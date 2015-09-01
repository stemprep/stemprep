$(".forum-post-link").on('click', function(event) {
  event.preventDefault();
  var url = $(this).attr('href');
  $.ajax({
    url: this.url,
    type: 'GET',
    data: {hello: 'hi'},
  })
  .done(function(response) {
    console.log("success");
    $("#content").children().each(function(index, el) {
    $(el).fadeToggle('slow', function() {
      debugger
    });
  });
    debugger
  })
  .fail(function() {
    console.log("error");
  })
  .always(function() {
    console.log("complete");
  });

});