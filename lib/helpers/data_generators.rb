require "#{Rails.root}/lib/helpers/data_generators/base.rb"
require "#{Rails.root}/lib/helpers/factory_manager.rb"
require "#{Rails.root}/lib/helpers/sometimes.rb"
Dir[Rails.root.join('lib/helpers/data_generators/**/*.rb')].each { |f| require f }

include Sometimes
