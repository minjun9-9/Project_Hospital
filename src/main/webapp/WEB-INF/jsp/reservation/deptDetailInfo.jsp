<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
	.introduction {
		display: flex; 
		justify-content: space-between;
		width: 100%;
	}
	.introduction-button-detail{
		display: flex;
		justify-content: flex-end;
		gap: 10px;
	}
	
	.introduction-info {
		margin: 0;
		padding: 0;
		background-color: white;
		display: flex;
		/* gap: 20px; */
	}
	.intro-head{
		text-decoration: none;
		color: black;
		padding: 10px;
	}
	.intro-head:hover{
		border-bottom: 1px solid blue;
	}
	.introduction-search {
		display:flex;
		justify-content: flex-end;
	}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function deptDetailInfo_Page1() {
		let item = document.querySelctAll(".intro-head");
		item.style.display='block';
	}
</script>
<body>
	<header>
	<%@include file ="/resources/header/header.jspf" %>
	<div class="container">
	</header>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/deptDetailInfo.css"> 
	<div class="container" style=" margin-top: 150px; padding: 20px;">
		<div class="introduction">
			<h2 style="font-size: 24px; margin-bottom: 10px;">소화기내과</h2>
			<div class="introduction-button-detail">
			<a href="#">
				<button style="padding: 10px 15px; background-color: #3378c1; border: 0; color: white; font-size: 14px; display: flex; align-content: center; align-items: center; gap:5px;">
				<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
				  <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325"/>
				</svg>
				<span>진료예약</span>
				</button></a>
			</a>
			<a href="<%=request.getContextPath() %>/reservation/deptSearch">
			<button style="padding: 10px 15px; background-color: #3378c1; border: 0; color: white; font-size: 14px; display: flex; align-content: center; align-items: center; gap:5px;">
			<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-border-all" viewBox="0 0 16 16">
			  <path d="M0 0h16v16H0zm1 1v6.5h6.5V1zm7.5 0v6.5H15V1zM15 8.5H8.5V15H15zM7.5 15V8.5H1V15z"/>
			</svg>
				<span>진료과전체</span>
				</button></a>
			</div>
		</div>
		 <div class="bd-example-snippet bd-code-snippet">
  <div class="bd-example m-0 border-0">
    
        <nav>
          <div class="nav nav-tabs mb-3" id="nav-tab" role="tablist">
            <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">진료과안내</button>
            <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">의료진</button>
          </div>
        </nav>
        <div class="tab-content" id="nav-tabContent">
          <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
            <div class="introduction-deptInfo" >
			<h1 style="margin-top: 30px; font-size: 25px;">소개</h1><br>
			<h2 style="margin-top: 30px; color: #3378c1; font-size: 19px;">상부위장관</h2>
			<span>
			삼성서울병원 소화기내과에서는 2010년 한 해 동안 진단 목적의 상부위장관 내시경을 41,376건 시행하였습니다. 또한 상부위장관 출혈에 대한 내시경적 지혈술과 양성 위용종에 대한 내시경적 절제술은 2010년 한 해 동안 각각 471건, 151건을 시행하였습니다.<br>
			최근 조기 위암 및 위전암성 병변의 치료술로 각광받고 있는 내시경 점막하 박리술 역시 2004년 도입 이후 꾸준히 시술 건수가 증가하여 2010년에는 716건을 시행하였습니다.<br>
			내시경 점막하 박리술은 일반 내시경 절제술과는 달리 크기에 관계 없이 병변의 일괄절제가 가능하며 적응증이 되는 병변의 경우 수술과 대등한 생존율을 보인다고 보고되어 있습니다. 또한 내시경 점막하 박리술은 개복 등의 침습적인 시술을 피할 수 있고 시술 후 바로 일상 생활이 가능하여 수술과 비교할 때 삶의 질 면에서 우월하다고 알려져 있습니다.<br>
			</span>
			<h2 style="margin-top: 30px; color: #3378c1; font-size: 19px;">간</h2>
			<span>
			췌담도 소화기 내과에서는 환자를 먼저 생각하는 따뜻한 마음과 다양한 검사를 이용한 정확한 진단 및 최첨단의 내시경을 통한 적절한 시술을 기반으로 췌장 및 담도계 질환의 진단 및 치료를 수행하고 있습니다.
췌장암, 담낭암, 담도암, 십이지장암, 유두부 팽대암 등의 암과 더불어 담석 질환, 담낭 용종, 췌장 낭성 병변, 췌장염 등의 양성 질환까지 모든 췌장 및 담도 질환에 대한 정확한 진단 및 치료를 하고 있습니다. 효과적인 환자 중심의 진단 및 치료를 위하여 외과, 영상의학과, 치료방사선과, 병리과, 종양내과 등의 다양한 분야의 전문의들과 상호 협력적인 진료를 하고 있습니다.
췌담도 소화기내과 교수를 포함한 의료진이 연간 약 2,000명의 암환자를 포함하여 약 15,000명의 환자를 외래에서 진료하고 있으며 약 2,000명의 입원 환자를 돌보고 있습니다. 3명의 숙련된 췌담도 내시경 의사가 70% 이상이 치료 내시경으로 구성된 연간 2,000여건의 ERCP 및 EUS 기반 내시경을 시행하고 있습니다. 이러한 내시경에는 endoscopic ultrasound guided fine needle aspiration or biopsy, endoscopic ultrasound guided therapy, photodynamic therapy, endoscopic biliary stenting, endoscopic papillectomy 등의 최첨단 치료가 포함되어 있으며, 새로운 치료에 대한 지속적인 연구를 수행하고 있습니다. 이러한 다양한 임상적 경험과 연구를 토대로 췌장 및 담관계 분야에서 국내외 최고 수준의 진료를 하고 있습니다.
			</span>
			<h2 style="margin-top: 30px; color: #3378c1; font-size: 19px;">췌담도</h2>
			<span>
			간질환으로는 급 · 만성 간염, 알콜성 및 비알콜성 지방간염, 양성 간종양, 간경변 및 간암 등을 다루고 있으며, 매년 50,000여명의 외래환자와 5,000여 명의 입원 환자를 진료하고 있습니다.
이 중 간암 환자는 약 25,000여명으로, 간동맥 화학 색전술, 고주파 열치료법, 방사선 치료, 항암 치료 등을 시행하고 있습니다. 간암 치료의 가장 많은 비중을 차지하는 간동맥 화학 색전술의 경우 매년 2,500여 건, 고주파 열치료법의 경우에는 700여건이 시행되고 있으며, 2011년 4월에는 국내 최초로 고주파 열치료법 5,000건을 돌파하기도 하였습니다. 이외에도 B형 간염, C형 간염의 항바이러스제 치료 및 간세포암에 대한 국내외 임상 시험을 주도하고 있으며, 그 결과를 해외 유명 잡지에 출판한 바 있습니다.
			</span>
			<h2 style="margin-top: 30px; color: #3378c1; font-size: 19px;">하부위장관</h2>
			<span>
			국내 최고 의료진으로 구성된 삼성서울병원 소화기내과 하부위장관 팀은 숙련된 고난도 내시경 술기와 풍부한 경험 및 지식을 바탕으로 대장과 소장의 다양한 질환을 빠르고 정확하게 진단함으로써 환자에 적합한 최적의 치료를 제공하고 있습니다.
최근에는 고난도 내시경 술기를 요하는 대장의 전암성 병변과 조기 대장암에 대해 당일 진료 및 장 정결이 되어 있는 경우 당일 시술을 시행함으로써 환자의 불편감과 불안감을 최소화 하였을 뿐 아니라 수술이 필요한 경우 외과와의 유기적 협진 체계를 통해 수술적 치료가 바로 이루어질 수 있는 시스템을 구축하였습니다.
또한 캡슐내시경 및 소장내시경검사를 통해 그 동안 진단과 치료가 어렵게 느껴졌던 소장질환에 대해서도 빠른 진단과 최적의 치료를 제공하고 있을 뿐 아니라, 대장폐색이 있는 경우 스텐트 삽입술 또는 풍선 확장술 등을 통해 수술은 피하면서 삶의 질은 개선시키는 치료 내시경 시술을 시행하고 있습니다.
최근 증가추세를 보이고 있는 염증성장질환에 있어서도 풍부한 임상경험과 다양한 임상연구를 통해 축적된 지식을 바탕으로 환자에 적합한 치료를 제공하고 있을 뿐 아니라, 주기적으로 염증성장질환에 대한 설명회를 개최함으로써 환자와 보호자의 질환에 대한 이해를 돕고 환자와 의사간의 유대관계를 더욱 견고히 하여 함께 질환을 이겨나갈 수 있도록 최선을 다하고 있습니다.
			</span>
			<h2 style="margin-top: 30px; color: #3378c1;">&nbsp</h2><br>
			</div>
          </div>
          <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
            <div class="introduction-deptInfo">
			<div class="introduction-search">
			<!-- <input class="form-control-search" type="search" id="searchQuery" placeholder="Search" aria-label="Search" >
		      <button class="btn btn-outline-success" type="submit">
		      	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
					<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
				</svg>
		      </button> -->
		      <input type="text" name="searchQuery" id="searchQuery" placeholder="의료진명을 입력하세요." autocomplete="off"/>
					    <button class="buttonResermain" type="button" onclick="searchDoctorInfo()" style="background-color: #3378c1; border: 0;">
							<svg id="SearchButtonResermain" xmlns="http://www.w3.org/2000/svg" width="14" height="14" style="background-color: #3378c1; color: white;"  class="bi bi-search" viewBox="0 0 16 16">
								<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
						</button>
			</div>
			
          </div>
        </div>
        
  </div>
</div>
		
		<!-- <ul class="introduction-info" style="list-style-type: none; padding: 10px;">
			<li><a class="intro-head" onclick="deptDetailInfo_Page1">진료과안내</a></li>
			<li><a class="intro-head" onclick="deptDetailInfo_Page2">의료진</a></li>
		</ul>
		<div class="introduction-deptInfo">
			<h1>소개</h1><br>
			<span>
			삼성서울병원 소화기내과에서는 2010년 한 해 동안 진단 목적의 상부위장관 내시경을 41,376건 시행하였습니다. 또한 상부위장관 출혈에 대한 내시경적 지혈술과 양성 위용종에 대한 내시경적 절제술은 2010년 한 해 동안 각각 471건, 151건을 시행하였습니다.<br>
			최근 조기 위암 및 위전암성 병변의 치료술로 각광받고 있는 내시경 점막하 박리술 역시 2004년 도입 이후 꾸준히 시술 건수가 증가하여 2010년에는 716건을 시행하였습니다.<br>
			내시경 점막하 박리술은 일반 내시경 절제술과는 달리 크기에 관계 없이 병변의 일괄절제가 가능하며 적응증이 되는 병변의 경우 수술과 대등한 생존율을 보인다고 보고되어 있습니다. 또한 내시경 점막하 박리술은 개복 등의 침습적인 시술을 피할 수 있고 시술 후 바로 일상 생활이 가능하여 수술과 비교할 때 삶의 질 면에서 우월하다고 알려져 있습니다.<br>
			</span>
		</div> -->
	</div>
</div>
	<%@include file ="/resources/footer/footer.jspf" %>
</body>
</html>