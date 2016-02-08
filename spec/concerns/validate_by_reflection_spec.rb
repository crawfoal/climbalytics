require 'rails_helper'

describe ValidateByReflection do
  describe '::ClassMethods' do
    describe '#build_args_for_validate' do
      context 'for a model no db constraints that correspond to active record validations' do
        it 'should return an empty array'
      end
      context 'for a model with some db constraints that correspond to active record validations' do
        before :each do
          allow(User::Name).to receive(:validation_types_for).and_return([])
        end
        subject(:args_array) { User::Name.build_args_for_validate }

        it { should_not include nil }

        it 'should return an array of the arguments for the corresponding validaitons' do
          expect(args_array).to include [:first, length: {maximum: 255}]
        end
        it 'should not have anything for primary key columns' do
          args_array.each do |args|
            expect(args).to_not include :id
          end
        end
        it 'should not include anything for columns that already have a validator of the particular type' do
          expect(args_array).to_not include [:email, {uniqueness: true}]
        end
      end
    end
  end
end
