require 'coveralls/rake/task'

task :clean_up_coverage_files do
  FileUtils.rm_rf("#{Rails.root}/coverage")
end

Coveralls::RakeTask.new
task :test_with_coveralls => [:clean_up_coverage_files, :spec, 'spec:tasks', 'spec:features', 'coveralls:push']
