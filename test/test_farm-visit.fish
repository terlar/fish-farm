function suite_farm-visit
	function setup
		function tmux_stub
			if count $argv >/dev/null
				switch $argv[1]
					case 'list-sessions'
						echo 'a_project: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
				end
			end

			echo "tmux $argv"
		end
		stub tmux tmux_stub
		stub_var TMUX server

		mkdir -p $farm/a_project
		mkdir -p $farm/b_project
	end

	function teardown
		rm -r $farm
	end

	function test_changes_directory_without_tmux
		function which_stub; return 1; end
		stub which which_stub

		farm-visit a_project
		assert_equal $farm/a_project $PWD
	end

	function test_outside_tmux_without_session
		set TMUX ''
		assert_includes "tmux new -A -s a_project farm cd a_project; $SHELL" (farm-visit a_project)
	end

	function test_inside_tmux_and_not_in_session
		set -l output (farm-visit b_project)

		assert_includes "tmux if true new -d -s b_project 'farm cd b_project; $SHELL'" $output
		assert_includes 'tmux switch -t b_project' $output
	end

	function test_inside_tmux_and_in_session
		set -l output (farm-visit a_project)

		refute_includes "tmux if true new -d -s a_project 'farm cd a_project; $SHELL'" $output
		assert_includes 'tmux switch -t a_project' $output
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
