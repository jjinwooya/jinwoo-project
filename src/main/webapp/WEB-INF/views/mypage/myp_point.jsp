<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 포인트</title>
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
.container1{
	height : auto;
	width: 1400px; /* 해상도 1200*/
	margin : auto;
}

.container2{
	margin-top: 20px;
	height : auto;
}

.box1{
	height: auto;
	
}

.text{text-align : center;}

h6{
	text-align : right;
	padding-top : 20px;
}
</style>
</head>
<body>

<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>
<div class="container1">
	<div class="container2">
		<div class="row box1">
			<div class="col-md-2">
				<jsp:include page="../inc/myp_aside.jsp"></jsp:include>
			</div>	<!-- col-md-2 사이드바  -->
			<div class="col-md-9">
				<div class="row">
				<div class="col-9">
					<h2>포인트</h2>
				</div>
				<div class="col-3">
					<h6><b>보유중인 포인트 : ${member.member_point}</b></h6>
				</div>
				</div>
				<hr>
				<!-- 탭 메뉴 -->
				<div class="row">
					<div class="col-12">
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="userinfo-tab" data-bs-toggle="tab"
								data-bs-target="#userinfo" type="button" role="tab" aria-controls="userinfo"
								aria-selected="true">적립내역</button>
						</li>
						<li class="nav-item" role="presentation">
							<button class="nav-link" id="myreview-tab" data-bs-toggle="tab"
								data-bs-target="#myreview" type="button" role="tab"
								aria-controls="myreview" aria-selected="false">사용내역</button>
						</li>
					</ul>
					</div>
				</div>
					<!-- 내용 -->
					<!-- ----------------------------- -->
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="userinfo" role="tabpanel"aria-labelledby="userinfo-tab">
						<table class="table2 table table-hover" >
						  <thead>
						    <tr>
						      <th scope="col"><b>#</b></th>
						      <th scope="col"><b>구매 구분</b></th>
						      <th scope="col"><b>구매 극장</b></th>
						      <th scope="col"><b>적립일</b></th>
						      <th scope="col"><b>적립 포인트</b></th>
						    </tr>
						  </thead>
						  <tbody>
							  <c:choose>
							  	<c:when test="${not empty combinedList }">
<%-- 							  		<td colspan="5" class="text1"><b>보유중인 포인트 : ${member.member_point}</b></td> --%>
								  	<c:forEach items="${combinedList}" var="item" varStatus="status">
									<fmt:parseDate var="parsedDate" value="${item.date}" 
									pattern="yyyy-MM-dd'T'HH:mm:ss" type="both"/>
									
									    <tr class="${status.index % 2 == 0 ? 'table-secondary' : ''}">
									        <th scope="row">${status.index + 1}</th>
								  			 <td>
		 						  			 	<c:choose>
								  			 		<c:when test="${item.theater eq '스토어' }">
								  			 			스토어
								  			 		</c:when>
								  			 		<c:otherwise>
								  			 			예매
								  			 		</c:otherwise>
								  			 	</c:choose>
								  			 </td>
								  			 <td>
								  			 	<c:choose>
								  			 		<c:when test="${item.theater eq '스토어' }">
								  			 			스토어
								  			 		</c:when>
								  			 		<c:otherwise>
								  			 			${item.theater}
								  			 		</c:otherwise>
								  			 	</c:choose>
								  			 </td>
								  			 <td>
												<fmt:formatDate value="${parsedDate }" pattern="yyyy-MM-dd HH:mm"/>
								  			 </td>
								  			 <td>
								  			 	${item.points }
								  			 </td>
								  		</tr>
								  	</c:forEach>
<%-- 							  		<td colspan="5" class="text1">보유중인 포인트 : ${member.member_point}</td> --%>
						  		</c:when>
							  	<c:otherwise>
							  		<td colspan="5" class="text">적립한 포인트가 존재하지 않습니다.</td>
							  	</c:otherwise>
							  </c:choose>
						  </tbody>
						</table>
						</div><!-- tab-pane -->
						<div class="tab-pane fade" id="myreview" role="tabpanel"aria-labelledby="myreview-tab">
							<table class="table2 table table-hover" >
							  <thead>
							    <tr>
							      <th scope="col"><b>#</b></th>
							      <th scope="col"><b>구매 구분</b></th>
							      <th scope="col"><b>사용 극장</b></th>
							      <th scope="col"><b>사용일</b></th>
							      <th scope="col"><b>사용 포인트</b></th>
							    </tr>
							  </thead>
							  <tbody>
							  
							  
								<c:forEach items="${combinedList }" var="item" varStatus="status">
								    <c:if test="${item.usePoints != 0}">
								        <fmt:parseDate var="parsedDate" value="${item.date}" pattern="yyyy-MM-dd'T'HH:mm:ss" type="both"/>
								        
								    <tr class="${status.index % 2 == 0 ? 'table-secondary' : ''}">
								        <th scope="row">${status.index + 1}</th>
								            <td>
								                <c:choose>
								                    <c:when test="${item.theater eq '스토어' }">
								                        스토어
								                    </c:when>
								                    <c:otherwise>
								                        예매
								                    </c:otherwise>
								                </c:choose>
								            </td>
								            <td>
								                <c:choose>
								                    <c:when test="${item.theater eq '스토어' }">
								                        스토어
								                    </c:when>
								                    <c:otherwise>
								                        ${item.theater}
								                    </c:otherwise>
								                </c:choose>
								            </td>
								            <td>
								                <fmt:formatDate value="${parsedDate }" pattern="yyyy-MM-dd HH:mm"/>
								            </td>
								            <td>
								                -${item.usePoints }
								            </td> 
								        </tr>
								    </c:if>
								</c:forEach>
							</table>
						</div><!-- tab-pane  -->
					</div><!-- tab-content -->
					<!-- ----------------------------- -->
					
			</div><!-- col-md-10 -->
		</div><!-- row 첫줄-->
		
		
			<div class="row ">
				<div class="col-md-2"> </div>
					<!-- 탭 메뉴 -->
				<div class="col-md-9">
				<hr>
					<ul class="nav nav-tabs" id="myTab" role="tablist">
						<li class="nav-item" role="presentation">
							<button class="nav-link active" id="userinfo-tab" data-bs-toggle="tab"
								data-bs-target="#userinfo" type="button" role="tab" aria-controls="userinfo"
								aria-selected="true">적립안내</button>
						</li>
					</ul>
					<!-- 내용 -->
					<div class="tab-content" id="myTabContent">
						<div class="tab-pane fade show active" id="userinfo" role="tabpanel"aria-labelledby="userinfo-tab">
							<textarea class="textarea1" rows="13" cols="110" style="width: 100%" readonly>
					
							
				영화 예매 시
				온라인(모바일, 홈페이지)을 통한 티켓 구매 시 유료영화관람금액(실 결제 금액)에 영화 예매 시점에
				해당하는 포인트를 적립할 수 있습니다.
				포인트 적립은 유료 구매 시에만 가능하며, 상영일 익일에 적립 및 내역 확인 가능합니다.
				
				매점 이용 시
				매점 상품 구매 시 유료결제금액의 0.5%에 해당하는 포인트를 적립할 수 있습니다.
						</textarea>
					</div><!-- tab-pane -->
					</div><!-- tab-content -->
				</div><!-- col-md-10 -->
			</div><!-- row 두번째 줄 -->
			
			
	</div><!-- container2 -->
</div><!-- container1 -->
<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js">

</body>
</html>