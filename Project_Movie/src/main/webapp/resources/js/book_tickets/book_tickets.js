$(function() {
	$.ajax({
		type : "GET",
		url : "BookTickets",
		data : {
			
		}
	}).done(function(data) {
		console.log(data);
		$(".mv_list_container").html(
			
		);
	}).fail(function() {
		
	});
	
	
	
});







