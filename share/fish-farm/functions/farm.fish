function farm --description 'Fishy repository switcher'
	if not type -q ghq
		echo 'farm: ghq is required'
		return 1
	end

	if test (count $argv) -eq 0
		set argv ls
	end

	switch $argv[1]
		case 'help' '-h' '--help'
			farm-help; return
	end

	set -l command $argv[1]
	set -e argv[1]
	set -l func_name "farm-$command"
	set -l return_status 0

	if functions -q $func_name
		eval $func_name $argv
		set return_status $status
	else
		if test (farm-find $command)
			farm-visit $command
		else
			farm-help
		end
	end

	return $return_status
end
