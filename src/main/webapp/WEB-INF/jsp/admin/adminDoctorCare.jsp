<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>의료진 관리</title>
<style>
	.modalTable .hiddenRow { visibility: hidden }
	.modalTable { font-size: 14px; }
	#profileTable { border: 1px solid black; }
	#profileTableImg th { 
		border-left: 1px solid black; 
		margin-bottom: 2px;
	}
	#profileTableImg th:first-child, #profileTableText th:first-child { border-left: none; }
	#profileTableImg img { width: 200px; height: 230px; }
	#profileTableText th { 
		border-left: 1px solid black;
		border-top: 1px solid black; 
		padding-top: 3px;
	}
	#searchResults {
	    z-index: 1000;
	    max-height: 200px;
	    overflow-y: auto;
	    background-color: white;
	    border: 1px solid #ddd;
	    border-top: none;
	    border-radius: 0 0 4px 4px;
	    margin-left: 0;
   	    margin-right: auto;
	}
	#searchResults li {
	    padding: 10px;
	    cursor: pointer;
	    font-size: 15px;
	}
	#searchResults li:hover {
	    background-color: #f8f9fa;
	}
	#searchInput {
	    border-bottom-right-radius: 0;
	}
	#searchResults {
	    border-top-right-radius: 0;
	}
	.resetImg {
		width: 5%;
		height: 60px;
	}
	.resetImg:hover {
		cursor: pointer;
	}
</style>
	<script>
		let loginType = '${resultDto.type}';
		let loginDrId = '${resultDto.drId}';
	</script>
	<!-- 부트스트랩 링크  -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<!-- 받은 파일 링크  -->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/top-right.css" />
	<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/design.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/admin/calendar.js" defer></script> <!-- 달력 스크립트 -->
	<script src="${pageContext.request.contextPath }/resources/js/admin/main.js" defer></script> <!-- 메인동작  -->

</head>


<body>
<!-- 부트스트랩 modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title" id="exampleModalLabel" style="font-size: 18px;">의료진 상세</h3>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="container-fluid">
      		<div>
		    	<table id="profileTable">
		    		<tr id="profileTableImg">
		    			<th><img src="#" alt="profile" class="profileImg"></th>
		    			<th><img src="#" alt="profile" class="profileImg"></th>
		    			<th><img src="#" alt="profile" class="profileImg"></th>
		    		</tr>
		    		<tr id="profileTableText">
		    			<th class="text-center profileText">프로필 이미지 없음</th>
		    			<th class="text-center profileText">프로필 이미지 없음</th>
		    			<th class="text-center profileText">프로필 이미지 없음</th>
		    		</tr>
		    	</table>
		    </div>
		    
		    <br><br>
		    <div class="col-sm-12">
		        <div class="row">
		        	<div style="width: 35%;">
		          		<table class="modalTable">
			          		<colgroup>
								<col width="55px">
								<col width="10px">
								<col width="280px">
							</colgroup>
							<tbody id="modalTbody1"></tbody>
		          		</table>
					</div>
		        	<div style="width: 65%;">
		        		<table class="modalTable">
		        		<colgroup>
							<col width="55px">
							<col width="10px">
							<col width="300px">
						</colgroup>
							<tbody id="modalTbody2"></tbody>
			        	</table>
		       		</div>
		     	</div>
		    </div>
		    <!-- 전문과목, 경력, 학회, 수상, 파일처리 -->
		    <br><br>
		    <div class="col-sm-12">
		    	<table class="modalTable">
		    		<colgroup>
						<col width="55px">
						<col width="10px">
						<col width="400px">
					</colgroup>
					<tbody id="modalTbody3"></tbody>
		    	</table>
		    </div>
      	</div>
      </div>
      <input id="drIdHidden" type="hidden" value="">
      <div class="modal-footer d-flex">
		  <div class="d-flex justify-content-center w-100">
		  	<button type="button" id="updateDrInfo" class="btn btn-info me-2">
		  		<img src="${pageContext.request.contextPath}/resources/images/pencil.png"><span class="ms-1">수정</span>
		    </button>
		    <button type="button" id="deleteDrInfo" class="btn btn-warning">
		  		<img src="${pageContext.request.contextPath}/resources/images/delete.png"><span class="ms-1">삭제</span>
		    </button>
		  </div>
		  <button type="button" class="btn btn-secondary ms-auto" data-bs-dismiss="modal">닫기</button>
	  </div>
    </div>
  </div>
</div>
<!-- -------------- 부트스트랩 modal 끝 -------------- -->

<!-- main content -->
<div id="content" class="body_wrap">
		<!-- 사이드바 -->
		<%@ include file="WEB-INF/../../common/sidebar.jspf"%>

	<!-- content시작 -->
	<div class="content">
		<!-- 헤더 -->
		<div class="top_bar bg_w">
			<a href="#" class="top_left doctor_con"><span>의료진 관리</span></a>
			<!-- 탑바 컨텐츠 -->
			<%@ include file="WEB-INF/../../common/topbarContent.jspf"%>
		</div>

		<div class="con_wrap bg_13">
			<!-- main content시작 -->
			<div class="doc_list bg_w">
				<!-- 검색  -->
				<div class="container-fluid mb-3" style="width: 70%; margin-left: 0%; padding-left: 0px; padding-right: 0px;">
					<div class="d-flex align-items-center" style="height: 70px;">
						 <!-- 라디오 버튼 그룹 -->
						 <div class="d-flex align-items-center p-3 me-2 radioDiv">
						     <div class="form-check form-check-inline d-flex align-items-center me-3">
						     	<input class="form-check-input radioInput" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="name" checked style="width: 20px; height: 20px;">
						     	<label class="form-check-label ms-2 text-nowrap" for="inlineRadio1" style="font-size: 1.2rem;">성명</label>
						     </div>
						     <div class="form-check form-check-inline d-flex align-items-center me-3">
						     	<input class="form-check-input radioInput" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="dept" style="width: 20px; height: 20px;">
						     	<label class="form-check-label ms-2 text-nowrap" for="inlineRadio2" style="font-size: 1.2rem;">진료과</label>
						     </div>
						     <div class="form-check form-check-inline d-flex align-items-center me-3">
						     	<input class="form-check-input radioInput" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="field" style="width: 20px; height: 20px;">
						     	<label class="form-check-label ms-2 text-nowrap" for="inlineRadio3" style="font-size: 1.2rem;">전문과목</label>
						     </div>
					     </div>
				    	<div class="flex-grow-1 me-2 position-relative" >
				    		<input class="form-control me-2 py-3" id="searchInput" type="search" placeholder="의료진 검색" aria-label="Search">
				    		<ul class="list-group position-absolute w-100 d-none" id="searchResults" style="top: calc(100% + 2px);">
				    		</ul>
				    	</div>
				    	<button class="btn btn-outline-primary text-nowrap py-3" id="searchBtn" type="button" style="width: 12%;">
				    		<img src="${pageContext.request.contextPath }/resources/images/ico_search.png" class="me-1">검색
				    	</button>
				    	<img src="${pageContext.request.contextPath}/resources/images/reset_image5.png"
						            		 class="ms-2 resetImg">
				   </div>
			    </div>
				<div class="list_mid mb-2">
					<span class="subtit f_s20 f_w700">의료진 목록</span>
					<div class="mid_btn">
						<button type="button" class="btn btn-primary" onclick="goDrRegister()">의료진 등록</button>
					</div>
				</div>
	<!-- drId; drPw; deptId; drPosition; drName; drPhoneNum; drAddress; drField; drEducation; drCareer; drAcademic; drAwards; drPersonNum; -->
			  <!-- 테이블 데이터 표시 항목 -->
			  <table class="table table-hover border-top " style="line-height: 2; font-size: 16px;">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="15%">
						<col width="35%">
						<col width="10%">
						<col width="15%">
					</colgroup>
					<thead class="table-light" style="background-color: #F2F5FC;">
				  		<tr> 
							<th scope="col">ID</th>
					    	<th scope="col">성명</th>
					    	<th scope="col">직책</th>
					    	<th scope="col">진료과</th>
					    	<th scope="col">전문과목</th>
					    	<th scope="col">일정</th>
					    	<th scope="col">상세보기</th>
					    </tr>
					</thead>
					<tbody id="drListTbody">
						<c:forEach var="drInfo" items="${drInfoList }">
							<tr class="doctorList">
								<td>${drInfo.drId }</td>
								<td>${drInfo.drName }</td>
								<td>${drInfo.drPosition }</td> <!-- 통합이후 수정함 -->
								<td>${drInfo.deptName }</td>
								<td>${drInfo.drField }</td>
								<!-- 달력 클릭 -->
								<td><a class="mask_calendar" id="${drInfo.drId }" style="cursor: pointer;"><img src="${pageContext.request.contextPath }/resources/images/caldendar_blue.png"></a></td>
								<!-- 상세보기(모달) -->
								<td>
									<a class="modalBtns" data-bs-toggle="modal" data-bs-target="#exampleModal" style="cursor: pointer;">
										<img src="${pageContext.request.contextPath }/resources/images/view_all.png" style="width: 25px;">
										<input type="hidden" value="${drInfo.drId }">
									</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
			  </table>
			  <!-- 페이징 버튼 -->
			  <nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<c:if test="${paging.nowBlock == 1 }">
							<li class="page-item disabled">
					    		<a class="page-link" href="#" tabindex="-1" aria-disabled="true">
					    			<img src="${pageContext.request.contextPath }/resources/images/first_page.png">
					    		</a>
					 		</li>
						</c:if>
						<c:if test="${paging.nowBlock != 1 }">
							<li class="page-item">
					    		<a class="page-link" href="adminDoctorCare?cPage=1">
					    			<img src="${pageContext.request.contextPath }/resources/images/first_page.png">
					    		</a>
					 		</li>
				 		</c:if>
						<c:if test="${paging.beginPage == 1 }">
					  		<li class="page-item disabled">
					    		<a class="page-link" href="#" tabindex="-1" aria-disabled="true">
					    			<img src="${pageContext.request.contextPath }/resources/images/prev_page.png">
					    		</a>
					 		</li>
				 		</c:if>
				 		<c:if test="${paging.beginPage != 1 }">
					  		<li class="page-item">
					    		<a class="page-link" href="adminDoctorCare?cPage=${paging.beginPage - 1 }">
					    			<img src="${pageContext.request.contextPath }/resources/images/prev_page.png">
					    		</a>
					 		</li>
				 		</c:if>
				 		<c:forEach var="pageNum" begin="${paging.beginPage }" end="${paging.endPage }">
					 		<c:if test="${pageNum == paging.nowPage }">
					  			<li class="page-item page-link text-dark">${pageNum }</li>
					  		</c:if>
					  		<c:if test="${pageNum != paging.nowPage }">
					  			<li class="page-item"><a class="page-link" href="adminDoctorCare?cPage=${pageNum }">${pageNum }</a></li>
					  		</c:if>
				  		</c:forEach>
				  		<c:if test="${paging.endPage >= paging.totalPage }">
					  		<li class="page-item disabled">
					    		<a class="page-link" href="#" tabindex="-1" aria-disabled="true">
					    			<img src="${pageContext.request.contextPath }/resources/images/next_page.png">
					    		</a>
					 		</li>
				 		</c:if>
				 		<c:if test="${paging.endPage < paging.totalPage }">
					  		<li class="page-item">
					    		<a class="page-link" href="adminDoctorCare?cPage=${paging.endPage + 1 }">
					    			<img src="${pageContext.request.contextPath }/resources/images/next_page.png">
					    		</a>
					 		</li>
				 		</c:if>
				 		<c:if test="${paging.nowBlock >= paging.totalBlock }">
				 			<li class="page-item disabled">
					    		<a class="page-link" href="#" tabindex="-1" aria-disabled="true">
					    			<img src="${pageContext.request.contextPath }/resources/images/last_page.png">
					    		</a>
					 		</li>
				 		</c:if>
				 		<c:if test="${paging.nowBlock < paging.totalBlock }">
					 		<li class="page-item">
					    		<a class="page-link" href="adminDoctorCare?cPage=${paging.totalPage }">
					    			<img src="${pageContext.request.contextPath }/resources/images/last_page.png">
					    		</a>
					 		</li>
				 		</c:if>
					</ul>
			 </nav>

			</div>
		</div>
		<div class="footer bg_13 f_s15">2025 ITWIll Medical Center All right Reserved.</div>
	</div>
</div>

<!-- 달력  mask -->
<div class="mask">
		<div class="mask_con bg_w">
			<div class="btn_x"><img src="${pageContext.request.contextPath }/resources/images/x_btn.png" alt="close"></div>
			<p class="mask_tit">일정관리</p>
			<div class="table_top">
				<ul class="f_w500 f_s15 bg_13">
					<li><span class="bul_sche sche01">정상진료</span></li>
					<li><span class="bul_sche sche02">휴진-진료없음</span></li>
					<li><span class="bul_sche sche03">정원초과</span></li>
				</ul>
				<div class="mask_date">
					<select id="year" name="year" onchange="selectYear()">
						
					</select>
					<select id="month" class="month" onchange="selectMonth()">
						<option value="1">01월</option>
						<option value="2">02월</option>
						<option value="3">03월</option>
						<option value="4">04월</option>
						<option value="5">05월</option>
						<option value="6">06월</option>
						<option value="7">07월</option>
						<option value="8">08월</option>
						<option value="9">09월</option>
						<option value="10">10월</option>
						<option value="11">11월</option>
						<option value="12">12월</option>
					</select>
				</div>
			</div>
			<table class="table_sty02">
				<caption>의료진 일정관리 달력</caption>
				<colgroup>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
				</colgroup>
				<thead>
					<tr>
						<th class="red">일</th>
						<th>월</th>
						<th>화</th>
						<th>수</th>
						<th>목</th>
						<th>금</th>
						<th class="blue">토</th>
					</tr>
				</thead>

				<tbody>
					<tr>
						<!-- 특정요일 전체 일괄적용 선택란 -->
						<c:forEach var="i" begin="0" end="6" step="1">
							<td>
								<div class="am">
									<p>오전</p>
									<select name="mask_selc" id="totalDayAM${i }" onchange="selectedDayUpdate(this)">
										<option value="0">일괄</option>
										<option value="1">&#9679;</option>
										<option value="2">&#9678;</option>
										<option value="3">&#9675;</option>
									</select>
								</div>
								<div class="pm">
									<p>오후</p>
									<select name="mask_selc" id="totalDayPM${i }" onchange="selectedDayUpdate(this)">
										<option value="0">일괄</option>
										<option value="1">&#9679;</option>
										<option value="2">&#9678;</option>
										<option value="3">&#9675;</option>
									</select>
								</div>
							</td>
						</c:forEach>
					</tr>
					
					<!-- 
						첫째주 1일 요일 확인해서 뿌리기
						7번 돌리기
						나머지에 따른 빈칸 생성 후 날짜 기입? 
					-->
					<!-- 첫째주 -->	
					<tr id="firstWeek" class="bg_13"></tr>
					<tr id="firstWeekChoice"></tr>

					<!-- 둘째주 -->
					<tr id="secondWeek" class="bg_13"></tr>
					<tr id="secondWeekChoice"></tr>

					<!-- 셋째주 -->
					<tr id="thirdWeek" class="bg_13"></tr>
					<tr id="thirdWeekChoice"></tr>

					<!-- 넷째주 -->
					<tr id="fourthWeek" class="bg_13"></tr>
					<tr id="fourthWeekChoice"></tr>

					<!-- 다섯주 -->
					<tr id="lastWeek" class="bg_13"></tr>
					<tr id="lastWeekChoice"></tr>

					<!-- 혹시모를째주 -->
					<tr id="fifthWeek"  class="bg_13"></tr>
					<tr id="fifthWeekChoice"></tr>


				</tbody>
			</table>
			<a class="mask_btn bg_2 f_s16 f_w600" onclick="updateCalendar()" style="cursor: pointer;">적용하기</a>
			<a class="reset c_78 f_s15 f_w400" onclick="resetCalendar()" style="cursor: pointer;">초기화</a>
		</div>

		<div class="mask2">
			<div class="mask2_con bg_w">
				<div class="btn_x2"><img src="${pageContext.request.contextPath }/resources/images/x_btn.png" alt="close"></div>
				<p class="mask_tit">상세일정 예약여부</p>
				<div class="table_top">
					<ul class="f_w500 f_s15 bg_13">
						<li><span class="bul_sche sche01">정상진료</span></li>
						<li><span class="bul_sche sche03">예약완료</span></li>
					</ul>
					<div class="mask_date">
						<span>선택일 </span>
						<select id="day" class="day" onchange="selectDay(this)">
							
							<option value="0">선택일</option>
						</select>
					</div>
				</div>
				<table class="table_sty02">
					<caption>의료진 일정관리 달력</caption>
					<colgroup>
						<col>
						<col>
						<col>
						<col>
						<col>
						<col>
						<col>
					</colgroup>
					<thead>
						<tr>
							<th colspan="4">오전</th>
							<th colspan="4">오후</th>
						</tr>
					</thead>
	
					<tbody id="detailTbody">
						


					</tbody>
				</table>
				
			</div>
		</div>
</div>

<!-- 부트스트랩 링크  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
	// 사이드바 토글 움직임
	document.querySelector('.drul').classList.add('on');
	document.querySelector('.drliCare').classList.add('on');
	
</script>	
</body>
</html>