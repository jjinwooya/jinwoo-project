<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 쿠폰</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myp_default.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
.text{text-align : center;}
</style>
</head>
<body>
<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>



<div class="container1">
	<div class="container2">
		<div class="row">
			<div class="col-md-2">
				<jsp:include page="../inc/myp_aside.jsp"></jsp:include>
			</div>
			<div class="col-md-9">
				<h2>쿠폰</h2>
				<hr>
				<!-- 탭 메뉴 -->
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="userinfo-tab" data-bs-toggle="tab"
							data-bs-target="#userinfo" type="button" role="tab" aria-controls="userinfo"
							aria-selected="true">쿠폰함</button>
					</li>
				</ul>
				<!-- 내용 -->
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="userinfo" role="tabpanel"aria-labelledby="userinfo-tab">
						<table class="table table-hover" >
						  <thead>
						    <tr>
						      <th scope="col"><b>#</b></th>
						      <th scope="col"><b>번호</b></th>
						      <th scope="col"><b>쿠폰 이름</b></th>
						      <th scope="col"><b>할인율</b></th>
						    </tr>
						  </thead>
						  <tbody>
							<c:choose>
								<c:when test="${not empty list}">
									<c:forEach var="coupon" items="${list}" varStatus="status">
							   			<tr class="${status.index % 2 == 0 ? 'table-secondary' : ''}">
							        	<th scope="row">${status.index + 1}</th>
							        	<td>${coupon.coupon_num}</td>
								        <td>${coupon.coupon_name}</td>
								        <td>${coupon.coupon_value}원</td>
							    		</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td colspan="4" class="text">보유중인 쿠폰이 존재하지 않습니다.</td>
								</c:otherwise>
							</c:choose>
						  </tbody>
						</table>
					</div><!-- tab-pane -->
				</div><!-- tab-content -->
			</div><!-- col-md-10 box1 -->
		</div> <!-- row -->
	</div> <!-- container2 -->
</div> <!-- contanier1 -->
<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js">

</body>
</html>