require 'main_suite_helper'

describe 'db:populate' do
  describe 'generated climbs' do
    subject(:climb) { create :_climb_ }

    it 'has a grade (4/5 of the time)' do
      expect(climb.grade).to_not be_nil
    end

    it 'gets the appropriate grade when explicitly specified' do
      climb = create(:_climb_, type: 'Route', grade: '5.12c')
      expect(climb.grade).to be == "5.12c"
    end

    it 'has a moves_count specified (4/5 of the time)' do
      expect(climb.moves_count).to_not be_nil
    end

    it 'has a name (1/5 of the time)' do
      expect(climb.name).to_not be_blank
    end

    it 'belongs to a gym section' do
      expect(climb.gym_section).to be_present
    end
  end
end
