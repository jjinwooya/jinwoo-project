<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 스토어 결제내역</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myp_reservation.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
hr{
	margin-top: 10px;
}
.breakdown_pageArea {
	margin-top: 20px;
	text-align: center;
}

.breakdown_pageArea > nav {
	display: inline-block;
}

</style>

<script type="text/javascript">
	function cancelStore(store_pay_num) {
		console.log(store_pay_num);
		if(confirm("정말 취소하시겠습니까?")){
			$.ajax({
				url : "myp_cancel_store",
				type : "post",
				dataType : "json",
				data : {
					"store_pay_num" : store_pay_num
				},
				success : function(result) {
					if(result){
						alert("취소가 완료되었습니다");
						location.reload();	
					}
				},
				error : function() {
					
				}
				
			});
		}

	}

</script>


</head>
<body>

<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>
<div class="container1">
	<div class="container2">
		<c:set var="pageNum" value="${empty param.pageNum ? 1 : param.pageNum}" />
		<div class="row">
			<div class="col-md-2 box1">
				<jsp:include page="../inc/myp_aside.jsp"></jsp:include>
			</div><!-- sidebar1 -->
				<!-- 탭 메뉴 -->
				<!-- 내용 -->
			<div class="col-md-9 box-in">
				<div class="row">
					<div class="col-10">
						<h2>스토어</h2>
					</div> <!-- col-10 -->
					<hr>
				</div><!--  하위 row -->
				<div class="box2">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="storePay-tab" data-bs-toggle="tab"
								data-bs-target="#storePay" type="button" role="tab" aria-controls="storePay"
								aria-selected="true">결제내역</button>
								
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="storeCancel-tab" data-bs-toggle="tab"
								data-bs-target="#storeCancel" type="button" role="tab" aria-controls="storeCancel"
								aria-selected="false">취소내역</button>
						</li>
					</ul>
				</div><!-- box2 -->
				
				<div class="tab-content" id="myTabContent">
					<!-- 결제 탭 -->
					<div class="tab-pane fade show active" id="storePay" role="tabpanel"aria-labelledby="storePay-tab">
						<table class="table table-hover" >
							<thead>
							    <tr>
								    <th scope="col"><b>#</b></th>
								    <th scope="col"><b>구매일</b></th>
								    <th scope="col"><b>구매내역</b></th>
								    <th scope="col"><b>결제금액</b></th>
								    <th scope="col"><b>결제수단</b></th>
								    <th scope="col"><b>취소</b></th>
						    	</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${not empty storePay}">
										<c:forEach var="storePay" items="${storePay}" varStatus="status">
										    <c:if test="${storePay.store_pay_status == '결제'}">
										        <tr class="${status.index % 2 == 0 ? 'table-secondary' : ''}">
										            <th scope="row">${status.index + 1}</th>
										            <td>
										                <fmt:parseDate value="${storePay.store_pay_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" />
										                <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm" />
										            </td>
										            <td>${storePay.store_pay_detail}</td>
										            <td>
										                <fmt:formatNumber value="${storePay.store_pay_price}" type="number" groupingUsed="true" />원
										            </td>
										            <td>${storePay.store_pay_type}</td>
										            <td><input type="button" class="btn btn-outline-secondary" id="cancelStore" onclick="cancelStore(${storePay.store_pay_num})" value="취소"></input></td>
										        </tr>
										    </c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<td colspan="6" class="box3">스토어 결제내역이 존재하지 않습니다.</td>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
					<!-- 결제 탭 -->
				<!-- 취소 탭 -->
				<div class="tab-pane fade" id="storeCancel" role="tabpanel"aria-labelledby="storeCancel-tab">
					<table class="table table-hover" >
						<thead>
						    <tr>
								<th scope="col"><b>#</b></th>
							    <th scope="col"><b>취소일</b></th>
							    <th scope="col"><b>취소내역</b></th>
							    <th scope="col"><b>결제취소 금액</b></th>
							    <th scope="col"><b>결제취소 수단</b></th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${not empty storePay}">
									<c:forEach var="storePay" items="${storePay}" varStatus="status">
									    <c:if test="${storePay.store_pay_status == '취소'}">
									        <tr class="${status.index % 2 == 0 ? 'table-secondary' : ''}">
									            <th scope="row">${status.index + 1}</th>
									            <td>
									                <fmt:parseDate value="${storePay.store_pay_cancel_date}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate2" />
									                <fmt:formatDate value="${parsedDate2}" pattern="yyyy-MM-dd HH:mm" />
									            </td>
									            <td>${storePay.store_pay_detail}</td>
									            <td>
									                <fmt:formatNumber value="${storePay.store_pay_price}" type="number" groupingUsed="true" />원
									            </td>
									            <td>${storePay.store_pay_type}</td>
									        </tr>
									    </c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td colspan="5" class="box3">스토어 취소내역이 존재하지 않습니다.</td>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div><!-- tab-pane fade 탭2 끝-->
				<!-- 취소탭 -->
				</div><!-- tab-content 탭1 끝 -->
			</div><!-- col-md-9 box-in -->
		</div> <!-- row -->
	</div><!-- container2 -->
</div><!-- container -->
<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js">

</body>
</html>