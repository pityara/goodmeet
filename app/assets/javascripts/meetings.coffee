jQuery ->
  $('#meeting_date').datepicker({ dateFormat: 'dd-mm-yy' }).val()
jQuery ->
  $('.deleteAction').click ->
    current_meeting = $(this).parents('div');
    if(confirm("Точно удалить?"))
      $.ajax({
        url: '/meetings/' + $(current_meeting).attr('data-meeting_id'),
        type: 'POST',
        data: { method: 'DELETE' },
        success: ->
          $(current_meeting).fadeOut(200);
      });
