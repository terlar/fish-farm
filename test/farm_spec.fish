. (dirname (status -f))/helper.fish

function setup_tank
  function farm-dummy   ; return 1            ; end
  function farm-help    ; echo __help__       ; end
  function farm-ls      ; echo __ls__         ; end
  function farm-version ; echo __version__    ; end
  function farm-visit   ; echo __visit__ $argv; end
end

function it_returns_status_from_command
  farm dummy
  test $status -eq 1
end

function it_handles_dashes
  test (farm --) = __help__
end

function it_outputs_farms_without_args
  test (farm) = __ls__
end

function it_outputs_help_with_unknown_command
  test (farm unknown) = __help__
end

function it_outputs_command_with_known_command
  test (farm version) = __version__
end

function it_visits_farm_with_known_farm
  function farm-find ; echo a_farm; end
  test (farm a_farm) = "__visit__ a_farm"
end

. $fish_tank
