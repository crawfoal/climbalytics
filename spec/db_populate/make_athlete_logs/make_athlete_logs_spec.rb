require 'rails_helper'
require "rake_helper"

describe MakeAthleteLogs, :rake_helper do
  describe '.make_athlete_logs', :transaction_group do
    before :all do
      @user = User.create!(email: 'setter@example.com',
                           password: 'password',
                           password_confirmation: 'password')
      @user.add_role :setter
      @user.setter_story.setter_climb_logs.create!(note: 'Competition style run-up start.')

      @user = User.create!(email: 'athlete@example.com',
                           password: 'password',
                           password_confirmation: 'password')
      @user.add_role :athlete
    end

    before :each do
      @alog_initial_count = AthleteClimbLog.count
      allow(MakeAthleteLogs).to receive(:associate_with_setter_log?).and_return(true)
      allow(SetterClimbLog).to receive(:random) { SetterClimbLog.last }
      MakeAthleteLogs.make_athlete_logs(@user.athlete_story)
    end

    it 'creates one or more athlete climb log' do
      expect(@alog_initial_count).to be == 0
      expect(AthleteClimbLog.count).to be > 0
    end

    it '(randomly) associates setter climb logs with the athlete climb logs' do
      AthleteClimbLog.all.each do |alog|
        expect(alog.setter_climb_log).to_not be nil
      end
    end
  end
end
