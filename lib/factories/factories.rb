Dir[Rails.root.join('lib/factories/**/*.rb')].each { |f| require f }
require "#{Rails.root}/lib/sometimes.rb"
