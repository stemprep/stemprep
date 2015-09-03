$(".forum-post-link").on('click', function(event) {
  event.preventDefault();
  var sendUrl = $(this).attr('id');
  // debugger
  $.ajax({
    url: sendUrl,
    method: 'get',
  })
  .done(function(response) {
    var postTemplate = response;
    $(".content-wrap").addClass('stop-scroll');
    $(".attachPost").after(postTemplate);
    $("#forum-modal").css({
      display:'block',
      opacity:'1'
    });
    // debugger
    // $(".forum-post-link").off();
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });

});
