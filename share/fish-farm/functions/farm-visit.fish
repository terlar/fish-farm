function farm-visit --description 'Visit project'
	set -l project $argv[1]
	set -l commands "farm cd $project"

	if not which tmux >/dev/null
		eval $commands
		return
	end

	if test -z "$TMUX"
		tmux new -A -s $project "$commands; $SHELL"
	else
		set -l sessions (tmux list-sessions | cut -d ':' -f 1 ^/dev/null)

		if not contains -- $project $sessions
			tmux if true "new -d -s $project '$commands; $SHELL'"
		end

		tmux switch -t $project
	end
end
