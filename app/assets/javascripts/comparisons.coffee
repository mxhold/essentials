$ ->
  if $('input[type=radio]:checked').length > 0
    $('input[type=submit]').prop('disabled', false)
  $('input[type=radio]').change ->
    $('input[type=submit]').prop('disabled', false)
