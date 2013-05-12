function __farm_complete --description 'Complete farm' --argument-names farm
  complete -f -c $farm -n "__farm_needs_command $farm" -a '(__farm_complete_commands)'
  complete -f -c $farm -n "__farm_needs_command $farm" -a '(__farm_complete_projects)' -d 'Project'
  complete -f -c $farm -n '__farm_using_command cd' -a '(__farm_complete_projects)' -d 'Project'
  complete -f -c $farm -n '__farm_using_command visit' -a '(__farm_complete_projects)' -d 'Project'
end

function __farm_needs_command --argument-names farm
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = $farm ]
    return 0
  end
  return 1
end

function __farm_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end


function __farm_complete_commands
  farm help | grep '  ' | sed 's|^ *||;s|<.*> ||' | unexpand -t1
end

function __farm_complete_projects
  set -l token (commandline -pt)
  set -l list (farm ls | grep $token)

  if test (count $list) -eq 1
    commandline -t $list
  else
    for i in $list
      echo $i
    end
  end
end