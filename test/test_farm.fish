function suite_farm
  function setup
    function farm-truthy; true ; end
    function farm-falsy ; false; end
    function farm-args  ; echo $argv; end

    mkdir -p $farm/a_project
  end

  function teardown
    rm -r $farm/a_project
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
    function farm-visit_stub
      echo 'farm-visit a_project'
    end
    stub farm-visit farm-visit_stub

    assert 'farm-visit a_project' (farm a_project)
  end
end

if not set -q tank_running
  source (dirname (status -f))/helper.fish
  tank_run
end
