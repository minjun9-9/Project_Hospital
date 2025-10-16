<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>one</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/design.js"></script>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c2677356b896085789173b459140e4a4&libraries=services"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

	<c:if test="${not empty message}">
        <script>
            alert("${message}");
        </script>
        <c:remove var="message" scope="request" />
    </c:if>
</head>
<style>
	.form-control {
		display: inline-block !important;
	}
	.doc_left {
		height: 587.5px;
	}
	.btn-secondary {
		height: 50px;
    	width: 120px;
	}
	.btn-primary {
		width: 230px;
    	height: 65px;
    	font-size: 22px;
	}
</style>
<body>
    <div class="body_wrap">
		<!-- <div class="menu bg_1">
			<div class="title bor_1"><a href="../index.jsp">협력병원</a></div>
			<div class="gnb_box">
				<ul class="gnb_1st">
					<li class="have_sub">
						<a href="#">협력병원 관리</a>
						<ul class="gnb_2nd">
							<li><a href="hospitalSearchList">협력병원 현황</a></li>
							<li><a href="hospitalInsert">협력병원 등록</a></li>
							<li><a href="hospitalList">협력병원 관리</a></li>
						</ul>
					</li>
					<li class="have_sub">
						<a href="#">진료예약</a>
						<ul class="gnb_2nd">
							<li><a href="../reservation/deptList?hpId=SSW">진료예약 등록</a></li>
							<li><a href="../reservation/reservationList?userNum=241227006">진료예약 조회</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div> -->
		
		<%@include file="/resources/common/menu.jspf" %>
		
		<div class="content">
			<div class="top_bar bg_w">
				<a href="#" class="top_left doctor_con"><span>협력병원 관리</span></a>
				<!-- <div class="top_right">
					<a href="#" class="option"><img src="../resources/images/top_option.png" alt="option"></a>
					<a href="#">
						<span class="profile bg_5 f_s20">류</span>
						<span class="name c_2 f_s15">홍길동님</span>
					</a>
				</div> -->
				<%@include file="/resources/common/profile.jspf" %>
			</div>
			<div class="con_wrap bg_13" style="min-width: 1500px;">
				<!-- content시작 -->
				<form action="hospitalUpdate" method="post">
					<div class="doctor">
						<div class="doc_left bg_w">
							<div class="doc_con" style="margin-bottom: 49px;">
								<p class="f_s17 f_w500">병원명*</p>
								<input class="form-control" type="text" name="hpName" value="${ hospitalOne.hpName }" placeholder="병원명을 입력하세요" maxlength="10" required>
							</div>
							<div class="doc_con" style="margin-bottom: 49px;">
								<p class="f_s17 f_w500">대표번호*</p>
								<input class="form-control" type="text" name="hpNumber" value="${ hospitalOne.hpNumber }" placeholder="대표번호를 **-***-****형식으로 입력하세요" pattern="(\d{2,3})-(\d{3,4})-(\d{4})" required>
							</div>
							<div class="doc_con" style="margin-bottom: 49px;">
								<p class="f_s17 f_w500">주소*</p>
								<input class="form-control" type="text" id="hpAddress" name="hpAddress" value="${ hospitalOne.hpAddress }" readonly/>
	        					<button class="btn btn-secondary" type="button" onclick="openAddressDialog()">주소검색</button>
							</div>
							<div class="doc_con" style="margin-bottom: 49px;">
								<p class="f_s17 f_w500">지역</p>
								<select class="form-select" name="hpRegion">
									<option value="서울" ${ hospitalOne.hpRegion == "서울" ? "selected" : "" }>서울특별시</option>
									<option value="경기" ${ hospitalOne.hpRegion == "경기" ? "selected" : "" }>경기도</option>
									<option value="인천" ${ hospitalOne.hpRegion == "인천" ? "selected" : "" }>인천광역시</option>
									<option value="강원" ${ hospitalOne.hpRegion == "강원" ? "selected" : "" }>강원도</option>
									<option value="충북" ${ hospitalOne.hpRegion == "충북" ? "selected" : "" }>충청북도</option>
									<option value="충남" ${ hospitalOne.hpRegion == "충남" ? "selected" : "" }>충청남도</option>
									<option value="대전" ${ hospitalOne.hpRegion == "대전" ? "selected" : "" }>대전광역시</option>
									<option value="전북" ${ hospitalOne.hpRegion == "전북" ? "selected" : "" }>전라북도</option>
									<option value="전남" ${ hospitalOne.hpRegion == "전남" ? "selected" : "" }>전라남도</option>
									<option value="광주" ${ hospitalOne.hpRegion == "광주" ? "selected" : "" }>광주광역시</option>
									<option value="경북" ${ hospitalOne.hpRegion == "경북" ? "selected" : "" }>경상북도</option>
									<option value="경남" ${ hospitalOne.hpRegion == "경남" ? "selected" : "" }>경상남도</option>
									<option value="대구" ${ hospitalOne.hpRegion == "대구" ? "selected" : "" }>대구광역시</option>
									<option value="울산" ${ hospitalOne.hpRegion == "울산" ? "selected" : "" }>울산광역시</option>
									<option value="부산" ${ hospitalOne.hpRegion == "부산" ? "selected" : "" }>부산광역시</option>
									<option value="제주" ${ hospitalOne.hpRegion == "제주" ? "selected" : "" }>제주도</option>
								</select>
							</div>
						</div>
						<div class="doc_right bg_w">
							<div id="map" style="width: 100%; height: 500px;"></div>
						</div>
					</div>
					<div class="doc_bottom f_s16 f_w600">
						<input class="btn btn-primary" type="submit" value="수정하기">
						<input class="btn btn-secondary" style="width: 230px; height: 65px; font-size: 22px;" type="button" value="승인" onclick="hospitalAccess('${ hospitalOne.hpId }')">
						<input class="btn btn-danger" style="width: 230px; height: 65px; font-size: 22px;" type="button" value="미승인" onclick="hospitalDelete('${ hospitalOne.hpId }')">
						<input type="hidden" name="hpId" value="${ hospitalOne.hpId }">
					</div>
				</form>
			</div>
		</div>
	</div>
<script>
	kakao.maps.load(function() {
		var hpAddress = "${ hospitalOne.hpAddress }";
		var geocoder = new kakao.maps.services.Geocoder();
	
		geocoder.addressSearch(hpAddress, function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var lat = result[0].y;  // 위도
				var lng = result[0].x;  // 경도
				var mapContainer = document.getElementById("map");
				
				var mapOption = {
					center: new kakao.maps.LatLng(lat, lng),  // 변환된 좌표를 중심으로 설정
					level: 3  // 지도 확대 레벨
				};
				var map = new kakao.maps.Map(mapContainer, mapOption);
				
				var marker = new kakao.maps.Marker({
					position: new kakao.maps.LatLng(lat, lng)  // 마커의 위치는 변환된 좌표로 설정
				});
				marker.setMap(map);
			}
			else {
				alert("존재하지 않는 주소입니다.");
			}
		});
	});
	function openAddressDialog() {
		new daum.Postcode({
			oncomplete: function(data) {
				document.getElementById('hpAddress').value = data.roadAddress;
				
				kakao.maps.load(function() {
					var hpAddress = data.roadAddress;
					var geocoder = new kakao.maps.services.Geocoder();
				
					geocoder.addressSearch(hpAddress, function(result, status) {
						if (status === kakao.maps.services.Status.OK) {
							var lat = result[0].y;  // 위도
							var lng = result[0].x;  // 경도
							var mapContainer = document.getElementById("map");
							
							var mapOption = {
								center: new kakao.maps.LatLng(lat, lng),  // 변환된 좌표를 중심으로 설정
								level: 3  // 지도 확대 레벨
							};
							var map = new kakao.maps.Map(mapContainer, mapOption);
							
							var marker = new kakao.maps.Marker({
								position: new kakao.maps.LatLng(lat, lng)  // 마커의 위치는 변환된 좌표로 설정
							});
							marker.setMap(map);
						}
						else {
							alert("존재하지 않는 주소입니다.");
						}
					});
				});
			}
		}).open();
	}
	function hospitalDelete(hpId) {
		location.href = "hospitalDelete?hpId=" + hpId;
	}
	function hospitalAccess(hpId) {
		location.href = "hospitalAccess?hpId=" + hpId;
	}
</script>
</body>
</html>
