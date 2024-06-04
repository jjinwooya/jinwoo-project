<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 회원탈퇴</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myp_withdraw_finish.css">
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
</head>
<body>
<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>
	<div class="container1">
		<div class="container2">
			<div class="row">
				<div class="col-md-2">
					<jsp:include page="../inc/myp_aside.jsp"></jsp:include>
				</div><!-- col-md-2 사이드바임 -->
				<div class="col-md-9">
					<h2>회원탈퇴</h2>
					<hr>
					<div class="box1">
						<h2>탈퇴처리되었습니다.</h2>
						<div class="row">
							<div class="col-md-3"> </div>
							<div class="col-md-6">
								<section class="content">
									<div class="d-grid gap-2 d-md-block box2">
									  <button class="btn btn-outline-primary btn-lg" type="button" onclick="location.href='myp_main'">메인페이지</button>
									  <button class="btn btn-outline-primary btn-lg" type="button" onclick="location.href='member_reg_member'">회원가입</button>
									  <button class="btn btn-outline-primary btn-lg" type="button" onclick="location.href='member_login'">로그인</button>
									</div> <!-- d-grid gap-2 d-md-block box2 -->
								</section>
						    </div><!-- col-md-5 -->
							<div class="col-md-3"> </div>
					    </div><!-- row -->
					</div> <!--  box1 --> 
			    </div><!-- "col-md-9" -->
		    </div><!-- row -->
    	</div> <!-- container2 -->
    </div> <!-- container1 -->
<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js">

</body>
</html>