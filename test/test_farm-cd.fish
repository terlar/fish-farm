function suite_farm-cd
	function setup
		stub_var farm (stub_dir)
		mkdir -p $farm/a_project
	end

	function test_changes_directory
		farm-cd a_project
		assert_equal $farm/a_project $PWD
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
