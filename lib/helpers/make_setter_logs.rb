module MakeSetterLogs

  MAX_SETTER_CLIMB_LOGS = 5
  MIN_SETTER_CLIMB_LOGS = 1

  class << self
    def make_setter_log(setter_story)
      setter_story.setter_climb_logs.create!(note: Faker::Hipster.sentences)
    end
    def make_setter_logs(setter_story)
      Random.random(MIN_SETTER_CLIMB_LOGS, MAX_SETTER_CLIMB_LOGS).times do
        MakeSetterLogs.make_setter_log(setter_story)
      end
    end
  end
end
