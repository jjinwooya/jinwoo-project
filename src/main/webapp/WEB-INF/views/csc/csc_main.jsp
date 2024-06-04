<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부기무비 고객센터</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/csc_sidebar.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/csc_main.css"> --%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style>
@import url("https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css");

#csc_mainShort_title {
	width:100%;
	height:30px;
	text-align: right;
	position:relative;
	top:25px;
	font-size:18px;
	color:gray;
	
}

.csc_ffs {
	text-align: center;
	vertical-align:text-top;
}


.csc_ffs_ps {
	width:200px;
	height:100px;
	display: inline-block;
} 
.csc_ffs_modify {
	width:200px;
	height:100px;
	display: inline-block;
} 
.csc_ffs_ticketing {
	width:200px;
	height:100px;
	display: inline-block;
	
} 
.csc_ffs_faq {
	width:200px;
	height:100px;
	display: inline-block;
} 

hr{
	border:0;
	background-color: gray;
}

/* 작은 박스-inquiry */
.csc_main_sbt {
	font-size:1.5em;
}
/* '더보기' */
.the_plus {
	text-decoration:none;
/* 	margin-left: 130px; */
	font-size:0.7em;
	float: right;
	color: black;
}

.csc_main_inquiry {
	margin-top:30px;
/* 	margin-left:30px; */
	width:400px;
}

/* 작은 박스-notice */

.csc_main_shortBox {
	font-size:1.5em;
}
.csc_main_notice {
	margin-top:30px;
	margin-left:30px;
	width:400px;
}

.csc_shortBox_border {
	border-top: 1px solid black;
	margin-top:5px;
}
.aTag {
	text-decoration: none;
	color:black;
}
ul li {
	margin-bottom: 5px;
}
.csc_main_InquiryUl {
	padding-left: 0;
}

.csc_main_InquiryUl li {
	margin-top: 5px;
/* 	list-style-image: url("https://i.ibb.co/6Ng1m3P/thumb.png"); */
	white-space: nowrap; /* 텍스트를 한 줄로 유지 */
    overflow: hidden; /* 넘치는 텍스트를 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트를 ...로 표시 */
    width: 100%; /* li 요소의 너비를 부모의 100%로 설정 */
    box-sizing: border-box; /* 패딩과 테두리를 포함하여 너비를 계산 */
    position: relative;
    padding-left: 20px;
}

.csc_main_InquiryUl li::before {
    content: url("https://i.ibb.co/6Ng1m3P/thumb.png");
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 16px; /* 이미지 너비 조정 */
    height: 16px; /* 이미지 높이 조정 */
    
}
.csc_main_noticeUl {
	margin-top: 5px;
/* 	list-style-image: url("https://i.ibb.co/6Ng1m3P/thumb.png"); */
}

#csc_mainTitle {
	margin-top: 20px;
}
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
</header>

<div class="container">
	<div class="row">
		<!-- 사이드바 영역 -->
		<div class="col-2">
			<jsp:include page="csc_sidebar.jsp"></jsp:include>
		</div>
		<!-- content - csc 메인 화면 영역 -->
		<div class="col-10">
			<div id="csc_mainTitle">
				<h1>고객센터 메인</h1>
				<hr>
			</div>
		<div>
			<div id="csc_mainShort_title">자주 찾는 서비스</div>
			<hr>
			<div class="row">
				<div class="csc_ffs">
					<div class="csc_ffs_ps">
						<a href="member_search_id" class="aTag"><img src="${pageContext.request.contextPath }/resources/images/boogiSad.png"><br>
						아이디/비밀번호<br>찾기</a>
					</div>
					<div class="csc_ffs_modify">
						<a href="myp_info_modify"class="aTag"><img src="${pageContext.request.contextPath }/resources/images/boogiHappy.png"><br>
						회원정보<br>수정</a>
					</div>
					<div class="csc_ffs_ticketing">
						<a href="tic_ticketing" class="aTag"><img src="${pageContext.request.contextPath }/resources/images/boogiLovely.png"><br>
						영화 예매<br>결제</a>
					</div>
					<div class="csc_ffs_faq">
						<a href="csc_faq" class="aTag"><img src="${pageContext.request.contextPath }/resources/images/boogiCurious.png"><br>
						자주 묻는<br> 질문</a>
					</div>
				</div>
			</div>
		</div>
		<!-- best 질문 / 공자 -->
		<div id="csc_mainShort_title">FAQ / 공지사항</div>
		<hr>
		<div class="row">
			<!-- 질문 -->
			<div class="col">
				<div class="csc_main_inquiry">
					<div class="csc_main_shortBox">
						자주묻는질문 Best <a href="csc_faq" class="the_plus">더 보기</a>
					</div>
					<div class="csc_shortBox_border">
						<ul class="csc_main_InquiryUl">
							<c:forEach var="faq" items="${faqList }">
								<li>[${faq.faq_category}]${faq.faq_subject }</li>
							</c:forEach>
						</ul>
					</div> 
				</div>
			</div>
			<!-- 공지 -->
			<div class="col">
				<div class="csc_main_notice">
					<div class="csc_main_shortBox">
						최근 공지사항 <a href="csc_notice" class="the_plus">더 보기</a>
					</div>
					<div class="csc_shortBox_border">
						<ul class="csc_main_noticeUl">
							<c:forEach var="notice" begin="0" end="5" items="${noticeList }">
								<li>[${notice.notice_category}]${notice.notice_subject}</li>
							</c:forEach>
						</ul>
					</div> 
				</div>
			</div>
			</div>
		</div>
	</div>
</div>	
	
<footer>
	<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
</footer>
</body>
</html>