function farm-active --description 'Active projects'
	for session in (tmux list-sessions | cut -d ':' -f 1 ^/dev/null)
		if test (farm find $session)
			echo $session
		end
	end
end
