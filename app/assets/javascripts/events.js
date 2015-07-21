// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready;
ready = function() {

	$('#event_time').timepicker({ 'minTime': '5:00am', 'maxTime': '11:00pm' });

	$(".join_event").click(function(){

		var join_button = $(event.target);
		var id = join_button.closest("article").attr("id");
    
    $.post("/events/" + id + "/toggle_assistance", function(data, status){
    	join_button.text(data.returned_state);    
    }, "json");
	});

};

$(document).ready(ready);
$(document).on('page:load', ready);
