require "#{Rails.root}/lib/data_generators/base.rb"
require "#{Rails.root}/lib/factory_manager.rb"
require "#{Rails.root}/lib/sometimes.rb"
load "#{Rails.root}/lib/geocoding_stubs.rb"
Dir[Rails.root.join("lib/data_generators/factories/**/*.rb")].each { |f| require f }
Dir[Rails.root.join('lib/data_generators/**/*.rb')].each { |f| require f }

include Sometimes
