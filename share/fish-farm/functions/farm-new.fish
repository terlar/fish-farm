function farm-new --description 'Create a new repository'
	if test (count $argv) -eq 0
		echo 'farm: no <repo> given'
		return 1
	end

	set -l repo $argv[1]
	set -e argv[1]

	ghq get $argv $repo

	farm-visit $repo
end
