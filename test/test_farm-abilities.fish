function suite_farm-abilities
	function setup
		stub_var farm (stub_dir)
		stub_var project_path $farm/projects/a
		mkdir -p $project_path
	end

	function test_console_ability
		assert_empty (farm abilities projects/a)

		mkdir -p $project_path/bin
		touch $project_path/bin/console
		farm abilities project
		assert_includes 'console' (farm abilities projects/a)
		rm $project_path/bin/console
		assert_empty (farm abilities projects/a)

		mkdir -p $project_path/script
		touch $project_path/script/console
		assert_includes 'console' (farm abilities projects/a)
		rm $project_path/script/console
		assert_empty (farm abilities projects/a)
	end

	function test_bundler_ability
		assert_empty (farm abilities projects/a)

		touch $project_path/Gemfile
		assert_includes 'bundler' (farm abilities projects/a)
		rm $project_path/Gemfile

		assert_empty (farm abilities projects/a)
	end

	function test_rack_ability
		assert_empty (farm abilities projects/a)

		touch $project_path/config.ru
		assert_includes 'rack' (farm abilities projects/a)
		rm $project_path/config.ru

		assert_empty (farm abilities projects/a)
	end

	function test_rails_ability
		assert_empty (farm abilities projects/a)

		mkdir -p $project_path/bin
		touch $project_path/bin/rails
		assert_includes 'rails' (farm abilities projects/a)
		rm $project_path/bin/rails
		assert_empty (farm abilities projects/a)

		mkdir -p $project_path/script
		touch $project_path/script/rails
		assert_includes 'rails' (farm abilities projects/a)
		rm $project_path/script/rails
		assert_empty (farm abilities projects/a)
	end

	function test_no_abilities
		assert_empty (farm abilities projects/a)
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
