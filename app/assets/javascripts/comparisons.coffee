$ ->
  if $('.new_comparison input[type=radio]:checked').length > 0
    $('.new_comparison input[type=submit]').prop('disabled', false)
  $('.new_comparison input[type=radio]').change ->
    $('.new_comparison input[type=submit]').prop('disabled', false)
