<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지 - 상영관 관리</title>
<link href="../admin_main/admin_main.css" rel="stylesheet">
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/admin_list.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<style>
/* 테이블 비율 */
th:nth-child(1), td:nth-child(1) {
	width: 10%;
}

th:nth-child(2), td:nth-child(2) {
	width: 15%;
}

th:nth-child(3), td:nth-child(3) {
	width: 15%;
}

th:nth-child(4), td:nth-child(4) {
	width: 20%;
}

th:nth-child(5), td:nth-child(5) {
	width: 15%;
}

th:nth-child(6), td:nth-child(6) {
	width: 10%;
}

.admin_movie_search {
	height: 50px;
	width: 400px;
	float: right;
	margin-right: 0;
	margin-bottom: 20px;
}
.admin_movie_search >select{
	width: 200px;
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
				<!-- 파라미터 없을 시 기본값 1 저장 -->
				<c:set var="pageNum" value="1"/>
				<c:if test="${not empty param.pageNum}">
					<c:set var="pageNum" value="${param.pageNum}"/>
				</c:if>
				
				<!--  메인 중앙 영역  -->
				<div class="admin_movie_head">
					<div class="admin_movie_title">🎞️상영관관리</div>
					<div class="admin_movie_search">
						<select class="form-select" name="searchKeyword" id="adminTheaterName"style="width: 300px;">
							<option value="">전체</option>
							<c:forEach var="theater" items="${theaterList}">
								<option value="${theater.theater_name}" <c:if test="${theater.theater_name eq param.searchKeyword}">selected</c:if>>${theater.theater_name}</option>
							</c:forEach>
						</select> 
					</div>
				</div>

				<!-- 바디 부분 여기 표 넣을거임 -->
				
				<div class="admin_movie_body" id="admin_movie_body">
					<table>
						<thead>
							<tr>
								<th>상영관 번호</th>
								<th>극장 지점명</th>
								<th>상영관 이름</th>
								<th>상영관 크기</th>
								<th>운영 상태</th>
								<th>수정/삭제</th>
							</tr>
						</thead>
				<!--  이 부분을 반복문을 통해서 상영관 정보를 담은 리스트를 
			      전달받아 출력하면 좋을듯-->
						<tbody>
							
							<c:forEach var="screenInfo" items="${screenInfoList}">
									<tr>
										<td>${screenInfo.screen_num}</td>
										<td>${screenInfo.theater_name}</td>
										<td>${screenInfo.screen_cinema_num}관</td>
										<td>${screenInfo.seat_size}석</td>
										<td>
											<c:choose>
												<c:when test="${screenInfo.screen_status == 1}">정상</c:when>
												<c:otherwise>휴관</c:otherwise>
											</c:choose>
										</td>
										<td>
											<button type="button" class="btn btn-outline-primary" onclick="boothModify(${screenInfo.screen_num})">관리</button>
										
										</td>
									</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<section id="pageList">
					<button type="button" class="btn btn-outline-primary" onclick="location.href='admin_booth?pageNum=${pageNum - 1}&searchKeyword=${param.searchKeyword}'"
						<c:if test="${pageNum le 1}">disabled</c:if>>
						이전
					</button>
					
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" >
							<c:choose>
								<c:when test="${pageNum eq i}">
									<b>${i}</b>
								</c:when>				
								<c:otherwise>
									<a href="admin_booth?pageNum=${i}&searchKeyword=${param.searchKeyword}">${i}</a>
								</c:otherwise>
							</c:choose>
					</c:forEach>
					
					<button type="button" class="btn btn-outline-primary" onclick="location.href='admin_booth?pageNum=${pageNum + 1}&searchKeyword=${param.searchKeyword}'"
						<c:if test="${pageNum ge pageInfo.maxPage}">disabled</c:if>>
						다음
					</button>
				</section>
				
				
				<div class="admin_movie_footer" align="center">
					<button onclick="boothForm()">상영관 등록</button>
				</div>

			</div>

		</div>
	</main>

	<footer>
		<jsp:include page="../../inc/admin_footer.jsp"></jsp:include>
	</footer>

	<script type="text/javascript">
		function boothModify(num) {
			window.open("admin_booth_modify?screen_num=" + num, "_self");
		}
		
		function boothForm() {
			window.open("admin_booth_form", "_self");
		}
		
		$(function() {
			$("#adminTheaterName").change(function() {
				location.href = "admin_booth?pageInfo=" + ${pageNum} + "&searchKeyword=" + $("#adminTheaterName").val();
				
			});
			
		});
		
		
	
	
	</script>
</body>
</html>