module MakeClimbSeshes
  class << self
    def make_climb_sesh(athlete_climb_log)
      athlete_climb_log.climb_seshes.create!(high_hold: high_hold(athlete_climb_log.climb.moves_count),
                                            note: note)
    end

    def make_climb_seshes(athlete_climb_log)
      num_seshes_per_log.times { make_climb_sesh(athlete_climb_log) }
    end

    private

    def note
      half_of_the_time { Faker::Hipster.sentences }
    end
    def high_hold(total_num_moves = nil)
      half_of_the_time do
        if total_num_moves
          total_num_moves / ( rand(4) + 1 )
        else
          rand(26)
        end
      end
    end
    def num_seshes_per_log
      random_between(1, 20)
    end
  end
end
