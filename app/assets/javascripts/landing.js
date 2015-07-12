var ready;
ready = function() {

	$('#event_time').timepicker({ 'minTime': '5:00am', 'maxTime': '11:00pm' });

};

$(document).ready(ready);
$(document).on('page:load', ready);
