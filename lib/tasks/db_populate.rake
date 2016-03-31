namespace :db do
  desc "Fill database with sample data"
  task :populate => :non_prod do
    load "#{Rails.root}/lib/geocoding_stubs.rb"
    require "#{Rails.root}/lib/factories/factories"

    Rake::Task['db:reset'].invoke

    FactoryGirl.create_list(:_user_, Faker::Number.between(10, 15))

    FactoryGirl.create_list(:_gym_, Faker::Number.between(5, 10))
    FactoryGirl.create(:wild_walls)
    FactoryGirl.create(:brooklyn_boulders_ny)
    FactoryGirl.create(:the_front_salt_lake)

    FactoryGirl.create_list(:_setter_, Faker::Number.between(15, 20))

    FactoryGirl.create_list(:_athlete_, Faker::Number.between(35, 40))
  end
end
