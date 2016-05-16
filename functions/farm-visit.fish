function farm-visit --description 'Visit repository'
    set -l repo (farm-find $argv | head -n1)

    if test -z "$repo"
        echo 'farm: unknown repo'
        return 1
    end

    if type -q mux
        set -l name (string split -r -m1 '/' $repo | tail -n1)

        mux $name ghq look $repo
    else
        ghq look $repo
    end
end
