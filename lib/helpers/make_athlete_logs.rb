require_relative "random_record"

module MakeAthleteLogs

  MAX_ATHLETE_CLIMB_LOGS = 10
  MIN_ATHLETE_CLIMB_LOGS = 1

  SET_TO_NOT_SET_RATIO = (3 + 1) # going straight to Random.rand, so need to add 1

  class << self
    def make_athlete_log(athlete_story, setter_climb_log = nil)
      log = athlete_story.athlete_climb_logs.build(
                                              note: Faker::Hipster.sentences,
                                              project: [true, false].sample,
                                              quality_rating: rand(6) + 1)
      log.setter_climb_log = setter_climb_log if setter_climb_log
      log.save!
    end

    def make_athlete_logs(athlete_story)
      setter_climb_logs_count = SetterClimbLog.count
      Random.random(MIN_ATHLETE_CLIMB_LOGS, MAX_ATHLETE_CLIMB_LOGS).times do
        setter_climb_log = RandomRecord.random_record(SetterClimbLog, setter_climb_logs_count, SET_TO_NOT_SET_RATIO) if setter_climb_logs_count > 0
        MakeAthleteLogs.make_athlete_log(athlete_story, setter_climb_log)
      end
    end
  end
end
