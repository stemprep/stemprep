var UserProfile = {
  init: function () {
    $(".edit-input").hide();
    $(".edit-user-profile").on('click', this.toggleInputs.bind(this));
  },
  toggleInputs: function () {
    $(".edit-user-profile").toggle();
    $(".info-data").fadeToggle('400');
    $(".edit-input").fadeToggle('400');
  }
}