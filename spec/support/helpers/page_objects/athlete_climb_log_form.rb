class AthleteClimbLogForm
  include Capybara::DSL

  def initialize
  end

  def mark_as_boulder
    climb_type_radios.find('label[for="athlete_climb_log_climb_attributes_type_boulder"]').click
  end

  def climb_type_marked_as? type
    climb_details_section.find('label.active').has_content? type
  end

  def gym_section_preset_to? gym_section_name
    climb_details_section.has_select?(
      "athlete_climb_log[climb_attributes][gym_section_id]",
      selected: gym_section_name
    )
  end

  def climb_type_preset_to? climb_type
    climb_type ||= ''
    climb_details_section.find('label.active').has_content? climb_type
  end

  def climb_grade_preset_to? climb_grade
    climb_grade ||= ''
    climb_details_section.has_select?(
      "athlete_climb_log[climb_attributes][grade]",
      selected: climb_grade
    )
  end

  def has_these_climb_field_presets? climb_attributes
    gym_section_name = GymSection.find(climb_attributes['gym_section_id']).name
    climb_type = climb_attributes['type']
    climb_grade = climb_type.constantize.grades.key(climb_attributes['grade']) if climb_type

    gym_section_preset_to?(gym_section_name) and
      climb_type_preset_to?(climb_type) and
      climb_grade_preset_to?(climb_grade)
  end

  private

  def form_element
    find 'form[id*=athlete_climb_log]'
  end

  def climb_details_section
    form_element.find('section.climb-details')
  end

  def climb_type_radios
    find('.climb-type')
  end
end
