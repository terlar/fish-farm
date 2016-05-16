function __farm_no_command
    set -l cmd (commandline -poc)
    set -e cmd[1]
    if test (count $cmd) -eq 0
        return 0
    end
    return 1
end

function __farm_using_command
    set cmd (commandline -poc)
    if test (count $cmd) -gt 1
        if test $argv[1] = $cmd[2]
            return 0
        end
    end
    return 1
end

function __farm_complete_commands
    farm help | awk '/Commands:/{f=1;next}/^\s*$/{f=0}f' | string replace -r '^\s+([^\s]+)\s+(.+)$' '$1'\t'$2'
end

complete -c farm -f -n '__farm_no_command' -a '(__farm_complete_commands)'
complete -c farm -f -n '__farm_no_command' -a '(farm ls)' -d 'Project'
complete -c farm -f -n '__farm_using_command cd' -a '(farm ls)' -d 'Project'
complete -c farm -f -n '__farm_using_command visit' -a '(farm ls)' -d 'Project'
