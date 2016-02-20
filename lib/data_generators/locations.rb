class LocationGenerator < BaseGenerator
  private
  def define_factory
    include_address = include_address?
    FactoryManager.define_child_of :location do
      with_address if include_address
    end
  end
  def include_address?
    four_fifths_of_the_time
  end
end
