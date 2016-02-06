require 'rails_helper'

describe ValidateByReflection do
  describe '::ClassMethods' do
    describe '#build_args_for_validate' do
      context 'for a model no db constraints that correspond to active record validations' do
        it 'should return an empty array'
      end
      context 'for a model with some db constraints that correspond to active record validations' do
        before :each do
          allow(User::Name).to receive(:validator_digest).and_return({length: [], numericality: [], presence: [], uniqueness: []})
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

    describe '#length_validation_args' do
      context 'for a column that should generate a validation' do
        it 'returns an array of arguments' do
          column = Climb.columns_hash['name']
          expect(Climb.length_validation_args(column)).to be == [:name, length: { maximum: 255 }]
        end
      end
      context 'for a column that should not generate a validation' do
        it 'returns nil' do
          column = AthleteClimbLog.columns_hash['project']
          expect(AthleteClimbLog.length_validation_args(column)).to be_nil
        end
      end
      context 'for a foreign key column' do
        it 'returns nil' do
          column = User::Name.columns_hash['user_id']
          expect(User::Name.length_validation_args(column)).to be_nil
        end
      end
    end

    describe '#numericality_validation_args' do
      context 'for a column that should generate a validation' do
        it 'returns an array of arguments' do
          column = ClimbSesh.columns_hash['high_hold']
          expect(ClimbSesh.numericality_validation_args(column)).to be == [:high_hold, numericality: { only_integer: true }]
        end
      end
      context 'for a column that should not generate a validation' do
        it 'returns nil' do
          column = ClimbSesh.columns_hash['note']
          expect(ClimbSesh.numericality_validation_args(column)).to be_nil
        end
      end
      context 'for a foreign key column' do
        it 'returns nil' do
          column = User::Name.columns_hash['user_id']
          expect(User::Name.length_validation_args(column)).to be_nil
        end
      end
    end

    describe '#presence_validation_args' do
      context 'for a column with a null constraint' do
        context 'for a foreign key column' do
          context 'for which the inverse association can be found' do
            it 'returns an array of arguments'
          end
          context 'for which the inverse association cannot be found' do
            it 'returns nil'
          end
        end
        context 'for a non foreign key column' do
          it 'returns an array of arguments'
        end
      end
      context 'for a column without a null constraint' do
        it 'returns nil' do
          column = AthleteClimbLog.columns_hash['note']
          expect(AthleteClimbLog.presence_validation_args(column)).to be_nil
        end
      end
    end

    describe '#uniqueness_validation_args' do
      context 'for a foreign key column' do
        context 'that is for a polymorphic association' do
          context 'and for which there is a unique index with the type column' do
            it 'returns an array of arguments' do
              column = Address.columns_hash['addressable_id']
              expect(Address.uniqueness_validation_args(column)).to be == [ :addressable_id, uniqueness: { scope: :addressable_type } ]
            end
          end
          context 'for which there is not a unique index' do
            it 'returns nil' do
              column = Climb.columns_hash['loggable_id']
              expect(Climb.uniqueness_validation_args(column)).to be_nil
            end
          end
        end
        context 'that is for a non-polymorphic association' do
          context 'for which there is a unique index' do
            it 'returns an array of arguments'
          end
        end
      end
      context 'for a non-foreign key column' do
        context 'for which there is a unique index' do
          it 'returns an array of arguments' do
            column = User.columns_hash['reset_password_token']
            expect(User.uniqueness_validation_args(column)).to be == [:reset_password_token, uniqueness: true]
          end
        end
        context 'for which there is not a unique index' do
          it 'returns nil' do
            column = User::Name.columns_hash['first']
            expect(User::Name.uniqueness_validation_args(column)).to be_nil
          end
        end
      end
    end
  end
end
