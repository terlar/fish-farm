. (dirname (status -f))/helper.fish

function setup_tank
  mkdir $farm/a_project
end

function clean_tank
  rm -d $farm/a_project
end

function it_contains_projects
  contains a_project (farm-ls)
end

. $fish_tank
