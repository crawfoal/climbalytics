require 'rails_helper'

RSpec.describe AthleteClimbLog, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :athlete_story }
    it { should validate_presence_of :climb }
    it { should validate_numericality_of(:quality_rating).only_integer.is_less_than(6).is_greater_than(0).allow_nil }
    it { should validate_length_of(:note).is_at_most(20000) }
  end

  describe '.min_quality_rating' do
    subject { AthleteClimbLog.min_quality_rating }
    it { should be == 1 }
  end

  describe '.max_quality_rating' do
    subject { AthleteClimbLog.max_quality_rating }
    it { should be == 5 }
  end

  subject(:athlete_climb_log) { create(:athlete_climb_log) }

  describe 'Associations' do
    it { should belong_to :setter_climb_log }

    it { should belong_to :athlete_story }

    it { should have_one(:climb).dependent(:destroy) }
    it { should accept_nested_attributes_for :climb }

    it { should have_many(:climb_seshes).dependent(:destroy) }
  end

  context 'with valid attributes' do
    it { should be_valid }
    it 'should have an associated climb' do
      expect(athlete_climb_log.climb).to_not be_nil
    end

    describe '#athlete' do
      it 'returns the user associated with this athlete story' do
        expect(athlete_climb_log.athlete).to be == athlete_climb_log.athlete_story.user
      end
    end
  end

end
