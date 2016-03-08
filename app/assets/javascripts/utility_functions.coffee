@getFlash = (flash_options) ->
  $.get(
    Routes.flash_path(),
    flash_options
  )

@updateUserRecord = (user_attributes) ->
  $.ajax({
    type: 'PATCH',
    url: Routes.user_path() + '.json',
    contentType: 'application/json',
    data: JSON.stringify({user: user_attributes})
  })
