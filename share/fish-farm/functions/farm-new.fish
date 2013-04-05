function farm-new --description 'Create a new farm'
  if test (count $argv) -eq 0
    echo 'farm-new: No <farm> given'
    return 1
  end

  set -l farm $argv[1]

  if test (farm-find $farm)
    echo "farm-new: Farm '$farm' already exist"
    return 1
  end

  set -l command " mkdir $farms/$farm"
  eval $command

  farm-visit $farm
end
