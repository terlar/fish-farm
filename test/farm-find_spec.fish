. (dirname (status -f))/helper.fish

function setup_tank
  function farm-ls; echo 'a_farm'; end
end

function clean_tank
  functions -e farm-ls
end

function it_matches_exactly
  test (farm-find a_farm) = a_farm
end

. $fish_tank
