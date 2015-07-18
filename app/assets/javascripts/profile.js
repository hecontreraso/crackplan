// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready;
ready = function() {

	$(".join_event").click(function(){

		var join_button = $(event.target);
		var id = join_button.closest("article").attr("id");
	   
    $.post("/events/" + id + "/toggle_assistance", function(data, status){

			if($("#is_current_user_profile").text() == "true"){
				if (data.returned_state == "Join"){
					$("#" + id).remove();
				}
    	}
    	else{
    		join_button.text(data.returned_state);
    	} 

    }, "json");
	});

	$("#follow").click(function(){

		var id = $("#user_id").text();
    $.post("/profile/" + id + "/toggle_follow", function(data, status){
    	$("#follow").text(data.returned_state);
    }, "json");

	});

};

$(document).ready(ready);
$(document).on('page:load', ready);
