begin
  require 'rspec/core/rake_task'
rescue LoadError
  abort('RSpec is not available in this environment... aborting task')
end

desc "(excluding feature, data generator specs)"
task :spec

Rake::Task['spec:features'].clear_actions

namespace :spec do
  desc "(patterns from .rspec overriden)"
  RSpec::Core::RakeTask.new('features') do |task|
    task.exclude_pattern = ''
    task.pattern = 'spec/features/**/*_spec.rb'
  end
end
