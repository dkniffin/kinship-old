# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#life_event_marriage_person_1_id').change ->
    val = $(this).find("option:selected").attr("value");
    if (val == 'new')
      $('#person_1_new_person_fields').show()
    else
      $('#person_1_new_person_fields').hide()

  $('#life_event_marriage_person_2_id').change ->
    val = $(this).find("option:selected").attr("value")
    if (val == 'new')
      $('#person_2_new_person_fields').show()
    else
      $('#person_2_new_person_fields').hide()
