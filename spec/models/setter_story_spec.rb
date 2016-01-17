require 'rails_helper'

RSpec.describe SetterStory, type: :model do
  before :each do
    @user = create(:setter_user)
  end
  it 'is created for a user after a role of setter is added' do
    expect(@user.setter_story).to be_persisted
  end
  it 'can create an associated boulder' do
    boulder = @user.setter_story.boulders.create
    expect(@user.setter_story.boulders.count).to be >= 1
    expect(boulder).to be_persisted
  end
end
