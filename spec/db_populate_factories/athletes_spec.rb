require 'main_suite_helper'

describe 'db:populate' do
  subject(:athlete) { create :_athlete_ }
  describe 'generated athletes' do
    it 'has some associated athlete_climb_logs (between 0 and 30)' do
      expect(Faker::Number).to receive(:between).at_least(:once).and_return(1)
      expect(athlete.athlete_story.athlete_climb_logs.size).to be == 1
    end
  end
end
