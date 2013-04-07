function farm-visit --description 'Visit project'
  set -l project $argv[1]
  set -l commands " cd $farm/$project; clear"

  if not which tmux >/dev/null
    eval $commands
    return
  end

  set -l sessions (tmux list-sessions | cut -d ':' -f 1 ^/dev/null)
  set -l environment (tmux show-environment | grep -v '^-' | sed 's|=| |')

  for i in $environment
    set commands " set -xg $i;$commands"
  end

  # Wrapper command for OSX clipboard
  set -l wrapper
  if which reattach-to-user-namespace >/dev/null
    set wrapper "reattach-to-user-namespace -l $SHELL"
  end

  if test -z "$TMUX"
    if not contains $project $sessions
      tmux new -d -s $project $wrapper
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
