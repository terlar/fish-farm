function farm-current --description 'Display current project name'
	set -l relative_path (echo $PWD | sed "s|$farm/||")

	test $PWD = $relative_path; and return 1

	set -l projects (farm-ls)

	while not contains -- $relative_path $projects
		set relative_path (dirname $relative_path)
	end

	echo $relative_path
end
