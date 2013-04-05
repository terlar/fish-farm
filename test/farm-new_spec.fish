. (dirname (status -f))/helper.fish

function setup_tank
  stub farm-visit
  function farm-ls; echo 'a_farm'; end
end

function clean_tank
  functions -e farm-visit farm-ls
  rm -d $farms/new_farm ^/dev/null
end

function it_returns_status_1_without_args
  farm-new
  test $status -eq 1
end

function it_returns_status_1_when_existing_farm
  farm-new a_farm
  test $status -eq 1
end

function it_creates_new_farm_directory_when_new
  farm-new new_farm
  test -d $farms/new_farm
end

function it_visits_new_farm_when_new
  contains 'farm-visit new_farm' (farm-new new_farm)
end

. $fish_tank
