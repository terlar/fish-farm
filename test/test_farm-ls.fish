function suite_farm-ls
	function setup
		stub_var farm (stub_dir)
		mkdir -p $farm/projects/a
		mkdir -p $farm/projects/b
	end

	function test_lists_projects
		assert_includes projects/a (farm-ls)
		assert_includes projects/b (farm-ls)
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
