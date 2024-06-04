<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>극장 등록 폼</title>
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
				<h4 class="mb-4">새 극장 등록</h4>
				<form class="validation-form" name="fr" novalidate action="admin_theater_pro" method="post" > <!-- onsubmit="return confirm('극장을 등록하시겠습니까?');" -->
					<div class="mb-3">
						<label for="movie_name">극장명</label> 
						<input type="text" id="movie_name" class="form-control"  name="theater_name" required maxlength="30"/>
						<div class="invalid-feedback">극장명을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_director">극장 주소</label> 
						<input type="text" id="movie_director" class="form-control" name="theater_address" required maxlength="100"/>
						<div class="invalid-feedback">극장 주소를 입력해주세요.</div>
					</div>
					<div class="mb-3"> 
						<label for="movie_director">극장 좌표</label> 
						<div style="display: flex;">
							<span class="input-group-text">X좌표</span>
							<input type="text" id="movie_director" class="form-control ping" name="theater_map_x"  required placeholder="00.0000000"
								 pattern="^[0-9]+(\.[0-9]+)?$" title="double 타입"  style="width: 300px; margin-right: 30px;" />
							<span class="input-group-text">Y좌표</span>
							<input type="text" id="movie_director" class="form-control ping"  name="theater_map_y"  required placeholder="00.0000000"
								 pattern="^[0-9]+(\.[0-9]+)?$" title="double 타입" style="width: 300px;"/>
						</div>
						<div class="invalid-feedback" >극장 좌표를 입력하세요</div>
						<div id="pingArea"></div>
					</div>
					<div class="mb-3">
						<label for="theater_floor_info">층 정보</label>
						<div class="form-floating">
							<textarea class="form-control" id="theater_floor_info" name="theater_floor_info" required maxlength="200"  style="height: 100px"></textarea>
							<label for="theater_public_bus">최대 200자</label>
						</div>
						<div class="invalid-feedback">층 정보를 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="theater_parking_info">주차 정보</label> 
						<div class="form-floating">
							<textarea class="form-control" id="theater_parking_info" name="theater_parking_info" required maxlength="800" style="height: 200px;"></textarea>
							<label for="theater_public_bus">최대 800자</label>
						</div>
						<div class="invalid-feedback">주차 정보를 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="theater_parking_fee">주차 요금</label> 
						<div class="form-floating">
							<textarea class="form-control" id="theater_parking_fee" name="theater_parking_fee" required maxlength="500" style="height: 150px;"></textarea>
							<label for="theater_public_bus">최대 500자</label>
						</div>
						<div class="invalid-feedback">주차 요금을 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="theater_public_bus">버스 교통 정보</label>
						<div class="form-floating">
							<textarea class="form-control" id="theater_public_bus" name="theater_public_bus" required maxlength="300" style="height: 100px;"></textarea>
							 <label for="theater_public_bus">최대 300자</label>
						</div>
						<div class="invalid-feedback">버스 교통 정보를 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="theater_public_subway">지하철 교통 정보</label> 
						<div class="form-floating">
							<textarea class="form-control" id="theater_public_subway" name="theater_public_subway" required maxlength="200" style="height: 100px;"></textarea>
							<label for="theater_public_bus">최대 200자</label>
						</div>
						<div class="invalid-feedback">지하철 교통 정보를 입력하세요</div>
					</div>
					<div class="mb-3">
						<label for="movie_genre">운영시간</label> 
						<input type="text" id="movie_genre" class="form-control" name="theater_hours"  required maxlength="200" placeholder="예 : 9:00 ~ 01:00 / 마지막 상영 시간에 따라 유동적"/>
						<div class="invalid-feedback">운영시간을 입력해주세요.</div>
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4" align="center">
						<input type="reset" value="다시작성" class="btn btn-secondary btn-lg btn-block" >
						<input type="button" value="돌아가기" class="btn btn-secondary btn-lg btn-block" onclick="history.back()">
						<input type="submit" value="등록하기" class="btn btn-primary btn-lg btn-block"> <!--  onclick="submitAlert()" -->
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
			if(confirm("극장을 등록하시겠습니까?")) {
				return true;
			} 
			
			return false;
		}
		
		$(function() {
			
			$(".ping").on("keyup",function() {
				let ping = $(this).val();
				let regex = /^[0-9]+(\.[0-9]+)?$/;
				
				if(!regex.exec(ping)) {
					$("#pingArea").text("boolean 형식만 입력 가능");
					$("#pingArea").css("color","red");
					$(this).val("");
				} else {
					$("#pingArea").text("");
				}
				
				
			});
			
			$(".ping").on("change",function() {
				let ping = $(this).val();
				let regex = /^[0-9]+(\.[0-9]+)?$/;
				
				if(!regex.exec(ping)) {
					$("#pingArea").text("boolean 형식만 입력 가능");
					$("#pingArea").css("color","red");
					$(this).val("");
				} else {
					$("#pingArea").text("");
				}
				
			});
			
			
		})
		
		
 	</script>
</body>
</html>