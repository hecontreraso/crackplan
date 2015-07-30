// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready;
ready = function() {
	datepickr('#event_date', { minDate: new Date() });

	//Used to join an event
	$("#page-events .join_event").click(function(event){
		var join_button = $(event.target);
		var id = join_button.closest("article").attr("id");  

    $.post("/events/" + id + "/toggle_assistance", function(data, status){
    	join_button.text(data.returned_state);    
    }, "json");
	});

	//Used to accept a following request
	$("#page-events .accept-request").click(function(event){
		var accept_button = $(event.target);
		var id = accept_button.closest("article").attr("value");
    $.post("/profile/" + id + "/accept_request", function(data, status){
			accept_button.closest("article").remove();    
    }, "json");
	});

	//Used to decline a following request
	$("#page-events .decline-request").click(function(event){
		console.log("DECLINE REQUEST METHOD");
		var decline_button = $(event.target);
		var id = decline_button.closest("article").attr("value");
    
    $.post("/profile/" + id + "/decline_request", function(data, status){
			decline_button.closest("article").remove();    
    }, "json");
	});

	// This makes work the tooltip for "3 more" on event assistants
	$(function () {
	  $('[data-toggle="tooltip"]').tooltip({ html: true })
	});

};

$(document).ready(ready);
$(document).on('page:load', ready);
