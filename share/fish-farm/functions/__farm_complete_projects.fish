function __farm_complete_projects --description 'Complete farm projects'
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
