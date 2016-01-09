require 'rails_helper'

RSpec.describe SetterStory, type: :model do
  it 'is created for a user after a role of setter is added' do
    define_roles(:setter)
    user = create(:setter_user)
    expect(user.setter_story).to be_persisted
  end
end
