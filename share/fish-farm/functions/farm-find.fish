function farm-find --description 'Find project'
	if contains -- $argv[1] (farm-ls)
		echo $argv[1]
		return 0
	end

	return 1
end
