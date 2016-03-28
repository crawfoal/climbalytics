$(document).on 'page:change', ->
  flash = $('[class^="flash"]')
  flash.on 'click', 'button.close', ->
    flash.slideUp()
