# This needs a different name. It encapsulates the behavior of updating the users current location, and reloading the nearby gyms. So maybe it needs to be split into two classes.
class GymPicker
  constructor: (@button) ->
    @refreshIcon = @button.find('.fa-refresh')
    @enclosingElement = $('.gym-picker .section-body')

  isLoading: ->
    if @button.hasClass('disabled')
      return true
    else
      return false

  applyLoadingStyles: ->
    @button.addClass('disabled')
    if @refreshIcon.length == 0
      @button.append('<i class="fa fa-refresh fa-lg fa-spin pull-right"></i>')
    else
      @refreshIcon.addClass('fa-spin')

  removeLoadingStyles: ->
    @button.removeClass('disabled')
    @refreshIcon.removeClass('fa-spin')

  update: ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(@geolocSuccess, @geolocError)
    else
      @geolocError()

  geolocSuccess: (position) =>
    updateUserRecord(current_location_attributes: {latitude: position.coords.latitude, longitude: position.coords.longitude})
    @reloadPartial()

  reloadPartial: =>
    $.get(Routes.gym_picker_path(), (result) =>
      @enclosingElement.html(result)
      console.log('Nearby gyms updated at ' + Date($.now))
    )

  geolocError: =>
    getFlash(
      alert_style: 'danger',
      message: 'We were not able to find your location. Either this webpage does not have permission to access your location, or your browser does not support geolocation.'
    ).done (result) =>
      $('.page-content').before(result)
    @removeLoadingStyles()
    console.log("Geolocation failed at " + Date($.now) )

getFlash = (flash_options) ->
  $.get(
    Routes.flash_path(),
    flash_options
  )

updateUserRecord = (user_attributes) ->
  console.log(user_attributes)
  $.ajax({
    type: 'PATCH',
    url: Routes.user_path() + '.json',
    contentType: 'application/json',
    data: JSON.stringify({user: user_attributes})
  })

$(document).on 'page:change', ->
  $('.gym-picker').on 'click', '[data-behavior~=locate-user]', (e) ->
    e.preventDefault()
    gymPicker = new GymPicker $(this)
    return if gymPicker.isLoading()
    gymPicker.applyLoadingStyles()
    gymPicker.update()
