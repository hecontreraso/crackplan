// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready;
ready = function() {

	$(".join_event").click(function(){

		var join_button = $(event.target);
		var id = join_button.closest("article").attr("id");
    
    $.post("/events/" + id + "/join", function(data, status){

			if (data.state_changed == "changed"){
				$("#" + id).remove();
			}
    
    }, "json");
	});




	// if($("#is_current_user_profile").text == true){
	// 	$("a[data-remote]").on("ajax:success", function(event, data, status, xhr){
	// 		var id = $(event.target).closest("article").attr("id");
	// 		console.log("Removing event: " + id + " from interface");
			
	// 	});

	// 	$("a[data-remote]").on("ajax:error", function(event, data, status, xhr){
	// 		alert("error");
	// 	});	
	// }

};

$(document).ready(ready);
$(document).on('page:load', ready);
