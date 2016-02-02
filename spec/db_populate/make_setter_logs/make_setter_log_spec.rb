require 'rails_helper'
require "rake_helper"

describe MakeSetterLogs, :rake_helper do
  describe '.make_setter_log', :transaction_group do
    before :all do
      @user = User.create!(email: 'user@example.com',
                           password: 'password',
                           password_confirmation: 'password')
      @user.add_role :setter
    end

    subject(:make_setter_log) { MakeSetterLogs.make_setter_log(@user.setter_story) }

    it 'creates one setter climb log' do
      expect { make_setter_log }.to change { SetterClimbLog.count }.from(0).to(1)
    end

    describe 'the setter climb log' do
      before :all do
        MakeSetterLogs.make_setter_log(@user.setter_story)
      end

      subject(:slog) { SetterClimbLog.last }

      it 'is associated with the user' do
        expect(slog.setter_story.user).to_not be_nil
      end

      it 'has a note' do
        expect(slog.note).to_not be_nil
      end
    end
  end
end
