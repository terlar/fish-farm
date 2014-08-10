function farm-abilities --description 'Display project abilities (default to current)'
  set -l project_root

  if test -z $argv[1]
    set project_root $farm/(farm-current)
  else
    set project_root $farm/$argv[1]
  end

  for file in bin/console script/console
    if test -f $project_root/$file
      echo console
      break
    end
  end

  if test -f $project_root/Gemfile
    echo bundler
  end

  if test -f $project_root/config.ru
    echo rack
  end

  for file in bin/rails script/rails
    if test -f $project_root/$file
      echo rails
      break
    end
  end

  return 1
end
