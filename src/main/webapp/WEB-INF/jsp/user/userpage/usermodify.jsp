<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기본정보 수정</title>
	<%@include file="/resources/header/header.jspf" %>
<style>
/* 전체 페이지 레이아웃 */
.page-container {
    display: flex;
    flex-direction: row;
    min-height: 100vh;
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
}

.modify-container {
	margin: 50px;
}

/* 사이드바 스타일 */
.sidebar {
    width: 250px;
    background-color: #595f6a;
    color: white;
    padding: 20px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    box-sizing: border-box;
}

.sidebar h2 {
    font-size: 1.5rem;
    font-weight: bold;
    margin-bottom: 20px;
    text-align: center;
    border-bottom: 1px solid rgba(255, 255, 255, 0.3);
    padding-bottom: 10px;
}

/* 사이드바 메뉴 */
.dev_menu {
    list-style: none;
    padding: 0;
    margin: 0;
}

.dev_menu > li {
    margin-bottom: 15px;
}

.dev-inner-anchor {
    display: block;
    color: white;
    text-decoration: none;
    padding: 10px 15px;
    font-size: 1rem;
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 5px;
    transition: background-color 0.3s ease;
}

.dev-inner-anchor:hover {
    background-color: rgba(255, 255, 255, 0.2);
}

.sub-menu {
    list-style: none;
    padding-left: 20px;
    display: none;
    margin-top: 10px;
}

.sub-menu li {
    margin-bottom: 10px;
}

.sub-menu a {
    text-decoration: none;
    color: white;
    font-size: 0.9rem;
    transition: color 0.3s ease;
}

.sub-menu a:hover {
    color: #007bff;
}

.dev_menu > li:hover .sub-menu {
    display: block;
}

/* 콘텐츠 영역 */
.main-content {
    flex-grow: 1;
    padding: 40px;
    box-sizing: border-box;
}

/* 폼 스타일 */
.table-wrapper {
    width: 100%;
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* 테이블 스타일 */
.table-default {
    width: 100%;
    border-collapse: collapse;
}

.table-default th, .table-default td {
    padding: 15px;
    border-bottom: 1px solid #ddd;
    text-align: left;
}

.table-default th {
    background-color: #f4f4f4;
    font-weight: bold;
    width: 200px;
}

/* 입력 필드 스타일 */
.input-text {
    width: 80%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 1rem;
    box-sizing: border-box;
}

.input-width-small {
    width: 20%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 1rem;
    box-sizing: border-box;
}

.input-width-smaller {
    width: 20%;
    height: 40px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 1rem;
    box-sizing: border-box;
}

.input-text-password {
    width: 30%;
    height: 40px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 1rem;
    box-sizing: border-box;
}

/* 버튼 스타일 */
.section-button {
	margin-left: 1000px;
}

.button {
    display: inline-block;
    padding: 12px 25px;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
}

.button-blue {
	width: 200px;
    background-color: #007bff;
    color: white;
}

.button-gray {
	width: 100px;
    background-color: #ccc;
    color: black;
}

.button:hover {
    opacity: 0.9;
}

/* 메시지 스타일 */
.input-description {
    font-size: 0.9rem;
    color: gray;
    margin-top: 5px;
    display: block;
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .page-container {
        flex-direction: column;
    }
    .sidebar {
        width: 100%;
        text-align: center;
        padding: 10px;
    }
    .table-wrapper {
        padding: 20px;
    }

    .input-text {
        font-size: 0.9rem;
    }

    .button {
        width: 100%;
        text-align: center;
    }
}
</style>
<script>
	let sessionTimeout = 30 * 60 * 1000; // 30분
	let warningTime = 25 * 60 * 1000; // 25분 후 경고
	
	setTimeout(() => {
	    alert("세션이 곧 만료됩니다. 계속 사용하려면 작업을 진행하세요.");
	}, warningTime);
	
	setTimeout(() => {
	    alert("세션이 만료되었습니다. 다시 로그인해주세요.");
	    window.location.href = "/hospital/user/login/login";
	}, sessionTimeout);
	
	// 페이지가 로드된 후 이벤트 리스너 등록
	document.addEventListener("DOMContentLoaded", function() {
	    setupEventListeners();
	});

	// 이메일 주소 선택 시 직접입력 처리
	function setupEventListeners() {
	    const emailSelect = document.querySelector("select[name='userDetailAddress']");
	    if (emailSelect) {
	        emailSelect.addEventListener('change', function() {
	            if (this.value === "직접입력") {
	                document.getElementById("userDetailAddress").disabled = false;
	                document.getElementById("userDetailAddress").value = "";
	            } else {
	                document.getElementById("userDetailAddress").disabled = true;
	                document.getElementById("userDetailAddress").value = this.value;
	            }
	        });
	    }

	    // 휴대폰 번호 입력 이벤트 등록
	    document.getElementById("userPhoneNum1").addEventListener('change', updateHiddenFields);
	    document.getElementById("userPhoneNum2").addEventListener('input', updateHiddenFields);
	    document.getElementById("userPhoneNum3").addEventListener('input', updateHiddenFields);
	    document.getElementById("userMainAddress").addEventListener('input', updateHiddenFields);
	    document.getElementById("userDetailAddress").addEventListener('input', updateHiddenFields);
	}

	// 휴대폰 및 이메일 필드 값 업데이트
	function updateHiddenFields() {
	    document.getElementById('userPhoneNum').value =
	        document.getElementById('userPhoneNum1').value + '-' +
	        document.getElementById('userPhoneNum2').value + '-' +
	        document.getElementById('userPhoneNum3').value;

	    document.getElementById('userEmail').value =
	        document.getElementById('userMainAddress').value + '@' +
	        document.getElementById('userDetailAddress').value;
	}

	// 비밀번호 확인 (비동기 서버 요청)
	async function dupCheckUserPw(inputPw) {
	    try {
	        let response = await fetch('/hospital/user/userpage/validatePassword', {
	            method: 'POST',
	            headers: { 'Content-Type': 'application/json' },
	            body: JSON.stringify({
	            	userId: document.querySelector('input[name="userId"]').value,
	            	userPw: inputPw,
	                email: document.getElementById('userMainAddress').value + '@' + document.getElementById('userDetailAddress').value,
	                phoneNum: document.getElementById('userPhoneNum1').value + '-' +
	                          document.getElementById('userPhoneNum2').value + '-' +
	                          document.getElementById('userPhoneNum3').value
	            })
	        });

	        let data = await response.json();
	        console.log("서버 응답 데이터 : " + data);
	        if (data.valid) {
	            document.getElementById("messagePw").textContent = "비밀번호가 일치합니다.";
	            document.getElementById("messagePw").style.color = "green";
	            return true;
	        } else {
	            document.getElementById("messagePw").textContent = "비밀번호가 일치하지 않습니다.";
	            document.getElementById("messagePw").style.color = "red";
	            return false;
	        }
	    } catch (error) {
	        console.error("비밀번호 확인 중 오류 발생:", error);
	        return false;
	    }
	}

	// 폼 유효성 검사 및 제출
	async function checkForm() {
	    updateHiddenFields(); // hidden 필드 업데이트

	    let phone1 = document.getElementById("userPhoneNum1").value;
	    let phone2 = document.getElementById("userPhoneNum2").value;
	    let phone3 = document.getElementById("userPhoneNum3").value;
	    let emailMain = document.getElementById("userMainAddress").value;
	    let emailDetail = document.getElementById("userDetailAddress").value;
	    let userPw = document.getElementById("userPw").value;

	    if (phone1 === "" || phone2 === "" || phone3 === "") {
	        alert("휴대폰 번호를 모두 입력해주세요.");
	        return false;
	    }

	    if (emailMain === "" || emailDetail === "") {
	        alert("이메일을 모두 입력해주세요.");
	        return false;
	    }

	    if (userPw === "") {
	        alert("비밀번호를 입력해주세요.");
	        return false;
	    }

	    // 비밀번호 확인 후 폼 제출
	    let isPwValid = await dupCheckUserPw(userPw);
	    if (!isPwValid) {
	        alert("비밀번호가 일치하지 않습니다.");
	        return false;
	    }

	    // 폼 제출
	    document.getElementById('userModifyForm').submit();
	    alert("회원정보가 수정되었습니다.");
	}

	// 취소 버튼 클릭 시 이전 페이지로 이동
	function goPage() {
	    window.history.back();
	}
</script>
</head>
<body>
	<div class="page-container">
		<!-- 사이드바 -->
		<div class="sidebar" role="navigation">
			<h2>나의서비스</h2>
			<ul class="dev_menu">
				<li><a href="#" class="dev-inner-anchor">건강노트</a>
					<div class="sub-menu">
						<ul>
							<li><a href="#">나의스토리</a></li>
							<li><a href="#">나의스크랩</a></li>
							<li><a href="#">관심의료진</a></li>
						</ul>
					</div>
				</li>
				<li><a href="#" class="dev-inner-anchor">건강코치</a>
					<div class="sub-menu">
						<ul>
							<li><a href="#">체중&amp;영양다이어리</a></li>
							<li><a href="#">혈압관리</a></li>
							<li><a href="#">혈당관리</a></li>
						</ul>
					</div>
				</li>
				<li><a href="#" class="dev-inner-anchor">14세 미만 대리인증</a></li>
				<li><a href="userpage" class="dev-inner-anchor">개인정보</a>
					<div class="sub-menu">
						<ul>
							<li><a href="usermodify">기본정보 수정</a></li>
							<li><a href="passwordmodify">비밀번호 변경</a></li>
							<li><a href="memberleave">회원탈퇴</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</div>
		
		<div class="modify-container">
		<form action="usermodify" method="post" id="userModifyForm">
		<section class="section-step">
			<div class="section-heading section-heading-top">
				<h3 class="section-heading-title">개인정보 수정</h3>
			</div>
		
			<div class="board-util board-util-top02">
				<div class="board-util-right">
					<span class="board-util-text color-red">* 필수 입력 항목</span>
				</div>
			</div>
		
			<div class="table-wrapper" role="form">
				<table class="table-default board-form table-member-PWDWDWDWDWDWDmodify">
					<tbody>
						<tr>
							<th scope="row">아이디</th>
							<td>
								<div class="input-inside-table">
									<input type="text" name="userId" class="input-text" title="아이디" value="${user.userId }" role="textbox" readonly required>
								</div>
							</td>
							<th scope="row">이름</th>
							<td>
								<div class="input-inside-table">
									<input type="text" name="userName" class="input-text" title="이름" value="${user.userName }" role="textbox" readonly required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">생년월일</th>
							<td>
								<div class="input-inside-table">
									<input type="text" name="userBirth" class="input-text" title="생년월일" value="${user.userBirth }" role="textbox" readonly required>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">휴대폰번호 <span class="required">*</span></th>
							<td colspan="3" class="phone">
								<div class="input-inside-table">
									<select name="userPhoneNum1" id="userPhoneNum1" class="input-width-small" required="required">
										<option value="">선택</option>
										<option value="010" ${userPhoneNum1 eq '010' ? 'selected' : '' }>010</option>
										<option value="011" ${userPhoneNum1 eq '011' ? 'selected' : '' }>011</option>
										<option value="016" ${userPhoneNum1 eq '016' ? 'selected' : '' }>016</option>
										<option value="017" ${userPhoneNum1 eq '017' ? 'selected' : '' }>017</option>
										<option value="019" ${userPhoneNum1 eq '019' ? 'selected' : '' }>019</option>
									</select>
									<span>-</span>
									<input type="text" name="userPhoneNum2" id="userPhoneNum2" class="input-width-small"  maxlength="4" value="${userPhoneNum2 }" required>
									<span>-</span>
									<input type="text" name="userPhoneNum3" id="userPhoneNum3" class="input-width-small"  maxlength="4" value="${userPhoneNum3 }" required>
									<input type="hidden" name="userPhoneNum" id="userPhoneNum">
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">이메일주소 <span class="required">*</span></th>
							<td colspan="3" class="email">
								<div class="input-inside-table">
									<input type="text" name="userMainAddress" value="${userMainAddress }" id="userMainAddress" class="input-width-smaller" required>
									<span class="input-sign">@</span>
									<input type="text" name="userDetailAddress" value="${userDetailAddress }" id="userDetailAddress" class="input-width-smaller" required>
									<input type="hidden" name="userDetailAddress" required>
									<select name="userDetailAddress" class="input-width-smaller">
										<option value="이메일을 선택하세요.">이메일을 선택하세요.</option>
										<option value="직접입력">직접입력</option>
										<option value="naver.com" ${userDetailAddress eq 'naver.com' ? 'selected' : '' }>naver.com</option>
										<option value="hanmail.net" ${userDetailAddress eq 'hanmail.net' ? 'selected' : '' }>hanmail.net</option>
										<option value="gmail.com" ${userDetailAddress eq 'gmail.com' ? 'selected' : '' }>gmail.com</option>
									</select>
									<input type="hidden" name="userEmail" id="userEmail" >
								</div>
							</td>
						</tr>
						
						<tr>
							<th scope="row">비밀번호 확인 <span class="required">*</span></th>
							<td colspan="3">
								<div class="input-inside-table">
									<input type="password" name="userPw" id="userPw" class="input-text-password" title="비밀번호 확인" role="textbox" maxlength="20" onkeyup="dupCheckUserPw(this.value);">
									<span id="messagePw" class="input-description">비밀번호 확인을 위해 입력해 주세요</span>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="board-util board-util02">
				<div class="board-util-left">
					<span class="board-util-text color-blue">※ 고객님께서 입력해주신 정보를 통하여 추후 고객 맞춤 정보 등 유익한 서비스가 제공되오니, 정확한 입력 부탁 드립니다.</span>
					<span class="board-util-text color-blue">※ 정보를 수정하신 후 확인 버튼을 클릭하셔야 정보 수정이 완료됩니다.</span><br />
					<span class="board-util-text color-red">※ 개명 관련 안내</span>
					<div class="list-default list-hyphen">
						<ul>
							<li class="color-red" style="font-size:15px">1단계) 원무창구에서 개명 사실 여부 확인 및 변경 등록  (신분증  지참)</li>
						</ul>
					</div>
				</div>
			</div>
		</section>
		<section class="section-button">
			<div class="board-util">
				<div class="board-util-right">
					<button type="button" class="button button-large button-blue" role="button" onclick="checkForm();"><span class="button-text">확인</span></button>
					<button type="button" class="button button-large button-gray" role="button" onclick="goPage();"><span class="button-text">취소</span></button>
				</div>
			</div>
		</section>
		</form>
		</div>
	</div>
	<%@include file="/resources/footer/footer.jspf" %>
</body>
</html>