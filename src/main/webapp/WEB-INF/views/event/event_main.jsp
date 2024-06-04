<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 이벤트</title>
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
main {
	width: 1400px;
	margin: 0 auto;
}

.event_title {
	text-align: left;
	margin: 30px 0px;
	border-bottom: 1px solid lightgray;
}
.event_title > h1{
	margin-bottom: 15px;
}

* {
	box-sizing: border-box;
	padding: 0;
}

.container {
	display: flex;
	flex-flow: row wrap;
	align-content: flex-start;
}

/* item에 hidden 처리하기. */
.item {
	width: 360px;
	aspect-ratio: 10/6;
	position: relative;
 	overflow: hidden; 
	border-radius: 10px;
	margin: 10px 30px;
}

.item:after {
	/* block & content */
	display: block;
	content: "";
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.2);
	position: absolute;
	top: 0;
	left: 0;
	z-index: 2;
	opacity: 0;
}

.imgBox {
	width: 100%;
	height: 100%;
	position: absolute;
}

.imgBox img {
	width: 100%;
	height: 100%;
	/* 사진이나 비디오의 규격 맞출 때 object-fit 이용하기. */
	object-fit: cover;
	z-index: 1;
}

.textBox {
	position: absolute;
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: flex-end;
	align-items: flex-start;
	padding: 20px;
	z-index: 3;
}

.textBox p {
	color: white;
	margin: 5px 0 0;
}

.textBox_name {
	font-size: 16px;
	font-weight: 500;
	opacity: 0;
	transform: translateY(50px);
}

.textBox_price {
	font-size: 16px;
	font-weight: 400;
	opacity: 0;
	transform: translateY(50px);
}

/* 마우스 올렸을 때에 기능 추가하기. */
.item:hover:after {
	opacity: 1;
}

/* 기능 1 : 화면 살짝 불투명 + 화면 커지기. */
.item:hover .imgBox img {
	transform: scale(1.1);
	/* 블러 처리하기. */
	filter: blur(3px);
}

/* 기능 2 : 상품 정보 보이면서 위로 올라가기. */
.item:hover .textBox .textBox_name {
	opacity: 1;
	transform: translateY(0px);
}

/* 기능 2 : 상품 정보 보이면서 위로 올라가기. */
.item:hover .textBox .textBox_price {
	opacity: 1;
	transform: translateY(0px);
}

/* 자연스럽게 트랜지션 적용하기. */
.item:after, .item .imgBox img, .item .textBox_name, .item .textBox_price
	{
	transition: all 0.4s ease-in-out;
}
.category-bar {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 10px;
}

.category-btn {
  background-color: #ddd;
  border: none;
  color: #333;
  padding: 10px 20px;
  margin: 0 5px;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.category-btn.active,
.category-btn:hover,
.category-btn.active:hover {
  background-color: #007bff;
  color: #fff;
}
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
	</header>

	<main>
		<div class="event_title">
			<h1>이벤트페이지</h1>
		</div>
		
		
		<div class="category-bar">
		  <button class="category-btn active EventType" value="0">전체이벤트</button>
		  <c:forEach var="eventType" items="${eventTypeList}">
		  	<button class="category-btn EventType" value="${eventType.event_type_num}">${eventType.event_type_name}</button>
		  </c:forEach>
<!-- 		  <button class="category-btn movieEvent">영화이벤트</button> -->
<!-- 		  <button class="category-btn theaterEvent">극장이벤트</button> -->
<!-- 		  <button class="category-btn discountEvent">할인이벤트</button> -->
		</div>
		<div class="container eventMain">
			<c:forEach var="eventList" items="${eventList}" >
				<div class="item movie-event" onclick="event_detail(${eventList.event_num})">
					<div class="imgBox">
						<img src="${pageContext.request.contextPath}/resources/upload/${eventList.event_thumbnail}" alt="썸네일"/>
					</div>
					<div class="textBox">
						<p class="textBox_name">${eventList.event_subject}</p>
						<p class="textBox_price">${eventList.event_start}  ~  ${eventList.event_end}</p>
					</div>
				</div>
			</c:forEach>
		</div>
		
<!-- 		<div class="event_cate_title"> -->
<!-- 			<h3>영화 이벤트</h3> -->
<!-- 		</div> -->
<!-- 		<div align="right"> -->
<!-- 			<button type="button" class="btn btn-outline-primary" id="ShowMoreBtn">더 보기</button> -->
<!-- 		</div> -->
<!-- 		<div class="container"> -->
<%-- 			<c:set var="movieEvent"/> --%>
<%-- 			<c:forEach var="movieEvent" items="${movieEventList}" varStatus="loop" begin="0" end="2"> --%>
<%-- 				<div class="item movie-event" onclick="event_detail(${movieEvent.event_num})"> --%>
<!-- 					<div class="imgBox"> -->
<%-- 						<img src="${pageContext.request.contextPath}/resources/images/${movieEvent.event_thumbnail}" alt="썸네일" onclick="location.href='eventDetail?event_num?=${movieEvent.event_num}'"/> --%>
<!-- 					</div> -->
<!-- 					<div class="textBox"> -->
<%-- 						<p class="textBox_name">${movieEvent.event_subject}</p> --%>
<%-- 						<p class="textBox_price">${movieEvent.event_start}  ~  ${movieEvent.event_end}</p> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<%-- 			</c:forEach> --%>
<!-- 		</div> -->
		
		
<!-- 		<div class="event_cate_title"> -->
<!-- 			<h3>극장이벤트</h3> -->
<!-- 		</div> -->
<!-- 		<div align="right"> -->
<!-- 			<button type="button" class="btn btn-outline-primary" id="TheaterShowMoreBtn">더 보기</button> -->
<!-- 		</div> -->
<!-- 		<div class="container"> -->
		
<%-- 			<c:forEach var="theaterEvent" items="${theaterEventList}"  varStatus="loop" begin="0" end="2"> --%>
<%-- 				<div class="item theater-event" onclick="event_detail(${theaterEvent.event_num})"> --%>
<!-- 					<div class="imgBox"> -->
<%-- 						<img src="${pageContext.request.contextPath}/resources/images/${theaterEvent.event_thumbnail}" alt="썸네일" onclick="location.href='eventDetail?event_num?=${theaterEvent.event_num}'"/> --%>
<!-- 					</div> -->
<!-- 					<div class="textBox"> -->
<%-- 						<p class="textBox_name">${theaterEvent.event_subject}</p> --%>
<%-- 						<p class="textBox_price">${theaterEvent.event_start}  ~  ${theaterEvent.event_end}</p> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<%-- 			</c:forEach> --%>
			
<!-- 		</div> -->
<!-- 		<div class="event_cate_title"> -->
<!-- 			<h3>할인이벤트</h3> -->
<!-- 		</div> -->
<!-- 		<div align="right"> -->
<!-- 			<button type="button" class="btn btn-outline-primary" id="DiscountShowMoreBtn">더 보기</button> -->
<!-- 		</div> -->
<!-- 		<div class="container"> -->
		
<%-- 			<c:forEach var="discountEvent" items="${discountEventList}" varStatus="loop" begin="0" end="2"> --%>
<%-- 				<div class="item discount-event" onclick="event_detail(${discountEvent.event_num})"> --%>
<!-- 					<div class="imgBox"> -->
<%-- 						<img src="${pageContext.request.contextPath}/resources/images/${discountEvent.event_thumbnail}" alt="썸네일" onclick="location.href='eventDetail?event_num?=${discountEvent.event_num}'"/> --%>
<!-- 					</div> -->
<!-- 					<div class="textBox"> -->
<%-- 						<p class="textBox_name">${discountEvent.event_subject}</p> --%>
<%-- 						<p class="textBox_price">${discountEvent.event_start}  ~  ${discountEvent.event_end}</p> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<%-- 			</c:forEach> --%>
			
<!-- 		</div> -->
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
	</footer>
	<script type="text/javascript">
		function event_detail(event_num) {
			location.href='eventDetail?event_num=' + event_num;
		} 
		
		$(function() {
			$('.category-btn').click(function() {
				$('.category-btn').removeClass('active');
				$(this).addClass('active');
			});
			$('.category-btn').hover(
				function() {
			    	$(this).addClass('hover');
			    },
			    function() {
			    	$(this).removeClass('hover');
			    }
			);
			
			$('.EventType').click(function() {
				$.ajax({
					type: "get",
					url: "eventType",
// 					dataType: "JSON",
					data : {
						eventType : $('button.active').val()
					},
					success: function(data) {
						console.log(data)
						$(".eventMain").empty();
						var eventHtml = '<div class="container eventMain">';
		                data.forEach(function(eventList) {
		                    eventHtml += '<div class="item movie-event" onclick="event_detail(' + eventList.event_num + ')">' +
		                                    '<div class="imgBox">' +
		                                        '<img src="resources/upload/' + eventList.event_thumbnail + '" alt="썸네일"/>' +
		                                    '</div>' +
		                                    '<div class="textBox">' +
		                                        '<p class="textBox_name">' + eventList.event_subject + '</p>' +
		                                        '<p class="textBox_price">' + eventList.event_start + ' ~ ' + eventList.event_end + '</p>' +
		                                    '</div>' +
		                                '</div>';
		                });
		                eventHtml += '</div>';
		                $(".eventMain").append(eventHtml);
						
						
					},
					error: function() {
						alert("이벤트 오류!");
					}
				});
			});
			
			
			
		});
		
		
		
	</script>

</body>
</html>