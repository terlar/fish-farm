function suite_farm-visit
	function setup
		stub_var GHQ_ROOT (stub_dir)
		mkdir -p $GHQ_ROOT/user/repo_a/.git
	end

	function test_uses_mux_when_available
		function mux_stub
			echo mux $argv
		end
		stub mux mux_stub

		assert_equal 'mux repo_a ghq look user/repo_a' (farm-visit user/repo_a)
	end
end

source (dirname (status -f))/helper.fish
