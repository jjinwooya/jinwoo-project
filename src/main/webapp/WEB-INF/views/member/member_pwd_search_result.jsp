<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 회원가입</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
</style>
</head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/member_default.css" rel="stylesheet" type="text/css">
<body>
<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>

<section class="member_section">
	<div class="member_title">
		<h3>새로운 비밀번호 입력</h3>
	    <hr>
	</div>
<form action="member_pwd_update" method="post">
	<div class="member_row">
	
	    <div class="form_item">
	    	<label for="member_pwd"><b>비밀번호</b></label>
	    	<input type="password"  name="member_pwd" id="member_pwd" required maxlength="20">
	    	<span id="msg_pwd1"></span>
	    </div>
	    <div class="form_item">
	    	<label for="member_pwd2"><b>비밀번호 확인</b></label>
	    	<input type="password"  name="member_pwd2" id="member_pwd2" required maxlength="20">
	    	<span id="msg_pwd2"></span>
	    </div>
		<input type="hidden" value="${member_id }" id ="member_id" name = "member_id">
		<div class="regist_final">
			<hr>
	    	<button type="submit" class="btn btn-outline-primary">비밀번호 바꾸기</button>
		</div>
	</div>
</form>

</section>

<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>
	<script>
	
	$(document).ready(function() {
	    // 비밀번호 입력값 변경 시
		$("#member_pwd").on("input", function() {
		    let pwd = $("#member_pwd").val();
		    let msg = "";
		    let color = "";
		    let lengthRegx = /^[A-Za-z0-9!@#$%]{8,16}$/;
		
		    if (!lengthRegx.exec(pwd)) {
		        msg = "영문자, 숫자, 특수문자(!, @, #, $)를 포함한 8~16자리를 입력해주세요";
		        color = "RED";
		    } else {
		        let engUpperRegex = /[A-Z]/;
		        let engLowerRegex = /[a-z]/;
		        let numRegex = /\d/;
		        let specRegex = /[!@#$%]/;
		        let count = 0;
		
		        if (engUpperRegex.exec(pwd)) count++;
		        if (engLowerRegex.exec(pwd)) count++;
		        if (numRegex.exec(pwd)) count++;
		        if (specRegex.exec(pwd)) count++;
		
		        switch (count) {
		            case 4:
		                msg = "안전";
		                color = "Green";
		                break;
		            case 3:
		                msg = "보통";
		                color = "Orange";
		                break;
		            case 2:
		                msg = "위험";
		                color = "RED";
		                break;
		            default:
		                msg = "영문자, 숫자, 특수문자(!, @, #, $)를 포함한 8~16자리를 입력해주세요";
		                color = "RED";
		        }
		    }
		
		    $("#msg_pwd1").text(msg);
		    $("#msg_pwd1").css("color", color);
		
		    checkFormValidity(); // 폼 유효성 검사 실행
		});
	    
	    // 비밀번호2 입력값 변경 시
	    $("#member_pwd2").on("input", function() {
	    	let pwd = $("#member_pwd").val();
	        let pwd2 = $("#member_pwd2").val();
	        
	        if (pwd2 != pwd) {
	            $("#member_pwd2").css("background-color", "red");
	            $("#msg_pwd2").text("비밀번호가 일치하지 않습니다");
	        } else {
	            $("#member_pwd2").css("background-color", ""); // 원래의 배경색으로 돌아갑니다 (빈 문자열로 설정)
	            $("#msg_pwd2").empty();
	        }
	
	        checkFormValidity(); // 폼 유효성 검사 실행
	    });
		    // 폼 유효성 검사 함수
		    function checkFormValidity() {
		        let pwdIsValid = /^.{8,16}$/.test($("#member_pwd").val());
		        let pwd2IsValid = /^.{8,16}$/.test($("#member_pwd2").val());
				let pwdMatch = pwdIsValid === pwd2IsValid;
				
		        if (pwdIsValid && pwd2IsValid && pwdMatch) {
		            $("button[type='submit']").prop("disabled", false); // submit 버튼 활성화
		        } else {
		        	$("button[type='submit']").prop("disabled", true); // submit 버튼 비활성화
		        }
			}
	});
	
</script>
</body>
</html>

