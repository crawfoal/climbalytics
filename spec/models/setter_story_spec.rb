require 'rails_helper'

RSpec.describe SetterStory, type: :model do
  let(:user) { create(:setter_user) }

  it 'is created for a user after a role of setter is added' do
    expect(user.setter_story).to be_persisted
  end
  it 'can create an associated setter_climb_log' do
    setter_climb_log = user.setter_story.setter_climb_logs.create
    expect(user.setter_story.setter_climb_logs.count).to be >= 1
    expect(setter_climb_log).to be_persisted
  end

end
