require 'rails_helper'

RSpec.describe AthleteClimbLog, type: :model do
  let(:user) { create(:athlete_user) }
  subject(:athlete_climb_log) { user.athlete_story.athlete_climb_logs.create(attributes_for(:athlete_climb_log)) }

  it { should have_one :climb }
  it { should accept_nested_attributes_for :climb }
  it { should validate_presence_of :athlete_story }

  it 'has a valid factory' do
    expect(athlete_climb_log).to be_valid
  end

  describe '#athlete' do
    it 'returns the user associated with this athlete story' do
      expect(athlete_climb_log.athlete).to be == user
    end
  end

end
