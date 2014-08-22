function farm-new --description 'Create a new project'
	if test (count $argv) -eq 0
		echo 'farm-new: No <project> given'
		return 1
	end

	set -l project $argv[1]

	if test (farm-find $project)
		echo "farm-new: Project '$project' already exist"
		return 1
	end

	eval " mkdir $farm/$project"
	farm-visit $project
end
