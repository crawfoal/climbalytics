require "#{Rails.root}/lib/data_generators/base.rb"
require "#{Rails.root}/lib/factory_manager.rb"
require "#{Rails.root}/lib/sometimes.rb"
Dir[Rails.root.join('lib/data_generators/**/*.rb')].each { |f| require f }

include Sometimes
