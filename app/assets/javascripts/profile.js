// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready;
ready = function() {

	$(".join_event").click(function(){

		var join_button = $(event.target);
		var id = join_button.closest("article").attr("id");
	   
    $.post("/events/" + id + "/toggle_assistance", function(data, status){

			if($("#is_current_user_profile").text() == "true"){
				if (data.state_changed == "changed"){
					$("#" + id).remove();
				}
    	}
    	else if (data.state_changed == "changed"){
				if( join_button.text() == "Going" ){
					join_button.text("Join");
				}
				else{
					joi_nbutton.text("Going");	
				}
			}

    }, "json");
	});

	$("#follow").click(function(){

		var follow_button = $(event.target);
		var id = $("#user_id").text)(;
	   
    $.post("/events/" + id + "/join", function(data, status){

			if($("#is_current_user_profile").text() == "true"){
				if (data.state_changed == "changed"){
					$("#" + id).remove();
				}
    	}
    	else if (data.state_changed == "changed"){
				if( follow_button.text() == "Going" ){
					follow_button.text("Join");
				}
				else{
					follow_button.text("Going");	
				}
			}

    }, "json");

    //ejecutar petición ajax para seguir a la persona. Si la respuesta es true, cambiar el texto de follow a unfollow

	});


};

$(document).ready(ready);
$(document).on('page:load', ready);
