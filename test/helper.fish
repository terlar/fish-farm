set fish_tank /usr/local/share/fish-tank/tank.fish
if not test -e $fish_tank
  set -e fish_tank
  echo 'error: fish-tank is required to run these tests (https://github.com/terlar/fish-tank)'
  exit 1
end

set -l spec_path (dirname (status -f))

set -g farm $spec_path/farm

. $spec_path/../share/fish-farm/farm.fish

function setup_tank; end
function clean_tank; end
