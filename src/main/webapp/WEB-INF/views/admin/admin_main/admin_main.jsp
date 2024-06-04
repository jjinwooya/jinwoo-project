<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지 홈</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}

a {
   text-decoration: none;
   color: black;
}
body {
    color : #151619;
    line-height: 1.5em;
    margin: 0px;
}

.admin_main_center{
	margin-top: 60px;
}

.card-text {
	font-size: 20px;
	padding-left: 20px;
	padding-top: 10px;
}

.card_num > a {
   text-decoration: none;
   color: black;
   font-size: 30px;
   padding-right: 25px;
}
.admin_main_title {
	margin-bottom: 50px;
}
.admin_main_center_card {
	border: 1px solid black;
	border-radius: 10px;
	width: 20%;
	display: inline-block;
	margin-right: 10px;
	margin-bottom: 20px;
}

.admin_main_card {
	font-size: 25px;
	margin-left: 20px;
	margin-top: 10px;
}
.admin_main_center{
	margin-left: 100px;
}
.admin_main_chart{
	width: 70%;
	margin: 100px 0 200px 100px;
	
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
	</header>

	<main>

		<div class="admin_main">

			<div class="row">

				<div class="col-md-2">
					<!-- 사이드바 영역 -->
					<jsp:include page="/WEB-INF/views/inc/admin_aside.jsp"></jsp:include>
				</div>

				<!--  메인 중앙 영역  -->
				<div class="col-md-10">

					<div class="admin_main_center">

						<div class="admin_main_title">
							<h1>📌 관리자페이지</h1>
						</div>
					
						<div class="admin_dashboard">
							<div class="admin_main_center_card" onclick="location.href='admin_reserve'">
								<div class="admin_main_card" align="left">◇금일 예매 현황</div>
								<div align="right" class="card_num">
									<a href="#">${reserveCount}건</a>
								</div>
							</div>
							<div class="admin_main_center_card" onclick="location.href='admin_moviePlan'">
								<div class="admin_main_card" align="left">◇금일 상영 영화</div>
								<div align="right" class="card_num">
									<a href="#">${moviePlanCount}건</a>
								</div>
							</div>
							<div class="admin_main_center_card" onclick="location.href='admin_movie'">
								<div class="admin_main_card" align="left">◇현재 상영작</div>
								<div align="right" class="card_num">
									<a href="#">${movieCount}편</a>
								</div>
							</div>
							<div class="admin_main_center_card" onclick="location.href='admin_member'">
								<div class="admin_main_card" align="left">◇총 회원 수</div>
								<div align="right" class="card_num">
									<a href="#">${memberCount}명</a>
								</div>
							</div>
						</div>

					</div>

					<div class="admin_main_chart">
						<canvas id="myChart" height="100px"></canvas>
					</div>

				</div>
			</div>

		</div>


	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
	</footer>
	<script type="text/javascript">
		var ctx = document.getElementById("myChart").getContext('2d');
		/*
		- Chart를 생성하면서, 
		- ctx를 첫번째 argument로 넘겨주고, 
		- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
		 */
		
		 // 극장 이름 가져오기
		 var TheaterList = [
			 <c:forEach var="theater" items="${theaterList}">
	         	"${theater.theater_name}" ,
	         </c:forEach>
		 ];
		 var MonthSales = [
	            <c:forEach var="MonthSales" items="${MonthSalesList}">
	            	"${MonthSales.Sales}" ,
	            </c:forEach>
	     ];
		
		// 랜덤색상 생성 
		function getRandomColor() {
			const rColor = Math.floor(Math.random() * 128 + 128);
		    const gColor = Math.floor(Math.random() * 128 + 128);
		    const bColor = Math.floor(Math.random() * 128 + 128);
		    return 'rgba(' + rColor + ',' + gColor + ',' + bColor + ', 0.5)';
		}

		var chartColors = function() {
		    return getRandomColor();
		};
		 
		var myChart = new Chart(ctx,
			{
				type : 'bar',
				data : {
					labels : TheaterList,
					datasets : [ {
						label : '월간 매출 데이터',
						data : MonthSales,
						backgroundColor : chartColors,
						borderColor : chartColors,
						borderWidth : 1
					} ]
				},
				options : {
					maintainAspectRatio : true, // default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
					scales : {
						y : [ {
							ticks : {
								beginAtZero : true
							}
						} ]
					}
				}
			});
	</script>
</body>
</html>