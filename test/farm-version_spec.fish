. (dirname (status -f))/helper.fish

function it_outputs_version
  not test -z (farm-version)
end

. $fish_tank
