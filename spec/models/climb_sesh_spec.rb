require 'rails_helper'

RSpec.describe ClimbSesh, type: :model do
  subject(:climb_sesh) { build(:climb_sesh) }
  it { should be_valid }
  it { should validate_presence_of :athlete_climb_log }
end
