function farm-visit --description 'Visit project'
	set -l project $argv[1]

	if type -q mux
		mux $project -c $farm/$project
	else
		farm cd $project
	end
end
