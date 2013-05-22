. (dirname (status -f))/helper.fish

function setup_tank
  set -g TMUX

  stub tmux which

  mkdir $farm/a_project
end

function clean_tank
  functions -e tmux which tmux-list-sessions which-tmux
  rm -d $farm/a_project
end

function it_switches_directory_without_tmux
  function which-tmux; return 1; end

  farm-visit a_project
  test $PWD = $farm/a_project
end

# When not in session
function it_creates_a_new_tmux_session
  contains "tmux new -A -s a_project farm cd a_project; exec $SHELL" (farm-visit a_project)
end

# When inside tmux and not in session
function it_creates_a_new_tmux_session_when_inside_tmux_and_not_in_sessions
  set -g TMUX 'server'
  contains "tmux if true new -d -s a_project 'farm cd a_project; exec $SHELL'" (farm-visit a_project)
end

function it_switches_to_new_session_when_inside_tmux_and_not_in_sessions
  set -g TMUX 'server'
  contains 'tmux switch -t a_project' (farm-visit a_project)
end

# When inside tmux and in session
function it_switches_to_session_when_inside_tmux_and_in_sessions
  set -g TMUX 'server'
  function tmux-list-sessions
    echo 'a_project: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
  end

  not contains "tmux if true new -d -s a_project 'farm cd a_project; exec $SHELL'" (farm-visit a_project)
  and contains 'tmux switch -t a_project' (farm-visit a_project)
end

. $fish_tank
