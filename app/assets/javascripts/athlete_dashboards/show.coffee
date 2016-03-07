$(document).on 'page:change', ->
  $('.log-a-climb .start').on('click', 'button', ->
    $(this).slideUp();
    $(this).closest('.log-a-climb').find('.gym-picker').slideDown();
  );
