require 'rails_helper'

describe ValidatorInspector do
  describe '#validation_types_for' do
    context 'a column with no validations' do
      subject { Climb.validation_types_for(:project) }
      it { should be_empty }
    end
    context 'a column with some validations' do
      it 'should be an array of the corresponding validation types' do
        expect(User.validation_types_for(:email)).to include :presence, :uniqueness
      end
    end
  end
end
