. (dirname (status -f))/helper.fish

function setup_tank
  stub farm-visit
  function farm-ls; echo a_project; end
end

function clean_tank
  functions -e farm-visit farm-ls
  rm -d $farm/new_project ^/dev/null
end

function it_returns_status_1_without_args
  farm-new
  test $status -eq 1
end

function it_returns_status_1_when_existing_farm
  farm-new a_project
  test $status -eq 1
end

function it_creates_new_project_directory_when_new
  farm-new new_project
  test -d $farm/new_project
end

function it_visits_new_project_when_new
  contains 'farm-visit new_project' (farm-new new_project)
end

. $fish_tank
