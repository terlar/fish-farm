. (dirname (status -f))/helper.fish

function setup_tank
  mkdir $farms/a_farm
end

function clean_tank
  rm -d $farms/a_farm
end

function it_contains_farms
  contains a_farm (farm-ls)
end

. $fish_tank
