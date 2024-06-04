<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영영화 상세보기</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}

* {
	margin: 0;
	padding: 0;
	/*    	border: 1px solid skyblue;    */
}

#wrap {
	width: 1400px;
	margin: 0 auto;
}

article {
	margin-top: 40px;
	width: 1400px;
	height: 600px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.movieTrail {
	/* 내부의 movieTrail을 가운데 정렬합니다. */
	width: 900px;
	max-width: 100%; /* 부모 요소의 너비에 맞게 설정합니다. */
	margin: 0 auto; /* 좌우 여백을 자동으로 설정하여 가운데 정렬합니다. */
}

section {
	overflow: hidden;
	width: 1400px;
	height: 1600px;
	/* 	background-color: #ffca28; */
	display: flex;
	flex-wrap: wrap;
}

section h1 {
	position: relative;
	text-align: center; /* 가운데 정렬 */
	font-size: 32px; /* 폰트 크기 수정 */
	width: 100%; /* 너비 조정 */
	white-space: nowrap;
}

.content {
	width: 1400px;
}

.movieTitle{
	border-bottom: 2px solid lightgray;
	margin: 30px 60px 0px;
}

.movie {
	padding-top: 30px;
	width: 350px;
	height: 600px;
	float: left;
	text-align: center;
}

.movie > button {
	margin-top: 10px; 
}

.movie img {
	width: 300px;
	height: 500px;
	border-radius: 10px;
}

.movie input[type="button"] {
	display: inline-block;
}

.movieInfo {
	padding-top: 30px;
	float: right;
	width: 1000px;
	height: 600px;
	margin-bottom: 50px;
}

.movieInfo ul li {
	font-size: 24px; /* 텍스트 크기 조정 */
	text-align: justify;
	word-break: keep-all;
	line-height: 1.5em;
}

.movieInfo input[type="button"] {
	position: absolute;
	margin-left: 20px;
	bottom: 30px;
}

.reviewContents {
	width: 1400px;
	height: 100px;
	/* 	border: 1px solid black;   */
	font-size: 30px;
	margin-top: 200px;
}
.submitButton > button{
	width: 250px;
	padding: 10px;
	margin-top: 10px;
	margin-left: 10px;
}

.star-rating {
	padding-left: 10px;
	padding-top: 10px;
	width: 300px;
	height: 150px;
}

#review_rating, #review_rating option:checked {
	color: gold; /* 셀렉트 박스와 선택된 옵션의 텍스트 색상을 골드로 설정 */
	font-size: 20px;
}

.review textarea.form-control {
	margin-left: 20px;
	height: 50px; /* 높이를 원하는 크기로 조절하세요 */
	/* 	border: 2px solid black; */
	resize: none;
}

.showReview {
	margin-bottom: 250px;
	font-size: 24px;
	margin-left: 20px;
	width: 1300px;
	height: 200px;
	padding-left: 0px;
	margin-top: 20px;
}

.reviewCover {
	width: 200px;
	height: 80px;
	float: left;
	color: gold; /* 별의 색상을 골드로 지정 */
}

.review {
	padding-top: 10px;
	width: 900px;
	margin-bottom: 0px;
	margin-top: 10px;
	/* 	border: 1px solid red;   */
	float: right;
}

.reviewCover span:before {
	content: '★';
	color: gold;
}

.reviewCover span.empty::before {
	content: '☆'; /* 빈 별의 모양 */
	color: gold;
}

.reviewCover span.filled::before {
	content: '★'; /* 별이 채워진 상태 */
	color: gold;
}

.reviewTexts {
	float: right;
	width: 1000px;
	height: 80px;
}

.reviewTexts span {
	margin-right: 10px; /* 원하는 만큼의 간격을 조절하세요 */
}

.movieInfo img {
	width: 200px;
	border-radius: 5px;
}

#pageList {
	margin-top: 30px;
	height: 100px;
	margin: auto;
	width: 1024px;
	text-align: center;
}
#pageList > input[type=button]{
	padding: 10px 20px;
	background: white;
	border: 1px solid #0078FF;
	border-radius: 10px;
	color: #0078FF;
}

#pageList > a{
	text-decoration: none;
	color: lightgray;
	margin: 0 10px;
}
#pageList > b{
	margin: 0 10px;
	color: #1b1b1b;
}


.backButton {
	margin-top: 20px;
}

footer {
	width: 100%;
	height: 100px;
}
/* 	background-color: #ffb300; */
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%-- <link href="${pageContext.request.contextPath}/resources/css/movie_info.css" rel="stylesheet" type="text/css"> --%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<script>
	function refreshParent() {
		location.reload(); // 원래 페이지 새로고침	
	}
</script>

<body>
	<header>
		<jsp:include page="../inc/admin_header.jsp"></jsp:include>
	</header>
	<div id="wrap">
		<div class="movieTitle">
			<h3>영화 상세페이지</h3>
		</div>
		<article>
			<div class="movieTrail">
				<c:choose>
					<c:when test="${not empty movie.movie_trailler}">
						<iframe width="100%" height="600px" src="${movie.movie_trailler}"></iframe>
					</c:when>
					<c:otherwise>
						<h1>죄송합니다. 이 영화의 트레일러가 준비되지 않았습니다.</h1>
					</c:otherwise>
				</c:choose>
			</div>
		</article>
		<section>
			<div class="content">
				<div class="list">
					<div class="movie">
						<img src="${movie.movie_poster}">
						<button type="button" class="btn btn-outline-primary"
							id="movieTicket">예매하기</button>
					</div>
					<div class="movieInfo">
						<ul>
							<li><span>제목 : ${movie.movie_name} </span></li>
							<li><span>개봉 : ${movie.movie_open_date} </span></li>
							<li><span>감독 : ${movie.movie_director} </span></li>
							<li><span>등급 : ${movie.movie_grade} </span></li>
							<li><span>장르 : ${movie.movie_genre }</span></li>
							<li><span>상영시간 : ${movie.movie_runtime } 분</span></li>
							<li><span>줄거리 : ${movie.movie_summary}</span></li>
						</ul>
						<img src="${movie.movie_stillCut}"> 
						<img src="${movie.movie_stillCut2}"> 
						<img src="${movie.movie_stillCut3}">
						<div class="backButton">
							<button type="button" class="btn btn-outline-primary"
								onclick="window.history.back()">뒤로가기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="reviewContents">
				<form action="reviewPro" method="post">
					<p>별점 & 관람평</p>
					<div class="row">
						<div class="star-rating col-3">
							<select id="review_rating" name="review_rating"
								class="form-select">
								<option value="0" selected>별점 선택(미선택시 0점 ☆)</option>
								<option value="1">★ 1점</option>
								<option value="2">★★ 2점</option>
								<option value="3">★★★ 3점</option>
								<option value="4">★★★★ 4점</option>
								<option value="5">★★★★★ 5점</option>
							</select>
						</div>
						
						<div class="review col-5">
							<c:set var="pageNum"
								value="${empty param.pageNum ? 1 : param.pageNum}" />
	<!-- 						<p>관람평</p> -->
							<c:choose>
								<c:when test="${not empty sessionScope.sId}">
									<textarea id="reviewText" name="review_text"
										class="form-control" rows="3" cols="5" maxlength="50"
										placeholder="50자 이내로 부탁드리겠습니다."></textarea>
								</c:when>
								<c:otherwise>
									<textarea id="reviewText" class="form-control" rows="3" cols="5"
										maxlength="50" placeholder="사랑하는 고객님 로그인먼저 부탁드리겠습니다."></textarea>
								</c:otherwise>
							</c:choose>
						</div>
						
						<div class="submitButton col-3">
							<button type="submit" class="btn btn-outline-primary"
								id="submitReviewBtn">별점주기 & 관람평 남기기</button>
						</div>
					</div>
					
					<!-- hidden input으로 값을 추가 -->
					<input type="hidden" id="movie_num" name="movie_num"
						value="${movie.movie_num}"> <input type="hidden"
						id="member_id" name="member_id" value="${sessionScope.sId}">

				</form>
				
			</div>
		
			<c:if test="${not empty sessionScope.sId}">
			<div class="member_review_search">
				<form action="member_review" method="post">
					<input type="hidden" name="member_id" value="${sessionScope.sId}" > 
					<input type="hidden" id="movie_num" name="movie_num" value="${movie.movie_num}">
					<input type="submit" class="btn btn-dark" value="내가 쓴 댓글 찾기">
				</form>
			</div>
			</c:if>
			<div class="showReview">
				<c:forEach var="review" items="${reviews}">
					<div class="reviewCover">
						<c:choose>
							<c:when test="${review.review_rating eq 0}">
								<span class="empty"></span>
							</c:when>
							<c:otherwise>
								<c:forEach begin="1" end="${review.review_rating}">
									<span class="filled"></span>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
					
					<div class="reviewTexts">
						<span class="review-text">${review.review_text}</span> 
<%-- 						<span class="member-id">${review.member_id}</span> 기존 멤버 아이디 전부 출력에서 뒤에 가리고 출력 --%> 
						<c:set var="maskedMemberId" value="${fn:substring(review.member_id, 0, fn:length(review.member_id) - 3)}***" />
    					<span class="member-id"><c:out value="${maskedMemberId}" /></span>
						<span class="review-date"><fmt:formatDate
								value="${review.review_date}" pattern="yyyy-MM-dd" /></span>
						<c:if test="${review.member_id eq sessionScope.sId}">
							<button onclick="openReviewModify(${review.review_num})"
								class="btn btn-outline-primary">수정</button>
							<button onclick="confirmDelete(${review.review_num})"
								class="btn btn-outline-primary">삭제</button>
						</c:if>
					</div>
				</c:forEach>
			</div>
			<div id="pageList">
				<input type="button" value="이전" 
					onclick="location.href='movieInfo?movie_num=${movie.movie_num}&pageNum=${pageNum - 1}'"
					<c:if test="${pageNum == 1}">disabled</c:if> />
				<c:forEach var="i" begin="1" end="${maxPage}">
					<c:choose>
						<c:when test="${pageNum == i}">
							<b>${i}</b>
						</c:when>
						<c:otherwise>
							<a href="movieInfo?movie_num=${movie.movie_num}&pageNum=${i}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<input type="button" value="다음" 
					onclick="location.href='movieInfo?movie_num=${movie.movie_num}&pageNum=${pageNum + 1}'"
					<c:if test="${pageNum == maxPage or maxPage == 0}">disabled</c:if> />
			</div>
		</section>
		<footer>
			<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
		</footer>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
    	let sId = "${sessionScope.sId}";
    	

    	$('#movieTicket').click(function() {
        // 세션 아이디 확인 후 로그인 페이지로 이동
	        if (!sId) {
	            if (confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
	                window.location.href = 'member_login';
	            }
	        } else {
	            // 세션 아이디가 있으면 예매 페이지로 이동
	            window.location.href = 'tic_ticketing';
	        }
	    });
	
	    // 리뷰 제출 버튼 클릭 시
	    $("#submitReviewBtn").click(function(event) {
	        // 관람평 입력값 가져오기
	        let reviewText = $("#reviewText").val().trim();
	        
	        // 로그인 여부 확인 후 로그인 페이지로 이동
	        if (!sId) {
	            if (confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
	                window.location.href = 'member_login';
	            }
	            event.preventDefault(); // 폼 제출 중단
	            return;
	        }
	
	        // 관람평이 비어 있는지 확인 후 알림 표시
	        if (reviewText === "") {
	            alert("관람평을 입력해주세요.");
	            $("#reviewText").focus();
	            event.preventDefault(); // 폼 제출 중단
	            return;
	        }
	      	        
	    });
	});
	
	// 리뷰 수정 버튼 클릭 시
	function openReviewModify(review_num) {
		 if (confirm("정말로 이 리뷰를 수정하시겠습니까?")) {
	        var url = "reviewModify?review_num=" + review_num;
	        window.open(url, "", "width=700,height=500,left=" + ((window.screen.width - 700) / 2) + ",top=" + ((window.screen.height - 500) / 2));
		 }
	}
	// 리뷰 삭제 버튼 클릭 시
	function confirmDelete(review_num) {
	    if (confirm("정말로 이 리뷰를 삭제하시겠습니까?")) {
	        var url = "deleteReview?review_num=" + review_num;
	        window.open(url, "", "width=700,height=300,left=" + ((window.screen.width - 700) / 2) + ",top=" + ((window.screen.height - 300) / 2));
	    }       
	}
</script>
</html>