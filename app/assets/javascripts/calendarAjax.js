var ServerEvent = function (title, startTime, endTime, url, allDay) {
  var self = this;
  self.title = title;
  self.start_time = startTime;
  self.end_time = endTime;
  self.url = "no url";
  self.all_day = allDay;

  function formatUtcDate (date) {
    return moment(date).utc().toDate();
  }
};

ServerEvent.prototype.createEvent = function() {
  var self = this;
  $.ajax({
    url: '/users/' + $(".widget-calendar").attr('id') + '/events',
    type: 'POST',
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    data:
    {
      event:
        {
          title: self.title,
          start_time: self.start_time,
          end_time: self.end_time,
          url: self.url,
          all_day: JSON.stringify(false)
        }
      }
  })
  .done(function() {
    console.log("success");
  })
  .fail(function() {
    console.log("error");
    // show an error modal
  })
  .always(function() {
    console.log("complete");
  });

};

