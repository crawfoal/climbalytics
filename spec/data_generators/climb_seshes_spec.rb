require 'rails_helper'
require "#{Rails.root}/lib/data_generators"

describe ClimbSeshGenerator do
  subject(:climb_sesh_generator) { ClimbSeshGenerator.new(min: 2, max: 2) }
  describe 'climb_sesh created by #generate_one' do
    subject(:climb_sesh) { climb_sesh_generator.generate_one }

    context 'with `include_*?` methods stubbed out to true' do
      it 'has a high hold defined' do
        allow(climb_sesh_generator).to receive(:include_high_hold?) { true }
        expect(climb_sesh.high_hold).to be_a Integer
      end
      it 'has a note' do
        allow(climb_sesh_generator).to receive(:include_note?) { true }
        expect(climb_sesh.note).to be_a String
      end
    end

    context 'with `include_*?` methods stubbed out to false' do
      it 'does not have a high hold defined' do
        allow(climb_sesh_generator).to receive(:include_high_hold?) { false }
        expect(climb_sesh.high_hold).to be_nil
      end
      it 'has a note' do
        allow(climb_sesh_generator).to receive(:include_note?) { false }
        expect(climb_sesh.note).to be_nil
      end
    end
  end
end
