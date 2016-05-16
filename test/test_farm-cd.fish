function suite_farm-cd
    function setup
        stub_var GHQ_ROOT (stub_dir)
        mkdir -p $GHQ_ROOT/user/repo_a/.git
    end

    function test_change_to_repo_directory
        function ghq_stub
            if test $argv[1] = 'look'
                builtin cd $GHQ_ROOT/$argv[2]
            else
                command ghq $argv
            end
        end
        stub ghq ghq_stub

        farm-cd user/repo_a
        assert_equal $GHQ_ROOT/user/repo_a $PWD
    end
end

source (dirname (status -f))/helper.fish
