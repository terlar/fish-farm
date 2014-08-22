function suite_farm-abilities
	function setup
		mkdir -p $farm/project
	end

	function teardown
		rm -r $farm
	end

	function test_console_ability
		assert_empty (farm abilities project)

		mkdir -p $farm/project/bin
		touch $farm/project/bin/console
		assert_includes 'console' (farm abilities project)
		rm $farm/project/bin/console
		assert_empty (farm abilities project)

		mkdir -p $farm/project/script
		touch $farm/project/script/console
		assert_includes 'console' (farm abilities project)
		rm $farm/project/script/console
		assert_empty (farm abilities project)
	end

	function test_bundler_ability
		assert_empty (farm abilities project)

		touch $farm/project/Gemfile
		assert_includes 'bundler' (farm abilities project)
		rm $farm/project/Gemfile

		assert_empty (farm abilities project)
	end

	function test_rack_ability
		assert_empty (farm abilities project)

		touch $farm/project/config.ru
		assert_includes 'rack' (farm abilities project)
		rm $farm/project/config.ru

		assert_empty (farm abilities project)
	end

	function test_rails_ability
		assert_empty (farm abilities project)

		mkdir -p $farm/project/bin
		touch $farm/project/bin/rails
		assert_includes 'rails' (farm abilities project)
		rm $farm/project/bin/rails
		assert_empty (farm abilities project)

		mkdir -p $farm/project/script
		touch $farm/project/script/rails
		assert_includes 'rails' (farm abilities project)
		rm $farm/project/script/rails
		assert_empty (farm abilities project)
	end

	function test_no_abilities
		assert_empty (farm abilities project)
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
