require 'rails_helper'
require "helpers/make_users"

describe MakeUsers, :rake_helper do
  [[:athlete, :setter], [:setter, :athlete]].each do |role1, role2|
    describe ".make_#{role1}_#{role2}s", :transaction_group do
      before :all do
        @users_init_count = User.count
        MakeUsers.send("make_#{role1}_#{role2}s")
      end

      it "adds the role of #{role2} to each #{role1} user" do
        User.all.each do |user|
          expect(user).to have_role role2
        end
      end

      it "creates some #{role2} climb logs for each user" do
        User.all.each do |user|
          expect(user.send("#{role2}_story").send("#{role2}_climb_logs").size).to be > 0
        end
      end

      it 'associates some athlete climb logs with a setter climb log' do
        associated_count = 0
        AthleteClimbLog.all.each do |alog|
          associated_count = associated_count + 1 unless alog.setter_climb_log.nil?
        end
        expect(associated_count).to be > 0
      end
    end
  end
end
