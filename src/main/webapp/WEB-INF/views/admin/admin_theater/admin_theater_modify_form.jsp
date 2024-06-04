<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영관 수정 폼</title>
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/admin_form.css" rel="stylesheet" type="text/css">
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">극장 정보 수정</h4>
				<form class="validation-form" novalidate action="admin_theater_modify" method="post"  name="fr"> <!-- onsubmit="return confirm('극장 정보를 등록하시겠습니까?');" -->
					<div class="mb-3">
<!-- 						<label for="movie_name">극장 번호</label>  -->
						<input type="hidden" id="movie_name" class="form-control" name="theater_num" readonly value="${theater.theater_num}"/>
<!-- 						<div class="invalid-feedback">자동 입력 값</div> -->
					</div>
					<div class="mb-3">	
						<label for="movie_name">극장명</label> 
						<input type="text" id="movie_name" class="form-control ping" name="theater_name" required maxlength="30" value="${theater.theater_name}"/>
						<div class="invalid-feedback">극장명을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_director">극장 주소</label> 
						<input type="text" id="movie_director" class="form-control ping" name="theater_address" required maxlength="100" value="${theater.theater_address}"/>
						<div class="invalid-feedback">극장 주소를 입력해주세요.</div>
					</div>
					<div class="mb-3"> 
						<label for="movie_director" >극장 좌표</label> 
						<div style="display: flex;">
							<span class="input-group-text">X좌표</span>
							<input type="text" id="movie_director" class="form-control" name="theater_map_x"  required 
								value="${theater.theater_map_x}"  pattern="^[0-9]+(\.[0-9]+)?$" title="double 타입"  style="width: 300px; margin-right: 30px;" />
							<span class="input-group-text">Y좌표</span>	
							<input type="text" id="movie_director" class="form-control"  name="theater_map_y"  required 
								 value="${theater.theater_map_y}"  pattern="^[0-9]+(\.[0-9]+)?$" title="double 타입" style="width: 300px;"/>
						</div>
						<div class="invalid-feedback" id="pingArea">극장 좌표를 입력하세요</div>
						<div id="pingArea"></div>
					</div>
					<div class="mb-3">
						<label for="theater_floor_info">층 정보</label>
						<div class="form-floating">
							<textarea class="form-control" id="theater_floor_info" name="theater_floor_info" required maxlength="200"  style="height: 100px">${theater.theater_floor_info}</textarea>
							<label for="theater_public_bus">최대 200자</label>
						</div>
						<div class="invalid-feedback">층 정보를 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="theater_parking_info">주차 정보</label> 
						<div class="form-floating">
							<textarea class="form-control" id="theater_parking_info" name="theater_parking_info" required maxlength="800" style="height: 200px;">${theater.theater_parking_info}</textarea>
							<label for="theater_public_bus">최대 800자</label>
						</div>
						<div class="invalid-feedback">주차 정보를 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="theater_parking_fee">주차 요금</label> 
						<div class="form-floating">
							<textarea class="form-control" id="theater_parking_fee" name="theater_parking_fee" required maxlength="500" style="height: 150px;">${theater.theater_parking_fee}</textarea>
							<label for="theater_public_bus">최대 500자</label>
						</div>
						<div class="invalid-feedback">주차 요금을 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="theater_public_bus">버스 교통 정보</label>
						<div class="form-floating">
							<textarea class="form-control" id="theater_public_bus" name="theater_public_bus" required maxlength="300" style="height: 100px;">${theater.theater_public_bus}</textarea>
							 <label for="theater_public_bus">최대 300자</label>
						</div>
						<div class="invalid-feedback">버스 교통 정보를 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="theater_public_subway">지하철 교통 정보</label> 
						<div class="form-floating">
							<textarea class="form-control" id="theater_public_subway" name="theater_public_subway" required maxlength="200" style="height: 100px;">${theater.theater_public_subway}</textarea>
							<label for="theater_public_bus">최대 200자</label>
						</div>
						<div class="invalid-feedback">지하철 교통 정보를 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="movie_genre">운영시간</label> 
						<input type="text" id="movie_genre" class="form-control" name="theater_hours" required maxlength="200" value="${theater.theater_hours}"/>
						<div class="invalid-feedback">운영시간을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_genre">운영상태</label> 
						<input type="text" id="movie_genre" class="form-control" name="theater_status" required maxlength="200" pattern="^[0-9]$" title="int 타입" value="${theater.theater_status}"/>
						<div class="invalid-feedback">운영상태를 입력해주세요. (1 = 정상운영, 2 = 미운영 상태)</div>
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4" align="center">
						<input type="button" value="극장삭제" class="btn btn-danger btn-lg btn-block" onclick="theaterWithdraw(${theater.theater_num})">
						<input type="reset" value="다시작성" class="btn btn-secondary btn-lg btn-block" >
						<input type="button" value="돌아가기" class="btn btn-secondary btn-lg btn-block" onclick="history.back()">
						<input type="submit" value="수정하기" class="btn btn-primary btn-lg btn-block" > <!-- onclick="submitAlert()" -->
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
	    
		document.fr.onsubmit=function(){
			if(confirm("극장 수정 정보를 등록하시겠습니까?")) {
				return true;
			} 
			return false;
		}
		
		function theaterWithdraw(num) {
			if(confirm("정말 극장을 삭제하시겠습니까?")){
				location.href="admin_theater_delete?theater_num=" + num;
			}
		}
		
		$(function() {
			$(".ping").on("keyup",function() {
				let ping = $(this).val();
				let regex = /^[0-9]+(\.[0-9]+)?$/;
				
				if(!regex.exec(ping)) {
					$("#pingArea").text("boolean 형식만 입력 가능");
					$("#pingArea").css("color","red");
				} else {
					$("#pingArea").text("");
				}
				
				
			});
			
			
		})
 	</script>
</body>
</html>