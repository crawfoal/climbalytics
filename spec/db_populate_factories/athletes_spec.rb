require 'rails_helper'

describe 'db:populate' do
  describe 'generated athletes' do
    it 'has some associated athlete_climb_logs (between 0 and 30)' do
      expect(Faker::Number).to receive(:between).at_least(:once).and_return(1)
      athlete = create :_athlete_
      expect(athlete.athlete_story.athlete_climb_logs.size).to be == 1
    end
  end
end
