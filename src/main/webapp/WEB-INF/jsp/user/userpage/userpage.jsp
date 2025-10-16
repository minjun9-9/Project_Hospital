<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
	<%@include file="/resources/header/header.jspf" %>
<style>


/* 전체 컨테이너 */
.page-container {
    display: flex;
    flex-direction: row;
    min-height: 100vh;
}

/* 사이드바 스타일 */
.sidebar {
    width: 250px;
    background-color: #595f6a;
    color: white;
    padding: 20px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    box-sizing: border-box;
}

.sidebar h2 {
    font-size: 1.5rem;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center;
    border-bottom: 1px solid rgba(255, 255, 255, 0.3);
    padding-bottom: 10px;
}

/* 사이드바 메뉴 */
.dev_menu {
    list-style: none;
    padding: 0;
    margin: 0;
}

.dev_menu > li {
    margin-bottom: 15px;
}

.dev-inner-anchor {
    display: block;
    color: white;
    text-decoration: none;
    padding: 10px 15px;
    font-size: 1rem;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

.dev-inner-anchor:hover {
    background-color: rgba(255, 255, 255, 0.2);
}

.sub-menu {
    list-style: none;
    padding-left: 20px;
    display: none;
    margin-top: 10px;
}

.sub-menu li {
    margin-bottom: 10px;
}

.sub-menu a {
    text-decoration: none;
    color: white;
    font-size: 0.9rem;
    transition: color 0.3s ease;
}

.sub-menu a:hover {
    color: #007bff;
}

.dev_menu > li:hover .sub-menu {
    display: block;
}

/* 콘텐츠 영역 */
.main-content {
    flex-grow: 1;
    padding: 40px;
    background-color: #f5f5f5;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: center;
}

/* 기본정보 섹션 */
.profile-container {
    width: 80%;
    max-width: 800px;
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-bottom: 40px;
    text-align: center;
}

.profile-container img {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    border: 2px solid #ccc;
    object-fit: cover;
    max-width: 100%;  /* 추가 */
}

/* 카드 그리드 */
.grid-container {
    display: grid;
    grid-template-columns: repeat(2, 1fr);  /* 2열로 설정 */
    gap: 40px;
    justify-content: center;
    width: 80%;
    max-width: 1200px; /* 최대 너비 설정 */
    margin-bottom: 40px;
}

/* 카드 스타일 */
.card {
    position: relative;
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    padding: 30px;
    text-align: center;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card h3 {
    margin-bottom: 10px;
    font-size: 1.2rem;
}

.card a {
    display: block;
    text-decoration: none;
    font-weight: bold;
    margin-top: 10px;
}

/* 버튼 기본 스타일 */
.button-link {
    display: inline-block;
    padding: 10px 20px;
    font-size: 1rem;
    font-weight: bold;
    color: #ffffff;
    background-color: #007bff;
    border: none;
    border-radius: 5px;
    text-align: center;
    text-decoration: none;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

/* 버튼 호버 및 클릭 효과 */
.button-link:hover {
    background-color: #0056b3;
    transform: translateY(-2px);
}

.button-link:active {
    background-color: #004494;
    transform: translateY(0);
}

/* 버튼 위치 조정 (우측 상단 배치) */
.card .card-buttons {
    position: absolute;
    top: 20px;
    right: 20px;
    display: flex;
    gap: 10px;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}

/* 관심의료진 섹션 */
.sub-container {
    margin-top: 50px;
}

/* 반응형 디자인 */
@media (max-width: 1024px) {
    .page-container {
        flex-direction: column;
    }
    .sidebar {
        width: 100%;
        text-align: center;
        padding: 10px;
    }
    .main-content {
        padding: 20px;
    }
    .grid-container {
        grid-template-columns: 1fr;
    }
}
</style>
<script>
	let sessionTimeout = 30 * 60 * 1000; // 30분
	let warningTime = 25 * 60 * 1000; // 25분 후 경고
	
	setTimeout(() => {
	    alert("세션이 곧 만료됩니다. 계속 사용하려면 작업을 진행하세요.");
	}, warningTime);
	
	setTimeout(() => {
	    alert("세션이 만료되었습니다. 다시 로그인해주세요.");
	    window.location.href = "<%=request.getContextPath() %>/hospital/user/login/login";
	}, sessionTimeout);
</script>
</head>
<body>
	<div class="page-container">
		<!-- 사이드바 -->
		<div class="sidebar" role="navigation">
			<h2>나의서비스</h2>
			<ul class="dev_menu">
				<li><a href="#" class="dev-inner-anchor">건강노트</a>
					<div class="sub-menu">
						<ul>
							<li><a href="#">나의스토리</a></li>
							<li><a href="#">나의스크랩</a></li>
							<li><a href="#">관심의료진</a></li>
						</ul>
					</div>
				</li>
				<li><a href="#" class="dev-inner-anchor">건강코치</a>
					<div class="sub-menu">
						<ul>
							<li><a href="#">체중&amp;영양다이어리</a></li>
							<li><a href="#">혈압관리</a></li>
							<li><a href="#">혈당관리</a></li>
						</ul>
					</div>
				</li>
				<li><a href="#" class="dev-inner-anchor">14세 미만 대리인증</a></li>
				<li><a href="userpage" class="dev-inner-anchor">개인정보</a>
					<div class="sub-menu">
						<ul>
							<li><a href="usermodify">기본정보 수정</a></li>
							<li><a href="passwordmodify">비밀번호 변경</a></li>
							<li><a href="memberleave">회원탈퇴</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
		
		<!-- 메인 콘텐츠 -->
		<div class="main-content">
			<!-- 기본정보 -->
			<div class="profile-container">
				<h3>기본정보</h3>
				<img src="${pageContext.request.contextPath }/resources/images/@profile_default.jpg"
						style="width: 150px; height: 150px; border-radius: 50%; border: 2px solid #ccc; object-fit: cover; margin-bottom: 10px;"><br>
				<span><strong>${user.userName }</strong> 고객님</span><br>
				<p><a href="#">자주하는 질문 (QNA)</a></p>
			</div>
			
			<!-- 예약현황, 진료내역 -->
			<div class="grid-container">
				<div class="card">
					<div class="card-buttons">
						<a  href="<%=request.getContextPath() %>/reservation/reservationList?userNum=${sessionScope.user.userNum}">전체 예약 내역</a>
					</div>
					<h3>예약현황</h3>
					<c:choose>
						<c:when test="${not empty reservation }">
							<p>
								예약현황 : <strong>${reservation.createdDate }</strong> 
								(${reservation.createdDay }) ${reservation.time } ${reservation.deptName } ${reservation.drName }
							</p>
							<a href="#" class="button-link">변경</a>
							<a href="reservationDelete?reservId=${ reservation.reservId }&otId=${ reservation.otId }" class="button-link">취소</a>
						</c:when>
								
						<c:otherwise>
							<p class="no-reservation">최근 3개월의 예약 내역이 없습니다.</p>
							<a class="button-link" href="reservation/reservationInsert">진료예약하기</a>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="card">
					<div class="card-buttons">
						<a href="<%=request.getContextPath() %>/userclient/mypage/historyMedicalRecord">전체 진료 내역</a>
					</div>
					<h3>진료내역</h3>
					<c:choose>
			         	<c:when test="${not empty record}">
							<p>
								진료내용 : <strong>${record.treatmentPeriod}</strong> 
								(${record.createdDay}) ${record.deptName} ${record.drName}
							</p>
							<a href="" class="button-link">변경</a>
							<a href="" class="button-link">취소</a>
			      		</c:when>
			                	
						<c:otherwise>
			   				<p class="no-record">최근 3개월의 진료 내역이 없습니다.</p>
			       		</c:otherwise>
			   		</c:choose>
			   	</div>
			</div>
	
			<!-- 검사예약, 투약내역 -->
			<div class="grid-container">
				<div class="card">
					<h3>검사예약</h3>
					<p>최근 3년의 검사예약 내역이 없습니다.</p>
				</div>
				<div class="card">
					<h3>투약내역</h3>
					<p>
						최근 3개월 간의 내역이 표시됩니다. 보다 자세한 정보는 '투약내역+' 버튼을 눌러주시기 바랍니다.<br>
						통합의료정보시스템으로 변경되어 2020년 12월 26일 이후 약처방 내역만 조회가 가능합니다.
					</p>
				</div>
			</div>
	
			<!-- 고객의 소리, 칭찬합니다 -->
			<div class="grid-container">
				<div class="card">
					<h3>고객의 소리</h3>
					<p>등록된 내역이 없습니다.</p>
					<a class="button-link" href="#">등록</a>
				</div>
				<div class="card">
					<h3>칭찬합니다</h3>
					<p>등록된 내역이 없습니다.</p>
					<a class="button-link" href="#">등록</a>
				</div>
			</div>
	
			<div>
				<!-- 관심의료진 -->
				<section>
					<h3>관심의료진</h3>
					<p><strong>${userInfo.userName }</strong> 고객님은 0명의 관심 의료진을 등록하셨습니다.</p>
					<a class="button-link" href="#">의료진 찾기</a>
				</section>
			</div>
		</div>
		
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
	</div>
	<%@include file="/resources/footer/footer.jspf" %>
</body>
</html>