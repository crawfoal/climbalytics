require 'rails_helper'
require "#{Rails.root}/lib/data_generators"

describe ClimbLogGenerator do
  describe '#initialize' do
    context 'by default' do
      subject(:user_generator) { ClimbLogGenerator.new }
      it 'sets @min = 0' do
        expect(user_generator.min).to be == 0
      end
      it 'sets @max = 30' do
        expect(user_generator.max).to be == 30
      end
    end
  end
end

describe AthleteClimbLogGenerator do
  subject(:athlete_climb_log_generator) { AthleteClimbLogGenerator.new(min: 2, max: 2) }

  describe 'athlete_climb_log created by #generate_one' do
    subject(:athlete_climb_log) { athlete_climb_log_generator.generate_one }

    it 'creates some associated climb_seshes' do
      athlete_climb_log_generator.seshes_count = 2
      expect(athlete_climb_log.climb_seshes.size).to be == 2
    end

    context 'with `include_*?` methods stubbed out to true' do
      it 'has a note' do
        allow(athlete_climb_log_generator).to receive(:include_note?) { true }
        expect(athlete_climb_log.note).to be_instance_of String
      end

      it 'project is set to true or false' do
        allow(athlete_climb_log_generator).to receive(:include_project?) { true }
        expect(athlete_climb_log.project).to be_in [true, false]
      end

      it 'has a quality rating' do
        allow(athlete_climb_log_generator).to receive(:include_quality_rating?) { true }
        expect(athlete_climb_log.quality_rating).to be_in AthleteClimbLog.min_quality_rating..AthleteClimbLog.max_quality_rating
      end
    end

    context 'with `include_*?` methods stubbed out to false' do
      it 'does not have a note' do
        allow(athlete_climb_log_generator).to receive(:include_note?) { false }
        expect(athlete_climb_log.note).to be_nil
      end

      it 'does not have project set' do
        allow(athlete_climb_log_generator).to receive(:include_project?) { false }
        expect(athlete_climb_log.project).to be_nil
      end

      it 'does not have a quality rating' do
        allow(athlete_climb_log_generator).to receive(:include_quality_rating?) { false }
        expect(athlete_climb_log.quality_rating).to be_nil
      end
    end
  end
end
