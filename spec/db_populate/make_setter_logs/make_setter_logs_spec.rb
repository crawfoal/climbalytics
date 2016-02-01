require 'rails_helper'
require "helpers/make_setter_logs"

describe MakeSetterLogs, :rake_helper do
  describe '.make_setter_logs', :transaction_group do
    before :all do
      @user = User.create!(email: 'user@example.com',
                           password: 'password',
                           password_confirmation: 'password')
      @user.add_role :setter
      @slog_initial_count = SetterClimbLog.count
      MakeSetterLogs.make_setter_logs(@user.setter_story)
    end

    it 'creates one or more setter climb log' do
      expect(@slog_initial_count).to be == 0
      expect(SetterClimbLog.count).to be > 0
    end
  end
end
