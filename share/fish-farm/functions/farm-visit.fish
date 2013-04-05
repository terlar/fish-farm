function farm-visit --description 'Visit farm'
  set -l farm $argv[1]
  set -l command " cd $farms/$farm; clear"

  if not which tmux >/dev/null
    eval $command
    return
  end

  set -l sessions (tmux list-sessions | cut -d ':' -f 1 ^/dev/null)

  # Wrapper command for OSX clipboard
  set -l wrapper
  if which reattach-to-user-namespace >/dev/null
    set wrapper "reattach-to-user-namespace -l $SHELL"
  end

  if test -z "$TMUX"
    if not contains $farm $sessions
      tmux new -d -s $farm $wrapper
      tmux send-keys -t $farm $command Enter
    end

    tmux attach -t $farm
  else
    if not contains $farm $sessions
      tmux if true "new -d -s $farm"
      tmux send-keys -t $farm $command Enter
    end

    tmux switch -t $farm
  end
end
