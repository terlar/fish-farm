. (dirname (status -f))/helper.fish

function setup_tank
  set -gx TMUX

  stub tmux which
  function which-reattach-to-user-namespace; return 1; end

  mkdir $farms/a_farm
end

function clean_tank
  functions -e tmux which tmux-list-sessions which-tmux which-reattach-to-user-namespace
  rm -d $farms/a_farm
end

function it_switches_directory_without_tmux
  function which-tmux; return 1; end

  farm-visit a_farm
  test $PWD = $farms/a_farm
end

# When not in session
function it_creates_a_new_tmux_session_when_not_in_sessions
  contains 'tmux new -d -s a_farm' (farm-visit a_farm)
end

function it_switches_directory_in_new_session_when_not_in_sessions
  contains "tmux send-keys -t a_farm  cd $farms/a_farm; clear Enter" (farm-visit a_farm)
end

function it_attaches_new_session_when_not_in_sessions
  contains 'tmux attach -t a_farm' (farm-visit a_farm)
end

# When in session
function it_attaches_session_when_in_sessions
  function tmux-list-sessions
    echo 'a_farm: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
  end

  not contains 'tmux new -d -s a_farm' (farm-visit a_farm)
  and not contains "tmux send-keys -t a_farm  cd $farms/a_farm; clear Enter" (farm-visit a_farm)
  and contains 'tmux attach -t a_farm' (farm-visit a_farm)
end

# When in tmux and not in session
function it_creates_a_new_tmux_session_when_in_tmux_and_not_in_sessions
  set -gx TMUX 'server'
  contains 'tmux if true new -d -s a_farm' (farm-visit a_farm)
end

function it_switches_directory_in_new_session_when_in_tmux_and_not_in_sessions
  set -gx TMUX 'server'
  contains "tmux send-keys -t a_farm  cd $farms/a_farm; clear Enter" (farm-visit a_farm)
end

function it_switches_to_new_session_when_in_tmux_and_not_in_sessions
  set -gx TMUX 'server'
  contains 'tmux switch -t a_farm' (farm-visit a_farm)
end

# When in tmux and in session
function it_switches_to_session_when_in_tmux_and_in_sessions
  set -gx TMUX 'server'
  function tmux-list-sessions
    echo 'a_farm: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
  end

  not contains 'tmux if true new -d -s a_farm' (farm-visit a_farm)
  and not contains "tmux send-keys -t a_farm  cd $farms/a_farm; clear Enter" (farm-visit a_farm)
  and contains 'tmux switch -t a_farm' (farm-visit a_farm)
end

. $fish_tank
