function suite_farm-current
	function setup
		stub_var GHQ_ROOT (stub_dir)
		mkdir -p $GHQ_ROOT/user/repo_a/.git
	end

	function test_in_repo_root
		cd $GHQ_ROOT/user/repo_a

		set output (farm-current)
		assert_equal 0 $status
		assert_equal user/repo_a $output
	end

	function test_in_repo_sub_directory
		mkdir -p $GHQ_ROOT/user/repo_a/lvl1/lvl2
		cd $GHQ_ROOT/user/repo_a/lvl1/lvl2

		set output (farm-current)
		assert_equal 0 $status
		assert_equal user/repo_a $output
	end

	function test_not_in_repo
		set output (farm-current)
		assert_equal 1 $status
		assert_empty $output
	end
end

source (dirname (status -f))/helper.fish
