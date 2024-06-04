<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>박스오피스 조회</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}

#header {
	margin-top: 30px;
	text-align: center;
	padding: 20px;
}

#resultArea {
	text-align: center;
	
}
table {
	border-collapse: collapse;
	width: 90%;
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



#bottom {
	text-align: center;
	margin-top: 20px;
}
</style>
<script type="text/javascript">
	$(function() {
		
		$("#closeButton").click(function() {
	         window.close(); // 현재 창 닫기
	     });
		
		
		$("#btnRequest").on("click", function() {
		
			let selectedDate = $("#date").val();
			//console.log("선택된 날짜 : " + selectedDate); 
			if(selectedDate == "") {
				alert("날짜 선택 부탁드립니다!");
				$("#date").focus();
				return;
			}
			
			// -----------------------------------------------------
		
			let targetDt = selectedDate.replaceAll("-",  "");
			//console.log("요청할 조회 대상일자(replaceAll) : " + targetDt); 
			
			$(".movieList").remove();
			$(".info").remove();
			let key = "f5eef3421c602c6cb7ea224104795888";
			
			$.ajax({
				type : "GET",
				url : "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=" + key + "&targetDt=" + targetDt,
				dataType : "json",
				success : function(data) {
					let boxOfficeResult = data.boxOfficeResult;
					let boxofficeType = boxOfficeResult.boxofficeType;
					let showRange = boxOfficeResult.showRange;
						
					$("#resultArea").prepend("<h3 class='info'>" + boxofficeType + "(" + showRange.split("~")[0] + ")</h3>");
							
					let dailyBoxOfficeList = boxOfficeResult.dailyBoxOfficeList;
 					//console.log("dailyBoxOfficeList : " + dailyBoxOfficeList);
			
					for(let movie of dailyBoxOfficeList) {
						// 상세정보 조회를 위한 변수 생성
						let movieCd = movie.movieCd;
						let movieDetailUrl = "test6_json_movie_detail.jsp?key=" + key + "&movieCd=" + movieCd;
						
						$("#resultArea > table").append( // 테이블 내의 마지막에 행 추가
							"<tr class='movieList'>"
							+ "<td>" + movie.rank + "</td>"
							+ "<td>" + movie.movieNm + "</td>"
							+ "<td>" + movie.openDt + "</td>"
							+ "<td>" + movie.audiAcc + " 명</td>"
							+ "</tr>"
						);
					}
				},
				error : function() {
					$("#resultArea").html("AJAX 요청 실패!");
				}
			});
		});
	});
	 
	
</script>
</head>
<body>
	<div id = "header">
	<h1>박스오피스 순위 조회</h1>
	<input type="date" id="date" class="btn btn-outline-primary">
	<input type="button" value="일별 박스오피스 조회" id="btnRequest" class="btn btn-outline-primary">
	</div>
	<hr>
	<div id="resultArea">
		<table border="1">
			<tr>
				<th width="80">현재순위</th>
				<th width="400">영화명</th>
				<th width="150">개봉일</th>
				<th width="100">누적관객수</th>
			</tr>
			<%-- 영화 정보 파싱 결과 출력 위치 --%>
		</table>
	</div>
	<hr>
	<div id="bottom">
	<button id="closeButton" class="btn btn-outline-primary">닫기</button>
	</div>
</body>
</html>








