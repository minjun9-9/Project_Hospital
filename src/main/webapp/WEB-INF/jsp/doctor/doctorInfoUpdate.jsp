<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	.bottomMargin { margin-bottom: 5px; }
	.resetBtn { 
		background-color: white; 
		border: none;
	}
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
	}
	
	.row-container {
	    display: flex;
	    align-items: center; 
	    justify-content: space-between; 
	}
	
	.text-container {
	    flex: 1; 
	    text-align: center; 
	    margin-left: 30px;
	}
	
	.img-container {
	    flex: 0; 
	    margin-right: 10px;
	}
	.img-container img {
	    max-width: 30px; 
	}
	.profileFont {
		color: #4BA6FF; 
		font-weight: normal;
	}
	.hoverArea:hover {
		cursor: pointer;
	}
	#deptHeadCheck:hover {
		cursor: pointer;
	}
	
</style>
<title>의료진 수정</title>
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
	const contextPath = '/hospital';
	
	//한글 및 영문 정규식
	const regName = /^[a-zA-Z가-힣]+$/;
	//숫자만 가능한 정규식
	const regNum = /^\d+$/;
	
	window.addEventListener("load", function(){
		const deptSelectTag = document.querySelector("#dept");
		const positionSelectTag = document.querySelector("#position");
		const phone1SelectTag = document.querySelector("#phone1");
		
		//진료과 selected 처리
		let deptOptions = deptSelectTag.options;
		let drInfoVODept = "${drInfoVO.deptId}";
		for (let option of deptOptions) {
			if (drInfoVODept === option.value) {
				option.setAttribute("selected", "selected");
			}
		}
		
		//직책 selected 처리
		let positionOptions = positionSelectTag.options;
		let drInfoVOPosition = "${drInfoVO.drPosition}";
		for (let option of positionOptions) {
			if (drInfoVOPosition === option.value) {
				option.setAttribute("selected", "selected");
			}
		}
		//진료 과장 클릭 이벤트
		let deptHeadCheck = false;
		const deptHeadCheckBox = document.querySelector("#deptHeadCheck");
		deptHeadCheckBox.addEventListener("click", () => {
			let lastDotIndex = deptHeadCheckBox.getAttribute("src").lastIndexOf(".");
			let lastSlashIndex = deptHeadCheckBox.getAttribute("src").lastIndexOf("/");
			let checkImgName = deptHeadCheckBox.getAttribute("src").slice(lastSlashIndex + 1, lastDotIndex);
			if (checkImgName === "check_off") {
				deptHeadCheckBox.setAttribute("src", contextPath + "/resources/images/check_on.png");
				deptHeadCheck = true;
			} else if (checkImgName === "check_on") {
				deptHeadCheckBox.setAttribute("src", contextPath + "/resources/images/check_off.png");
				deptHeadCheck = false;
			}
		})
		
		//전화번호 앞자리 selected 처리
		let phone1Options = phone1SelectTag.options;
		let drInfoVOPhoneNum = "${drInfoVO.drPhoneNum}";
		for (let option of phone1Options) {
			if (drInfoVOPhoneNum.slice(0,3) === option.value) {
				option.setAttribute("selected", "selected");
			}
		}
		
		//파일 관련 작업------------------------
		//프로필이미지 데이터 입력
		const profileImgArr = document.querySelectorAll(".profileImg");
		const profileTextDivArr = document.querySelectorAll(".profileTextDiv");
		
		const hiddenForProfileArr = document.querySelectorAll(".hiddenForProfile");
		let tmp = document.querySelectorAll(".hiddenForProfileOriginalName");
		for (let i = 0; i < hiddenForProfileArr.length; i++) {
			if (hiddenForProfileArr[i].value !== "noProfile") {
				profileImgArr[i].setAttribute("src", "${pageContext.request.contextPath }" + hiddenForProfileArr[i].value);
				profileTextDivArr[i].innerHTML = document.querySelectorAll(".hiddenForProfileOriginalName")[i].value; 
			}
		}
		
		//파일 선택 이벤트 처리
		let fileArr = [null, null, null];
		const fileInputArr = document.querySelectorAll(".fileInputs");
		
		for (let i = 0; i < profileImgArr.length; i++) {
			profileImgArr[i].addEventListener("click", () => {
				fileInputArr[i].click();
			});
		}
		
		for (let i = 0; i < fileInputArr.length; i++) {
			fileInputArr[i].addEventListener("change", () => {
				let result = fileChange(fileInputArr[i], fileArr[i], profileTextDivArr[i], profileImgArr[i]);
				if (result === "notImage") {
					alert("4가지 이미지 파일만 첨부 가능합니다(가능한 확장자 : jpg, jpeg, png, gif)");
					return false;
				} else {
					fileArr[i] = result;
				}
			});
		}
		
		
		//파일 비우기 버튼
		let resetImgBtn = document.querySelectorAll(".resetImg");
		
		const hiddenForProfileFilestoreIdArr = document.querySelectorAll(".hiddenForProfileFilestoreId");
		let existFiles = [null, null, null];
		
		for (let i = 0; i < resetImgBtn.length; i++) {
			resetImgBtn[i].addEventListener("click", () => {
				profileImgArr[i].setAttribute("src", "${pageContext.request.contextPath }/resources/images/photo.png");
				profileTextDivArr[i].innerHTML = "프로필 이미지 없음";
				if (hiddenForProfileFilestoreIdArr[i]) {
					existFiles[i] = i;
				}
				fileArr[i] = null;
				fileInputArr[i].value = "";
			});
		}
		
		//--------------------------
		
		//학력 데이터 입력
		document.querySelector("#education").value = "${drInfoVO.drEducation}";
		
		
		//셩명 데이터 입력
		document.querySelector("#name").value = "${drInfoVO.drName}";
		
		//전화번호 데이터 입력  
		document.querySelector("#phone2").value = drInfoVOPhoneNum.slice(4,8);
		document.querySelector("#phone3").value = drInfoVOPhoneNum.slice(9);
		
		
		//주소 데이터 입력
		let getAddress = "${drInfoVO.drAddress}";
		let addressArr = getAddress.split(",");
		
		document.querySelector("#postcode").value = addressArr[2];
		document.querySelector("#address").value = addressArr[0];
		document.querySelector("#addressDetail").value = addressArr[1];
		
		//전문과목 데이터 입력
		let getField = "${drInfoVO.drField}";
		let fieldArr = getField.split(",");
		if (fieldArr.length == 1 && fieldArr[0] == "") {
			fieldArr = null;
		}
		
		//전문과목 추가 버튼
		let subjectAddBtn = document.querySelector("#subjectAddBtn");
		
		let subjectCounter = 1;
		
		if (fieldArr != null) {
			document.querySelector("#subject-0").value = fieldArr[0];
			if (fieldArr.length > 1) {
				for (subjectCounter = 1; subjectCounter < fieldArr.length; subjectCounter++) {
					document.querySelector("#subjectDiv").insertAdjacentHTML('beforeend', 
							'<div class="subjectClose d-flex align-items-center position-relative" data-index="' + subjectCounter + '">' +
							'<input type="text" name="subjectDetail" class="subjectDetails form-control flex-grow-1 bottomMargin" placeholder="전문과목을 입력하세요" id="subject-' + subjectCounter + '">' +
							'<button type="button" class="btn-close ms-2" onclick="subjectClose(' + subjectCounter + ')"></button>' +
							'</div>');
					document.querySelector("#subject-" + subjectCounter).value = fieldArr[subjectCounter];
				}
			}
		}
		
		//진료과목 추가 버튼 및 이벤트 처리
		subjectAddBtn.addEventListener("click", () => {
			const subjectHtml = 
				'<div class="subjectClose d-flex align-items-center position-relative" data-index="' + subjectCounter + '">' +
				'<input type="text" name="subjectDetail" class="subjectDetails form-control flex-grow-1 bottomMargin" placeholder="전문과목을 입력하세요" id="subject-' + subjectCounter + '">' +
				'<button type="button" class="btn-close ms-2" onclick="subjectClose(' + subjectCounter + ')"></button>' +
				'</div>';
			document.querySelector("#subjectDiv")
				.insertAdjacentHTML('beforeend', subjectHtml);
			subjectCounter++;
		});
		
		
		
		//주소값 비우기 버튼
		let addressCancleBtn = document.querySelector("#addressCancleBtn");
		
		addressCancleBtn.addEventListener("click", () => {
			let addressInputs = document.querySelectorAll(".addressDiv input");
			for (let addressInput of addressInputs) {
				addressInput.value = '';
			}
		});
		
		//경력 데이터 입력
		let getCareer = "${drInfoVO.drCareer}";
		let careerArr = getCareer.split(",");
		if (careerArr.length == 1 && careerArr[0] == "") {
			careerArr = null;
		}
		
		//경력 추가 버튼
		let careerAddBtn = document.querySelector("#careerAddBtn");
		
		let careerCounter = 1;
		
		if (careerArr != null) {
			document.querySelector("#career-0").value = careerArr[0];
			if (careerArr.length > 1) {
				for (careerCounter = 1; careerCounter < careerArr.length; careerCounter++) {
					document.querySelector("#careerDiv").insertAdjacentHTML('beforeend', 
							'<div class="careerClose d-flex align-items-center position-relative" data-index="' + careerCounter + '">' +
						    '<input type="text" name="career" class="form-control flex-grow-1 careers bottomMargin" placeholder="경력을 입력하세요" id="career-' + careerCounter + '">' +
						    '<button type="button" class="btn-close ms-2" onclick="careerClose(' + careerCounter + ')"></button>' +
						    '</div>');
					document.querySelector("#career-" + careerCounter).value = careerArr[careerCounter];
				}
			}
		}
		
		//경력 추가 버튼 이벤트 처리
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
		
		//학회 데이터 입력
		let getAcademic = "${drInfoVO.drAcademic}";
		let academicArr = getAcademic.split(",");
		if (academicArr.length == 1 && academicArr[0] == "") {
			academicArr = null;
		}
		
		//학회 추가 버튼
		let academicAddBtn = document.querySelector("#academicAddBtn");
		
		let academicCounter = 1;
		
		if (academicArr != null) {
			document.querySelector("#academic-0").value = academicArr[0];
			if (academicArr.length > 1) {
				for (academicCounter = 1; academicCounter < academicArr.length; academicCounter++) {
					document.querySelector("#academicDiv").insertAdjacentHTML('beforeend', 
							'<div class="academicClose d-flex align-items-center position-relative" data-index="' + academicCounter + '">' +
							'<input type="text" name="academic" class="form-control flex-grow-1 academics bottomMargin" placeholder="학회를 입력하세요" id="academic-' + academicCounter + '">' +
							'<button type="button" class="btn-close ms-2" onclick="academicClose(' + academicCounter + ')"></button>' +
							'</div>');
					document.querySelector("#academic-" + academicCounter).value = academicArr[academicCounter];
				}
			}
		}
		
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
		
		//수상 데이터 입력
		let getAwards = "${drInfoVO.drAwards}";
		let awardsArr = getAwards.split(",");
		if (awardsArr.length == 1 && awardsArr[0] == "") {
			awardsArr = null;
		}
		
		//수상 추가 버튼
		let awardAddBtn = document.querySelector("#awardAddBtn");
		
		let awardCounter = 1;
		
		if (awardsArr != null) {
			document.querySelector("#award-0").value = awardsArr[0];
			if (awardsArr.length > 1) {
				for (awardCounter = 1; awardCounter < awardsArr.length; awardCounter++) {
					document.querySelector("#awardDiv").insertAdjacentHTML('beforeend', 
							'<div class="awardClose d-flex align-items-center position-relative" data-index="' + awardCounter + '">' +
							'<input type="text" name="award" class="form-control flex-grow-1 awards bottomMargin" placeholder="수상경력을 입력하세요" id="award-' + awardCounter + '">' +
							'<button type="button" class="btn-close ms-2" onclick="awardClose(' + awardCounter + ')"></button>' +
							'</div>');
					document.querySelector("#academic-" + awardCounter).value = awardsArr[awardCounter];
				}
			}
		}
		
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
		
		
		//수정하기 버튼
		const updateBtn = document.querySelector("#update");
		updateBtn.addEventListener("click", () => {
			//이름(공백x, 한글 및 영문만 가능)
			let doctorName = document.querySelector("#name");
			let doctorNameValue = doctorName.value.trim();
			if (!regName.test(doctorNameValue)) {
				alert("이름은 한글 및 영문만 가능하고 공백은 허용되지 않습니다!!");
				doctorName.focus();
				doctorName.value = '';
				return false;
			}
			
			//학력(공백x)
			let education = document.querySelector("#education");
			let educationValue = education.value.trim();
			if (educationValue === '') {
				alert("학력은 필수 입력 사항입니다!!");
				education.focus();
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
			
			//여러개 입력 가능한 칸(전문과목, 경력, 학회, 수상)
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
			
			//아이디   (아이디는 수정하는게 아니라 조건용) 
			let drId = "${drInfoVO.drId}";
			
			//파일 FormData()에 담기
			const formData = new FormData();
			
			for (let i = 0; i < fileArr.length; i++) {
				if (fileArr[i]) {
					formData.append("profileImage", fileArr[i][0]); //주의 fileArr[i] file사용시  file이거 자체가 배열이라 [0] 이런식으로 인덱스 활용해야함
				} else { 
					if (existFiles[i] != null) {
						formData.append("profileImage", new Blob(), "exist_file#%" + i + ".txt"); // 빈 파일 대체
					} else {
						formData.append("profileImage", new Blob(), "empty_file#%" + i + ".txt"); // 빈 파일 대체
					}
				}
			}
			
			const filestoreIdArr = document.querySelectorAll(".hiddenForProfileFilestoreId");
			const filestoreIdValues = [];
			
			for (let i = 0; i < filestoreIdArr.length; i++) {
				filestoreIdValues.push(filestoreIdArr[i].value + "," + i);
			}
			
			//데이터 object로 만들기      (아이디 ,이름, 학력, 연락처, 진료과, 직책, 주소, 전문과목, 경력, 학회, 수상) 총 11개  + 파일  
			const updateDrInfo = {
				drId : drId,
				drName : doctorNameValue,
				drEducation : educationValue,
				drPhoneNum : phone,
				deptId : dept,
				drPosition : position,
				drAddress : fullAddress,
				drFieldList : subjectValues,
				drCareerList : careerValues,
				drAcademicList : academicValues,
				drAwardsList : awardValues,
				filestoreIdList : filestoreIdValues,
				deptHeadCheck : deptHeadCheck
			}
			formData.append("updateDrInfo", JSON.stringify(updateDrInfo));
			
			fetch("${pageContext.request.contextPath }/updateDrInfo", {
				method : "POST", //put요청으로 할시 에러 발생
				body : formData
			})
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
	function fileChange(fileInput, file, profileTextDiv, profileImg) {
			file = fileInput.files;
			if (file && file.length > 0) {
				const selectedFile = file[0];
				const dotIndex = selectedFile.name.lastIndexOf(".");
				if (selectedFile.name.slice(dotIndex) !== '.jpg' && selectedFile.name.slice(dotIndex) !== '.jpeg' && 
						selectedFile.name.slice(dotIndex) !== '.png' && selectedFile.name.slice(dotIndex) !== '.gif') {
					return "notImage";
				}
				profileTextDiv.innerHTML = selectedFile.name;
				
				const fileURL = URL.createObjectURL(selectedFile);
				profileImg.setAttribute("src", fileURL);
				return file;
			} else {
				return null;
			}
	}
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
		location.href = "../admin/adminMain";
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
<div class="body_wrap">
	<!-- 사이드바 -->
	<%@ include file="WEB-INF/../../common/sidebar.jspf"%>
	
	<div class="content">
		<div class="top_bar bg_w">
			<a href="adminDoctorRegister" class="top_left doctor_con"><span>의료진 정보 수정</span></a>
			<!-- 탑바 컨텐츠 -->
			<%@ include file="WEB-INF/../../common/topbarContent.jspf"%>
			
		</div>
		<div class="con_wrap bg_13">
			<!-- content시작 -->
				<div class="doctor">
					<div class="doc_left bg_w">
						<div class="doc_con" style="width: 90%;">
							<p class="f_s17 f_w500" style="height: 10px;">프로필 이미지 
								<span class="ms-4 profileFont">프로필 사진을 클릭해주세요</span>
								<img alt="click image" src="${pageContext.request.contextPath }/resources/images/click_Img3.png">
							</p>
						</div>
						<div class="mb-3">
					    		<table id="profileTable" class="text-center">
						    		<tr id="profileTableImg" class="hoverArea">
						    			<th>
						    				<img src="${pageContext.request.contextPath }/resources/images/photo.png" alt="profile" class="profileImg">
						    				<input type="file" id="fileInput" class="fileInputs" name="ImgFile" class="form-control-file" style="display: none;"/>
						    			</th>
						    			<th>
						    				<img src="${pageContext.request.contextPath }/resources/images/photo.png" alt="profile" class="profileImg">
						    				<input type="file" id="fileInput" class="fileInputs" name="ImgFile" class="form-control-file" style="display: none;"/>
						    			</th>
						    			<th>
						    				<img src="${pageContext.request.contextPath }/resources/images/photo.png" alt="profile" class="profileImg">
						    				<input type="file" id="fileInput" class="fileInputs" name="ImgFile" class="form-control-file" style="display: none;"/>
						    			</th>
						    		</tr>
								    <tr id="profileTableText">
								        <th class="text-center profileText">
								            <div class="row-container">
								                <div class="text-container profileTextDiv">프로필 이미지 없음</div>
								                <div class="img-container resetImg hoverArea">
								                    <img src="${pageContext.request.contextPath }/resources/images/reset.png" alt="Reset Icon">
								                </div>
								            </div>
								        </th>
								        <th class="text-center profileText">
								            <div class="row-container">
								                <div class="text-container profileTextDiv">프로필 이미지 없음</div>
								                <div class="img-container resetImg hoverArea">
								                    <img src="${pageContext.request.contextPath }/resources/images/reset.png" alt="Reset Icon">
								                </div>
								            </div>
								        </th>
								        <th class="text-center profileText">
								            <div class="row-container">
								                <div class="text-container profileTextDiv">프로필 이미지 없음</div>
								                <div class="img-container resetImg hoverArea">
								                    <img src="${pageContext.request.contextPath }/resources/images/reset.png" alt="Reset Icon">
								                </div>
								            </div>
								        </th>
								    </tr>
					    		</table>
					    	<c:if test="${not empty drInfoVO.filePath }">
						    	<c:forEach var="filePath" items="${drInfoVO.filePath }">
						    		<input type="hidden" class="hiddenForProfile" value="${filePath }">
						    	</c:forEach>
						    	<c:forEach var="originalName" items="${drInfoVO.originalName }">
						    		<input type="hidden" class="hiddenForProfileOriginalName" value="${originalName }">
						    	</c:forEach>
						    	<c:forEach var="filestoreId" items="${drInfoVO.filestoreId }">
						    		<input type="hidden" class="hiddenForProfileFilestoreId" value="${filestoreId }">
						    	</c:forEach>
					    	</c:if>
					    	<c:if test="${empty drInfoVO.filePath }">
					    		<input type="hidden" class="hiddenForProfile" value="noProfile">
					    	</c:if>
					    </div>
						<div class="doc_con" style="width: 90%;">
							<p class="f_s17 f_w500">성명*</p>
							<div class="d-flex align-items-center">
								<input type="text" id="name" name="name" class="form-control flex-grow-1" placeholder="성명을 입력하세요">
								<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
							</div>
						</div>
						<div class="doc_con" style="width: 90%;">
							<p class="f_s17 f_w500 mb-3">학력*</p>
							<div class="d-flex align-items-center">
								<input type="text" id="education" name="education" class="form-control flex-grow-1" placeholder="학력을 입력하세요">
								<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> <!-- 레이아웃용도 -->
							</div>
						</div>
						<div>
							<p class="f_s17 f_w500 mb-3">진료과</p>
							<select id="dept" name="dept" class="form-select custom-select mb-3 py-2" style="width: 86%; height: 50px;">
								<c:forEach var="deptIdName" items="${deptIdNameList }">
									<option value="${deptIdName.deptId }">${deptIdName.deptName }</option>
								</c:forEach>
							</select>
						</div>
						<div>
							<!-- <p class="f_s17 f_w500 mb-3">직책</p> -->
							<p class="f_s17 f_w500 mb-3 d-flex justify-content-between align-items-center" class="doc_con" style="width: 86%;">
								<span>직책</span>
								<span class="text-end">진료과장지정
									<img src="${pageContext.request.contextPath }/resources/images/check_off.png" class="ms-1" id="deptHeadCheck">
								</span>
							</p>
							<select id="position" name="position" class="form-select custom-select mb-3 py-2" style="width: 86%; height: 50px;">
								<option>인턴</option>
								<option>레지</option>
								<option>과장</option>
								<option>교수</option>
							</select>
						</div>
						<div class="doc_con" style="width: 90%;">
							<p class="f_s17 f_w500">연락처*</p>
							<div id="phoneDiv" class="d-flex align-items-center">
								<select id="phone1" name="phone1" class="form-select custom-select" 
									style="width: 20%; height: 50px; direction: ltr; appearance: auto;">
									<option>010</option>
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
					</div>
					<div class="doc_right bg_w">
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
					</div>
				</div>
				<div class="doc_bottom f_s16 f_w600">
					<button type="button" id="update" class="btn btn-primary btn-lg text-nowrap" style="width: 25%;">수정하기</button>
					<button type="button" class="btn btn-dark btn-lg text-nowrap" style="width: 25%;" onclick="goMain()">메인으로</button>
				</div>
		</div>
		<div class="footer bg_13 f_s15">2023 Hanyang University Medical Center All right Reserved.</div>
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