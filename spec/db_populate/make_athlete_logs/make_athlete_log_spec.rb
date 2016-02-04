require 'rails_helper'
require "rake_helper"

describe MakeAthleteLogs, :rake_helper do

  let(:user) { create(:athlete_user) }

  describe '.make_athlete_log' do
    subject(:make_athlete_log) { MakeAthleteLogs.make_athlete_log(user.athlete_story) }

    it 'creates one setter climb log' do
      expect { make_athlete_log }.to change { AthleteClimbLog.count }.from(0).to(1)
    end

    describe 'the athlete climb log' do
      subject(:alog) { make_athlete_log }

      it 'is associated with the user' do
        expect(alog.athlete_story.user).to_not be_nil
      end
      it 'has a note' do
        expect(alog.note).to_not be_nil
      end
      it 'has an associated climb' do
        expect(alog.climb).to_not be_nil
      end
      it 'has at least one associated climb sesh' do
        expect(alog.climb_seshes.size).to be > 0
      end
    end
  end
end
