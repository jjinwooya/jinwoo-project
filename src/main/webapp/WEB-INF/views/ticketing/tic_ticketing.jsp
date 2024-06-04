<%@page import="itwillbs.p2c3.boogimovie.handler.DateUtils"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
</style>
<meta charset="UTF-8">
<title>부기무비 빠른예매</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/css/tic_ticketing.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    .selected {
        background-color: #FFD700; /* 선택된 항목의 배경색을 설정합니다. */
    }

	.final_list {
		width: 100%;
		margin-left: 5px;
		margin-top: 5px;
		padding-top: 20px;
	}
	
	body {
		margin: 0px;
	}
	
	/* 스크롤바 설정*/
	.scroll::-webkit-scrollbar {
		width: 18px;
		height: 18px;
	}
	
	/* 스크롤바 막대 설정*/
	.scroll::-webkit-scrollbar-thumb {
		background-color: rgba(255, 255, 255, 1);
		/* 스크롤바 둥글게 설정    */
		border-radius: 10px;
		border: 7px solid rgba(0, 0, 0, 0.8);
	}
	
	/* 스크롤바 뒷 배경 설정*/
	.scroll::-webkit-scrollbar-track {
		background-color: rgba(0, 0, 0, 0);
	}
	
	.tic {
		padding-right: 0 !important;
		padding-left: 0 !important;
	}
	
	.tic_movie {
		background-color: white;
		height: 800px;
		border-left: solid 3px black;
		border-top: solid 3px black;
		border-bottom: solid 3px black;
		margin-right: 0;
	}
	
	.tic_theater {
		background-color: white;
		height: 800px;
		padding: 0px;
		border: solid 3px black;
	}
	
	.tic_final {
		background-color: white;
		height: 800px;
		padding: inherit;
		border-right: solid 3px black;
		border-top: solid 3px black;
		border-bottom: solid 3px black;
	}
	
	.explain {
		height: 10%;
		border-bottom: solid 3px black;
		padding: 20px;
		text-align:center;
		font-size: 22px;
		word-break: keep-all;
	}
	
	.list {
		height: calc(90% - 20px); /* 내부 padding과 border 높이를 고려한 계산 */
		padding: 5px;
	}
	
	li {
		list-style-type: none;
	}
	
	ul {
		padding-left: 5px !important;
	}
	
	.daylist {
		height: 10%;
		border-bottom: solid 3px black;
		display: flex; /* Flexbox 설정 */
		align-items: center; /* 버튼을 수직으로 가운데 정렬 */
	}
	
	.scroll_button {
		cursor: pointer;
		padding: 5px;
		border: none;
		width: 50px;
		height: 50px;
		top: 50%;
		transform: translateY(-50%);
	}
	
	.scroll-button.left {
		left: 0;
	}
	
	.scroll-button.right {
		right: 0;
	}
	
	button img {
		height: 100%;
		width: 100%;
	}
	
	.daylist button {
		margin: 0 5px; /* 버튼들 사이의 간격 조절 */
	}
	
	.movielist {
		height: calc(95% - 80px);
		padding-left: 20px;
		overflow-y: scroll;
		white-space: nowrap;
	}
	
	.select_container {
		margin-top: -15px;
		position: relative;
		height: 10%;
		margin-left: 140px;
		width: 200px;
	}
	
	.movie_atrbt {
		height: 80px;
	}
	
	.theaterlist {
		overflow-y: scroll; /* 세로 스크롤이 필요할 때만 스크롤을 표시합니다. */
		max-height: 100%; /* 부모 요소의 높이에 맞게 조절합니다. */
		white-space: nowrap;
		padding-left: 10px;
	}
	
	.daylist {
		white-space: nowrap; /* 일자 목록이 가로로 나열되도록 설정합니다. */
		overflow-x: scroll; /* 가로 스크롤을 표시합니다. */
	}
	
	.finallist {
		height: 95%;
		padding: inherit;
	}
	
	.finalmovielist {
		height: calc(90% - 50px);
		padding-left: 10px;
		overflow-y: scroll;
		white-space: nowrap;
	}
	
	*, *::before, *::after {
		box-sizing: border-box;
	}
	
	:root { -
		-select-border: #777; -
		-select-focus: blue; -
		-select-arrow: var(- -select-border);
	}
	
	select {
		appearance: none;
		background-color: transparent;
		border: none;
		padding: 0 1em 0 0;
		margin: 0;
		width: 100%;
		font-family: inherit;
		font-size: 80%;
		cursor: inherit;
		line-height: inherit;
		z-index: 1;
		&::
		-ms-expand
		{
		display
		:
		none;
	}
	
	outline
	:
	 
	none
	;
	
	
	}
	.select {
		display: grid;
		grid-template-areas: "select";
		align-items: center;
		position: relative;
		select
		,
		&
		:
		:
		after
		{
		
	    
		grid-area
		:
		 
		select;
	}
	
	min-width: 15ch ;
	  max-width: 30ch ;
	
	  border: 1px solid var(--select-border) ;
	  border-radius: 0.25em ;
	  padding: 0.25em 0.5em ;
	
	  font-size: 1.25rem ;
	  cursor: pointer ;
	  line-height: 1.1 ;
	
	  background-color: #fff ;
	  background-image: linear-gradient(to top, #f9f9f9, #fff 33 %) ;
	
	
	
	select:focus+.focus {
		position: absolute;
		top: -1px;
		left: -1px;
		right: -1px;
		bottom: -1px;
		border: 2px solid var(- -select-focus);
		border-radius: inherit;
	}
	
	select[multiple] {
		padding-right: 0;
		/*
	   * Safari will not reveal an option
	   * unless the select height has room to 
	   * show all of it
	   * Firefox and Chrome allow showing 
	   * a partial option
	   */
		height: 6rem; option { white-space : normal;
		outline-color: var(- -select-focus);
	}
	
	/* 
	   * Experimental - styling of selected options
	   * in the multiselect
	   * Not supported crossbrowser
	   */
	&
	:not(:disabled) option {
		border-radius: 12px;
		transition: 120ms all ease-in; &: checked { background :
		linear-gradient( hsl( 242, 61%, 76%), hsl( 242, 61%, 71%));
		padding-left: 0.5em;
		color: black !important;
	}
	
	}
	}
	.select--disabled {
		cursor: not-allowed;
		background-color: #eee;
		background-image: linear-gradient(to top, #ddd, #eee 33%);
	}
	
	}
	.side_var {
		margin-right: 50px;
	}
	
	.tic_main {
		width: 1400px;
		margin: 0 auto;
	}
	
	.tic_title {
		margin: 30px auto;
	}
	
	.tic_row {
		margin-bottom: 100px;
		margin-left: 300px;
	}
	
	.tic_button {
		margin: 0 auto;
		margin-bottom: 100px;
		width: 150px;
	}
	
	a {
		text-decoration: none !important;
		color: black !important;
	}
	
	.col-sm-6> ul{
		margin-top: 20px;
		margin-left: 5px;
	}
	.daylistBtn > input[type=button]{
		padding: 10px 20px;
		border: none;
		background: white;
	}
	.daylistBtn > input[type=button].selected{
		background: #c7cdff;
		transition-duration: .1s;
		padding: 10px 30px;
	}
	.daylistBtn{
		margin: 0 15px;
	}
	*.selected {
		background-color: #c7cdff;
		padding: 10px 10px;
		transition-duration: .1s;
	}
	* {
		font-size: 20px;
	}
	.finalmovielist{
		padding: 0px;
	}
	.final_list{
		border: 1px solid #c7cdff;
		background: #c7cdff;
		color: black;
		padding: 10px 20px;
	}
	.final_list.selected{
		border: 1px solid #c7cdff;
		background: #181934;
		color: #c7cdff;
		padding: 20px 20px;
	}
</style>
</head>

<!-- 예매 메인 -->
<body>
<!-- 현재날짜와 이번달 최대일수를 계산하여 출력 -->
<%
    LocalDate currentDate = LocalDate.now();
    String startDate = currentDate.toString();
    int maxDay = currentDate.lengthOfMonth();
    int nowDay = currentDate.getDayOfMonth();
    int inputDay = nowDay + 10;
    pageContext.setAttribute("nowDay", nowDay);
    pageContext.setAttribute("day", inputDay > maxDay ? maxDay : inputDay);
    pageContext.setAttribute("currentDate", currentDate);
    pageContext.setAttribute("maxDay", maxDay);
%>

<header>
    <jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>

<form action="tic_choose_seat" method="post" id="fr">
<section class="tic_main">
    <div class="tic_title">
        <h2>영화 예매</h2>
            <hr>
    </div>
    <div class="row asdf">
        <!-- 본문 시작 -->
        <div class="col-md-12">
            <div class="row tic_row">
            <!-- tic_movie영역 시작 -->
                <div class="col-md-3 tic" style="padding-left: 20px; padding-right: 20px;">
                    <div class="tic_movie">
                    <!-- 설명영역 -->
                        <div class="explain" id="movieSelected">
                            영화를 선택해주세요
                        </div>
                    <!-- select박스 -->
                    <div class="row">
                        <div class="col-md-4">
                            <input type="checkbox" id="like_movie" name="like_movie" value="나의취향" class="col-md-3">내취향
                        </div>
                    </div>
                    <!-- 영화정보 -->
                    <div class="movielist scroll" id="movielist">
                        <c:forEach items="${movieList }" var="movie">
                            <div class="movie_atrbt">
                                <c:choose>
                                    <c:when test="${movie.movie_grade eq '전체관람가' }">
                                        <img src="${pageContext.request.contextPath}/resources/images/tic_icon_all.gif" style="width: 48px; height: 48px;">
                                    </c:when>
                                    <c:when test="${movie.movie_grade eq '12세관람가' }">
                                        <img src="${pageContext.request.contextPath}/resources/images/tic_icon_over12.gif" style="width: 48px; height: 48px;">
                                    </c:when>
                                    <c:when test="${movie.movie_grade eq '15세관람가' }">
                                        <img src="${pageContext.request.contextPath}/resources/images/tic_icon_over15.gif" style="width: 48px; height: 48px;">
                                    </c:when>
                                    <c:when test="${movie.movie_grade eq '18세관람가(청소년관람불가)' }">
                                        <img src="${pageContext.request.contextPath}/resources/images/tic_icon_over18.gif" style="width: 48px; height: 48px;">
                                    </c:when>
                                </c:choose>
                                    &nbsp;&nbsp;&nbsp;
                                    <span id="movie_${movie.movie_num}">
                                        <a class="movie-link" onclick="movieClick('${movie.movie_name}', '${movie.movie_num}')">
                                            ${movie.movie_name}
                                        </a>
                                    </span>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- tic_movie종료 -->

                <!-- tic_theater 시작 -->
                <div class="col-md-3 tic" style="padding-left: 20px; padding-right: 20px;">
                    <div class="tic_theater">
                        <!-- 설명영역 -->
                        <div class="explain" id="theaterSelected">
                            상영관을 선택해주세요
                        </div>
                        <div class="row list">
                            <!-- theater 리스트1 -->
                            <div class="col-sm-6" style="border-right: solid 3px black; text-align: left;">
                                <ul>
                                    <li><a class="theater-link" id="entireTheaterLink" onclick="theaterType('EntireTheater', 'entire', this)">전체극장</a></li>
                                </ul>
                                <ul>
                                    <li><a class="theater-link" id="myTheaterLink" onclick="theaterType('MyTheater','${sessionScope.sId}', this)">MY영화관</a></li>
                                </ul>
                            </div>
                            <!-- theater 리스트2 -->
                            <div class="col-sm-6 theaterlist scroll" id="theaterlist">
                                <c:forEach items="${theaterList }" var="theater">
                                    <ul>
                                        <li><a class="theater-link" onclick="theaterClick('${theater.theater_name}', this)">${theater.theater_name }</a> </li>
                                    </ul>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- tic_theater 종료 -->
                <!-- tic_final 시작 -->
                <div class="col-md-6 tic" style="padding-left: 20px;">
                    <div class="tic_final">
                        <!-- 설명영역 -->
                        <div class="explain" id="daySelected">
                            ${currentDate}
                        </div>
                            <div class="finallist">
                                <div class="daylist scroll">
                                    <div class="daylistBtn">
                                        <c:forEach begin="1" end="10" var="i">
                                            <c:choose>
                                                <c:when test="${nowDay <= maxDay}">
                                                    <input type="button" onclick="javascript:dayClick('${currentDate }', ${nowDay }, this)" value="${nowDay }일">&nbsp;
                                                    <%
                                                        nowDay++;
                                                    pageContext.setAttribute("nowDay", nowDay);
                                                    %>
													</c:when>
													<c:otherwise>
                                                    ||
                                                    <%
                                                    	nowDay = 1;
                                                    pageContext.setAttribute("nowDay", nowDay);
                                                    %>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="finalmovielist scroll" id="finalmovielist">
                                    <div style="height: 300px">
                                        <br>
                                        <div align="center">영화 상영관 날짜정보를 선택해주세요</div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <!-- tic_final 종료 -->
                </div>
            </div>
        </div>
    </div>
    <!-- tic_row 종료 -->
    <div class="tic_button">
        <button type="submit" class="btn btn-outline-primary">좌석 선택</button>
    </div>
</section>
</form>

<footer>
    <jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    let selectedMovie = "";
    let selectedTheater = "";
    let selectedDay = "";
    let form = $("#fr");

    function final_list_selected(movie_name, start_time, end_time, theater_name, screen_cinema_num, selected_day, element) {
        let final_list_selected_things = "/" + movie_name + "/"
            + start_time + "/"
            + end_time + "/"
            + theater_name + "/"
            + screen_cinema_num + "/"
            + selected_day + "/";

        let hiddenInput = $('#final_list_input');
        if (hiddenInput.length === 0) {
            hiddenInput = $('<input>').attr({
                type: 'hidden',
                id: 'final_list_input',
                name: 'final_list_data'
            });
            form.append(hiddenInput);
        }

        hiddenInput.val(final_list_selected_things);

        // 선택된 final_list의 배경색 변경
        $(".final_list").removeClass("selected");
        $(element).addClass("selected");
    }

    function finalList() {
        // selectedMovie, selectedTheater, selectedDay가 모두 존재하는지 확인
        if (selectedMovie && selectedTheater && selectedDay) {
            $.ajax({
                url: "api/finalList",
                method: "GET",
                data: {
                    selectedMovie: selectedMovie,
                    selectedTheater: selectedTheater,
                    selectedDay: selectedDay
                },
                dataType: "json",
                success: function (response) {
                    var result = $("#finalmovielist");
                    result.empty();

                    if (response.length === 0) {
                        // 결과가 없을 경우 메시지 출력
                        result.append("<div style='height: 300px'><br> <div align='center'>입력 정보에 대한 일정이 없습니다.</div></div>");
                    } else {
                    	
                        response.forEach(function (finalList) {
                            var finalDiv = "<div class='final_list' onclick='final_list_selected(\""
                                + finalList.movie_name
                                + "\", \"" + finalList.scs_start_time
                                + "\", \"" + finalList.scs_end_time
                                + "\", \"" + finalList.theater_name
                                + "\", \"" + finalList.screen_cinema_num
                                + "\", \"" + selectedDay + "\", this)'>"
                                + "<div>" + finalList.movie_name + "</div>"
                                + "<div class='row box1' style='width: 600px'>"
                                + "<div class='col-md-3'>"
                                + "<strong>" + finalList.scs_start_time + "</strong> ~ " + finalList.scs_end_time
                                + "</div>"
                                + "<div class='col-md-5'>"
                                + finalList.screen_dimension + " || 총 " + finalList.total_seat + "석 ||"
                                + finalList.scs_empty_seat + "석 남음"
                                + "</div>"
                                + "<div class='col-md-3'>"
                                + finalList.theater_name + " || " + finalList.screen_cinema_num + " 관"
                                + "</div>"
                                + "</div>"
                                + "</div>";

                            result.append(finalDiv);
                        });

                        // 새롭게 생성된 final_list 항목에 클릭 이벤트 핸들러를 추가합니다.
                        $(".final_list").click(function () {
                            $(".final_list").removeClass("selected");
                            $(this).addClass("selected");
                        });
                    }
                },
                error: function () {
                    alert("영화 정보를 가져오는 데 실패했습니다.");
                }
            });
        } else {
            // 필수 선택 항목이 누락된 경우 경고 메시지를 표시할 수 있습니다.
            console.log("영화, 상영관, 날짜를 모두 선택해주세요.");
        }
    }

    function theaterType(type, sId, element) {
        if (sId == null || sId == "") {
        	if(confirm("로그인이 필요한 서비스입니다. 로그인 하시겠습니까?")){
        		location.href = "member_login";
        	}else{
        		return;
        	}
        }

        // 전체극장 및 MY영화관 선택 시 이전 선택된 항목의 selected 클래스를 제거
        $(".theater-link").removeClass("selected");
        $(element).addClass("selected");

        $.ajax({
            url: "api/theater" + type,
            method: "GET",
            data: {
                sId: sId
            },
            dataType: "json",
            success: function (response) {
                var result = $("#theaterlist");
                result.empty();
                
                if (response.length === 0) {
                    result.append("<div>정보가 없습니다.</div>");
                    return;
                }
                
                if (type === 'EntireTheater') {
                    // 전체 극장 10개만 노출
                    response.slice(0, 10).forEach(function (theater) {
                        var staticHtml = '<ul><li><a class="theater-link" onclick="theaterClick(\'' + theater.theater_name + '\', this)">' + theater.theater_name + '</a></li></ul>';
                        result.append(staticHtml);
                    });
                } else if (type === 'MyTheater') {
                    // My 영화관 처리
                    response.forEach(function (theater) {
                        var theaterDiv = '<ul><li><a class="theater-link" onclick="theaterClick(\'' + theater.member_my_theater + '\', this)">' + theater.member_my_theater + '</a></li></ul>';
                        result.append(theaterDiv);
                    });
                }
            },
            error: function () {
                var result2 = $("#theaterlist");
                var theaterDiv2 = "<div>영화정보 <br>불러오기를 <br>실패했습니다.</div>";
                result2.empty();
                result2.append(theaterDiv2);
            }
        });
    }

    function movieClick(movie_name, movie_num) {
        selectedMovie = movie_name;
        var result1 = $("#movieSelected");
        result1.empty();
        result1.append(movie_name);

        // 선택된 영화의 배경색 변경
        $("#movielist .movie-link").removeClass("selected");
        $("#movie_" + movie_num + " .movie-link").addClass("selected");

        $.ajax({
            type : "POST",
            url : "movieSearch",
            data : {
                "movie_num" : movie_num
            },
            dataType : "json",
            success : function(response) {
                appendMovieCountToTheaters(response); 
            },
            error : function(){
                console.log("error");
            }
        });
        finalList();
    }

    function appendMovieCountToTheaters(data) {
        // 기존 영화 개수 정보를 초기화
        $(".theater-movie-count").remove();

        data.forEach(function(item) {
            var theaterName = item.theater_name;
            var movieCount = item.movie_count;
            var theaterElement = $("a.theater-link:contains('" + theaterName + "')");
            if (theaterElement.length > 0) {
                // 영화 개수를 표시하는 새로운 span 요소를 생성하여 추가
                var movieCountSpan = $("<span class='theater-movie-count'> (" + movieCount + ")</span>");
                theaterElement.parent().append(movieCountSpan);
            }
        });
    }

    function theaterClick(theater_name, element) {
        selectedTheater = theater_name;
        var result = $("#theaterSelected");
        result.empty();
        result.append(theater_name);

        // 선택된 상영관의 배경색 변경
        $("#theaterlist .theater-link").removeClass("selected");
        $(element).addClass("selected");
        finalList();
    }

    function dayClick(date, nowDay, element) {
        if (!selectedMovie || !selectedTheater) {
            alert("영화와 상영관을 선택해주세요.");
            return;
        }

        var baseDate = new Date(date);
        var currentDay = baseDate.getDate();

        // nowDay가 현재 날짜의 일(day) 값보다 낮으면 한 달을 더해줌
        if (nowDay < currentDay) {
            baseDate.setMonth(baseDate.getMonth() + 1);
        }

        baseDate.setDate(nowDay);
        var formattedDate = baseDate.toISOString().split('T')[0];
        selectedDay = formattedDate;
        var result = $("#daySelected");

        // 선택된 날짜의 배경색 변경
        $(".daylist input").removeClass("selected");
        $(element).addClass("selected");

        result.empty();
        result.append(formattedDate);

        finalList();
    }

    function getGradeIcon(grade) {
        var contextPath = "${pageContext.request.contextPath}";
        switch (grade) {
            case "전체관람가":
                return "<img src='" + contextPath + "/resources/images/tic_icon_all.gif' style='width: 48px; height: 48px;'>";
            case "12세관람가":
                return "<img src='" + contextPath + "/resources/images/tic_icon_over12.gif' style='width: 48px; height: 48px;'>";
            case "15세관람가":
                return "<img src='" + contextPath + "/resources/images/tic_icon_over15.gif' style='width: 48px; height: 48px;'>";
            case "18세관람가(청소년관람불가)":
                return "<img src='" + contextPath + "/resources/images/tic_icon_over18.gif' style='width: 48px; height: 48px;'>";
            default:
                return "";
        }
    }

    function loadMovies(orderBy, sId) {
        $.ajax({
            url: "api/movie" + orderBy,
            method: "GET",
            data: {
                sId: sId
            },
            dataType: "json",
            success: function (response) {
                var result = $("#movielist");
                result.empty();
                if (response.length === 0) {
                    result.append("<div>내 취향의 영화가 없습니다.</div>");
                    return;
                }
                response.forEach(function (movie) {
                    var movieDiv = "<div class='movie_atrbt'>"
                        + getGradeIcon(movie.movie_grade)
                        + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                        + "<span id='movie_" + movie.movie_num + "'>"
                        + "<a class='movie-link' onclick='movieClick(\"" + movie.movie_name + "\", \"" + movie.movie_num + "\")'>" + movie.movie_name + "</a>"
                        + "</span>"
                        + "</div>";

                    result.append(movieDiv);
                });

                // 새롭게 생성된 영화 항목에 클릭 이벤트 핸들러를 추가합니다.
                $("#movielist .movie-link").click(function () {
                    $("#movielist .movie-link").removeClass("selected");
                    $(this).addClass("selected");
                });
            },
            error: function () {
                alert("영화 정보를 가져오는 데 실패했습니다.");
            }
        });
    }

    $(document).ready(function () {
        var sId = '<%= session.getAttribute("sId") %>';
		
        // 페이지 로드 시 전체극장이 선택되도록 설정
        $("#entireTheaterLink").addClass("selected");
        theaterType('EntireTheater', 'entire', $("#entireTheaterLink")[0]);
        
        $("#like_movie").change(function () {
            var likeMovie = $(this).is(":checked");
            var orderBy = "LikeMovie";
    		
            if (likeMovie) {
            	debugger;
            	console.log("sId : " + sId);
            	if(sId == null || sId == ""){
            		if(confirm("로그인이 필요한 서비스입니다 로그인하시겠습니까?")){
            			location.href = "member_login";
            		}else{
            			return;
            		}
            	}
                loadMovies(orderBy, sId);
            } else {
                orderBy = "Abc";
                loadMovies(orderBy, sId);
            }
        });	
        
        
        $('#fr').submit(function(event) {
            let hiddenInput = $('#final_list_input');
            if (hiddenInput.length === 0 || hiddenInput.val() === "") {
                alert("선택된 데이터가 없습니다.");
                event.preventDefault(); // 폼 제출 막기
            }
        });
    });
</script>
</body>
</html>