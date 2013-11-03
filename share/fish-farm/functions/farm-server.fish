function farm-server --description 'Launch server for current project'
  set -l type (farm-type)
  test -z "$type"; and return 1

  switch $type
    case rails; rails server
    case rack ; rackup
  end
end
