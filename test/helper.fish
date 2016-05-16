if not set -q tank_helper
    set -l fish_tank /usr/local/share/fish-tank/tank.fish
    if not test -e $fish_tank
        echo 'error: fish-tank is required to run these tests (https://github.com/terlar/fish-tank)'
        exit 1
    end

    set -l project_path (realpath (dirname (status -f))/..)
    set fish_function_path $project_path/functions $fish_function_path
    set -gx GHQ_ROOT /tmp/farm

    source $fish_tank
    set -g tank_helper 1
    set -q tank_runner
    or tank_run
end
