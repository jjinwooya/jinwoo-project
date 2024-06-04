<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 스토어 결제</title>
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
	
	.pay_info {
		width: 500px;
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
				<p>주문번호 : ${store_pay.merchant_uid}</p>
				<p>결제일시 : 
					<fmt:parseDate value="${store_pay.store_pay_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate"/>
					<fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</p> 
			</div>
			<div>
				<h5 class="text-primary">결제 정보</h5>
				<p>결제수단 : ${store_pay.store_pay_type}</p>
				<hr>
				<p>총 가격 : ${total_fee}원</p>
				<p>포인트 사용 : ${store_pay.use_point}원</p>
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
				<p><b>최종 결제금액 : ${store_pay.store_pay_price}원</b></p>
			</div>
			<div>
				<h5 class="text-primary">구매 정보</h5>
				<div class="pay_info">
					<ul class="list-group list-group-flush">
						<!-- 결제 항목 노출 -->
						<c:forEach var="cart" items="${cartList}">
							<li class="list-group-item"> <!--  항목 하나 -->
								<div class="row ">
									<div class="col text-center">
										<img src="${pageContext.request.contextPath}/resources/images/${cart.item_info_image}" id="item_info_image" alt="아이템 이미지" style="width:100px;" >
									</div>
									<div class="col">
										<p><b>구매 항목 : <span class="pay_number">${cart.item_info_name}</span></b></p>
										<p><b>구매 수량 : <span class="pay_number">${cart.item_quantity}</span>개 </b></p>
									</div>	
								</div> <!-- row -->	
							</li><!--  여기까지 -->
						</c:forEach>
					</ul>
				</div>
			</div>
			<br>
			<br>
			<div class="d-flex justify-content-center">
				<button class="btn btn-primary mx-2" type="button" onclick="location.href='myp_store'">구매 내역 확인</button>
				<button class="btn btn-primary mx-2" type="button" onclick="location.href='./'">부기무비 메인</button>
			</div>	
		</div>
	</article>
<script type="text/javascript">
	window.history.pushState(null, null, location.href);
	window.onpopstate = function () {
	    history.go(1);
	};

</script>
</body>
</html>