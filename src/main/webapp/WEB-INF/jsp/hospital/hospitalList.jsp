<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>list</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/design.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	
	<%-- <c:if test="${not empty message}">
        <script>
            alert("${message}");
        </script>
        <c:remove var="message" scope="request" />
    </c:if> --%>
    
    <c:if test="${not empty sessionScope.message}">
        <script>
            alert("${sessionScope.message}");
        </script>
        <c:remove var="message" scope="session" />
    </c:if>
    
    
</head>
<style>
	.doc_list .table_sty01 tr th {
		font-weight: 600 !important;
	}
	.doc_list .table_sty01 tr td {
		font-weight: 400 !important;
	}
	.doc_li_down {
		justify-content: center;
	}
	.search_btn {
		width: 100px;
	    height: 70px;
	    display: block;
	    background-color: #436DFF;
	    color: #fff;
	    cursor: pointer;
	    padding: 22px 20px;
	    box-sizing: border-box;
	    font-weight: 500;
	    font-size: 17px;
	    padding-left: 45px;
	    position: relative;
	}
	.search_btn_after {
		display: block;
	    content: '';
	    position: absolute;
	    background: url(../resources/images/ico_search_w.png) no-repeat center / cover;
	    top: 50%;
	    left: 20px;
	    width: 19px;
	    height: 19px;
	    transform: translateY(-50%);
	}
	.search_box {
		width: 840px;
		height: 70px;
	    padding-left: 60px;
	    background: url(../resources/images/ico_search.png) no-repeat 20px center;
	    outline: none;
	    box-sizing: border-box;
	    border: 1px solid #436DFF;
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
				<div class="doc_list bg_w">
					<div class="list_top">
						<div class="doc_li_down">
							<form action="hospitalSearchListName" method="post" style="display: flex;">
								<input class="search_box" type="text" name="hpName" placeholder="병원명을 입력해주세요." maxlength="10">
								<label class="search_btn" for="search_btn">검색
									<input class="d-none" id="search_btn" type="submit" value="검색">
									<span class="search_btn_after"></span>
								</label>
							</form>
						</div>
					</div>
					<div class="list_mid">
						<span class="subtit f_s20 f_w700">협력병원 목록</span>
					</div>
					<table class="table_sty01">
						<colgroup>
							<col width="120px">
							<col width="250px">
							<col width="140px">
							<col width="">
							<col width="160px">
							<col width="110px">
							<col width="110px">
						</colgroup>
						<thead style="fon">
							<tr>
								<th class="text-center">병원코드</th>
								<th class="text-left">병원명</th>
								<th class="text-center">대표번호</th>
								<th class="text-center">주소</th>
								<th class="text-center">등록일</th>
								<th class="text-center">탈퇴여부</th>
								<th class="text-center">수정</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="hospital" items="${ hospitalList }">
								<tr> 
									<td class="text-center">${ hospital.hpId }</td>
									<td style="text-align: left;">${ hospital.hpName }</td>
									<td class="text-center">${ hospital.hpNumber }</td>
									<td style="text-align: left; padding: 10px;">${ hospital.hpAddress }</td>
									<td class="text-center">
										<fmt:formatDate value="${ hospital.createdAt }" pattern="yyyy-MM-dd"/>
									</td>
									<c:if test="${ hospital.quit == '0' }">
										<td class="text-center">승인</td>
									</c:if>
									<c:if test="${ hospital.quit == '1' }">
										<td class="text-center c_r">미승인</td>
									</c:if>
									<td><span class="pencil"><a href="hospitalUpdate?hpId=${ hospital.hpId }">수정</a></span></td>
								</tr>
							</c:forEach>
							<c:if test="${ empty hospitalList }">
								<tr>
									<td class="text-center" colspan="7">검색결과가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>