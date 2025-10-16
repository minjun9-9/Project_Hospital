<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>진료의뢰</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css" />

<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/design.js"></script>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
<style>
	span.chkpurple {font-size: 14px; font-weight: 600;background-color: #A377D1; color: #fff; display: inline-block;width: 50px;height: 25px;text-align: center;line-height: 25px;}
	span.chkred {font-size: 14px; font-weight: 600;background-color: #E9706D; color: #fff; display: inline-block;width: 50px;height: 25px;text-align: center;line-height: 25px;}
	span.chkgreen {font-size: 14px; font-weight: 600;background-color: #A5CF4C; color: #fff; display: inline-block;width: 50px;height: 25px;text-align: center;line-height: 25px;}
	span.chkdeepgreen {font-size: 14px; font-weight: 600;background-color: #328D7D; color: #fff; display: inline-block;width: 50px;height: 25px;text-align: center;line-height: 25px;}
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/searchButton.css" />
</head>
<body>
	<%@include file="/resources/common/calendar.jspf" %>
	
	<div class="body_wrap">
	
		<%@include file="/resources/common/menu.jspf" %>
		
		<div class="content">
			<div class="top_bar bg_w">
				<a href="#" class="top_left doctor_con"><span>진료의뢰</span></a>
				<%@include file="/resources/common/profile.jspf" %>
				<%-- <div class="top_right">
					<a href="#" class="option"><img src="${pageContext.request.contextPath}/resources/images/top_option.png" alt="option"></a>
					<a href="#">
						<c:set var="name" value="${admin.adminName }" />
						<span class="profile bg_5 f_s20">${fn:substring(name, 0, 1)}</span>
						<span class="name c_2 f_s15">${name } 님</span>
					</a>
				</div> --%>
			</div>
			<div class="con_wrap bg_13">
				<!-- content시작 -->
				<div class="doc_list bg_w">
					<%-- <div class="list_top">
						<div class="doc_li_up">
							<select name="doc_li_selc">
								<option value="doc_li01">관련진료과</option>
								<option value="doc_li02">관련진료과01</option>
								<option value="doc_li03">관련진료과02</option>
								<option value="doc_li04">관련진료과03</option>
								<option value="doc_li05">관련진료과04</option>
								<option value="doc_li06">관련진료과05</option>
							</select>
							<!-- <ul class="f_s15 f_w600">
								<li class="bor_4"><a href="#"><span class="purple">서</span>한양대학교병원</a></li>
								<li class="bor_4"><a href="#"><span class="red">류</span>류머티스병원</a></li>
								<li class="bor_4"><a href="#"><span class="green">국</span>국제병원</a></li>
								<li class="bor_4"><a href="#"><span class="deepgreen">클</span>클리닉/센터</a></li>
							</ul> -->
							
							<%
							    Date today = new Date(); //오늘날짜
								SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //포멧형식
							    String formattedDate = sdf.format(today); //적용
							    
							    pageContext.setAttribute("date", formattedDate);
							%>
							
							<div class="up_date">
								<p class="f_w400 f_s14">Date</p>
								<div class="calendar">
									<input type="date" value="${date}">
									<span>-</span>
									<input type="date" value="${date}">
								</div>
								<!-- <ul>
									<li class="bor_2 on"><a href="#">전체</a></li>
									<li class="bor_2"><a href="#">오늘</a></li>
									<li class="bor_2"><a href="#">1주일</a></li>
									<li class="bor_2"><a href="#">1달</a></li>
								</ul> -->
							</div>
						</div>
						<div class="doc_li_down">
							<div class="find_box bg_8">
								<label for="search" class="f_s16 f_w500"><input type="radio" name="type" checked>전문과목</label>
								<label for="search" class="f_s16 f_w500"><input type="radio" name="type">성명</label>
								<label for="search" class="f_s16 f_w500"><input type="radio" name="type">태그</label>
							</div>
							<input type="text" class="search_box" placeholder="Search">
							<a href="#">검색</a>
							<!-- <div class="my_box">
								<p class="f_s14 f_w400"><span class="f_w500">Total</span>0/ <em class="f_w600">91.248.780</em></p>
							</div> -->
						</div>
					</div> --%>
					
					
					<!-- 검색  -->
					<div class="container-fluid mb-3" style="width: 50%;">
						<form action="referralPage" method="get" class="d-flex align-items-center" style="height: 70px;">
					    	<input class="form-control me-2 py-3" id="searchInput" type="search" placeholder="내용을 입력해주세요." aria-label="Search" name="searchKeyword">
					    	<!-- <input type="submit" value="검색"> -->
					    	<button class="btn btn-outline-primary text-nowrap py-3" id="searchBtn" type="submit" style="width: 18%;">
					    		<img src="${pageContext.request.contextPath }/resources/images/ico_search.png" class="me-1">검색
					    	</button>
					    </form>
					    
					    <!-- <form action="referralPage" method="get" style="display: flex;">
							<input class="search_box" type="text" name="searchKeyword" placeholder="병원명을 입력해주세요.">
							<label class="search_btn" for="search_btn">검색
								<input class="d-none" id="search_btn" type="submit" value="검색">
								<span class="search_btn_after"></span>
							</label>
						</form> -->
				    </div>
				    
				    
					<div class="list_mid">
						<span class="subtit f_s20 f_w700">받은 진료의뢰 목록</span>
						<div class="mid_btn">
							<a href="insertReferralPage" class="bg_2 f_w500 f_s15">진료의뢰서 작성</a>
						</div>
					</div>
					<table class="table_sty01">
						<table class="table_sty01">
							<caption>진료의뢰 목록</caption>
							<colgroup>
								<col width="80px">	<!-- No -->
								<col width="180px">	<!-- 신청 진료과 -->
								<col width="120px">	<!-- 신청자 -->
								<col width="80px">	<!-- 빈칸 -->
								<col width="180px">	<!-- 수신 진료과 -->
								<col width="120px">	<!-- 수신자 -->
								<col width="">		<!-- 요청내용 -->
								<col width="120px"> <!-- 등록날짜 -->
								<col width="120px"> <!-- 처리내용 확인 RECEIVE_CHK -->
								<%-- <col width="120px">	<!-- 수정 --> --%>
								<%-- <col width="120px">	<!-- 삭제 --> --%>
							</colgroup>
							<thead>
								<tr>
									<th class="text-center"><span>No</span></th>
									<th class="text-center"><span class="bul_th">신청 진료과</span></th>
									<th class="text-center"><span class="bul_th">신청자</span></th>
									<th class="text-center"></th>
									<th class="text-center"><span class="bul_th">수신 진료과</span></th>
									<th class="text-center"><span class="bul_th">수신자</span></th>
									<th style="text-align: center;"><span>요청내용</span></th>
									<th class="text-center"><span>등록일</span></th>
									<th class="text-center"><span>상태</span></th>
									<!-- <th class="text-center"><span>수정</span></th> -->
									<!-- <th class="text-center"><span>삭제</span></th> -->
								</tr>
							</thead>
							<!-- 목록 시작 -->
							<tbody>
								<%-- <c:if test="${not empty sessionScope.admin}"> --%>
									<c:forEach var="referral" items="${referralListAll}">
									<tr>
										<td>${referral.referId}</td>		
										<td class="text-center">${referral.sDeptName}</td>							
										<td class="text-center">${referral.sDrName}</td>		
										<td></td>
										<td class="text-center">${referral.rDeptName}</td>							
										<td class="text-center">${referral.rDrName}</td>					
										<td style="text-align: center;"><a href="insertReferralPage?referId=${referral.referId }">${referral.referContent}</a></td>							
										<td style="text-align: center;">${referral.createDate }</td>	
										<c:if test="${referral.receiveChk == '확인 전'}"><td><span class="chkgreen">${referral.receiveChk }</span></td></c:if>						
										<c:if test="${referral.receiveChk == '진행 중'}"><td><span class="chkdeepgreen">${referral.receiveChk }</span></td></c:if>						
										<c:if test="${referral.receiveChk == '완료'}"><td><span class="chkpurple">${referral.receiveChk }</span></td></c:if>						
										<c:if test="${referral.receiveChk == '취소'}"><td><span class="chkred">${referral.receiveChk }</span></td></c:if>						
										<!-- <td><span class="pencil">수정</span></td> -->
										<%-- <td><div class="del_box"><img src="${pageContext.request.contextPath}/resources/images/deliete.png" alt=""></div></td> --%>
									</tr>							
									</c:forEach>
								<%-- </c:if> --%>
								
							</tbody>
							
						</table>
					</table>
					
					<!-- 페이징처리하기 -->
					<%-- <div class="table01_paging">
						<ul>
							<li><a href="#"><img src="${pageContext.request.contextPath}/resources/images/first_page.png" alt="첫번째로페이지"></a></li>
							<li><a href="#"><img src="${pageContext.request.contextPath}/resources/images/prev_page.png" alt="이전페이지"></a></li>
						</ul>
						<ol>
							<li class="on"><a href="#">01</a></li>
							<li><a href="#">02</a></li>
							<li><a href="#">03</a></li>
							<li><a href="#">04</a></li>
							<li><a href="#">05</a></li>
							<li><a href="#">06</a></li>
							<li><a href="#">07</a></li>
							<li><a href="#">08</a></li>
							<li><a href="#">09</a></li>
							<li><a href="#">10</a></li>
						</ol>
						<ul>
							<li><a href="#"><img src="${pageContext.request.contextPath}/resources/images/next_page.png" alt="다음페이지"></a></li>
							<li><a href="#"><img src="${pageContext.request.contextPath}/resources/images/last_page.png" alt="마지막페이지"></a></li>
						</ul>
						<p class="go_page c_78 f_w400 f_s15">
							Go to page :
							<input type="text" placeholder="1">
							of <em class="c_b">3,985</em>
						</p>
					</div> --%>
					<!-- 페이징처리 -->
					
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
							    		<a class="page-link" href="referralPage?cPage=1&searchKeyword=${keyword}">
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
							    		<a class="page-link" href="referralPage?cPage=${paging.beginPage - 1 }&searchKeyword=${keyword}">
							    			<img src="${pageContext.request.contextPath }/resources/images/prev_page.png">
							    		</a>
							 		</li>
						 		</c:if>
						 		<c:forEach var="pageNum" begin="${paging.beginPage }" end="${paging.endPage }">
							 		<c:if test="${pageNum == paging.nowPage }">
							  			<li class="page-item page-link text-dark">${pageNum }</li>
							  		</c:if>
							  		<c:if test="${pageNum != paging.nowPage }">
							  			<li class="page-item"><a class="page-link" href="referralPage?cPage=${pageNum }&searchKeyword=${keyword}">${pageNum }</a></li>
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
							    		<a class="page-link" href="referralPage?cPage=${paging.endPage + 1 }&searchKeyword=${keyword}">
							    			<img src="${pageContext.request.contextPath }/resources/images/next_page.png">
							    		</a>
							 		</li>
						 		</c:if>
						 		<c:if test="${paging.nowBlock >= paging.totalBlock }">
						 			<li class="page-item disabled">
							    		<a class="page-link" href="#" tabindex="-1" aria-disabled="true">
							    			<img src="${pageContext.request.contextPath }/resources/images/next_page.png">
							    		</a>
							 		</li>
						 		</c:if>
						 		<c:if test="${paging.nowBlock < paging.totalBlock }">
							 		<li class="page-item">
							    		<a class="page-link" href="referralPage?cPage=${paging.totalPage }&searchKeyword=${keyword}">
							    			<img src="${pageContext.request.contextPath }/resources/images/last_page.png">
							    		</a>
							 		</li>
						 		</c:if>
							</ul>
					 </nav>
					 
				</div>
			</div>
			<div class="footer">2025 ITWILL.</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>	
</body>
</html>