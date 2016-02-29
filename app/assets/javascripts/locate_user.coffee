locateUserElement = ->
  $('[data-behavior~=locate-user]')

geolocSuccess = (position) ->
  user = {
    current_location_attributes: {
      latitude: position.coords.latitude,
      longitude: position.coords.longitude
    }
  }
  $.ajax({
    type: 'PATCH',
    url: Routes.user_path() + '.json',
    contentType: 'application/json',
    data: JSON.stringify({user: user})
    }).done (message) ->
      alert("We've found you!")
      console.log(message)

geolocError = ->
  "Geolocation failed"

getPosition = ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition geolocSuccess, geolocError
  else
    "Geolocation not supported"

$(document).on 'page:change', ->
  locateUserElement().click ->
    getPosition()
