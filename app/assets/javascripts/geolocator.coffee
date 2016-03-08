# As this is used more, we might want/need to change the callbacks and what is built into the success and error methods.
class Climbalytics.Geolocator
  constructor: (@success_callback, @error_callback) ->

  success: (position) =>
    @current_location =
      latitude: position.coords.latitude,
      longitude: position.coords.longitude
    updateUserRecord(current_location_attributes: @current_location)
    @success_callback()

  error: =>
    getFlash(
      alert_style: 'danger',
      message: 'We were not able to find your location. Either this webpage does not have permission to access your location, or your browser does not support geolocation.'
    ).done (result) =>
      $('.page-content').before(result)
    @error_callback()
    console.log("Geolocation failed at " + Date($.now) )

  run: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(@success, @error)
    else
      @error()
