<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의내역 답변작성</title>
<style>
	.container {
		width:850px;
		height:auto;
		margin: 0 auto;
		border-width: 5px;
		padding: 10px;
		
	}
	
	table {
		border-top:1px solid black;
		border-bottom:1px solid black;
		width:800px;
		margin: 50px auto;
		border-collapse: collapse;
		text-align: center;
	}
	table tr td {
		border:1px solid black;
		padding : 15px;
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
	 
	input {
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
	
</style>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
</header>
	<div class="container">
		<div>
			<form action="admin_oto_detail" method="post" onsubmit="return confirm('답변을 등록하시겠습니까?');">
			<input type="hidden" value="${oto.oto_num }" name="oto_num">
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
						<td><span>[${oto.theater_name}]</span></td>
					</tr>
					<tr>
						<td>작성일</td>
						<td>${otoDate }</td>
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
									<a href="${pageContext.request.contextPath }/resources/upload/${oto.oto_file1}" download="${original_fileName1 }"><input type="button" value="첨부파일1">
									</a><br>
								</c:if>
								<c:if test="${not empty oto.oto_file2 }">
									<c:set var="original_fileName2" value="${fn:substringAfter(oto.oto_file2, '_') }"/>
										${original_fileName2 }
									<%-- 다운로드 버튼 활용하여 해당 파일 다운로드(버튼에 하이퍼링크 지정) --%>
									<a href="${pageContext.request.contextPath }/resources/upload/${oto.oto_file1}" download="${original_fileName2 }"><input type="button" value="첨부파일2">
									</a>
								</c:if>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<textarea name="oto_content" rows="15" cols="100" style="resize: none" readonly >${oto.oto_content }</textarea>
						</td>
					</tr>
				</table>
				<div align="center">
					<h2>답변 쓰기</h2>
					<textarea name="oto_reply_content" rows="15" cols="100" style="resize: none"></textarea>
				</div>
				<!-- 답변 버튼 -->
				<div class="detail_button">
					<input type="submit" value="답변하기">
					<input type="reset" value="다시쓰기">
					<input type="button" value="돌아가기" onclick="history.back()">
				</div>
			</form>
		</div>
	</div>
<footer>
	<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
</footer>
</body>
</html>