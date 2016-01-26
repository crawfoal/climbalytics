require 'rails_helper'

RSpec.describe AthleteClimbLog, type: :model do
  let(:user) { create(:athlete_user) }

  context 'with valid attributes' do
    subject(:athlete_climb_log) { user.athlete_story.athlete_climb_logs.create(attributes_for(:athlete_climb_log)) }

    it { should be_valid }

    describe '#athlete' do
      it 'returns the user associated with this athlete story' do
        expect(athlete_climb_log.athlete).to be == user
      end
    end
  end

end
