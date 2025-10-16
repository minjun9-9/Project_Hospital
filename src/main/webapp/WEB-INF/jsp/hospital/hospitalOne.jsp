<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<%@include file ="/resources/header/header.jspf" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>one</title>
	<link rel="stylesheet" href="../resources/css/default.css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="../resources/js/jquery-1.11.2.min.js"></script>
	<script src="../resources/js/swiper.min.js"></script>
	<script src="../resources/js/design.js"></script>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c2677356b896085789173b459140e4a4&libraries=services"></script>
</head>
<style>
	.hp_one{
		display: flex;
		flex-direction: column;
		gap: 21px;
		font-size: 17px;
		background-color: #595f6a;
		color: #fff;
		padding: 30px 40px;
		margin-bottom: 20px;
	}
	#map {
		 width: 100%;
		 height: 500px;
	}
</style>
<body>
<!-- <div class="body_wrap">
		<div class="content">
			<div class="con_wrap bg_13"> -->
				<!-- content시작 -->
<div class="container">
	<div style="width: 1200px; margin: 20px auto 40px">
		<div class="hp_one">
			<div>병원명 : ${ hospitalOne.hpName }</div>
			<div>대표번호 : ${ hospitalOne.hpNumber }</div>
			<div>주소 : ${ hospitalOne.hpAddress }</div>
			<div>진료과 :
				<c:forEach var="dept" items="${ deptList }" varStatus="status">
					${ dept.deptName }
					<c:if test="${ status.index < deptList.size() - 1 }">
						,
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div id="map"></div>
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
</script>
<%@include file ="/resources/footer/footer.jspf" %>
</body>
</html>
