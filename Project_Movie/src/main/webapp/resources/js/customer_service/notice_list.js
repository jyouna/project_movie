$(function () {
    // 제목 클릭 이벤트
    $(".notice_subject").on("click", function (event) {
        let notice_code = $(event.target).siblings(".notice_code").text();
        console.log("siblings " + notice_code);
        location.href = "NoticePost?notice_code=" + notice_code + "&pageNum=${pageInfo.pageNum}";
    }); // 제목 클릭 이벤트 종료

    // 검색 버튼 클릭 이벤트 
//    $("#search-bar input[type=button]").click(function () {
//        if ($("#search-bar>input[type=text]").val() == "") {
//            alert("검색어를 입력해주세요");
//        } else {
//            $.ajax({
//                type: "GET",
//                url: "notice",
//                data: {
//                    howsearch: $(".search_box").val(),
//                    searchKeyword: $("#search-bar>input[type=text]").val()
//                },
//                dataType: "json", 
//                success: function (NoticeList) {
//                    $("listForm").hide();
//                    $("table").html(
//                        "<tr>"
//                        + "<th>번호</th>"
//                        + "<th>제목</th>"
//                        + "<th>등록일</th>"
//                        + "<th>조회수</th>"
//                        + "</tr>"
//                    );
//                    if (NoticeList[0] == null) {
//                        $("table").append(
//                            "<tr>"
//                            + "<th colspan='4'> 검색 결과가 없습니다.<br>"
//                            + "</tr>"
//                        );
//                    } else {
//                        for (let notice of NoticeList) {
//                            $("table").append(
//                                "<tr>"
//                                + "<td>" + notice.notice_code + "</td>"
//                                + "<td>" + notice.subject + "</td>"
//                                + "<td>" + notice.regis_date + "</td>"
//                                + "<td>" + notice.view_count + "</td>"
//                                + "</tr>"
//                            );
//                        }
//                    }
//                },
//                error: function () {
//                    alert("검색에 실패했습니다.");
//                }
//            }); // AJAX 요청 종료
//        }
//    }); // 검색 버튼 클릭 이벤트 종료
}); // $(function) 종료

