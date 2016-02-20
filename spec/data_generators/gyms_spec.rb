require 'rails_helper'
require "#{Rails.root}/lib/data_generators"

describe GymGenerator do
  subject(:gym_generator) { GymGenerator.new(min: 2, max: 2) }

  describe '#generate_set' do
    subject(:generate_set) { gym_generator.generate_set }

    it 'creates some gyms' do
      expect { generate_set }.to change { Gym.count }.from(0).to(2)
    end
  end

  describe 'gyms created by #generate_one' do
    subject(:gym) { gym_generator.generate_one }

    it 'has a name' do
      expect(gym.name).to be_a String
    end
    it 'has a topo' do
      expect(gym.topo).to be_present
    end
    it 'has a location' do
      expect(gym.location).to be_present
    end

    it 'has some sections' do
      allow(gym_generator).to receive(:num_sections).and_return(2)
      expect(gym.sections.size).to be == 2
    end
  end
end
