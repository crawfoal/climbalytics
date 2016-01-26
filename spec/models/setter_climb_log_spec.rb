require 'rails_helper'

describe SetterClimbLog do
  context 'with valid attributes' do
    subject(:setter_climb_log) { create(:setter_climb_log) }

    it { should be_valid }

    describe '#setter' do

      context 'with a setter defined' do

        let(:user) { create(:setter_user) }
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
