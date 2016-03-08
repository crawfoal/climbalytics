# The Climbalytics object will hold all of the application wide functionality we build.
window.Climbalytics ||= {}

Climbalytics.init = ->
  # Initialize Bootstrap tooltips:
  $('[data-toggle="tooltip"]').tooltip()

$(document).on 'page:change', ->
  Climbalytics.init()
