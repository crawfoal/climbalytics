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
  end
end
