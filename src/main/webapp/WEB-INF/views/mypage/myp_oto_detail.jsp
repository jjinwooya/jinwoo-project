<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin_detail</title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');
	
	* {
	  font-family: "Nanum Gothic", sans-serif;
	  font-weight: 400;
	  font-style: normal;
	}
	.container {
		width:750px;
		height:auto;
		margin: 0 auto;
/* 		border:1px solid #6699FF; */
/* 		border-width: 5px; */
		padding: 10px;
		
	}
	table {
		border-top:1px solid black;
		border-bottom:1px solid black;
		width:80%;
		margin: 0 auto;
		border-collapse: collapse;
		text-align: center;
	}
	table tr td {
		border:1px solid black;
		padding : 10px;
	}
	
	td:nth-child(odd) {
	  font-weight: bold;
	  text-align: left;
	  background-color: skyblue;
	}
	
	td:nth-child(even) {
	  font-weight: bold;
	  text-align: left;
	}
	
	 tr:nth-child(5) td {
	 	text-align: center;
	 	background-color: white;
	 }
	 
	table td:first-child {
		border-left: 0;
	}
	
	table td:last-child {
		border-right: 0;
	}
	 
	
	input[value="목록"] {
		padding:10px;
		background-color: skyblue;	
		font-weight: bold;
		border-radius: 5px;
	}
	.detail_button {
		text-align: center;
		margin-top: 15px;
	}
	
	span {
		color:#6699FF;
	}
	input[value="첨부파일"] {
		background-color: skyblue;
		
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
				<jsp:include page="../inc/myp_aside.jsp"></jsp:include>
			</div>
			<div class="col-10">
				<form action="myp_oto_modifyPro" method="post">
					<table>
						<tr>
							<td>제목</td>
							<td>${oto.oto_subject }</td>
							<td>작성자</td>
							<td>${oto.member_id }</td>
						</tr>
						<tr>
							<td>문의 유형</td>
							<td><span>[${oto.oto_category }]</span></td>
							<td>문의 지점</td>
							<td><span>[${oto.theater_name }]</span></td>
						</tr>
						<tr>
							<td>작성일</td>
							<td>${otoDate}</td>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td>첨부파일</td>
							<td colspan="3">
								<div>
									<c:if test="${not empty oto.oto_file1 }">
										<c:set var="original_fileName1" value="${fn:substringAfter(oto.oto_file1, '_') }"/>
											${original_fileName1 }
										<%-- 다운로드 버튼 활용하여 해당 파일 다운로드(버튼에 하이퍼링크 지정) --%>
										<a href="${pageContext.request.contextPath }/resources/upload/${oto.oto_file1}" download="${original_fileName1 }"><input type="button" value="첨부파일">
										</a><br>
									</c:if>
									<c:if test="${not empty oto.oto_file2 }">
										<c:set var="original_fileName2" value="${fn:substringAfter(oto.oto_file2, '_') }"/>
											${original_fileName2 }
										<%-- 다운로드 버튼 활용하여 해당 파일 다운로드(버튼에 하이퍼링크 지정) --%>
										<a href="${pageContext.request.contextPath }/resources/upload/${oto.oto_file1}" download="${original_fileName2 }"><input type="button" value="첨부파일">
										</a>
									</c:if>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<textarea rows="18" cols="90" style="resize: none" disabled>${oto.oto_content }</textarea>
							</td>
						</tr>
						
					</table>
					<!-- 답변 버튼 -->
					<div class="detail_button">
						<input type="button" value="목록" onclick="location.href='myp_oto_breakdown'">
					</div>
				</form>
			</div>
		</div>
	</div>
<footer>
	<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
</footer>
</body>
</html>