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
    Gym.create!(name: 'Wild Walls', topo: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'gyms', 'topo_image.png')), location_attributes: { address_attributes: { line1: '202 West Second Avenue', city: 'Spokane', zip: '99201', state_id: wa.id } })

    Gym.all.each { |gym| generate_members_for gym }

  end

  def generate_members_for(gym)
    climb_generator = ClimbGenerator.new(gym: gym)
    alog_generator = AthleteClimbLogGenerator.new(climb_generator: climb_generator)
    athlete_generator = AthleteGenerator.new(min: 1, max: 15, alog_generator: alog_generator)

    athlete_generator.generate_set
  end
end
