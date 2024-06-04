<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>부기무비 전체극장</title>
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<!-- 극장 theater.css  -->
<link href="${pageContext.request.contextPath}/resources/css/theater.css" rel="stylesheet" type="text/css">
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>


</head>

<body>
	<header>
		<jsp:include page="../inc/admin_header.jsp"></jsp:include>
	</header>
	<article>
	<h1>전체 극장</h1>
	<hr>
	<div class="theater_all">
		<jsp:include page="theater_top.jsp"></jsp:include>
		
		<div class="theater_map">
			<div id="map" style="width:70%; height:400px; margin: auto;"></div>
		</div><!-- theater_map 끝 -->
		
		<br>
		<!-- 극장 관련 이벤트 불러오기 -->
		<div class="theater_main_cont" id="theater-event">
			<div class="row">
				<div class="col-11">
					<h3 class="text-primary">극장 이벤트</h3>
				</div>
				<div class="col">
					<a href="event" style="text-decoration: none;">더보기 
	      				<img src="${pageContext.request.contextPath}/resources/images/chevron-right.svg" width="15" > 
	      			</a>
				</div>
			</div>
			<div class="row">
				<c:forEach var="event" items="${eventList}" begin="0" end="2" >
						<div class="col">
							<a href="eventDetail?event_num=${event.event_num}">
								<img src="${pageContext.request.contextPath}/resources/upload/${event.event_thumbnail}" style="width:100%;">
							</a>
						</div>
				</c:forEach>
			</div>
		</div>
		<br>
		<!-- 극장 관련 공지사항 불러오기 -->
		<div class="theater_main_cont" id="theater-notice">
			<div class="row">
	    		<div class="col-11">
	     			<h3 class="text-primary">극장 공지사항</h3>	
	   			</div>
	    		<div class="col">
	      			<a href="csc_notice" style="text-decoration: none;">더보기 
	      				<img src="${pageContext.request.contextPath}/resources/images/chevron-right.svg" width="15"> 
	      			</a>
	   			</div>
	   		</div>
			<table class="table table-bordered table-striped">
				<thead>
					<tr>
						<th scope="col" width="400px"><b>극장</b></th>
						<th scope="col" width="800px"><b>제목</b></th>
						<th scope="col" ><b>등록일</b></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="notice" items="${noticeList}" begin="0" end="6">
						<tr>
							<td scope="row">${notice.theater_name}</td>
							<td><a href="csc_notice_detail?notice_num=${notice.notice_num}" class="notice_detail">${notice.notice_subject}</a></td>
<%-- 							<td>${notice.notice_date}</td> --%>
							<td>
								<fmt:parseDate var="parseNotice_date" value="${notice.notice_date}" 
												pattern="yyyy-MM-dd" type="both" />
								<fmt:formatDate value="${parseNotice_date}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
		</div>	
	</article>
	<footer>
	</footer>
	<!-- 카카오맵 API 라이브러리 -->
 	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b60a9d61c7090ce24f1b5bfa7ab26622"></script>
	<script>
		$(function() {
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
		    mapOption = { 
		        center: new kakao.maps.LatLng(35.180355, 129.074238), // 지도의 중심좌표(부산 중심 대충)
		        level: 9 // 지도의 확대 레벨
		    };
			
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			 
			// 마커를 표시할 위치와 title 객체 배열입니다 
			
			// 서버에서 전달된 mapTheater 객체를 JSON.parse를 통해 자바스크립트 객체로 변환
			let mapTheater = JSON.parse('${mapTheater}');
// 			console.log("mapTheater : " + JSON.stringify(mapTheater));
			var positions = [];
			
			for (var i = 0; i < mapTheater.length; i++) {
			    var theater = mapTheater[i];
			    positions.push({
			    	title: '부기무비 ' + theater.theater_name,
			        latlng: new kakao.maps.LatLng(theater.map_x, theater.map_y)
			    });
			    console.log("title : " + theater.theater_name);
			    console.log("latlng : " + theater.map_x, theater.map_y);
			}
			
			// 마커 이미지의 이미지 주소입니다
			var imageSrc = "${pageContext.request.contextPath}/resources/images/boogi_mark.png"; 
			    
			for (var i = 0; i < positions.length; i ++) {
			    
			    // 마커 이미지의 이미지 크기 입니다
			    var imageSize = new kakao.maps.Size(52, 69); 
			    
			    // 마커 이미지를 생성합니다    
			    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
			    
			    // 마커를 생성합니다
			    var marker = new kakao.maps.Marker({
			        map: map, // 마커를 표시할 지도
			        position: positions[i].latlng, // 마커를 표시할 위치
			        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			        image : markerImage // 마커 이미지 
			    });
			}
			
		});
	</script>
 	
</body>
</html>


