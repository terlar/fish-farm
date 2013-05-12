. (dirname (status -f))/helper.fish

function setup_tank
  mkdir $farm/a_project
end

function clean_tank
  rm -d $farm/a_project
end

function it_switches_directory
  farm-cd a_project
  test $PWD = $farm/a_project
end

. $fish_tank
