<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
	
	.breadcrumbs{
		font-size: 14px;
		display: flex;
	}
	ul, li{
		list-style: none;
	}
	ul{
	display: block;
	}
	.breadcrumbs ul.location-child {
		margin-left: 0;
		padding-left: 0;
		position: relative;
		left: 0;
	}
	.breadcrumbs li.location-child {
	
	}
	.location-label{
		text-decoration: none;
		color: black;
	}
	.location-child {
		display: none;
	}
	
	
	/* 카드용 css */
	   .card-footer{
      width: 50%;
      align-items: center;
      text-align: center;
      text-decoration: none;
        
    }
    .doctor-card{
        list-style-type: none;
        display: grid;
       /*  grid-template-columns: repeat(2, 1fr); */
        gap: 40px;
        padding: 0;
        justify-items: end;
        width: 45%;
    }
    #doctorResults{
        list-style-type: none;
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        padding: 0;
        justify-items: end;
    }
	.doctor-profile{
        list-style-type: none;
		height: auto;
		width: 100%;
		background-color: white;
	}
    .doctor-img{
        margin: 20px;
    }
    .card-footer:hover{
        background-color: #3378C1;
    }
    .card-font{
        font-size: 14px;
        font: inherit;
        color: #44484f;
        text-align: center;
        align-items: center;
        justify-content: center;
    }
    
</style>


<body>

	<header>
	<%@include file ="/resources/header/header.jspf" %>
	
	</header>
	<div style=" background-color: white; position: relative;"> <!-- 부모 div에 relative position 추가 -->
    <div class="inner-header" style="display:flex; max-width: 1320px; margin-left: 100px;">
        <ul class="breadcrumbs">
				<li>
					<a>
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-door-fill" viewBox="0 0 16 16">
						  <path d="M6.5 14.5v-3.505c0-.245.25-.495.5-.495h2c.25 0 .5.25.5.5v3.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5"/>
						</svg>
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-compact-right" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M6.776 1.553a.5.5 0 0 1 .671.223l3 6a.5.5 0 0 1 0 .448l-3 6a.5.5 0 1 1-.894-.448L9.44 8 6.553 2.224a.5.5 0 0 1 .223-.671"/>
						</svg>
					</a>
				</li>
				<li id="location1" class="expanded">
					<a href="javascript:void(0);" class="location-label" aria-expanded="true">
						<span class="location-text">진료예약</span>
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
						  <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						</svg>
					</a>
					<ul class="location-child" style="position: absolute; top: 30; left: 150px; display: none; padding:20px; padding-top:10px; background-color: white;">
						<li style="margin-bottom: 5px;">진료예약</li>
						<li style="margin-bottom: 5px;">건강정보</li>
						<li style="margin-bottom: 5px;">진료차트</li>
						<li style="margin-bottom: 5px;">나눔소통</li>
						<li style="margin-bottom: 5px;">병원안내</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/minjun_css/resermain.css">
	<!-- <h1>예약진행 페이지</h1> -->
	<div class="container">
	<div class="inner-wrap clearfix">
		<div class="left-container" style="margin-right: 20px;	margin-bottom: 20px;">
			<div class="left">
				<div class="box-default box-shadow medical-search" style="margin-bottom: 30px;">
					<h3 style="margin: 16px 0 23px;"><strong>의료진 검색</strong></h3>
					<form id="searchForm" class="searchResermain" onsubmit="searchDoctorInfo(); return false;">
					    <input type="text" name="searchQuery" id="searchQuery" placeholder="검색어를 입력하세요." autocomplete="off"/>
					    <button class="buttonResermain" type="button" onclick="searchDoctorInfo()">
							<svg id="SearchButtonResermain" xmlns="http://www.w3.org/2000/svg" width="14" height="14" style="background-color: #3378c1;"  class="bi bi-search" viewBox="0 0 16 16">
								<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
						</button>
					</form>

<script>
function searchDoctorInfo() {
    const searchQuery = document.getElementById('searchQuery').value;

    fetch('/hospital/reservation/doctorDetailInfoSearchMain?searchQuery=' + encodeURIComponent(searchQuery))
        .then(response => response.json())
        .then(data => {
            // 검색 결과를 localStorage에 저장
            localStorage.setItem("doctorList", JSON.stringify(data));
            localStorage.setItem("searchQuery", searchQuery); // 검색어도 함께 저장

            // 리다이렉트 없이 doctorDetailInfo 페이지로 이동
            window.location.href = "/hospital/reservation/doctorDetailInfo";
        })
        .catch(error => console.error('Error:', error));
}


/* 초성넘기기 */
</script>

				</div>
				<div> 
    <ul style="padding: 0; margin: 0;">
        <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <c:forEach var="doctor" items="${topDoctors}" varStatus="status">
                    <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                        <li class="doctor-profile" style="width: 100%; height: 100;">
                            <div style="display: flex;">
                                <div class="doctor-img" style="width: 150px; height: 150px;">
                                     <c:if test="${not empty doctor.fileOne}">
				                        <img src="/hospital${doctor.filePath}" alt="Doctor Image" style="width:150px; height: 150px;  object-fit: cover;">
				                    </c:if>
				                    <c:if test="${empty doctor.filePath}">
				                        <svg xmlns="http://www.w3.org/2000/svg" width="150" height="150" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				                            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
				                            <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
				                        </svg>
				                    </c:if>
                                </div>
                                <div class="doctor-info" style="margin: 10px;">
                                    <div class="doctor-info-names" style="display:flex;">
                                        <h3 style="color: #115bab;">${doctor.drName}&nbsp</h3>
                                        <h3> 교수</h3>
                                        <h3 style="font-size: 1rem; align-content: center;">${doctor.deptName}</h3>
                                    </div>
                                    <strong>[진료분야]</strong><br><br>
                                    <span style="color: #72767e; font-weight: bold;">${doctor.drField}</span>
                                </div>
                            </div>
                            <div style="display: flex; margin: 20px 0; width: 100%;">
                                <a href="" class="card-footer">
                                    <div class="card-font" style="margin: 20px;">상세소개</div>
                                </a>
                                <a href="javascript:void(0);" onclick="checkLogin()" class="card-footer">
                                    <div class="card-font" style="margin: 20px;">진료예약</div>
                                </a>
                            </div>
                        </li>
                    </div>
                </c:forEach>
            </div>
<script>
	function checkLogin() {
		var user = '<%= session.getAttribute("user")%>';
		
		if(!user || user ==="null"){
			alert("로그인 후 예약이 가능합니다.");
			window.location.href = "<%=request.getContextPath() %>/user/login/login";
		} else {
			window.location.href = "<%=request.getContextPath() %>/reservation/reservationInsert?hpId=SSW&userNum="+"${sessionScope.user.userNum}";
		}
	}
</script>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </ul>
</div>
			</div>
		</div>
		<div class="right-container">
		
			<div class="right">
				<div class="box-default box-shadow treatment-parts" style="margin-bottom: 30px;">
					<div class="two">
					
					<div class="box-default box-shadow quick-reservation" style="padding: 0;">
						<div class="normal-reservation" style="">
							<h3 style="margin-bottom: 15px;"><strong>일반예약</strong></h3>
							<ul>
								<li class="ico-phone"><strong style="margin-right: 10px;">전화예약</strong><span class="txtBlue">1599-3114</span></li>
								<li class="ico-phone"><strong style="margin-right: 10px;">치과예약</strong><span class="txtBlue">1599-3114</span>
								</li>
								<li class="ico-walk"><strong style="margin-right: 10px;">방문예약</strong>병원에 직접 방문하시어 예약을 하실 수 있습니다. </li>
							</ul>
						</div>
					</div>
				</div>
				</div>
				<div class="box-default box-shadow treatment-parts">
					<h3><strong>진료과 검색</strong></h3>
	
					<div class="tab-parts">
						<ul class="clearfix" role="tablist" style="text-align: center; margin: 0; padding: 0;">
							<li class="on" style="color: #3378c1;">진료과</li>
						</ul>
					</div>
		
					<div class="parts-initial-search" style="margin-top: 15px; ">
		
						<div id="parts" class="parts-con current" aria-labelledby="pis_btn1">
							<div class="initial-search">
								<div class="initial-search-list">
									<%-- <table role="presentation" id="dpTypeO">
										<colgroup>
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											</colgroup>
											<tr >
											 	<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button"  onclick="goToDeptSearch('ㄱ')">ㄱ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㄴ')">ㄴ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㄷ')">ㄷ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㄹ')">ㄹ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅁ')">ㅁ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅂ')">ㅂ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅅ')">ㅅ</button></td>
												<td></td>
											</tr>
											<tr>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅇ')">ㅇ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅈ')">ㅈ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅊ')">ㅊ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅋ')">ㅋ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅌ')">ㅌ</button></td>
												<td><button  style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅍ')">ㅍ</button></td>
												<td><button   style="margin: 5px;" type="button" class="button button-initial" role="button" onclick="goToDeptSearch('ㅎ')">ㅎ</button></td>
												<td></td>
											</tr>
										 <script type="text/javascript">
											 function goToDeptSearch(initial) {
												window.location.href = '<%=request.getContextPath() %>/reservation/deptSearch?initial='+initial; 
												
											} 
										</script> 
										</table> --%>
									<form id="deptSearchForm" method="get" action="<%=request.getContextPath() %>/reservation/deptSearchForm">
									<table role="presentation" id="dpTypeO">
										<colgroup>
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											<col style="width:12.5%">
											</colgroup>
											<tr >
											 	<td><button  style="margin: 5px;" type="submit" class="button button-initial" name="initial" value="ㄱ" >ㄱ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㄴ" >ㄴ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㄷ">ㄷ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㄹ">ㄹ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅁ" >ㅁ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅂ" >ㅂ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅅ">ㅅ</button></td>
												<td></td>
											</tr>
											<tr>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅇ">ㅇ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅈ">ㅈ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅊ">ㅊ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅋ">ㅋ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅌ">ㅌ</button></td>
												<td><button  style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅍ">ㅍ</button></td>
												<td><button   style="margin: 5px;" type="submit" class="button button-initial"  name="initial" value="ㅎ">ㅎ</button></td>
												<td></td>
											</tr>
										</table>
										</form>
									</div>
		
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	<%@include file ="/resources/footer/footer.jspf" %>
<style>
/* 캐러셀 겹쳐서 여기를 적용시킬 거임 */
.carousel-control-next{
	position: absolute;
	right: 0;
	transform: translateY(-50%);
	top: 10%;
	z-index: 11;
	height: 10%;
	width: 10%;
}
.carousel-control-prev{
	position: absolute;
	right: 20px;
	transform: translateY(-50%);
	top: 10%;
	z-index: 11;
	height: 10%;
	width: 170%;
}
</style>
<script>
	document.addEventListener('DOMContentLoaded', function () {
		const locationLabel = document.querySelector('.location-label');
		const locationChild = document.querySelector('.location-child');
	
		if (locationLabel) {
			locationLabel.addEventListener('click', function () {
				if (locationChild && locationChild.style.display === 'block') {
					locationChild.style.display = 'none';
				} else if (locationChild) {
					locationChild.style.display = 'block';
				}
			});
		}
	});
	
	document.querySelector('.location-label').addEventListener('click', function() {
		const locationChild = document.querySelector('.location-child');
		
		if (locationChild.style.display === 'block'){
			locationChild.style.display = 'none';
		} else {
			locationChild.style.display ='block';
		}
	});
	</script>
</body>
</html>