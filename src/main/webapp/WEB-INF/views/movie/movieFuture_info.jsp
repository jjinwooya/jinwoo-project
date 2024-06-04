<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 상영예정 상세보기</title>
<style type="text/css">
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap')
	;

* {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 400;
	font-style: normal;
}

* {
	margin: 0;
	padding: 0;
	/*   	border: 1px solid skyblue;   */
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
	width: 1400px;
	height: 900px;
	display: flex;
	overflow: hidden;
	flex-wrap: wrap;
}

section h1 {
	position: relative;
	text-align: center; /* 가운데 정렬 */
	font-size: 32px; /* 폰트 크기 수정 */
	width: 100%; /* 너비 조정 */
	white-space: nowrap;
}

.movie {
	padding-top: 30px;
	width: 350px;
	height: 500px;
	float: left;
	text-align: center;
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
	height: 500px;
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

.backButton {
	margin-top: 30px;
}

.movieInfo img {
	width: 200px;
	height: 100px;
}

footer {
	width: 100%;
	height: 100%
}
</style>
<%-- <link href="${pageContext.request.contextPath}/resources/css/movieFuture_info.css" rel="stylesheet"> --%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
	<header>
		<jsp:include page="../inc/admin_header.jsp"></jsp:include>
	</header>
	<div id="wrap">
		<article>
			<div class="movieTrail">
				<c:choose>
					<c:when test="${not empty movieFutureInfo.movie_trailler}">
						<iframe width="100%" height="600px"
							src="${movieFutureInfo.movie_trailler}"></iframe>
					</c:when>
					<c:otherwise>
						<h1>죄송합니다. 이 영화의 트레일러가 준비되지 않았습니다.</h1>
					</c:otherwise>
				</c:choose>
			</div>
		</article>
		<section>
			<div class="content">
				<h1>상영 예정 영화 상세페이지</h1>
				<div class="list">
					<div class="movie">
						<img src="${movieFutureInfo.movie_poster}">
					</div>
					<div class="movieInfo">
						<ul>
							<li><span>제목 : ${movieFutureInfo.movie_name} </span></li>
							<li><span>개봉 : ${movieFutureInfo.movie_open_date} </span></li>
							<li><span>감독 : ${movieFutureInfo.movie_director} </span></li>
							<li><span>등급 : ${movieFutureInfo.movie_grade} </span></li>
							<li><span>장르 : ${movieFutureInfo.movie_genre } </span></li>
							<li><span>상영시간 : ${movieFutureInfo.movie_runtime } 분</span></li>
							<li><span>줄거리 : ${movieFutureInfo.movie_summary}</span></li>
						</ul>
						<img src="${movieFutureInfo.movie_stillCut}"> <img
							src="${movieFutureInfo.movie_stillCut2}"> <img
							src="${movieFutureInfo.movie_stillCut3}">
						<div class="backButton">
							<button type="button" class="btn btn-outline-primary"
								onclick="window.history.back()">뒤로가기</button>
						</div>
					</div>
				</div>
			</div>

		</section>
	</div>
	<footer>
		<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
	</footer>
</body>
</html>