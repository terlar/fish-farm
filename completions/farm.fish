function __farm_no_command
    set -l cmd (commandline -poc)
    if set -q cmd[2]
        return 1
    end
    return 0
end

function __farm_using_command
    set -l cmd (commandline -poc)
    set -l found

    test (count $cmd) -gt (count $argv)
    or return 1

    set -e cmd[1]

    for i in $argv
        contains -- $i $cmd
        and set found $found $i
    end

    test "$argv" = "$found"
end

function __farm_projects
    set -l projects (farm ls)

    __fish_seen_subcommand_from $projects
    and return 1

    printf '%s\n' $projects
end

function __farm_subcommands
    farm help | awk '/Commands:/{f=1;next}/^\s*$/{f=0}f' | string replace -r '^\s+(\S+)\s(<\S+>|[A-Z]+)?\s*(.+)$' '$1'\t'$3'
end

complete -c farm -n '__farm_no_command' -f -a '(__farm_subcommands)'
complete -c farm -n '__farm_no_command' -f -a '(__farm_projects)' -d 'Project'
complete -c farm -n '__farm_using_command cd' -x -a '(__farm_projects)' -d 'Project'
complete -c farm -n '__farm_using_command visit' -x -a '(__farm_projects)' -d 'Project'
