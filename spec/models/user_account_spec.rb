require 'rails_helper'

RSpec.describe UserAccount, type: :model do
  describe 'Validations' do
    subject { build(:user_account) }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('amanda@example.com').for(:email) }
    it { should_not allow_value('foo').for(:email) }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
    it { should validate_length_of(:password).is_at_least(8).is_at_most(72) }
    it { should validate_length_of(:email).is_at_most(255) }
  end

  describe 'Associations' do
    it { should have_one :user }
  end
end
