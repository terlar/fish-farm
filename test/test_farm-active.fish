function suite_farm-active
    function setup
        stub_var GHQ_ROOT (stub_dir)
        mkdir -p $GHQ_ROOT/user/repo_a/.git
    end

    function test_listing_repos_active_in_tmux
        function tmux_stub
            echo 'repo_a: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
            echo 'not_a_repo: 1 windows (created Fri Apr  5 07:43:34 2013) [238x71]'
        end
        stub tmux tmux_stub

        assert_includes 'repo_a' (farm-active)
        refute_includes 'not_a_repo' (farm-active)
    end
end

source (dirname (status -f))/helper.fish
