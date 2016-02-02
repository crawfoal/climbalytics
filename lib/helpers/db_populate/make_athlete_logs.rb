module MakeAthleteLogs

  class << self
    def make_athlete_log(athlete_story, setter_climb_log = nil)
      log = athlete_story.athlete_climb_logs.build(note: note,
                                                   project: project,
                                                   quality_rating: quality_rating)
      log.setter_climb_log = setter_climb_log if setter_climb_log
      log.save!
    end

    def make_athlete_logs(athlete_story)
      setter_climb_logs_count = SetterClimbLog.count
      num_logs_per_athlete_story.times do
        if setter_climb_logs_count > 0 and associate_with_setter_log?
          setter_climb_log = SetterClimbLog.random(setter_climb_logs_count)
        end
        MakeAthleteLogs.make_athlete_log(athlete_story, setter_climb_log)
      end
    end

    private

    def note
      Faker::Hipster.sentences
    end
    def project
      [true, false].sample
    end
    def quality_rating
      rand(6) + 1
    end

    def associate_with_setter_log?
      rand(4) == 0
    end
    def num_logs_per_athlete_story
      Random.random(1, 10)
    end
  end
end
