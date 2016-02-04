require 'rails_helper'
require "rake_helper"

describe MakeSetterLogs, :rake_helper do
  describe '.make_setter_logs', :transaction_group do
    before :all do
      user = create(:setter_user)
      @slog_initial_count = SetterClimbLog.count
      MakeSetterLogs.make_setter_logs(user.setter_story)
    end

    it 'creates one or more setter climb log' do
      expect(@slog_initial_count).to be == 0
      expect(SetterClimbLog.count).to be > 0
    end
  end
end
