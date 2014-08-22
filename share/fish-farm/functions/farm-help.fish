function farm-help --description 'Display help information'
	echo 'usage: farm [<command>|<project>] [<args>]'
	echo
	echo 'Commands:'
	echo '  ls                List available projects'
	echo '  find              Find available project'
	echo '  new               Create a new project'
	echo '  cd <project>      Go to given project directory'
	echo '  visit <project>   Switch or open the given project'
	echo '  current           Display current project name'
	echo '  abilities         Display project abilities (default current)'
	echo '  server            Launch server for current project'
	echo '  console           Launch console for current project'
	echo '  version           Display the current version of farm'
	echo '  help              Display help information'
end
