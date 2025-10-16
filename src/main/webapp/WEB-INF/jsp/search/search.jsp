<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
    <%@include file = "/resources/header/header.jspf" %>
   <div class="container" style="margin-top: 100px;">
<style>
	.left-nav-a {
		list-style-type: none;
		color: black;
		width: 100%;
		display: block;
		padding: 6px 14px 6px 10px;
	}
	.left-nav li:hover {
	background-color: #115bab;
	cursor: pointer;
	}
	.left-nav li:hover .left-nav-a{
		text-decoration: underline;
		color: white;
	}
	.left-nav{
	width: 15%;
	}
	.left-nav ul {
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	.left-nav li {
		width: 100%;
		display: block;
	}
	.right-nav {
		align-items:flex-end;
		width: 60%;
	}
	.center-nav{
		width: 5%;
	}
	.card-footer:hover {
		background-color: #115bab;
		color: white;
	}
</style>
   		<div class="total-search" style="text-align: center; margin-bottom: 20px;">
   			<form action="<%=request.getContextPath() %>/search/search" method="get" style="margin-top: 30px;">
				<div class="form-container" style="justify-content: center;"><span style="font-size: 28px; color: #3378c1;">통합검색</span> 
					
				      <input class="form-control-search" type="search" id="searchQuery" name="query" placeholder="검색어를 입력하세요" value="${param.query != null? param.query : ''}" aria-label="Search" autocomplete="off" style="width: 40%; border-radius: 0px; border: 3px solid #3378c1;">
				      <button class="btn btn-outline-success" type="submit" style="height: 49.45px; background-color: #3378c1;">
				      	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" style="background-color:  #3378c1; color: white;" class="bi bi-search" viewBox="0 0 16 16">
							<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
						</svg>
				      </button>
				</div>
				</form>
   		</div>
   		<div style="display: flex;">
   		<div class="left-nav" >
   			<ul>
   				<li style="width: 100%; display: flex;"><a class="left-nav-a" >통합검색(${doctorCount+qnaCount })<a style="color:  white; align-content: center;">></a></a></li>
   				<li style="width: 100%; display: flex;"><a class="left-nav-a" >의료진(${doctorCount })<a style="color:  white; align-content: center;">></a></a></li>
   				<li style="width: 100%; display: flex;"><a class="left-nav-a" >건강정보()<a style="color:  white; align-content: center;">></a></a></li>
   				<li style="width: 100%; display: flex;"><a class="left-nav-a" >나눔소통(${qnaCount })<a style="color:  white; align-content: center;">></a></a></li>
   			</ul>
   		</div>
   		<div class="center-nav"></div>
   		<div class="right-nav">
   			<div style="background-color: #ededef; margin: 0 0 25px; padding: 24px 30px 22px 30px;"><span style="color: #3378c1;">${query }</span>  에 대한 검색결과  <span style="color: #3378c1;">(${doctorCount+qnaCount })건</span>이 있습니다.</div>
   			<div >
   				<c:if test="${doctorCount > 0 }">
   					<h1 style="margin-bottom: 30px; font-size: 24px;"><span style="font-weight: bold;">의료진</span> <span style="color: #3378c1;">(${doctorCount }건)</span></h1>
	   				<c:forEach var="doctor" items="${doctorResults}">
	   					<!-- <div style="width: 100%;">
		   					<div style="display: flex;">
		   						di
		   					</div>
		   					<div style="display: flex; width: 100%; ">
		   						<div style="width: 50%; text-align: center; align-content: center;"><a style="">상세소개</a></div>
		   						<div style="width: 50%; text-align: center; align-content: center;"><a style="">진료예약</a></div>
		   					</div>
	   					</div> -->
	   					<li class="doctor-profile" style="width: 100%; height: 244px; margin-bottom: 25px; background-color: white;">
			        		<div class="" style="display: flex;" >
			        			<div class="doctor-img" style="margin: 20px;">
			        				<c:if test="${empty doctor.fileOne }">
				        				<svg xmlns="http://www.w3.org/2000/svg" width="125" height="125" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
								        	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
								        	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
							        	</svg>
			        				</c:if>
			        				<c:if test="${not empty doctor.fileOne }">
			        					<img alt="${doctor.fileOne }" src="Doctor.Image" width="125" height="125"> 
			        				</c:if>
					        	</div>
			        			<div class="doctor-info" style="width: 100%; height: 175px; margin-left: 30px; margin-top: 15px;">
				        			<div class="doctor-info-names" style="display:flex; ">
				        				<h3 style="color: #115bab;">${doctor.drName}&nbsp</h3><h3> ${doctor.drPosition }</h3> <h3 style=" font-size: 1rem; align-content: center;">[${doctor.deptName}]</h3>
				       				</div>
				        			<strong>[진료분야]</strong><br><br>
				        			<span style="color: #72767e; font-weight: bold;">${ doctor.drField}</span>
				        		</div>
			        		</div>
			        		<div style="display: flex; margin:  0px; width: 100%; align-content: center; text-align: center;">
			        			<a href="" class="card-footer" style="width: 50%;"><div class="card-font" style="margin: 20px;">상세소개</div></a>
			        			<a href="javascript:void(0);" onclick="checkLogin()" class="card-footer" style="width: 50%;"><div class="card-font" style="margin: 20px;">진료예약</div></a>
			        		</div>
			        	</li>
	   				</c:forEach>
   				</c:if>
   				<c:if test="${doctorCount > 0 }">
   				
   				</c:if>
<script>
	function checkLogin() {
		var user = '<%= session.getAttribute("user")%>';
		
		if(!user || user ==="null"){
			alert("로그인 후 예약이 가능합니다.");
			window.location.href = "<%=request.getContextPath() %>/user/login/login";
		} else {
			window.location.href = "<%=request.getContextPath() %>/reservation/reservationInsert?hpId=SSW&userNum="+"${sessionScope.user.userNum}";
		}
	}
</script>
   			</div>
   		</div>
   		</div>
   </div>
    <%@include file ="/resources/footer/footer.jspf" %>

    
</body>
</html>
