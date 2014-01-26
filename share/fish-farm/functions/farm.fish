function farm --description 'Fishy project switcher'
  if test (count $argv) -eq 0
    set argv ls
  end

  switch $argv[1]
    case 'help' '-h' '--help'
      farm-help; return
  end

  set -l command $argv[1]
  set -e argv[1]
  set -l func_name "farm-$command"

  if functions -q $func_name
    eval $func_name $argv
  else
    if test (farm-find $command)
      farm-visit $command
    else
      farm-help
    end
  end

  return $status
end
