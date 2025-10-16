<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료과 등록</title>
<style>
	.resetBtn { 
		background-color: white; 
		border: none;
	}
	#fileText {
		width: 80%;
		height: 50px;
		min-width: 180px;
		max-width: none;
	}
	#uploadFileBtn {
		width: 19%;
		height: 50px;
		min-width: 60px;
	}
	.btnCSS {
		width: 25%;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis; 
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.btnCSS2 {
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis; 
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.deptImage {
		max-height: 130px;
		object-fit: contain;
	}
	.divBorder {
		overflow: hidden;
		overflow-y: auto;
		max-height: 800px;
	}
	.dupleCheck {
		font-size: 15px;
		color: gray;
	}
	.dupleCheckSuccess {
		color: green;
	}
	.dupleCheckFail {
		color: red;
	}
</style>
<!-- 부트스트랩 링크  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<!-- 받은 파일 링크  -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/top-right.css" />
<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/design.js"></script>
<script>
	const contextPath = '/hospital';
	const regexUpper = /^[A-Z]+$/;
	const regexKorean = /^[ㄱ-ㅎ|가-힣]+$/;
	
	window.addEventListener("load", function(){
		//파일 관련
		const uploadFileBtn = document.querySelector("#uploadFileBtn");
		const fileInput = document.querySelector("#fileInput");
		const fileText = document.querySelector("#fileText");
		const deptImage = document.querySelector("#deptImage");
		
		const formData = new FormData();
		//파일 선택 이벤트
		uploadFileBtn.addEventListener("click", () => {
			fileInput.click();
		});
		
		
		fileInput.addEventListener("change", () => {
			let files = fileInput.files;
			let file =files[0];
			
			let dotIndex;
			if (file) {
				dotIndex = file.name.lastIndexOf(".");
				if (file.name.slice(dotIndex) !== '.jpg' && file.name.slice(dotIndex) !== '.jpeg' && 
						file.name.slice(dotIndex) !== '.png' && file.name.slice(dotIndex) !== '.gif') {
					alert("4가지 이미지 파일만 첨부 가능합니다(가능한 확장자 : jpg, jpeg, png, gif)");
					text = '';
					fileText.value = '';
					fileInput.value = '';
					files = null;
					file = null;
					return false;
				}
				const fileURL = URL.createObjectURL(file);
				
				deptImage.setAttribute("src", fileURL);
				
				let text = file.name;
				fileText.value = text;
				
				formData.append('deptImage', file);
				
			}
			
			
		});
		
		//파일 비우기 버튼 이벤트
		const fileResetBtn = document.querySelector("#fileResetBtn");
		fileResetBtn.addEventListener("click", () => {
			deptImage.setAttribute("src", contextPath + "/resources/images/file_image.png");
			text = '';
			fileText.value = '';
			fileInput.value = '';
			files = null;
			file = null;
			formData.delete('deptImage');
		});
		
		//진료과 ID 인풋 태그
		const deptIdInput = document.querySelector("#deptIdInput");
		//진료과 이름 인풋 태그
		const deptNameInput = document.querySelector("#deptNameInput");
		
		//중복값 확인 이벤트 처리
		const dupleSpan = document.querySelector("#dupleSpan");
		let deptId = "";
		let duplicateCheck = false;
		const duplicateCheckBtn = document.querySelector("#duplicateCheck");
		duplicateCheckBtn.addEventListener("click", () => {
			//진료과 ID 값 체크
			let deptIdInputValue = deptIdInput.value.trim();
			if (deptIdInputValue === "") {
				alert("진료과 ID는 필수 입력 사항입니다");
				deptIdInput.focus();
				return false;
			}
			if (!regexUpper.test(deptIdInputValue)) {
				alert("진료과 ID는 영문 대문자만 입력 가능합니다");
				deptIdInput.value = "";
				deptIdInput.focus();
				return false;
			}
			
			deptId = "SW" + deptIdInputValue; 
			fetch(contextPath + "/deptIdCheck?deptId=" + deptId, {
				method : "GET",
				headers : { "Content-Type" : "application/json" },
			})
				.then(response => {
					if (!response.ok) {
						throw new Error("[deptIdCheck] Ajax 요청 에러발생" + response.statusText);
					}
					return response.json();
				})
				.then(result => {
					duplicateCheck = result;
					
					if (duplicateCheck) {
						//사용 가능하다는 표시
						dupleSpan.innerHTML = "사용 가능";
						dupleSpan.setAttribute("class", "ms-3 dupleCheck dupleCheckSuccess");
					} else {
						//사용 불가라는 표시
						dupleSpan.innerHTML = "사용 불가";
						dupleSpan.setAttribute("class", "ms-3 dupleCheck dupleCheckFail");
					}
				})
				.catch(error => {
					alert(error);
				})
			
		});
		
		//진료과 ID 인풋태그 이벤트 처리 
		deptIdInput.addEventListener("change", () => {
			duplicateCheck = false;
			dupleSpan.innerHTML = "중복값 확인 필수";
			dupleSpan.setAttribute("class", "ms-3 dupleCheck");
		});
		
		//등록 버튼 이벤트 처리
		const registerBtn = document.querySelector("#register");
		registerBtn.addEventListener("click", () => {
			//진료과 이름 값 체크
			let deptNameInputValue = deptNameInput.value.trim();
			if (deptNameInputValue === "") {
				alert("진료과 이름은 필수 입력 사항입니다"); 
				deptNameInput.focus();
				return false;
			}
			if (!regexKorean.test(deptNameInputValue)) {
				alert("진료과 이름은 한글만 입력 가능합니다"); 
				deptNameInput.value = "";
				deptNameInput.focus();
				return false;
			}
			
			//중복값 체크 확인하고 데이터 서버로 보내기
			if (!duplicateCheck) {
				alert("중복값을 확인해 주세요");
				return false;
			} 
			
			const deptInfoObj = {
				deptId : deptId,
				deptName : deptNameInputValue	
			}
			console.log(typeof deptInfoObj);
			console.log(deptInfoObj);
			
			formData.append("deptInfo", JSON.stringify(deptInfoObj));
			
			fetch(contextPath + "/deptRegister", {
				method : "POST",
				body : formData
			})
				.then(response => {
					if (!response.ok) {
						throw new Error("[deptRegister] Ajax 요청 에러발생" + response.statusText);
					}
					return response.json();
				})
				.then(message => {
					alert(message.msg);
					if (message.result === 'success') {
						//진료과 등록되면 페이지 새로고침해서 초기화
						location.reload(true);
					}
				})
				.catch(error => {
					alert(error);
				})
			
		});
		
		
	});
	
function goMain() {
	location.href = "adminMain";
}
</script>
</head>
<body>

<div id="content" class="body_wrap">
	<!-- 사이드바 -->
	<%@ include file="WEB-INF/../../common/sidebar.jspf"%>
	<!-- 컨텐츠 시작 -->
	<div class="content">
		<div class="top_bar bg_w">
			<a href="#" class="top_left doctor_con"><span>진료과 등록</span></a>
			<!-- 탑바 컨텐츠 -->
			<%@ include file="WEB-INF/../../common/topbarContent.jspf"%>
		</div>
	<div class="con_wrap bg_13">
		<!-- main content시작 -->
		<div class="dummy">
		
			<div class="container" style="padding-top: 70px; width: 35%; height: 100%;">
				
				<div class="border border-3 rounded py-5 shadow divBorder">
					<div class="text-start text-center">
				    	<span class="subtit f_s20 f_w700">진료과 등록</span>
				  	</div>
				  	
				  	<div class="doc_con ms-4 mb-4" style="margin-top: 70px; width: 90%;">
					  	<div class="row">
					  		<div class="col-md-4 d-flex justify-content-center align-items-center">
						      <img src="${pageContext.request.contextPath}/resources/images/file_image.png" 
						      		id="deptImage" alt="deptImage" style="height: 117px;">
						    </div>
					  		<div class="col-md-8">
						        <p class="f_s17 f_w500">진료과 이미지
						        	<button type="button" id="fileResetBtn" class="ms-2 resetBtn">
						        		<img src="${pageContext.request.contextPath }/resources/images/reset.png">
						        	</button>
						        </p>
								<div class="d-flex align-items-center position-relative">
									<!-- 숨겨진 파일 입력 필드 -->
									<input type="file" id="fileInput" name="ImgFile" class="form-control-file" style="display: none;"/>
									<input type="text" id="fileText" name="fileText" class="form-control flex-grow-1" 
											placeholder="파일을 선택해 주세요" readonly>
									<span style="width: 1%; text-align: center;"> </span><!-- 공백 일부러  -->
									<button type="button" id="uploadFileBtn" class="btn btn-secondary text-nowrap btnCSS">파일</button>
								</div>
						      </div>
						</div>
				  	</div>
				  	
					<div class="doc_con ms-4 mb-5" style="width: 90%;">
						<div id="deptIdDiv" class="d-flex justify-content-between align-items-center">
						  <p class="f_s17 f_w500 mb-3 m-0">진료과 ID*<span id="dupleSpan" class="ms-3 dupleCheck">중복값 확인 필수</span></p>
						  <button type="button" id="duplicateCheck" class="doc_con btn btn-success btn-sm align-self-center btnCSS2" 
						  		style="height: 25px; line-height: 5.0; display: flex; align-items: center;">중복 확인</button>
						</div>
						<div class="d-flex align-items-center">
							<input type="text" id="deptIdInput" name="deptId" class="form-control flex-grow-1" placeholder="진료과 ID를 입력하세요">
						</div>
					</div>
					<div class="doc_con ms-4" style="margin-bottom: 80px; width: 90%;">
						  <p class="f_s17 f_w500 mb-3 m-0">진료과 이름*</p>
						<div class="d-flex align-items-center">
							<input type="text" id="deptNameInput" name="deptName" class="form-control flex-grow-1" placeholder="진료과 이름을 입력하세요">
						</div>
					</div>
					
					<div class="doc_bottom f_s16 f_w600">
						<button type="button" id="register" class="btn btn-primary btn-lg text-nowrap btnCSS">등록하기</button>
						<button type="button" class="btn btn-dark btn-lg text-nowrap btnCSS" onclick="goMain()">메인으로</button>
					</div>
					
				</div>
			</div>
		</div>
			<div class="footer bg_13 f_s15">2025 ITWILL Medical Center All right Reserved.</div>
		</div>
		<!-- 컨텐츠 끝  -->
	</div>
</div>












<!-- 부트스트랩 링크  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
	// 사이드바 토글 움직임
	document.querySelector('.deptul').classList.add('on');
	document.querySelector('.deptliregister').classList.add('on');
	
</script>
</body>
</html>