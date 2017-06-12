jQuery ->
  $('#meeting_date').datepicker({ dateFormat: 'dd-mm-yy' }).val()
$(document).on 'turbolinks:load', ->
  $('.deleteAction').click ->
    current_meeting = $(this).parents('div')[0];
    if(confirm("Точно удалить?"))
      $.ajax({
        url: '/meetings/' + $(current_meeting).attr('data-meeting_id'),
        type: "DELETE",
        data: { method: 'DELETE' },
        success: (result) ->
          $(current_meeting).fadeOut(200);
          console.log(result)
      });
$(document).on 'turbolinks:load', ->
  $(document.body).on 'click', '.pagination a', ->
    $('.pagination').html 'Комментарии загружаются...'
    $.getScript @href
    false
