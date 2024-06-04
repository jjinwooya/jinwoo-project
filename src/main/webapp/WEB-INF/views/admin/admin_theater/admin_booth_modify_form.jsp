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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>

<script type="text/javascript">
	$(function() {
		
		$("#selectTheater").change(function() {
			let domain = $("#selectTheater").val();
			$("#theater_name").val(domain);
			
			console.log("domain : " + domain)
			
		});
		
	});

</script>

</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">상영관 정보 수정</h4>
				<form class="validation-form" novalidate action="admin_booth_modify" method="post" name="fr">
					<div class="mb-3">
						<label for="theater_name">극장 지점명</label> 
							<div class="input-group mb-3">
								<input type="text" id="theater_name" name="theater_name" class="form-control" required readonly value="${screenInfo.theater_name}"/>
								<label class="input-group-text" for="inputGroupSelect01">지점선택</label>
								<select class="form-select" id="selectTheater">
									<option>극장을 선택하세요</option>
									<c:forEach var="theater" items="${theaterList}"> 
										<option value="${theater.theater_name}">${theater.theater_name}</option>
									</c:forEach>
  								</select>
							</div>
						<div class="invalid-feedback">극장 지점명 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_code">상영관 번호</label> 
							<div class="input-group mb-3">	
								<span class="input-group-text">고정 값</span>
								<input type="text" id="movie_code" name="screen_num" class="form-control" readonly value="${screenInfo.screen_num}"/> 
							</div>	
						<div class="invalid-feedback">상영관 번호 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_name">상영관 이름</label> 
							<div class="input-group mb-3">	
								<span class="input-group-text">관 번호</span>
								<input type="text" id="movie_name" name="screen_cinema_num"  class="form-control" required value="${screenInfo.screen_cinema_num}"
									pattern="^[0-9]$" title="숫자만 입력 가능"/> 
								<span class="input-group-text">관</span>
							</div>
						<div class="invalid-feedback">상영관 이름을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_createDate">상영관 크기</label>
						<div class="input-group mb-3">
							<span class="input-group-text" >최대 행</span>
							<input type="text" id="movie_createDate" name="screen_seat_row" class="form-control" 
									 value="${screenInfo.screen_seat_row}" required maxlength="2" placeholder="숫자 입력"/>
						</div>
						<div id="rowArea"></div>	
						<div class="input-group mb-3">	
							<span class="input-group-text">최대 열</span>
							<input type="text" id="movie_createDate" name="screen_seat_col" class="form-control" required maxlength="2" placeholder="숫자 입력"
						 			value="${screenInfo.screen_seat_col}" />
						</div>
						<div id="colArea"></div>	
						<div class="invalid-feedback">상영관크기를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_genre">운영 상태</label> 
							<div class="input-group mb-3">	
								<label class="input-group-text" for="screen_info_status">1 : 정상 / 2 : 휴관</label>
								<select class="form-select form-control" id="screen_info_status" name="screen_status" required>
								    <c:choose>
								        <c:when test="${screenInfo.screen_status eq 1}">
								            <option value="1" selected>1</option>
								            <option value="2">2</option>
								        </c:when>
								        <c:otherwise>
								            <option value="1">1</option>
								            <option value="2" selected>2</option>
								        </c:otherwise>
								    </c:choose>
								</select>
							</div>
							<div class="invalid-feedback">운영 상태를 입력해주세요.</div>
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4" align="center">
						<input type="button" value="상영관삭제" class="btn btn-danger btn-lg btn-block" onclick="boothWithdraw(${screenInfo.screen_num})">
						<input type="reset" value="다시작성" class="btn btn-secondary btn-lg btn-block" >
						<input type="button" value="돌아가기" class="btn btn-secondary btn-lg btn-block" onclick="history.back()">
						<input type="submit" value="수정하기" class="btn btn-primary btn-lg btn-block">
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
			if(confirm("상영관 수정 정보를 등록하시겠습니까?")) {
				return true;
			} 
			
			return false;
		}
	    
	    function boothWithdraw(num) {
			if(confirm("정말 상영관을 삭제하시겠습니까?")){
				location.href="admin_booth_delete?screen_num=" + num;
			}
		}
	    
		$(function() {
			$("#screen_seat_col").on("input", function() {
				let inputNumber = $(this).val();
				let regex = /^[1-9][0-9]?$/; // 두 자리 숫자 정규식
				
				if (!regex.test(inputNumber)) {
				    $(this).val("");
				    $("#colArea").text("2자리 숫자만 입력 가능");
				    $("#colArea").css("color", "red");
				} else {
				    $("#colArea").text("");
				}
			}).on("blur", function() {
				let inputNumber = $(this).val();
				let regex = /^[1-9][0-9]?$/; // 두 자리 숫자 정규식
				
				if (regex.test(inputNumber)) {
				    let alphabet = String.fromCharCode(64 + parseInt(inputNumber));
				    $(this).val(alphabet);
				}
			});

		
		    $("#screen_seat_row").on("input", function() {
		        let inputRow = $(this).val();
		        let regex = /^[1-9][0-9]?$/; // 두 자리 숫자 정규식
		        
		        if (!regex.test(inputRow)) {
		            $(this).val("");
		            $("#rowArea").text("2자리 숫자만 입력 가능");
		            $("#rowArea").css("color", "red");
		        } else {
		            $("#rowArea").text("");
		        }
		    });
		});
 	</script>
</body>
</html>