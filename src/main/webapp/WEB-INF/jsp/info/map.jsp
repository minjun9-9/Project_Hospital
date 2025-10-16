<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<style>
	.kakaomap-div{
		padding: 10px;
		text-align: center;
		border-bottom: 1px solid gray;
		background-color: white;
	}
	.kakaomap-div:last-child{
		border-bottom: 0;
	}
</style>
    <%@ include file = "/resources/header/header.jspf" %>
   <div class="container" style="margin-top: 100px;">
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9c5be5c45455862c19002b25d1ab342b&libraries=services"></script>
	<div id="map" style="width:100%;height:350px; position: relative; z-index: 0;">
		<div class="kakaomap" style="width: 20%; height: 20%; position: absolute; z-index: 3; top: 60%; left: 80%;">
			<div class="kakaomap-div"><a><span style="color: #0ba6f3;">대표전화</span> 1234-1234</a></div>
			<div class="kakaomap-div"><a><span style="color: #0ba6f3;">진료예약문의</span> 5678-5678</a></div>
			<div class="kakaomap-div" style="background-color: #088bcd; cursor: pointer;"onclick="kakaoMap();"><a  style="color: white;">경로 보기</a></div>
		</div>
	
	</div>
		<div class="shuttle" style="background-color: white; margin-top: 30px; margin-bottom: 30px;">
			<h2 style="color: #088bcd; padding: 20px;">셔틀버스</h2>
			<br>
			<div class="left-right" style="justify-content: space-between; display: flex;">
				<div class="left" style="width: 70%; margin: 30px;">
					<div>
						<img alt="셔틀경로" src="${pageContext.request.contextPath }/resources/images/map/shuttle.png">
					</div>
					<p style="margin-bottom: 30px;"> </p>
					<strong>수서고속철도역(SRT), 지하철 3호선 수서역, 일원역에서 병원 본관, 암병원을 순환 운행하고 있습니다.</strong>
					<span>평일 07:30 ~ 18:00 (운행간격 8분) │ 토요일 07:30 ~ 12:30 (운행간격 15분) │ 공휴일: 운휴</span>
					<span>* 수서고속철도역(SRT) 출발 기준</span>
				</div>
				<div class="right" style="width: 30%; height: 100%; justify-content: flex-end; margin-bottom: 30px;">
					<img alt="셔틀경로" src="${pageContext.request.contextPath }/resources/images/map/map.png"
						onclick="openImage()"	>
				</div>
				<script>
					/* function openImage() {
						
						var imageUrl = "${pageContext.request.contextPath }/resources/images/map/map.png";
						var width = 900;
						var height = 800;
						
						var screenWidth = window.innerWidth || document.document.clientWidth || document.body.clientWidth;
						var screenHeight = window.innerHeight || document.document.clientHeight || document.body.clientHeight;
						
						var left = (screenWidth - width) /2;
						var top = (screenHeight - height) / 2;
						
						var newWindow =	window.open(imageUrl, 'ImageWindow', `width=\${width}, height=\${height}, left=\${left}, top=\${top}, resizable=yes`);
						newWindow.document.write(`<img src="` + imageUrl + `"style="width:100%;height:100%; object-fit:contain;">`);
					} */
					function openImage() {
					    // 이미지 URL 설정
					    var imageUrl = "${pageContext.request.contextPath }/resources/images/map/map.png";

					    // 모달의 이미지 src 변경
					    document.getElementById('modalImage').src = imageUrl;

					    // 모달 띄우기
					    var myModal = new bootstrap.Modal(document.getElementById('imageModal'));
					    myModal.show();
					}

				</script>
			</div>
		</div>
	<div></div>
	</div>
	<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content" style="border: 3px solid #0b50a1;">
      <div class="modal-header" style="background-color: #0b50a1; text-align: center;">
        <h5 class="modal-title" id="imageModalLabel" style="width: 95%; margin-left: 30px; color: white;">주요 게이트 및 셔틀버스 경로</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="width: 5%; color: white;"></button>
      </div>
      <div class="modal-body">
        <img id="modalImage" src="" alt="셔틀버스 경로 이미지" style="width: 100%; height: 900px; object-fit: contain;">
      </div>
    </div>
  </div>
</div>
<script>
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var mapContainer = document.getElementById('map'), 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), 
        level: 3 // 지도의 확대 레벨
    };  

var map = new kakao.maps.Map(mapContainer, mapOption); 

var ps = new kakao.maps.services.Places(); 

//내가 노출시킬 키원드
ps.keywordSearch('강남구 삼성서울병원', placesSearchCB); 

function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        map.setBounds(bounds);
    } 
}
//마커표시
function displayMarker(place) {
    
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    kakao.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
    });
}

//카카오 길찾기
function kakaoMap() {
	window.open("https://map.kakao.com/link/to/%EC%82%BC%EC%84%B1%EC%84%9C%EC%9A%B8%EB%B3%91%EC%9B%90,37.488205,127.085012", "_blank", "width=1500,height=1200,top=100,left=100");
}
</script>
    <%@ include file = "/resources/footer/footer.jspf" %>

    
</body>
</html>
