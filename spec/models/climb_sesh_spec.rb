require 'rails_helper'

RSpec.describe ClimbSesh, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :athlete_climb_log }
    it { should validate_numericality_of(:high_hold).only_integer.allow_nil }
    it { should validate_length_of(:note).is_at_most(20000) }
  end

  subject { build(:climb_sesh) }
  it { should be_valid }

end
