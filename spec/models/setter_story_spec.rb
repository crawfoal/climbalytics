require 'rails_helper'

RSpec.describe SetterStory, type: :model do
  let(:user) { create(:setter_user) }

  it 'is created for a user after a role of setter is added' do
    expect(user.setter_story).to be_persisted
  end
  it 'can create an associated setter_climb_log' do
    expect { user.setter_story.setter_climb_logs.create }.to change { user.setter_story.setter_climb_logs.count }.by(1)
  end

end
