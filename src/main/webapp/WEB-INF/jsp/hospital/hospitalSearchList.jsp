<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<%@include file ="/resources/header/header.jspf" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>list</title>
	<link rel="stylesheet" href="../resources/css/default.css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="../resources/js/jquery-1.11.2.min.js"></script>
	<script src="../resources/js/swiper.min.js"></script>
	<script src="../resources/js/design.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
/*************************************************************/
/*                     협력병원 현황 페이지                                                       */
/*************************************************************/
	.table-responsive {
		height: 580px;
	}
	.table-responsive table a{
		font-weight: 600;
		color: black;
	}
	.table-responsive table a:hover{
		text-decoration:underline;
		color: #3378c1;
	}
	.table-responsive th{
		text-align: center;
		font-weight: bold;
		background-color: #3378c1;
		color: #fff;
	}
	.table-responsive td{
		background-color: #fff;
	}
	.image-container {
	    position: relative;
	    display: inline-block;
	    background-color: #fff;
	    max-width: 410px;
	    height: 580px;
	}
	
	/* 이미지 크기와 위치 */
	.image-container img {
	    width: 410px;
	    height: 570px;
	    display: block;
	    opacity: 0.5;
	}
	
	/* 지역 링크 스타일 */
	.region-link {
	    position: absolute;
	    font-weight: 500;
	    text-decoration: none;
	    padding: 5px;
	    border-radius: 5px;
	    color: black;
	}
	
	/* Hover 상태 추가 */
	.region-link:hover {
    background-color: #3378c1;
    color: #fff;
	}
	
	/* 각 지역의 위치를 조정 */
	.region-link:nth-child(2) { top: 40px; left: 150px; }  /* 서울특별시 */
	.region-link:nth-child(3) { top: 80px; left: 160px; } /* 경기도 */
	.region-link:nth-child(4) { top: 50px; left: 70px; } /* 인천광역시 */
	.region-link:nth-child(5) { top: 40px; left: 260px; } /* 강원도 */
	.region-link:nth-child(6) { top: 140px; left: 200px; } /* 충청북도 */
	.region-link:nth-child(7) { top: 170px; left: 110px; } /* 충청남도 */
	.region-link:nth-child(8) { top: 190px; left: 190px; } /* 대전광역시 */
	.region-link:nth-child(9) { top: 260px; left: 130px; } /* 전라북도 */
	.region-link:nth-child(10) { top: 360px; left: 100px; } /* 전라남도 */
	.region-link:nth-child(11) { top: 320px; left: 130px; } /* 광주광역시 */
	.region-link:nth-child(12) { top: 170px; left: 290px; } /* 경상북도 */
	.region-link:nth-child(13) { top: 310px; left: 230px; } /* 경상남도 */
	.region-link:nth-child(14) { top: 250px; left: 280px; } /* 대구광역시 */
	.region-link:nth-child(15) { top: 290px; left: 310px; } /* 울산광역시 */
	.region-link:nth-child(16) { top: 330px; left: 310px; } /* 부산광역시 */
	.region-link:nth-child(17) { top: 520px; left: 50px; } /* 제주도 */
	.menu .title {
		margin-top: 140px;
	}
</style>

<body>
<!-- <div class="body_wrap" style="text-align: center;">
		<div class="content">
			<div class="con_wrap bg_13"> -->
				<!-- content시작 -->
<div class="container" style="margin-top: 20px;">
	<div style="max-width: 1200px; min-width: 1200px; margin: 20px auto 40px">
		<div class="row">
			<div class="image-container col">
				<img alt="대한민국" src="../resources/images/korea.jpg">
				
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=서울">서울특별시</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=경기">경기도</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=인천">인천광역시</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=강원">강원도</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=충북">충청북도</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=충남">충청남도</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=대전">대전광역시</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=전북">전라북도</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=전남">전라남도</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=광주">광주광역시</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=경북">경상북도</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=경남">경상남도</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=대구">대구광역시</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=울산">울산광역시</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=부산">부산광역시</a>
				<a class="region-link" href="hospitalSearchListRegion?hpRegion=제주">제주도</a>
			</div>
			<div class="table-responsive col">
				<table class="table table-bordered">
					<colgroup>
						<col width="200px">
						<col width="160px">
						<col width="">
					</colgroup>
					<thead>
						<tr>
							<th>병원명</th>
							<th>대표번호</th>
							<th>주소</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="hospital" items="${ hospitalList }">
							<tr>
								<td><a href="hospitalOne?hpId=${ hospital.hpId }">${ hospital.hpName }</a></td>
								<td class="text-center">${ hospital.hpNumber }</td>
								<td>${ hospital.hpAddress }</td>
							</tr>
						</c:forEach>
						<c:if test="${ empty hospitalList }">
							<tr>
								<td class="text-center" colspan="3">검색결과가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<%@include file ="/resources/footer/footer.jspf" %>
</body>
</html>