<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 예매 결제</title>
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');
	* {
	  font-family: "Nanum Gothic", sans-serif;
	  font-weight: 400;
	  font-style: normal;
	}

	body { 
		margin: 0; 
		padding:0; 
 	} 

	article {
		margin: auto;
	}
	
	.payment_all{
		width: 700px;
		margin: 30px auto;
	}
	
	#reserve_info {
		width: 700px;
	}

	h2 {
		text-align: center;
		margin: 50px 0;
	}
	
	h5 {
		margin-top: 30px;
	}
</style>
</head>
<body>
	<article>
		<div class="payment_all">
			<h2>정상적으로 <span class="text-primary">결제 완료</span> 되었습니다. </h2>	
			<div>
				<h5 class="text-primary">결제 내역</h5>
				<p>주문번호 : ${pay.merchant_uid}</p>
				<p>결제일시 : 
					<fmt:parseDate value="${pay.ticket_pay_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate"/>
					<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</p>
			</div>
			<div>
				<h5 class="text-primary">결제 정보</h5>
				<p>결제수단 : ${pay.ticket_pay_type}</p>
				<hr>
				<p>티켓 가격 :
					<c:choose>
						<c:when test="${not empty coupon.coupon_name}">
							${pay.ticket_pay_price + pay.use_point + (coupon.coupon_value*-1)}원
						</c:when>
						<c:otherwise>
							${pay.ticket_pay_price + pay.use_point}
						</c:otherwise>
					</c:choose>
				</p>
				<p>포인트 사용 : ${pay.use_point}원</p>
				<p>쿠폰 : 
					<c:choose>
						<c:when test="${not empty coupon.coupon_name}">
							${coupon.coupon_name}(${coupon.coupon_value}) 
						</c:when>
						<c:otherwise>
							미사용
						</c:otherwise>
					</c:choose>
				</p>
				<hr>
				<p><b>최종 결제금액 : ${pay.ticket_pay_price} 원</b></p>
			</div>
			<div>
				<h5 class="text-primary">예매 정보</h5>
				<div class="row" id="reserve_info">
					<div class="col text-center">
						<img src="${payInfo.movie_poster}" id="movie_poster" alt="포스터썸네일" style="width: 250px;" >
					</div>
					<div class="col">
						<ul class="list-group list-group-flush">
							<li class="list-group-item">
								<p><!-- 영화 제목 -->
									<span id="movie_name">${payInfo.movie_name}</span> | 
									<span id="movie_name">${payInfo.screen_dimension}</span>
								</p>
							</li>
							<li class="list-group-item">
								<p><!-- 극장명, 상영관 명 -->
									<span id="theater_name">${payInfo.theater_name} / </span>
									<span id="screen_cinema_num">${payInfo.screen_cinema_num}관</span>
								</p>
							</li>
							<li class="list-group-item">
								<p>좌석 <!-- 선택된 좌석 -->
									<span id="selected_seats">${payInfo.ticket_seat_info}</span>
								</p>
							</li>
							<li class="list-group-item">
								<p> <!-- 상영 시간 -->
									<span id="select_date">${payInfo.scs_date}</span>
								</p>
							</li>
							<li class="list-group-item">
								<p><!-- 상영 시작 시간~ 끝나는 시간 -->
									<img src="${pageContext.request.contextPath}/resources/images/pay_clock.svg" style="width: 15px;">
									<span id="scs_start_time"> ${payInfo.scs_start_time}</span> ~
									<span id="scs_end_time">${payInfo.scs_end_time}</span>
								</p>
							</li>
						</ul>
					</div>
				</div> <!-- row -->
			</div>
			<br>
			<br>
			<div class="d-flex justify-content-center">
				<button class="btn btn-primary mx-2" type="button" onclick="location.href='myp_reservation'">예매 내역 확인</button>
				<button class="btn btn-primary mx-2" type="button" onclick="location.href='./'">부기무비 메인</button>
			</div>
		</div>
	</article>
</body>
<script type="text/javascript">
	window.history.pushState(null, null, location.href);
	window.onpopstate = function () {
	    history.go(1);
	};

</script>
</html>