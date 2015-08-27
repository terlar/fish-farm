function farm-ls --description 'List available projects'
	for project in $farm/*/*
		echo $project | sed "s|$farm/||"
	end
end
