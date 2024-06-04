<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 CSS, JS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<!-- 극장 theater.css  -->
<link href="${pageContext.request.contextPath}/resources/css/theater.css" rel="stylesheet" type="text/css">
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script type="text/javascript">
	$(function() {
		// 서버에서 전달된 feeMap 객체를 JSON.parse를 통해 자바스크립트 객체로 변환
		let feeMap = JSON.parse('${feeMap}');
		
		for (let keyword in feeMap) {
            if (feeMap.hasOwnProperty(keyword)) {
                let price = feeMap[keyword];
                let formattedPrice = price.toLocaleString();
                $("#" + keyword).html(formattedPrice + "원");
            }
        }
	});
</script>
</head>
<body>
	<div class="theater_price_all">
		<h4 class="text-primary">관람료</h4>
			<div class="row gx-5">
		    	<div class="col">
		    		<ul><li class="2D">2D</li></ul>
		      		<table class="table table-bordered">
				 		<thead>
					    	<tr class="table-secondary">
						    	<th scope="col">요일</th>
						    	<th scope="col">상영시간</th>
						    	<th scope="col">일반</th>
						    	<th scope="col">청소년</th>
						    	<th scope="col">우대/경로</th>
					    	</tr>
				  		</thead>
						<tbody>
					    <tr>
					      <th scope="row" rowspan="3" class="WD">월~금</th>
					      <td class="MT">조조</td>
					      <td id="2DWDMTNP" class="NP"></td>
					      <td id="2DWDMTYP" class="YP"></td>
					      <td id="2DWDMTOP" class="OP"></td>
					    </tr>
					    <tr>
					    	<td class="GT">일반</td>
					    	<td id="2DWDGTNP" class="NP"></td>
					    	<td id="2DWDGTYP" class="YP"></td>
					    	<td id="2DWDGTOP" class="OP"></td>
					    </tr>
					    <tr>
					    	<td class="NT">심야</td>
					    	<td id="2DWDNTNP" class="NP"></td>
					    	<td id="2DWDNTYP" class="YP"></td>
					    	<td id="2DWDNTOP" class="OP"></td>
					    </tr>
					    <tr>
					 		<th scope="row" rowspan="3" class="HD">토~일<br>공휴일</th>
					     	<td class="MT">조조</td>
					      	<td id="2DHDMTNP" class="NP"></td>
					      	<td id="2DHDMTYP" class="YP"></td>
					      	<td id="2DHDMTOP" class="OP"></td>
					    </tr>
					    <tr>
					    	<td class="GT">일반</td>
					      	<td id="2DHDGTNP" class="NP"></td>
					      	<td id="2DHDGTYP" class="YP"></td>
					      	<td id="2DHDGTOP" class="OP"></td>
					    </tr>
					      <tr>
					    	<td class="NT">심야</td>
					    	<td id="2DHDNTNP" class="NP"></td>
					    	<td id="2DHDNTYP" class="YP"></td>
					    	<td id="2DHDNTOP" class="OP"></td>
					    </tr>
					  </tbody>
				</table>
		    </div>
		    <div class="col">
				<ul><li class="3D">3D</li></ul>
				<table class="table table-bordered">
					<thead>
						<tr class="table-secondary">
							<th scope="col">요일</th>
							<th scope="col">상영시간</th>
							<th scope="col">일반</th>
							<th scope="col">청소년</th>
							<th scope="col">우대/경로</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row" rowspan="3" class="WD">월~금</th>
							<td class="MT">조조</td>
							<td id="3DWDMTNP" class="NP"></td>
							<td id="3DWDMTYP" class="YP"></td>
							<td id="3DWDMTOP" class="OP"></td>
						</tr>
					    <tr>
					    	<td class="GT">일반</td>
					    	<td id="3DWDGTNP" class="NP"></td>
					    	<td id="3DWDGTYP" class="YP"></td>
					    	<td id="3DWDGTOP" class="OP"></td>
					    </tr>
					      <tr>
					    	<td class="NT">심야</td>
					    	<td id="3DWDNTNP" class="NP"></td>
					    	<td id="3DWDNTYP" class="YP"></td>
					    	<td id="3DWDNTOP" class="OP"></td>
					    </tr>
					    <tr>
					 		<th scope="row" rowspan="3" class="WD">토~일<br>공휴일</th>
					     	<td class="MT">조조</td>
					      	<td id="3DHDMTNP" class="NP"></td>
					      	<td id="3DHDMTYP" class="YP"></td>
					      	<td id="3DHDMTOP" class="OP"></td>
					    </tr>
					    <tr>
					    	<td class="GT">일반</td>
					      	<td id="3DHDGTNP" class="NP"></td>
					      	<td id="3DHDGTYP" class="YP"></td>
					      	<td id="3DHDGTOP" class="OP"></td>
					    </tr>
					     <tr>
					    	<td class="NT">심야</td>
					    	<td id="3DHDNTNP" class="NP"></td>
					    	<td id="3DHDNTYP" class="YP"></td>
					    	<td id="3DHDNTOP" class="OP"></td>
					    </tr>
					</tbody>
				</table>
			</div><!-- col -->
		</div><!--row-->
		<p><b>조조</b> 10:00 이전까지 / <b>심야</b> : 23:00 이후부터</p>
		<br>
		<h4 class="text-primary">요금제</h4>
		<ul>
			<li>경로 만65세 이상 본인에 한함(신분증 확인)</li>
			<li>청소년 요금 만4세~ 만18세 : 미취학 아동~고등학생(학생증, 교복, 청소년증, 의료보험증, 주민등록 등/초본, 그 외 청소년 확인 가능 서류)</li>
			<li>48개월 미만의 경우 증빙원(예 : 의료보험증, 주민등록 초/등본 등) 지참 시에만 무료 관람 가능</li>
		</ul>
		<br>
		<h4 class="text-primary">우대적용</h4>
		<ul>
			<li>부산 지역 주민 본인만 가능(신분증 확인)</li>
			<li>국가유공자 현장에서 국가유공자증을 소지한 본인만 가능</li>
			<li>장애인 현장에서 복지카드를 소지한 장애인(1급~3급까지 동반 1인까지 적용 / 4급~6급은 본인에 한함)</li>
			<li>미취학아동 부모 동반한 만4세~ 만6세까지 본인(의료보험증, 주민등록 초/등본 확인)</li>
			<li>소방종사자 공무원증을 소지하거나 정복을 입은 소방관 본인</li>
		</ul>
	</div><!-- theater_info -->
	
	
</body>
</html>