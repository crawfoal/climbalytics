require 'rails_helper'
require "rake_helper"

describe MakeUsers, :rake_helper do
  describe '.make_new_users', :transaction_group do
    before :all do
      @users_init_count = User.count
      MakeUsers.make_new_users
    end

    it 'creates some users' do
      expect(@users_init_count).to be == 0
      expect( User.count ).to be > 0
    end

    it 'does not give the users names' do
      User.all.each do |user|
        expect(user.name).to be_nil
      end
    end
    it 'does not assign any roles to the users' do
      User.all.each do |user|
        expect(user.roles).to be_empty
      end
    end

    it 'creates an email for the users' do
      User.all.each do |user|
        expect(user.email).to_not be_nil
      end
    end
  end
end
