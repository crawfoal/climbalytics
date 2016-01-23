require 'rails_helper'

RSpec.describe Climb, type: :model do
  it { should belong_to :loggable }
  it { should validate_presence_of :type }
  context 'which is neither a boulder nor a route' do
    subject(:climb) { build(:climb) }
    it { is_expected.to_not be_valid }
  end
end
