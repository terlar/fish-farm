function suite_farm-find
	function setup
		stub_var GHQ_ROOT (stub_dir)
		mkdir -p $GHQ_ROOT/user/repo_a/.git
		mkdir -p $GHQ_ROOT/user/repo_ab/.git
	end

	function test_known_repo
		set output (farm-find user/repo_a)
		assert_equal 0 $status
		assert_equal user/repo_a $output

		set output (farm-find user/repo_ab)
		assert_equal 0 $status
		assert_equal user/repo_ab $output
	end

	function test_unknown_project
		set output (farm-find user/repo_b)
		assert_equal 1 $status
		assert_empty $output
	end
end

source (dirname (status -f))/helper.fish
