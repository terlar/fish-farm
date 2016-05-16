function farm-help --description 'Display help information'
    echo 'usage: farm [<command>|<repo>] [<args>]'
    echo
    echo 'Commands:'
    echo '  ls                List available repositories'
    echo '  find              Find available repository'
    echo '  new               Create a new repository'
    echo '  cd <repo>         Go to given repository directory'
    echo '  visit <repo>      Switch to or open the given repository'
    echo '  current           Display current repository name'
    echo '  version           Display the current version of farm'
    echo '  help              Display help information'
end
