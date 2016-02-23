require 'rails_helper'
require "#{Rails.root}/lib/data_generators"

describe ClimbGenerator do
  subject(:climb_generator) { ClimbGenerator.new }

  describe 'climb created by #generate_one' do
    subject(:climb) { climb_generator.generate_one }

    context 'with `include_*?` methods stubbed out to true' do
      it 'has a grade' do
        allow(climb_generator).to receive(:include_grade?).and_return(true)
        expect(climb.grade).to be_in climb.type.constantize.grades.keys
      end
      it 'specifies the number of moves in the climb' do
        allow(climb_generator).to receive(:include_moves_count?).and_return(true)
        expect(climb.moves_count).to be_a Integer
      end
      it 'has a name' do
        allow(climb_generator).to receive(:include_name?).and_return(true)
        expect(climb.name).to be_a String
      end
    end

    context 'with `include_*?` methods stubbed out to false' do
      it 'does not have a grade' do
        allow(climb_generator).to receive(:include_grade?).and_return(false)
        expect(climb.grade).to be_nil
      end
      it 'does not specify the number of moves in the climb' do
        allow(climb_generator).to receive(:include_moves_count?).and_return(false)
        expect(climb.moves_count).to be_nil
      end
      it 'does not name' do
        allow(climb_generator).to receive(:include_name?).and_return(false)
        expect(climb.name).to be_nil
      end
    end

    context 'when generator is initialized with a gym' do
      let(:gym) { GymGenerator.new.generate_one }
      let(:climb_generator) { ClimbGenerator.new(gym: gym) }
      it 'belongs to a section of the gym' do
        expect(climb.gym_section).to be_in gym.sections
      end
    end
  end
end
