require 'rails_helper'
require "rake_helper"

describe MakeUsers, :rake_helper do
  [:setter, :athlete].each do |role|
    describe ".make_#{role}s", :transaction_group do
      before :all do
        @users_init_count = User.count
        MakeUsers.send("make_#{role}s")
      end

      it 'creates some users' do
        expect(@users_init_count).to be == 0
        expect( User.count ).to be > 0
      end

      # this test could legitimately fail, and it is more likely to fail if not that many users are created
      it 'gives some users a name' do
        expect( User::Name.count ).to be > 0
        User::Name.all.each do |name|
          expect( name.user ).to_not be_nil
        end
      end
      it "assigns each user a role of #{role}" do
        User.all.each do |user|
          expect(user).to have_role role
        end
      end

      it 'creates an email for the users' do
        User.all.each do |user|
          expect(user.email).to_not be_nil
        end
      end

      it "creates some #{role} logs for each user" do
        User.all.each do |user|
          expect(user.send("#{role}_story").send("#{role}_climb_logs").size).to be > 0
        end
      end
    end
  end
end
