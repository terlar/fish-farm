function farm-visit --description 'Visit project'
  set -l project $argv[1]
  set -l commands " cd $farm/$project; clear"

  if not which tmux >/dev/null
    eval $commands
    return
  end

  set -l sessions (tmux list-sessions | cut -d ':' -f 1 ^/dev/null)

  if test -z "$TMUX"
    if not contains $project $sessions
      tmux new -d -s $project
      tmux send-keys -t $project $commands Enter
    end

    tmux attach -t $project
  else
    if not contains $project $sessions
      tmux if true "new -d -s $project"
      tmux send-keys -t $project $commands Enter
    end

    tmux switch -t $project
  end
end
