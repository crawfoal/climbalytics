require 'rails_helper'

RSpec.describe AthleteClimbLog, type: :model do
  let(:user) { create(:athlete_user) }

  it { should belong_to :setter_climb_log }

  it { should belong_to :athlete_story }
  it { should validate_presence_of :athlete_story }

  it { should have_one(:climb).dependent(:destroy) }
  it { should accept_nested_attributes_for :climb }

  it { should have_many(:climb_seshes).dependent(:destroy) }

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
