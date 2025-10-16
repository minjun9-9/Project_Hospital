<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<%@include file ="/resources/header/header.jspf" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>reservation</title>
	<link rel="stylesheet" href="../resources/css/default.css" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<script src="../resources/js/jquery-1.11.2.min.js"></script>
	<script src="../resources/js/swiper.min.js"></script>
	<script src="../resources/js/design.js"></script>
	<!-- 달력 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="../resources/js/datepicker-ko.js"></script>
</head>

<style>
	a {
		color: inherit;
	}
	.rs_user {
		display: flex;
		gap: 21px;
		background-color: #595f6a;
		margin-bottom: 20px;
	}
	.rs_user_info {
		font-size: 24px;
		text-align: center;
		background-color: #596083;
		color: yellow;
		padding: 124px 0px;
		min-width: 250px;
    	max-width: 250px;
	}
	.rs_user_one {
		display: flex;
		flex-direction: column;
		gap: 21px;
		font-size: 16px;
		color: #fff;
		padding: 40px 0px;
		min-width: 320px;
    	max-width: 320px;
	}
	.rs_seq {
		display: flex;
		background-color: #e4e7ea;
		font-size: 20px;
    	padding: 10px 0px;
    	margin-bottom: 20px;
	}
	.rs_seq_step {
		margin-bottom: 4px;
    	font-size: 18px;
		color: #72767e;
	}
	.rs_seq_dept {
		min-width: 270px;
		max-width: 270px;
		text-align: center;
		padding: 7px;
	}
	.rs_seq_hpMember {
		min-width: 400px;
		max-width: 400px;
		text-align: center;
		padding: 7px;
	}
	.rs_seq_date {
		min-width: 350px;
		max-width: 350px;
		text-align: center;
		padding: 7px;
	}
	.rs_seq_time {
		min-width: 180px;
		max-width: 180px;
		text-align: center;
		padding: 7px;
	}
	.rs_seq_sel {
		display: flex;
		height: 500px;
	}
	.rs_deptList {
		display: flex;
    	flex-wrap: wrap;
    	align-content: baseline;
    	text-align: center;
    	font-size: 14px;
    	padding: 7px;
    	min-width: 270px;
    	max-width: 270px;
	}
	.rs_dept {
		flex: 1 calc(40%);
		padding: 10px;
	}
	.rs_dept:hover {
		background-color: #3378c1;
    	color: #fff;
	}
	.rs_deptName {
		background-color: #007aff;
    	color: #fff;
    	font-size: 16px;
    	padding: 4px;
    	text-align: center;
	}
	.rs_hpMemberbox {
		overflow-y: auto;
    	height: 466px;
	}
	.rs_hpMemberList {
		padding: 7px;
		min-width: 400px;
    	max-width: 400px;
	}
	.rs_hpMember {
		display: flex;
		align-items: center;
		padding: 7px 0px;
	}
	.rs_hpMember_img {
		width: 140px;
		height: 140px;
	}
	.rs_date {
		font-size: 20px;
		padding: 7px;
		min-width: 350px;
    	max-width: 350px;
	}
	.rs_timeList {
		display: flex;
		flex-wrap: wrap;
		align-content: baseline;
		overflow-y: auto;
		height: 486px;
		padding: 7px;
		min-width: 180px;
		max-width: 180px;
	}
	.rs_time {
		flex: 1 calc(40%);
		text-align: center;
	}
	.rs_timeYbutton:hover {
		background-color: #3378c1;
		color: #fff;
		cursor: pointer;
	}
	.rs_timeYbutton {
		border: none;
		font-size: 12px;
		padding: 10px;
	}
	.rs_timeNbutton {
		border: none;
		padding: 10px;
	}
	.modal {
	  display: none;
	  position: fixed;
	  z-index: 1;
	  align-content: center;
	  top: 0px;
	  bottom: 0px;
	  left: 0px;
	  right: 0px;
	  overflow: auto;
	  background-color: rgba(0, 0, 0, 0.4);
	}
	.modal-content {
	  background-color: white;
	  margin: auto;
	  padding: 20px;
	  border: 1px solid #888;
	  width: 500px;
	  height: 440px;
	}
	.close {
	  color: #aaa;
	  float: right;
	  font-size: 28px;
	  font-weight: bold;
	}
	.close:hover, .close:focus {
	  color: black;
	  text-decoration: none;
	  cursor: pointer;
	}
	.rs_btnY {
		font-size: 18px;
		margin: 10px;
		border-radius: 0.375rem;
		font-weight: 400;
		width: 120px;
		height: 40px;
		border: none;
		border-color: #0d6efd;
		color: #fff;
		background-color: #0d6efd;
	}
	.rs_btnN {
		font-size: 18px;
		margin: 10px;
		border-radius: 0.375rem;
		font-weight: 400;
		width: 120px;
		height: 40px;
		border: none;
		border-color: #6c757d;
		color: #fff;
		background-color: #6c757d;
	}
	.rs_btnY:hover {
		cursor: pointer;
		color: #fff;
		background-color: #0b5ed7;
		border-color: #0a58ca;
	}
	.rs_btnN:hover {
		cursor: pointer;
		color: #fff;
		background-color: #5c636a;
		border-color: #565e64;
	}
	.ui-widget.ui-widget-content {
    border: none;
	}
	.ui-widget-header {
    border: none;
    background-color: #fff;
</style>

<body>
<!-- <div class="body_wrap">
		<div class="content">
			<div class="con_wrap bg_13"> -->
				<!-- content시작 -->
<div class="container">
	<div style="width: 1200px; margin: 20px auto 40px">
		<div class="rs_user">
			<div class="rs_user_info">회원정보</div>
			<div class="rs_user_one">
				<div>이름 : ${ userClientOne.userName }</div>
				<div>환자번호 : ${ userClientOne.userNum }</div>
				<c:if test="${ userClientOne.userGender == 'M' }">
					<div>성별 : 남자</div>
				</c:if>
				<c:if test="${ userClientOne.userGender == 'F' }">
					<div>성별 : 여자</div>
				</c:if>
				<div>전화번호 : ${ userClientOne.userPhoneNum }</div>
				<div>이메일 : ${ userClientOne.userEmail }</div>
			</div>
			<c:if test="${ userClientOne.guardianName != null }">
				<div class="rs_user_one">
					<div>보호자 이름 : ${ userClientOne.guardianName }</div>
					<div>보호자 전화번호 : ${ userClientOne.guardianPhoneNum }</div>
					<div>보호자 이메일 : ${ userClientOne.guardianEmail }</div>
				</div>
			</c:if>
		</div>
		<div class="rs_seq">
			<div class="rs_seq_dept">
				<div class="rs_seq_step">STEP 1</div>
				진료과 선택
			</div>
			<div class="rs_seq_hpMember">
				<div class="rs_seq_step">STEP 2</div>
				의료진 선택
			</div>
			<div class="rs_seq_date">
				<div class="rs_seq_step">STEP 3</div>
				날짜 선택
			</div>
			<div class="rs_seq_time">
				<div class="rs_seq_step">STEP 4</div>
				시간 선택
			</div>
		</div>
		<div class="rs_seq_sel">
			<div class="rs_deptList">
				<c:forEach var="dept" items="${ deptList }">
					<div class="rs_dept">
						<a onclick="hpMemberSearchList('${ dept.deptId }', '${ dept.deptName }', '${ userClientOne.userNum }')" href="#">${ dept.deptName }</a>
					</div>
				</c:forEach>
			</div>
			<div class="rs_hpMemberList" id="hpMemberList"></div>
			<div class="rs_date" id="date"></div>
			<div class="rs_timeList" id="openingTimeTable"></div>
		</div>
	</div>
</div>
<div id="modal" class="modal">
	<div class="modal-content">
		<div style="width: 460px; height: 300px;" id=reservationInsert></div>
  	</div>
</div>
<script>
	let rsuserNum = "";
	let rsdeptId = "";
	let rsyearDate = "";
	function hpMemberSearchList(deptId, deptName, userNum) {
		rsuserNum = userNum;
		rsdeptId = deptId;
		
		$.ajax("hpMemberSearchListJson", {
			method: "post",
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify({
				deptId : deptId
			}),
			
			success: function(data){
				
				let dispHtml = "<div class='rs_deptName'>" + deptName + "</div>";
				dispHtml += "<div class='rs_hpMemberbox'>";
				
				for (let hpMember of data) {
					dispHtml += "<div class='rs_hpMember'>";
					dispHtml += "<div>";
					dispHtml += (hpMember.fileone ? 
								"<img class='rs_hpMember_img' alt='프로필사진' src='/hospital/images/DrProfiles/"+ hpMember.fileone+".png'>"
								:
									'<svg xmlns="http://www.w3.org/2000/svg" width="140" height="140" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">' +
	                                '<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>' +
	                                '<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>' +
	                                '</svg>'	
								);
					dispHtml += "</div>";
					dispHtml += "<div style='padding: 11px;'>";
					dispHtml += "<a onclick='openingTimeTableList(\"" + hpMember.drId + "\")' href='#' class='f_s20 f_w600'>";
					dispHtml += hpMember.drName + " " + hpMember.drPosition;
					dispHtml += "</a>";
					dispHtml += "<div style='margin-top: 10px;' class='f_s14'>진료분야 : " + hpMember.drField + "</div>";
					dispHtml += "</div>";
					dispHtml += "</div>";
				}
				dispHtml += "</div>";
				
				$("#hpMemberList").html(dispHtml);
				$("#date").datepicker("destroy");
				$("#openingTimeTable").html("");
			},
			error: function(){
				alert("실패");
			}
		});
	}
	
	function openingTimeTableList(drId) {
		$("#date").datepicker("destroy");
		$("#openingTimeTable").html("");
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		
		$.ajax("openingTimeListJson", {
			method: "post",
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify({ drId : drId }),
			
			success: function(data){
				var yearDates = data;
				
				$("#date").datepicker({
					dateFormat: "yy-mm-dd",
					minDate: 1,
					beforeShowDay: function(date) {
						for(var i = 0; i < yearDates.length; i++) {
							var yearDate = new Date(yearDates[i]);
							
							if(date.getFullYear() === yearDate.getFullYear() &&
								date.getMonth() === yearDate.getMonth() &&
								date.getDate() === yearDate.getDate()) {
								return [true, ""];
							}
						}
						return [false, "ui-state-disabled"];
					},
					onSelect: function (dateText, inst) {
						rsyearDate = dateText;
						var selectDate = new Date(dateText);
						selectDate.setHours(0, 0, 0, 0);
						
						$.ajax("openingTimeTableListJson", {
							method: "post",
							contentType: "application/json",
							dataType: "json",
							data: JSON.stringify({
								yearDate : dateText,
								drId : drId
							}),
							
							success: function(data){
								let currentTime = new Date();
								let count = 0;
								let am = false;
								let pm = false;
								let dispHtml = "";
								
								for (let openingTimeTable of data) {
									
									if(openingTimeTable.otState == "정상진료") {
										let timeParts = openingTimeTable.time.split(":");
										let openingTime = new Date(selectDate.getFullYear(), selectDate.getMonth(), selectDate.getDate(), timeParts[0], timeParts[1]);
										
										if(currentTime < openingTime) {
											dispHtml += "<div class='rs_time'>";
											dispHtml += "<button class='rs_timeYbutton' onclick='openModal(" + openingTimeTable.otId + ")'>";
											dispHtml += openingTimeTable.time;
											dispHtml += "</button>";
											dispHtml += "</div>";
										}
									}
		/*							if(openingTimeTable.otState == "휴진-진료없음") {
										if(count < 2) {
											if(openingTimeTable.timeType == "오전" && !am) {
												dispHtml += "<div class='rs_time'>";
												dispHtml += "<button class='rs_timeNbutton' readonly>";
												dispHtml += openingTimeTable.timeType + " " + openingTimeTable.otState;
												dispHtml += "</button>";
												dispHtml += "</div>";
												am = true;
												count++;
											}
											else if(openingTimeTable.timeType == "오후" && !pm) {
												dispHtml += "<div class='rs_time'>";
												dispHtml += "<button class='rs_timeNbutton' readonly>";
												dispHtml += openingTimeTable.timeType + " " + openingTimeTable.otState;
												dispHtml += "</button>";
												dispHtml += "</div>";
												pm = true;
												count++;
											}
										}
									}
		*/						}
								if(data.length === 0) {
									dispHtml += "<div>";
									dispHtml += "예약 가능한 시간이 없습니다.";
									dispHtml += "</div>";
								}
								
								$("#openingTimeTable").html(dispHtml);
							},
							error: function(){
								alert("실패");
							}
						});
					}
				});
			},
			error: function(){
				alert("실패");
			}
		});
	}
	function openModal(otId) {
		$.ajax("reservationInsertCheckJson", {
			method: "post",
			contentType: "application/json",
			dataType: "json",
			data: JSON.stringify({
				userNum : rsuserNum,
				deptId : rsdeptId,
				yearDate : rsyearDate
			}),
			
			success: function(data){
				document.getElementById("modal").style.display = "block";
				
				$.ajax("reservationInsertJson", {
					method: "post",
					contentType: "application/json",
					dataType: "json",
					data: JSON.stringify({
						otId : otId
					}),
					
					success: function(data){
						let dispHtml = "<div style='font-size: 20px; margin-bottom: 5px;'>";
						dispHtml +="예약일시";
						dispHtml +="</div>";
						dispHtml +="<div style='font-size: 18px;'>";
						dispHtml +=data.yearDate + " " + data.time;
						dispHtml +="</div>";
						dispHtml +="<div>";
						dispHtml +="<form action='reservationInsert' method='post'>";
						dispHtml +="<div style='font-size: 18px; text-align: center;'>";
						dispHtml +="진료예약사유";
						dispHtml +="</div>";
						dispHtml +="<div style='font-size: 16px; text-align: center; padding: 6px 10px;'>";
						dispHtml +="<textarea style='resize: none; outline: none;' name='reservContent' rows='10' cols='40' required "
						dispHtml +="placeholder='진료의뢰서,진단서 등에서 기입된 병명과 의뢰사유를 간단하게 작성해주시면 됩니다. 예시)위암 수술,위암 의심' maxlength='80'>"
						dispHtml +="</textarea>";
						dispHtml +="</div>";
						dispHtml +="<div style='text-align: center;'>";
						dispHtml +="<input class='rs_btnY' type='submit' value='예약하기'>";
						dispHtml +="<input class='rs_btnN' type='button' value='취소하기' onclick='closeModal()'>";
						dispHtml +="<input type='hidden' name='otId' value='" + data.otId + "'>";
						dispHtml +="<input type='hidden' name='drId' value='" + data.drId + "'>";
						dispHtml +="<input type='hidden' name='userNum' value='" + rsuserNum + "'>";
						dispHtml +="</div>";
						dispHtml +="</form>";
						dispHtml += "</div>";
						$("#reservationInsert").html(dispHtml);
					},
					error: function(){
						alert("실패");
					}
				});
			},
			error: function(jqXHR, textStatus, errorThrown){
				alert("해당진료과는 해당날짜에 이미 예약이 되어있습니다.");
			}
		});
	}

	function closeModal() {
		document.getElementById("modal").style.display = "none";
		$("#reservationInsert").html("");
	}
	
</script>
<%@include file ="/resources/footer/footer.jspf" %>
</body>
</html>