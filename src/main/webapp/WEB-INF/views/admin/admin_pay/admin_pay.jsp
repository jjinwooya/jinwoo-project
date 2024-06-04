<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스토어 결제관리</title>
<!-- <link href="../admin_main/admin_main.css" rel="stylesheet"> -->
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
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
  width: 20%;
}

th:nth-child(3),
td:nth-child(3) {
  width: 10%;
}
th:nth-child(4),
td:nth-child(4) {
  width: 15%;
}
th:nth-child(5),
td:nth-child(5) {
  width: 15%;
}
th:nth-child(6),
td:nth-child(6) {
  width: 15%;
}
th:nth-child(7),
td:nth-child(7) {
  width: 15%;
}

.admin_store_head{
	margin: 50px 0;
	text-align: right;
}
.admin_store_body{
	margin-bottom: 30px;
}
.admin_store_search{
	height: 50px;
	width: 360px;
	background: #black;
	float: right;
	margin-right: 100px;
	margin-bottom: 10px;
}

.admin_store_title{
	float: left;
	font-size: 30px;
	margin-left: 100px;
}

.admin_store_search>form>input[type=text] {
	font-size: 18px;
	height: 40px;
	width: 150px;
	padding: 5px;
	outline: none;
	vertical-align: middle;
}

.admin_store_search>form>input[type=submit] {
	width: 90px;
	height: 40px;
	background: black;
	outline: none;
	color: white;
	font-weight: bold;
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
		<jsp:include page="../../inc/admin_header.jsp"></jsp:include>
	</header>

	<main>

		<div class="row">

			<div class="col-md-2">
				<!-- 사이드바 영역 -->
				<jsp:include page="../../inc/admin_aside.jsp"></jsp:include>
			</div>

			<div class="col-md-9">
				<!--  메인 중앙 영역  -->
				
				<!-- 파라미터 없을 시 기본값 1 저장 -->
				<c:set var="pageNum" value="1"/>
				<c:if test="${not empty param.pageNum}">
					<c:set var="pageNum" value="${param.pageNum}"/>
				</c:if>
				
				<!-- 헤드 부분 검색 기능 -->
				<div class="admin_store_head">
					<div class="admin_store_title">💳스토어 결제관리</div>
					<div class="admin_store_search">
						<form action="admin_pay">
							<input type="text" name="searchKeyword" placeholder="아이디 입력" value="${param.searchKeyword}">
							<input type="submit" value="검색">
						</form>
					</div>
				</div>

				<!-- 바디 부분 여기 표 넣을거임 -->
				<div class="admin_store_body">
					<table>
						<thead>
							<tr>
								<th>결제코드</th>
								<th>결제회원</th>
								<th>결제종류</th>
								<th>결제날짜</th>
								<th>결제금액</th>
								<th>결제상태</th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${store_pay_list }" var="store_pay">
								<tr>
									<td>${store_pay.store_pay_num}</td>
									<td>${store_pay.member_id}</td>
									<td>스낵</td>
									<td>
									 	<fmt:parseDate value="${store_pay.store_pay_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
                						<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm" />
									</td>
									<td>
									 	<fmt:formatNumber value="${store_pay.store_pay_price}" type="currency" currencySymbol="" groupingUsed="true" />원
									</td>
									<td>${store_pay.store_pay_status}</td>
									<td>
										<button type="button" class="btn btn-outline-primary" onclick="pay_detail(${store_pay.store_pay_num})">상세보기</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<!-- 페이징 -->
				<section id="pageList">
					<button type="button" class="btn btn-outline-primary" onclick="location.href='admin_pay?pageNum=${pageNum - 1}&searchKeyword=${param.searchKeyword}'"
						<c:if test="${pageNum le 1}">disabled</c:if>>
						이전
					</button>
					
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" >
							<c:choose>
								<c:when test="${pageNum eq i}">
									<b>${i}</b>
								</c:when>				
								<c:otherwise>
									<a href="admin_pay?pageNum=${i}&searchKeyword=${param.searchKeyword}">${i}</a>
								</c:otherwise>
							</c:choose>
					</c:forEach>
					
					<button type="button" class="btn btn-outline-primary" onclick="location.href='admin_pay?pageNum=${pageNum + 1}&searchKeyword=${param.searchKeyword}'"
						<c:if test="${pageNum ge pageInfo.maxPage}">disabled</c:if>>
						다음
					</button>
				</section>
				

			</div>

		</div>
	</main>

	<footer>
		<jsp:include page="../../inc/admin_footer.jsp"></jsp:include>
	</footer>

	<script type="text/javascript">
		function pay_detail(store_pay_num) {
			location.href = "StorePayDetail?store_pay_num=" + store_pay_num;
		}
	
	
	</script>
</body>
</html>