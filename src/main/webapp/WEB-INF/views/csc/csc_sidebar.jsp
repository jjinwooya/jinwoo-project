<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
body { 
	font-family: "Noto Sans KR", sans-serif; 
	font-optical-sizing: auto;
	font-weight: 400;
	font-style: normal;
	
}

.btn-group {
	padding: 4px 0px;
}

.btn-group:hover .dropdown-menu {
	display: block;
	margin-left: 130px;
}

.btn-group:hover .btn {
	background: skyblue;
	color: white;
	width: 100px;
	padding-top: 12px;
	transition-duration: .1s;
}

.btn-group-vertical {
	background: white;
	border-top: 3px solid black;
	border-bottom: 3px solid black;
}

.sideVar_title {
	padding-top: 15px;
}

.sideVar {
	margin: 60px auto;
	font-family: "Noto Sans KR", sans-serif; 
	font-weight: 400;
	font-style: normal;	
}
.admin_aside_name{
	font-weight: bold;
}
a{
	text-decoration: none;
	color: black;
}

</style>
<div class="sideVar">
	<!--  사이드바 영역  -->
	<div class="admin_middle_left" align="right">
		<div class="btn-group-vertical">
			<!-- 사이드바 타이틀 -->
			<div class="sideVar_title">
				<a href="csc_main"><h4 class="admin_aside_name">고객센터</h4></a>
			</div>
			<div class="btn-group dropright">
				<!-- 마우스 오버 전 카테고리 -->
				<button type="button" class="btn" data-toggle="dropdown" onclick="location.href='csc_faq'">
					<h5>FAQ</h5>
				</button>
			</div>
			<div class="btn-group">
				<button type="button" class="btn" data-toggle="dropdown" onclick="location.href='csc_notice'">
					<h5>공지사항</h5>
				</button>
			</div>
			<div class="btn-group">
				<button type="button" class="btn" data-toggle="dropdown" onclick="location.href='csc_oto'">
					<h5>1대1 문의</h5>
				</button>
			</div>
		</div>
	</div>
</div>
