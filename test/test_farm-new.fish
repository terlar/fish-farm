function suite_farm-new
	function setup
		stub_var farm (stub_dir)
		mkdir -p $farm/projects/a
	end

	function test_without_args
		set -l output (farm-new)
		assert_equal 1 $status
		assert_equal 'farm-new: No <project> given' $output
	end

	function test_with_existing_project
		set -l output (farm-new projects/a)
		assert_equal 1 $status
		assert_equal "farm-new: Project 'projects/a' already exist" $output
	end

	function test_when_new
		function mux_stub
			echo mux $argv
		end
		stub mux mux_stub

		set -l output (farm-new projects/new)
		assert_equal 0 $status
		assert (test -d $farm/projects/new)
		assert_equal "mux projects/new -c $farm/projects/new" $output
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
