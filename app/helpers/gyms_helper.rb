module GymsHelper
  def expand_basic_info?
    @gym.name.blank?
  end
  def expand_address?
    @gym.location.address.blank?
  end
  def expand_gym_layout?
    @gym.topo.blank?
  end

  def gyms_near user
    if (location = user.current_location)
      Gym.near([location.latitude, location.longitude])
    else
      []
    end
  end
end
