$(function () {
  $('.sub-doc').on('click', function(event) {
    event.preventDefault();

    var fileInput = $('.file-up');
    var form         = $(fileInput.parents('form:first'));
    var submitButton = form.find('input[type="submit"]');
    var progressBar  = $("<div class='bar'></div>");
    var barContainer = $("<div class='progress'></div>").append(progressBar);
    fileInput.after(barContainer);
    console.log(fileInput);

    fileInput.fileUpload({
      fileInput: fileInput,
      url: '<%= @s3_direct_post.url %>',
      type: 'POST',
      autoUpload: true,
      formData: <%= @s3_direct_post.fields.to_json.html_safe %>,
      paramName: 'file',
      dataType: 'XML',
      replaceFileInput: false
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        progressBar.css('width', progress + '%')
      },
      start: function (e) {
        submitButton.prop('disabled', true);
        console.log('started');

        progressBar.
          css('background', 'green').
          css('display', 'block').
          css('width', '0%').
          text("Loading...");
      },
      done: function(e, data) {
        submitButton.prop('disabled', false);
        progressBar.text("Uploading done");
        console.log('done');
        console.log(data);
        // extract key and generate URL from response
        var key   = $(data.jqXHR.responseXML).find("Key").text();
        var url   = '<%= s3_direct_post.url.host %>/' + key;

        // create hidden field
        var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
        form.append(input);
      },
      fail: function(e, data) {
        submitButton.prop('disabled', false);

        progressBar.
          css("background", "red").
          text("Failed");
      }
    });
    /* Act on the event */
  });
})