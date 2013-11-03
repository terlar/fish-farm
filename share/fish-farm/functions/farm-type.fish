function farm-type --description 'Display current project type'
  set -l project
  if test -z $argv[1]
    set project (farm-current)
  else
    set project $argv[1]
  end

  set -l projec_root $farm/$project

  for file in bin/rails script/rails
    if test -f $projec_root/$file
      echo rails; return
    end
  end

  for file in config.ru
    if test -f $projec_root/$file
      echo rack; return
    end
  end

  return 1
end
