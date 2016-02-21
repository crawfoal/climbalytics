# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

# Note: The cmd option is now required due to the increasing number of ways
#       rspec may be run, below are examples of the most common uses.
#  * bundler: 'bundle exec rspec'
#  * bundler binstubs: 'bin/rspec'
#  * spring: 'bin/rspec' (This will use spring if running and you have
#                          installed the spring binstubs per the docs)
#  * zeus: 'zeus rspec' (requires the server to be started separately)
#  * 'just' rspec: 'rspec'

guard :rspec, cmd: "bundle exec rspec" do
  require 'active_support/inflector'
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Factories
  watch(%r{^#{rspec.spec_dir}/factories/(.+)\.rb}) do |m|
    [
      rspec.spec.("models/#{m[1].singularize}"),
      rspec.spec.("data_generators/#{m[1]}")
    ]
  end
  watch(%r{^lib/data_generators/factories/(.+)\.rb$}) { |m| rspec.spec.("data_generators/#{m[1]}") }

  # Data Generators
  watch(%r(^lib/data_generators.rb)) { "#{rspec.spec_dir}/data_generators" }
  watch(%r(^lib/data_generators/base.rb)) { "#{rspec.spec_dir}/data_generators" }
  watch(%r(^lib/factory_manager.rb)) { "#{rspec.spec_dir}/data_generators" }
  watch(%r(^lib/sometimes.rb)) { "#{rspec.spec_dir}/data_generators" }
  watch(%r(^lib/data_generators/(.+)\.rb$)) do |m|
    rspec.spec.("data_generators/#{m[1]}")
  end

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb haml slim))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.("routing/#{m[1]}_routing"),
      "#{rspec.spec_dir}/controllers/#{m[1]}",
      rspec.spec.("acceptance/#{m[1]}")
    ]
  end

  # Rake Files
  watch(%r{^lib/tasks/(.+).rake}) { |m| rspec.spec.("tasks/#{m[1]}_rake") }

  # Concerns
  watch(%r{^app/models/concerns/(.+)\.rb$}) { |m| rspec.spec.("concerns/#{m[1]}") }

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs)     { |m| rspec.spec.("features/#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.("features/#{m[1]}") }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || "spec/acceptance"
  end
end
