function farm-console --description 'Launch console for current project'
  set -l abilities (farm-abilities)
  test (count $abilities) -gt 0; or return 1

  switch "$abilities"
    case '*console*'
      ./bin/console
    case '*rails*'
      rails console
    case '*bundler*'
      bundle console
    case '*'
      return 1
  end
end
