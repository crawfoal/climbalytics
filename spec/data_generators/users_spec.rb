require 'rails_helper'
require "#{Rails.root}/lib/data_generators"

shared_examples 'creates some users' do |num_created|
  it 'creates some users' do
    expect { subject.generate_set }.to change { User.count }.by(num_created)
  end
end

describe UserGenerator do
  subject(:user_generator) { UserGenerator.new(min: 2, max: 2) }

  describe '#generate_set' do
    include_examples 'creates some users', 2
  end

  describe '#initialize' do
    context 'by default' do
      subject(:user_generator) { UserGenerator.new }
      it 'sets @min = 10' do
        expect(user_generator.min).to be == 10
      end
      it 'sets @max = 15' do
        expect(user_generator.max).to be == 15
      end
    end
  end

  describe 'user created by #generate_one' do
    subject(:user) { user_generator.generate_one }

    context 'with @include_name = :never' do
      before { user_generator.include_name = :never }
      it "doesn't have a name" do
        expect(user.name).to be_nil
      end
    end

    context 'with @include_name = :always' do
      before { user_generator.include_name = :always }

      it "creates a full name for the user" do
        expect(user.name.first).to_not be_blank
        expect(user.name.last).to_not be_blank
      end
    end

  end
end

describe AthleteGenerator do
  subject(:athlete_generator) { AthleteGenerator.new(min: 2, max: 2) }
  before :each do
    athlete_generator.logs_count = 2
  end

  describe '#logs_count' do
    it 'calls AthleteClimbLogGenerator#count' do
      expect_any_instance_of(AthleteClimbLogGenerator).to receive(:count)
      athlete_generator.logs_count
    end
  end

  describe '#logs_count=' do
    it 'calls AthleteClimbLogGenerator#count=' do
      expect_any_instance_of(AthleteClimbLogGenerator).to receive(:count=).with(2)
      athlete_generator.logs_count = 2
    end
  end

  describe '#seshes_per_log' do
    it 'calls ClimbSeshGenerator#count' do
      expect_any_instance_of(ClimbSeshGenerator).to receive(:count)
      athlete_generator.seshes_per_log
    end
  end

  describe '#seshes_per_log=' do
    it 'calls ClimbSeshGenerator#count=' do
      expect_any_instance_of(ClimbSeshGenerator).to receive(:count=).with(2)
      athlete_generator.seshes_per_log = 2
    end
  end

  describe '#initialize' do
    context 'using defaults' do
      subject(:athlete_generator) { AthleteGenerator.new }
      it 'sets @min = 20' do
        expect(athlete_generator.min).to be == 20
      end
      it 'sets @max = 40' do
        expect(athlete_generator.max).to be == 40
      end
    end
  end

  describe '#generate_set' do
    include_examples 'creates some users', 2
  end

  describe '#generate_one' do
    it 'creates one athlete_story' do
      expect { athlete_generator.generate_one }.to change { AthleteStory.count }.by 1
    end
  end

  describe 'user created by #generate_one' do
    subject(:athlete) { athlete_generator.generate_one }
    it 'has a role of athlete' do
      expect(athlete).to have_role :athlete
    end
    it 'has the correct number athlete_climb_logs' do
      expect(athlete.athlete_story.athlete_climb_logs.size).to be == 2
    end
  end

  describe '#factory_name' do
    it 'changes when a local variable in #define_factory changes' do
      old_factory_name = athlete_generator.factory_name
      athlete_generator.logs_count = athlete_generator.logs_count.max + 1
      expect(athlete_generator.factory_name).to_not be == old_factory_name
    end
  end

end

describe SetterGenerator do
  subject(:setter_generator) { SetterGenerator.new(min: 2, max: 2) }

  describe '#generate_set' do
    include_examples 'creates some users', 2
  end

  describe 'user created by #generate_one' do
    subject(:setter) { setter_generator.generate_one }
    it 'has a role of setter' do
      expect(setter).to have_role :setter
    end
  end

  describe '#initialize' do
    context 'using defaults' do
      subject(:setter_generator) { SetterGenerator.new }
      it 'sets @min = 15' do
        expect(setter_generator.min).to be == 15
      end
      it 'sets @max = 20' do
        expect(setter_generator.max).to be == 20
      end
    end
  end
end
