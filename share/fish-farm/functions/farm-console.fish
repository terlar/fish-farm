function farm-console --description 'Launch console for current project'
  set -l type (farm-type)
  test -z "$type"; and return 1

  switch $type
    case rails; rails console
  end
end
