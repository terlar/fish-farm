. (dirname (status -f))/helper.fish

function setup_tank
  function farm-ls; echo a_project; end
end

function clean_tank
  functions -e farm-ls
end

function it_matches_exactly
  test (farm-find a_project) = a_project
end

. $fish_tank
