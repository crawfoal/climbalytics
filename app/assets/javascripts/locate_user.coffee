# This needs a different name. It encapsulates the behavior of updating the users current location, and reloading the nearby gyms. So maybe it needs to be split into two classes.
class Climbalytics.GymPicker
  constructor: (@button) ->
    @refreshIcon = @button.find('.fa-refresh')
    @enclosingElement = $('.gym-picker .section-body')
    @geolocator = new Climbalytics.Geolocator(@reloadPartial, @removeLoadingStyles)

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

$(document).on 'page:change', ->
  $('.gym-picker').on 'click', '[data-behavior~=locate-user]', (e) ->
    e.preventDefault()
    gymPicker = new Climbalytics.GymPicker $(this)
    return if gymPicker.isLoading()
    gymPicker.applyLoadingStyles()
    gymPicker.geolocator.run()
