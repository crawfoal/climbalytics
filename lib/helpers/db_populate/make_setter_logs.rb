module MakeSetterLogs

  class << self
    def make_setter_log(setter_story)
      setter_story.setter_climb_logs.create!(note: Faker::Hipster.sentences)
    end
    def make_setter_logs(setter_story)
      num_logs_per_setter_story.times do
        MakeSetterLogs.make_setter_log(setter_story)
      end
    end

    private

    def num_logs_per_setter_story
      Random.random(1, 5)
    end
  end
end
