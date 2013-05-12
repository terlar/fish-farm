# fish completion for farm
function __fish_farm_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'f' ]
    return 0
  end
  return 1
end

function __fish_farm_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

function __fish_farm
  farm help | grep '  ' | sed 's|^ *||;s|<.*> ||' | unexpand -t1
end

function __fish_farm_project
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

complete -f -c f -n '__fish_farm_needs_command' -a '(__fish_farm)'
complete -f -c f -n '__fish_farm_needs_command' -a '(__fish_farm_project)' -d 'Project'
complete -f -c f -n '__fish_farm_using_command cd' -a '(__fish_farm_project)' -d 'Project'
complete -f -c f -n '__fish_farm_using_command visit' -a '(__fish_farm_project)' -d 'Project'
