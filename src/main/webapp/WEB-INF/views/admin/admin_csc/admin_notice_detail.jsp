<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비</title>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/csc_sidebar.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/csc_notice_detail.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous">
</script>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
	<style type="text/css">
	span {
		color:skyblue;
	}
	#prevLink, #nextLink {
		text-decoration: none;
		color:black;
	}
	</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
</header>
<div class="container">
	<div class="row">
		<div class="col-2">
<%-- 			<jsp:include page="/WEB-INF/views/csc/csc_sidebar.jsp"></jsp:include> --%>
		</div>
		<div class="col-10">
			<h3>공지사항</h3>
			<hr>
			<div>
				<p><span>[부기무비]</span> ${notice.notice_subject} </p>
				<p><span>문의 지점</span> | <c:if test="${not empty notice.theater_name }">${notice.theater_name }</c:if> &nbsp;&nbsp;&nbsp; <span>작성일</span> | ${notice.notice_fdt }
			</div>
			<hr>
			<div>
				${notice.notice_content }			
			</div>
			<hr>
			<!-- 이전, 다음 페이징 -->
			<div>
				<span class="csc_paging"><a id="prevLink" href="admin_notice_detail?notice_num=${notice.prev }" >&laquo;이전</a></span>
				<span class="csc_paging"><a id="nextLink" href="admin_notice_detail?notice_num=${notice.next }" >다음&raquo;</a></span>
			</div>	
			<!-- 목록 버튼 -->
			<div class="csc_detail_button">
				<input type="button" value="목록" onclick="location.href='admin_notice'">
			</div>
		</div>
	</div>

</div>
<footer>
	<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
</footer>
<script>
    let noticeNum = ${notice.notice_num};
    let maxNoticeNum = ${maxNotice}; // maxNoticeNum은 마지막 notice_num 값
    let minNoticeNum = ${minNotice}; // maxNoticeNum은 마지막 notice_num 값
    

    let prevLink = $("#prevLink");
    let nextLink = $("#nextLink");
	
    //처음 게시물 또는 마지막 게시물일 때 a태그 비활성화
    if (noticeNum === minNoticeNum) {
    	prevLink.removeAttr("href");
    	prevLink.css("pointer-events", "none"); 
    	prevLink.css("color", "gray"); 
    }

    if (noticeNum === maxNoticeNum) {
        nextLink.removeAttr("href");
        nextLink.css("pointer-events", "none");
        nextLink.css("color", "gray");
    }
</script>
</body>
</html>