$(function() {
	$.ajax({
		type : "GET",
		url : "BookTickets",
		data : {
			movie_status : "상영예정작"
		}
	}).done(function(data) {
		console.log(data);
	}).fail(function() {
		
	});
	
	
	
});







