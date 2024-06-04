<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 등록폼</title>
<!-- 부트스트랩 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous">
</script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/admin_form.css" rel="stylesheet" type="text/css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
#event_type_num{
	max-width: 680px;
	padding: 5px;
	background: #fff;
	border-radius: 5px;
	background: #fff;
}
</style>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-2">이벤트 상세보기</h4>
				<h6 class="mb-3">이벤트코드 : ${event.event_num}</h6>
				<form class="validation-form" novalidate action="admin_event_modify_pro?event_num=${event.event_num}" method="post" onsubmit="return confirm('이벤트를 수정하시겠습니까?');">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="event_type_num">이벤트타입</label> 
							<select name="event_type_num" id="event_type_num" class="form-control" required>
								<option <c:if test="${event.event_type_num eq 1}"> selected </c:if> value="1">영화이벤트</option>
								<option <c:if test="${event.event_type_num eq 2}"> selected </c:if> value="2">극장이벤트</option>
								<option <c:if test="${event.event_type_num eq 3}"> selected </c:if> value="3">할인이벤트</option>
							</select>
							<div class="invalid-feedback">이벤트 제목을 선택해주세요.</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="coupon_num">할인쿠폰</label> 
							<select name="coupon_num" id="coupon_num" class="form-control" required>
								<option <c:if test="${event.coupon_type_num eq 9}"> selected </c:if> value="9">미선택</option>
								<option <c:if test="${event.coupon_type_num eq 1}"> selected </c:if> value="1">1000원 할인쿠폰</option>
								<option <c:if test="${event.coupon_type_num eq 2}"> selected </c:if> value="2">2000원 할인쿠폰</option>
								<option <c:if test="${event.coupon_type_num eq 3}"> selected </c:if> value="3">3000원 할인쿠폰</option>
								<option <c:if test="${event.coupon_type_num eq 4}"> selected </c:if> value="4">4000원 할인쿠폰</option>
								<option <c:if test="${event.coupon_type_num eq 5}"> selected </c:if> value="5">5000원 할인쿠폰</option>
								<option <c:if test="${event.coupon_type_num eq 6}"> selected </c:if> value="6">6000원 할인쿠폰</option>
								<option <c:if test="${event.coupon_type_num eq 7}"> selected </c:if> value="7">7000원 할인쿠폰</option>
								<option <c:if test="${event.coupon_type_num eq 8}"> selected </c:if> value="8">8000원 할인쿠폰</option>
							</select>
							<div class="invalid-feedback">이벤트 제목을 선택해주세요.</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="event_title">이벤트제목</label> 
						<input type="text" name="event_subject" id="event_title" class="form-control" value="${event.event_subject}" required />
						<div class="invalid-feedback">이벤트 제목을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="event_thumbnail">썸네일</label> 
							<input type="text" name="event_thumbnail" id="event_thumbnail" class="form-control" value="${event.event_thumbnail}" readonly required />
					</div>
					<div class="mb-3">
						<label for="event_image">본문이미지</label> 
						<input type="text" name="event_image" id="event_image" class="form-control" value="${event.event_image}" readonly required />
						<div class="invalid-feedback">이미지를 선택해주세요.</div>
					</div>
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="event_start_date">이벤트 시작일</label> 
							<input type="date" name="event_start_date" id="event_start_date" class="form-control" value="${event.event_start}" required />
							<div class="invalid-feedback">이벤트 시작일을 선택해주세요.</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="event_end_date">이벤트 종료일</label> 
							<input type="date" name="event_end_date" id="event_end_date" class="form-control" value="${event.event_end}" required>
							<div class="invalid-feedback">이벤트 종료일을 선택해주세요.</div>
						</div>
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4" align="center">
						<input type="submit" value="수정하기" class="btn btn-primary btn-lg btn-block">
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="history.back()">
					</div>
				</form>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; Boogi Movie</p>
		</footer>
	</div>
	<script>
	    window.addEventListener('load', () => {
	      const forms = document.getElementsByClassName('validation-form');
	
	      Array.prototype.filter.call(forms, (form) => {
	        form.addEventListener('submit', function (event) {
	          if (form.checkValidity() === false) {
	            event.preventDefault();
	            event.stopPropagation();
	          }
	
	          form.classList.add('was-validated');
	        }, false);
	      });
	    }, false);
	    
	    $(function() {
			$("#event_end_date").change(function() {
				if($("#event_start_date").val() == ""){
					alert("이벤트 시작일을 먼저 선택해주세요");
					$('#event_end_date').val('');
					$("#event_start_date").focus();
				} else {
		            var startDateValue = $("#event_start_date").val();
		            $('#event_end_date').attr('min', startDateValue);
		        }
			});
			$('#event_start_date').change(function() {
		        $('#event_end_date').attr('min', $(this).val());
		        if($('#event_end_date').val() != '' && $('#event_start_date').val() > $('#event_end_date').val()){
		        	alert("이벤트 종료일을 체크해주세요");
		        	$('#event_start_date').val('');
		        }
		    });
		});    
	  
	    
 	</script>
</body>
</html>