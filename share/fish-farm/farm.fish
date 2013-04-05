# Set defaults
set -q farm ; or set -U farm $HOME/Code

# Path
set -l farm_path (dirname (status -f))

if not contains $farm_path/functions $fish_function_path
  set fish_function_path $farm_path/functions $fish_function_path
end

if not contains $farm_path/completions $fish_complete_path
  set fish_complete_path $farm_path/completions $fish_complete_path
end

# Set CDPATH
set CDPATH $CDPATH $farm

# Alias
function f ; farm $argv ; end
