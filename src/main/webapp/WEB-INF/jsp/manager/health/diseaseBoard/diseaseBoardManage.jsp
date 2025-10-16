<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/minseo_css/default.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/top-right.css" />
	<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/design.js"></script>
<title>(관리자) 건강 정보 : 센텀 기반 수정본</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>

<style>
	#thumbnail-disp {
		width: 490px;
    	height: 400px;
    	overflow: hidden;
	}
	#thumbnail-disp img {
		width: 100%;
   	 	height: 100%;
   	 	object-fit: contain; 
	}
	#cntBox {
		width: 250px;
		margin-right: 300px;
	}
	#currentCnt {
		padding-left: 10px;
	}
	#totalCount {
		margin-right: 50px;
	}
	.full-clickable {
    display: block; /* a 태그를 블록 요소로 설정 */
    width: 100%;   /* 부모 div 전체 너비 사용 */
    height: 100%;  /* 부모 div 전체 높이 사용 */
    text-decoration: none; /* 링크 밑줄 제거 */
    color: inherit; /* 텍스트 색상 상속 */
	}
	
	/*전체, 오늘, 1주, 1개월 오른쪽 정렬*/
	#termSearchBtn-container{
		position: absolute;
   		 right: 0;
	}
	
	.left_up .find_box {
		gap: 20px;
		border: 1px solid #E0E7F3;
		width: 250px;
		height: 50px;
		padding: 15px 20px;
		display: flex;
		box-sizing: border-box;
		justify-content: space-between;
		align-items: center;
    }
    
	
	.top_right {
	    position: relative;
	}
	.dropdown-menu-noBoot {
	    display: none;
	    position: absolute;
	    top: 120%;
	    right: 0;
	    background-color: white;
	    border: 1px solid #ccc;
	    border-radius: 8px;
	    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
	    min-width: 150px;
	    z-index: 1000;
	}
	.dropdown-menu-noBoot a {
	    display: block;
	    padding: 10px;
	    color: #333;
	    text-decoration: none;
	}
	.dropdown-menu-noBoot a:hover {
	    background-color: #f0f0f0;
	}
	.name:hover {
	    text-decoration: underline;
	}

	#diseaseBoardListTbody > tr > td {
		font-size: 16px;
	}
</style>

</head>
<body>

	<div class="body_wrap">
		<!-- 사이드바 -->
		<%@ include file="WEB-INF/../../../../common/sidebar.jspf"%>
		
		<!-- 컨텐츠 시작  -->
		<div class="content">
			<div class="top_bar bg_w">
				<a href="#" class="top_left health_con" id="boardManageBtn"><span>건강 게시판 관리</span></a>
				<!-- 탑바 right 컨텐츠-->
				<%@ include file="WEB-INF/../../../../common/topbarContent.jspf"%>
			</div>
			<div class="con_wrap bg_13">
				<!-- content시작 -->
				<div class="tab03_wrap normal bg_w">
				
				
					<!-- tab1 질환 게시판 -->
					<div class="tab03_li on" data-tab="tab1">
						<a href="#" class="full-clickable"><p class="tab03_btn f_w700 f_s17 c_3 bor_2">질환 게시판 <!-- <span class="bg_w">+15</span> --></p> </a>
						<div class="tab03_con">
							<div class="tab03_top">
								<div class="top_left">
									<div class="left_up">
										<div class="find_box bg_8">
											<label for="search" class="f_s16 f_w500"><input type="radio" name="classification" value="body" checked>신체</label>
											<label for="search" class="f_s16 f_w500"><input type="radio" name="classification" value="disease">질환</label>
										</div>
											<select name="bodyPartId" id="selectBox-body" >
												<option value="-1" selected disabled hidden="">신체 분류</option>
												<c:forEach var="body" items="${bodyClassificationList}">
													<option value="${body.bodyPartId }" >${body.bodyPartName}</option>
												</c:forEach>
											</select>
											<select name="diseasePartId" id="selectBox-disease">
												<option value="-1" selected disabled hidden="">질환 분류</option>
												<c:forEach var="disease" items="${diseaseClassificationList}">
													<option value="${disease.diseasePartId}">${disease.diseasePartName}</option>
												</c:forEach>
											</select>
										<div class="search">
											<a href="#" id="classificationSearchBtn">검색</a>
										</div>
										
										<div class="up_date">
											<p>Date</p>
											<div class="calendar">
												<input type="date" id="start_date">
												<span>-</span>
												<input type="date" id="end_date">
											</div>
											<ul>
												<li class="bor_2"><a href="#" id="apply">날짜 검색</a></li>
												<li class="bor_2"><a href="#" id="apply_reset">날짜 초기화</a></li>
											</ul>
											<ul id="termSearchBtn-container">
												<li class="bor_2 on"><a href="#" class="termSearchBtn" data-term="all">전체</a></li>
												<li class="bor_2"><a href="#" class="termSearchBtn" data-term="oneDay">오늘</a></li>
												<li class="bor_2"><a href="#" class="termSearchBtn" data-term="oneWeek">1주</a></li>
												<li class="bor_2"><a href="#" class="termSearchBtn" data-term="oneMonth">1개월</a></li>
											</ul>
										</div>
									</div>
									<div class="left_down">
										<div class="find_box bg_8">
											<label for="search" class="f_s16 f_w500"><input type="radio" name="topic" value="title" checked>제목만</label>
											<label for="search" class="f_s16 f_w500"><input type="radio" name="topic" value="content">내용만</label>
										</div>
										<div class="search">
											<input type="text" class="search_box" placeholder="Search" id="search_input">
											<a href="#" id="keywordSearchBtn">검색</a>
										</div>
										
									</div>
								</div>
								<div class="top_right">
									<div class="my_box" id="cntBox">
										<p class="f_s14 f_w400"><span class="f_w500">Total</span><span id="currentCnt">/</span><em class="f_w600" id="totalCount">${diseaseBoardTotalCount.totalCount }</em></p>
									</div>
								</div>
							</div>
							<div class="tab03_mid">
								<span class="subtit f_s20 f_w700">질환 게시판 관리</span>
								<div class="mid_btn">
									<!-- <div class="del bor_2 c_3 f_s15 f_w600">삭제</div> -->
									<a href="#" class="del bor_2 c_3 f_s15 f_w600" id="multi_deleteBtn">삭제</a>
									<a href="insertDiseaseBoardPage" class="bg_2 f_w500 f_s15">질환 게시글 등록</a>
								</div>
							</div>
							<table class="table_sty01">
								<caption>질환 게시판 관리</caption>
								<colgroup>
									<col width="80px">
									<col width="200px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
									<col width="80px">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="checkAll"></th>
										<th><span>제목</span></th>
										<th><span>질환 분류</span></th>
										<th><span>신체 분류</span></th>
										<th><span>첨부</span></th>
										<th><span>Date&nbsp;</span><a href="#" id="orderByDateDesc"><img src="${pageContext.request.contextPath }/resources/images/bul_th.png"></a></th>
										<th><span>조회수&nbsp;</span><a href="#" id="orderByCountDesc"><img src="${pageContext.request.contextPath }/resources/images/bul_th.png"></a></th>
										<th><span>수정</span></th>
										<th><span>삭제</span></th>
									</tr>
								</thead>
								<tbody id="diseaseBoardListTbody">
								</tbody>
							</table>
							<div class="table01_paging">
							
								<nav aria-label="...">
									<ul class="pagination">
										<%-- 이전 페이지 번튼  --%>
										<c:if test="${currentPage > 1 }">
											<li class="page-item">
												<a class="page-link" href="#" data-page="${currentPage - 1}">이전페이지</a>
											</li>
										</c:if>
										<c:if test="${currentPage <= 1 }">
											<li class="page-item disabled">
												<a class="page-link" href="#">이전페이지</a>
											</li>
										</c:if>
										
										<%-- 페이지 번호 반복 --%>
										<c:forEach var="p" begin="1" end="${totalPageCount }">
											<c:choose>
												<%-- 현재 페이지인 경우 active 표시 --%>
												<c:when test="${p == currentPage }">
													<li class="page-item active" aria-current="page">
														<a class="page-link" href="#" data-page="${p}">${p}</a>
													</li>
												</c:when>
												<c:otherwise>
													<li class="page-item">
														<a class="page-link" href="#" data-page="${p}">${p}</a>
													</li>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<%-- 다음 페이지 버튼 --%>
										<c:if test="${currentPage < totalPageCount }">
											<li class="page-item">
												<a class="page-link" href="#" data-page=${currentPage + 1 }>다음 페이지</a>
											</li>
										</c:if>
										<c:if test="${currentPage >= totalPageCount }">
											<li class="page-item disabled">
												<a class="page-link">다음페이지</a>
											</li>
										</c:if>
									</ul>
								</nav>
							
							</div>
							
						</div>
						<!-- 썸네일 첨부파일 Modal -->
						<div class="modal fade" id="thumbnailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="exampleModalLabel">썸네일 사진</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <div class="modal-body" id="thumbnail-disp"></div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						        <button type="button" class="btn btn-primary" id="updateBtn">사진 수정하기</button>
						      </div>
						    </div>
						  </div>
						</div>
					</div>
					
					<!-- tab2  검사, 치료 게시판-->
					<div class="tab03_li" data-tab="tab2">
						<a href="examinationBoardManagePage" class="full-clickable"><p class="tab03_btn f_w700 f_s17 c_3 bor_2">검사, 치료 게시판</p></a>
					</div>
					
					
					<!-- tab3 건강 뉴스 게시판-->
					<div class="tab03_li" data-tab="tab3">
						<a href="healthBoardManagePage" class="full-clickable"><p class="tab03_btn f_w700 f_s17 c_3 bor_2">건강 뉴스 게시판</p></a>
					</div>
					
				</div>
			</div>
			<div class="footer bg_13 f_s15">2023 Hanyang University Medical Center All right Reserved.</div>
		</div>
	</div>
	
	
	
<script>
	
	
	// main tab 작동 js!!!!!!
	/*
	$('.tab03_li').click(function () {
	    $('.tab03_li').removeClass('on')
	    $(this).addClass('on')
	})
	*/
	//좌측 상당 누르면 페이지 리로드
	let mainBtn = document.getElementById('boardManageBtn');
	mainBtn.addEventListener('click', function(event) {
		event.preventDefault();
		location.reload();
	});
	
	//모달 사진 수정 버튼 수정 페이지로 연결
	let updateBtn = document.getElementById('updateBtn');
	updateBtn.addEventListener('click', function(event) {
		event.preventDefault();
		
		let diseaseBoardIdFromBtn = updateBtn.getAttribute('data-diseaseBoardId');
		console.log("모달로 넘어온 diseaseBoardId : " + diseaseBoardIdFromBtn);
		location.href="updateDiseaseBoardPage?diseaseBoardId=" + diseaseBoardIdFromBtn;
		
		//dispHtml += "<td><a href='updateDiseaseBoardPage?diseaseBoardId=" + disease.diseaseBoardId + "'><span class='pencil'>수정</span></a></td>";
		
		
	});
	
	//페이지네이션 버튼 눌렀을 때 처리 (이벤트 위임 사용해서 .pagination에 단일 이벤트 리스너 등록)
	document.querySelector('.pagination').addEventListener('click', function(e) {
		if(e.target && e.target.matches('a.page-link')) {
			e.preventDefault();
			const pageNum = e.target.dataset.page;
			if(pageNum) {
				paginationAjax(parseInt(pageNum));
			}
		}
	});
	//페이지 로드시 처리
	document.addEventListener('DOMContentLoaded', function() {
		
		//currentPage값 가져오기
		const currentPage = ${currentPage};
		console.log("DOM로드 후 기본 페이지 : " + currentPage);
		
		//페이지 로드 직후 ajax로 목록 가져오기
		paginationAjax(currentPage);
	});
	
	//페이지네이션 아작스
	function paginationAjax(pageNum) {
		console.log("아작스에서 받은 페이지: " + pageNum);
		
		$.ajax({
			url : "getDiseaseBoardPage/" + encodeURIComponent(pageNum)
			, dataType : "json"
			, method: "get"
			, success : function(data) {
				//1. 목록 업데이트
				 getDiseaseBoardListSuccess(data.boardList);
				
				//2. 페이지네이션 재생성
				renderPagination(data.currentPage, data.totalPageCount);
			}
			, error : function() {
				alert("페이지네이션 구현 실패");
			} 
		});
	};
	
	//페이지네이션 재생성
	function renderPagination(currentPage, totalPageCount) {
		const paginationUl = document.querySelector('.pagination');
		paginationUl.innerHTML = ''; //기존 <li> 제거
		
		//이전페이지 버튼
		if(currentPage > 1) {
			paginationUl.innerHTML += `
			<li class='page-item'>
				<a class='page-link' href='#' data-page='\${currentPage - 1}'>이전페이지</a>
			</li>
			`;
		} else {
			paginationUl.innerHTML += `
			<li class='page-item disabled'>
				<a class='page-link'>이전페이지</a>
			</li>
			`;
		}
		
		//숫자 버튼
		for(let p = 1; p <= totalPageCount; p++) {
			if(p === currentPage) {
				paginationUl.innerHTML += `
				<li class="page-item active" aria-current="page">
					<a class="page-link" href="#" data-page="\${p}">\${p}</a>
				</li>
				`;
			} else {
				paginationUl.innerHTML += `
				<li class="page-item">
					<a class="page-link" href="#" data-page="\${p}">\${p}</a>
				</li>
				`;
			}
		}
		
		//다음페이지 버튼
		if(currentPage < totalPageCount) {
			paginationUl.innerHTML += `
			<li class="page-item">
				<a class="page-link" href="#" data-page='\${currentPage + 1 }'>다음 페이지</a>
			</li>		
			`;
		} else {
			paginationUl.innerHTML += `
			<li class="page-item disabled">
				<a class="page-link">다음 페이지</a>
			</li>		
			`;
		}
		
	}


	const startDateTag = document.getElementById('start_date');
	const endDateTag = document.getElementById('end_date');
	const currentDate = new Date().toISOString().substring(0, 10);
	
	//페이지 로드시
	$(document).ready(function() {
		
		//질환 게시판 전체 글 출력 ajax
		//getDiseaseBoardList();
		
		//- 기본값 오늘 날짜로 설정
		startDateTag.value = currentDate;
		endDateTag.value = currentDate;
		
		//- 최소 날짜 설정
		startDateTag.min = "1990-01-01";
		endDateTag.min = "1990-01-01";
		
		//- 최대 날짜 설정
		startDateTag.max = currentDate;
		endDateTag.max = currentDate;
		
		//질환분류, 신체분류 radio 중 선택한 것만 option 띄우기
		const radioBtns = document.querySelectorAll('input[name="classification"]');
		const diseaseSelectBox = document.getElementById('selectBox-disease');
		const bodySelectBox = document.getElementById('selectBox-body');
		
		// - 초기 상태 설정 함수 신체 분류만 표시
		diseaseSelectBox.style.display = "none";
		bodySelectBox.style.display = "block";
		
		//-누를 때 둘 중 하나만 띄우기
		radioBtns.forEach((radio) => {
			radio.addEventListener('click', function() {
				if(this.value == 'disease') {
					diseaseSelectBox.style.display = "block";
					bodySelectBox.style.display = "none";
				} else if(this.value == 'body') {
					diseaseSelectBox.style.display = "none";
					bodySelectBox.style.display = "block";
				}
			});
		});
		
		
	});
	
	/*
	//질환 게시판 전체 글 출력 ajax 분리 --> paginationAjax로 대체
	function getDiseaseBoardList() {
		$.ajax({
			url : "getDiseaseBoardList"
			, method : "get"
			, success : function(data) {
				 getDiseaseBoardListSuccess(data);
			}
			, error : function() {
				alert("페이지 로드시 리스트 구현 실패");
			}
			
		});
	}
	*/
	
	//질환분류, 신체분류별 검색 기능 
	let classificationSearchBtn = document.getElementById('classificationSearchBtn');
	classificationSearchBtn.addEventListener('click', function(event) {
		event.preventDefault();
		
		// - 선택한 분류 종류 확인
		let selectedClassification = document.querySelector('input[name="classification"]:checked').value;
		console.log("선택한 분류 종류 : " + selectedClassification); 
		
		// - 선택한 분류에 따라 option value 가져오기
		if(selectedClassification == 'disease') { //질환 분류 선택
			//- option 선택했는지 검증
			let selectedDiseasePartId = $('#selectBox-disease option:selected').val();
			if (selectedDiseasePartId == -1) {
				alert("질환 분류의 값을 선택해주세요.");
				return;
			}
			searchDiseaseBoardByClassification(selectedClassification , selectedDiseasePartId);
		} else if (selectedClassification == 'body') { //신체 분류 선택
			//- option 선택했는지 검증
			let selectedBodyPartId = $("#selectBox-body option:selected").val();
			if (selectedBodyPartId == -1) {
				alert("신체 분류의 값을 선택해주세요.");
				return;
			}
			searchDiseaseBoardByClassification(selectedClassification , selectedBodyPartId);
		}
		
	});
	
	//질환분류, 신체분류별 검색 ajax
	function searchDiseaseBoardByClassification(selectedClassification , selectedPartId) {
		console.log("분류별 검색 ajax 실행_분류 종류 : " + selectedClassification + ", ID : " + selectedPartId);
		
		$.ajax({
			url : "searchDiseaseBoardByClassification"
			, method : "post"
			, data : JSON.stringify({searchTopic : selectedClassification, selectedPartId : selectedPartId})
			, dataType : "json"
			, contentType : "application/json"
			, success : function(data) {
				getDiseaseBoardListSuccess(data);
			}
			, error : function() {
				alert("실패");
			}
		});
		
		
	}
	
	//글 검색 기능(제목만, 내용만)
	let keywordSearchBtn = document.getElementById("keywordSearchBtn");
	keywordSearchBtn.addEventListener('click', function(event) {
		event.preventDefault();
		
		//사용자 입력값 가져오기
		// - 제목만, 내용만 어떤건지
		let searchTopic = document.querySelector('input[name="topic"]:checked').value;
		console.log("검색 주제 : " + searchTopic);
		
		// - 검색어
		let searchKeyword = document.getElementById('search_input').value.trim();
		console.log("사용자 검색 입력값 : " + searchKeyword);
		if (searchKeyword == "") {
			return;
		}
		
		$.ajax({
			url : "searchDiseaseBoardByTitleOrContentAndKeyword"
			, method : "post"
			, data : JSON.stringify({keyword : searchKeyword, searchTopic : searchTopic})
			, dataType : "json"
			, contentType : "application/json"
			, success : function(data) {
				getDiseaseBoardListSuccess(data)
			}
			, error : function() {
				alert("실패");
			}
		});
		
	});
	
	
	//캘린더 날짜 검색 기능
	let apply = document.getElementById("apply");
	apply.addEventListener('click', function(event) {
		event.preventDefault();
		
		//날짜 검증
		let startDateValue = new Date(startDateTag.value);
		let endDateValue = new Date(endDateTag.value);
		
		if (endDateValue < startDateValue) {
			alert("종료 날짜는 시작 날짜 이후여야 합니다.");
			return;
		}
		
		//캘린더 날짜 검색 아작스 실행
		dateSearchAjax(startDateValue, endDateValue);
		
		
	});
	
	//캘린더 날짜 초기화
	let applyReset = document.getElementById('apply_reset');
	applyReset.addEventListener('click', function(event) {
		event.preventDefault();
		
		//기본값 오늘 날짜로 설정
		startDateTag.value = currentDate;
		endDateTag.value = currentDate;
		
	});
	
	//캘린더 날짜 검색 아작스
	function dateSearchAjax(startDateValue, endDateValue) {
		console.log("캘린더 날짜 검색 아작스 : " + startDateValue + ", : " + endDateValue);
		
		//날짜 추출
		const finalStartDate = dateFormatting(startDateValue);
		const finalEndDate = dateFormatting(endDateValue);
		console.log("최종 시작 날짜 : " + finalStartDate);
		console.log("최종 끝 날짜 : " + finalEndDate);
		
		let sendData = {startDate : finalStartDate, endDate : finalEndDate};
		
		
		$.ajax({
			url : "searchByCalendarDiseaseBoard" 
			, method : "post"
			, data : JSON.stringify(sendData)
			, dataType : "json"
			, contentType : "application/json"
			, success : function(data) {
				getDiseaseBoardListSuccess(data)
			}
			, error : function() {
				alert("실패");
			}
		});
	} 
	
	//diseaseBoardList ajax success 함수 분리
	function getDiseaseBoardListSuccess (data) {
		
		//조회된 글 개수
		let totalCount = "";
		
		let colCnt = document.querySelectorAll('thead tr th').length;		
		let dispHtml = "";
		if(data == "") {
			dispHtml += "<tr class='no-data-row'><td class='no-data-message' colspan='" + colCnt + "'>조회된 데이터가 없습니다.</td></tr>";
		}
		
		data.forEach(function(disease) {
			dispHtml += "<tr>";
			dispHtml += "<td><input type='checkbox' class='chk' value=" + disease.diseaseBoardId + "></td>";
			dispHtml += "<td><a href='getDiseaseBoardDetailPage?diseaseBoardId=" + disease.diseaseBoardId + "'>" + disease.title +"</a></td>";
			//질환, 신체, 첨부
			dispHtml += "<td>" + disease.diseasePartName + "</td>";
			dispHtml += "<td>" + disease.bodyPartName + "</td>";
			if(disease.filePath == null) { 	//첨부파일 없으면 기본 이미지 --> 되긴 하는데 그냥 '첨부파일 x'하는게 나을듯
				dispHtml += "<td><div class='file_box'>X</div></td>";
			} else { //있으면 첨부파일 이미지
				dispHtml += "<td>";
				dispHtml += "<div class='file_box'>";
				// 원래는 이거. 아래꺼는 모달적용하기. dispHtml += "<a href='" + disease.filePath + "'>" ;
				dispHtml += "<button type='button' data-bs-diseaseBoardId='" + disease.diseaseBoardId + "'  data-bs-thumbnail='" + disease.filePath + "'  data-bs-toggle='modal' data-bs-target='#thumbnailModal' style='border: none;'>";
				dispHtml += "<img src='${pageContext.request.contextPath }/resources/images/file.png' alt='fileImg'>";
				//dispHtml += "<img src='${pageContext.request.contextPath }" +  disease.filePath + "' alt='diseaseImg'>";
				dispHtml += "</button></div></td>";
				
			}
			dispHtml += "<td>" + disease.createdAt + "</td>";
			dispHtml += "<td>" + disease.boardCount + "</td>";
			dispHtml += "<td><a href='updateDiseaseBoardPage?diseaseBoardId=" + disease.diseaseBoardId + "'><span class='pencil'>수정</span></a></td>";
			dispHtml += "<td><div class='del_box'>";
			dispHtml += "<a href='' class='deleteBtnClass' data-disease-board-id=" + disease.diseaseBoardId + "><img src='${pageContext.request.contextPath }/resources/images/delete.png' alt=''></a>";
			dispHtml += "</div></td>";
			dispHtml += "</tr>";
			
			totalCount = disease.totalCount + "/";
			
		}); 
		//전체 글 개수는 그냥 따로 쿼리로 빼서 가져옴
		console.log("조회된 글 개수 : " + totalCount);
		$('#currentCnt').html(totalCount); 
		$('#diseaseBoardListTbody').html(dispHtml);
			
	}
	
	//모달 썸네일 이미지 전송
	var thumbnailModal = document.getElementById('thumbnailModal');
	thumbnailModal.addEventListener('show.bs.modal', function (event) {
	  	var button = event.relatedTarget;
	 	var thumbnailPath = button.getAttribute('data-bs-thumbnail');
	 	let modalDiseaseBoardId = button.getAttribute('data-bs-diseaseBoardId');
	  	console.log("넘어온 파일 경로 : " + thumbnailPath);
	  	console.log("넘어온 게시글 ID : " +  modalDiseaseBoardId);
		
	  	let dispHtml = "<img src='${pageContext.request.contextPath }" +  thumbnailPath + "' alt='diseaseImg'>";
	  	$('#thumbnail-disp').html(dispHtml);
	  	
	 	// 버튼에 데이터 추가 (사진수정 링크)
	    $('#updateBtn').attr('data-diseaseBoardId', modalDiseaseBoardId);
	});
	
	
	//날짜 yyyy-mm-dd 변환 함수
	function dateFormatting(date) {
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, '0'); //월은 0부터 시작이라 +1, 2자리 숫자로 변환
		const day = String(date.getDate()).padStart(2, '0'); //2자리 숫자로 변환
		return `\${year}-\${month}-\${day}`;
	}
	
	//전체, 오늘, 1주, 1개월 검색 기능
	document.querySelectorAll('.termSearchBtn').forEach(btn => {
		btn.addEventListener('click', function(event) {
			event.preventDefault();
			const termValue = this.dataset.term;
			if (termValue == 'all') { //'전체' 조회 누르면 '질환 게시판 전체 글 출력 ajax'로 연결
				paginationAjax(1);
			} else {
				termSearchAjax(termValue);
			}
		});
	});
	
	//전체, 오늘, 1주, 1개월 검색 기능 ajax
	function termSearchAjax(termValue) {
		console.log("구간 검색 ajax 실행 : " + termValue);
		
		$.ajax({
			url : "searchByTermDiseaseBoard/" + encodeURIComponent(termValue)
			, dataType : "json"
			, method : "get"
			, success : function(data) {
				getDiseaseBoardListSuccess(data)
			}
			, error : function() {
				alert("실패");
			}
		});
		
	}
	

	//전체 체크 기능
	let checkAll = document.getElementById("checkAll");
	
	checkAll.addEventListener("click", function() {
		
		const isChecked = checkAll.checked;
		if (isChecked) {
			const checkboxes = document.querySelectorAll(".chk");
			for (const checkbox of checkboxes) {
				checkbox.checked = true;
			}
		} else {
			const checkboxes = document.querySelectorAll(".chk");
			for (const checkbox of checkboxes) {
				checkbox.checked = false;
			}
		}
		
	});
	
	//여러개 삭제 기능
	let multi_deleteBtn = document.getElementById("multi_deleteBtn");
	
	multi_deleteBtn.addEventListener('click', function(event) {
		event.preventDefault();
		
		const checkboxes = document.querySelectorAll(".chk");
		const selectedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked);
		const selectedIds = selectedCheckboxes.map(checkbox => checkbox.value);
		if (selectedCheckboxes.length == 0) {
			alert("삭제할 항목을 선택해주세요.");
			return;
		}
		
		if(confirm("정말 삭제하시겠습니까?")) {
			deleteAjax(selectedIds);
		} else {
			location.reload(); //선택한 체크박스 해제하기
		}
		
	});
	
	
	
	
	//각각 삭제 기능
	//이게 $(document).ready()로 초기 페이지 로드할때 ajax 요청으로 동적 생성된 요소들은 이벤트 리스너가 바인딩 되지 않는대!!!
	//방법 1 : $(document).ready() 이거 안에 ajax로 데이터 불러왔을때 success : 안에! 기존 방법(addEvenTListener) 하든가 
	//방법 2 : 동적으로 추가된 요소들은 이벤트 위임기법 사용해야 함
	/* // 기존 방법 (방법 1)
	document.querySelectorAll('.deleteBtnClass').forEach(btn => {
		btn.addEventListener('click', function(event) {
			event.preventDefault();
			
			const diseaseBoardId = this.dataset.diseaseBoardId; 
			console.log("삭제 선택한 id : " + diseaseBoardId);
			
			if(confirm("정말 삭제하시겠습니까?")) {
				deleteAjax(diseaseBoardId);
			} else {
				return;
			}
			
		})
	})
	*/
	
	//방법 2
	
	$(document).on('click', '.deleteBtnClass', function(event) {
		event.preventDefault();
		const diseaseBoardId = $(this).data('disease-board-id');
		console.log("삭제 선택한 id : " + diseaseBoardId);
		
		if(confirm("정말 삭제하시겠습니까?")) {
			deleteAjax(diseaseBoardId);
		}
		
	});
	//각각 삭제 기능  끝 --------
	
	//삭제 ajax
	function deleteAjax(selectedIds) {
		console.log("삭제할 id : " + selectedIds);
		console.log(JSON.stringify({selectedId : selectedIds}));
		const dataToSend = Array.isArray(selectedIds) ? selectedIds : [selectedIds]; // 항상 배열로 변환--> 이거 추가하니까 되네...?
					//배열이면 그냥 보내고, 배열 아니면 []배열로 만들기
					//값이 하나인 경우에도 배열 형태로 보내지 않으면 매핑 오류!!!!!!! 하나 선택에서 보내면 String 타입으로 넘어가는거지., dto는 String[] 이니까
		
		$.ajax({
			url : "deleteDiseaseBoard"
			, method : "delete"
			, data : JSON.stringify({selectedId : dataToSend})
			, dataType : "json"
			, contentType : "application/json"
			, success : function(data) {
				console.log("삭제된 행 수 : " + data);
				if (data >= 1) {
					alert("삭제가 완료되었습니다.");
					location.reload();
				} else {
					alert("삭제 도중 문제가 발생했습니다.");
				}
			}
			, error : function() {
				alert("실패");
			}
			
		});
	}
	
	
	
</script>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<script>
	// 사이드바 토글 움직임
	document.querySelector('.healthul').classList.add('on');
	document.querySelector('.healthBoard').classList.add('on');
	
</script>	
</body>
</html>