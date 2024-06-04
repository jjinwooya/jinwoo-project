<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 회원가입 확인하기</title>
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
	    <h3>가입 확인하기</h3>
	    <hr>
    </div>
<!--     <div align="center"><input type="button" value="휴대폰 인증하기" onclick="cerTel()"></div> -->
	<form action="member_reg_member" method="post">
		<div class="member_row">
	
		    <div class="form_item">
		    	<label for="member_name"><b>이름</b></label>
		    	<input type="text"  maxlength="10" name="member_name" id="member_name" required placeholder="이름을 입력해주세요">
		    	<span id="name_span"></span>
		    </div>
		    
		    <div class="form_item">
		    	<label for="member_birth"><b>생년월일</b></label>
		    	<input type="text"  maxlength="6" name="member_birth" id="member_birth" required placeholder="생년월일6자리 입력해주세요">
		    	<span id="birth_span"></span>
		    </div>
		    
		    <div class="form_item">
		    	<label for="member_email"><b>이메일</b></label>
		    	<input type="text"  maxlength="30" name="member_email" id="member_email" required placeholder="이메일을 입력해주세요">
		    	<span id="email_span"></span>
		    </div>
		</div>
		<div class="regist_final">
			<hr>
			<button type="submit" class="btn btn-outline-primary">가입 확인하기</button>
			<button type="button" class="btn btn-outline-primary" onclick="history.back()">돌아가기</button>
		</div>
	</form>
</section>



<header>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</header>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

// 	function cerTel(){
// 		IMP.init("imp00262041"); 
		
// 		// IMP.certification(param, callback) 호출
// 		IMP.certification(
// 		  {
// 		    // param
// 		    // 주문 번호
// 		    pg: "danal.A010002002", //본인인증 설정이 2개이상 되어 있는 경우 필
// 		    merchant_uid: "ORD20180131-0000011",
//             name: '홍길동', // 사용자 이름
//             phone: '01012345678' // 사용자 전화번호
// 		  }, function (rsp) {
// 		        // callback
// 		        if (rsp.success) {
// 		            $.ajax({
// 		                url: "/cerTel",
// 		                method: "POST",
// 		                headers: { "Content-Type": "application/json" },
// 		                data: JSON.stringify({ imp_uid: rsp.imp_uid }), // JSON.stringify로 데이터 변환
// 		                success: function(response) {
// 		                    alert("인증이 완료되었습니다.");
// 		                },
// 		                error: function(xhr, status, error) {
// 		                    alert("서버와의 통신에 실패했습니다.");
// 		                }
// 		            });
// 		        } else {
// 		            alert("인증에 실패하였습니다. 에러 내용: " + rsp.error_msg);
// 		        }
// 		    });	
// 		}

$(document).ready(function() {
    // 이름 입력값 변경 시
    $("#member_name").on("input", function() {
        let name = $("#member_name").val();
        let regex = /^[a-zA-Z가-힣]{2,10}$/g;
        
        if (!regex.test(name)) {
            $("#member_name").css("background-color", "red");
            $("#name_span").text("올바른 이름형식(특수문자 불가, 영어 한글 2~10글자)를 입력해주세요");
        } else {
            $("#member_name").css("background-color", ""); // 원래의 배경색으로 돌아갑니다 (빈 문자열로 설정)
            $("#name_span").text(""); // 텍스트를 제거합니다
        }

        checkFormValidity(); // 폼 유효성 검사 실행
    });

    // 생일 입력값 변경 시
    $("#member_birth").on("input", function() {
        let birth = $("#member_birth").val();
        let regex = /^\d{6}$/g;

        if (birth.length === 6) { // member_birth의 길이가 6일 때만 실행
            if (!regex.test(birth)) {
                $("#member_birth").css("background-color", "red");
                $("#birth_span").text("생년월일 6자리를 정확히 입력해주세요(예시 : 950211)");
            } else {
                let validationResult = isValidDate(birth);
                if (validationResult !== true) {
                    $("#member_birth").css("background-color", "red");
                    $("#birth_span").text(validationResult); // 유효성 검사 결과 메시지 출력
                } else {
                    $("#member_birth").css("background-color", ""); // 원래의 배경색으로 돌아갑니다 (빈 문자열로 설정)
                    $("#birth_span").text(""); // 텍스트를 제거합니다
                }
            }

            checkFormValidity(); // 폼 유효성 검사 실행
        }
    });

    // 이메일 입력값 변경 시
    $("#member_email").on("input", function() {
        let email = $("#member_email").val();
        let regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/g;
        
        if (!regex.test(email)) {
            $("#member_email").css("background-color", "red");
            $("#email_span").text("이메일 형식을 맞춰 입력해주세요 (example@example.exam)");
        } else {
            $("#member_email").css("background-color", ""); // 원래의 배경색으로 돌아갑니다 (빈 문자열로 설정)
            $("#email_span").text("");
        }

        checkFormValidity(); // 폼 유효성 검사 실행
    });

    // 폼 유효성 검사 함수
    function checkFormValidity() {
        let nameIsValid = /^[a-zA-Z가-힣]{2,10}$/.test($("#member_name").val());
        let birthIsValid = /^\d{6}$/.test($("#member_birth").val()) && isValidDate($("#member_birth").val()) === true;
        let emailIsValid = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test($("#member_email").val());
        
        if (nameIsValid && birthIsValid && emailIsValid) {
            $("button[type='submit']").prop("disabled", false); // submit 버튼 활성화
        } else {
            $("button[type='submit']").prop("disabled", true); // submit 버튼 비활성화
        }
    }

    // 날짜 유효성 검사 함수
    function isValidDate(birth) {
        // 생년월일 6자리를 Date 객체로 변환
        let year = parseInt(birth.substring(0, 2), 10);
        year += (year < 50) ? 2000 : 1900; // 2000년대 이후는 2000을 더하고, 1950년 이전은 1900을 더함
        let month = parseInt(birth.substring(2, 4), 10) - 1; // 월은 0부터 시작
        let day = parseInt(birth.substring(4, 6), 10);
		
        if (month < 0 || month > 11) {
            return "존재하지 않는 달입니다."; // 유효하지 않은 월
        }

        let date = new Date(year, month, day);
        if (date.getFullYear() !== year || date.getMonth() !== month || date.getDate() !== day) {
            return "존재하지 않는 일입니다."; // 유효하지 않은 일
        }

        let today = new Date();
        if (date > today) {
            return "오늘 이후 날짜입니다."; // 미래 날짜
        }

        return true; // 유효한 날짜
    }
});

</script>
</body>
</html>