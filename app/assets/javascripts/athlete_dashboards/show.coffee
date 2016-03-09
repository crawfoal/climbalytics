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
    routePicker.slideDown()
