<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>부기무비 1:1 문의</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/csc_oto.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/csc_sidebar.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- 제이쿼리 -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
<header>
	<jsp:include page="/WEB-INF/views/inc/admin_header.jsp"></jsp:include>
</header>
<div class="container">
	<div class="row">
		<!--사이드바 영역  -->
		<div class="col-3">
			<jsp:include page="csc_sidebar.jsp"></jsp:include>				
		</div>
		<!-- content 영역 -->
		<div class="col-9">
			<form action="csc_oto" id="csc_oto_form" method="post" enctype="multipart/form-data">
				<div id="csc_mainTitle">
					<h1 class="csc-title">1 대 1 문의</h1>
				</div>
				<hr>
				<div class="csc_explain w-75">
					<p><small>고객님의 문의에 답변하는 직원은 고객 여러분의 가족 중 한 사람일 수 있습니다.<br>
					고객의 언어폭력(비하, 욕설, 반말, 성희롱 등)으로부터 직원을 보호하기 위해<br>
					관련 법에 따라 수사기관에 필요한 조치를 요구할 수 있으며, 형법에 의해 처벌 대상이 될 수 있습니다.<br>
					FAQ를 이용하시면 궁금증을 더 빠르게 해결하실 수 있습니다.
					1:1 문의글 답변 운영시간 10:00 ~ 19:00
					접수 후 48시간 안에 답변 드리겠습니다</small></p>
				</div>
				<hr>
				<div id="csc_agree">
					<div class="csc_check_scope">
						<input type="checkbox" id="csc_checkbox" name="check_box" >
						<label for="csc_checkbox">개인정보 수집에 대한 동의</label>
					</div>
					<hr>
					<p>귀하께서 문의하신 다음의 내역은 법률에 의거 개인정보 수집·이용에 대한 본인동의가 필요한 항목입니다.<br>
					<br>
					<b>[개인정보의 수집 및 이용목적]</b><br>
					회사는 1:1 문의 내역의 확인, 요청사항 처리 또는 완료 시 원활한 의사소통 경로 확보를 위해 수집하고 있습니다.<br>
					<br>
					<b>[필수 수집하는 개인정보의 항목]</b><br>
					아이디, 문의내용<br>
					<br>
					<b>[개인정보의 보유기간 및 이용기간]</b><br>
					문의 접수 ~ 처리 완료 후 3년<br>
					(단, 관계법령의 규정에 의하여 보존 할 필요성이 있는 경우에는 관계 법령에 따라 보존)<br>
					자세한 내용은 '개인정보 처리방침'을 확인하시기 바랍니다.</p>
				</div>
				<span>원활한 서비스 이용을 위한 최소한의 개인정보이므로 동의하지 않을 경우 서비스를 이용하실 수 없습니다</span>
				<!-- 폼 영역 -->
				<hr>
				<div class="row">
					<div class="inquiry_warning">* 필수!</div>
					<div class="row mb-3">
					<label for="client_name" class="col-2 col-form-label">고객 ID</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm w-25" id="client_name" readonly name="member_id" value="${sId }">
					</div>
					</div>
					<div class="row mb-2">
						<label for="inquiry_type" class="col-sm-2 col-form-label inquiry_warning_star">문의유형</label>
						<div class="col-sm-10">
							<select name="oto_category" class="form-select form-select-sm w-25" id="oto_category" >
								<option selected value="">문의 유형 선택</option>
								<option value="예매/결제">예매/결제</option>
								<option value="영화관이용">영화관이용</option>
								<option value="쿠폰">쿠폰</option>
								<option value="스토어">스토어</option>
								<option value="홈페이지/모바일">홈페이지/모바일</option>
							</select>					
						</div>
					</div>
					<div class="row mb-2">
						<label for="inquiry_type" class="col-sm-2 col-form-label inquiry_warning_star">문의지점</label>
						<div class="col-sm-10">
							<select name="theater_name" id="theater_name" class="form-select form-select-sm w-25" >
								<option selected value="">문의 지점 선택</option>
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
					</div>
					<!-- 제목 -->
					<div class="row mb-2">
						<label for="client_subject" class="col-2 col-form-label inquiry_warning_star" >제목</label>
						<div class="col-sm-10">
							<input type="text" name="oto_subject" class="form-control form-control-sm" id="client_subject" required >
						</div>
					</div>
					<!-- 내용 -->
					<div class="row mb-2">
						<label for="client_content" class="col-2 col-form-label inquiry_warning_star" >내용</label>
						<div class="col-sm-10">
							<textarea class="form-control" name="oto_content" rows="13" id="client_content" required style="resize: none"></textarea>
						</div>
					</div>
					<div class="row mb-2">
						<label for="client_file" class="col-2 col-form-label" >파일첨부</label>
						<div class="col-sm-10">
							<input type="file" name="file1" class="form-control form-control-sm" id="client_file1">
							<input type="file" name="file2" class="form-control form-control-sm" id="client_file2">
						</div>
					</div>
					<hr>
					<div class="submit_button">
						<input type="submit" value="문의">
					</div>	
					
				<!--  -->				
				</div>
			</form>
		</div>
	</div>
</div>
<!-- footer -->
<footer>
	<jsp:include page="/WEB-INF/views/inc/admin_footer.jsp"></jsp:include>
</footer>
<script type="text/javascript">
$(function () {
	console.log($("#oto_category").val());
	$("#csc_oto_form").submit(function(event) {
		if(!$("#csc_checkbox").is(":checked")) {
			alert("동의를 선택하셔야 문의가 가능합니다.");
			$("#csc_checkbox").focus();
			event.preventDefault();
		} else if($("#oto_category").val() =='') {
			alert("문의유형을 선택해 주세요.");
			$("#oto_category").focus();
			event.preventDefault();
		} else if($("#theater_name").val() =='') {
			alert("문의지점을 선택해 주세요.");
			$("#theater_name").focus();
			event.preventDefault();
		}
	});
});


</script>
</body>
</html>