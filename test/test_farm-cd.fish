function suite_farm-cd
	function setup
		stub_var farm (stub_dir)
		mkdir -p $farm/projects/a
	end

	function test_changes_directory
		farm-cd projects/a
		assert_equal $farm/projects/a $PWD
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
