function suite_farm
	function setup
		function farm-truthy; true      ; end
		function farm-falsy ; false     ; end
		function farm-args  ; echo $argv; end

		stub_var GHQ_ROOT (stub_dir)
		mkdir -p $GHQ_ROOT/user/repo_a/.git
	end

	function test_empty_arguments
		assert (farm)
		assert_equal (farm-ls) (farm)
	end

	function test_command_delegation
		assert (farm truthy)
		refute (farm falsy)
		assert_equal (farm-version) (farm version)
		assert_equal (farm-args command --option) (farm args command --option)
	end

	function test_help_arguments
		set -l help_output (farm-help)

		for arg in help --help -h
			set -l output (farm $arg)
			assert_equal 0 $status
			assert_includes $help_output $output
		end
	end

	function test_invalid_arguments
		set -l help_output (farm-help)

		for arg in unknown --
			set -l output (farm $arg)
			assert_equal 0 $status
			assert_includes $help_output $output
		end
	end

	function test_visits_project_with_known_project
		function mux_stub
			echo mux $argv
		end
		stub mux mux_stub

		assert "mux repo_a ghq look user/repo_a" (farm user/repo_a)
	end
end

source (dirname (status -f))/helper.fish
