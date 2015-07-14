// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready;
ready = function() {

	// Shared methods with profile
	$("a[data-remote]").on("ajax:success", function(event, data, status, xhr){
		if( $(event.target).text() == "Going" ){
			$(event.target).text("Join");
		}
		else{
			$(event.target).text("Going");	
		}
	});

	$("a[data-remote]").on("ajax:error", function(event, data, status, xhr){
		alert("error");
	});	

};

$(document).ready(ready);
$(document).on('page:load', ready);
