require "#{Rails.root}/lib/helpers/sometimes.rb"

module Always

  ::Sometimes.private_instance_methods.each do |method_name|
    define_method method_name do |&block|
      block.call
    end
    private method_name
  end
  
end
