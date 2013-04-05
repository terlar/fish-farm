# fish completion for farm
function __fish_farm
  set -l token (commandline -pt)
  set -l list (ls $farm | grep $token)

  if test (count $list) -eq 1
    commandline -t $list
  else
    for i in $list
      echo $i
    end
  end
end

complete -f -c f -a '(__fish_farm)'
