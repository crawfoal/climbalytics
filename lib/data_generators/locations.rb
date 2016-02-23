class LocationGenerator < BaseGenerator
  attr_accessor :rand_lat_long
  alias_method :rand_lat_long?, :rand_lat_long

  def initialize(args = {})
    super
    @rand_lat_long = true unless args[:rand_lat_long] == false
  end

  private
  def define_factory
    if parent_factory
      include_address = include_address?
      FactoryManager.define_child_of parent_factory do
        with_address if include_address
      end
    else
      :generic_location
    end
  end
  def parent_factory
    :location unless rand_lat_long?
  end
  def include_address?
    four_fifths_of_the_time
  end
end
