namespace :codeclimate do
  task :format do
    require 'simplecov'
    require 'codeclimate-test-reporter'
    require 'webmock'
    WebMock.disable_net_connect!(allow: 'codeclimate.com')
    CodeClimate::TestReporter::Formatter.new.format(SimpleCov.result)
  end
end
