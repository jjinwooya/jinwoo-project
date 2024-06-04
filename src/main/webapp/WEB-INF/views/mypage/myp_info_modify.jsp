<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 회원정보수정</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myp_info_modify.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
</style>

<body>
<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>
<div class="container1">
	<div class="container2">
		<div class="row">
			<div class="col-md-2">
				<jsp:include page="../inc/myp_aside.jsp"></jsp:include>
			</div>	<!-- col-md-2 사이드바  -->
			<div class="col-md-9">
				<h2>회원정보수정</h2>
				<hr>
				<form action="myp_info_modify_pro" method="post" name="fr">
					<div class="box1">
						
						<div class="box5">
				   			<label for="member_name"><b>이름</b></label>
						</div>
					  	<div class="form_item w-75">
					    	<input type="text" name="member_name" id="member_name" value="${member.member_name}" placeholder="이름을 입력" readonly>
					    </div><!-- form item -->
						<div class="box5">
				   			<label for="member_id"><b>아이디</b></label>
				   		</div>
					  	<div class="form_item w-75">
				    		<input type="text"  placeholder="아이디 입력" name="member_id" id="member_id" title="영문대소문자, 숫자, _ 조합 4~16자리" pattern="^[A-Za-z0-9]\w{3,15}$" value="${member.member_id}" readonly required>
					    </div><!-- form item -->
						<div class="box5">
			   				<label for="member_pwd"><b>새 비밀번호</b></label>
			   			</div>
					  	<div class="form_item w-75">
					    	<input type="password" placeholder="비밀번호 입력" name="member_pwd" id="member_pwd">
						    <div class="box4">
					    		<span id="msg_pwd"></span>
							</div>
					    </div><!-- form item -->
						
						<div class="box5">
			   				<label for="member_pwd2"><b>새 비밀번호확인</b></label>
					  	</div>
					  	<div class="form_item w-75 ">
					    	<input type="password" placeholder="비밀번호 확인" name="member_pwd2" id="member_pwd2">
		    			    <div class="box4">
				    	   		<span id="msg_pwd2" style="color: red;"></span>
				    	    </div>
					    </div><!-- form item -->
						
						<div class="box5">
			   				<label for="member_birth"><b>생년월일</b></label>
						</div>
					  	<div class="form_item w-75">
					    	<input type="text" placeholder="생년월일" name="member_birth" id="member_birth" readonly required value="${member.member_birth}">
			    	    	<span id="msg_birth"></span>
					    </div><!-- form item -->
					    
						<div class="box5">
			   				<label for="member_addr"><b>주소</b></label>
			   			</div>
					  	<div class="form_item w-75">
							    <input type="text" id="post_code" name="member_post_code" size="6" readonly onclick="search_address()" value="${member.member_post_code }"  required placeholder="클릭 시 주소검색">
								<input type="text" id="address1" name="member_address1" placeholder="기본주소" size="25" required value="${member.member_address1 }"  readonly onclick="search_address()"><br>
								<input type="text" id="address2" name="member_address2" placeholder="상세주소" size="25" required pattern="^.{2,20}$" maxlength="20" value="${member.member_address2 }">
					    	<div class="box4">
					    		<span id="msg_addr"></span>	
					    	</div>
					    </div><!-- form item -->
					
						<div class="box5">
				   			<label for="member_email"><b>Email</b></label>
						</div>
					  	<div class="form_item w-75">
					    	<input type="text" placeholder="이메일 입력" name="member_email" id="member_email" required value="${member.member_email}">
							<div class="box4">
		 				    	<span id="msg_email"></span>
		 				    </div>
					    </div><!-- form item -->
					
						<div class="box5">
			   				<label for="member_tel"><b>전화번호</b></label>
			   			</div>
					  	<div class="form_item w-75">
					    	<input type="text" placeholder="-를 제외한 전화번호를 입력해주세요" name="member_tel" required id="member_tel" value="${member.member_tel}">
							<div class="box4">
								<span id="msg_tel"></span>
							</div>
					    </div><!-- form item -->
					    
			    		<div class="row">
							<div class="box5">
								<label for="movie_genre"><b>영화취향</b></label>
							</div>
							<div class="col-md-6 box3">
							    <c:set var="genres" value="${fn:split(member.member_movie_genre, '/')}"/>
							    <div class="col-md-2"><label><input type="checkbox" class="form-check-input" value="공포" name="member_movie_genre" <c:if test="${fn:contains(member.member_movie_genre, '공포')}">checked</c:if>>공포</label></div>
							    <div class="col-md-2"><label><input type="checkbox" class="form-check-input" value="코믹" name="member_movie_genre" <c:if test="${fn:contains(member.member_movie_genre, '코믹')}">checked</c:if>>코믹</label></div>
							    <div class="col-md-2"><label><input type="checkbox" class="form-check-input" value="액션" name="member_movie_genre" <c:if test="${fn:contains(member.member_movie_genre, '액션')}">checked</c:if>>액션</label></div>
							    <div class="col-md-2"><label><input type="checkbox" class="form-check-input" value="범죄" name="member_movie_genre" <c:if test="${fn:contains(member.member_movie_genre, '범죄')}">checked</c:if>>범죄</label></div>
							    <div class="col-md-2"><label><input type="checkbox" class="form-check-input" value="SF" name="member_movie_genre" <c:if test="${fn:contains(member.member_movie_genre, 'SF')}">checked</c:if>>SF</label></div>
							    <div class="col-md-2"><label><input type="checkbox" class="form-check-input" value="코미디" name="member_movie_genre" <c:if test="${fn:contains(member.member_movie_genre, '코미디')}">checked</c:if>>코미디</label></div>
							    <div class="col-md-2"><label><input type="checkbox" class="form-check-input" value="스릴러" name="member_movie_genre" <c:if test="${fn:contains(member.member_movie_genre, '스릴러')}">checked</c:if>>스릴러</label></div>
							    <div class="col-md-2"><label><input type="checkbox" class="form-check-input" value="전쟁" name="member_movie_genre" <c:if test="${fn:contains(member.member_movie_genre, '전쟁')}">checked</c:if>>전쟁</label></div>
							    <div class="col-md-2"><label><input type="checkbox" class="form-check-input" value="스포츠" name="member_movie_genre" <c:if test="${fn:contains(member.member_movie_genre, '스포츠')}">checked</c:if>>스포츠</label></div>
							</div>
					    </div>
					</div><!-- box1 -->
					<div class="d-grid gap-2 col-3 box2">
						  <button class="btn btn-outline-primary btn-lg" type="submit" onclick="myp_info_modify_pro">수정완료</button>
					</div> <!-- d-grid gap-2 col-3 box2 -->
				</form>
			</div><!-- col-md-9 -->
		</div><!-- row -->
	</div><!-- container2 -->
</div><!-- container1  -->	
	<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
	</footer>
	
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
	
	<script>

	$(document).ready(function() {
	    let riskCount = 0;

	    // 비밀번호 입력값 변경 시
	    $("#member_pwd").on("input", function() {
	        validatePassword();
	        validatePasswordConfirmation();
	        checkFormValidity(); // 폼 유효성 검사 실행
	    });

	    // 비밀번호2 입력값 변경 시
	    $("#member_pwd2").on("input", function() {
	        validatePasswordConfirmation();
	        checkFormValidity(); // 폼 유효성 검사 실행
	    });

	    // 상세주소 입력값 변경 시
	    $("#address2").on("input", function() {
	        validateAddress2();
	        checkFormValidity(); // 폼 유효성 검사 실행
	    });

	    // 이메일 입력값 변경 시
	    $("#member_email").on("input", function() {
	        validateEmail();
	        checkFormValidity(); // 폼 유효성 검사 실행
	    });

	    // 전화번호 입력값 변경 시
	    $("#member_tel").on("input", function() {
	        validateTel();
	        checkFormValidity(); // 폼 유효성 검사 실행
	    });

	    // 초기 폼 유효성 검사
	    checkFormValidity();

	    function validatePassword() {
	        let pwd = $("#member_pwd").val();
	        let msg = "";
	        let color = "";
	        let lengthRegx = /^[A-Za-z0-9!@#$%]{8,16}$/;
	        
	        
	        if (pwd === "") {
	            msg = "";
	            color = "";
	        } else if (!lengthRegx.exec(pwd)) {
	            msg = "영문자, 숫자, 특수문자(!, @, #, $)를 포함한 8~16자리를 입력해주세요";
	            color = "RED";
	            riskCount = 0;
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
	                    riskCount = 4;
	                    break;
	                case 3:
	                    msg = "보통";
	                    color = "Orange";
	                    riskCount = 3;
	                    break;
	                case 2:
	                    msg = "위험";
	                    color = "RED";
	                    riskCount = 2;
	                    break;
	                default:
	                    msg = "영문자, 숫자, 특수문자(!, @, #, $)를 포함한 8~16자리를 입력해주세요";
	                    color = "RED";
	                    riskCount = 0;
	            }
	        }
	        $("#msg_pwd").text(msg);
	        $("#msg_pwd").css("color", color);
	    }

	    function validatePasswordConfirmation() {
	        let pwd = $("#member_pwd").val();
	        let pwd2 = $("#member_pwd2").val();
			
            $("#msg_pwd2").css("color", "red");
			
	        if (pwd2 != pwd) {
	            $("#msg_pwd2").text("비밀번호가 일치하지 않습니다");
	        } else if (pwd2 == ""){
	            $("#msg_pwd2").empty();
	        	
	        }else {
	            $("#msg_pwd2").text("비밀번호가 일치합니다");
	            $("#msg_pwd2").css("color", "green");
	        } 
	        
	        message.style.color = color;
	        
	    }
	        
	    function validateAddress2() {
	        let address2 = $("#address2").val();
	        let regex = /^.{2,20}$/g;
        	$("#msg_addr").css("color", "red");

	        if(address2 == "") {
	        	$("#msg_addr").text("상세주소를 입력하세요");
	        } else if (!regex.test(address2)) {
	        	$("#msg_addr").text("모든 문자 2~20 글자를 입력해주세요");
	        } else {
	        	$("#msg_addr").empty();
	        	
	        }
	        
	    }

	    function validateEmail() {
	        let email = $("#member_email").val();
	        let length = email.split('@')[0].length;
			
	        if (email == ""){
	            $("#msg_email").text("이메일 주소를 입력해주세요");
	            $("#msg_email").css("color", "red");
	        } else if (length < 4){
	            $("#msg_email").text("이메일 주소는 최소 4글자 이상이여야 합니다");
	            $("#msg_email").css("color", "red");
	        } else {
	        	
		        let regex = /^[a-zA-Z0-9._%+-]{4,20}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/g;
		        
		        if (!regex.test(email)) {
	           		$("#msg_email").css("color", "red");
		            $("#msg_email").text("이메일 형식을 맞춰 입력해주세요 (example@example.exam)");
	        	} else {
		            $("#msg_email").empty();
		        }
		        
	        }
        }

	    function validateTel() {
	        let tel = $("#member_tel").val();
	        let regex = /^010\d{8}$/g;

	        if (!regex.test(tel)) {
	            $("#msg_tel").text("전화번호 형식이 맞지 않습니다(예: 01000000000)");
	            $("#msg_tel").css("color", "red");
	        } else {
	            $("#msg_tel").empty();
	        }
	    }

	    // 폼 유효성 검사 함수
	    function checkFormValidity() {
	        let pwdIsValid = $("#member_pwd").val() === "" || /^.{8,16}$/.test($("#member_pwd").val());
	        let pwd2IsValid = $("#member_pwd2").val() === "" || $("#member_pwd2").val() === $("#member_pwd").val();
	        let address2IsValid = /^.{2,20}$/.test($("#address2").val());
	        let emailIsValid = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test($("#member_email").val());
	        let telIsValid = /^010\d{8}$/.test($("#member_tel").val());
	        let isPasswordStrong = $("#member_pwd").val() === "" || riskCount > 1;
			
	        if (pwdIsValid && pwd2IsValid && address2IsValid && emailIsValid && telIsValid && isPasswordStrong) {
	            $("button[type='submit']").prop("disabled", false); // submit 버튼 활성화
	        } else {
	            $("button[type='submit']").prop("disabled", true); // submit 버튼 비활성화
	        }
	    }

	    // 초기 폼 유효성 검사
	    checkFormValidity();
	});
	
	
	</script>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
	    function search_address() {
	        new daum.Postcode({ // daum.Postcode 객체 생성
	        	// 주소검색 창에서 주소 검색 후 검색된 주소를 사용자가 클릭하면
	        	// oncomplete 이벤트에 의해 해당 이벤트 뒤의 익명함수가 실행(호출됨)
	        	// => 사용자가 호출하는 것이 아니라 API 가 함수를 호출하게 됨(callback(콜백) 함수)
// 	            oncomplete: function(data) {
// 	                // 클릭(선택)된 주소에 대한 정보(객체)가 익명함수 파라미터 data 에 전달됨
// 	                // => data.xxx 형식으로 각 주소 정보에 접근 가능
// 	                console.log(data);
// 	                // 1) 우편번호(= 국가기초구역번호 = zonecode 속성값) 가져와서 
// 	                //    우편번호 입력란(postCode)에 출력
// 	                document.fr.post_code.value = data.zonecode;
	        		
// 	        		// 2) 기본주소(address 속성값) 가져와서 기본주소 항목(address1)에 출력
// // 	        		document.fr.address1.value = data.address; // 기본주소
// // 	        		document.fr.address1.value = data.roadAddress; // 도로명주소
	        		
// 	        		// 만약, 해당 주소에 대한 건물명(buildingName 속성값)이 존재할 경우(널스트링 아닐 때)
// 	        		// 기본주소 뒤에 건물명을 결합하여 출력
// 	        		// ex) 기본주소 : 부산 부산진구 동천로 109
// 	        		//     건물명 : 삼한골든게이트
// 	        		//     => 부산 부산진구 동천로 109 (삼한골든게이트)
// 	        		let address = data.address; // 기본주소 변수에 저장
	        		
// 	        		// 건물명이 존재할 경우(buildingName 속성값이 널스트링이 아닐 경우)
// 	        		// 기본주소 뒤에 건물명 결합
// 	        		if(data.buildingName != "") {
// 	        			address += " (" + data.buildingName + ")";
// 	        		}
	        		
// 	        		// 기본주소 출력
// 	        		document.fr.member_addr.value = address;
	        		
// 	        		// 상세주소 입력 항목에 커서 요청
// 	        		document.fr.member_addr.focus();
					// ---------------------------------------------------
					oncomplete: function(data) {

	        		console.log(data); // 반환되는 데이터를 콘솔에 출력하여 데이터 구조를 확인합니다.
					let address = data.address; // 기본주소를 가져옵니다.

					// 건물명이 존재할 경우 기본주소 뒤에 추가합니다.
					if(data.buildingName !== "") {
					address += " (" + data.buildingName + ")";
					}
					document.fr.address2.value="";
					// 주소 정보에서 우편번호를 가져옵니다.
// 					let zonecode = data.zonecode;
	                document.fr.post_code.value = data.zonecode;
					
					// 우편번호와 주소를 입력란에 설정합니다.
// 					document.getElementById('member_addr').value = zonecode + ' ' + address;
	        		document.fr.address1.value = address;
					
					// 창을 닫습니다.
// 					this.modal.close();      		
					document.fr.address2.focus();// 상세주소 입력 항목에 커서 요청
					
					}
	        }).open();
	    }
	</script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js">
<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script> -->
</body>
</html>