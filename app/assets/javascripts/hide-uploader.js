$(document).ready(function () {
  $("#upload-form").hide();
  $("#upload-button").on("click", function  (event) {
    event.preventDefault();
    $(this).hide();
    $("#documents-header").hide();
    $("#upload-form").slideToggle();
  });


  $("#close-upload").on("click", function (event) {
    event.preventDefault();
    $("#upload-form").slideToggle();
    $("#documents-header").toggle();
    $("#upload-button").toggle();
  });
  $(".sub-doc").toggle();
  $(".vis-label").click(function(event) {
    $(".sub-doc").fadeIn('fast');
  });

  $(".directUpload").on('submit', function(event) {
    event.preventDefault();
    var theFile = $(".file-up");
    // debugger
    // console.log($(".file-up").files[0]);
    });


});