$(function(){
    var userEvents = [];

    function pageLoad(){
        $('#external-events').find('div.external-event').each(function() {

            // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
            // it doesn't need to have a start or end
            var eventObject = {
                title: $.trim($(this).text()) // use the element's text as the event title
            };

            // store the Event Object in the DOM element so we can get to it later
            $(this).data('eventObject', eventObject);

            // make the event draggable using jQuery UI
            $(this).draggable({
                zIndex: 999,
                revert: true,      // will cause the event to go back to its
                revertDuration: 0  //  original position after the drag
            });

        });


        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();



        var $calendar = $('#calendar').fullCalendar({
            header: {
                left: '',
                center: '',
                right: ''
            },

            selectable: true,
            selectHelper: true,
            select: function(start, end, allDay) {
                var $modal = $("#edit-modal"),
                    $btn = $('#create-event');
                $btn.off('click');
                $btn.click(function () {
                    var title = $("#event-name").val();

                    // var requestStart = start.utc().toDate();
                    // var requestEnd = end.utc().toDate();

                    if (title) {
                        var startSel = $("#startTimeSelector").val();
                        var endSel = $("#endTimeSelector").val();
                        var userStart = new Date(start.year(), start.month(), start.date(), parseInt(startSel)).getTime();
                        var userEnd = new Date(end.year(),
                                            end.month(),
                                            start.date(),
                                            parseInt(endSel)).getTime();
                        var serverEvent = new ServerEvent(title, userStart,
                            userEnd, null, false);
                        serverEvent.createEvent();
                        $calendar.fullCalendar('renderEvent',
                            {
                                title: title,
                                start: start,
                                end: end,
                                allDay: allDay,
                                backgroundColor: '#79A5F0',
                                textColor: '#fff'
                            },

                            true
                        );
                    }
                    $calendar.fullCalendar('unselect');
                });
                $modal.modal('show');
                $calendar.fullCalendar('unselect');
            },
            editable: true,
            droppable:true,

            drop: function(date, allDay) { // this function is called when something is dropped

                // retrieve the dropped element's stored Event Object
                var originalEventObject = $(this).data('eventObject');

                // we need to copy it, so that multiple events don't have a reference to the same object
                var copiedEventObject = $.extend({}, originalEventObject);

                // assign it the date that was reported
                copiedEventObject.start = date;
                copiedEventObject.allDay = allDay;

                var $categoryClass = $(this).data('event-class');
                if ($categoryClass)
                    copiedEventObject['className'] = [$categoryClass];

                // render the event on the calendar
                // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
                $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

                $(this).remove();

            },

            // Event array from server
            events: userEvents,
            eventClick: function(event) {
                var dateStart = event.start.toDate();
                var dateEnd = event.end.toDate();
                // debugger
                // opens events in a popup window
                if (event.url){
                    window.open(event.url, 'gcalevent', 'width=700,height=600');
                    return false
                } else {
                    var $modal = $("#editModal"),
                        $modalLabel = $("#editModalLabel");
                    $modalLabel.html(event.title);
                    $modal.find("#eventDescription").html(function(){
                        if (event.allDay){
                            return "All day event"
                        } else {
                            return "Start At: <strong>" + dateStart.getHours() + ":" + (dateStart.getMinutes() == 0 ? "00" : dateStart.getMinutes()) + "</strong></br>"
                                + (dateEnd == null ? "" : "End At: <strong>" + dateEnd.getHours() + ":" + (dateEnd.getMinutes() == 0 ? "00" : dateEnd.getMinutes()) + "</strong>")
                        }
                    }());
                    $modal.modal('show');
                }
            }


        });

        $("#calendar-switcher").find("label").click(function(){
            $calendar.fullCalendar( 'changeView', $(this).find('input').val() )
        });

        var currentDate = $calendar.fullCalendar('getDate');

        $('#calender-current-date').html(
                moment(currentDate).format("YYYY/MM/DD") +
                " - <span class='fw-semi-bold'>" +
                moment(currentDate).format("dddd") +
                "</span>"
        );


        $('#calender-prev').click(function(){
            $calendar.fullCalendar( 'prev' );
            currentDate = $calendar.fullCalendar('getDate');
            $('#calender-current-date').html(
                    $.fullCalendar.formatDate(currentDate, "MMM yyyy") +
                    " - <span class='fw-semi-bold'>" +
                    $.fullCalendar.formatDate(currentDate, "dddd") +
                    "</span>"
            );
        });
        $('#calender-next').click(function(){
            $calendar.fullCalendar( 'next' );
            currentDate = $calendar.fullCalendar('getDate');
            $('#calender-current-date').html(
                    $.fullCalendar.formatDate(currentDate, "MMM yyyy") +
                    " - <span class='fw-semi-bold'>" +
                    $.fullCalendar.formatDate(currentDate, "dddd") +
                    "</span>"
            );
        });
    }


    function getEvents () {
            var urlId = $(".widget-calendar").attr('id');
            $.ajax({
                url: '/users/' + urlId + '/events',
                type: 'GET',
                dataType: 'JSON',
                data: null,
            })
            .done(function(response) {
                response.forEach(function(index, el) {
                    // debugger
                    var eventObject = {
                        title: index.title,
                        start: moment(index.start_time),
                        end: moment(index.end_time),
                        allDay: false,
                        backgroundColor: '#64bd63',
                        textColor: 'fff'
                    };
                    // debugger
                    // eventObject.start.toDate();
                    // eventObject.end.toDate();
                    userEvents.push(eventObject);

                });
                console.log("success" + userEvents);
            })
            .fail(function() {
                console.log("error");
            })
            .always(function() {
                pageLoad();
                SingApp.onPageLoad(pageLoad);
                console.log("complete");
                console.log(userEvents);
            });
        };
        getEvents();

});