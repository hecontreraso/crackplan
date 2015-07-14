// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var ready;
ready = function() {

	$(".join_event").click(function(){

		var join_button = $(event.target);
		var id = join_button.closest("article").attr("id");
	   
    $.post("/events/" + id + "/join", function(data, status){

			if($("#is_current_user_profile").text() == "true"){
							console.log("same profile");
				if (data.state_changed == "changed"){
					$("#" + id).remove();
				}
    	}
    	else if (data.state_changed == "changed"){
    					console.log("other profile");
				if( join_button.text() == "Going" ){
					join_button.text("Join");
				}
				else{
					join_button.text("Going");	
				}
			}

    }, "json");

	});

};

$(document).ready(ready);
$(document).on('page:load', ready);
