require 'rails_helper'

RSpec.describe AthleteStory, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model
    it { should validate_presence_of :user }
    #---------------------------------------------------------------------------

    it 'should have 1 validator' do
      expect(AthleteStory.validators.size).to be 1
    end
  end

  let(:user) { create(:user, roles: [:athlete]) }

  it 'is created for a user after a role of athlete is added' do
    expect(user.athlete_story).to be_persisted
  end
end
