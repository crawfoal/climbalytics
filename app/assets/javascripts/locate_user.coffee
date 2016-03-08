# This needs a different name. It encapsulates the behavior of updating the users current location, and reloading the nearby gyms. So maybe it needs to be split into two classes.
class GymPicker
  constructor: (@button) ->
    @refreshIcon = @button.find('.fa-refresh')
    @enclosingElement = $('.gym-picker .section-body')
    @geolocator = new Geolocator(@reloadPartial, @removeLoadingStyles)

  isLoading: =>
    if @button.hasClass('disabled')
      return true
    else
      return false

  applyLoadingStyles: =>
    @button.addClass('disabled')
    if @refreshIcon.length == 0
      @button.append('<i class="fa fa-refresh fa-lg fa-spin pull-right"></i>')
    else
      @refreshIcon.addClass('fa-spin')

  removeLoadingStyles: =>
    @button.removeClass('disabled')
    @refreshIcon.removeClass('fa-spin')

  reloadPartial: =>
    $.get(Routes.gym_picker_path(), (result) =>
      @enclosingElement.html(result)
      console.log('Nearby gyms updated at ' + Date($.now))
    )

# As this is used more, we might want/need to change the callbacks and what is built into the success and error methods.
class Geolocator
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

$(document).on 'page:change', ->
  $('.gym-picker').on 'click', '[data-behavior~=locate-user]', (e) ->
    e.preventDefault()
    gymPicker = new GymPicker $(this)
    return if gymPicker.isLoading()
    gymPicker.applyLoadingStyles()
    gymPicker.geolocator.run()
