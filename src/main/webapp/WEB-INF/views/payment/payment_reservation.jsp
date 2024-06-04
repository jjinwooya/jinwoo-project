<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 빠른예매</title>
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<!--  포트원 SDK -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
		width: 1400px;
		margin: 0 auto;
	}
	
	.payment_all{
		margin: 30px;
	}
	
	#pay_agreement {
		padding: 30px;
	}
	
	.pay_number {
		font-weight: bold;
		color: #0054FF;
	}
	
	#person_info {
		font-size: 13px;
	}
	
	
</style>
<script>
	console.log("${keyword}");
</script>
</head>
<body>
	<header>
		<jsp:include page="../inc/admin_header.jsp"></jsp:include>
	</header>
	<article>
		<div class="payment_all">
		<h1>빠른 예매</h1>
		<hr>
		<form name="payForm" onsubmit="goPayment()">
			<div class="row payment_option">
				<div class="col-7 col1">
					<div class="d-flex">
						<h3 class="me-auto">할인 적용</h3>
						<button type="reset" class="btn btn-outline-primary btn-sm" id="discount_reset">할인적용 초기화</button>
					</div>
					<div class="card" id="member_point">
						<h5 class="card-header">부기무비 포인트</h5>
						<div class="card-body">
							<p class="card-text">* 예매 취소 시 유효기간이 지난 멤버십 포인트는 복구되지 않습니다.</p>
							<div class="w-50 input-group mb-3">
								<input type="text" class="form-control pay_number" placeholder="보유 포인트" id="getMemberPoint" readonly>
								<button class="btn btn-outline-secondary" type="button" id="getMemberPointBtn" >조회</button>
							</div>
							<div class="w-50 input-group mb-3">
								<input type="text" class="form-control pay_number" placeholder="사용할 포인트를 입력하세요" id="useMemberPoint" pattern="[0-9]*">
								<button class="btn btn-outline-secondary" type="button" id="useMemberPointBtn">적용</button>
							</div>
							<div id="checkPointArea"></div>
						</div>
					</div> <!-- member_point -->
					<br>
					<div class="card" id="member_coupon">
						<h5 class="card-header">부기무비 쿠폰</h5>
						<div class="card-body">
							<p class="card-text">* 예매 취소 시 유효기간이 지난 쿠폰은 복구되지 않습니다.</p>
							<div class="w-50 input-group mb-3">
								<input type="text" class="form-control pay_number" placeholder="내 쿠폰" id="getMemberCoupon" readonly>
								<button class="btn btn-outline-secondary" type="button" id="coupon-modal" >조회</button>
							</div>
						</div>
					</div><!-- member_coupon -->
					<br>
					<h3>결제 방법</h3>
					<div class="card" >
						<h5 class="card-header">결제 수단</h5>
						<div class="card-body">
							 <div class="pay-method-container">
			                    <div class="row justify-content-center">
			                        <div class="col" >
			                            <input type="radio" class="btn-check" name="pg" id="btn-check-normal" value="html5_inicis" autocomplete="off" checked>
			                            <label class="btn pay_way" for="btn-check-normal">
			                                <img src="${pageContext.request.contextPath}/resources/images/pay_credit-card.svg" alt="일반결제 이미지" style="width: 50px;">
			                                &nbsp;&nbsp;일반결제&nbsp;&nbsp;
			                            </label>
			                        </div>
			
			                        <div class="col">
			                            <input type="radio" class="btn-check" name="pg" id="btn-check-kakao" value="kakaopay" autocomplete="off">
			                            <label class="btn pay_way" for="btn-check-kakao">
			                                <img src="${pageContext.request.contextPath}/resources/images/pay_kakao.svg" alt="카카오페이 이미지" style="width: 100px;">
			                                카카오페이
			                            </label>
			                        </div>
			                        
			                        <div class="col">
			                            <input type="radio" class="btn-check" name="pg" id="btn-check-tosspay" value="tosspay" autocomplete="off">
			                            <label class="btn pay_way" for="btn-check-tosspay">
			                                <img src="${pageContext.request.contextPath}/resources/images/pay_toss.png" alt="토스페이 이미지" style="width: 100px; ">
			                                토스페이
			                            </label>
			                        </div>
			                    </div>
			                </div><!-- pay-method-container -->
						</div><!-- card-body -->
					</div><!-- 결제수단 card -->
					<br>
					<div class="card" >
						<h5 class="card-header">이용 약관</h5>
						<div class="card-body"id="pay_agreement">
		                    <div class="row">
		                        <div class="col">
		                            <label for="agmt-all" class="form-check-label">전체 동의</label>
		                        </div>
		                        <div class="col form-check-reverse">
		                            <input type="checkbox" class="form-check-input" name="agmt-all" id="agmt-all">
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col">
		                            <label for="agmt-age" class="form-check-label">만 14세 이상 결제 동의</label>
		                        </div>
		                        <div class="col form-check-reverse">
		                            <input type="checkbox" class="form-check-input select" name="agmt" id="agmt-age" required>
		                            <div class="invalid-feedback">
		                                약관에 동의해 주세요.
		                            </div>
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col">
		                            <label for="agmt-confirm" class="form-check-label">주문내용 확인 및 결제동의</label>
		                        </div>
		                        <div class="col form-check-reverse">
		                            <input type="checkbox" class="form-check-input select" name="agmt" id="agmt-confirm" required>
		                            <div class="invalid-feedback">
		                                약관에 동의해 주세요.
		                            </div>
		                        </div>
		                    </div>
						</div><!-- pay_agreement -->
					</div> <!--이용약관 card -->
				</div> <!-- col1 끝 -->
				
				<div class="col col2">
					<h3>결제하기</h3>
					<div class="card " >
						<h5 class="card-header">결제 정보</h5>
						<div class="card-body text-center">
							<div class="card payment_status_box">
	
								<div class="row ">
									<div class="col text-center">
										<img src="${scs.movie_poster}" id="movie_poster" alt="포스터썸네일" style="width: 250px;" >
									</div>
									<div class="col float-start">
										<ul class="list-group list-group-flush">
											<li class="list-group-item float-start">
												<p><!-- 영화 제목 -->
													<span id="movie_name">${scs.movie_name}</span> | 
													<span id="screen_dimension">${scs.screen_dimension}</span>
												</p>
											</li>
											<li class="list-group-item float-start">
												<p><!-- 극장명, 상영관 명 -->
													<span id="theater_name">${scs.theater_name} / </span>
													<span id="screen_cinema_num">${scs.screen_cinema_num}관</span>
												</p>
											</li>
											<li class="list-group-item float-start">
												<p>좌석 <!-- 선택된 좌석 -->
													<span id="selected_seats">${selected_seats}</span>
												</p>
											</li>
											<li class="list-group-item float-start">
												<p> <!-- 상영 시간 -->
													<span id="select_date">${formattedDate}</span>
												</p>
											</li>
											<li class="list-group-item float-start">
												<p><!-- 상영 시작 시간~ 끝나는 시간 -->
													<img src="${pageContext.request.contextPath}/resources/images/pay_clock.svg" style="width: 15px;">
													<span id="scs_start_time"> ${scs.scs_start_time}</span> ~
													<span id="scs_end_time">${scs.scs_end_time}</span>
												</p>
											</li>
											<li class="list-group-item float-start">
												<p><!-- 예매 인원 정보 -->
													<span id="person_info">${person_info}</span>
												</p>
											</li>
										</ul>
									</div>
								</div> <!-- row -->
									
								<div class="card-footer">
									<p><b> 총 금액
										<span id="total_fee" class="pay_number">${total_fee}</span>
									</b></p>
								</div> <!-- card-footer -->
							</div>
							<br>
							<div class="card payment_status_box">
								<ul class="list-group list-group-flush">
									<li class="list-group-item">
										<p>사용 포인트 
											<span id="point_apply" class="pay_number">0</span>
										</p>
									</li>
									<li class="list-group-item">
										<p>사용 쿠폰 
											<span id="coupon_apply" class="pay_number">0</span>
										</p>
									</li>
								</ul>
								<div class="card-footer">
									<p><b>총 할인 적용 <span id="discount_sum" class="pay_number">0</span></b>원</p>
								</div>
							</div>
							<br>
							<div class="card payment_status_box">
								<ul class="list-group list-group-flush">
									<li class="list-group-item">
										<p><b>최종 결제금액 
											<span id="final_amount" class="pay_number">${total_fee}</span> <!-- 첫 금액은  total_fee랑 같아야 함-->
										</b></p>
									</li>
									<li class="list-group-item">
										<p><b>결제수단 
											<span id="pay_way_apply" style="color: red;">일반결제</span>
										</b></p>
									</li>
								</ul>
							</div>
							
						</div> <!-- card-body 끝 -->
						<div class="card-footer" >
							<div class="btn-group nav nav-pills nav-fill" role="group"  >
								<button type="button" class="btn btn-secondary btn-lg" onclick="history.back();">이전</button>
								<button type="submit" class="btn btn-primary btn-lg" onclick="goPayment();">결제</button>
							</div>
						</div><!-- card-footer -->
					</div><!-- card -->
				</div> <!--  col2 끝 -->
			</div> <!-- row payment_option 끝 -->
		</form>
	</div><!-- payment_all  끝 -->
	
		<!-- 쿠폰팝업(모달창) -->
	    <div class="modal fade" id="couponModal" tabindex="-1" role="dialog" aria-labelledby="payModalLabel" aria-hidden="true">
	        <div class="modal-dialog" role="document">
	            <div class="modal-content">
	                <div class="modal-header">
	                    <h5 class="modal-title" id="payModalLabel">사용가능 쿠폰  총 <span>${fn:length(couponList)}</span>개</h5>
	                    <button type="button" class="btn-close" id="coupon-close" aria-label="Close"></button>
	                </div>
	                <form >
	                    <div class="modal-body">
	                        <div class="wrapper">
	                            <div class="box">
		                            <c:forEach var="coupon" items="${couponList}">
		                        		<input type="radio" class="coupon-select" name="select" id="${coupon.coupon_num}" value="${coupon.coupon_value}">
		                        		<label for="${coupon.coupon_num}" class="coupon-select" >${coupon.coupon_name}</label>
		                        		<br>
		                        	</c:forEach>
	                        	</div>
	                        </div>
	                        <div class="modal-footer">
	                            <button type="submit" class="btn btn-primary" id="coupon-submit">적용</button>
	                        </div>
	                   </div>
	                </form>
	            </div> <!-- modal-content -->
	        </div> <!-- modal-dialog -->
	    </div> <!-- couponModal -->

	</article>
	<footer>
		<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
	</footer>
	
<script>

	
 	$(function() {
 		
		// 포인트 조회 버튼 눌러서 포인트 가져오기
		$("#getMemberPointBtn").on("click", function() {
			$("#getMemberPoint").val("${member.member_point}");
		});
		
		// 사용할 포인트 값 입력 검증
		$("#useMemberPoint").on("keyup",function() {
			let point = $(this).val();
			let regex = /^[1-9][0-9]*00$/; // 숫자만 입력 가능, 100원 단위로만(마지막 두 자리는 0으로만) 입력 가능
			
			if(!regex.exec(point)) {
				$("#checkPointArea").text("100원 단위 숫자만 입력 가능합니다.");
				$("#checkPointArea").css("color","red");
			} else {
	            $("#checkPointArea").text("");
	        }
			
		});
		
		
		// 포인트 입력 후 적용 버튼 누를 시
		$("#useMemberPointBtn").on("click", function() {
			
			// 보유 포인트를 조회하지 않고 적용 버튼을 누른 경우 
			if($("#getMemberPoint").val() == "") {
				$("#checkPointArea").text("보유 포인트를 먼저 조회해 주세요.");
				$("#checkPointArea").css("color","red");
				$("#useMemberPoint").focus();
				
				return;
			}
			
			let point = $("#useMemberPoint").val();
			let regex = /^[1-9][0-9]*00$/; // 숫자만 입력 가능, 100원 단위로만(마지막 두 자리는 0으로만) 입력 가능
			
			if(!regex.exec(point)) {
				alert("100원 단위 숫자만 입력 가능합니다.");
				$("#useMemberPoint").val("");
			} 
			
			let total_fee = document.querySelector("#total_fee").innerText; // 넘어온 총 결제 값
			let use_point = $("#useMemberPoint").val();	// 입력된 사용할 포인트 값
			
			// 총 할인 적용 값
			let coupon_apply = document.querySelector("#coupon_apply").innerText; 	// 결제란 적용된 쿠폰 항목
// 			let use_coupon = $("#getMemberCoupon").val();
			let discount_sum = parseInt(use_point) + parseInt(coupon_apply); 		// 결제란 적용된 비타민 + 쿠폰 항목
			let final_amount = parseInt(total_fee) - parseInt(discount_sum); 		// 현재 최종 값 - 총 할인금액 
			
			
			$.ajax({
				type : "GET",
			 	url : "memberPoint",
			 	data : {
			 		member_id : "${member.member_id}",
			 		use_point : $("#useMemberPoint").val()
			 	},
			 	dataType : "json",
			 	success : function(checkDupPointResult) {
			 		if(!checkDupPointResult) {
			 			alert("보유 포인트를 초과할 수 없습니다.");
	 					$("#useMemberPoint").val("");
	 					$("#useMemberPoint").focus();
			 		} else {
			 			if(confirm ("포인트를 사용하시겠습니까?")){
			 				if(discount_sum < parseInt(total_fee)) {
					 			$("#point_apply").html(use_point);			// 적용할 포인트 값
					 			$("#final_amount").html(final_amount+"원");		// 총 결제금액에  적용 값 
					 			$("#discount_sum").html(discount_sum); 		// 총 할인 적용 값
			 				} else {
			 					alert("결제 금액을 초과할 수 없습니다.");
			 					$("#useMemberPoint").val("");
			 					$("#useMemberPoint").focus();
			 				}
			 			} else {
			 				$("#useMemberPoint").val("");
			 			}
			 		}
					
				}
// 			 	, 
// 				error : function() {
// 					alert("사용할 포인트를 입력하세요.");
// 				}
				
			}); // ajax
			
		});
		
		// 쿠폰 조회 버튼 누를 시 보유 쿠폰 조회 모달창 
		$('#coupon-modal').click((e) => {
			e.preventDefault();
			$('#couponModal').modal("show");
		});
		$('#coupon-close').click(() => $('#couponModal').modal("hide"));
		$('#coupon-submit').click(() => $('#couponModal').modal("hide"));
	    
		
		// 쿠폰 적용 버튼 누를 시 쿠폰 적용
		$("#coupon-submit").on("click", function() {
			event.preventDefault(); // 폼 제출 기본 동작 막기
			
			
			let total_fee = document.querySelector("#total_fee").innerText; // 넘어온 총 결제 값
			let selectedCoupon = document.querySelector('input[name=select]:checked').value.replace("-", ""); // 선택한 쿠폰값
			
			// 총 할인 적용 값
			let point_apply = document.querySelector("#point_apply").innerText;		// 결제란 적용된 포인트 항목
// 			let coupon_apply = document.querySelector("#coupon_apply").innerText; 	// 결제란 적용된 쿠폰 항목
			let discount_sum = parseInt(point_apply) + parseInt(selectedCoupon); 		// 결제란 적용된 비타민 + 쿠폰 항목
			let final_amount = parseInt(total_fee) - parseInt(discount_sum); 		// 현재 최종 값 - 총 할인금액 
			
			if(confirm ("선택하신 쿠폰을 사용하시겠습니까?")){
				
				if(discount_sum < parseInt(total_fee)) {
		 			$("#getMemberCoupon").val(selectedCoupon); 	// 사용한 쿠폰의 이름을 인풋 박스에 출력
		 			$("#coupon_apply").html(selectedCoupon);	// 적용할 쿠폰 값
		 			$("#final_amount").html(final_amount+"원");		// 총 결제금액 적용 값
		 			$("#discount_sum").html(discount_sum);		// 총 할인 적용 값
				} else {
					alert("결제 금액을 초과할 수 없습니다.");
				}
 			} 
			
			
		});
		
		// 결제 방식 선택 시 최종 결제 방식에 결제수단 표시하기
		$('input[name="pg"]').change(function() {
			// 선택된 라디오 버튼의 값을 가져오기
			let pay_way_apply = $(this).next().text();
			$("#pay_way_apply").html(pay_way_apply);
		   
		});
				
		
		// 전체선택 체크박스 체크 상태값을 각 체크박스의 체크 상태값으로 설정
		$("#agmt-all").click(function() {
			let checkboxes = document.querySelectorAll('input[name="agmt"]');
			for(let agmt of checkboxes) {
				agmt.checked = document.querySelector("#agmt-all").checked;
			}
		});
		
		
		// 하나라도 체크 해제되면 전체 체크 버튼도 해제되도록 설정
		$("input[name='agmt']").click(function() {
		    // 모든 체크박스를 순회하며 하나라도 체크가 해제된 것이 있는지 확인
		    let allChecked = true;
		    $("input[name='agmt']").each(function() {
		        if (!this.checked) {
		            allChecked = false;
		            return false; // each 루프 종료
		        }
		    });

		    // 전체 체크 버튼에 상태 반영
		    $("#agmt-all").prop("checked", allChecked);
		});
		
		
		// 할인정보 리셋 시 결제정보에도 반영
		$("#discount_reset").click(function() {
			$("#final_amount").html("${total_fee}");		// 총 결제금액 적용 값
 			$("#discount_sum").html(0);		// 총 할인 적용 값
 			$("#point_apply").html(0);		// 총 할인 적용 값
 			$("#coupon_apply").html(0);		// 총 할인 적용 값
			
		});
		
		
		
	}); // $(function() {}
 	
 
	// 결제 버튼 클릭 시 결제처리 요청함수
	function goPayment() {
		console.clear();
		console.log('goPayment() 호출됨');
		
		event.preventDefault();
		
		// 폼 유효성 검사
	    let form = document.forms['payForm'];
	    if (!form.checkValidity()) {
	        alert("이용 약관 동의 필수!");
	        $("#agmt-all").focus();
	        
	        return;
	    }
		
		let IMP = window.IMP;   // 생략 가능
 		IMP.init("imp00262041"); // 예: imp00000000 
 		
 		let pg = document.querySelector("input[name=pg]:checked").value;
 		let productName = "부기무비 영화 예매 / ${scs.movie_name}";
 		let amount = parseInt(document.querySelector("#final_amount").innerText);	
 		let member_email = "${member.member_email}";
 		let member_name = "${member.member_name}";
 		let member_tel = "${member.member_tel}";
 		
 		
		// IMP.request_pay 결제창 호출
 	    IMP.request_pay(
 	        {
 	            pg: pg,
 	            pay_method: "card",
 	            merchant_uid: "order_" + new Date().getTime(),
 	            name: productName,
 	            amount: amount,
 	            buyer_email: member_email,
 	            buyer_name: member_name,
 	            buyer_tel: member_tel
 	        },
 	        function (rsp) {
 	            console.log(rsp);

 	            if(rsp.success) {
	                
 	                verifyAndSavePayInfo(rsp.imp_uid, rsp.merchant_uid);

 	            } else {
 	                alert("결제에 실패하였습니다. ${rsp.error_code} : ${rsp.error_msg}");
	                
 	            } // if-else

 	        } // function(rsp)

 	    ); // .request_pay
		
		
		
	}; // goPayment()
	

	// 결제검증 후 DB업데이트
	function verifyAndSavePayInfo(imp_uid, merchant_uid) {
		console.log('verifyAndSavePayInfo() 호출됨');
		
		let use_point =  document.querySelector("#point_apply").innerText;
		let couponInput = document.querySelector('input[name=select]:checked');
		let coupon_num = couponInput ? couponInput.id : 0;
		let member_id = "${member.member_id}";
		let amount = parseInt(document.querySelector("#final_amount").innerText);	
		
		let movie_name = "${scs.movie_name}";
		let theater_name = "${scs.theater_name}";
		let screen_cinema_num = "${scs.screen_cinema_num}";
		let selected_seats = "${selected_seats}";
		let start_time = "${scs.scs_start_time}";
		let end_time = "${scs.scs_end_time}";
		let person_info = "${person_info}";
		let scs_num = "${scs.scs_num}";
		let keyword = "${keyword}";
		
		
		
	    const params = {
	        "use_point": use_point,
	        "coupon_num": coupon_num,
	        "member_id" : member_id,
	        "amount" : amount,
	        "movie_name": movie_name,
	        "theater_name" : theater_name,
	        "screen_cinema_num" : screen_cinema_num,
	        "scs_start_time" : start_time,
	        "scs_start_time" : end_time,
	        "person_info" : person_info,
	        "selected_seats" : selected_seats,
	        "scs_num" : scs_num,
	        "keyword" : keyword
	    }
	    
	    $.ajax({

	        type: "POST",
	        url: "payVerify" + imp_uid,
	        data: params,
	        success: function(payVerify) {
	            console.log(payVerify);

	            if(payVerify) {
	                location.href = "success_reserve" + merchant_uid;

	            } else {
	                alert('처리 중 오류가 발생하였습니다. 다시 시도해 주세요');

	            } // if-else
	
	        }, // success
	        error : function() {
				console.log("AJAX 요청 에러 발생!");
			}

	    }) // .ajax

	} // savePayInfo
	
	

</script>
</body>
</html>