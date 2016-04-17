function suite_farm-new
	function setup
		stub_var GHQ_ROOT (stub_dir)
	end

	function test_without_args
		set output (farm-new)
		assert_equal 1 $status
		assert_equal 'farm: no <repo> given' $output
	end

	function test_when_getting_a_new_repo
		function ghq_stub
			if test $argv[1] = 'get'
				mkdir -p $GHQ_ROOT/$argv[2]/.git
			else
				command ghq $argv
			end
		end
		stub ghq ghq_stub

		function mux_stub
			echo mux $argv
		end
		stub mux mux_stub

		set output (farm-new user/repo_a)
		assert_equal 0 $status
		assert (test -d $GHQ_ROOT/user/repo_a)
		assert_equal "mux repo_a ghq look user/repo_a" $output
	end
end

source (dirname (status -f))/helper.fish
