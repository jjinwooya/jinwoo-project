<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>1 대 1 문의 내역</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/myp_oto_breakdown.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/csc_sidebar.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style>

@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
table {
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
  width: 5%;
}

th:nth-child(2),
td:nth-child(2) {
  width: 30%;
}

th:nth-child(3),
td:nth-child(3) {
  width: 10%;
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
   width: 15%;  
} 
th:nth-child(7),
td:nth-child(7) { 
   width: 10%;  
} 
th:nth-child(8),
td:nth-child(8) { 
   width: 10%;  
}
td:nth-child(8) {
	color: red;
}

.myp_inquiry > img {
	width:27px;
	height:27px;
}
.myp_inquiry {
	vertical-align: middle;
	font-weight: bold;
	font-size: 30px;
	margin: 20px 0;
}
#myp_title {
	margin-top: 20px;
}

.breakdown_pageArea {
	margin-top: 20px;
	text-align: center;
}

.breakdown_pageArea > nav {
	display: inline-block;
}
input[value="답변확인"] {
	background: skyblue;
	border-radius: 5px;
	border: 0;
	padding:3px;
}

</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
</header>
<div class="container">
	<c:set var="pageNum" value="${empty param.pageNum ? 1 : param.pageNum}" />
	<div class="row">
		<!--사이드 바  -->
		<div class="col-2">
			<jsp:include page="../inc/myp_aside.jsp"></jsp:include>
		</div>
		<!-- content 영역 -->
		<div class="col-10">
			<div id="myp_title">
				<h1>1 대 1 문의 내역</h1>
			</div>
			<hr>
			<div class="myp_inquiry">
				<img src="${pageContext.request.contextPath }/resources/images/inquiryIcon.svg">나의 문의내역
			</div>
			<!--문의 내역 게시판-->
			<div class="admin_review_body">
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>문의유형</th>
						<th>문의지점</th>
						<th>수정</th>
						<th>삭제</th>
						<th>답변</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty otoList} ">
							<tr>
								<td colspan="7">게시판이 비어있습니다</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="oto" items="${otoList}">
								<tr>
									<td>${oto.oto_num}</td>
									<td onclick="location.href='myp_oto_detail?oto_num=${oto.oto_num}'">${oto.oto_subject} </td>
									<td>${oto.member_id} </td>
									<td>${oto.oto_category} </td>
									<td>${oto.theater_name }</td>
									<td>
										<button type="button" class="btn btn-outline-primary" 
											onclick="location.href='myp_oto_modifyForm?oto_num=${oto.oto_num}&pageNum=${pageNum }'">수정</button>
									</td>
									<td>
										<button type="button" class="btn btn-outline-primary" onclick="otoConfirm(${oto.oto_num})">삭제</button>
									</td>
									<td>
										<c:choose>
											<c:when test="${oto.oto_reply_status eq '답변' }">
												<input type="button" value="답변확인" onclick="location.href='myp_oto_reply?pageNum=${param.pageNum}&oto_num=${oto.oto_num }'">
											</c:when>
											<c:when test="${oto.oto_reply_status eq '미답' }">
												${oto.oto_reply_status }
											</c:when>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					
				</tbody>
			</table>
			</div>
			<!-- 페이징 시작 -->
			<div class="breakdown_pageArea">
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<li class="page-item <c:if test="${pageNum eq 1 }">disabled</c:if>" >
							<a class="page-link" href="myp_oto_breakdown?pageNum=${pageNum - 1}" aria-label="Previous" >
							<span aria-hidden="true" >&laquo;</span>
							</a>
						</li>
						<c:forEach var="i" begin="${pageList.startPage }" end="${pageList.endPage }">
							<c:choose>
								<c:when test="${pageNum eq i }">
									<li class="page-item active"><a class="page-link">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link" href="myp_oto_breakdown?pageNum=${i}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<li class="page-item <c:if test="${pageNum eq pageList.maxPage }">disabled</c:if>">
							<a class="page-link" href="myp_oto_breakdown?pageNum=${pageNum + 1}" aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>
	</div>
</div>

<footer>
	<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
</footer>
<script type="text/javascript">
	function otoConfirm(num) {
		if(confirm("삭제하시겠습니까?")) {
			location.href="myp_oto_delete?oto_num=" + num;
		}
	};
</script>
</body>
</html>