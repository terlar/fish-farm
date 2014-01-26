function suite_farm-new
  function setup
    mkdir -p $farm/a_project
  end

  function teardown
    rm -r $farm
  end

  function test_without_args
    set -l output (farm-new)
    assert_equal 1 $status
    assert_equal 'farm-new: No <project> given' $output
  end

  function test_with_existing_project
    set -l output (farm-new a_project)
    assert_equal 1 $status
    assert_equal "farm-new: Project 'a_project' already exist" $output
  end

  function test_when_new
    function farm-visit_stub
      echo "farm-visit $argv"
    end
    stub farm-visit farm-visit_stub

    set -l output (farm-new new_project)
    assert_equal 0 $status
    assert (test -d $farm/new_project)
    assert_equal 'farm-visit new_project' $output
  end
end

if not set -q tank_running
  source (dirname (status -f))/helper.fish
  tank_run
end
