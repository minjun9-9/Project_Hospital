<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/minjun_css/deptSearch.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="icon" href="/favion.ico" type="image/x-icon"">
<style>
   
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file ="/resources/header/header.jspf" %>
<script>
window.onload = function() {
    // URL에서 "initial" 파라미터를 추출
    const urlParams = new URLSearchParams(window.location.search);
    const initial = urlParams.get('initial');  // "initial" 파라미터 값 읽기

    // 초성에 맞는 부서만 필터링
    filterDepartments(initial || '');  // 만약 "initial" 파라미터가 없다면 전체 부서 표시

    const refreshButton = document.querySelector('.button.button-initial[onclick="filterDepartments(\'refresh\')"]');
    if (refreshButton) {
        refreshButton.addEventListener('click', function() {
            filterDepartments('');  // 리프레시 버튼 클릭 시 모든 부서 표시
        });
    }
};

// 초성 추출 함수
function getInitialConsonant(text) {
    const firstChar = text.charAt(0); // 첫 번째 문자 추출
    const code = firstChar.charCodeAt(0); // 문자 코드 값 얻기

    const startCode = 44032; // '가'의 유니코드 값
    const initialConsonantsCount = 19;  // 초성 개수
    const vowelCount = 21;              // 중성 개수
    const finalConsonantCount = 28;     // 종성 개수
    
    if (code >= startCode && code <= 55203) {
        // 초성 추출
        const initialIndex = Math.floor((code - startCode) / (vowelCount * finalConsonantCount));
        const initials = ['ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ', 'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ', 'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ'];
        return initials[initialIndex]; // 초성을 반환
    }
    return ''; // 한글이 아닌 경우 빈 문자열 반환
}

// 부서 구분
function filterDepartments(initial) {
    let items = document.querySelectorAll('.card-item');
    let anyVisible = false;
    items.forEach(item => {
        let deptName = item.querySelector('.field-title').innerText.trim();
        let deptInitial = getInitialConsonant(deptName); 

        if (initial === 'refresh' || deptInitial === initial || initial === '') {
            item.style.display = 'block';
            anyVisible = true;
        } else {
            item.style.display = 'none';  
        }
    });

    if (!anyVisible && initial !== 'refresh') {
        console.log(`빈공간 처리해야함 ` + initial);
    }
}
</script>


</head>
<body>
<div class="container">
	
	<!-- 후에 이거로 만들어야 함 -->
	<%-- <div class="card-list-wrapper">
			<div class="card-list list-column6 list-parts-menu">
				<ul class="masonry">
					<li class=""card-item parts-counsel-card">
							<div class="card-content">
								<section class="card-item-inner">
									<div class="" aria-hidden="true">
										<img src="${pageContext.request.contextPath }/resources/images/내과.jpg" alt="내과이미지" />
									</div>
									<div class="card-content-textarea">
										<h3 class="field-title" data-name="내과">
											내과
										</h3>
									</div>
								</section>
							</div>
							
					</li>
				</ul>
			</div>
	</div> --%>
<!-- </div> -->
	<!-- <div class="inner-wrap clearfix" > -->
<!-- <section id="contents" style="position: relative; width: 100%; padding: 0 0 240px 0;">
	<div class="part-search">

		<section class="initial-search initial-search-type02" >
				<form method="post" action="">
					<div class="initial-search-box">
						<div class="initial-search-head">
							<span class="initial-search-title" 
							style="padding-right: 10px; color: #1b1d21; font-size: 22px; font-weight: normal; letter-spacing: -1px; vertical-align: middle; white-space: nowrap;"
							>
							초성검색</span>
							<span class="initial-search-description">원하시는 진료과의 초성을 선택해 주세요.</span>
						</div>
			
						<div class="button-container">
									<button type="button" class="button button-initial " >ㅎ</button>
									<button type="button" class="button button-initial" >
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
									  <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
									  <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
									</svg>
									</button>
						</div>
			
					</div>
				</form>
			</section>
		</div>
	</section> -->
	<!-- 부서 목록 출력 -->
        <div class="card-list-wrapper">
        <div class="part-search" style="margin-top: 30px;">

		<section class="initial-search initial-search-type02">
			<form method="post" action="">
				<div class="initial-search-box">
					<div class="initial-search-head" style="margin-left: 20px;">
						<span class="initial-search-title"
							style="padding-right: 10px; color: #1b1d21; font-size: 22px; font-weight: normal; letter-spacing: -1px; vertical-align: middle; white-space: nowrap; align-content: center; align-items: center; justify-content: center;">
							초성검색</span> <span class="initial-search-description">원하시는 진료과의
							초성을 선택해 주세요.</span>
					</div>

					<div class="button-container">
						<button type="button" class="button button-initial" onclick="filterDepartments('ㄱ')"><span>ㄱ</span></button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㄴ')">ㄴ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㄷ')">ㄷ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㄹ')">ㄹ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅁ')">ㅁ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅂ')">ㅂ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅅ')">ㅅ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅇ')">ㅇ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅈ')">ㅈ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅊ')">ㅊ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅋ')">ㅋ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅌ')">ㅌ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅍ')">ㅍ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('ㅎ')">ㅎ</button>
						<button type="button" class="button button-initial" onclick="filterDepartments('refresh')">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								fill="currentColor" class="bi bi-arrow-clockwise" style="color: #3378c1; font-weight: bold;"
								viewBox="0 0 16 16">
									  <path fill-rule="evenodd"
									d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z" />
									  <path
									d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466" />
									</svg>
						</button>
					</div>

				</div>
			</form>
		</section>
	</div>
            <div class="card-list">
                <ul class="masonry" style="display: flex; width: 100%; margin-top: 30px;">
                    <!-- 부서 목록을 동적으로 출력 -->
                    <c:forEach var="dept" items="${deptList}">
                        <li class="card-item parts-counsel-card">
                            <a href="<%= request.getContextPath() %>/reservation/deptDetailInfo">
                                <article class="card-content">
                                    <section class="card-item-inner">
                                        <div class="card-content-img" aria-hidden="true">
                                            <!-- 과 이름에 맞는 이미지로 교체 -->
                                            
                                            <img src="<%= request.getContextPath() %>/resources/images/${dept.deptName}.jpg" alt="기본 이미지" onError="this.onerror=null; this.src='<%= request.getContextPath() %>/resources/images/no_image.jpg'"/>
                                        </div>
                                        <div class="card-content-textarea">
                                            <h3 class="field-title" data-name="${dept.deptName}">
                                                ${dept.deptName}
                                            </h3>
                                        </div>
                                    </section>
                                </article>
                            </a>
                            <div class="part-menu">
                                <div class="part-menu-title">
                                    <div class="part-menu-title-inner">
                                        <span class="field-title">${dept.deptName}</span>
                                    </div>
                                </div>
                                <div class="part-menu-item">
                                    <div class="part-menu-item-inner">
                                        <span class="menu-item"><a href="#" class="menu-item">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
                                                <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.24 2.24 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.3 6.3 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5"/>
                                            </svg>
                                            진료과소개</a></span>

                                        <span class="menu-item"><a href="<%=request.getContextPath() %>/reservation/reservationInsert?hpId=SSW&userNum=${sessionScope.user.userNum}" class="menu-item">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                                <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325"/>
                                            </svg>
                                            진료예약</a></span>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
		</div>
<!-- </div> -->
<%@include file ="/resources/footer/footer.jspf" %>
</body>
</html>