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
	.tab03_mid .mid_btn > a:nth-child(2) {
	width: 160px;
	}
	
	.left_up .up_date {
		margin-left: 0;
	}

	#healthBoardListTbody > tr > td {
		font-size: 16px;
	}

</style>

</head>
<body>

	<div class="body_wrap">
		<!-- 사이드바 -->
		<%@ include file="WEB-INF/../../../../common/sidebar.jspf"%>
		
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
					<div class="tab03_li" data-tab="tab1">
						<a href="diseaseBoardManagePage" class="full-clickable"><p class="tab03_btn f_w700 f_s17 c_3 bor_2">질환 게시판</p> </a>
					</div>
					
					<!-- tab2  검사, 치료 게시판-->
					<div class="tab03_li" data-tab="tab2">
						<a href="examinationBoardManagePage" class="full-clickable"><p class="tab03_btn f_w700 f_s17 c_3 bor_2">검사, 치료 게시판 </p></a>
					</div>
					
					<!-- tab3 건강 뉴스 게시판-->
					<div class="tab03_li on" data-tab="tab3">
						<a href="#" class="full-clickable"><p class="tab03_btn f_w700 f_s17 c_3 bor_2">건강 뉴스 게시판</p></a>
						<div class="tab03_con">
							<div class="tab03_top">
								<div class="top_left">
									<div class="left_up">
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
										<p class="f_s14 f_w400"><span class="f_w500">Total</span><span id="currentCnt">/</span><em class="f_w600" id="totalCount">${healthBoardListTotalCount}</em></p>
									</div>
								</div>
							</div>
							<div class="tab03_mid">
								<span class="subtit f_s20 f_w700">건강 뉴스 게시판 관리</span>
								<div class="mid_btn">
									<a href="#" class="del bor_2 c_3 f_s15 f_w600" id="multi_deleteBtn">삭제</a>
									<a href="insertHealthBoardPage" class="bg_2 f_w500 f_s15">건강 뉴스 게시글 등록</a> 
								</div>
							</div>
							<table class="table_sty01">
								<caption>건강 뉴스 게시판 관리</caption>
								<colgroup>
									<col width="80px">
									<col width="150px">
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
										<th><span>첨부</span></th>
										<th><span>Date&nbsp;</span><a href="#" id="orderByDateDesc"><img src="${pageContext.request.contextPath }/resources/images/bul_th.png"></a></th>
										<th><span>조회수&nbsp;</span><a href="#" id="orderByCountDesc"><img src="${pageContext.request.contextPath }/resources/images/bul_th.png"></a></th>
										<th><span>수정</span></th>
										<th><span>삭제</span></th>
									</tr>
								</thead>
								<tbody id="healthBoardListTbody"> 
								</tbody>
							</table>
							<div class="table01_paging">
							<!-- 
								<nav aria-label="...">
									<ul class="pagination">
										<li class="page-item disabled">
											<a class="page-link" href="#">이전페이지</a>
										</li>
										<li class="page-item active" aria-current="page">
											<a class="page-link" href="#" data-page="1">1</a>
										</li>
										<li class="page-item">
											<a class="page-link" href="#" data-page="2">2</a>
										</li>
										
										<li class="page-item">
											<a class="page-link" href="#" data-page=>다음 페이지</a>
										</li>
									</ul>
								</nav>
							 -->
							
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
					
				</div>
			</div>
			<div class="footer bg_13 f_s15">2023 Hanyang University Medical Center All right Reserved.</div>
		</div>
	</div>
	
	
	
<script>
//페이지네이션 자바스크립트에서 다 끝내기
//검색 파라미터 : 표시할 게시글 수, 
//한 페이지당 표시할 게시글 수(pageSize)를 jsp 하나당 하나로 고정
//데이터 검색할 때마다 일단 무조건 pageSize만큼 가져오기 + 전체 데이터 개수도 가져오기
//페이지네이션 버튼 생성하고 나서 이벤트 연결하기. 어 어떤 종류 검색인지 어떻게 알지.? flag 설정?
/*
//나혼자 페이지네이션.. 요소 다 있는디? 로드하자마자 페이지네이션 되겠는디? 는 못 하겠다 나중에 여유되면 하자 ^^
let totalCount = ${healthBoardListTotalCount}; //총 게시글 수 (controller에 총 게시글 수 있음. 아예 따로임)
let pageSize = 10; //페이지당 표시할 게시글 수
let totalPageCount = Math.ceil(totalCount / pageSize); //필요한 총 페이지 수
let paginationFlag = "";
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
	
	let hbIdFromBtn = updateBtn.getAttribute('data-hbId');
	console.log("모달로 넘어온 hbId : " + hbIdFromBtn);
	location.href="updateHealthBoardPage?hbId=" + hbIdFromBtn;
	
});



let isCalendarSearch = false;
let calendatSearchParms = {};


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
		paginationFlag = 'default';
		paginationAjax(currentPage);
		
	});
	
	
	//페이지네이션 아작스 
	function paginationAjax(pageNum) {
		console.log("받은 페이지: " + pageNum); 
		//console.log("페이지처리할 데이터 종류 : " + paginationFlag); 
		
		if (isCalendarSearch) {
			calendarPaginationAjax(pageNum, calendarSearchParams);
		} else {
			//기본 페이지
			$.ajax({
				url : "getHealthBoardPage/" + encodeURIComponent(pageNum)
				, dataType : "json"
				, method: "get"
				, success : function(data) {
					
					//1. 목록 업데이트
					 getHealthBoardListSuccess(data);
					
					//2. 페이지네이션 재생성 이거를 success함수에 넣으면 되지 않나????????
					renderPagination(data.currentPage, data.totalPageCount);
				}
				, error : function() {
					alert("페이지네이션 구현 실패");
				} 
			});
		}
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
		
		//- 기본값 오늘 날짜로 설정
		startDateTag.value = currentDate;
		endDateTag.value = currentDate;
		
		//- 최소 날짜 설정
		startDateTag.min = "1990-01-01";
		endDateTag.min = "1990-01-01";
		
		//- 최대 날짜 설정
		startDateTag.max = currentDate;
		endDateTag.max = currentDate;
		
	});
	
	
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
			url : "searchHealthBoardByTitleOrContentAndKeyword"
			, method : "post"
			, data : JSON.stringify({keyword : searchKeyword, searchTopic : searchTopic})
			, dataType : "json"
			, contentType : "application/json"
			, success : function(data) {
				getHealthBoardListSuccess(data)
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
			url : "searchByCalendarHealthBoard" 
			, method : "post"
			, data : JSON.stringify(sendData)
			, dataType : "json"
			, contentType : "application/json"
			, success : function(data) {
				getHealthBoardListSuccess(data)
			}
			, error : function() {
				alert("실패");
			}
		});
		
		calendarPaginationAjax(1, sendData);
		
	} 
	
	//캘린더 날짜 검색 페이지네이션
	function calendarPaginationAjax(pageNum, sendData) { //이렇게 해도 넘어온다!
		console.log("받은 페이지: " + pageNum); 
		console.log("받은 날짜 데이터: " + sendData);
		
		$.ajax({
			url : "getHealthBoardCalendarPage/" + encodeURIComponent(pageNum)
			, dataType : "json"
			, data : JSON.stringify(sendData)
			, method: "post"
			, contentType : "application/json"
			, success : function(data) {
				getHealthBoardListSuccess(data);
				renderPagination(data.currentPage, data.totalPageCount);
			}
			, error : function() {
				alert("캘린더 데이터 페이지네이션 구현 실패");
			} 
		});
		
		
	}

	
	
	//healthBoardList ajax success 함수 분리
	function getHealthBoardListSuccess(data) {
		console.log("가져온 데이터 : " + data.boardList);
		console.log("가져온 데이터의 개수 : " + data.totalCount);
		
		let colCnt = document.querySelectorAll('thead tr th').length;		
		let dispHtml = "";
		if(data.boardList == "") {
			dispHtml += "<tr class='no-data-row'><td class='no-data-message' colspan='" + colCnt + "'>조회된 데이터가 없습니다.</td></tr>";
		}
		
		data.boardList.forEach(function(health) {
			dispHtml += "<tr>";
			dispHtml += "<td><input type='checkbox' class='chk' value=" + health.hbId + "></td>";
			dispHtml += "<td><a href='getHealthBoardDetailPage?hbId=" + health.hbId + "'>" + health.title +"</a></td>";
			if(health.filePath == null) { 	//첨부파일 없으면 X
				dispHtml += "<td><div class='file_box'>X</div></td>";
			} else { //있으면 첨부파일 이미지
				dispHtml += "<td>";
				dispHtml += "<div class='file_box'>";
				dispHtml += "<button type='button'  data-bs-hbId='" +  health.hbId + "'  data-bs-thumbnail='" + health.filePath + "'  data-bs-toggle='modal' data-bs-target='#thumbnailModal' style='border: none;'>";
				dispHtml += "<img src='${pageContext.request.contextPath }/resources/images/file.png' alt='fileImg'>";
				dispHtml += "</button></div></td>";
				
			}
			dispHtml += "<td>" + health.createdAt + "</td>";
			dispHtml += "<td>" + health.boardCount + "</td>";
			dispHtml += "<td><a href='updateHealthBoardPage?hbId=" + health.hbId + "'><span class='pencil'>수정</span></a></td>";
			dispHtml += "<td><div class='del_box'>";
			dispHtml += "<a href='' class='deleteBtnClass' data-health-id=" + health.hbId + "><img src='${pageContext.request.contextPath }/resources/images/delete.png' alt=''></a>";
			dispHtml += "</div></td>";
			dispHtml += "</tr>";
			
		}); 
		
		//2. 페이지네이션 재생성 이거를 success함수에 넣으면 되지 않나????????
		//renderPagination(현재 페이지, totalPageCount총페이지 수); 아작스에서 페이지처리 다 해서 가져오면 될듯?? 
		//renderPagination(data.currentPage, data.totalPageCount);
		//renderPagination(1, data.totalPageCount); 
		// 오!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  되는건가...? 잘 모르겠어ㅠㅠ
		//그런데 이렇게 하면 다른 페이지 버튼 눌렀을 때 어떻게 되는거지
		
		//전체 글 개수는 그냥 따로 쿼리로 빼서 가져옴
		console.log("조회된 글 개수 : " + data.totalCount); 
		$('#currentCnt').html(data.totalCount + "/"); 
		$('#healthBoardListTbody').html(dispHtml);
			
	}
	
	//모달 썸네일 이미지 전송
	var thumbnailModal = document.getElementById('thumbnailModal');
	thumbnailModal.addEventListener('show.bs.modal', function (event) {
	  	var button = event.relatedTarget;
	 	var thumbnailPath = button.getAttribute('data-bs-thumbnail');
	 	let modalHbId = button.getAttribute('data-bs-hbId');
	  	console.log("넘어온 파일 경로 : " + thumbnailPath);
	  	console.log("넘어온 게시글 ID : " + modalHbId);
		
	  	let dispHtml = "<img src='${pageContext.request.contextPath }" + thumbnailPath + "' alt='healthImg'>";
	  	$('#thumbnail-disp').html(dispHtml);
	  	
	 	// 버튼에 데이터 추가 (사진수정 링크)
	    $('#updateBtn').attr('data-hbId', modalHbId);
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
			if (termValue == 'all') { //'전체' 조회 누르면 '검사, 치료 게시판 전체 글 출력 ajax'로 연결
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
			url : "searchByTermHealthBoard/" + encodeURIComponent(termValue)
			, dataType : "json"
			, method : "get"
			, success : function(data) {
				getHealthBoardListSuccess(data)
			}
			, error : function() {
				alert("구간 검색 실패");
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
	$(document).on('click', '.deleteBtnClass', function(event) {
		event.preventDefault();
		const healthId = $(this).data('health-id');
		console.log("삭제 선택한 id : " + healthId);
		
		if(confirm("정말 삭제하시겠습니까?")) {
			deleteAjax(healthId);
		}
		
	});
	
	//삭제 ajax
	function deleteAjax(selectedIds) {
		console.log("삭제할 id : " + selectedIds);
		console.log(JSON.stringify({selectedId : selectedIds}));
		const dataToSend = Array.isArray(selectedIds) ? selectedIds : [selectedIds]; // 항상 배열로 변환--> 이거 추가하니까 되네...?
		
		$.ajax({
			url : "deleteHealthBoard"
			, method : "delete"
			, data : JSON.stringify({selectedId : dataToSend})
			, dataType : "json"
			, contentType : "application/json"
			, success : function(data) {
				console.log("삭제된 행 수 : " + data);
				if (data >= 1) {
					alert("삭제가 완료되었습니다.");
					location.reload(); // 이게 왜 질환관리 게시판으로 가지?
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