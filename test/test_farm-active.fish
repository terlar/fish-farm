function suite_farm-active
	function setup
		mkdir -p $farm/a_project
	end

	function teardown
		rm -r $farm
	end

	function test_lists_active_projects
		function tmux_stub
			echo 'a_project: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
			echo 'not_a_project: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
		end
		stub tmux tmux_stub

		assert_includes 'a_project' (farm-active)
		refute_includes 'not_a_project' (farm-active)
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
