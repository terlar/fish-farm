function farm-find --description 'Find farm'
  if contains $argv[1] (farm-ls)
    echo $argv[1]
  end

  return 1
end
