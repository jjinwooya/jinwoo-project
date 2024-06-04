<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 로그인</title>
</head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath}/resources/css/member_login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js" integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
input[type=password] {
    width: 100%;
    padding: 12px 20px;
    margin: 20px 10px 10px 0px;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}	
</style>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"></script>

<body>
<header>
    <jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>

<div class="row container">
    <h3>로그인</h3>
    <hr>
    <div class="col input-box">
        <form action="member_login_pro" method="post" name="fr">
            <label for="member_id">아이디</label>
            <input type="text" id="member_id" name="member_id" placeholder="아이디를 입력하세요" value="<c:out value='${cookie.rememberId.value}'/>" maxlength="20" required="required">

            <label for="member_pwd">비밀번호</label>
            <input type="password" id="member_pwd" name="member_pwd" placeholder="비밀번호를 입력하세요" maxlength="16" required="required">

            <div class="loginBtns">
                <button type="submit" class="btn btn-outline-primary">로그인</button>
                <button type="button" class="btn btn-outline-primary" onclick="location.href='member_search_id'">아이디 찾기</button>
                <button type="button" class="btn btn-outline-primary" onclick="location.href='member_search_pwd'">비밀번호 찾기</button>
                <button type="button" class="btn btn-outline-primary" onclick="location.href='member_pre_reg_member'">회원가입</button>
                
            </div>
			<div>
				<input type="checkbox" id="remember_id" name="remember_id"
				<c:if test="${not empty cookie.rememberId.value}">checked</c:if>>
				<label for="remember_id">아이디 기억하기</label>
			</div>
        </form>
    </div>
    <div class="col login-box">
        <h2>소셜 로그인</h2>
<!--         <a href="#" class="social-button" id="google-connect"> <span>구글 로그인</span></a> -->
        <a href="#" class="social-button" id="naver-connect"> <span>네이버 로그인</span></a>
    </div>
</div>

<footer>
    <jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>
<script>

	window.onload = function() {
	    var naverLogin = new naver.LoginWithNaverId({
	        clientId: "YYIJQmFYT8uB2h0xYs1o",
	        callbackUrl: "http://c3d2401t2.itwillbs.com/boogimovie/NaverLoginCallback",
	        isPopup: false, // 팝업 방식으로 할 경우 true로 설정
	    });
	
	    // 네이버 로그인 초기화
	    naverLogin.init();
	    
        document.getElementById('naver-connect').onclick = function() {
            naverLogin.authorize();
            return false;
        };
        
     // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해야 합니다.
        Kakao.init('JAVASCRIPT_KEY');
     	

	};
</script>
</body>
