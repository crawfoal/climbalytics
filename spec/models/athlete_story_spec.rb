require 'main_suite_helper'

RSpec.describe AthleteStory, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :user }
  end

  it 'is created for a user after a role of athlete is added' do
    expect(create(:athlete).athlete_story).to be_persisted
  end

  describe '#cache_recent_gym' do
    let(:astory) { create :athlete_story }
    let(:gym) { create :gym }

    it 'adds the gym id to the recent_gym_ids_cache attribute' do
      astory.cache_recent_gym(gym.id)
      astory.reload
      expect(astory.recent_gym_ids_cache).to include gym.id
    end

    it 'adds the new gym id to the front of the cache' do
      (1..2).each { |num| astory.cache_recent_gym(num) }
      expect(astory.recent_gym_ids_cache).to be == [2,1]
    end

    it 'accepts an object that responds to #id' do
      astory.cache_recent_gym(gym)
      expect(astory.recent_gym_ids_cache).to include gym.id
    end

    it "holds at most 3 gym_ids" do
      (1..4).each { |num| astory.cache_recent_gym(num) }
      expect(astory.recent_gym_ids_cache.length).to be == 3
    end

    it "won't add the new gym id if it is the same as the id at the front of the cache" do
      2.times { astory.cache_recent_gym(1) }
      expect(astory.recent_gym_ids_cache).to be == [1]
    end
  end

  describe 'recent_gym_ids_cache attribute' do
    let(:astory) { build :athlete_story }

    class MyObject
    end

    it "won't run arbitrary code when being serialized/deserialized" do
      begin
        astory.recent_gym_ids_cache = "[1,2,3,`TEST_VAR='hello world!'`]"
        astory.save
        astory.reload
      rescue ActiveRecord::SerializationTypeMismatch
      end
      expect(`echo $TEST_VAR`).to_not include "hello world!"
    end

    it 'cannot be set to an arbitrary object' do
      expect{ astory.recent_gym_ids_cache = MyObject.new }.to raise_error ActiveRecord::SerializationTypeMismatch
    end

    it 'can be set to an array object' do
      expect{ astory.recent_gym_ids_cache = Array.new }.to_not raise_error
    end

    it "cannot store non-integer elements" do
      astory.recent_gym_ids_cache << MyObject.new
      expect(astory).to_not be_valid
    end
  end

  describe '#recent_gyms' do
    let(:athlete_story) { create :athlete_story }

    context 'at least one climb has been logged for three separate gyms' do
      before :each do
        4.times { athlete_story.athlete_climb_logs << create(:athlete_climb_log, gym_section: create(:gym).sections.first) }
      end

      it 'includes the three most recent gyms' do
        alogs = athlete_story.athlete_climb_logs.order(created_at: :desc, id: :asc)
        gyms = alogs.map{ |alog| alog.climb.gym }.uniq
        gyms = gyms[0..[2, gyms.length].min]
        expect(athlete_story.recent_gyms).to be == gyms
      end
    end

    context 'no climbs have been logged' do
      it 'returns an empty array' do
        expect(athlete_story.recent_gyms).to be == []
      end
    end
  end
end
