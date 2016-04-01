namespace :codeclimate do
  task :format do
    require 'simplecov'
    require 'codeclimate-test-reporter'
    CodeClimate::TestReporter::Formatter.new.format(SimpleCov.result)
  end
end
