function suite_farm-ls
	function setup
		mkdir -p $farm/a_project
		mkdir -p $farm/b_project
	end

	function teardown
		rm -r $farm
	end

	function test_lists_projects
		assert_includes a_project (farm-ls)
		assert_includes b_project (farm-ls)
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
