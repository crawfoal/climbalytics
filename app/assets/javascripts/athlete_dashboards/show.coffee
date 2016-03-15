updateClimbLinks = (routePicker) ->
  selectedSectionID = routePicker.find('select[id$="gym_section_id"]').val()
  $.get Routes.climbs_path(), { in_section: selectedSectionID, with_type: 'SetterClimbLog' }, (response) ->
    routePicker.find('.climb-links').html(response)

$(document).on 'page:change', ->
  $('.log-a-climb .start').on 'click', 'button', ->
    $(this).slideUp()
    $(this).closest('.log-a-climb').find('.gym-picker').slideDown()

  $('.nearby-gyms').on 'click', '.gym-link', ->
    gymPicker = $(this).closest('.gym-picker')
    gymPicker.slideUp()
    routePicker = gymPicker.closest('.log-a-climb').find('.route-picker')
    gymID = $(this).data('gym-id')
    $.get Routes.route_picker_path(gymID), (response)->
      routePicker.find('.section-body').html(response)
      updateClimbLinks(routePicker)
    routePicker.slideDown()

  routePicker = $('.route-picker')
  routePicker.on 'change', 'select[id$="gym_section_id"]', ->
    updateClimbLinks(routePicker)
  routePicker.on 'click', '.loggable-link', (event) ->
    if $(this).attr('href') == Routes.new_athlete_climb_log_path()
      event.preventDefault()
      routePicker.find('#athlete_climb_log_setter_climb_log_id').val(
        $(this).data('slog-id')
      )
      routePicker.find('input[type="submit"]').trigger('click')
