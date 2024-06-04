<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지 - 리뷰관리</title>
<!-- 부트스트랩 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
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
  width: 10%;
}

th:nth-child(2),
td:nth-child(2) {
  width: 10%;
}

th:nth-child(3),
td:nth-child(3) {
  width: 15%;
}
th:nth-child(4),
td:nth-child(4) {
  width: 5%;
}
th:nth-child(5),
td:nth-child(5) {
  width: 30%;
}
th:nth-child(6),
td:nth-child(6) {
  width: 10%;
}
th:nth-child(7),
td:nth-child(7) {
  width: 10%;
}
.admin_review_head{
	margin: 50px 0;
	text-align: right;
}
.admin_review_body{
	margin-bottom: 30px;
}
.admin_review_search{
	height: 50px;
	width: 360px;
	background: #black;
	float: right;
	margin-right: 100px;
	margin-bottom: 10px;
}

.admin_review_title{
	float: left;
	font-size: 30px;
	margin-left: 100px;
}

.admin_review_search>form>input[type=text] {
	font-size: 18px;
	height: 40px;
	width: 150px;
	padding: 5px;
	outline: none;
	vertical-align: middle;
}

.admin_review_search>form>input[type=submit] {
	width: 90px;
	height: 40px;
	outline: none;
	font-weight: bold;
	margin-left: 5px;
	vertical-align: middle;
}
#pageList{
	text-align: center;
	font-size: 20px;
	margin-bottom: 20px;
}

#pageList > a{
	text-decoration: none;
	color: lightgray;
	margin: 0 10px;
}
#pageList > b{
	margin: 0 10px;
	color: #1b1b1b;
}

</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
	</header>

	<main>
		<div class="row">
		
			<div class="col-md-2">
				<!-- 사이드바 영역 -->
				<jsp:include page="/WEB-INF/views/inc/admin_aside.jsp"></jsp:include>
			</div>
			
			<div class="col-md-9">
				
				<!--  메인 중앙 영역  -->
				
				<!-- 파라미터 없을 시 기본값 1 저장 -->
				<c:set var="pageNum" value="1"/>
				<c:if test="${not empty param.pageNum}">
					<c:set var="pageNum" value="${param.pageNum}"/>
				</c:if>
				
				<div class="admin_review_head">
					<div class="admin_review_title">✍️리뷰관리</div>
					<div class="admin_review_search">
						<form action="admin_review">
							<input type="text" name="searchKeyword" placeholder="아이디 입력" value="${param.searchKeyword}">
							<input type="submit" class="btn btn-dark" value="검색">
						</form>
					</div>
				</div>
				
					<!-- 바디 부분 여기 표 넣을거임 -->
				<div class="admin_review_body">
					<table>
						<thead>
							<tr>
								<th>리뷰번호</th>
								<th>영화번호</th>
								<th>회원ID</th>
								<th>별점</th>
								<th>내용</th>
								<th>등록날짜</th>
								<th>삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="review" items="${reviewList}">
								<tr>
									<td>${review.review_num}</td>
									<td>${review.movie_num}</td>
									<td>${review.member_id}</td>
									<td>${review.review_rating}</td>
									<td>${review.review_text}</td>
									<td><fmt:formatDate value="${review.review_date}" pattern="yyyy-MM-dd" /></td>
									<td>
										<button type="button" class="btn btn-outline-primary" 
											onclick="reviewWithdraw('${review.review_num}')">
											삭제
										</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<section id="pageList">
					<button type="button" class="btn btn-outline-primary" onclick="location.href='admin_review?pageNum=${pageNum - 1}&searchKeyword=${param.searchKeyword}'"
						<c:if test="${pageNum le 1}">disabled</c:if>>
						이전
					</button>
					
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" >
							<c:choose>
								<c:when test="${pageNum eq i}">
									<b>${i}</b>
								</c:when>				
								<c:otherwise>
									<a href="admin_review?pageNum=${i}&searchKeyword=${param.searchKeyword}">${i}</a>
								</c:otherwise>
							</c:choose>
					</c:forEach>
					
					<button type="button" class="btn btn-outline-primary" onclick="location.href='admin_review?pageNum=${pageNum + 1}&searchKeyword=${param.searchKeyword}'"
						<c:if test="${pageNum ge pageInfo.maxPage}">disabled</c:if>>
						다음
					</button>
				</section>
				
			</div>
			
		</div>
	</main>
	

	<footer>
		<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
	</footer>

	<script type="text/javascript">
		function reviewWithdraw(review_num){
			 
			if(confirm("정말 삭제하시겠습니까?")){
				location.href = "admin_review_delete?review_num=" + review_num;
			}
		} 
	</script>
</body>
</html>