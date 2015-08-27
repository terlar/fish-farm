function suite_farm-active
	function setup
		stub_var farm (stub_dir)
		mkdir -p $farm/projects/a
	end

	function test_lists_active_projects
		function tmux_stub
			echo 'projects/a: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
			echo 'not_a_project: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
		end
		stub tmux tmux_stub

		assert_includes 'projects/a' (farm-active)
		refute_includes 'not_a_project' (farm-active)
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
