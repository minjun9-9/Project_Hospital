<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
	.bottomMargin { margin-bottom: 5px; }
	.resetBtn { 
		background-color: white; 
		border: none;
	}
</style>
<title>의료진 등록</title>
<!-- 부트스트랩 링크  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<!-- Daum 주소 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 받은 파일 링크  -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/top-right.css" />
<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/design.js"></script>
<script>
	//한글 및 영문 정규식
	const regName = /^[a-zA-Z가-힣]+$/;
	//숫자만 가능한 정규식
	const regNum = /^\d+$/;
					   
	window.addEventListener("load", function(){
		//진료과목 추가 버튼 및 이벤트 처리
		let subjectCounter = 1;
		let subjectAddBtn = document.querySelector("#subjectAddBtn");
		subjectAddBtn.addEventListener("click", () => {
			const subjectHtml = 
				'<div class="subjectClose d-flex align-items-center position-relative" data-index="' + subjectCounter + '">' +
				'<input type="text" name="subjectDetail" class="subjectDetails form-control flex-grow-1 bottomMargin" placeholder="전문과목을 입력하세요" id="subject-' + careerCounter + '">' +
				'<button type="button" class="btn-close ms-2" onclick="subjectClose(' + subjectCounter + ')"></button>' +
				'</div>';
			document.querySelector("#subjectDiv")
				.insertAdjacentHTML('beforeend', subjectHtml);
			subjectCounter++;
		});
		
		//경력 추가 버튼
		let careerAddBtn = document.querySelector("#careerAddBtn");
		
		//경력 추가 버튼 이벤트 처리
		let careerCounter = 1;
		careerAddBtn.addEventListener("click", () => {
		    const careerHtml = 
		    '<div class="careerClose d-flex align-items-center position-relative" data-index="' + careerCounter + '">' +
		    '<input type="text" name="career" class="form-control flex-grow-1 careers bottomMargin" placeholder="경력을 입력하세요" id="career-' + careerCounter + '">' +
		    '<button type="button" class="btn-close ms-2" onclick="careerClose(' + careerCounter + ')"></button>' +
		    '</div>';
			document.querySelector("#careerDiv")
				.insertAdjacentHTML('beforeend', careerHtml);
			careerCounter++;
		});
		
		//학회 추가 버튼
		let academicAddBtn = document.querySelector("#academicAddBtn");
		
		let academicCounter = 1;
		academicAddBtn.addEventListener("click", () => {
			const academicHtml =
				'<div class="academicClose d-flex align-items-center position-relative" data-index="' + academicCounter + '">' +
				'<input type="text" name="academic" class="form-control flex-grow-1 academics bottomMargin" placeholder="학회를 입력하세요" id="academic-' + academicCounter + '">' +
				'<button type="button" class="btn-close ms-2" onclick="academicClose(' + academicCounter + ')"></button>' +
				'</div>';
			document.querySelector("#academicDiv")
				.insertAdjacentHTML('beforeend', academicHtml);
			academicCounter++;
		});
		
		//수상 추가 버튼
		let awardAddBtn = document.querySelector("#awardAddBtn");
		
		let awardCounter = 1;
		awardAddBtn.addEventListener("click", () => {
			const awardHtml =
				'<div class="awardClose d-flex align-items-center position-relative" data-index="' + awardCounter + '">' +
				'<input type="text" name="award" class="form-control flex-grow-1 awards bottomMargin" placeholder="수상경력을 입력하세요" id="award-' + awardCounter + '">' +
				'<button type="button" class="btn-close ms-2" onclick="awardClose(' + awardCounter + ')"></button>' +
				'</div>';
			document.querySelector("#awardDiv")
				.insertAdjacentHTML('beforeend', awardHtml);
			awardCounter++;
		});
		
		
		//파일 선택 이벤트 처리
		const uploadFileBtn = document.querySelector("#uploadFileBtn");
		const fileInput = document.querySelector("#fileInput");
		const fileText = document.querySelector("#fileText");
		const formData = new FormData();
		let files;
		let texts = '';
		
		uploadFileBtn.addEventListener("click", () => {
			fileInput.click();
		});
		
		fileInput.addEventListener("change", () => {
			files = fileInput.files; 
			if (files.length > 3) {
				alert("파일은 최대 3개까지 첨부할 수 있습니다");
				return false;
			}
			
			let dotIndex;
			for (let file of files) {
				if (file) {
					dotIndex = file.name.lastIndexOf(".");
					if (file.name.slice(dotIndex) !== '.jpg' && file.name.slice(dotIndex) !== '.jpeg' && 
							file.name.slice(dotIndex) !== '.png' && file.name.slice(dotIndex) !== '.gif') {
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
		
		fileResetBtn.addEventListener("click", () => {
			texts = '';
			fileText.value = '';
			fileInput.value = '';
			files = null;
			formData.delete('profileImage');
		});
		
		//주소값 비우기 버튼
		let addressCancleBtn = document.querySelector("#addressCancleBtn");
		
		addressCancleBtn.addEventListener("click", () => {
			let addressInputs = document.querySelectorAll(".addressDiv input");
			for (let addressInput of addressInputs) {
				addressInput.value = '';
			}
		});
		
		
		//등록버튼
		let registerBtn = document.querySelector("#register");
		
		//등록 이벤트
		registerBtn.addEventListener("click", () => {
			//필수값 체크
			
			//학력(공백x)
			let education = document.querySelector("#education");
			let educationValue = education.value.trim();
			if (educationValue === '') {
				alert("학력은 필수 입력 사항입니다!!");
				education.focus();
				return false;
			}
			
			//이름(공백x, 한글 및 영문만 가능)
			let doctorName = document.querySelector("#name");
			let doctorNameValue = doctorName.value.trim();
			if (!regName.test(doctorNameValue)) {
				alert("이름은 한글 및 영문만 가능하고 공백은 허용되지 않습니다!!");
				
				doctorName.focus();
				doctorName.value = '';
				return false;
			}
			
			//연락처
			let phone1 = document.querySelector("#phone1").value;
			let phoneInput2 = document.querySelector("#phone2");
			let phoneInput3 = document.querySelector("#phone3");
			
			let phone2 = phoneInput2.value.trim();
			let phone3 = phoneInput3.value.trim();
			
			if (phone2 === '' || phone3 === '') {
				alert("연락처는 필수 입력 사항입니다!!");
				if (phone2 === '') {
					phoneInput2.focus();
					return false;
				} else {
					phoneInput3.focus();
					return false;
				}
			}
			
			if (!regNum.test(phone2) || !regNum.test(phone3)) {
				alert("연락처는 숫자만 입력 가능합니다!!");
				if (!regNum.test(phone2)) {
					phoneInput2.focus();
					return false;
				} else {
					phoneInput3.focus();
					return false;
				}
			}
			
			let phone = `\${phone1}-\${phone2}-\${phone3}`;
			
			//주민번호
			let personNum1 = document.querySelector("#personNum1");
			let personNum2 = document.querySelector("#personNum2");
			
			let personNumValue1 = personNum1.value.trim();
			let personNumValue2 = personNum2.value.trim();
			
			if (personNumValue1 === '' || personNumValue2 === '') {
				alert("주민번호는 필수 입력 사항입니다!!");
				if (personNumValue1 === '') {
					personNum1.focus();
					return false;
				} else {
					personNum2.focus();
					return false;
				}
				
			}
			
			if (!regNum.test(personNumValue1) || !regNum.test(personNumValue2)) {
				alert("주민번호는 숫자만 입력 가능합니다!!");
				if (!regNum.test(personNumValue1)) {
					personNum1.focus();
					personNum1.value = '';
					return false;
				} else {
					personNum2.focus();
					personNum2.value = '';
					return false;
				}
			}
			
			if (personNumValue1.length !== 6) {
				alert("주민번호 앞 6자리를 입력해주세요!!");
				personNum1.focus();
				return false;
			}
			
			if (personNumValue2.length !== 1) {
				alert("주민번호 뒤 1자리만  입력해주세요!!");
				personNum2.focus();
				personNum2.value = '';
				return false;
			}
			
			let month = parseInt(personNumValue1.substr(2,2));
			let day = parseInt(personNumValue1.substr(4,2))
			if (!(1 <= month && month <= 12) || !(1 <= day && day <= 31)) {
				alert("주민번호 앞자리를 정확히 입력해주세요!!");
				personNum1.focus();
				personNum1.value = '';
				return false;
			}
			
			if (month == 2 && !(1 <= day && day <= 29)) {
				alert("주민번호 앞자리를 정확히 입력해주세요!!");
				personNum1.focus();
				personNum1.value = '';
				return false;
			} 
			
			if (!(1 <= personNumValue2 && personNumValue2 <= 4)) {
				alert("주민번호 뒷자리를 정확히 입력해주세요!!");
				personNum2.focus();
				personNum2.value = '';
				return false;
			}
			let personNum = `\${personNumValue1}-\${personNumValue2}******`;
			
			//주소
			let postcode = document.querySelector("#postcode").value;
			let address = document.querySelector("#address").value;
			let addressDetailInput = document.querySelector("#addressDetail");
			
			let addressDetail = addressDetailInput.value.trim();
			
			if (postcode === '' || address === '' || addressDetail === '') {
				alert("주소는 필수 입력 사항입니다!!");
				addressDetailInput.focus();
				return false;
			}
			
			let fullAddress = `\${address},\${addressDetail},\${postcode}`;
			
			
			//진료과
			let dept = document.querySelector("#dept").value;
			
			//직책
			let position = document.querySelector("#position").value;
			
			
			//여러개 입력 가능한 칸은 붙이기 처리 해야할듯(전문과목, 경력, 학회, 수상)
			//전문과목
			let subjectDetails = document.querySelectorAll(".subjectDetails");
			let subjectValues = [];
			for (let subject of subjectDetails) {
				if (subject.value.trim() !== '') {
					subjectValues.push(subject.value.trim());
				}
			}
			
			//경력
			let careers = document.querySelectorAll(".careers");
			let careerValues = [];
			for(let career of careers) {
				if (career.value.trim() !== '') {
					careerValues.push(career.value.trim());
				}
			}
			
			//학회
			let academics = document.querySelectorAll(".academics");
			let academicValues = [];
			for (let academic of academics) {
				if (academic.value.trim() !== '') {
					academicValues.push(academic.value.trim());
				}
			}
			
			//수상
			let awards = document.querySelectorAll(".awards");
			let awardValues = [];
			for (let award of awards) {
				if (award.value.trim() !== '') {
					awardValues.push(award.value.trim());
				}
			}
			
			//파일데이터는 위에서 끌어오기
			//1. 입력받은 값 객체에 데이터 채우기(/이름 / 연락처 / 주소 / 전문과목 / 진료과 / 직책 / 학력 / 경력 / 학회 / 수상 / 주민번호  ) id,pw 서버에서 제공 총 13개  / 파일별도(최대3개)
			const drInfo = {
				drName : doctorNameValue,
				drPhoneNum : phone,
				drAddress : fullAddress,
				drField : subjectValues,
				deptId : dept,
				drPersonNum : personNum,
				drPosition : position,
				drEducation : educationValue,
				drCareer : careerValues,
				drAcademic : academicValues,
				drAwards : awardValues,
			};
			formData.append("drInfo", JSON.stringify(drInfo));
			
			//2. 요청
			//값 체크 후 서버에 데이터 정송
			fetch("${pageContext.request.contextPath }/insertDrInfo",{
				method : "POST",
				body : formData
			})	//3. 요청 후 데이터 처리 유무 응답처리
				.then(response => {
					if (!response.ok) {
						throw new Error("Ajax 요청 에러발생" + response.statusText);
					}
					return response.json();
				})
				.then(message => {
					alert(message.msg);
					if (message.result === 'success') {
						//의료진 등록되면 페이지 새로고침해서 초기화
						location.reload(true);
					}
				})
				.catch(error => {
					alert(error); 
				})
		});
		
		
	});
	
	function subjectClose(index) {
		let subjectDiv = document.querySelector("#subjectDiv");
		let subjectInput = document.querySelector('.subjectClose[data-index="' + index + '"]');
		subjectDiv.removeChild(subjectInput);
	}
	function careerClose(index) {
		let careerDiv = document.querySelector("#careerDiv");
		let careerInput = document.querySelector('.careerClose[data-index="' + index + '"]');
		careerDiv.removeChild(careerInput);
	}
	function academicClose(index) {
		let academicDiv = document.querySelector("#academicDiv");
		let academicInput = document.querySelector('.academicClose[data-index="' + index + '"]');
		academicDiv.removeChild(academicInput);
	}
	function awardClose(index) {
		let awardDiv = document.querySelector("#awardDiv");
		let awardInput = document.querySelector('.awardClose[data-index="' + index + '"]');
		awardDiv.removeChild(awardInput);
	}
	function goMain() {
		location.href = 'adminMain';
	}
	
	//주소찾기 함수
	function searchAddress() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을 때 실행할 내용.
	            // 입력 필드 가져오기
	            const postcodeBox = document.querySelector("#postcode");
	            const addressBox = document.querySelector("#address");

	            // 도로명 주소 선택
	            if (data.roadAddress) {
	            	addressBox.value = data.roadAddress;
	            } else {
	                // 지번 주소 선택
	                addressBox.value = data.jibunAddress;
	            }

	            // 우편번호 값 설정
	            postcodeBox.value = data.zonecode;
	        }
	    }).open();
	}
</script>
</head>
<body>
<body>
    <div class="body_wrap">
	<!-- 사이드바 -->
		<%@ include file="WEB-INF/../../common/sidebar.jspf"%>
		
		<div class="content">
			<div class="top_bar bg_w">
				<a href="adminDoctorRegister" class="top_left doctor_con"><span>의료진 등록</span></a>
				<!-- 탑바 컨텐츠 -->
				<%@ include file="WEB-INF/../../common/topbarContent.jspf"%>
			</div>
			<div class="con_wrap bg_13">
				<!-- content시작 -->
					<div class="doctor">
						<div class="doc_left bg_w">
							<div>
								<p class="f_s17 f_w500 mb-3">진료과</p>
								<select id="dept" name="dept" class="form-select custom-select mb-3 py-2" style="width: 86%; height: 50px;">
									<c:forEach var="deptIdName" items="${deptIdNameList }">
										<option value="${deptIdName.deptId }">${deptIdName.deptName }</option>
									</c:forEach>
								</select>
							</div>
							<div>
								<p class="f_s17 f_w500 mb-3">직책</p>
								<select id="position" name="position" class="form-select custom-select mb-3 py-2" style="width: 86%; height: 50px;">
									<option>인턴</option>
									<option>레지</option>
									<option>과장</option>
									<option>교수</option>
								</select>
							</div>
							<div class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500 mb-3">학력*</p>
								<div class="d-flex align-items-center">
									<input type="text" id="education" name="education" class="form-control flex-grow-1" placeholder="학력을 입력하세요">
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
								</div>
							</div>
							<div class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">성명*</p>
								<div class="d-flex align-items-center">
									<input type="text" id="name" name="name" class="form-control flex-grow-1" placeholder="성명을 입력하세요">
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
								</div>
							</div>
							<div class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">연락처*</p>
								<div id="phoneDiv" class="d-flex align-items-center">
									<select id="phone1" name="phone1" class="form-select custom-select" 
										style="width: 20%; height: 50px; direction: ltr; appearance: auto;">
										<option selected>010</option>
										<option>011</option>
										<option>016</option>
										<option>017</option>
									</select>
									<span style="width: 5%; text-align: center; font-weight: bold;">-</span>
									<input type="text" id="phone2" name="phone2" class="form-control flex-grow-1" style="width: 35%;">
									<span style="width: 5%; text-align: center; font-weight: bold;">-</span>
									<input type="text" id="phone3" name="phone3" class="form-control flex-grow-1" style="width: 35%;">
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
								</div>
							</div>
							<div class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">주민번호*</p>
								<div class="d-flex align-items-center">
									<input type="text" id="personNum1" name="personNum1" class="form-control flex-grow-1" placeholder="앞 6자리를 입력해주세요" style="width: 40%; text-align: letf;">
									<span style="width: 5%; text-align: center; font-weight: bold;">-</span>
									<input type="text" id="personNum2" name="personNum2" class="form-control flex-grow-1" style="width: 10%; text-align: letf;">
									<span style="width: 45%; font-weight: bold; font-size: 1rem" class="ms-2">* * * * * * </span>
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
								</div>
							</div>
							<div class="addressDiv doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">주소*<button type="button" id="addressCancleBtn" class="ms-2 resetBtn"><img src="${pageContext.request.contextPath }/resources/images/reset.png"></button></p>
								<!-- <button type="button" id="addressCancleBtn" class="ms-2"><img src="${pageContext.request.contextPath }/resources/images/reset.png"></button> -->
								<div class="d-flex align-items-center mb-2">
									<input type="text" id="postcode" name="postcode" class="form-control flex-grow-1" placeholder="우편번호" style="width: 80%;" readonly>
									<span style="width: 1%;"> </span> <!-- 레이아웃용도 -->
									<button class="btn btn-secondary text-nowrap" type="button" style="width: 19%; height: 50px;" onclick="searchAddress()">주소검색</button>
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
								</div>
								<div class="d-flex align-items-center mb-2">
									<input type="text" id="address" name="address" class="form-control flex-grow-1" placeholder="기본주소" style="width: 80%;" readonly>
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
								</div>
								<div class="d-flex align-items-center">
									<input type="text" id="addressDetail" name="addressDetail" class="form-control flex-grow-1" placeholder="상세주소" style="width: 80%;">
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
								</div>
							</div>
						</div>
						<div class="doc_right bg_w">
							<div id="subjectDiv" class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">전문과목<button id="subjectAddBtn" class="btn btn-secondary btn-sm ms-2" type="button" style="height: 25px; line-height: normal;">추가</button></p>
								<div class="subjectClose d-flex align-items-center position-relative" data-index="0">
									<input type="text" name="subjectDetail" class="subjectDetails form-control flex-grow-1 bottomMargin" placeholder="전문과목을 입력하세요" id="subject-0">
									<button type="button" class="btn-close ms-2" onclick="subjectClose(0)"></button>
								</div>
							</div>
							<div id="careerDiv" class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">경력<button id="careerAddBtn" class="btn btn-secondary btn-sm ms-2" type="button" style="height: 25px; line-height: normal;">추가</button></p>
								<div class="careerClose d-flex align-items-center position-relative" data-index="0">
								    <input type="text" name="career" class="form-control flex-grow-1 careers bottomMargin" placeholder="경력을 입력하세요" id="career-0">
								    <button type="button" class="btn-close ms-2" onclick="careerClose(0)"></button>
							    </div>
							</div>
							<div id="academicDiv" class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">학회<button id="academicAddBtn" class="btn btn-secondary btn-sm ms-2" type="button" style="height: 25px; line-height: normal;">추가</button></p>
								<div class="academicClose d-flex align-items-center position-relative" data-index="0">
									<input type="text" name="academic" class="form-control flex-grow-1 academics bottomMargin" placeholder="학회를 입력하세요" id="academic-0">
									<button type="button" class="btn-close ms-2" onclick="academicClose(0)"></button>
								</div>
							</div>
							<div id="awardDiv" class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">수상<button id="awardAddBtn" class="btn btn-secondary btn-sm ms-2" type="button" style="height: 25px; line-height: normal;">추가</button></p>
								<div class="awardClose d-flex align-items-center position-relative" data-index="0">
									<input type="text" name="award" class="form-control flex-grow-1 awards bottomMargin" placeholder="수상경력을 입력하세요" id="award-0">
									<span><button type="button" class="btn-close ms-2" onclick="awardClose(0)"></button></span>
								</div>
							</div>
							<div class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">프로필 이미지<button type="button" id="fileResetBtn" class="ms-2 resetBtn"><img src="${pageContext.request.contextPath }/resources/images/reset.png"></button></p>
								<div class="d-flex align-items-center position-relative">
									<!-- 숨겨진 파일 입력 필드 -->
    								<input type="file" id="fileInput" name="ImgFile" class="form-control-file" style="display: none;" multiple/>
									<input type="text" id="fileText" name="fileText" class="form-control flex-grow-1 bottomMargin" 
											placeholder="파일을 선택해 주세요 (최대3개)" style="width: 80%; height: 50px;" readonly>
									<span style="width: 1%; text-align: center;"> </span>
									<button type="button" id="uploadFileBtn" class="btn btn-secondary text-nowrap" style="width: 19%; height: 50px; margin-bottom: 5.2px">파일 선택</button>
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
								</div>
							</div>
						</div>
					</div>
					<div class="doc_bottom f_s16 f_w600">
						<button type="button" id="register" class="btn btn-primary btn-lg text-nowrap" style="width: 25%;">등록하기</button>
						<button type="button" class="btn btn-dark btn-lg text-nowrap" style="width: 25%;" onclick="goMain()">메인으로</button>
					</div>
			</div>
			<div class="footer bg_13 f_s15">2025 ITWIll Medical Center All right Reserved.</div>
		</div>
	</div>

<!-- 부트스트랩 링크  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
	// 사이드바 토글 움직임
	document.querySelector('.drul').classList.add('on');
	document.querySelector('.drliregister').classList.add('on');
	
</script>	
</body>
</html>