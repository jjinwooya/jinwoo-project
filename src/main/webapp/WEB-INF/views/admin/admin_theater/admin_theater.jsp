<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    	
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지 - 극장 관리</title>
<link href="../admin_main/admin_main.css" rel="stylesheet">
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/admin_list.css" rel="stylesheet" type="text/css">
<style>
/* 테이블 비율 */
th:nth-child(1), td:nth-child(1) {
	width: 7%;
}

th:nth-child(2), td:nth-child(2) {
	width: 10%;
}

th:nth-child(3), td:nth-child(3) {
	width: 20%;
}

th:nth-child(4), td:nth-child(4) {
	width: 10%;
}

th:nth-child(5), td:nth-child(5) {
	width: 7%;
}

th:nth-child(6), td:nth-child(6) {
	width: 10%;
}

.admin_movie_search {
	height: 50px;
	width: 300px;
	float: right;
	margin-right: 0;
	margin-bottom: 20px;
}
.admin_movie_search >select{
	width: 200px;
}
.admin_movie_title{
	margin-bottom: 20px;
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
				<!-- 헤드 부분 여기 검색 기능 넣을거임 -->
				<div class="admin_movie_head">
					<div class="admin_movie_title">🕋극장관리</div>
<!-- 					<div class="admin_movie_search"> -->
<!-- 						<select class="form-select"> -->
<%-- 							<c:forEach var="theater" items="${theaterList}"> --%>
<%-- 								<option>${theater.theater_name}</option> --%>
<%-- 							</c:forEach> --%>
<!-- 						</select>  -->
<!-- 					</div> -->
				</div>

				<!-- 바디 부분 여기 표 넣을거임 -->
				
				<div class="admin_movie_body">
					<table>
						<thead>
							<tr>
								<th width="100px">극장코드</th>
								<th width="200px">극장 이름</th>
								<th>극장 주소</th>
								<th>운영 시간</th>
								<th>운영 상태</th>
								<th>관리</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="theater" items="${theaterList}">
								<tr>
									<td>${theater.theater_num}</td>
									<td>${theater.theater_name}</td>
									<td>${theater.theater_address}</td>
									<c:set var="arrTheaterHours" value="${fn:split(theater.theater_hours, '/')}" />
									<td>${arrTheaterHours[0]}</td>
									<td>
										<c:choose>
											<c:when test="${theater.theater_status == 1}">운영 중</c:when>
											<c:otherwise>미운영 중</c:otherwise>
										</c:choose>
									</td>
									<td>
										<button type="button" class="btn btn-outline-primary" onclick="theaterModifyForm(${theater.theater_num})" >관리</button>
									</td>
								</tr>
							</c:forEach>
														
						</tbody>
					</table>
				</div>
				
				<div class="admin_movie_footer" align="center">
					<button onclick="theaterForm()" >극장 등록</button>
				</div>

			</div>

		</div>
	</main>

	<footer>
		<jsp:include page="../../inc/admin_footer.jsp"></jsp:include>
	</footer>

	<script type="text/javascript">
		function theaterModifyForm(num) {
			window.open("admin_theater_modify?theater_num=" + num, "_self");
		}
		
		function theaterForm() {
			window.open("admin_theater_form", "_self");
		}
		
		
	
	
	</script>
</body>
</html>