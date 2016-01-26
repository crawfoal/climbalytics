require 'rails_helper'

describe State do
  context 'with valid attributes' do
    subject(:state) { build(:state) }
    it { should be_valid }
  end
end
