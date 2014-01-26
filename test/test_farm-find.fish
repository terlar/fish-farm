function suite_farm-find
  function setup
    mkdir -p $farm/a_project
    mkdir -p $farm/a_projecta
  end

  function teardown
    rm -r $farm
  end

  function test_known_project
    set -l output (farm-find a_project)
    assert_equal 0 $status
    assert_equal a_project $output
  end

  function test_unknown_project
    set -l output (farm-find b_project)
    assert_equal 1 $status
    assert_empty $output
  end
end

if not set -q tank_running
  source (dirname (status -f))/helper.fish
  tank_run
end
