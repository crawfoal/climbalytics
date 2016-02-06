require 'rails_helper'

describe ValidationInspector do
  describe '::Column' do
    describe "#validate_length_options" do
      context 'when a column has a limit' do
        it 'uses the database limit as the maximum' do
          pa_column = State.columns_hash['postal_abbreviation']
          expect(pa_column.validate_length_options).to be == { maximum: pa_column.limit }
        end
      end

      context 'when a column does not have a limit' do
        context 'and the column type is string' do
          it 'defines a maximum of 255' do
            expect(Climb.columns_hash['name'].validate_length_options).to be == { maximum: 255 }
          end
        end

        context 'and the column type is text' do
          it 'defines a maximum of 20,000' do
            expect(ClimbSesh.columns_hash['note'].validate_length_options).to be == { maximum: 20000 }
          end
        end

        context 'and the column type is integer' do
          it 'defines a maximum of 11' do
            expect(Climb.columns_hash['moves_count'].validate_length_options).to be == { maximum: 11 }
          end
        end
      end
    end

    describe '#validate_numericality_options' do
      context 'the column type is integer' do
        it 'returns only_integer: true' do
          expect(Climb.columns_hash['moves_count'].validate_numericality_options).to be == { only_integer: true }
        end
      end
      context 'the column type is decimal or float' do
        it 'returns true'
      end
    end

    describe '#validate_presence_options' do
      context 'when null = false is specified for the column' do
        it 'returns true' do
          expect(User.columns_hash['email'].validate_presence_options).to be == true
        end
      end

      context 'when there is no null constraint for the column' do
        it 'returns nil' do
          expect(Climb.columns_hash['name'].validate_presence_options).to be == nil
        end
      end
    end

  end

  describe '::AssociationReflection' do
    describe '#validate_presence_options' do
      context 'when the inverse reflection can be found' do
        it 'returns the name of the assocation' do
          expect(SetterStory.reflections['user'].validate_presence_options).to be == :user
        end
      end
      context 'when the inverse reflection cannot be found' do
        it 'returns nil' do
          expect(Boulder.reflections['loggable'].validate_presence_options).to be_nil
        end
      end
    end

    describe '#validate_uniqueness_options' do
      context 'when the association is polymorphic' do
        it 'returns a scope with the type column' do
          expect(Climb.reflections['loggable'].validate_uniqueness_options).to be == { scope: :loggable_type }
        end
      end
      context 'when the association is not polymorphic' do
        it 'returns true' do
          expect(AthleteStory.reflections['user'].validate_uniqueness_options).to be == true
        end
      end
    end
  end
end
