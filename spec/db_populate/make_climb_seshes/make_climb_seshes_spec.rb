require 'rails_helper'
require "rake_helper"

describe MakeClimbSeshes, :rake_helper do
  describe '.make_climb_seshes', :transaction_group do
    before :all do
      alog = create(:athlete_climb_log)
      alog.create_boulder(attributes_for(:boulder))
      @orig_num_climb_seshes = ClimbSesh.count
      MakeClimbSeshes.make_climb_seshes(alog)
    end

    it 'creates one or more climb_seshes' do
      expect(@orig_num_climb_seshes).to be == 0
      expect(AthleteClimbLog.last.climb_seshes.size).to be > 0
    end
  end
end
