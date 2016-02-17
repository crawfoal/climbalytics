require 'rails_helper'

RSpec.describe SetterStory, type: :model do
  describe 'Validations' do
    #---------------------------------------------------------------------------
    # Validations defined in model

    #---------------------------------------------------------------------------

    it 'should have no validators' do
      expect(SetterStory.validators.size).to be 0
    end
  end

  let(:user) { create(:user, roles: [:setter]) }

  it 'is created for a user after a role of setter is added' do
    expect(user.setter_story).to be_persisted
  end
  it 'can create an associated setter_climb_log' do
    expect { user.setter_story.setter_climb_logs.create }.to change { user.setter_story.setter_climb_logs.count }.by(1)
  end

end
