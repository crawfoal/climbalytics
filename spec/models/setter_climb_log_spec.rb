require 'main_suite_helper'

describe SetterClimbLog do
  describe 'Validations' do
    it { should validate_presence_of :climb }
    it { should validate_length_of(:note).is_at_most(20000) }
  end

  describe 'Associations' do
    it { should belong_to :setter_story }
    it { should have_many :athlete_climb_logs }
    it { should have_one(:climb).dependent(:destroy) }
  end

  context 'with valid attributes' do
    subject(:setter_climb_log) { create(:setter_climb_log) }

    it { should be_valid }

    describe '#setter' do

      context 'with a setter defined' do

        let(:user) { create(:setter) }
        subject(:setter_climb_log) { user.setter_story.setter_climb_logs.create }

        it "returns the setter's user model" do
          expect(setter_climb_log.setter).to be user
        end

      end

      context 'without a setter defined' do
        it "returns nil" do
          expect(setter_climb_log.setter).to be_nil
        end
      end

    end
  end
end
