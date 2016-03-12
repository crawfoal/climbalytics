$(document).on 'page:change', ->
  $('#climb_seshes_index_table .delete [data-remote]').on 'ajax:success', (event) ->
    $(this).closest('tr').remove()
    Climbalytics.getFlash(
      alert_style: 'success',
      message: 'Sesh successfully deleted.'
    ).done (result) =>
      $('.page-content').before(result)

  if $('#climb_seshes_index_table tr').length == 1
    $('a.add_fields').trigger 'click'
