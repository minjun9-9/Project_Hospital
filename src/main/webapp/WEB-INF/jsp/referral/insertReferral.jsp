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
<title>진료의뢰서 작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css" />
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/design.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script>
	
// 소속에 따라 진료과 옵션을 변경하는 함수
function updateDepartments() {
	const rHpName = document.getElementById("rHpName");
	const rDeptName = document.getElementById("rDeptName");
	const selectedValue = rHpName.value;
	
	/* console.log(rHpName);
	console.log(rDeptName); */
	
	console.log(selectedValue);
	
	//진료과 ajax처리
	let vo = {};
	vo.hpId = selectedValue;
	/* console.log(vo); */
	console.log(JSON.stringify(vo));
	
	$.ajax("${pageContext.request.contextPath}/depts",{
		method : "POST",
		data : JSON.stringify(vo),
		contentType : "application/json",
		dataType : "json",
		
		success:function(data){
			/* alert("[성공]"); */
			console.log(data);
			
			let departments = {
				selectedValue:[]
			};
			
			$.each(data, function(index, obj){
				departments.selectedValue.push({
		            value: obj.deptId,  // deptId를 value로 사용
		            text: obj.deptName  // deptName을 text로 사용
		        });
			});
			
			// 드롭다운에 진료과 항목 추가
	        populateDepartmentDropdown(departments.selectedValue);
			
		},
		error : function(){
			alert("[실패]");
		}
	});
	
	// 드롭다운에 진료과를 동적으로 추가하는 함수
	function populateDepartmentDropdown(departments) {
	    let selectElement = $('#rDeptName');  // <select> 요소 선택
	    selectElement.empty();  // 기존 옵션을 지우기

	    // 기본 옵션 추가
	    selectElement.append(new Option("진료과를 선택하세요", "DEFAULT"));

	    // 서버에서 받은 진료과 목록을 추가
	    $.each(departments, function(index, dept) {
	        selectElement.append(
	            $('<option>', {
	                value: dept.value,
	                text: dept.text
	            })
	        );
	    });
	}
}



//진료과에 맞는 인원 목록을 동적으로 업데이트하는 함수
function updateDoctor() {
	console.log("updatePeople 시작");
	const rDeptName = document.getElementById("rDeptName");
   	console.log(rDeptName);
   	const selectedValue = rDeptName.value;
   	console.log(selectedValue); //데이터 선택
   	
  // ajax처리
	let vo = {};
	vo.deptId = selectedValue;
	/* console.log(vo); */
	console.log(JSON.stringify(vo));
	
	$.ajax("${pageContext.request.contextPath}/hpMembers",{
		method : "POST",
		data : JSON.stringify(vo),
		contentType : "application/json",
		dataType : "json",
		
		success:function(data){
			/* alert("[성공]"); */
			console.log(data);
			
			let departments = {
				selectedValue:[]
			};
			
			$.each(data, function(index, obj){
				departments.selectedValue.push({
		            value: obj.drId,  // drId를 value로 사용
		            text: obj.drName  // drName을 text로 사용
		        });
			});
			
			// 드롭다운에 진료과 항목 추가
	        populateDepartmentDropdown(departments.selectedValue);
			
		},
		error : function(){
			alert("[실패]");
		}
	});
	
	// 드롭다운에 진료과를 동적으로 추가하는 함수
	function populateDepartmentDropdown(departments) {
	    let selectElement = $('#rDrId');  // <select> 요소 선택
	    selectElement.empty();  // 기존 옵션을 지우기

	    // 기본 옵션 추가
	    selectElement.append(new Option("선택하세요", "DEFAULT"));

	    // 서버에서 받은 진료과 목록을 추가
	    $.each(departments, function(index, dr) {
	        selectElement.append(
	            $('<option>', {
	                value: dr.value,
	                text: dr.text
	            })
	        );
	    });
	}
}
	
//환자선택	
function updateUser(){
	console.log("환자선택")
	
	const userValue = userNum.value;
	
	console.log("userNum : "+userValue);
}	


window.addEventListener("load", function(){

	//파일 선택 이벤트 처리
	const uploadFileBtn = document.querySelector("#uploadFileBtn");
	const fileInput = document.querySelector("#fileInput");
	const fileText = document.querySelector("#fileText");
	const formData = new FormData();
	let files;
	let texts = '';
	
	uploadFileBtn.addEventListener("click", function(){
		fileInput.click();
	});
	
	fileInput.addEventListener("change", function(){
		files = fileInput.files; 
		if (files.length > 3) {
			alert("파일은 최대 3개까지 첨부할 수 있습니다");
			return false;
		}
		
		let dotIndex;
		for (let file of files) {
			if (file) {
				dotIndex = file.name.lastIndexOf(".");
				if (file.name.slice(dotIndex) !== '.jpg' && 
						file.name.slice(dotIndex) !== '.jpeg' && 
						file.name.slice(dotIndex) !== '.png' && 
						file.name.slice(dotIndex) !== '.gif') {
					alert("4가지 이미지 파일만 첨부 가능합니다(가능한 확장자 : jpg, jpeg, png, gif)");
					texts = '';
					fileText.value = '';
					fileInput.value = '';
					files = null;
					formData.delete('profileImage');
					return false;
				}
				texts += file.name + " / ";
				
				formData.append('profileImage', file);
			}
		}
		fileText.value = texts.slice(0, -3);
	});
	
	//파일 비우기 버튼
	let fileResetBtn = document.querySelector("#fileResetBtn");
	
	fileResetBtn.addEventListener("click", function() {
		texts = '';
		fileText.value = '';
		fileInput.value = '';
		files = null;
		formData.delete('profileImage');
	});
});

//의뢰내용 빈칸 체크
function validateForm() {
    // 의뢰내용 입력란 값 가져오기
    var referContent = document.querySelector("textarea[name='referContent']");

    // 의뢰내용이 비어있는지 확인
    if (referContent.value.trim() === "") {
        alert("의뢰내용을 입력해주세요.");  // 경고 메시지 표시
        referContent.focus();  // 의뢰내용 입력란에 포커스
        return false;  // 폼 제출을 막음
    }

    return true;  // 의뢰내용이 입력되었으면 폼 제출
}

</script>
</head>
<body>
	<div class="body_wrap">
	
		<%@include file="/resources/common/menu.jspf" %>
		
		<div class="content">
			<div class="top_bar bg_w">
				<a href="#" class="top_left doctor_con"><span>진료의뢰서 작성</span></a>
				<%@include file="/resources/common/profile.jspf" %>
			</div>
			<div class="con_wrap bg_13">
			<form action="insertReferral" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
				<!-- content시작 -->
					<div class="doctor">
						<div class="doc_left bg_w">
							<div class="doc_con">
								<p class="f_s17 f_w500">병원</p>
								<!-- <select id="doc_sel01" name="doc_sel01" onchange="updateDepartments()"> -->
								<select id="rHpName" name="rHpName" onchange="updateDepartments()">
									<option selected disabled>선택</option>
									<c:forEach var="vo" items="${hospitalList }">
										<option value="${vo.hpId }">${vo.hpName }</option>	
									</c:forEach>
								</select>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">진료과</p>
								<!-- <select id="doc_sel02" name="doc_sel02" onchange="updateDoctor()"> -->
								<select id="rDeptName" name="rDeptName" onchange="updateDoctor()">
									<option selected disabled>선택</option>
								</select>
							</div>
							<div class="doc_con">
								<%-- <p class="f_s17 f_w500">성명</p>
								<input type="text" placeholder="성명을 입력하세요" value="${admin.adminName }"> --%>
								 <p class="f_s17 f_w500">받을 의사</p>
							    <!-- <select id="personList" name="personList"> -->
							    <select id="rDrId" name="rDrId">
							      <option selected disabled>선택</option>
							    </select>
							</div>
							
							<div class="doc_con">
								 <p class="f_s17 f_w500">보낸 의사</p>
								<%-- <input type="text" id="sDrId" name="sDrId" value="${id }" readonly="readonly">
								<label for="sDrId">${name}</label> --%>
								<input type="text" id="sDrName" name="sDrName" value="${name}" readonly="readonly">
    							<input type="hidden" name="sDrId" value="${id}">
							</div>
							
							<div class="doc_con">
								 <p class="f_s17 f_w500">환자</p>
							    <!-- <select id="userList" name="userList" onchange="updateUser()"> -->
							    <select id="userNum" name="userNum" onchange="updateUser()">
							      <option selected disabled>선택</option>
								  <c:forEach var="user" items="${userList }">
										<option value="${user.userNum }">${user.userName }</option>	
								  </c:forEach>
							    </select>
							</div>
						</div>
						<div class="doc_right bg_w">
							<div class="doc_con">
								<p class="f_s17 f_w500">의뢰내용</p>
								<textarea name="referContent" placeholder="의뢰내용을 입력하세요">${referral.referContent}</textarea>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">결과</p>
								<textarea name="resultContent" placeholder="결과를 입력하세요" readonly="readonly">${referral.resultContent}</textarea>
							</div>
							
							<%-- <div class="doc_con">
								<p class="f_s17 f_w500">파일 등록</p>
								<div class="profile on">
									<a href="#" class="c_4 f_s15 f_w500">파일 선택</a>
									<div class="file f_s16 f_w400">업로드된_파일명.jpg</div>
									<span class="profile_img"><img src="${pageContext.request.contextPath}/resources/images/ico_plus.png" alt=""></span>
								</div>
								<div class="profile">
									<a href="#" class="c_4 f_s15 f_w500">파일 선택</a>
									<div class="file f_s16 f_w400">파일을 선택해 주세요.</div>
									<span class="profile_img"><img src="${pageContext.request.contextPath}/resources/images/ico_minus.png" alt=""></span>
								</div>
							</div> --%>
							<%-- <div class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">파일 등록<button type="button" id="fileResetBtn" class="ms-2 resetBtn"><img src="${pageContext.request.contextPath }/resources/images/reset.png"></button></p>
								<div class="d-flex align-items-center position-relative">
									<!-- 숨겨진 파일 입력 필드 -->
    								<input type="file" id="fileInput" name="file" class="form-control-file" style="display: none;" multiple="multiple"/>
									<input type="text" id="fileText" name="fileText" class="form-control flex-grow-1 bottomMargin" 
											placeholder="파일을 선택해 주세요" style="width: 80%; height: 50px;" readonly>
									<span style="width: 1%; text-align: center;"> </span>
									<button type="button" id="uploadFileBtn" class="btn btn-secondary text-nowrap" style="width: 19%; height: 50px; margin-bottom: 5.2px">파일 선택</button>
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
								</div>
							</div> --%>
						</div>
					</div>
					
					<div class="doc_bottom f_s16 f_w600">
						<input class="btn btn-primary btn-lg" type="submit" value="등록하기">
						<!-- <a href="#" class="bg_2">등록하기</a> -->
						<!-- <a href="#">목록으로</a> -->
						<button onclick="history.back()" class="btn btn-secondary btn-lg">목록으로</button>
					</div>
			</form>
			</div>
			<div class="footer bg_13 f_s15">2025 ITWILL.</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>	
</body>
</html>