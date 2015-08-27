function suite_farm-visit
	function setup
		stub_var farm (stub_dir)
		mkdir -p $farm/projects/a
		mkdir -p $farm/projects/b
	end

	function test_changes_directory_without_mux
		stub_var PATH /usr/bin

		farm-visit projects/a
		assert_equal $farm/projects/a $PWD
	end

	function test_uses_mux_when_available
		function mux_stub
			echo mux $argv
		end
		stub mux mux_stub

		assert_equal "mux projects/a -c $farm/projects/a" (farm-visit projects/a)
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
