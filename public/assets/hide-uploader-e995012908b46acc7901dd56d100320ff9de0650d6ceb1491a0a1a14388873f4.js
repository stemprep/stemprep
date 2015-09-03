$(document).ready(function() {
  $(".sub-doc").hide();
  var UploadModule = {
    init: function () {
      this.cacheDom();
      this.bindEvents();
    },
    cacheDom: function () {
      this.$uploadInput = $(".file-up");
      this.$uploadForm = $("#uploadForm");
      this.$submit = $(".sub-doc");
      this.$amazonUrl = $(".amazon-var-url").html();
      this.$amazonHost = $(".amazon-var-host").html();
      this.$amazonFields = $(".amazon-var-fields").html();
    },
    bindEvents: function () {
      this.$uploadInput.on('click', this.showSubmit.bind(this));
      this.$uploadForm.on('submit', this.uploadFile.bind(this));
    },
    showSubmit: function () {
      this.$submit.toggle();
    },
    uploadFile: function (event) {
      event.preventDefault();
      var self = this;
      var fileInput = $('.file-up');
      var postUrl = self.$amazonUrl;
      var postFormData = self.$amazonFields;
      this.$uploadForm.fileupload({
        fileInput: fileInput,
        url: postUrl,
        type: 'POST',
        autoUpload: true,
        formData: postFormData,
        paramName: 'file',
        dataType: 'XML',
        replaceFileInput: false,

        start: function (e) {
        // submitButton.prop('disabled', true);
        console.log('started');

        // progressBar.
          // css('background', 'green').
          // css('display', 'block').
          // css('width', '0%').
          // text("Loading...");
      },

      done: function(e, data) {
        // submitButton.prop('disabled', false);
        // progressBar.text("Uploading done");
        console.log('done');
        console.log(data);
        debugger
        // extract key and generate URL from response
        var key   = $(data.jqXHR.responseXML).find("Key").text();
        var url   = self.$amazonHost + '/' + key;

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
    }


  }

 UploadModule.init();
});


//     fileInput.fileUpload({
//       fileInput: fileInput,
//       url: '<%= @s3_direct_post.url %>',
//       type: 'POST',
//       autoUpload: true,
//       formData: <%= @s3_direct_post.fields.to_json.html_safe %>,
//       paramName: 'file',
//       dataType: 'XML',
//       replaceFileInput: false
//       progressall: function (e, data) {
//         var progress = parseInt(data.loaded / data.total * 100, 10);
//         progressBar.css('width', progress + '%')
//       },
//       start:
