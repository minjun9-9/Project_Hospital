<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<style>
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
		margin-top: 10px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis; 
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.divBorder {
		overflow: hidden;
		overflow-y: auto;
		max-height: 700px;
		height: 100%; 
		width: 100%; 
    	box-sizing: border-box; 
	}

	#emailPwd, #changePwd {
		height: 50px;
	}
	.checkMsg {
		font-size: 15px;
		color: gray;
	}
	.checkMsgSuccess {
		color: green;
	}
	.checkMsgFail {
		color: red;
	}
	.pwdLevelText {
		font-size: 15px;
	}
	.pw-length, .pw-alphabet, .pw-sp-char {
		color: red;
	}
	.pw-ok {
		color: green;
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
	const regexEmailId = /^[a-zA-Z0-9-]+$/;
	const regexDomain = /^[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$/;
	
	//우측상단 로그인명 클릭시 나오는 드롭다운
	window.addEventListener("load", function(){
		const dropdownMenuDiv = document.querySelector("#dropdownMenu");
		const loginName = document.querySelector(".name");
		loginName.addEventListener("click", (event) => {
			event.preventDefault();
			dropdownMenuDiv.style.display = (dropdownMenuDiv.style.display === "block") ? "none" : "block";
		});
		
		document.addEventListener("click", (event) => {
			if (!dropdownMenuDiv.contains(event.target) && event.target !== loginName) {
				dropdownMenuDiv.style.display = "none";
			}
		})
	});
	
	//메인 동작
	window.addEventListener("load", function(){
		
		//인증 요청 처리
		let isAuthenticateRequest = false;
		const authenticateRequestBtn = document.querySelector("#authenticateRequest");
		authenticateRequestBtn.addEventListener("click", () => {
			const emailInput = document.querySelector("#email");
			const emailDomainInput = document.querySelector("#emailDomain");
			const emailPwdInput = document.querySelector("#emailPwd");
			let emailValue = emailInput.value.trim();
			let emailDomainValue = emailDomainInput.value.trim();
			let emailPwdValue = emailPwdInput.value.trim();
			
			//값 체크
			if (emailValue === '' || emailDomainValue === '') {
				alert("이메일을 입력해 주세요");
				if (emailValue === '') {
					emailInput.focus();
				} else if (emailDomainValue === '') {
					emailDomainInput.focus();
				}
				return false;
			}
			if (!regexEmailId.test(emailValue)) {
				alert("이메일 ID를 올바르게 입력해 주세요");
				emailInput.focus();
				return false;
			}
			if (!regexDomain.test(emailDomainValue)) {
				alert("도메인을 올바르게 입력해 주세요");
				emailDomainInput.focus();
				return false;
			}
			let fullEmail = `\${emailValue}@\${emailDomainValue}`; //추후 js파일로 옮길시 (\)역슬래쉬 없애야 동작함
			
			if (emailPwdValue === '') {
				alert("비밀번호를 입력해 주세요");
				emailPwdInput.focus();
				return false;
			}
			
			//이메일 및 비밀번호 값 체크(이메일 input은 필요시 스타일 변경)
			const emailObj = {
				email : fullEmail,
				emailPwd : emailPwdValue
			}
			
			//Ajax로 서버에서 이메일 인증 번호를 발송한다
			fetch(contextPath + "/authenticateByEmail", {
				method : "POST",
				headers : { "Content-Type" : "application/json" },
				body : JSON.stringify(emailObj)
			})
				.then(response => {
					if (!response.ok) {
						throw new Error("Ajax 에러 발생");
					}
					return response.json();
				})
				.then(message => {
					
					alert(message.msg);
					if (message.result === "success") {
						isAuthenticateRequest = true;
					}
				})
				.catch(error => {
					alert(error);
				})
			
		});
		
		//인증 버튼 처리
		const authenticate = document.querySelector("#authenticate");
		authenticate.addEventListener("click", () => {
			if (!isAuthenticateRequest) {
				alert("인증 요청을 먼저 해주세요");
				return false;
			}
			
			const authenticateNumInput = document.querySelector("#authenticateNum");
			let authenticateNumInputValue = authenticateNumInput.value.trim();
			if (authenticateNumInputValue === '') {
				alert("인증 번호를 입력해주세요");
				authenticateNumInput.focus();
				return false;
			}
			
			fetch(contextPath + "/verifyCode", {
				method : "POST",
				headers : { "Content-Type" : "application/json" },
				body : JSON.stringify({ authenticateNumInputValue })
			})
				.then(response => {
					if (!response.ok) {
						throw new Error("Ajax 에러 발생");
					}
					return response.json();
				})
				.then(message => {
					const checkMsgSpan = document.querySelector(".checkMsg");
					if (message.result === "success") {
						//인증 성공시 처리
						checkMsgSpan.innerHTML = message.msg;
						checkMsgSpan.classList.remove("checkMsgFail");
						checkMsgSpan.classList.add("checkMsgSuccess");
						
						//비밀번호 변경 태그 만들기
						const divBorder = document.querySelector(".divBorder");	
						const buttonDiv = document.querySelector(".buttonDiv");
    				
    	                const pwdParentDiv = document.createElement("div");
    	                pwdParentDiv.className = "doc_con ms-4";
    	                pwdParentDiv.style.width = "90%";
    	                
    	                const pwdP = document.createElement("p");
    	                pwdP.className = "f_s17 f_w500 mb-3 m-0";
    	                pwdP.textContent = "비밀번호 변경";
    	                
    	                const pwdSpan = document.createElement("span");
    	                pwdSpan.className = "ms-3 pwdLevelText";
    	                
    	                const pwdChileDiv = document.createElement("div");
    	                pwdChileDiv.className = "d-flex align-items-center mb-3";
    	                
    	                const pwdInput = document.createElement("input");
    	                pwdInput.type = "password";
    	                pwdInput.id = "changePwd";
    	                pwdInput.name = "changePwd";
    	                pwdInput.className = "form-control flex-grow-1 changePwdClass";
    	                pwdInput.placeholder = "변경할 비밀번호를 입력해주세요";
    	                
						const pTag1 = document.createElement("p");
						pTag1.textContent = "8글자 이상  X";
						pTag1.className = "pw-length";
						
						const pTag2 = document.createElement("p");
						pTag2.textContent = "대소문자 포함 X";
						pTag2.className = "pw-alphabet";
						
						const pTag3 = document.createElement("p");
						pTag3.textContent = "특수문자  포함 X";
						pTag3.className = "pw-sp-char";
						
    	                pwdChileDiv.appendChild(pwdInput);
    	                pwdP.appendChild(pwdSpan);
    	                pwdParentDiv.appendChild(pwdP);
    	                pwdParentDiv.appendChild(pwdChileDiv);
    	                pwdParentDiv.appendChild(pTag1);
    	                pwdParentDiv.appendChild(pTag2);
    	                pwdParentDiv.appendChild(pTag3);
    	                
    	                divBorder.insertBefore(pwdParentDiv, buttonDiv);
    	                
					} else {
						//인증 실패시 처리
						checkMsgSpan.innerHTML = message.msg;
						checkMsgSpan.classList.add("checkMsgFail");
					}
				})
				.catch(error => {
					alert(error);
				})
			
			
		});
		
		const isPwdCheckArr = [false, false, false]; 
		
		const regLower = /[a-z]/;
		const regUpper = /[A-Z]/;
		const regSpeChar = /[^a-zA-Z0-9]/;
		const divBorder = document.querySelector(".divBorder");
		
		divBorder.addEventListener("input", (event) => {
			if (!event.target.classList.contains("changePwdClass")) return;
			const changePwdInput = document.querySelector("#changePwd");
			
			//KISA 보안 적용(길이, 영대소문자, 특수문자 까지만)
			//문자 길이 8자리 이상
			let changePwdValue = changePwdInput.value.trim();
			const pwdLevelText = document.querySelector(".pwdLevelText");
			console.log(changePwdInput.value.trim());
			
			if (changePwdValue === '') {
				pwdLevelText.innerHTML = "";
				return;
			}
			const pwLength = document.querySelector(".pw-length");
			if (changePwdValue.length >= 8) {
				pwLength.innerHTML = '8글자 이상 V';
				pwLength.classList.add("pw-ok");
				isPwdCheckArr[0] = true;
			} else {
				pwLength.innerHTML = '8글자 이상 X';
				pwLength.classList.remove("pw-ok");
				isPwdCheckArr[0] = false;
			}
			
			//영문 대소문자 포함
			const pwAlphabet = document.querySelector(".pw-alphabet");
			if (regLower.test(changePwdValue) && regUpper.test(changePwdValue)) {
				pwAlphabet.innerHTML = '대소문자 포함 V';
				pwAlphabet.classList.add("pw-ok");
				isPwdCheckArr[1] = true;
			} else {
				pwAlphabet.innerHTML = '대소문자 포함 X';
				pwAlphabet.classList.remove("pw-ok");
				isPwdCheckArr[1] = false;
			}
			
			//특수문자 포함
			const pwSpChar = document.querySelector(".pw-sp-char");
			if (regSpeChar.test(changePwdValue)) {
				pwSpChar.innerHTML = '특수문자  포함 V';
				pwSpChar.classList.add("pw-ok");
				isPwdCheckArr[2] = true;
			} else {
				pwSpChar.innerHTML = '특수문자  포함 X';
				pwSpChar.classList.remove("pw-ok");
				isPwdCheckArr[2] = false;
			}
			
			let trueCnt = 0;
			for (let isPwdCheck of isPwdCheckArr) {
				if (isPwdCheck) {
					trueCnt++;
					console.log("true : " + trueCnt);
				} 
			}
			console.log("total : " + trueCnt);
			if (trueCnt == 0) {
				pwdLevelText.innerHTML = "매우 취약";
				pwdLevelText.style.color = "red";
			} else if (trueCnt == 1) {
				pwdLevelText.innerHTML = "취약";
				pwdLevelText.style.color = "red";
			} else if (trueCnt == 2) {
				pwdLevelText.innerHTML = "보통";
				pwdLevelText.style.color = "orange";
			} else if (trueCnt == 3) {
				pwdLevelText.innerHTML = "강함";
				pwdLevelText.style.color = "green";
			}
			
		});
		
		//변경하기 버튼 클릭 처리
		const updatePwdBtn = document.querySelector("#updatePwd");
		updatePwdBtn.addEventListener("click", () => {
			const changePwdInput = document.querySelector("#changePwd");
			
			if (changePwdInput == null) {
				if (!isAuthenticateRequest) {
					alert("인증 요청을 먼저 해주세요");
					return false;
				}
				
				alert("인증을 해주세요");
				return false;
			} else {
				let changePwdValue = changePwdInput.value.trim();
				if (changePwdValue === '') {
					alert("변경할 비밀번호를 입력해 주세요");				
					changePwdInput.focus();
					return false;
				}
				
				//최소 8자리, 영대소문자 확인, 특수문자 확인
				if (!isPwdCheckArr[0]) {
					alert("비밀번호는 8글자 이상이여야 합니다");
					changePwdInput.focus();
					return false;
				}
				if (!isPwdCheckArr[1]) {
					alert("비밀번호에 대소문자가 포함되어야 합니다");
					changePwdInput.focus();
					return false;
				}
				if (!isPwdCheckArr[2]) {
					alert("비밀번호에 특수문자가 포함되어야 합니다");
					changePwdInput.focus();
					return false;
				}
				
				//최대 20자리까지
				if (changePwdValue.length > 20) {
					alert("비밀번호는 최대 20자까지 입니다");
					changePwdInput.focus();
					return false;
				}
				
				//비밀번호 변경 값 읽어서 서버에서 처리
				fetch(contextPath + "/changeDrPwd", {
					method : "POST",
					headers : { "Content-Type" : "application/json" },
					body : JSON.stringify({ changePwdValue })
				})
					.then(response => {
						if (!response.ok) {
							throw new Error("Ajax 에러 발생");
						}
						return response.json();
					})
					.then(message => {
						alert(message.msg);
						if (message.result === "success") {
							location.href = contextPath + '/adminDoctorMain/loginPage';
						} else {
							location.reload(true);
						}
					})
					.catch(error => {
						alert(error);
					})
				
			}
			
		});
		
		
		
	});
function goMain() {
	location.href = contextPath + '/admin/adminMain';
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
			<a href="#" class="top_left doctor_con"><span>비밀번호 변경</span></a>
			<!-- 탑바 컨텐츠 -->
			<%@ include file="WEB-INF/../../common/topbarContent.jspf"%>
		</div>
	<div class="con_wrap bg_13">
		<!-- main content시작 -->
		<div class="dummy">
		
			<div class="container" style="padding-top: 70px; width: 35%; height: 100%;">
				
				<div class="border border-3 rounded py-5 shadow divBorder">
					<div class="text-start text-center">
				    	<span class="subtit f_s20 f_w700">이메일 인증</span>
				  	</div>
				  	
					<div class="doc_con ms-4 mb-5" style="width: 90%; margin-top: 70px;">
						<div id="deptIdDiv" class="d-flex justify-content-between align-items-center">
						  <p class="f_s17 f_w500 mb-3 m-0">이메일*</p>
						  <button type="button" id="authenticateRequest" class="doc_con btn btn-success btn-sm align-self-center btnCSS2" 
						  		style="height: 25px; line-height: 5.0; display: flex; align-items: center;">인증 요청</button>
						</div>
						<div class="d-flex align-items-center">
							<input type="text" id="email" name="email" class="form-control flex-grow-1" placeholder="아이디 입력" 
								style="width: 40%; flex: 1; margin-right: 5px;">
							<span style="font-size: 20px;">@</span>
   						    <input type="text" id="emailDomain" name="emailDomain" class="form-control" placeholder="도메인 입력" 
   						    	style="width: 40%; flex: 1; margin-left: 5px;">
						</div>
					</div>
					
					<div class="doc_con ms-4 mb-5" style="width: 90%;">
						  <p class="f_s17 f_w500 mb-3 m-0">비밀번호*</p>
						<div class="d-flex align-items-center">
							<input type="password" id="emailPwd" name="emailPwd" class="form-control flex-grow-1" placeholder="비밀번호를 입력하세요">
						</div>
					</div>
					
					<div class="doc_con ms-4 mb-5" style="width: 90%;">
						 <div id="" class="d-flex justify-content-between align-items-center">
						  <p class="f_s17 f_w500 mb-3 m-0">인증번호 입력*<span class="ms-3 checkMsg"></span></p>
						  <button type="button" id="authenticate" class="doc_con btn btn-success btn-sm align-self-center btnCSS2" 
						  		style="height: 25px; line-height: 3.0; display: flex; align-items: center;">인증</button>
						</div>
						<div class="d-flex align-items-center">
							<input type="text" id="authenticateNum" name="authenticateNum" class="form-control flex-grow-1" placeholder="인증번호를 입력하세요">
						</div>
					</div>
					
					<!-- <div class="doc_con ms-4" style="width: 90%;">
						<p class="f_s17 f_w500 mb-3 m-0">비밀번호 변경*<span class="ms-3 pwdLevelText"></span></p>
						<div class="d-flex align-items-center mb-3">
							<input type="password" id="changePwd" name="" class="form-control flex-grow-1 changePwdClass" placeholder="변경할 비밀번호를 입력해주세요">
						</div>
						<p class="pw-length">8글자 이상  X</p>
						<p class="pw-alphabet">대소문자 포함 X</p>
						<p class="pw-sp-char">특수문자  포함 X</p>
					</div> -->
					
					<div class="doc_bottom f_s16 f_w600 buttonDiv" style="margin-top: 80px;">
						<button type="button" id="updatePwd" class="btn btn-primary btn-lg text-nowrap btnCSS">변경하기</button>
						<button type="button" class="btn btn-dark btn-lg text-nowrap btnCSS" onclick="goMain()">메인으로</button>
					</div>
					
				</div>
				
			</div>
		</div>
			<div class="footer bg_13 f_s15">2023 Hanyang University Medical Center All right Reserved.</div>
		</div>
		<!-- 컨텐츠 끝  -->
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