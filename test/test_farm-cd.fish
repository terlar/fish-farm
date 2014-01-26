function suite_farm-cd
  function setup
    mkdir -p $farm/a_project
  end

  function teardown
    rm -r $farm
  end

  function test_changes_directory
    farm-cd a_project
    assert_equal $farm/a_project $PWD
  end
end

if not set -q tank_running
  source (dirname (status -f))/helper.fish
  tank_run
end
