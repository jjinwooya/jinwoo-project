<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 등록폼</title>
<!-- 부트스트랩 링크 -->
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
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}

body {
	min-height: 50vh;
	background: -webkit-gradient(linear, left bottom, right top, from(#92b5db),
		to(#1d466c));
	background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
}

.input-form {
	max-width: 680px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}
.col-md-6>select {
	width: 250px;
	padding: 5px;
	border: 1px solid #999;
	font-family: url('http://i.ibb.co/98Vbb8L/gnb-bg.gif') no-repeat 95% 50%;
	border-radius: 2px;
	-webkit-appearance: none;
	-mox-appearance: none;
	appearance: none;
	text-align: center;
}
.form-control{
	border: 1px solid #bbb;
}
</style>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">영화수정</h4>
				<form class="validation-form" novalidate action="admin_movie_edit_pro" method="post" onsubmit="return confirm('영화를 등록하시겠습니까?');">
					<div class="mb-3">
						<label for="movie_num">영화코드</label> 
						<input type="text" name="movie_num" id="movie_num" class="form-control" value="${movie.movie_num}" />
					</div>
					<div class="mb-3">
						<label for="movie_name">영화명</label> 
						<input type="text" name="movie_name" id="movie_name" class="form-control" value="${movie.movie_name}" />
						<div class="invalid-feedback">영화명을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_director">감독</label> 
						<input type="text" name="movie_director" id="movie_director" class="form-control" value="${movie.movie_director}"/>
						<div class="invalid-feedback">감독을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_genre">장르</label> 
						<input type="text" name="movie_genre" id="movie_genre" class="form-control" value="${movie.movie_genre}">
					</div>
					<div class="mb-3">
						<label for="movie_grade">관람등급</label> 
						<input type="text" class="form-control" id="movie_grade" name="movie_grade" value="${movie.movie_grade}">
					</div>
					<div class="mb-3">
						<label for="movie_runtime">상영시간(분)</label> 
						<input type="text" class="form-control" id="movie_runtime" name="movie_runtime" value="${movie.movie_runtime}">
					</div>
					<div class="mb-3">
						<label for="movie_open_date">개봉일</label> 
						<input type="date" name="movie_open_date" id="movie_open_date" class="form-control" value="${movie.movie_open_date}"/>
						<div class="invalid-feedback">개봉일을 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_end_date">종영일</label> 
						<input type="date" id="movie_end_date" class="form-control" name="movie_end_date"  value="${movie.movie_end_date}"/>
						<div class="invalid-feedback">종영일을 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_poster">포스터</label> 
						<input type="text" name="movie_poster" id="movie_poster" class="form-control" required value="${movie.movie_poster}" />
						<div class="invalid-feedback">포스터를 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_stillCut">스틸컷1</label> 
						<input type="text" name="movie_stillCut" id="movie_stillCut" class="form-control" value="${movie.movie_stillCut}" />
						<div class="invalid-feedback">스틸컷을 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_stillCut2">스틸컷2</label> 
						<input type="text" name="movie_stillCut2" id="movie_stillCut2" class="form-control" value="${movie.movie_stillCut2}" />
						<div class="invalid-feedback">스틸컷을 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_stillCut3">스틸컷3</label> 
						<input type="text" name="movie_stillCut3" id="movie_stillCut3" class="form-control" value="${movie.movie_stillCut3}" />
						<div class="invalid-feedback">스틸컷을 선택해주세요.</div>
					</div>
			
					<div class="mb-3">
						<label for="movie_trailer">트레일러</label> 
						<input type="text" name="movie_trailler" id="movie_trailer" class="form-control" value="${movie.movie_trailler}" />
						<div class="invalid-feedback">트레일러를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_story">줄거리</label> 
						<textArea name="movie_summary" id="movie_story" class="form-control" rows="10px" required>${movie.movie_summary}</textArea>
						<div class="invalid-feedback">줄거리를 입력해주세요.</div>
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4" align="center">
						<input type="submit" value="등록하기" class="btn btn-primary btn-lg btn-block" >
						<input type="reset" value="다시작성" class="btn btn-primary btn-lg btn-block" >
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="history.back()">
						<button type="button" class="btn btn-danger btn-lg btn-block" onclick="movieWithdraw(${movie.movie_num})">영화삭제</button>
					</div>
				</form>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; Boogi Movie</p>
		</footer>
	</div>
	<script>
	    window.addEventListener('load', () => {
	      const forms = document.getElementsByClassName('validation-form');
	
	      Array.prototype.filter.call(forms, (form) => {
	        form.addEventListener('submit', function (event) {
	          if (form.checkValidity() === false) {
	            event.preventDefault();
	            event.stopPropagation();
	          }
	
	          form.classList.add('was-validated');
	        }, false);
	      });
	    }, false);
	    
		function movieWithdraw(movie_num){
			if(confirm("정말 삭제하시겠습니까?")){
				location.href = "admin_movie_delete?movie_num=" + movie_num;
			}
		}
	    
 	</script>
</body>
</html>