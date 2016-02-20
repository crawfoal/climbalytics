require "#{Rails.root}/lib/data_generators"

namespace :db do
  desc "Fill database with sample data"
  task :populate => :non_prod do

    Rake::Task['db:reset'].invoke

    # Create some "new" users (users that don't have a role yet).
    UserGenerator.new.generate_set

    AthleteGenerator.new.generate_set

    GymGenerator.new.generate_set
  end
end
