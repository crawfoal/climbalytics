namespace :db do
  desc "Fill database with sample data"
  task :populate => :non_prod do
    require "#{Rails.root}/lib/data_generators"

    Rake::Task['db:reset'].invoke

    # Create some "new" users (users that don't have a role yet).
    UserGenerator.new.generate_set

    GymGenerator.new.generate_set

    # Create a gym nearby us
    ww = FactoryGirl.create(:wild_walls)

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
