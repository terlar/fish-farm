function suite_farm-version
	function test_exit_status
		assert (farm-version)
	end

	function test_output
		refute_empty (farm-version)
	end
end

source (dirname (status -f))/helper.fish
