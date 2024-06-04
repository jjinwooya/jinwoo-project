<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>부기무비 회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css
" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath }/css/member_reg_complete.css" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
	.message{
		margin-left : 500px;
	}
</style>
	
</head>
<body>

<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>

	
<div class="row container">
	<div class="col-md-12" style="margin-top : 100px;">
		<div class="message">
			<h3>${member_name }님 회원가입을 환영합니다!</h3>
			<br>
			<br>
		<button type="button" class="btn btn-outline-primary" onclick="location.href='./'">영화</button>
		<button type="button" class="btn btn-outline-primary" onclick="location.href='tic_ticketing'">예매</button>
		</div>
		
	</div>
</div>
  
<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>
</body>
</html>