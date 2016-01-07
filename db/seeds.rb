# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'active_record/fixtures'

ActiveRecord::Fixtures.create_fixtures("#{Rails.root}/test/fixtures", "states")

# Make sure the roles are defined for the first user (mainly needed for the view).
puts "Making user roles."
user = User.create()
[:athlete, :setter].each do |role|
  user.add_role role
end
user.destroy
