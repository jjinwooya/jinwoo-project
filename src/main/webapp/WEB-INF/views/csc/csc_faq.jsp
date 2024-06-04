<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부기무비 FAQ</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/csc_faq.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/csc_sidebar.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<style>
	label + div p{
		line-height: 0.7;
	}
	label + div > p {
		margin-top: 3px;
	}
</style>
</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
</div>
<div class="container">
	<div class="row">
		<!-- 사이드바 영역 -->
		<div class="col-md-2">
			<jsp:include page="csc_sidebar.jsp"></jsp:include>		
		</div>
		<!-- content 영역 - FAQ -->
		<div class="col-md-10">
			<div class="row">
				<div id="csc_mainTitle">
					<h1>FAQ</h1>
				</div>
			<hr>
			</div>
			<!-- 검색창 -->
			<div class="row">
				<div class="csc_faq_search">
					<div class="inner">
						<form action="javascript:void(0);" method="get" name="search_faq" id="faqSearch">
							<label for="csc_faq_search">빠른검색</label>
							<input type="text" id="csc_faq_search" name="faqSearchKeyword" placeholder="검색어 입력">
							<input type="submit" value="검색">
						</form>
					</div>
				</div>
			</div>
			<!-- 검색창 끝 -->
			<!-- 구분 카테고리 시작 -->
			<div class="row mt-3">
				<div class="csc_faq_sel">
					<select id="faq_category" name="faq_category" class="form-select form-select-sm w-25">
						<option value="">전체</option>
						<option value="예매/결제" data-category="예매/결제">예매/결제</option>
						<option value="영화관이용" data-category="영화관이용">영화관이용</option>
						<option value="쿠폰" data-category="쿠폰">쿠폰</option>
						<option value="스토어" data-category="스토어">스토어</option>
						<option value="홈페이지/모바일" data-category="홈페이지/모바일">홈페이지/모바일</option>
					</select>
				</div>
			</div>
			<hr>
			<!-- 자주묻는 질문 게시판 -->
			<div class="csc_accordion" >
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${empty faqList }"> --%>
<!-- 						<div align="center">faq 게시물이 없습니다</div> -->
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<%-- 						<c:forEach var="faq" items="${faqList }" varStatus="status"> --%>
<%-- 							<input type="checkbox" id="answer${status.index + 1 }"> --%>
<%-- 							<label for="answer${status.index + 1}"><span class="faq_category">[${faq.faq_category}]</span> ${faq.faq_subject }<em></em></label> --%>
<!-- 							<div> -->
<!-- 								<span><em></em>ANSWER</span><br> -->
<%-- 								<p>${faq.faq_content }</p>  --%>
<!-- 							</div> -->
<%-- 						</c:forEach> --%>
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
			</div>
			<hr>
		</div>
	</div>
</div>
<!-- admin_footer.jsp -->
<div>
	<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
</div>
<script type="text/javascript">

let isLoading = false;
let isEmpty = false;
let pageNum = 1;
let index = 0;
let faqCategory = '';
let faqSearchKeyword = '';


function getScroll(newFaqCategory = "", isEmpty, faqSearchKeyword = "") {
	
	if (isLoading) return; // 이미 데이터를 불러오고 있는 중이라면 중복 요청 방지
	isLoading = true; // 데이터 요청 중 플래그 설정
	
    $.ajax({
        type: "GET",
        url: "csc_faq.json",
        data: {
            parsedPageNum: pageNum,
            faqCategory: newFaqCategory || faqCategory,
            faqSearchKeyword : faqSearchKeyword
        },
        dataType: "json",
        success: function(response) {
            let faqList = response;  // [{},{}]
            
//             for(let faq of faqList) {
// 	            console.log(JSON.stringify(faq));
// 				console.log(faq.faq_num);
// 				console.log(faq.faq_subject);
//             }
            
            
			//true면 기존 아코디언 비움
            if(isEmpty) {
				$(".csc_accordion").empty();
            }
			//반복문을 통해 ajax를 통해 받아온 값을 아코디언div에 전달
            $.each(faqList, function(i, faq) {
				let imgPath = "${pageContext.request.contextPath}/resources/images/cscBulb.png";
            	let faqNum = faq.faq_num; //faq_num 변수에 저장
                let accordion = $(".csc_accordion");
                let checkbox = $("<input>", {
                    type: "checkbox",
                    id: "answer" + (i + 1 + index)
                });
                let label = $("<label>", {
                    for: "answer" + (i + 1 + index),
                    "data-faqNum" : faqNum,
                    click: function() {
                    	updateView(faqNum);
                    }
                }).append(
                    $("<span>", {
                        class: "faq_category",
                        text: "[" + faq.faq_category + "]"
                    }),
                    $("<span>", {
                        text: faq.faq_subject
                    }),
                    $("<em>")
                );
                let answerDiv = $("<div>").append(
                    $("<span>").append(
                    	$("<em>", {
                    		class: "faq_blub"
                    	}),
                    	"ANSWER"
                    ),
                    $("<br>"),
                    faq.faq_content
                );
                
                accordion.append(checkbox, label, answerDiv);
            });
			
			isLoading = false; // 데이터 요청 완료 후 플래그 해제
			pageNum++;
			index += 7;
        },
        
        error: function() {
            alert("불러오는데 실패했습니다");
        }
    });
}
//read_count 증가시키는 ajax & 쿠키 전달받기
function updateView(faqNum) {
	$.ajax({
		type: "GET",
		url: "faqViewCount",
		data: {
			faq_num: faqNum
		},
		dataType: "json",
		success: function(response) {
		},
		error: function() {
			alert("호출 실패!");
		}
	});
}


$(function() {
	//초기 로딩
    getScroll("", false, "");
    
    $("#faq_category").change(function() {
        let newFaqCategory = $(this).val();
        faqCategory = newFaqCategory || ""; // faqCategory 업데이트
        
        pageNum = 1;
        faqSearchKeyword = '';
        getScroll(newFaqCategory, true, faqSearchKeyword);
        $("#csc_faq_search").val("");
    });
    
    $(document).scroll(function() {
        let currentScroll = $(this).scrollTop();
        let documentHeight = $(document).height();
        let windowHeight = $(window).height();
        let nowHeight = currentScroll + windowHeight;
        let bottom = 20; //딱 맞게 scroll바가 아래로 가지 않아도 ajax 호출하도록
    	
        // 화면 하단까지 스크롤되었을 때 추가 데이터 가져오기
		if (currentScroll >= documentHeight - windowHeight - bottom) {
			console.log("스크롤 이벤트 발생 - pageNum = " + pageNum);
			
			getScroll(faqCategory, false, faqSearchKeyword); // 스크롤 이벤트 발생 시 getScroll() 함수 호출
        }
    });
    
    $("#faqSearch").submit(function() {
    	faqSearchKeyword = $("#csc_faq_search").val();
//     	console.log(faqSearchKeyword);
		pageNum = 1;
    	getScroll('', true, faqSearchKeyword);
    });
    
});

</script>
</body>
</html>