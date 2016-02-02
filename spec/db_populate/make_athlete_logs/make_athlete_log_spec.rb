require 'rails_helper'
require "rake_helper"

describe MakeAthleteLogs, :rake_helper do
  describe '.make_athlete_log', :transaction_group do
    before :all do
      @user = User.create!(email: 'user@example.com',
                           password: 'password',
                           password_confirmation: 'password')
      @user.add_role :athlete
    end

    subject(:make_athlete_log) { MakeAthleteLogs.make_athlete_log(@user.athlete_story) }

    it 'creates one setter climb log' do
      expect { make_athlete_log }.to change { AthleteClimbLog.count }.from(0).to(1)
    end

    describe 'the athlete climb log' do
      before :all do
        MakeAthleteLogs.make_athlete_log(@user.athlete_story)
      end

      subject(:alog) { AthleteClimbLog.last }

      it 'is associated with the user' do
        expect(alog.athlete_story.user).to_not be_nil
      end

      it 'has a note' do
        expect(alog.note).to_not be_nil
      end

      it 'has an associated climb' do
        expect(alog.climb).to_not be_nil
      end
    end
  end
end
