require 'rails_helper'
require "#{Rails.root}/lib/helpers/data_generators"

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
      it 'sets @min = 5' do
        expect(user_generator.min).to be == 5
      end
      it 'sets @max = 15' do
        expect(user_generator.max).to be == 15
      end
    end
  end

  context 'with @include_name = :never' do
    before :each do
      user_generator.include_name = :never
    end

    describe '#generate_one' do
      it "doesn't create a name for the user" do
        expect(user_generator.generate_one.name).to be_nil
      end
    end
  end

  context 'with @include_name = :always' do
    before :each do
      user_generator.include_name = :always
    end

    describe '#generate_one' do
      it "creates a full name for the user" do
        user = user_generator.generate_one
        expect(user.name.first).to_not be_blank
        expect(user.name.last).to_not be_blank
      end
    end
  end
end

describe AthleteGenerator do
  subject(:athlete_generator) { AthleteGenerator.new(min: 2, max: 2) }
  before :each do
    athlete_generator.athlete_climb_log_generator.min = 2
    athlete_generator.athlete_climb_log_generator.max = 2
  end

  describe '#generate_set' do
    include_examples 'creates some users', 2
  end

  describe '#generate_one' do
    subject(:athlete) { athlete_generator.generate_one }
    it 'gives the user a role of athlete' do
      expect(athlete).to have_role :athlete
    end
    it 'creates the specified number athlete_climb_logs' do
      expect(athlete.athlete_story.athlete_climb_logs.size).to be == 2
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
end

describe SetterGenerator do
  subject(:setter_generator) { SetterGenerator.new(min: 2, max: 2) }

  describe '#generate_set' do
    include_examples 'creates some users', 2
  end

  describe '#generate_one' do
    it 'gives the user a role of setter' do
      expect(setter_generator.generate_one).to have_role :setter
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
