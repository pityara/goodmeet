$(document).on 'turbolinks:load', ->
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    current_comment = $(this).parents('.comment')[0]
    $(current_comment).fadeOut(200);
