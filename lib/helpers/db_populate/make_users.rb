require_relative "make_setter_logs"
require_relative "make_athlete_logs"

module MakeUsers

  class << self
    def make_users
      make_new_users
      make_setters
      make_athletes
      make_athlete_setters # current_role = athlete
      make_setter_athletes # current_role = setter
    end

    def make_new_users
      _make_users(num_new_users, nil, nil, :never)
    end

    def make_setters(count = num_setters, email_prefix = :setter)
      _make_users(count, :setter, email_prefix) do |user|
        MakeSetterLogs.make_setter_logs(user.setter_story)
        yield user if block_given?
      end
    end

    def make_athletes(count = num_athletes, email_prefix = :athlete)
      _make_users(count, :athlete, email_prefix) do |user|
        yield user if block_given?
        MakeAthleteLogs.make_athlete_logs(user.athlete_story)
      end
    end

    def make_athlete_setters
      make_athletes(num_athlete_setters, :athlete_setter) do |user|
        user.add_role(:setter)
        MakeSetterLogs.make_setter_logs(user.setter_story)
      end
    end

    def make_setter_athletes
      make_setters(num_setter_athletes, :setter_athlete) do |user|
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

    def num_new_users
      Random.random(5, 15)
    end

    def num_setters
      Random.random(10, 20)
    end

    def num_athletes
      Random.random(20, 50)
    end

    def num_athlete_setters
      Random.random(5, 10)
    end

    def num_setter_athletes
      Random.random(5, 10)
    end

  end
end
