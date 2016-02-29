namespace :db do
  desc "Fill database with sample data"
  task :populate => :non_prod do
    require "#{Rails.root}/lib/data_generators"

    Rake::Task['db:reset'].invoke

    # Create some "new" users (users that don't have a role yet).
    UserGenerator.new.generate_set

    GymGenerator.new.generate_set

    # Create a gym nearby us
    wa = State.create!(postal_abbreviation: 'WA', full_name: 'Washington')
    ww = Gym.create!(name: 'Wild Walls', topo: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'gyms', 'topo_image.png')), location_attributes: { address_attributes: { line1: '202 West Second Avenue', city: 'Spokane', zip: '99201', state_id: wa.id } })
    Faker::Number.between(1,5).times { ww.sections << FactoryGirl.create(:gym_section) }

    generate_members_for Gym.all

  end

  def generate_members_for(gyms)
    climb_generator = ClimbGenerator.new()
    alog_generator = AthleteClimbLogGenerator.new(climb_generator: climb_generator)
    athlete_generator = AthleteGenerator.new(min: 1, max: 15, alog_generator: alog_generator)
    _gyms = Array(gyms)
    _gyms.each do |gym|
      climb_generator.gym = gym
      athlete_generator.generate_set
    end
  end
end
