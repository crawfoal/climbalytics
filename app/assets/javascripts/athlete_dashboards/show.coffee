updateClimbLinks = (climbPicker) ->
  selectedSectionID = climbPicker.find('select[id$="gym_section_id"]').val()
  $.get Routes.climbs_path(), { in_section: selectedSectionID, with_type: 'SetterClimbLog' }, (response) ->
    climbPicker.find('.climb-links').html(response)

$(document).on 'page:change', ->
  $('.log-a-climb').on 'click', '.start', ->
    $(this).slideUp()
    $(this).closest('.log-a-climb').find('.gym-picker').slideDown()

  $('.gym-picker').on 'click', '.gym-link', ->
    gymPicker = $(this).closest('.gym-picker')
    gymPicker.slideUp()
    climbPicker = gymPicker.closest('.log-a-climb').find('.climb-picker')
    gymID = $(this).data('gym-id')
    $.get Routes.climb_picker_path(gymID), (response)->
      climbPicker.append(response)
      updateClimbLinks(climbPicker)
    climbPicker.slideDown()

  climbPicker = $('.climb-picker')
  climbPicker.on 'change', 'select[id$="gym_section_id"]', ->
    updateClimbLinks(climbPicker)
  climbPicker.on 'click', '.loggable-link', (event) ->
    if $(this).attr('href') == Routes.new_athlete_climb_log_path()
      event.preventDefault()
      climbPicker.find('#athlete_climb_log_setter_climb_log_id').val(
        $(this).data('slog-id')
      )
      climbPicker.find('input[type="submit"]').trigger('click')
