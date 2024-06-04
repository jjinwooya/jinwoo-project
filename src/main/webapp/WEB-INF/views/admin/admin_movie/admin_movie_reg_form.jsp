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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js" ></script>
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

.form-control{
	border: 1px solid #bbb;
}
#getMovie, #boxoffice {
	height: 40px;
	font-size: 15px;
	flex: right;
	margin-top: 22px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">영화등록</h4>
				<form class="validation-form" novalidate action="admin_movie_reg_pro" method="post" onsubmit="return confirm('영화를 등록하시겠습니까?');">
					<div class="row"> 
						<div class="col-md-6 mb-3">
							<label for="movie_name">영화명</label> 
							<input type="text" name="movie_name" id="movie_name" class="form-control" required />
							<div class="invalid-feedback">영화명을 입력해주세요.</div>
						</div>
						<div class="col-md-2">
							<input type="submit" id="getMovie" value="영화검색" class="btn btn-primary btn-lg btn-block" >
						</div>
						<div class="col-md-2">
							<input type="submit" id="boxoffice" value="박스오피스 조회" class="btn btn-primary btn-lg btn-block" >
						</div>
					</div>
					<div class="mb-3">
						<label for="movie_director">감독</label> 
						<input type="text" name="movie_director" id="movie_director" class="form-control" required/>
					</div>
					<div class="mb-3">
						<label for="genre_num">장르</label> 
						<input type="text" name="movie_genre" id="genre_num" class="form-control" required/>
					</div>
					<div class="mb-3">
						<label for="movie_grade">관람등급</label> 
						<input type="text" class="form-control" id="movie_grade" name="movie_grade" required/>
					</div>
					<div class="mb-3">
						<label for="movie_runtime">상영시간(분)</label> 
						<input type="text" class="form-control" id="movie_runtime" name="movie_runtime" required/>
					</div>
					<div class="mb-3">
						<label for="movie_status">상영상태</label> 
						<input type="text" name="movie_status" id="movie_status" class="form-control" required/>
						<div class="invalid-feedback">상영상태를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_open_date">개봉일</label> 
						<input type="date" name="movie_open_date" id="movie_open_date" class="form-control" required/>
						<div class="invalid-feedback">개봉일을 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_end_date">종영일</label> 
						<input type="date" id="movie_end_date" name="movie_end_date" class="form-control" required/>
						<div class="invalid-feedback">종영일을 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_poster">포스터</label> 
						<input type="text" name="movie_poster" id="movie_poster" class="form-control" />
						<div class="invalid-feedback">포스터를 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_stillCut">스틸컷</label> 
						<input type="text" name="movie_stillCut" id="movie_stillCut" class="form-control" required/>
						<div class="invalid-feedback">스틸컷을 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_stillCut2">스틸컷2</label> 
						<input type="text" name="movie_stillCut2" id="movie_stillCut2" class="form-control" required/>
						<div class="invalid-feedback">스틸컷을 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_stillCut3">스틸컷3</label> 
						<input type="text" name="movie_stillCut3" id="movie_stillCut3" class="form-control" required/>
						<div class="invalid-feedback">스틸컷을 선택해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_trailer">트레일러</label> 
						<input type="text" name="movie_trailler" id="movie_trailer" class="form-control" />
						<div class="invalid-feedback">트레일러를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_story">줄거리</label> 
						<textArea  name="movie_summary" id="movie_story" class="form-control" rows="10px" required></textArea>
						<div class="invalid-feedback">줄거리를 입력해주세요.</div>
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4" align="center">
						<input type="submit" value="등록하기" class="btn btn-primary btn-lg btn-block" >
						<input type="reset" value="다시작성" class="btn btn-primary btn-lg btn-block" >
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="history.back()">
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
	    
	    $(document).ready(function(){
	    	  // 박스오피스 검색창
			$("#boxoffice").on("click", function(e) {
				e.preventDefault(); // 기본 이벤트(폼 전송) 막음
		        window.open('boxoffice', '_blank',  "width=820,height=800,left=800,top=300"); // 박스오피스 페이지를 새 창으로 열기
		    });
	    	
	    	  // 영화등록 ajax
	        $('#getMovie').click(function(e) {
	            e.preventDefault(); // 기본 이벤트(폼 전송) 막음

	            var movieNm = $('#movie_name').val();

	            $.ajax({    
	                type : 'get',           // 타입 (get, post, put 등등)    
	                url : 'https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=YM1N07PIQD3S9ZQD2Y5W&title=' + movieNm,           // 요청할 서버url    
	                  
	                dataType : 'json',       // 데이터 타입 (html, xml, json, text 등등)    
	                success : function(result) { // 결과 성공 콜백함수
	                console.log(result);
	                    debugger;
	                if(result && result.Data && result.Data[0] && result.Data[0].Result && result.Data[0].Result[0]){
	                    // 영화 데이터가 저장된 json 타입 데이터
	                    var movieData = result.Data[0].Result[0];
	                    //장르
	                    $('#genre_num').val(result.Data[0].Result[0].genre);
	                    // 감독                   
	                    $('#movie_director').val(result.Data[0].Result[0].directors.director[0].directorNm);
	                    // 개봉일
	                    let dateString = result.Data[0].Result[0].repRlsDate;
	                    let year = dateString.substring(0, 4);
	                    let month = dateString.substring(4, 6);
	                    let day = dateString.substring(6, 8);
	                    let formattedDate = year + '-' + month + '-' + day;
	                    $('#movie_open_date').val(formattedDate);
	                    
	                    // 종영일
	               		// movie_open_date에 저장된 날짜를 Date 객체로 변환
	                    let openDate = new Date(year, month, day);
	                    // 1년을 더한 날짜 계산
	                    let endDate = new Date(openDate.getFullYear() + 1, openDate.getMonth(), openDate.getDate());
	                    // 년, 월, 일을 문자열로 변환하여 YYYY-MM-DD 형식으로 조합
	                    let endYear = endDate.getFullYear();
	                    let endMonth = endDate.getMonth() < 10 ? '0' + endDate.getMonth() : endDate.getMonth(); // 한자리수일 경우 앞에 0 추가
	                    let endDay = endDate.getDate() < 10 ? '0' + endDate.getDate() : endDate.getDate();
	                    let formattedEndDate = endYear + '-' + endMonth + '-' + endDay;
	                    // movie_end_date에 1년을 더한 날짜 설정
	                    $('#movie_end_date').val(formattedEndDate);
	                    
	                    // 개봉상태
	                    // 계산해서 넣어야함
						var today = new Date(); 
						var todayYear = today.getFullYear();
						var todayMonth = today.getMonth() + 1; 
						var todayDay = today.getDate();
						var todayDate = new Date(todayYear, todayMonth - 1, todayDay); 
						
						// API로부터 받아온 개봉일을 파싱하여 비교하기 적합한 형태로 변환
						var fomatYear = parseInt(dateString.substring(0, 4));
						var formatMonth = parseInt(dateString.substring(4, 6));
						var formatDay = parseInt(dateString.substring(6, 8));
						var formatDate = new Date(fomatYear, formatMonth - 1, formatDay); 
						
						// 오늘 날짜와 API로부터 받아온 개봉일을 비교
						if (formatDate < todayDate) {
		                    $('#movie_status').val("개봉");
						} else {
		                    $('#movie_status').val("개봉예정");
							
						}
						
	                    // 영화등급
	                    $('#movie_grade').val(result.Data[0].Result[0].rating);
	                    // 상영시간
	                    $('#movie_runtime').val(result.Data[0].Result[0].runtime);
	                    // 스틸컷  
	                    $('#movie_stillCut').val(result.Data[0].Result[0].stlls.split("|")[0]);
	                    // 스틸컷2  
	                    $('#movie_stillCut2').val(result.Data[0].Result[0].stlls.split("|")[1]);
	                    // 스틸컷3  
	                    $('#movie_stillCut3').val(result.Data[0].Result[0].stlls.split("|")[2]);
	                    // 포스터
	                    $('#movie_poster').val(result.Data[0].Result[0].posters.split("|")[0]);
	                    // 트레일러
	                    $('#movie_trailer').val(result.Data[0].Result[0].vods.vod[0].vodUrl);
	                    // 줄거리
	                    $('#movie_story').val(result.Data[0].Result[0].plots.plot[0].plotText);  
	                } else {
	                	 alert("검색 결과가 없습니다.");
	                     $('#genre_num').val("");
	                     $('#movie_director').val("");
	                     $('#movie_open_date').val("");
	                     $('#movie_end_date').val("");
	                     $('#movie_status').val("");
	                     $('#movie_grade').val("");
	                     $('#movie_runtime').val("");
	                     $('#movie_stillCut').val("");
	                     $('#movie_poster').val("");
	                     $('#movie_trailer').val("");
	                     $('#movie_story').val("");
	                }
	                
	                
	                },    
	                error : function(request, status, error) { // 결과 에러 콜백함수        
	                    console.log(error)
	                    
	                }
	            }); //ajax
	        });
	    }); // document.ready
	    
	    
 	</script>
</body>
</html>