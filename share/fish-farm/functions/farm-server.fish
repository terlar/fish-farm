function farm-server --description 'Launch server for current project'
  set -l abilities (farm-abilities)
  test (count $abilities) -gt 0; or return 1

  switch "$abilities"
    case '*rails*'
      rails server
    case '*rack*'
      rackup
    case '*'
      return 1
  end
end
