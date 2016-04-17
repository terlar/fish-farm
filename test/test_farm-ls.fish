function suite_farm-ls
	function setup
		stub_var GHQ_ROOT (stub_dir)
		mkdir -p $GHQ_ROOT/user/repo_a/.git
		mkdir -p $GHQ_ROOT/user/repo_b/.git
		mkdir -p $GHQ_ROOT/not_repo
	end

	function test_lists_repos
		assert_includes user/repo_a (farm-ls)
		assert_includes user/repo_b (farm-ls)
		refute_includes not_repo (farm-ls)
	end
end

source (dirname (status -f))/helper.fish
