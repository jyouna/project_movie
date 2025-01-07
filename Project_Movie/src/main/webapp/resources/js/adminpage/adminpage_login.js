function adminLogout() {
	if(confirm("로그아웃 하시겠습니까?")) {
		$.ajax({
			type : "GET",
			url : "AdminLogout",
			success : function(response){
				if(response) {
					window.close();
				}  else {
                    alert("로그아웃 오류");
                }
			} 
		});
	}
}