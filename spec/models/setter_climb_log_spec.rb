require 'rails_helper'

describe SetterClimbLog do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model

    #---------------------------------------------------------------------------

    #---------------------------------------------------------------------------
    # Generated validations
    it { should validate_length_of(:note).is_at_most(20000) }
    #---------------------------------------------------------------------------

    it 'should have 4 validator' do
      expect(SetterClimbLog.validators.size).to be 4 # include CarrierWave validators
    end
  end

  context 'with valid attributes' do
    subject(:setter_climb_log) { create(:setter_climb_log) }

    it { should be_valid }

    describe '#setter' do

      context 'with a setter defined' do

        let(:user) { create(:user, roles: [:setter]) }
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
