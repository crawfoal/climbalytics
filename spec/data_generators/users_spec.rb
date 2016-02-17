require 'rails_helper'
require "#{Rails.root}/lib/helpers/data_generators"

shared_examples 'creates some users' do |num_created|
  it 'creates some users' do
    expect { subject.run }.to change { User.count }.by(num_created)
  end
end

describe UserGenerator do
  subject(:user_generator) { UserGenerator.new(min: 2, max: 2) }

  describe '#run' do
    include_examples 'creates some users', 2
  end

  describe '#initialize' do
    context 'using defaults' do
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
    subject(:user_generator) { UserGenerator.new(min: 2, max: 2, include_name: :never) }

    describe '#run' do
      include_examples 'creates some users', 2

      it "doesn't create a name for any of the users" do
        user_generator.min = 5
        user_generator.max = 5
        user_generator.run
        User.all.each do |user|
          expect(user.name).to be_nil
        end
      end
    end
  end

  context 'with @include_name = :always' do
    subject(:user_generator) { UserGenerator.new(min: 2, max: 2, include_name: :always) }

    describe '#run' do
      include_examples 'creates some users', 2

      it "creates a full name for every user" do
        user_generator.min = 5
        user_generator.max = 5
        user_generator.run
        User.all.each do |user|
          expect(user.name.first).to_not be_blank
          expect(user.name.last).to_not be_blank
        end
      end
    end
  end
end

describe AthleteGenerator do
  subject(:athlete_generator) { AthleteGenerator.new(min: 2, max: 2) }

  describe '#run' do
    include_examples 'creates some users', 2

    it 'gives each user a role of athlete' do
      athlete_generator.run
      User.all.each do |user|
        expect(user).to have_role :athlete
      end
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

  describe '#run' do
    include_examples 'creates some users', 2

    it 'gives each user a role of setter' do
      setter_generator.run
      User.all.each do |user|
        expect(user).to have_role :setter
      end
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
