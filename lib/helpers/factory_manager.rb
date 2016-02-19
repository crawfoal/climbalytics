# This class is tested using the AthleteGenerator
class FactoryManager
  def self.define_child_of(parent_factory, &block)
    unless FactoryGirl.factories.registered? parent_factory
      raise ArgumentError, "parent factory '#{parent_factory}' is not defined... are you sure you passed in a symbol?"
    end

    locals_fingerprint = block.binding.local_variables_with_values.hash

    child_factory_name = "#{parent_factory}_#{locals_fingerprint}"
    unless FactoryGirl.factories.registered? child_factory_name
      FactoryGirl.define do
        factory(child_factory_name, parent: parent_factory, &block)
      end
    end

    return child_factory_name
  end
end

class Binding
  def local_variables_with_values
    local_variables.map do |name|
      [name, local_variable_get(name)]
    end
  end
end
