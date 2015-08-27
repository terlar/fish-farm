function suite_farm-current
	function setup
		stub_var farm (stub_dir)
		mkdir -p $farm/projects/a
	end

	function test_displays_current_project_if_active_without_relative_path
		cd $farm/projects/a

		set -l output (farm-current)
		assert_equal 0 $status
		assert_equal projects/a $output
	end

	function test_displays_current_project_if_active_with_relative_path
		mkdir -p $farm/projects/a/lvl1/lvl2
		cd $farm/projects/a/lvl1/lvl2

		set -l output (farm-current)
		assert_equal 0 $status
		assert_equal projects/a $output
	end

	function test_displays_nothing_when_no_active
		set -l output (farm-current)
		assert_equal 1 $status
		assert_empty $output
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
