// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready;
ready = function() {

	$("a[data-remote]").on("ajax:success", function(event, data, status, xhr){
		var id = $(event.target).closest("article").attr("id");
		console.log("Removing event: " + id + " from interface");
		$("#" + id).remove();
	});

	$("a[data-remote]").on("ajax:error", function(event, data, status, xhr){
		alert("error");
	});	

};

$(document).ready(ready);
$(document).on('page:load', ready);
