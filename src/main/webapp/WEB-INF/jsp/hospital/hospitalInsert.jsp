<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>insert</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/design.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c2677356b896085789173b459140e4a4&libraries=services"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
	.form-control {
		display: inline-block !important;
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
	#map {
		width: 100%;
		height: 500px;
		align-content: center;
    	text-align: center;
	}
	.map_text {
		opacity: 0.4;
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
				<form method="post">
					<div class="doctor">
						<div class="doc_left bg_w">
							<div class="doc_con">
								<p class="f_s17 f_w500">병원코드*</p>
								<input class="form-control" type="text" id="hpId" name="hpId" placeholder="병원코드를 입력하세요" maxlength="8" required>
	        					<div id="hpIdCheck"></div>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">병원명*</p>
								<input class="form-control" type="text" name="hpName" placeholder="병원명을 입력하세요" maxlength="10" required>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">대표번호*</p>
								<input class="form-control" type="text" name="hpNumber" placeholder="대표번호를 **-***-****형식으로 입력하세요" pattern="(\d{2,3})-(\d{3,4})-(\d{4})" required>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">주소*</p>
	        					<input class="form-control" type="text" id="hpAddress" name="hpAddress" placeholder="기본주소" readonly/>
	        					<button class="btn btn-secondary" type="button" onclick="openAddressDialog()">주소검색</button>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">지역</p>
								<select class="form-select" name="hpRegion">
									<option value="서울">서울특별시</option>
									<option value="경기">경기도</option>
									<option value="인천">인천광역시</option>
									<option value="강원">강원도</option>
									<option value="충북">충청북도</option>
									<option value="충남">충청남도</option>
									<option value="대전">대전광역시</option>
									<option value="전북">전라북도</option>
									<option value="전남">전라남도</option>
									<option value="광주">광주광역시</option>
									<option value="경북">경상북도</option>
									<option value="경남">경상남도</option>
									<option value="대구">대구광역시</option>
									<option value="울산">울산광역시</option>
									<option value="부산">부산광역시</option>
									<option value="제주">제주도</option>
								</select>
							</div>
						</div>
						<div class="doc_right bg_w">
							<div id="map"><span class="map_text">주소를 입력하세요</span></div>
						</div>
					</div>
					<div class="doc_bottom f_s16 f_w600">
						<input class="btn btn-primary" type="button" value="등록하기" onclick="hospitalInsert(this.form)">
					</div>
				</form>
			</div>
		</div>
	</div>
<script>
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
	
	let insertHpIdCheck = "불가";
	
	function hpIdCheck(callback) {
		//1
		console.log("id체크 시작");
		
		let hpId = document.getElementById('hpId').value;
		console.log(hpId);
		
		$.ajax("hospitalOneJson", {
			method: "post",
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify({ hpId : hpId }),
			
			success: function(data){
				if(data.hpId === "사용가능") {
					insertHpIdCheck = "사용가능";
					/*  */
					console.log("여기까지왔음.")
					console.log(insertHpIdCheck);
					
					callback("사용가능");
				}
				else {
					alert("이미 사용중인 아이디입니다.");
					document.getElementById('hpId').value = "";
					insertHpIdCheck = "불가";
					callback("불가");
				}
			},
			error: function() {
		        alert("실패");
		        callback("실패");
		    }
		});
	}
	
	/* function hospitalInsert(frm) {
		
		console.log("체크시작");
		hpIdCheck();
		console.log("체크완료");
		
		
		console.log("등록클릭");
		if(frm.checkValidity()) {
			
			console.log(insertHpIdCheck);
			
			if(insertHpIdCheck === "사용가능") {
				console.log("사용가능 및 저장");
				//frm.action = "hospitalInsert";
				//frm.submit();
			}
		}
		else {
			alert("항목을 모두 입력해주세요.");
		}
	} */
	
	function hospitalInsert(frm) {
	    console.log("함수 시작");

	    // 콜백으로 hpIdCheck 실행
	    hpIdCheck(function(status) {
	        console.log("아이디체크 시작");

	        if(frm.hpAddress.value == null || frm.hpAddress.value == "") {
				alert("항목을 모두 입력해주세요.");
			}
			else if (frm.checkValidity()) {
	            console.log(insertHpIdCheck);

	            if (insertHpIdCheck === "사용가능") {
	                console.log("사용가능 및 저장");
	                frm.action = "hospitalInsert";
	                frm.submit();
	            }
	        } else {
	            alert("항목을 모두 입력해주세요.");
	        }
	    });
	}
	
	
	
	document.getElementById('hpId').addEventListener("input",function(event) {
		let hpId = event.target.value;
		
		if(hpId === "") {
			return;
		}
		
		$.ajax("hospitalOneJson", {
			method: "post",
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify({ hpId : hpId }),
			
			success: function(data){
				let dispHtml = "";
				
				if(data.hpId === "사용가능") {
					dispHtml += "사용가능한 아이디입니다.";
				}
				else {
					dispHtml += "이미 사용중인 아이디입니다.";
				}
				$("#hpIdCheck").html(dispHtml);
			},
			error: function() {
		        alert("실패");
		    }
		});
	});
</script>
</body>
</html>
