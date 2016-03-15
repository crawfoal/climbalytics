module ClimbsHelper
  def path_to_edit_loggable_for(climb)
    method('edit_' + climb.loggable_type.underscore + '_path').call(climb.loggable)
  end

  def path_to_athlete_climb_log_for(climb)
    if climb.loggable_type == 'SetterClimbLog' and current_user.has_role? :athlete
      alog = current_user.athlete_story.athlete_climb_logs.where(setter_climb_log: climb.loggable).first
      if alog
        edit_athlete_climb_log_path(alog)
      else
        new_athlete_climb_log_path
      end
    elsif climb.loggable_type == 'AthleteClimbLog' and climb.loggable.athlete == current_user
      edit_athlete_climb_log_path(climb.loggable)
    else
      nil
    end
  end
end
