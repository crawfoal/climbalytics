module GymsHelper
  def expand_address?
    @gym.location.address.blank?
  end

  def gyms_near user
    if (location = user.current_location)
      Gym.near([location.latitude, location.longitude])
    else
      []
    end
  end
end
