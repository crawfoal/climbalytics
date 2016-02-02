require_relative "make_setter_logs"
require_relative "make_athlete_logs"

module MakeUsers

  MAX_NEW_USERS = 15
  MIN_NEW_USERS = 5

  MAX_ATHLETES = 50
  MIN_ATHLETES = 20

  MAX_SETTERS = 20
  MIN_SETTERS = 10

  MIN_ATHLETE_SETTERS = 5
  MAX_ATHLETE_SETTERS = 10

  MIN_SETTER_ATHLETES = 5
  MAX_SETTER_ATHLETES = 10

  class << self
    def make_users
      make_new_users
      make_setters
      make_athletes
      make_athlete_setters # current_role = athlete
      make_setter_athletes # current_role = setter
    end

    def make_new_users
      _make_users(Random.random(MIN_NEW_USERS, MAX_NEW_USERS), nil, nil, :never)
    end

    def make_setters(min_count = nil, max_count = nil, email_prefix = nil)
      min_count ||= MIN_SETTERS
      max_count ||= MAX_SETTERS
      email_prefix ||= :setter

      _make_users(Random.random(min_count, max_count), :setter, email_prefix) do |user|
        MakeSetterLogs.make_setter_logs(user.setter_story)
        yield user if block_given?
      end
    end

    def make_athletes(min_count = nil, max_count = nil, email_prefix = nil)
      min_count ||= MIN_ATHLETES
      max_count ||= MAX_ATHLETES
      email_prefix ||= :athlete

      _make_users(Random.random(min_count, max_count), :athlete, email_prefix) do |user|
        yield user if block_given?
        MakeAthleteLogs.make_athlete_logs(user.athlete_story)
      end
    end

    def make_athlete_setters
      make_athletes(MIN_ATHLETE_SETTERS, MAX_ATHLETE_SETTERS, :athlete_setter) do |user|
        user.add_role(:setter)
        MakeSetterLogs.make_setter_logs(user.setter_story)
      end
    end

    def make_setter_athletes
      make_setters(MIN_SETTER_ATHLETES, MAX_SETTER_ATHLETES, :setter_athlete) do |user|
        user.add_role(:athlete)
        MakeAthleteLogs.make_athlete_logs(user.athlete_story)
      end
    end

    private

    def _make_users(count, role = nil, email_prefix = nil, include_name = nil)
      email_prefix ||= role || 'user'
      count.times do |num|
        user = User.new( email: "#{email_prefix}#{num}@example.com",
                         password: "password#{num}",
                         password_confirmation: "password#{num}")
        unless include_name == :never
          user.name = make_name if [true, false].sample or include_name == :always
        end
        user.save!
        user.add_role(role) if role
        yield user if block_given?
      end
    end

    def make_name(first = nil, last = nil)
      unless first or last
        first = Faker::Name.first_name
        last = Faker::Name.last_name
      end
      User::Name.create!(first: first, last: last)
    end

  end
end
