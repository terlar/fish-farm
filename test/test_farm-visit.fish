function suite_farm-visit
	function setup
		stub_var farm (stub_dir)
		mkdir -p $farm/a_project
		mkdir -p $farm/b_project
	end

	function test_changes_directory_without_mux
		stub_var PATH /usr/bin

		farm-visit a_project
		assert_equal $farm/a_project $PWD
	end

	function test_uses_mux_when_available
		function mux_stub
			echo mux $argv
		end
		stub mux mux_stub

		assert_equal "mux a_project -c $farm/a_project" (farm-visit a_project)
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
