<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<body>

<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>

<section class="member_section">
	<div class="member_title">
	    <h3>회원가입</h3>
	    <hr>
    </div>
<form action="member_reg_member_pro" method="post" name="fr" class="needs-validation">
	<div class="member_row">
		
	    <div class="form_item">
	    	<label for="member_name"><b>이름</b></label>
	    	<input type="text"  name="member_name" id="member_name" required  value="${member.member_name }" readonly="readonly">
	    	<span></span>
	    </div>
	
	<label for="member_id"><b>아이디</b></label>
    <input type="text" placeholder="아이디 입력" name="member_id" id="member_id" required autocapitalize="off" maxlength="20">
    <label id="msg_id" class="msg_id"></label><br>
    <label id="msg_dup_id" class="msg_dup_id"></label><br>
    <label for="pwd"><b>비밀번호</b></label>
    <input type="password" placeholder="비밀번호 입력" name="member_pwd" id="member_pwd" required maxlength="16">
    <label id="msg_pwd" class="msg_pwd"></label><br>
    <label for="pwd2"><b>비밀번호 확인</b></label>
    <input type="password" placeholder="비밀번호 확인" name="member_pwd2" id="member_pwd2" required maxlength="16">
    <label id="msg_pwd2" class="msg_pwd2"></label><br>
    <label for="birth"><b>생년월일</b></label>
    <input type="text" placeholder="생년월일" name="member_birth" id="member_birth" required value="${member.member_birth }" readonly="readonly">
    <label id="msg_birth" class="msg_birth"></label><br>	
    <label for="postCode"><b>주소</b></label>
    <input type="text" id="post_code" name="member_post_code" size="6" readonly onclick="search_address()" placeholder="클릭 시 주소검색">
	<input type="text" id="address1" name="member_address1" placeholder="기본주소" size="25" readonly onclick="search_address()"><br>
	<input type="text" id="address2" name="member_address2" placeholder="상세주소" size="25" pattern="^.{2,20}$" maxlength="20">
	<label id="msg_addr" class="msg_addr"></label><br>
    <label for="member_email"><b>Email</b></label>
    <input type="text" placeholder="이메일 입력" name="member_email" id="member_email" required maxlength="30" value="${member.member_email }" readonly="readonly">
    <label id="msg_email" class="msg_email"></label><br>
    <label for="member_tel"><b>전화번호</b></label>
    <input type="text" placeholder="전화번호 입력" name="member_tel" id="member_tel" placeholder="-제외한 전화번호를 입력해주세요" required maxlength="11" onclick="certificationTel()">
    <label id="msg_tel" class="msg_tel"></label><br>
    		<div class="form_item">
			<label for="member_movie_genre"><b>영화취향</b></label>
				<div class="member_movie_genre">
					<label><input type="checkbox" name="member_movie_genre" value="공포">공포</label>
					<label><input type="checkbox" name="member_movie_genre" value="코믹">코믹</label>
					<label><input type="checkbox" name="member_movie_genre" value="액션">액션</label>
					<label><input type="checkbox" name="member_movie_genre" value="범죄">범죄</label>
					<label><input type="checkbox" name="member_movie_genre" value="SF">SF</label>
					<label><input type="checkbox" name="member_movie_genre" value="코미디">코미디</label>
					<label><input type="checkbox" name="member_movie_genre" value="스릴러">스릴러</label>
					<label><input type="checkbox" name="member_movie_genre" value="전쟁">전쟁</label>
					<label><input type="checkbox" name="member_movie_genre" value="스포츠">스포츠</label>
				</div>
			</div>
		<div class="regist_fianl">
			<hr>
			<button type="submit" class="btn btn-outline-primary">가입하기</button>
			<button type="button" class="btn btn-outline-primary" onclick="history.back()">돌아가기</button>
		</div>
	</div>
</form>
</section>

	<footer>
		<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
	</footer>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
	    let riskCount = 0;
	    let dupIdCnt = 0; 
	    
	    // 아이디 입력값 변경 시
	    $("#member_id").on("input", function() {
	        validateIdAndCheckDuplication();
	    });
	
	    // 비밀번호 입력값 변경 시
	    $("#member_pwd").on("input", function() {
	        validatePassword();
	    });
	
	    // 비밀번호2 입력값 변경 시
	    $("#member_pwd2").on("input", function() {
	        validatePasswordConfirmation();
	    });
	
	    // 상세주소 입력값 변경 시
	    $("#member_address2").on("input", function() {
	        validateAddress2();
	    });
	
	    // 이메일 입력값 변경 시
	    $("#member_email").on("input", function() {
	        validateEmail();
	    });
	
	    // 전화번호 입력값 변경 시
	    $("#member_tel").on("input", function() {
	        validateTel();
	    });
	
	    // 초기 폼 유효성 검사
	    checkFormValidity();
	    
	    function validateIdAndCheckDuplication() {
	        let id = $("#member_id").val();
	        let idRegx = /^[a-zA-Z가-힣0-9]{8,20}$/;
	        let msg = "";
	        let color = "";
	
	        if (!idRegx.test(id)) {
	            msg = "아이디는 특수문자,한글을 제외한 8~20자리의 영어, 숫자만 입력 가능합니다.";
	            color = "RED";
	            $("#msg_id").text(msg);
	            $("#msg_id").css("color", color);
	            dupIdCnt = 1;
	            checkFormValidity();
	            return;
	        }
	
	        $.ajax({
	            type: "GET",
	            url: "dupId",
	            data: {
	                "member_id": id
	            },
	            success: function(response) {
	                if(response === "false" || response === false){
	                    msg = "중복된 아이디입니다.";
	                    color = "RED";
	                    dupIdCnt = 1;
	                } else {
	                    msg = "사용 가능한 아이디입니다.";
	                    color = "GREEN";
	                    dupIdCnt = 0;
	                }
	                $("#msg_id").text(msg);
	                $("#msg_id").css("color", color);
	                checkFormValidity();
	            }
	        });
	    }
	
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
	        checkFormValidity();
	    }
	
	    function validatePasswordConfirmation() {
	        let pwd = $("#member_pwd").val();
	        let pwd2 = $("#member_pwd2").val();
	        let msg = "";
	        let color = "";
	
	        if (pwd !== pwd2) {
	            msg = "비밀번호가 일치하지 않습니다.";
	            color = "RED";
	            riskCount = 1;
	        } else {
	            msg = "비밀번호가 일치합니다.";
	            color = "GREEN";
	            riskCount = 0;
	        }
	        $("#msg_pwd2").text(msg);
	        $("#msg_pwd2").css("color", color);
	        checkFormValidity();
	    }
	
	    function validateAddress2() {
	        let address2 = $("#member_address2").val();
	        let msg = "";
	        let color = "";
	
	        if (address2.length < 2 || address2.length > 20) {
	            msg = "상세 주소는 2~20자리 입력해주세요.";
	            color = "RED";
	            riskCount = 1;
	        } else {
	            msg = "사용 가능한 상세 주소입니다.";
	            color = "GREEN";
	            riskCount = 0;
	        }
	        $("#msg_addr").text(msg);
	        $("#msg_addr").css("color", color);
	        checkFormValidity();
	    }
	
	    function validateEmail() {
	        let email = $("#member_email").val();
	        let emailRegx = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
	        let msg = "";
	        let color = "";
	
	        if (!emailRegx.test(email)) {
	            msg = "올바른 이메일 형식이 아닙니다.";
	            color = "RED";
	            riskCount = 1;
	        } else {
	            msg = "사용 가능한 이메일입니다.";
	            color = "GREEN";
	            riskCount = 0;
	        }
	        $("#msg_email").text(msg);
	        $("#msg_email").css("color", color);
	        checkFormValidity();
	    }
	
	    function validateTel() {
	        let tel = $("#member_tel").val();
	        let telRegx = /^01[016789][0-9]{7,8}$/;
	        let msg = "";
	        let color = "";
	
	        if (!telRegx.test(tel)) {
	            msg = "올바른 전화번호 형식이 아닙니다.";
	            color = "RED";
	            riskCount = 1;
	        } else {
	            msg = "사용 가능한 전화번호입니다.";
	            color = "GREEN";
	            riskCount = 0;
	        }
	        $("#msg_tel").text(msg);
	        $("#msg_tel").css("color", color);
	        checkFormValidity();
	    }
	
	    function checkFormValidity() {
	        let isFormValid = (
	            $("#member_name").val() &&
	            $("#member_id").val() &&
	            $("#member_pwd").val() &&
	            $("#member_pwd2").val() &&
	            $("#member_birth").val() &&
	            $("#post_code").val() &&
	            $("#address1").val() &&
	            $("#address2").val() &&
	            $("#member_email").val() &&
	            $("#member_tel").val() &&
	            dupIdCnt === 0 &&
	            riskCount === 0
	        );
	
	        $("button[type='submit']").prop('disabled', !isFormValid);
	    }
	});
</script>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	
	    function search_address() {
	        new daum.Postcode({ // daum.Postcode 객체 생성
	        	// 주소검색 창에서 주소 검색 후 검색된 주소를 사용자가 클릭하면
	        	// oncomplete 이벤트에 의해 해당 이벤트 뒤의 익명함수가 실행(호출됨)
	        	// => 사용자가 호출하는 것이 아니라 API 가 함수를 호출하게 됨(callback(콜백) 함수)
	            oncomplete: function(data) {
	                // 클릭(선택)된 주소에 대한 정보(객체)가 익명함수 파라미터 data 에 전달됨
	                // => data.xxx 형식으로 각 주소 정보에 접근 가능
	                console.log(data);
	                // 1) 우편번호(= 국가기초구역번호 = zonecode 속성값) 가져와서 
	                //    우편번호 입력란(postCode)에 출력
	                document.fr.post_code.value = data.zonecode;
	        		// 2) 기본주소(address 속성값) 가져와서 기본주소 항목(address1)에 출력
// 	        		document.fr.address1.value = data.address; // 기본주소
// 	        		document.fr.address1.value = data.roadAddress; // 도로명주소
	        		// 만약, 해당 주소에 대한 건물명(buildingName 속성값)이 존재할 경우(널스트링 아닐 때)
	        		// 기본주소 뒤에 건물명을 결합하여 출력
	        		// ex) 기본주소 : 부산 부산진구 동천로 109
	        		//     건물명 : 삼한골든게이트
	        		//     => 부산 부산진구 동천로 109 (삼한골든게이트)
	        		let address = data.address; // 기본주소 변수에 저장
	        		// 건물명이 존재할 경우(buildingName 속성값이 널스트링이 아닐 경우)
	        		// 기본주소 뒤에 건물명 결합
	        		if(data.buildingName != "") {
	        			address += " (" + data.buildingName + ")";
	        		}
	        		// 기본주소 출력
	        		document.fr.address1.value = address;
	        		// 상세주소 입력 항목에 커서 요청
	        		document.fr.address2.focus();
	            }
	        }).open();
	    }
	</script>
</body>
</html>