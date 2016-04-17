function farm-current --description 'Display current repository name'
	set -l root (ghq root)

	for repo in (farm-ls)
		if string match -q "$root/$repo*" $PWD
			echo $repo
			return 0
		end
	end

	return 1
end
