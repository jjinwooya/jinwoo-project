<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스낵 등록폼</title>
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
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
</style>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">스낵정보수정</h4>
				<form class="validation-form" novalidate action="admin_store_modifyPro" method="post" onsubmit="return confirm('스낵정보를 등록하시겠습니까?');">
					<div class="mb-3">
						<label for="movie_createDate">기존 스토어 상품 종류</label> 
							<input type="text" value="${updateItem.item_info_category}">
							<label for="movie_createDate">변경할 스토어상품 종류</label> 
							<select id="item_info_category" name="item_info_category">
								<option value="스낵">스낵</option>
								<option value="음료">음료</option>
								<option value="팝콘">팝콘</option>
								<option value="콤보">콤보</option>
							</select>
						<div class="invalid-feedback">스낵종류를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_name">스낵명</label> 
						<input type="text" id="item_info_name" name="item_info_name"  value="${updateItem.item_info_name}"class="form-control" required />
						<div class="invalid-feedback">스낵명을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_director">판매가격</label> 
						<input type="text" id="item_info_price" name="item_info_price"  value="${updateItem.item_info_price}" class="form-control" required />
						<div class="invalid-feedback">판매가격을 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="movie_stillCut1">스낵이미지</label> 
						<input type="text" id="item_info_image" name="item_info_image" value="${updateItem.item_info_image}" class="form-control" required />
						<div class="invalid-feedback">스낵이미지를 선택해주세요.</div>
					</div>
					<div class="mb-4" align="center">
						<input type="submit" value="수정하기" class="btn btn-primary btn-lg btn-block" >
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
 	</script>
</body>
</html>