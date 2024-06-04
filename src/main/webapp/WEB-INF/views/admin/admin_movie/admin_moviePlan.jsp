<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지 - 회원관리</title>
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
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}

table {
	border-collapse: collapse;
	width: 1400px;
	margin: 0rem auto;
	box-shadow: 4px 4px 10px 0 rgba(0, 0, 0, 0.1);
	background-color: white;
	text-align: center;
}

/* 테이블 행 */
th, td {
	padding: 8px;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #1b1b1b;
	color: #ddd;
}

/* 테이블 올렸을 때 */
tbody tr:hover {
	background-color: #eee;
	opacity: 0.9;
	cursor: pointer;
}

.admin_plan_body {
	margin-bottom: 50px;
}

.admin_moviePlan_search {
	height: 35px;
	width: 85%;
	background: #black;
	text-align: center;
}
.admin_plan_search>button {
	width: 90px;
	height: 46px;
	background: black;
	outline: none;
	color: white;
	font-weight: bold;
}

.admin_plan_title {
	font-size: 30px;
	margin-top: 30px;
	margin-bottom: 20px;
	margin-left: 120px;
	width: 230px;
}
.admin_plan_body_search{
	margin-bottom: 30px;
	width: 1200px;
}
.moviePlanSearchBox{
	width: 800px;
	text-align: center;
	margin: 30px auto;
}
.moviePlanSearchBox > select{
	width: 130px;
	margin-right: 10px;
	margin-bottom: 20px;
}
.moviePlanSearchBox > input{
	width: 200px;
}
.moviePlanSearchBox > button{
	height: 40px;
	margin-bottom: 5px;
	margin-left: 10px;
}
.moviePlanSearchBox > h3{
	margin-top: 10px;
}
#pageList{
	text-align: center;
	font-size: 20px;
	margin-bottom: 20px;
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
</style>
</head>
<body>

	<header>
		<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
	</header>

	<main>
		<!-- 메인이랑 바디 사이 -->
		<div class="row">

			<div class="col-md-2">
				<!-- 사이드바 영역 -->
					<jsp:include page="/WEB-INF/views/inc/admin_aside.jsp"></jsp:include>
			</div>

			<div class="col-md-9">
				<!--  메인 중앙 영역  -->
				
				<!-- 파라미터 없을 시 기본값 1 저장 -->
				<c:set var="pageNum" value="1"/>
				<c:if test="${not empty param.pageNum}">
					<c:set var="pageNum" value="${param.pageNum}"/>
				</c:if>
				
				<div class="admin_plan_title" align="left">🗓️상영일정관리</div>
				
				<div class="admin_plan_body">
					<form action="admin_moviePlan_reg" method ="post">
						<table class="admin_plan_body_search">
							<thead>
								<tr>
									<th width="150px">극장</th>
									<th width="100px">상영관</th>
									<th width="200px">영화제목</th>
									<th width="80px">2D/3D</th>
									<th width="150px">상영날짜</th>
									<th width="100px">상영시간</th>
									<th width="100px">상영종료</th>
									<th width="100px">상영등록</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>
										<div>
											<select id="theaterSelect" class="admin_moviePlan_search" name="theater_num" required>
												<option value="">미선택</option>
											<c:forEach var="theaterName" items="${theaterNameList}">
												<option value="${theaterName.theater_num}">${theaterName.theater_name}</option>
											</c:forEach>
											</select> 
										</div>
									</td>
									<td>
										<div>
											<select id="screenSelect" class="admin_moviePlan_search" name="screen_cinema_num" required></select> 
										</div>
									</td>
									<td>
										<div>
											<select id="movieSelect" name="movie_num" class="admin_moviePlan_search" required>
												<option value="">영화선택</option>
												<c:forEach var="movie" items="${movieList}">
													<option value="${movie.movie_num}">${movie.movie_name}</option>
												</c:forEach>
											</select> 
										</div>
									</td>
									<td>
										<select name = "screen_dimension" class="admin_moviePlan_search" required>
											<option value="2D">2D</option>
											<option value="3D">3D</option>
										</select>
									</td>
									<td>
										<input type="date" class="admin_moviePlan_search" id="scs_date" name="scs_date" min="yyyy-mm-dd" required>
									</td>
									<td>
										<select id="hourSelect" name="scs_start_time" class="admin_moviePlan_search" required>
											<option value="">시간선택</option>
											<c:forEach var="hour" begin="9" end="24">
											    <option value="${hour}:00" >${hour}:00</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<input type="text" id="movieEndTime" name="scs_end_time" class="admin_moviePlan_search" readonly>
									</td>
									<td>
										<button type="submit" class="btn btn-outline-primary">등록하기</button>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					
					<div class="moviePlanSearchBox">
						<h3>상영일정 조회하기</h3>
						
						<select id="searchTheater" class="admin_moviePlan_search" name="theater_num">
								<option value="0">극장선택</option>
							<c:forEach var="theaterName" items="${theaterNameList}">
								<option value="${theaterName.theater_num}">${theaterName.theater_name}</option>
							</c:forEach>
						</select>
						
						<select id="searchScreen" class="admin_moviePlan_search" name="screen_num" required></select> 
						
						<input type="date" class="admin_moviePlan_search" name="scs_date" id="searchDate">
						<button type="submit" class="btn btn-outline-primary" id="searchBtn">조회하기</button>
						<button type="submit" class="btn btn-outline-primary" id="searchBtn" onclick="location.href='admin_moviePlan'">목록으로</button>
					</div>
					
					<table class="admin_plan_body_search">
						<thead>
							<tr>
								<th>상영번호</th>
								<th>극장</th>
								<th>상영관</th>
								<th>영화제목</th>
								<th>2D/3D</th>
								<th>상영날짜</th>
								<th>상영시간</th>
								<th>상영종료</th>
								<th>상영일정삭제</th>
							</tr>
						</thead>
						<tbody id="moviePlanList">
							<c:forEach var="moviePlan" items="${moviePlanList}">
								<tr>
									<td>${moviePlan.scs_num}</td>
									<td>${moviePlan.theater_name}</td>
									<td>${moviePlan.screen_cinema_num}</td>
									<td>${moviePlan.movie_name}</td>
									<td>${moviePlan.screen_dimension}</td>
									<td>${moviePlan.scs_date}</td>
									<td>${moviePlan.scs_start_time}</td>
									<td>${moviePlan.scs_end_time}</td>
									<td>
<%-- 										<button type="button" class="btn btn-outline-primary" onclick="moviePlanEdit(${moviePlan.scs_num})">수정</button> --%>
										<button type="button" class="btn btn-outline-primary" onclick="moviePlanWithdraw(${moviePlan.scs_num})">삭제</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<section id="pageList">
					<button type="button" class="btn btn-outline-primary" onclick="location.href='admin_moviePlan?pageNum=${pageNum - 1}'"
						<c:if test="${pageNum le 1}">disabled</c:if>>
						이전
					</button>
					
					<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}" step="1" >
							<c:choose>
								<c:when test="${pageNum eq i}">
									<b>${i}</b>
								</c:when>				
								<c:otherwise>
									<a href="admin_moviePlan?pageNum=${i}">${i}</a>
								</c:otherwise>
							</c:choose>
					</c:forEach>
					
					<button type="button" class="btn btn-outline-primary" onclick="location.href='admin_moviePlan?pageNum=${pageNum + 1}'"
						<c:if test="${pageNum ge pageInfo.maxPage}">disabled</c:if>>
						다음
					</button>
				</section>

			</div>

		</div>
		<div>
		
		</div>
	</main>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
	</footer>
	
	<script type="text/javascript">
		// 상영관리 상세보기
		function moviePlanEdit(scs_num) {
			location.href = "admin_moviePlan_form?scs_num=" + scs_num;
		}
		
		// 상영관리 삭제하기
		function moviePlanWithdraw(scs_num) {
			if(confirm("정말 삭제하시겠습니까?")){
				location.href = "admin_moviePlan_delete?scs_num=" + scs_num;
			}
		}
		
		// 오늘 이전 날짜 설정 disable 시키기
		var now = new Date();
		var year = now.getFullYear();
		var month = (now.getMonth() + 1).toString().padStart(2, '0');
		var day = now.getDate().toString().padStart(2, '0');
	    var minDate = year + '-' + month + '-' + day;
	    document.getElementById('scs_date').setAttribute('min', minDate);
		
		// 극장 ajax
		$(document).ready(function() {
			
			// 상영시간 제약조건 초기화
			function resetHourSelect() {
		         $('#hourSelect option').prop('disabled', false).css({"background": "", "color": ""});
		    }
	
			
			// 극장 선택시 상영관 선택
		    $('#theaterSelect').change(function() {
		        var theater_num = $("#theaterSelect").val();
		        $.ajax({
		            url: 'getScreens', // 상영관 정보를 가져오는 엔드포인트
		            method: 'GET',
		            data: { theater_num: theater_num },
		            dataType: 'json', // 전달 데이터 타입 json
		            success: function(response) {
		            	// 기존옵션 제거
		                $('#screenSelect').empty();
		                $('#scs_date').val("");
		                $('#movieSelect').val("");
		                $('#hourSelect').val("");
		                $('#movieEndTime').val("");
		                resetHourSelect();
		                // option 요소 생성하여 추가
	                	$('#screenSelect').append('<option value="">미선택</option>');
		                $.each(response, function(index, screen_info){
		                	$('#screenSelect').append('<option value="' + screen_info.screen_cinema_num + '">' + screen_info.screen_cinema_num + '관</option>');
		                });
		            }
		        });
		    });
			
			// 날짜 정보가 변할떄 코드 시작
			$('#scs_date, #screenSelect').change(function(){
				let theaterSelect = $('#theaterSelect').val();
				let screenSelect = $('#screenSelect').val();
				let movieSelect = $('#movieSelect').val();
				let scs_date = $('#scs_date').val();
				$('#movieEndTime').val(""); // 기존옵션 제거
				if(theaterSelect == "" ){
					alert("극장정보를 선택해주세요");
					$('#scs_date').val("");
					$('#theaterSelect').focus();
					return;
				}
				if(screenSelect == "" ){
					alert("상영관을 선택해주세요");
					$('#scs_date').val("");
					$('#screenSelect').focus();
					return;
				}
				if(movieSelect == ""){
					$('#scs_date').val("");
					$('#movieSelect').focus();
					return;
				}
				
				resetHourSelect(); // 시간 선택 초기화
				
				// 상영 가능 시간 정보 ajax
				$.ajax({
					type: "GET",
					url: "moviePlan_time",
					data: {
						theaterSelect : theaterSelect,
						screenSelect : screenSelect,
						scs_date : scs_date,
					},
					success : function(data) {
						// 기존 옵션 비우기
						$('#hourSelect').val("");
						// 이미 일정이 있는 시간 disabled
		 				for(movieTime of data){
// 		 					debugger;
		 					var time = movieTime.scs_start_time;
		 					var endTime = movieTime.scs_end_time;
		 					// 9시 이전 시간이 넘어올때는 startTime을 9시로 설정
		 					if (time < 9){
		 						time = 9;
		 					} else {
		 						time = movieTime.scs_start_time;
		 					}
		 					if(endTime < 9){
		 						endTime = 24;
		 					} else{
		 						endTime = movieTime.scs_end_time;
		 					}
		 					
		 					for(let i = time; i <= endTime; i++){
		 						$("#hourSelect option[value='"+i+":00']").prop('disabled',true).css({"background": "lightgray", "color" : "white"});
		 						console.log("i: " + i);
		 					}
		 					
// 		 					if(time < 9){
// 			 					for(let i = 9; i < movieTime.scs_end_time; i++){
// 			 						$("#hourSelect option[value='"+i+":00']").prop('disabled',true).css({"background": "lightgray", "color" : "white"});
// 			 						console.log("i: " + i);
// 			 					}
// 		 					} else {
// 			 					for(let i = movieTime.scs_start_time; i < movieTime.scs_end_time; i++){
// 			 						$("#hourSelect option[value='"+i+":00']").prop('disabled',true).css({"background": "lightgray", "color" : "white"});
// 			 						console.log("i: " + i);
// 			 					}
// 		 					}
		 					
	 					}						
// 			 					debugger;
					},
					error : function() {
// 						alert("상영시간 선택 오류발생!");
					}
					
				});
				
			});
			
			// 상영시간 ajax
		    $('#hourSelect').change(function() {
		    	if($('#theaterSelect').val() == "" ){
					alert("극장정보를 선택해주세요");
					$('#hourSelect').val("");
					$('#theaterSelect').focus();
					return;
				}
		    	if($('#screenSelect').val() == "" ){
					alert("상영관을 선택해주세요");
					$('#scs_date').val("");
					$('#screenSelect').focus();
					return;
				}
				if($("#movieSelect").val() == ""){
					alert("영화를 선택해주세요");
					$('#hourSelect').val("");
					$('#movieSelect').focus();
					return;
				}
				if($("#scs_date").val() == ""){
					alert("상영날짜를 선택해주세요");
					$('#hourSelect').val("");
					$('#scs_date').focus();
					return;
				}
		        $.ajax({
		            url: 'movieEndTime', //  영화시간 정보를 가져오는 엔드포인트
		            method: 'GET',
		            data: { hourSelect: $("#hourSelect").val(),
		            		movieSelect: $('#movieSelect').val()
		           	},
		            dataType: '', // 전달 데이터 타입 json
		            success: function(response) {
		                $('#movieEndTime').empty(); // 기존옵션 제거
		                // option 요소 생성하여 추가
	                	$('#movieEndTime').val(response);
		            }
		        });
		    });
		    // theaterSelect, screenSelect 변경 시에도 hourSelect 초기화
	        $('#theaterSelect, #screenSelect').change(function() {
	            resetHourSelect(); // 시간 선택 초기화
	        });
		    
		    // 상영일정 조회하기
	        $('#searchBtn').click(function() {
		    	if($('#searchTheater').val() == 0){
					alert("극장정보를 선택해주세요");
					$('#searchTheater').focus();
					return;
				}
		    	if($('#searchDate').val() == "" ){
					alert("상영날짜를 선택해주세요");
					$('#searchDate').focus();
					return;
				}
		    	
		    	$.ajax({
		    		type: "GET",
		    		url: "searchMoviePlanList",
		    		dataType: "JSON",
		    		data: {
		    			searchTheater: $('#searchTheater').val(),
		    			searchDate: $('#searchDate').val(),
		    			searchScreen: $('#searchScreen').val()
// 		    			pageNum: currentPage 
		    		},
		    		success: function(data) {
// 						debugger;
		    			$("#moviePlanList").empty();
						var searchHtml = '';
		                data.forEach(function(searchMovieList) {
		                	var scs_date = new Date(searchMovieList.scs_date).toLocaleDateString().replace(/\s/g, "").replaceAll(".", "-").slice(0, -1);
		                	debugger;
		                	searchHtml += '<tr>'
									  +	 '<td>' + searchMovieList.scs_num + '</td>'
									  +		'<td>' + searchMovieList.theater_name + '</td>'
									  +		'<td>' + searchMovieList.screen_cinema_num + '</td>'
									  +		'<td>' + searchMovieList.movie_name + '</td>'
									  +		'<td>' + searchMovieList.screen_dimension + '</td>'
									  +		'<td>' + scs_date + '</td>'
									  +		'<td>' + searchMovieList.scs_start_time + '</td>'
									  +		'<td>' + searchMovieList.scs_end_time + '</td>'
									  +		'<td><button type="button" class="btn btn-outline-primary" onclick="moviePlanWithdraw(' + searchMovieList.scs_num + ')">삭제</button>'
									  +		'</td></tr>'
		                });
		                $("#moviePlanList").append(searchHtml);
// 		                updatePagination(data.pageInfo);
						$("#pageList").empty();

					},
					error: function(data) {
						
					}
		    		
		    	});
		    	
		    	
		    	
		    }); // 상영 일정 조회 끝
		    
		 // 극장 선택시 상영관 선택
		    $('#searchTheater').change(function() {
		        var theater_num = $("#searchTheater").val();
		        $.ajax({
		            url: 'getScreens', // 상영관 정보를 가져오는 엔드포인트
		            method: 'GET',
		            data: { theater_num: theater_num },
		            dataType: 'json', // 전달 데이터 타입 json
		            success: function(response) {
		            	// 기존옵션 제거
		                $('#searchScreen').empty();
		                // option 요소 생성하여 추가
	                	$('#searchScreen').append('<option value="">상영관선택</option>');
		                $.each(response, function(index, screen_info){
		                	$('#searchScreen').append('<option value="' + screen_info.screen_cinema_num + '">' + screen_info.screen_cinema_num + '관</option>');
		                });
		            }
		        });
		    });
		    
// 		    function updatePagination(pageInfo) {
// 		        $('#pageList').empty(); // 기존 내용을 비웁니다.

// 		        // 이전 버튼 생성
// 		        var prevButton = $('<button>', {
// 		            type: 'button',
// 		            class: 'btn btn-outline-primary',
// 		            text: '이전',
// 		            click: function() { if (currentPage > 1) loadPage(currentPage - 1); }
// 		        }).prop('disabled', currentPage <= 1);
// 		        $('#pageList').append(prevButton);

// 		        // 페이지 번호 생성
// 		        for (var i = pageInfo.startPage; i <= pageInfo.endPage; i++) {
// 		            if (i === currentPage) {
// 		                $('#pageList').append($('<b>').text(i));
// 		            } else {
// 		                var pageLink = $('<a>', {
// 		                    href: '#',
// 		                    text: i,
// 		                    click: (function(pageNum) {
// 		                        return function(event) {
// 		                            event.preventDefault();
// 		                            loadPage(pageNum);
// 		                        };
// 		                    })(i)
// 		                });
// 		                $('#pageList').append(pageLink);
// 		            }
// 		        }

// 		        // 다음 버튼 생성
// 		        var nextButton = $('<button>', {
// 		            type: 'button',
// 		            class: 'btn btn-outline-primary',
// 		            text: '다음',
// 		            click: function() { if (currentPage < pageInfo.maxPage) loadPage(currentPage + 1); }
// 		        }).prop('disabled', currentPage >= pageInfo.maxPage);
// 		        $('#pageList').append(nextButton);

// 		        // 현재 페이지 번호 업데이트
// 		        currentPage = pageInfo.currentPage;
// 		    }
		    
			
	    }); // document.ready 끝
		
	
	</script>
</body>
</html>