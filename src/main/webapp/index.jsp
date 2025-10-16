<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시작페이지</title>

<%@include file ="/resources/header/header.jspf" %>
<c:if test="${ not empty sessionScope.message }">
	<script>
		alert("${sessionScope.message}");
	</script>
	<c:remove var="message" scope="session"/>
</c:if>
</head>
<body>
<div class="main-container" >
<div class="vertical-menu"> 
	<a href="#link1" class="top-menu"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-map-pin"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg>
		<span style="color: #bfbfbf;">길찾기</span></a> 
	<a href="#link2" class="top-menu">메뉴 2</a> 
	<a href="#link3" class="top-menu" >
	메뉴 3
	</a> 
	<div style="background-color: #FFCC99;">
	
	<p style="margin: 0;">365일 24시간</p>
	<p style="margin: 0;">진료예약</p>
	<p style="margin: 0; color: blue;">1234-5678</p>
	<span style="width:100%; align-content: center;align-items: center;justify-content: center;text-align: center;">
	<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-telephone-forward-fill" viewBox="0 0 16 16">
	  <path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.68.68 0 0 0 .178.643l2.457 2.457a.68.68 0 0 0 .644.178l2.189-.547a1.75 1.75 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.6 18.6 0 0 1-7.01-4.42 18.6 18.6 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877zm10.761.135a.5.5 0 0 1 .708 0l2.5 2.5a.5.5 0 0 1 0 .708l-2.5 2.5a.5.5 0 0 1-.708-.708L14.293 4H9.5a.5.5 0 0 1 0-1h4.793l-1.647-1.646a.5.5 0 0 1 0-.708"/>
	</svg>	
	</span>
	</div>
	<a id="topBtn" class="top-btn" onclick="scrollToTop()">top</a>
</div> 
<!-- 
	<h1>시작 페이지</h1>
	<p>
		<a href="login/loginPage">로그인 페이지로 이동(GET)</a>
	</p>
-->
<main>

<!-- 헤더 추가 필요 -->


<div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
	
  <div class="carousel-indicators">
    <button id="button-carousel" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    <button id="button-carousel" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="1" aria-label="Slide 2"></button>
    <!-- <button id="button-carousel" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="2" aria-label="Slide 3"></button> -->
  </div>
  <div class="carousel-inner">
    <div class="carousel-item active" data-bs-interval="3000" >
    <a href="<%= request.getContextPath() %>/info/noticeView">
      <img src="${pageContext.request.contextPath }/resources/images/carousel/연말정산.png" class="d-block w-100" alt="...">
    </a>
    </div>
    <div class="carousel-item" data-bs-interval="3000">
    <a href="<%= request.getContextPath() %>/info/remodel">
      <img src="${pageContext.request.contextPath }/resources/images/carousel/리모델링.png" class="d-block w-100" alt="...">
    </a>
    </div>
   <%--  <div class="carousel-item" data-bs-interval="3000">
    <a href="<%= request.getContextPath() %>/info/noticeView">
      <img src="https://gongu.copyright.or.kr/gongu/wrt/cmmn/wrtFileImageView.do?wrtSn=13262118&filePath=L2Rpc2sxL25ld2RhdGEvMjAyMC8yMS9DTFMxMDAwNi82MmZhMWExMy03ZjRmLTQ1NWMtYTZlNy02ZTk2YjhjMjBkYTk=&thumbAt=Y&thumbSe=b_tbumb&wrtTy=10006" class="d-block w-100" alt="...">
    </a>
    </div> --%>
  </div>
  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Previous</span>
  </button>
  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="visually-hidden">Next</span>
  </button>
</div>

 
<div class="index-main">
<div class="index-main-inner">
	<!-- <div class="search-dept">
	<h3 class="title_docdept_srch" style="margin: 0;">
		의료진/진료과 검색
		<span>서울병원의 전문의료진을 검색해 보세요.</span>
	</h3>
	    <form id="searchForm" onsubmit="searchDoctorInfo(); return false;" style="height: 100%;">
		    <input type="search" name="searchQuery" autocomplete="off" id="searchQuery" placeholder="의료진/진료과" style="padding:0; height: 24px;">
		    <svg xmlns="http://www.w3.org/2000/svg" onclick="searchDoctorInfo()" width="24" height="24" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
				<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
			</svg>
			</input>
		</form> -->
	<div class="search-dept" style="display: flex;">
	<div style="width: 60%; text-align: left; margin-left: 30px;">
		<h3 class="title_docdept_srch" style="margin: 0;">
			의료진/진료과 검색
			<span>서울병원의 전문의료진을 검색해 보세요.</span>
		</h3>
	</div>
	<div style="width: 30%; margin-left: 30px; display: flex;">
	  <div style="width: 100%; background-color: #f7f7f9; padding: 0 23px; display: flex; border-radius: 30px;">
	    <form id="searchForm" onsubmit="searchDoctorInfo(); return false;" style="height: 100%; width: 100%; display: flex; align-items: center;">
	      <input type="search" name="searchQuery" autocomplete="off" id="searchQuery" placeholder="의료진/진료과" style="border: 0; padding: 0 10px; height: 24px; flex-grow: 1;">
	      <div style="display: flex; justify-content: flex-end; align-items: center; margin-left: 10px;">
	        <svg xmlns="http://www.w3.org/2000/svg" onclick="searchDoctorInfo()" width="24" height="24" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
	          <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
	        </svg>
	      </div>
	    </form>
	  </div>
	</div>

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
	    </script>
	</div>
	<div class="inner-click" style="display: flex; justify-content: space-between;">
			<div class="inner-click-child" style="background-color: #2261ab;">
				<h4>온라인 진료예약</h4>
				<p style="margin-bottom: 15px;"> </p>
				<p>로그인 없이도 진료 예약을<br>
				편리하게 하실 수 있습니다.</p>
				<p style="margin-bottom: 30px;"> </p>
				<div> <a class="inner-click-child-a" href="javascript:void(0);" onclick="checkLogin()">예약신청</a> </div>
			</div>
<script>
	function checkLogin() {
		var user = '<%= session.getAttribute("user")%>';
		
		if(!user || user ==="null"){
			alert("로그인 후 예약이 가능합니다.");
			window.location.href = "<%=request.getContextPath() %>/user/login/login";
		} else {
			window.location.href = "reservation/reservationInsert?hpId=SSW&userNum=${sessionScope.user.userNum}";
		}
	}
</script>
			<div class="inner-click-child" style="background-color: #11a0d8;">
				<h4>의료과/진료과</h4>
				<p style="margin-bottom: 15px;"> </p>
				<p>서울병원의 전문의료진을 <br>
				검색해 보세요.</p>
				<p style="margin-bottom: 15px;"> </p>
				<div><a class="inner-click-child-a" href="<%=request.getContextPath() %>/reservation/main">의료진검색</a></div>
			</div>
			<div class="inner-click-child" style="background-color: #ef9e19;">
				<h4>협력병원 현황</h4>
				<p style="margin-bottom: 15px;"> </p>
				<p>서울병원과 협력중인 목록을<br>
				편리하게 확인하실 수 있습니다.</p>
				<p style="margin-bottom: 30px;"> </p>
				<div> <a class="inner-click-child-a"  href="hospital/hospitalSearchList">협력현황 보러가기</a> </div>
			</div>
		</div>
	<div class="rect-info">
		<a class="rect-guide" onclick="checkRserLogin()">
<script>
	function checkRserLogin() {
		var user = '<%= session.getAttribute("user")%>';
		
		if(!user || user ==="null"){
			alert("로그인 후 진료조회가 가능합니다.");
			window.location.href = "<%=request.getContextPath() %>/user/login/login";
		} else {
			window.location.href = "reservation/reservationList?userNum="+"${sessionScope.user.userNum}";
		}
	}
</script>
			<span class="rect-guide-img">
				<svg xmlns="http://www.w3.org/2000/svg" width="60%" height="60%" fill="currentColor" class="bi bi-clipboard-check" viewBox="0 0 16 16">
				  <path fill-rule="evenodd" d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0"/>
				  <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z"/>
				  <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z"/>
				</svg>
			</span>
			<span class="rect-guide-span">진료조회</span>
		</a>
		<a class="rect-guide">
			<span class="rect-guide-img">
					<svg xmlns="http://www.w3.org/2000/svg" width="60%" height="60%" fill="currentColor" class="bi bi-clipboard2-data" viewBox="0 0 16 16">
					  <path d="M9.5 0a.5.5 0 0 1 .5.5.5.5 0 0 0 .5.5.5.5 0 0 1 .5.5V2a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 2v-.5a.5.5 0 0 1 .5-.5.5.5 0 0 0 .5-.5.5.5 0 0 1 .5-.5z"/>
					  <path d="M3 2.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 0 0-1h-.5A1.5 1.5 0 0 0 2 2.5v12A1.5 1.5 0 0 0 3.5 16h9a1.5 1.5 0 0 0 1.5-1.5v-12A1.5 1.5 0 0 0 12.5 1H12a.5.5 0 0 0 0 1h.5a.5.5 0 0 1 .5.5v12a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5z"/>
					  <path d="M10 7a1 1 0 1 1 2 0v5a1 1 0 1 1-2 0zm-6 4a1 1 0 1 1 2 0v1a1 1 0 1 1-2 0zm4-3a1 1 0 0 0-1 1v3a1 1 0 1 0 2 0V9a1 1 0 0 0-1-1"/>
					</svg>
			</span>
			<span class="rect-guide-span">검사이력 및 결과조회</span>
		</a>
		<a class="rect-guide" href="<%= request.getContextPath() %>/info/map">
			<span class="rect-guide-img">
				<svg xmlns="http://www.w3.org/2000/svg" width="60%" height="60%" fill="currentColor" class="bi bi-signpost-split" viewBox="0 0 16 16">
				  <path d="M7 7V1.414a1 1 0 0 1 2 0V2h5a1 1 0 0 1 .8.4l.975 1.3a.5.5 0 0 1 0 .6L14.8 5.6a1 1 0 0 1-.8.4H9v10H7v-5H2a1 1 0 0 1-.8-.4L.225 9.3a.5.5 0 0 1 0-.6L1.2 7.4A1 1 0 0 1 2 7zm1 3V8H2l-.75 1L2 10zm0-5h6l.75-1L14 3H8z"/>
				</svg>
			</span>
			<span class="rect-guide-span">오시는 길</span>
		</a>
		<a class="rect-guide" href="<%= request.getContextPath() %>/info/parking">
			<span class="rect-guide-img">
				<svg xmlns="http://www.w3.org/2000/svg" width="60%" height="60%" fill="currentColor" class="bi bi-car-front-fill" viewBox="0 0 16 16">
				  <path d="M2.52 3.515A2.5 2.5 0 0 1 4.82 2h6.362c1 0 1.904.596 2.298 1.515l.792 1.848c.075.175.21.319.38.404.5.25.855.715.965 1.262l.335 1.679q.05.242.049.49v.413c0 .814-.39 1.543-1 1.997V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.338c-1.292.048-2.745.088-4 .088s-2.708-.04-4-.088V13.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-1.892c-.61-.454-1-1.183-1-1.997v-.413a2.5 2.5 0 0 1 .049-.49l.335-1.68c.11-.546.465-1.012.964-1.261a.8.8 0 0 0 .381-.404l.792-1.848ZM3 10a1 1 0 1 0 0-2 1 1 0 0 0 0 2m10 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2M6 8a1 1 0 0 0 0 2h4a1 1 0 1 0 0-2zM2.906 5.189a.51.51 0 0 0 .497.731c.91-.073 3.35-.17 4.597-.17s3.688.097 4.597.17a.51.51 0 0 0 .497-.731l-.956-1.913A.5.5 0 0 0 11.691 3H4.309a.5.5 0 0 0-.447.276L2.906 5.19Z"/>
				</svg>
			</span>
			<span class="rect-guide-span">주차안내</span>
		</a>
		<a class="rect-guide">
			<span class="rect-guide-img">
				<svg xmlns="http://www.w3.org/2000/svg" width="60%" height="60%" fill="currentColor" class="bi bi-map" viewBox="0 0 16 16">
				  <path fill-rule="evenodd" d="M15.817.113A.5.5 0 0 1 16 .5v14a.5.5 0 0 1-.402.49l-5 1a.5.5 0 0 1-.196 0L5.5 15.01l-4.902.98A.5.5 0 0 1 0 15.5v-14a.5.5 0 0 1 .402-.49l5-1a.5.5 0 0 1 .196 0L10.5.99l4.902-.98a.5.5 0 0 1 .415.103M10 1.91l-4-.8v12.98l4 .8zm1 12.98 4-.8V1.11l-4 .8zm-6-.8V1.11l-4 .8v12.98z"/>
				</svg>
			</span>
			<span class="rect-guide-span">원내위치안내</span>
		</a>
		<a class="rect-guide" href="<%= request.getContextPath() %>/info/noticeView">
			<span class="rect-guide-img">
				<svg xmlns="http://www.w3.org/2000/svg" width="60%" height="60%" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
				  <path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5"/>
				  <path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/>
				</svg>
			</span>
			<span class="rect-guide-span">병원생활 안내</span>
		</a>
		
		
	</div>
</div>
</div>
</div>
</main>

<script>
	window.onscroll = function() { 
		var topButton = document.getElementById("topBtn"); 
		if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) { 
			topButton.style.display = "block"; 
		} else { 
			/* topButton.style.display = "none"; */ 
		} 
	}; 
	// top 버튼 클릭 시 상단으로 이동 
	function scrollToTop() { 
		document.body.scrollTop = 0; 
		document.documentElement.scrollTop = 0;  
		
	} 
</script>	
	<%@include file ="/resources/footer/footer.jspf" %>

</body>
</html>








