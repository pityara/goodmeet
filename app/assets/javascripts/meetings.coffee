jQuery ->
  $('input#meeting_date').datepicker({ dateFormat: 'dd-mm-yy' }).val()
jQuery ->
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
