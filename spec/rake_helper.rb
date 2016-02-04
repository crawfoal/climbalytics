Dir[Rails.root.join('lib/helpers/**/*.rb')].each { |f| require f }

# Override methods defined in Sometimes, so that we get consistent test behavior. Doing it this way (as opposed to the commented out stub approach below) allows us to have consistency even when those methods are called in before :all hooks.
class Object
  include Always
end

# RSpec.configure do |config|
#   config.before(:each) do
#     Sometimes.private_instance_methods.each do |method_name|
#       allow_any_instance_of(Object).to receive(method_name) { |&block| block.call }
#     end
#   end
# end
