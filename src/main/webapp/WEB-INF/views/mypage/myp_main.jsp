<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 마이페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myp_default.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
h6{ 
 	margin-top:30px; 
} 

</style>
</head>
<body>
<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
	<c:if test="${not empty updateMessage}">
	    <script>
	        window.onload = function() {
	        	let message = "<c:out value='${updateMessage}' />";
// 	        	message = message.replace("/\\n/g", "\n");
	        	if (confirm(message)) {
	                // "확인"을 클릭했을 때의 동작
	                location.href="myp_oto_breakdown";
	            } else {
	                // "취소"를 클릭했을 때의 동작
	            }
	        }
	    </script>
	</c:if>
	
	<script type="text/javascript">
		var maxCount = 3;							
		var count = 0;   								
		
		function CountChecked(field){ 					
			if (field.checked) {					
				count += 1;					
			}
			else {							
				count -= 1;					
			}
			
			if (count > maxCount) {					
				alert("최대 3개까지만 선택가능합니다!");
			field.checked = false;						
			count -= 1;									
			}
		}
	</script>
					
</header>
<div class="container1">
	<div class="container2">
		<div class="row box1">
			<div class="col-md-2">
				<jsp:include page="../inc/myp_aside.jsp"></jsp:include>
			</div>	
			<div class="col-md-9">
				<h2>마이페이지</h2>
				<hr>
				<blockquote class="bluejeans">
					<br>
					<div class="main col-5">
						<h3>${member.member_name}님 안녕하세요!</h3>
						<hr>
						<h6>보유중인 포인트 : ${member.member_point}</h6>
					</div>
						<div class="col-6 box3">
							<button type="button" class="btn btn-outline-primary btn-lg" style="left: 20px" onclick="location.href='myp_info_modify'">회원정보수정</button>
						</div>
				</blockquote>
				<hr>
			</div><!-- col-md-10 -->
		</div><!-- row -->
		<div class="row ">
			<div class="col-md-2"> </div>
				<div class="col-md-6">
					<div class="row">
						<div class="col-10">
							<h2>예매내역</h2>
						</div>
						<div class="col-2 box2">
							<button type="button" class="btn btn-outline-primary" onclick="location.href='myp_reservation'">+ 더보기</button>
						</div>
					</div><!-- row -->
					<table class="table2 table table-hover " >
					  <thead>
					    <tr>
					      <th scope="col">#</th>
					      <th scope="col">영화</th>
					      <th scope="col">관람날짜</th>
					      <th scope="col">상영시간</th>
					      <th scope="col">상영관</th>
					      <th scope="col">관람좌석</th>
					      <th scope="col">결제금액</th>
					    </tr>
					  </thead>
					  <tbody>
						<c:choose>
					  		<c:when test="${not empty movieReservation}">
								<c:forEach var="map" items="${movieReservation}" varStatus="status" begin="0" end="4">
									    <tr class="${status.index % 2 == 0 ? 'table-secondary' : ''}">
									        <th scope="row">${status.index + 1}</th>
									        <td>${map.movie_name}</td>
									        <td>${map.scs_date}</td>
									        <td>${map.theater_info}</td>
									        <td>${map.session_time}</td>
									        <td>${map.ticket_seat_info}</td>
									        <td>${map.ticket_pay_price}</td>
									    </tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<td colspan="7" class="align_center">예매내역이 존재하지 않습니다.</td>
							</c:otherwise>
						</c:choose>
					  </tbody>
					</table>
				</div><!-- col-md-6 -->
				
				<div class="col-md-3">
					<div class="row">
						<div class="col-10">
							<h2>MY 극장</h2>
						</div><!-- col-5 -->
						<div class="col-2">
							<img src="${pageContext.request.contextPath}/resources/images/myp_mytheater.png" data-bs-toggle="modal" data-bs-target="#exampleModal" width="25px" height="25px"  onclick="initializeModal()">
						</div><!-- col-7 -->
					</div>	<!-- row -->	
								
					<!-- Modal -->
					<div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
					  <div class="modal-dialog modal-dialog-centered">
					    <div class="modal-content">
					    
					      <div class="modal-header">
					        <h5 class="modal-title" id="exampleModalLabel">MY 극장</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div><!-- modal-header -->
					      
					      <div class="modal-body">
							<div class="form-check">
								<div>
									<c:forEach begin="0" var="theater" items="${theater}">
										      <input onclick="CountChecked(this)" class="form-check-input" value="${theater.theater_name}" type="checkbox" id="${theater.theater_name}" name="theaterId">
											  <label for="${theater.theater_name}">${theater.theater_name}</label><br>
									</c:forEach>
								</div>
							</div>
					      </div><!-- modal-body -->
					      
					      <div class="modal-footer"> <!-- 모달 폼 극장 전체 리스트 -->
								<button type="button" onclick="sendCheckedValues(event)" class="btn btn-outline-primary btn-lg"  class="btn btn-secondary" data-bs-dismiss="modal" name="theaterIds">확인</button>
					      </div><!--modal-footer  --> <!-- 모달 폼 극장 전체 리스트 -->
					    </div><!-- modal-content -->
					  </div> <!-- modal-dialog -->
					</div><!-- modal fade 모달 div 끝 -->
					
					<table class="table3 table table-bordered">
					
						<tr>
							<td>
								<c:choose>
									<c:when test="${empty member.member_my_theater1}"> <!-- 자주가는 영화관 미설정시 -->
										<a href="#">+</a>
									</c:when>
									<c:otherwise>
										<a href="#">${member.member_my_theater1}</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						
						<tr>
							<td>
								<c:choose>
									<c:when test="${empty member.member_my_theater2}">
										<a href="#">+</a>
									</c:when>
									<c:otherwise>
										<a href="#">${member.member_my_theater2}</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						
						<tr>
							<td>
								<c:choose>
									<c:when test="${empty member.member_my_theater3}">
										<a href="#">+</a>
									</c:when>
									<c:otherwise>
										<a href="#">${member.member_my_theater3}</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</table>
				</div><!-- col-md-3-->
		</div> <!-- row -->
	</div><!-- container2 -->
</div><!-- container -->

<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js">

<script type="text/javascript">
	function initializeModal() {
		var myTheaters = [
		  "${member.member_my_theater1}",
		  "${member.member_my_theater2}",
		  "${member.member_my_theater3}"
		];

	    $('.form-check-input').each(function() {
      		var theaterName = $(this).val();
      		if (myTheaters.includes(theaterName)) {
		        $(this).prop('checked', true);
		        count++;
	      	} else {
      			$(this).prop('checked', false);
			}
	    });
	}
	
    function sendCheckedValues(event) {
        var checkedValues = []; // 선택된 체크박스의 값을 저장할 배열
        var checkboxes = document.querySelectorAll('.form-check-input:checked'); // 선택된 체크박스들을 가져옴
        
        checkboxes.forEach(function(checkbox) {
            checkedValues.push(checkbox.value); // 배열에 선택된 체크박스의 값을 추가
        });
						        
	    // checkedValues 배열의 길이가 3이 되도록 null 값 추가
	    while (checkedValues.length < 3) {
	        checkedValues.push(null);
	    }
    
   		var member_id = "${member.member_id}"; // memberId를 가져옴
	    $.ajax({
	        url: "api/myp_my_theater",
	        type: "POST",
	        dataType: "json",
	        contentType: "application/json", // 서버에게 내용이 JSON임을 알려줌
	        data: JSON.stringify({ member_id: member_id, checkedValues: checkedValues }), // JSON 문자열로 변환하여 전송
			success: function(response) {
				if(response){
					alert("나의 극장 정보 등록을 성공하였습니다");
				    location.reload();	
				}
				  
			},
			error: function(xhr, status, error) {
				console.error("Error details:", xhr, status, error); // 디버깅 정보 출력
				console.log("영화등록 실패");
				alert("영화 정보 등록을 실패하였습니다" + error);
				
			}
		});
	}
</script>
</body>
</html>

