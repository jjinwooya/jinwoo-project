<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>부기무비 아이디 찾기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css
" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/css/member_reg_complete.css" rel="stylesheet">

<style>
	.message{
		margin-left : 500px;
	}
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
</style>
	
</head>
<body>

<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>

	
<div class="row container">
	<div class="col-md-2">
		<div class="side_var">
			<jsp:include page="../inc/admin_aside.jsp"></jsp:include>
		</div>
	</div>
	<div class="col-md-10" style="margin-top : 100px;">
		<div class="message">
			<h3>귀하의 아이디는 ${replaceMemberId } 입니다!</h3>
			<br>
			<br>
			<form action="member_search_pwd" method="post">
				<input type="hidden" name="member_id" id="member_id" value="${memberId}">
				<button type="button" class="btn btn-outline-primary" onclick="location.href='member_login'">로그인</button>
				<button type="submit" class="btn btn-outline-primary">패스워드 찾기</button>
			</form>
		</div>
		
	</div>
</div>
  
<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>
</body>
</html>