<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록폼</title>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<!-- 썸머노트 cdn -->
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
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
<link href="${pageContext.request.contextPath}/resources/css/admin_form.css" rel="stylesheet" type="text/css">
<style>
	/* Summernote 라인 높이 조정 */
	.note-editable {
	    line-height: 0.5; /* 원하는 라인 높이로 설정 */
	}
</style>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">공지사항등록</h4>
				<form class="validation-form" novalidate action="admin_notice_pro" method="post" onsubmit="return confirm('공지를 등록하시겠습니까?');">
					<input type="hidden" name="theater_name" id="hidden-disabled-select">
					<input type="hidden" value="${param.pageNum }" name="pageNum">
					<div class="mb-3">
						<label for="movie_name">글제목</label> 
						<input type="text"  id="notice_name" class="form-control" required name="notice_subject" required />
						<div class="invalid-feedback">글제목을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<select name="notice_category" id="notice_category">
							<option value="전체" >전체</option>
							<option value="극장" >극장</option>
						</select>
						<select name="theater_name" id="theater_name_select">
							<option value="none">없음</option>
							<option value="해운대점">해운대점</option>
							<option value="센텀점">센텀점</option>
							<option value="서면점">서면점</option>
							<option value="남포점">남포점</option>
							<option value="부산대점">부산대점</option>
							<option value="사직점">사직점</option>
							<option value="영도점">영도점</option>
							<option value="덕천점">덕천점</option>
							<option value="정관점">정관점</option>
							<option value="사상점">사상점</option>
						</select>
						
					</div>
					<div class="mb-3">
						<label for="movie_story">내용</label> 
						<textarea id="summernote" class="form-control" rows="10" cols="100" required name="notice_content"></textarea>
						<div class="invalid-feedback">내용을 입력해주세요.</div>
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

$(function () {
	
	if ($("#notice_category").val() == "전체") {
        $("#theater_name_select").prop("disabled", true);
        $("#notice_name").val("[부기무비]");
    } else {
        $("#theater_name_select").prop("disabled", false);
    }
	
	$("#notice_category").change(function() {
		if ($(this).val() == "전체") {
		    $("#theater_name_select").val("none");
		    $("#notice_name").val("[부기무비]");
		    $("#theater_name_select").prop("disabled", true);
		} else if ($(this).val() == "극장") {
			
		    $("#theater_name_select").val("해운대점");
		    $("#notice_name").val("[해운대점]");
		    $("#theater_name_select").prop("disabled", false);
		    $("#theater_name_select option:eq(0)").prop("disabled", true);
		}
	});
	$("#theater_name_select").change(function () {
		let theaterName = $("#theater_name_select").val();
		$("#notice_name").val("[" + theaterName + "]");
		
	});
	
	
});
</script>
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
</script>
<script>
	$('#summernote').summernote({
	  placeholder: '공지를 입력하세요.',
	  tabsize: 1,
	  height: 800,
	  toolbar: [
	    ['style', ['style']],
	    ['font', ['bold', 'underline', 'clear']],
	    ['color', ['color']],
	    ['para', ['ul', 'ol', 'paragraph']],
	    ['table', ['table']],
	    ['insert', ['link', 'picture', 'video']],
	    ['view', ['fullscreen', 'codeview', 'help']],
	    ['height', ['height']]
	  ]
	});
</script>
<script>
	function copyDisabledSelectValue() {
		var disabledSelect = document.getElementById("theater_name_select");
		var hiddenInput = document.getElementById("hidden-disabled-select");
		hiddenInput.value = disabledSelect.value;
	}
</script>

</body>
</html>