namespace :codeclimate do
  task :start do
    require 'simplecov'
    require 'codeclimate-test-reporter'
    SimpleCov.add_filter 'vendor'
    SimpleCov.formatters = []
    SimpleCov.merge_timeout 3600
    SimpleCov.start CodeClimate::TestReporter.configuration.profile
  end

  task :format do
    require 'simplecov'
    require 'codeclimate-test-reporter'
    CodeClimate::TestReporter::Formatter.new.format(SimpleCov.result)
  end
end
