<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MY-page</title>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');
	
	* {
	  font-family: "Nanum Gothic", sans-serif;
	  font-weight: 400;
	  font-style: normal;
	}
	.container {
		width:850px;
		height:auto;
		margin: 0 auto;
/* 		border:1px solid #6699FF; */
/* 		border-width: 5px; */
		padding: 10px;
		
	}
	table {
		border-top:1px solid black;
		border-bottom:1px solid black;
		width:800px;
		margin: 0 auto;
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
	 
	
	input[value="수정완료"] {
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
<script>
	function deleteFile(oto_num, fileName, index) { //글번호, 업로드 파일명, 순서번호
		if(confirm(index + "번 파일을 삭제하시겠습니까?")) {
			// 파일삭제 작업을 AJAX로 요청 및 처리 - POST
			$.ajax({
				type: "POST",
				url: "otoDeleteFile",
				data: {
					"oto_num": oto_num,
					"oto_file1": fileName
				},
				dataType: "json",
				success: function(result) {
					
					//삭제 성공/실패 여부 판별
					if(result) {
						//<input type="file" name="file${status.count }">
						// -----------------------------------------------
						//1. class 선택자 "file"에 해당하는 div 태그들 중 index-1 번 요소 탐색
// 						console.log($(.file).eq(index - 1).html());
						//2. id선택자 "fileItemAreaX" 에 해당하는 div 태그 탐색
// 						console.log($("$fileItemArea" + index).html());
						//--------------------------------------------
						// 1번 방법 활용하여 duv 태그 내에 파일 업로드 폼 표시
						$(".file").eq(index - 1).html('<input type="file" name="file' + index + '">');
					} else {
						alert("파일 삭제 실패!")
					}
					
				},
				error: function() {
					alert("응답 실패")
				}
			});
		}
	}
</script>
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
				<form action="myp_oto_modifyPro" method="post" enctype="multipart/form-data">
					<input type="hidden" name="oto_num" value="${oto.oto_num} ">
					<input type="hidden" name="pageNum" value="${param.pageNum} ">
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
								<c:forEach var="fileName" items="${fileNames }" varStatus="status">
									<div class="file">
										<c:choose>
											<c:when test="${not empty fileName}">
												<c:set var="original_fileName" value="${fn:substringAfter(fileName, '_') }" />
												${original_fileName }
												<a href="${pageContext.request.contextPath }/resources/upload/${fileName}" download="${original_fileName}">
													<input type="button" value="첨부파일"></a>
												<a href="javascript: deleteFile(${oto.oto_num}, '${fileName}', ${status.count})" title="파일 삭제">
													<img alt="delete" src="${pageContext.request.contextPath }/resources/images/xIcon.png">
												</a>
											</c:when>
											<c:otherwise>
												<!-- fileName이 empty 일때 -->
												<input type="file" name="file${status.count }">
											</c:otherwise>
										</c:choose>							
									</div>
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td colspan="4">
								<textarea rows="20" cols="100" style="resize: none" name="oto_content">${oto.oto_content }</textarea>
							</td>
						</tr>
						
					</table>
					<!-- 답변 버튼 -->
					<div class="detail_button">
						<input type="submit" value="수정완료">
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