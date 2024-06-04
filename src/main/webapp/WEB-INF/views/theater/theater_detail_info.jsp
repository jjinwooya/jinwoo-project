<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<!-- 극장 theater.css  -->
<link href="${pageContext.request.contextPath}/resources/css/theater.css" rel="stylesheet" type="text/css">

 <style>
	.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
	.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
	.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
	.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
	.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
</style>

</head>

<body>
	<div class="theater_info">
		<div class="theater_info_content"> <!-- 시설안내 -->
			<h4 class="text-primary">시설 안내</h4>
			<div> <!-- 지점별 운영 시간 -->
				<h5>■ 운영 시간</h5>
				${theater.theater_hours}
			</div>
			<br>
			<div class="theater_facility"> <!-- 보유시설 -->
				<h5>■ 보유 시설</h5>
				<div class="theater_facility_area" style="display: flex;">
					<c:forEach var="facility" items="${facilityList}">
						<div style="width:120px; text-align: center;">
							<img src="${pageContext.request.contextPath}/resources/images/${facility.facility_img}" class="theater_facility_info_img"><br>
							${facility.facility_info}
						</div>
					</c:forEach>
				</div>
				
			</div> <!-- theater_facility_info 끝 -->
			 <br>
			 <div class="theater_floor_info"> <!-- 층별안내 -->
				<h5>■ 층별 안내</h5>
				${theater.theater_floor_info}
			 </div> <!-- theater_floor_info 끝 -->
		</div> <!-- theater_info_content 끝 -->
		<br>
		<div class="theater_info_content"> <!-- 교통안내 -->
			<h4 class="text-primary">교통 안내</h4>
			<div class="theater_detail_map"> <!-- 약도 -->
				<h5>■ 약도</h5>
				<p>도로명 주소: ${theater.theater_address}</p>
				
				<div id="map" style="width:350px; height:350px;"></div>
		
				
			 </div> <!-- theater_detail_map 끝 -->
			 <br>
			 <div class="theater_parking"> <!-- 주차 안내 -->
				<h5>■ 주차</h5>	
				<div class="theater_parking_info">
					<b>주차안내</b><br>
					${theater.theater_parking_info}
				</div>
				<br>
				<div class="theater_parking_fee">
					<b>주차요금</b><br>
					${theater.theater_parking_fee}
				</div>		
			 </div> <!-- theater_parking 끝 -->
			 <br>
			 <div class="theater_public" >  <!-- 교통안내 -->
			 	<h5>■ 대중교통</h5>	
			 	<div class="theater_public_area">
				 	<div class="theater_public_info">
				 		<img src="${pageContext.request.contextPath}/resources/images/theater_info_bus.png" class="theater_public_img">
						<b>버스</b><br>
						${theater.theater_public_bus}
						
					</div>		
				 	<div class="theater_public_info" >
				 		<c:if test="${not empty theater.theater_public_subway}">
				 			<img src="${pageContext.request.contextPath}/resources/images/theater_info_subway.png" class="theater_public_img"> 
							<b>지하철</b><br>
							${theater.theater_public_subway}
						</c:if>
					</div>		
				</div>
			 </div> <!-- theater_public 끝 -->
		</div> <!-- theater_info_content 끝 -->
		<br>
		<!-- 각 지점 공지사항 -->
		<div class="theater_info_content"> <!-- 공지사항 -->
			<div class="row">
	    		<div class="col-11">
					<h4 class="text-primary">공지사항</h4>
	   			</div>
	    		<div class="col">
	      			<a href="csc_notice"  style="text-decoration: none;">더보기
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
					<c:forEach var="notice" items="${theaterNoticeList}" begin="0" end="6">
						<tr>
							<td scope="row">${notice.theater_name}</td>
							<td><a href="csc_notice_detail?notice_num=${notice.notice_num}" class="notice_detail">${notice.notice_subject}</a></td>
							<td>
								<fmt:parseDate var="parseNotice_date" value="${notice.notice_date}" 
												pattern="yyyy-MM-dd" type="both" />
								<fmt:formatDate value="${parseNotice_date}" pattern="yyyy-MM-dd" />
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div> <!-- theater_info_content 끝 -->
	
	</div> <!-- theater_info 끝  -->
	
	<!-- 카카오맵 API 라이브러리 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b60a9d61c7090ce24f1b5bfa7ab26622&libraries=services"></script>
	<script>
		var theater_map_x = ${theater.theater_map_x};
		var theater_map_y = ${theater.theater_map_y};
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		  mapOption = { 
		        center: new kakao.maps.LatLng(theater_map_x, theater_map_y), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
		    };

		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		var imageSrc = '${pageContext.request.contextPath}/resources/images/boogi_mark.png', // 마커이미지의 주소입니다    
		    imageSize = new kakao.maps.Size(52, 69), // 마커이미지의 크기입니다
		    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		    markerPosition = new kakao.maps.LatLng(theater_map_x, theater_map_y); // 마커가 표시될 위치입니다

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		  position: markerPosition,
		  image: markerImage // 마커이미지 설정 
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);  

		// 커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		var content = '<div class="customoverlay">' +
		    '    <span class="title">부기무비 ' + '${theater.theater_name}' + '</span>' +
		    '</div>';

		// 커스텀 오버레이가 표시될 위치입니다 
		var position = new kakao.maps.LatLng(theater_map_x, theater_map_y);  

		// 커스텀 오버레이를 생성합니다
		var customOverlay = new kakao.maps.CustomOverlay({
		    map: map,
		    position: position,
		    content: content,
		    yAnchor: 1 
		});
		
    
	</script>

</body>
</html>