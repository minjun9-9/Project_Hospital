<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 빈칸이 있을시에 창띄우기
function validateForm() {
    const requiredFields = [
        { id: "userName", message: "이름을 입력해주세요." },
        { id: "birthYear", message: "생년월일(연도)을 입력해주세요." },
        { id: "birthMonth", message: "생년월일(월)을 입력해주세요." },
        { id: "birthDay", message: "생년월일(일)을 입력해주세요." },
        { id: "userGender", message: "성별을 선택해주세요." },
        { id: "userMainAddress", message: "주소를 입력해주세요." },
        { id: "userDetailAddress", message: "상세주소를 입력해주세요." },
        { id: "userPhoneNum1", message: "휴대폰 번호를 입력해주세요." },
        { id: "userPhoneNum2", message: "휴대폰 번호를 입력해주세요." },
        { id: "userPhoneNum3", message: "휴대폰 번호를 입력해주세요." },
        { id: "email1", message: "이메일 아이디를 입력해주세요." },
        { id: "email2", message: "이메일 도메인을 입력해주세요." },
        { id: "userId", message: "아이디를 입력해주세요." },
        { id: "userPw", message: "비밀번호를 입력해주세요." },
        { id: "passwordConfirm", message: "비밀번호 확인을 입력해주세요." },
    ];

    for (const field of requiredFields) {
        const input = document.getElementById(field.id);
        if (!input || !input.value.trim()) {
            alert(field.message);
            input.focus();
            return false;
        }
    }

    const userPw = document.getElementById("userPw").value.trim();
    const passwordConfirm = document.getElementById("passwordConfirm").value.trim();

    if (userPw !== passwordConfirm) {
        alert("비밀번호가 일치하지 않습니다.");
        console.error("비밀번호와 비밀번호 확인이 일치하지 않습니다."); // 변경된 메시지
        return false;
    }

    console.log("폼이 유효합니다. 제출을 진행합니다."); // 변경된 메시지
    return true;
}
		
		
		// 아이디 중복 확인
        function checkUserId() {
			const userId = document.getElementById('userId').value;

        	if (!userId) {
        		alert("아이디를 입력해주세요.");
        		return;
        	}

        	$.ajax({
        		url: "/hospital/user/signup/check-id",
        		method: "GET",
        		data: { userId: userId },
        		success: function(response) {
        	   		if (response) {
        	         	alert("이미 사용 중인 아이디입니다.");
        			} else {
        	      		alert("사용 가능한 아이디입니다.");
        	   		}
        		},
     			error: function() {
        			alert("아이디 확인 중 문제가 발생했습니다.");
        		}
        	});
        }
        
		function chkInputUID(inputStr, inputId) {
			var rsltStr = inputStr.replace(/[' ']/g, '');
			$('#'+inputId).val(rsltStr);
			$('#'+inputId).focus();
		}
		
		document.addEventListener("DOMContentLoaded", function () {
		    const birthYearInput = document.getElementById("birthYear");
		    const birthMonthInput = document.getElementById("birthMonth");
		    const birthDayInput = document.getElementById("birthDay");

		    // 월 변경 시, 일수 동적 설정
		    birthMonthInput.addEventListener("change", updateDays);
		    birthYearInput.addEventListener("blur", updateDays); // 연도 변경 시도 반영

		    function updateDays() {
		        const year = parseInt(birthYearInput.value);
		        const month = parseInt(birthMonthInput.value);
		        const daysInMonth = getDaysInMonth(year, month);

		        // 현재 선택된 값 유지
		        const currentDay = parseInt(birthDayInput.value);

		        // 기존 옵션 제거
		        birthDayInput.innerHTML = "";

		        // 새로운 옵션 추가
		        for (let i = 1; i <= daysInMonth; i++) {
		            const option = document.createElement("option");
		            option.value = i < 10 ? "0" + i : i.toString();
		            option.text = i < 10 ? "0" + i : i.toString();
		            birthDayInput.appendChild(option);
		        }

		        // 선택값이 유효하면 유지
		        if (currentDay && currentDay <= daysInMonth) {
		            birthDayInput.value = currentDay < 10 ? "0" + currentDay : currentDay.toString();
		        }
		    }

		    function getDaysInMonth(year, month) {
		        if (!year || !month) return 31; // 기본값
		        return new Date(year, month, 0).getDate(); // 해당 월의 마지막 날짜 반환
		    }
		});
	
        
	// 이메일 자동 입력
	function applyEmailAddr(emailDomain) {
	    const emailInput = document.getElementById("email2");
	    if (emailDomain === "직접입력") {
	        emailInput.readOnly = false;
	        emailInput.value = "";
	        emailInput.focus();
	    } else {
	        emailInput.readOnly = true;
	        emailInput.value = emailDomain;
	    }
	}
		
	// 주소 검색
	function searchAddress() {
	    new daum.Postcode({
	        oncomplete: function (data) {
	            const roadAddr = data.roadAddress;
	            console.log("도로명 주소 : ", roadAddr);
	            const userMainAddress = document.getElementById("userMainAddress");
	           	if (roadAddr) {
	            	userMainAddress.value = roadAddr;
	            	document.getElementById("userDetailAddress").focus();
	           		console.log("메인 주소 설정 : ", userMainAddress.value);
	           	} else {
	           		console.error("주소 검색 결과 X");
	           	}
	            // 상세주소로 포커스 이동
	        },
	    }).open();
	}

	// 주소 업데이트
	function updateFullAddress() {
	    const mainAddress = document.getElementById("userMainAddress").value;
	    const detailAddress = document.getElementById("userDetailAddress").value;
	    
	    console.log("메인 주소 : ",  mainAddress);
	    console.log("상세 주소 : ",  detailAddress);
	    
	    const fullAddress = mainAddress + " " + detailAddress;
	    document.getElementById("userAddress").value = fullAddress;
	    console.log("전체 주소 : ", fullAddress);
	}

	document.addEventListener("DOMContentLoaded", () => {
		console.log("페이지 로드 완료");
		
	    const mainAddressInput = document.getElementById("userMainAddress");
	    const detailAddressInput = document.getElementById("userDetailAddress");

		// 주소 입력 필드 변경 시마다 업데이트
	    if (mainAddressInput && detailAddressInput) {
	    	mainAddressInput.addEventListener("input", updateFullAddress);
	    	detailAddressInput.addEventListener("input", updateFullAddress);
	    	console.log("추가성공");
	    } else {
	        console.error("주소 입력 필드가 DOM에서 발견되지 않았습니다.");
	    }
	});
		
	// 성별 버튼 선택
	function selectGender(gender) {
	    const userGender = document.getElementById("userGender");
	    userGender.value = gender;
	
	    document.querySelectorAll(".gender-btn").forEach(btn => {
	        btn.classList.remove("active");
	    });
	
	    const selectedButton = document.getElementById(gender == "M" ? "btn-male" : "btn-female");
	    if (selectedButton) {
	    	selectedButton.classList.add("active");
	    }
	}
</script>
</head>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f7f8fa;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	align-items: center;
}

header {
	width: 100%;
	background-color: #007bff;
	padding: 15px 0;
	color: white;
	text-align: center;
	font-size: 1.2rem;
	font-weight: bold;
}

header a {
	color: white;
	text-decoration: none;
	font-size: 1.5rem;
}

header .signup_class {
	display: flex;
	justify-content: center;
	margin-top: 10px;
	list-style: none;
	padding: 0;
}

header .signup_class li {
	display: inline;
	margin: 0 10px;
	font-size: 1rem;
}

header .signup_class li.act span {
	color: #ffd700;
}

.container {
	max-width: 800px;
	margin: 30px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th {
	text-align: left;
	background-color: #007bff;
	color: white;
	padding: 10px;
	width: 30%;
	vertical-align: top;
}

td {
	padding: 10px;
	border: 1px solid #ddd;
}

input, select, button {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
	margin-bottom: 5px;
}

input:focus, select:focus, button:focus {
	outline: none;
	border-color: #007bff;
	box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
}

.input-group button {
	width: auto;
	color: black;
	border: none;
	cursor: pointer;
	padding: 10px 20px;
}

.input-group button:hover {
	background-color: #0056b3;
}

.btn-group {
	display: flex;
	justify-content: flex-end;
	gap: 10px;
}

.btn-group button {
	width: 100px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	padding: 10px;
	text-align: center;
}

.btn-group button:hover {
	background-color: #0056b3;
}

.gender-btn {
	width: 100px;
	padding: 10px;
	margin: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
	cursor: pointer;
	background-color: #f8f9fa; /* 기본 배경 */
	color: #333; /* 기본 텍스트 색 */
	transition: background-color 0.3s, color 0.3s; /* 부드러운 효과 */
}

.gender-btn:hover {
	background-color: #e2e6ea; /* 마우스 올렸을 때 */
}

.gender-btn.active {
	background-color: #007bff; /* 선택된 배경색 */
	color: white; /* 선택된 텍스트 색 */
	border-color: #0056b3;
}

.req {
	color: red;
	font-weight: bold;
}

small {
	font-size: 0.85rem;
	color: #777;
}

h1 {
	font-size: 1.5rem;
	text-align: center;
	margin-bottom: 20px;
	color: #333;
}

.visuallyhidden {
	border: 0;
	clip: rect(0, 0, 0, 0);
	height: 1px;
	margin: -1px;
	overflow: hidden;
	padding: 0;
	position: absolute;
	width: 1px;
}
</style>
<body>
	<header>
		<a href="/hospital/index.jsp">아이티서울병원</a>
		<ol class="signup_class">
			<li><span>약관동의</span></li>
			<li class="act"><span>회원정보입력
					<p class="visuallyhidden">현재페이지</p>
			</span></li>
			<li><span>가입완료</span></li>
		</ol>
	</header>

	<div class="container">
		<h1>회원 정보 입력</h1>
		<form action="register" method="post"
			onsubmit="return validateForm();">
			<input type="hidden" name="type" value="${type }">
			<c:choose>
				<c:when test="${param.type == 'adult'}">
					<tbody>
						<tr>
							<th scope="row">회원유형</th>
							<td>
								<div class="input-group">일반</div>
							</td>
						</tr>
						<tr>
							<th scope="row">이름 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="userName" name="userName"
										placeholder="이름을 입려하세요" title="이름"
										style="width: 300px; padding-left: 5px" required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">생년월일 *</th>
							<td>
								<div class="input-group">
									<input type="number" id="birthYear" name="birthYear"
										placeholder="연도 (YYYY)" min="1900" max="2099"
										style="width: 90px; padding-left: 5px" required> <select
										id="birthMonth" name="birthMonth"
										style="width: 90px; padding-left: 5px" required>
										<option value="">월</option>
										<option value="01">1월</option>
										<option value="02">2월</option>
										<option value="03">3월</option>
										<option value="04">4월</option>
										<option value="05">5월</option>
										<option value="06">6월</option>
										<option value="07">7월</option>
										<option value="08">8월</option>
										<option value="09">9월</option>
										<option value="10">10월</option>
										<option value="11">11월</option>
										<option value="12">12월</option>
									</select> <select id="birthDay" name="birthDay"
										style="width: 90px; padding-left: 5px" required>
										<option value="">일</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">성별 *</th>
							<td>
								<div class="input-group">
									<button type="button" id="btn-male" class="gender-btn"
										onclick="selectGender('M')">남성</button>
									<button type="button" id="btn-female" class="gender-btn"
										onclick="selectGender('F')">여성</button>
									<input type="hidden" id="userGender" name="userGender" required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">주소 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="userMainAddress" name="userMainAddress"
										placeholder="주소를 입력하세요"
										style="width: 300px; padding-left: 5px" readonly required>
									<button type="button" onclick="searchAddress()">주소 검색</button>
									<br> <input type="text" id="userDetailAddress"
										name="userDetailAddress" placeholder="상세 주소를 입력하세요"
										style="width: 300px; padding-left: 5px" required> <input
										type="hidden" id="userAddress" name="userAddress" required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">휴대전화 *</th>
							<td>
								<div class="input-group">
									<select id="userPhoneNum1" name="userPhoneNum1"
										style="width: 100px; padding-left: 5px">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select> <input type="text" id="userPhoneNum2" name="userPhoneNum2"
										maxlength="4" title="휴대폰 중간자리"
										style="width: 100px; padding-left: 5px" required> <input
										type="text" id="userPhoneNum3" name="userPhoneNum3"
										maxlength="4" title="휴대폰 끝자리"
										style="width: 100px; padding-left: 5px" required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">이메일 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="email1" name="email1" maxlength="20"
										required title="이메일 아이디"
										style="width: 130px; padding-left: 5px"> <span>@</span>
									<input type="text" id="email2" name="email2" maxlength="20"
										required title="이메일 도메인 직접입력"
										style="width: 130px; padding-left: 5px"> <select
										name="email3" id="email3"
										onchange="applyEmailAddr(this.value)" title="이메일 도메인 선택"
										style="width: 100px; padding-left: 5px">
										<option value="직접입력">직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="gmail.com">gmail.com</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">아이디 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="userId" name="userId" maxlength="20"
										placeholder="아이디를 입력하세요"
										style="width: 300px; padding-left: 5px" required>
									<button type="button" onclick="checkUserId()">중복확인</button>
									<br>
								</div>
								<div class="input-group">
									<small>※ 영문 소문자 6~20자 (영문 대문자/한글/특수문자 입력 불가능)</small>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">비밀번호 *</th>
							<td>
								<div class="input-group">
									<input type="password" id="userPw" name="userPw" maxlength="20"
										placeholder="비밀번호를 입력하세요"
										style="width: 300px; padding-left: 5px" required><br>
								</div>
								<div class="input-group">
									<small class="add_comment add_comment03 first"
										style="background-position: 0 5px"><sup>1)</sup>비밀번호
										8~20자 입력 또는 <sup>2)</sup>10~20자 입력</small><br> <small
										class="add_comment add_comment03"
										style="background-position: 0 5px"><sup>1)</sup>영문/숫자/특수문자
										또는 <sup>2)</sup>영문/숫자 혼합 사용 (영문 대문자/한글 입력 불가능)</small><br> <small
										class="add_comment add_comment03">동일한 숫자, 문자 3자 이상 반복
										미사용</small><br> <small class="add_comment add_comment03">연속된
										숫자 3자 이상 미사용</small><br>
									<p class="add_comment" id="messagePass" style="display: none;"></p>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">비밀번호 확인 *</th>
							<td>
								<div class="input-group">
									<input type="password" id="passwordConfirm"
										name="passwordConfirm" maxlength="20" placeholder="비밀번호 확인"
										style="width: 300px; padding-left: 5px" required>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group">
									<input type="hidden" id="sendState" name="sendState" value="Y">
								</div>
							<td>
						</tr>
					</tbody>
				</c:when>
				<c:when test="${param.type == 'youth'}">
					<tbody>
						<tr>
							<th scope="row">회원유형</th>
							<td>
								<div class="input-group">소아/청소년</div>
							</td>
						</tr>
						<tr>
							<th scope="row">법정대리인 이름 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="guardianName" name="guardianName"
										placeholder="이름을 입력하세요"
										style="width: 300px; padding-left: 5px" required><br>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">법정대리인 휴대폰 *</th>
							<td>
								<div class="input-group">
									<select id="guardianPhoneNum1" name="guardianPhoneNum1"
										style="width: 100px; padding-left: 5px">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select> <input type="text" id="guardianPhoneNum2"
										name="guardianPhoneNum2" maxlength="4" required
										title="휴대폰 중간자리" style="width: 100px; padding-left: 5px">
									<input type="text" id="guardianPhoneNum3"
										name="guardianPhoneNum3" maxlength="4" required
										title="휴대폰 끝자리" style="width: 100px; padding-left: 5px">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">법정대리인 이메일 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="guardianEmail1" name="guardianEmail1"
										maxlength="20" required title="이메일 아이디"
										style="width: 130px; padding-left: 5px"> <span>@</span>
									<input type="text" id="guardianEmail2" name="guardianEmail2"
										maxlength="20" required title="이메일 도메인 직접입력"
										style="width: 130px; padding-left: 5px"> <select
										name="email3" id="guardianEmail3" title="이메일 도메인 선택"
										style="width: 100px; padding-left: 5px">
										<option value="직접입력">직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="gmail.com">gmail.com</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">소아/청소년 정보 입력란</th>
							<br>
						</tr>
						<tr>
							<th scope="row">이름 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="userName" name="userName"
										placeholder="이름을 입려하세요" title="이름"
										style="width: 300px; padding-left: 5px" required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">생년월일 *</th>
							<td>
								<div class="input-group">
									<input type="number" id="birthYear" name="birthYear"
										placeholder="연도 (YYYY)" min="1900" max="2099"
										style="width: 90px; padding-left: 5px" required> <select
										id="birthMonth" name="birthMonth"
										style="width: 90px; padding-left: 5px" required>
										<option value="">월</option>
										<option value="01">1월</option>
										<option value="02">2월</option>
										<option value="03">3월</option>
										<option value="04">4월</option>
										<option value="05">5월</option>
										<option value="06">6월</option>
										<option value="07">7월</option>
										<option value="08">8월</option>
										<option value="09">9월</option>
										<option value="10">10월</option>
										<option value="11">11월</option>
										<option value="12">12월</option>
									</select> <select id="birthDay" name="birthDay"
										style="width: 90px; padding-left: 5px" required>
										<option value="">일</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">성별 *</th>
							<td>
								<div class="input-group">
									<button type="button" id="btn-male" class="gender-btn"
										onclick="selectGender('M')">남성</button>
									<button type="button" id="btn-female" class="gender-btn"
										onclick="selectGender('F')">여성</button>
									<input type="hidden" id="userGender" name="userGender" required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">주소 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="userMainAddress" name="userMainAddress"
										placeholder="주소를 입력하세요"
										style="width: 300px; padding-left: 5px" required>
									<button type="button" onclick="searchAddress()">주소 검색</button>
									<br> <input type="text" id="userDetailAddress"
										name="userDetailAddress" placeholder="상세 주소를 입력하세요"
										style="width: 300px; padding-left: 5px" required> <input
										type="hidden" id="userAddress" name="userAddress" required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">휴대전화 *</th>
							<td>
								<div class="input-group">
									<select id="userPhoneNum1" name="userPhoneNum1"
										style="width: 100px; padding-left: 5px">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select> <input type="text" id="userPhoneNum2" name="userPhoneNum2"
										maxlength="4" title="휴대폰 중간자리"
										style="width: 100px; padding-left: 5px" required> <input
										type="text" id="userPhoneNum3" name="userPhoneNum3"
										maxlength="4" title="휴대폰 끝자리"
										style="width: 100px; padding-left: 5px" required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">이메일 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="email1" name="email1" maxlength="20"
										required title="이메일 아이디"
										style="width: 130px; padding-left: 5px"> <span>@</span>
									<input type="text" id="email2" name="email2" maxlength="20"
										required title="이메일 도메인 직접입력"
										style="width: 130px; padding-left: 5px"> <select
										name="email3" id="email3"
										onchange="applyEmailAddr(this.value)" title="이메일 도메인 선택"
										style="width: 100px; padding-left: 5px">
										<option value="직접입력">직접입력</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="gmail.com">gmail.com</option>
									</select>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">아이디 *</th>
							<td>
								<div class="input-group">
									<input type="text" id="userId" name="userId" maxlength="20"
										placeholder="아이디를 입력하세요"
										style="width: 300px; padding-left: 5px" required>
									<button type="button" onclick="checkUserId()">중복확인</button>
									<br>
								</div>
								<div class="input-group">
									<small>※ 영문 소문자 6~20자 (영문 대문자/한글/특수문자 입력 불가능)</small>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">비밀번호 *</th>
							<td>
								<div class="input-group">
									<input type="password" id="userPw" name="userPw" maxlength="20"
										placeholder="비밀번호를 입력하세요"
										style="width: 300px; padding-left: 5px" required><br>
								</div>
								<div class="input-group">
									<small class="add_comment add_comment03 first"
										style="background-position: 0 5px"><sup>1)</sup>비밀번호
										8~20자 입력 또는 <sup>2)</sup>10~20자 입력</small><br> <small
										class="add_comment add_comment03"
										style="background-position: 0 5px"><sup>1)</sup>영문/숫자/특수문자
										또는 <sup>2)</sup>영문/숫자 혼합 사용 (영문 대문자/한글 입력 불가능)</small><br> <small
										class="add_comment add_comment03">동일한 숫자, 문자 3자 이상 반복
										미사용</small><br> <small class="add_comment add_comment03">연속된
										숫자 3자 이상 미사용</small><br>
									<p class="add_comment" id="messagePass" style="display: none;"></p>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">비밀번호 확인 *</th>
							<td>
								<div class="input-group">
									<input type="password" id="passwordConfirm"
										name="passwordConfirm" maxlength="20" placeholder="비밀번호 확인"
										style="width: 300px; padding-left: 5px" required>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="input-group">
									<input type="hidden" id="sendState" name="sendState" value="Y">
								</div>
							<td>
						</tr>
					</tbody>
				</c:when>
			</c:choose>
			<button type="button" onclick="history.back()"
				style="width: 100px; cursor: pointer">이전</button>
			<button type="submit" style="width: 200px; cursor: pointer">완료</button>
		</form>
	</div>
</body>
</html>