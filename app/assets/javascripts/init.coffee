# The Climbalytics object will hold all of the application wide functionality we build.
window.Climbalytics ||= {}

Climbalytics.init = ->
  console.log('')

$(document).on 'page:change', ->
  Climbalytics.init()
