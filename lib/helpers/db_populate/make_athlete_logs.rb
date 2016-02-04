module MakeAthleteLogs

  class << self
    def make_athlete_log(athlete_story, setter_climb_log = nil)
      log = athlete_story.athlete_climb_logs.create(note: note,
                                                    project: project,
                                                    quality_rating: quality_rating)
      log.setter_climb_log = setter_climb_log if setter_climb_log
      MakeClimbs.send("make_#{climb_type}", log)
      MakeClimbSeshes.make_climb_sesh(log)
      log.save!
      log
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
      a_third_of_the_time { Faker::Hipster.sentences }
    end
    def project
      [true, false].sample
    end
    def quality_rating
      half_of_the_time { rand(6) + 1 }
    end
    def climb_type
      [:boulder, :route].sample
    end
    def associate_with_setter_log?
      a_fourth_of_the_time { true }
    end
    def num_logs_per_athlete_story
      random_between(1, 10)
    end
  end
end
