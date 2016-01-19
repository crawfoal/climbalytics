require 'rails_helper'

RSpec.describe BoulderLog, type: :model do
  let(:user) { create(:athlete_user) }
  subject(:boulder_log) { user.athlete_story.boulder_logs.create(attributes_for(:boulder_log)) }

  it 'has a valid factory' do
    expect(boulder_log).to be_valid
    expect(boulder_log.grade).to_not be_blank
  end

  describe '#athlete' do
    it 'returns the user associated with this athlete story' do
      expect(boulder_log.athlete).to be == user
    end
  end
end
