require 'rails_helper'

RSpec.describe AthleteStory, type: :model do
  let(:user) { create(:athlete_user) }

  it { should validate_presence_of :user }

  it 'is created for a user after a role of athlete is added' do
    expect(user.athlete_story).to be_persisted
  end
end
