<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>일대일 문의 내역</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous">
</script>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<style type="text/css">
	.admin_csc_selectBox {
		display: flex;
		justify-content: space-around;
	}
	
	h3 {
		margin-left: 20px;
	}
	
	h1 {
		font-style: italic;
	}
	
	/* 테이블 css */
	.admin_ono_body > table {
	  border-collapse: collapse;
	  width: 90%;
	  margin: 0rem auto;
	  box-shadow: 4px 4px 10px 0 rgba(0, 0, 0, 0.1);
	  background-color: white;
	  text-align: center;
	}
	 /* 테이블 행 */
	th, td {
	  padding: 8px;
	  border-bottom: 1px solid #ddd;
	}
	
	th {
	  background-color: #1b1b1b;
	  color: #ddd;
	}
	
	/* 테이블 올렸을 때 */
	tbody tr:hover {
	  background-color: #eee;
	  opacity: 0.9;
	  cursor: pointer;
	}
	
	/* 테이블 비율 */
	th:nth-child(1),
	td:nth-child(1) {
	  width: 10%;
	}
	
	th:nth-child(2),
	td:nth-child(2) {
	  width: 10%;
	}
	
	th:nth-child(3),
	td:nth-child(3) {
	  width: 25%;
	}
	th:nth-child(4),
	td:nth-child(4) {
	  width: 10%;
	}
	th:nth-child(5),
	td:nth-child(5) {
	  width: 10%;
	}
	th:nth-child(6),
	td:nth-child(6) {
	  width: 10%;
	}
	th:nth-child(7),
	td:nth-child(7) {
	  width: 10%;
	}
	td:nth-child(7)>span {
		color: red;
	}
	.admin_ono_head {
	margin: 30px 0;
	text-align: right;
	border
	}
	
	.admin_ono_title {
		float: left;
		font-size: 30px;
		margin-left: 100px;
	}
	.notice_pageArea {
	margin-top: 20px;
    text-align: center;
	}

	.notice_pageArea nav {
	    display: inline-block;
	}
	.admin_oto_search {
		display: flex;
		width: 600px;
		float: right;
	}
	.admin_oto_search > input[type=button]{
	background : white;
	color: black;
	border: 1px solid black;
	padding: 0 10px;
	margin-left: 10px;
	}
	.admin_oto_search > input[type=button]:hover{
	background : black;
	color: white;
	transition-duration: .2s;
	}
	
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
</header>

<!-- 	<div class="container"> -->
<div class="row">
	<c:set var="pageNum" value="${empty param.pageNum ? 1 : param.pageNum }" />
	<!-- side 영역 -->
	<div class="col-2">
		<jsp:include page="/WEB-INF/views/inc/admin_aside.jsp"></jsp:include>
	</div>
	<!-- content 영역 -->
	<div class="col-9">
		<div class="admin_ono_head">
			<div class="admin_ono_title">
				🤷1대1 문의 관리
			</div>
			<div class="admin_oto_search">
			
				<select class="form-select form-select-sm w-25"
					aria-label="Default select example" name="csc_category" id="admin_faq">
					<option value = "">문의 유형 선택</option>
					<option value="예매/결제" >예매/결제</option>
					<option value="영화관이용">영화관이용</option>
					<option value="쿠폰">쿠폰</option>
					<option value="스토어">스토어</option>
					<option value="홈페이지/모바일">홈페이지/모바일</option>
				</select>
				
				<select class="form-select form-select-sm w-25"
					aria-label="Default select example" name="csc_theater" id="admin_theater">
					<option value = "">문의 지점 선택</option>
					<option value="해운대점">해운대점</option>
					<option value="센텀점">센텀점</option>
					<option value="서면점">서면점</option>
					<option value="남포점">남포점</option>
					<option value="부산대점">부산대점</option>
					<option value="사직점">사직점</option>
					<option value="영도점">영도점</option>
					<option value="덕천점">덕천점</option>
					<option value="정관점">정관점</option>
					<option value="사상점">사상점</option>
				</select>
				
				<input type="button" value="초기화" onclick="resetAll()">
				
			</div>
		</div>
		
		<div class="admin_ono_body">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>작성자</th>
						<th>문의제목</th>
						<th>문의유형</th>
						<th>문의지점</th>
						<th>작성일</th>
						<th>답변상태</th>
						<th>답변</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty otoList }">
							<tr>
								<td colspan="7">게시물이 없습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="oto" items="${otoList }" varStatus="status">
								<tr>
									<td>${oto.oto_num }</td>
									<td>${oto.member_id }</td>
									<td>${oto.oto_subject }</td>
									<td>${oto.oto_category }</td>
									<td>${oto.theater_name }</td>
									<td>
										<fmt:parseDate var="parseOtoDate" value="${oto.oto_date }" pattern="yyyy-MM-dd'T'HH:mm:ss" type="both" />
										<fmt:formatDate value="${parseOtoDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
									</td>
									<td>
										<span id="oto_reply_status${status.index }">${oto.oto_reply_status }</span>
									</td> 
									<td>
										<c:choose>
											<c:when test="${oto.oto_reply_status eq '답변'}">
												<button type="button" class="btn btn-outline-primary" onclick="admin_oto_modify(${oto.oto_num},${pageNum })">답변수정</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-outline-primary" onclick="admin_oto_reply(${oto.oto_num})">답변하기</button>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					
				</tbody>
			</table>
		</div>
		<div class="notice_pageArea">
<%-- 		<c:set var="pageNum" value="${empty param.pageNum ? 1 : param.pageNum}" /> --%>
			<c:choose>
				<c:when test="${empty otoList }">
					<h3>Non-paging</h3>
				</c:when>
				<c:otherwise>
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<li class="page-item <c:if test="${pageNum eq 1 }">disabled</c:if>" >
								<a class="page-link" href="admin_oto?pageNum=${param.pageNum - 1}&faqCategory=${faqCategory}&theaterName=${theaterName }"  >
								<span aria-hidden="true" >&laquo;</span>
								</a>
							</li>
							<c:forEach var="i" begin="${pageList.startPage }" end="${pageList.endPage }">
								<c:choose>
									<c:when test="${param.pageNum eq i}">
										<li class="page-item active"><a class="page-link">${i}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link" href="admin_oto?pageNum=${i}&faqCategory=${faqCategory }&theaterName=${theaterName}">${i}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<li class="page-item <c:if test="${pageNum eq pageList.maxPage}">disabled</c:if>">
								<a class="page-link" href="admin_oto?pageNum=${param.pageNum + 1}&faqCategory=${faqCategory}&theaterName=${theaterName}" >
								<span aria-hidden="true">&raquo;</span>
								</a>
							</li>
						</ul>
					</nav>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
</footer>
	
<script type="text/javascript">
let pageNum = 1;

$(function () {
	$("#admin_faq").change(function() {
		let faqCategory = $(this).val();
		location.href="admin_oto?pageNum=" + pageNum + "&faqCategory=" + faqCategory;
// 		console.log(faqCategory);
	});
	
	$("#admin_theater").change(function() {
		let theaterName = $(this).val();
		location.href="admin_oto?pageNum=" + pageNum + "&theaterName=" + theaterName;		
		console.log(theaterName);
	});
	
	$("[id^='oto_reply_status']").each(function() {
		if($(this).text() == '답변') {
			$(this).css("color", "green");
		}
	});
	
	
}); 

function resetAll() {
	location.href="admin_oto?pageNum=" + pageNum;
}


function admin_oto_reply(num) {
	window.open("admin_oto_detail?oto_num=" + num, "_self");
}
function admin_oto_modify(num, pageNum) {
	window.open("admin_oto_modify?oto_num=" + num + "&pageNum=" + pageNum, "_self");
}
function admin_notice_withdraw() {
	location.href="admin_notice_delete";
}


</script>
	
</body>
</html>