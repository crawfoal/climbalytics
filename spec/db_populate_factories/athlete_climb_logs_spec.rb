require 'rails_helper'

describe 'db:populate' do
  describe 'generated athlete climb logs' do
    subject(:alog) { athlete_climb_log = create :_athlete_climb_log_ }

    it 'has some associated climb_seshes (between 1 and 10)' do
      expect(Faker::Number).to receive(:between).at_least(:once).and_return(1)
      expect(alog.climb_seshes.size).to be == 1
    end

    it 'has a note (1/5 of the time)' do
      expect(alog.note).to_not be_blank
    end

    it 'has the project attribute marked as true or false (4/5 of the time)' do
      expect(alog.project).to_not be_nil
    end

    it 'has a quality rating (1/3 of the time)' do
      expect(alog.quality_rating).to_not be_nil
    end

    it 'belongs to a setter_climb_log' do
      expect(alog.setter_climb_log).to be_present
    end

    it 'gym_section is set appropriately for both the athlete_climb_log and the setter_climb_log' do
      gym_section = create(:gym_section)
      alog = create :_athlete_climb_log_, gym_section: gym_section
      expect(alog.climb.gym_section).to be == gym_section
      expect(alog.setter_climb_log.climb.gym_section).to be == gym_section
    end
  end
end
