$(function () {
  $(".edit-input").hide();
  $(".edit-user-profile").click(function(event) {
    event.preventDefault();
    $(this).toggle();
    $(".info-data").fadeToggle('400');
    $(".edit-input").fadeToggle('400');

    // $(".submit-edit").click(function(event) {
    //   $(".edit-input").fadeToggle('400');
    //   $(".info-data")fadeToggle('400');
    // });
  });



});