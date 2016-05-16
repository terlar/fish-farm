function farm-active --description 'Active repositories'
    farm-ls | read -lz repos

    for session in (tmux list-sessions | string replace -r ':.*' '')
        if echo $repos | grep -q -- "$session\$"
            echo $session
        end
    end
end
