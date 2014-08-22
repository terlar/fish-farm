function farm-current --description 'Display current project name'
	set -l relative_path (echo $PWD | sed "s|$farm/||")

	test $PWD = $relative_path; and return 1

	set -l dirname (dirname $relative_path)

	if test $dirname = .
		echo $relative_path
	else
		echo $dirname
	end
end
