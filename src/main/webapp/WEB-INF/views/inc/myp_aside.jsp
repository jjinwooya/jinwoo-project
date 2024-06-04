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
	margin-left: 135px;
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
	border-top: 3px solid skyblue;
	border-bottom: 3px solid skyblue;
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
				<a href="myp_main"><h4 class="admin_aside_name">마이페이지</h4></a>
			</div>
			<div class="btn-group dropright">
				<button type="button" class="btn" data-toggle="dropdown">
					<h5>결제내역</h5>
				</button>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="myp_reservation">예매내역</a> 
					<a class="dropdown-item" href="myp_store">스토어</a> 
				</div>
			</div>
			<div class="btn-group">
				<button type="button" class="btn" data-toggle="dropdown">
					<h5><a href="myp_coupon">쿠폰</a></h5>
				</button>
			</div>
			<div class="btn-group">
				<button type="button" class="btn" data-toggle="dropdown">
					<h5><a href="myp_point">포인트</a></h5>
				</button>
			</div>
			<div class="btn-group">
				<button type="button" class="btn" data-toggle="dropdown">
					<h5><a href="myp_oto_breakdown">문의내역</a></h5>
				</button>
			</div>
			<div class="btn-group">
				<button type="button" class="btn" data-toggle="dropdown">
					<h5><a href="myp_info_modify">회원정보수정</a></h5>
				</button>
			</div>
			<div class="btn-group">
				<button type="button" class="btn" data-toggle="dropdown">
					<h5><a href="myp_withdraw_info">회원탈퇴</a></h5>
				</button>
			</div>
		</div>
	</div>
</div>
