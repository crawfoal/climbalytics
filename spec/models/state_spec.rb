require 'main_suite_helper'

describe State do
  describe 'Validations' do
    it { should validate_length_of(:postal_abbreviation).is_at_most(2) }
    it { should validate_length_of(:full_name).is_at_most(50) }
  end

  context 'with valid attributes' do
    subject(:state) { build(:state) }
    it { should be_valid }
  end
end
