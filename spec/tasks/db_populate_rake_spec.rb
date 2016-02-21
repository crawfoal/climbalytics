require 'rails_helper'
require 'rake'

describe 'db:populate', :transaction_group do
  before :all do
    Rake.application.rake_require 'tasks/db_populate'
    Rake.application.rake_require 'tasks/non_prod'
    Rake::Task.define_task(:environment)
    Rake::Task.define_task(:'db:reset')

    @orig_number_db_rows = count_rows_in_db(exclude: ['Role', 'ActiveRecord::SchemaMigration'], verbose: true)

    print_status_message 'running db:populate task...'.light_magenta
    Rake.application.invoke_task 'db:populate'
  end

  it '(our spec group should start with an empty database)' do
    expect(@orig_number_db_rows).to be == 0
  end

  it 'creates some "new" users (users with out a role)' do
    expect(User.includes(:roles).where( roles: { id: nil } ).size).to be > 0
  end
  it 'creates some athlete users' do
    expect(User.with_role(:athlete).size).to be > 0
  end
  it 'creates some athlete stories' do
    expect(AthleteStory.count).to be > 0
  end
  it 'creates some athlete climb logs' do
    expect(AthleteClimbLog.count).to be > 0
  end
  it 'creates some climb seshes' do
    expect(ClimbSesh.count).to be > 0
  end
  it 'creates some climbs' do
    expect(Climb.count).to be > 0
  end
  it 'creates some boulders' do
    expect(Boulder.count).to be > 0
  end
  it 'creates some routes' do
    expect(Route.count).to be > 0
  end
  it 'creates some gyms' do
    expect(Gym.count).to be > 0
  end
  describe 'each generated gym' do
    it 'has a location' do
      Gym.all.each do |gym|
        expect(gym.location).to be_present
      end
    end
    it 'has an address' do
      Gym.all.each do |gym|
        expect(gym.location.address).to be_present
      end
    end
  end

end
