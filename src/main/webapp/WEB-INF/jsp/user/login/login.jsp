<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	//네이버 로그인
	function naverLogin() {
	    const state = "naver_login_state"; // 세션 또는 토큰으로 상태 확인
	    const naverAuthUrl = "https://nid.naver.com/oauth/authorize?response_type=code"
	        + "&client_id=YOUR_NAVER_CLIENT_ID"
	        + "&redirect_uri=YOUR_REDIRECT_URI"
	        + "&state=" + state;
	    window.location.href = naverAuthUrl;
	}
	
	//카카오 로그인
    function kakaoLogin() {
        const state = "kakao_login_state"; // 세션 또는 토큰으로 상태 확인
        const kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize?response_type=code"
            + "&client_id=YOUR_KAKAO_CLIENT_ID"
            + "&redirect_uri=YOUR_REDIRECT_URI"
            + "&state=" + state;
        window.location.href = kakaoAuthUrl;
    }
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f7f8fa;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    
    .login-container {
        max-width: 400px;
        width: 100%;
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        padding: 30px;
        text-align: center;
    }
    
    .login-container h1 {
        font-size: 26px;
        color: #4c4c4c;
        margin-bottom: 20px;
    }
    
    .login-container input {
        width: 100%;
        padding: 10px;
        margin: 12px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }
    
    .login-container button {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        color: #ffffff;
        cursor: pointer;
        margin-top: 10px;
    }
    
    .login-container button:hover {
        background-color: #0056b3;
    }
    
    .login-container .link-group {
        margin-top: 25px;
        font-size: 14px;
        color: #007bff;
    }
    
    .login-container .link-group a {
        text-decoration: none;
        color: #007bff;
        margin: 0 10px;
    }
    
    .login-container .link-group a:hover {
        text-decoration: underline;
    }
    
    .social-login {
        margin-top: 20px;
    }
    .social-login img {
        width: 50px;
        margin: 0 10px;
        cursor: pointer;
    }
</style>
</head>
<body>
    <div class="login-container">
		<h1>로그인</h1>
    	<div class="logo">
    		<a href="<%= request.getContextPath() %>/index.jsp" >아이티서울병원</a>
    	</div>
        <form id="loginForm" action="login" method="post">
			<input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요">
			<input type="password" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요">
			<input type="hidden" name="redirect" id="redirectInput">
			<div class="checkbox-group">
				<label for="rememberId">아이디 저장
					<input type="checkbox" id="rememberId">
				</label>
			</div>
			<button type="submit">로그인</button>
		</form>
		<div class="link-group">
			<a href="<%= request.getContextPath() %>/user/find/findid">아이디 찾기</a> | 
			<a href="<%= request.getContextPath() %>/user/find/findpw">비밀번호 찾기</a> | 
			<a href="<%= request.getContextPath() %>/user/signup/selecttype">회원가입</a>
		</div>
		<div class="social-login">
		    <h2 class="h3">간편인증 로그인</h2>
		    <button class="btn_kakao_login" onclick="kakaoLogin()">카카오 로그인</button>
		    <button class="btn_naver_login" onclick="naverLogin()">네이버 로그인</button>
		</div>
    </div>
<script>
	document.addEventListener("DOMContentLoaded", function () {
		const loginForm = document.getElementById("loginForm")
		const userIdInput = document.getElementById('userId');
		const userPwInput = document.getElementById('userPw');
		const rememberCheckbox = document.getElementById("rememberId");
		
	    // 아이디 입력 제한 및 모든 입력 초기화
	    userIdInput.addEventListener("input", function () {
	        const value = userIdInput.value;
	        if (/[A-Zㄱ-ㅎㅏ-ㅣ가-힣]/.test(value)) {
	        	alert("아이디는 소문자 영문자와 숫자만 입력 가능합니다.");
	            loginForm.reset();
	            userIdInput.focus();
			}
		});
		
		loginForm.addEventListener("submit", function (event) {
			event.preventDefault();
			
			const userId = userIdInput.value.trim();
			const userPw = userPwInput.value.trim();
			
			// 1. 아이디와 비밀번호를 입력하지 않을 때
			if (!userId && !userPw) {
				event.preventDefault();
				alert("아이디와 비밀번호를 모두 입력하세요.");
				return;
			}
			
			// 2. 아이디를 입력하지 않을 때
			if (!userId) {
				event.preventDefault();
				alert("아이디를 입력하세요.");
				return;
			}
			
			// 3. 비밀번호를 입력하지 않을 때
			if (!userPw) {
				event.preventDefault();
				alert("비밀번호를 입력하세요.");
				return;
			}
		
        fetch("/hospital/user/login/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ userId, userPw }),
        })
            .then((response) => response.json())
            .then((data) => {
                if (data.success) {
                    /* window.location.href = "/hospital/index.jsp"; */
                    window.location.href = data.redirectUrl;
                } else {
                    alert(data.message);
                }
            })
            .catch((error) => {
                console.error("서버와의 통신 중 오류 발생:", error);
                alert("서버와의 통신 중 문제가 발생했습니다. 다시 시도해주세요.");
            });
		});
		
		// 페이지 로드 시 저장된 아이디 로드
		const savedUserId = localStorage.getItem("savedUserId");
		if (savedUserId) {
			userIdInput.value = savedUserId;
			rememberCheckbox.checked = true;
		}
		
		// 아이디 저장 체크박스 이벤트
		rememberCheckbox.addEventListener("change", function () {
			if (this.checked) {
				localStorage.setItem("savedUserId", userIdInput.value);
			} else {
				localStorage.removeItem("savedUserId");
				userIdInput.value = "";
			}
		});
		
		// 입력 변경시 아이디 저장
		userIdInput.addEventListener("input", function () {
			if (rememberCheckbox.checked) {
				localStorage.setItem("savedUserId", userIdInput.value);
			}
		});
		 const urlParams = new URLSearchParams(window.location.search);
	      const redirectUrl = urlParams.get('redirect') || '/hospital/index.jsp';
	      document.getElementById('redirectInput').value = redirectUrl;
	});
</script>

</body>
</html>










