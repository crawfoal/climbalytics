updateUser = (user) ->
  $.ajax({
    type: 'PATCH',
    url: Routes.user_path() + '.json',
    contentType: 'application/json',
    data: JSON.stringify({user: user})
    })

updateGymChoices = ->
  $.get(Routes.gym_picker_path(), (result) ->
    $('.gym-picker .section-body').html(result)
    console.log('Nearby gyms updated at ' + Date($.now))
  )

geolocSuccess = (position) ->
  updateUser({
    current_location_attributes: {
      latitude: position.coords.latitude,
      longitude: position.coords.longitude
    }
  })
  updateGymChoices()

showGeolocFailedFlash = ->
  $.get(
    Routes.flash_path(),
    {
      alert_style: 'danger',
      message: 'We were not able to find your location. Either this webpage does not have permission to access your location, or your browser does not support geolocation.'
    },
    (result) ->
      $('.page-content').before(result)
  )

geolocError = ->
  showGeolocFailedFlash()
  removeLoadingStyles()
  console.log("Geolocation failed at " + Date($.now) )

getPosition = ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition geolocSuccess, geolocError
  else
    geolocError()

isLoading = (geolocateButton) ->
  if geolocateButton.hasClass('disabled')
    return true
  else
    return false

addLoadingStyles = (geolocateButton) ->
  geolocateButton.addClass('disabled')
  refreshIcon = geolocateButton.find('.fa-refresh')
  if refreshIcon.length == 0
    geolocateButton.append('<i class="fa fa-refresh fa-lg fa-spin pull-right"></i>')
  else
    refreshIcon.addClass("fa-spin")

removeLoadingStyles = (geolocateButton) ->
  geolocateButton = $('.gym-picker [data-behavior~=locate-user]') if typeof geolocateButton == 'undefined'
  geolocateButton.removeClass('disabled')
  geolocateButton.find('.fa-refresh').removeClass('fa-spin')

$(document).on 'page:change', ->
  $('.gym-picker').on 'click', '[data-behavior~=locate-user]', (e) ->
    e.preventDefault()
    geolocateButton = $(this)
    return if isLoading(geolocateButton)
    addLoadingStyles(geolocateButton)
    getPosition()
