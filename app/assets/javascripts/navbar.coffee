$(document).on 'page:change', ->
  menuToggle = $('#js-mobile-menu').unbind()
  $('#js-navigation-menu').removeClass 'show'
  menuToggle.on 'click', (e) ->
    e.preventDefault()
    $('#js-navigation-menu').slideToggle ->
      if $('#js-navigation-menu').is(':hidden')
        $('#js-navigation-menu').removeAttr 'style'

  currentRoleSelect = $('select#user_current_role')
  $('ul.roles').on 'click', 'a', ->
    currentRoleSelect.val($(this).text())
    currentRoleSelect.closest('form').submit()
