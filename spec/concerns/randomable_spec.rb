require 'main_suite_helper'

describe Randomable do
  describe 'ClassMethods#random' do
    before :each do
      create(:user)
    end
    context 'when given a count' do
      subject(:random_user) { User.random(User.count) }
      it { should be_a User }
    end
    context 'with no parameters' do
      subject(:random_user) { User.random }
      it { should be_a User }
    end
  end
end
