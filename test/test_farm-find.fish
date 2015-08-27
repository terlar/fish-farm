function suite_farm-find
	function setup
		stub_var farm (stub_dir)
		mkdir -p $farm/projects/ab
		mkdir -p $farm/projects/aba
	end

	function test_known_project
		set -l output (farm-find projects/ab)
		assert_equal 0 $status
		assert_equal projects/ab $output
	end

	function test_unknown_project
		set -l output (farm-find projects/b)
		assert_equal 1 $status
		assert_empty $output
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
