. (dirname (status -f))/helper.fish

function setup_tank
  stub tmux
  mkdir $farm/a_project
end

function clean_tank
  functions -e tmux tmux-list-sessions
  rm -d $farm/a_project
end

function it_lists_active_projects
  function tmux-list-sessions
    echo 'a_project: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
    echo 'not_a_project: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
  end

  contains 'a_project' (farm-active)
  and not contains 'not_a_project' (farm-active)
end

. $fish_tank
