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
end
