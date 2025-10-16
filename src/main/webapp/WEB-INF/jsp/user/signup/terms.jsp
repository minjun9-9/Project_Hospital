<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>약관 동의</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function () {
		const termsCheckbox = document.getElementById('terms-checkbox');
		const privacyCheckbox = document.getElementById('privacy-checkbox');
		const allCheckbox = document.getElementById('all-checkbox');
		const prevBtn = document.getElementById('prev-btn');
		const submitBtn = document.getElementById('submit-btn');
		
		submitBtn.addEventListener('click', function (event) {
			if (!validateAgreement(termsCheckbox, privacyCheckbox)) {
				event.preventDefault();
			}
		});
		
		if(prevBtn) {
			prevBtn.addEventListener('click', function() {
				event.preventDefault();
				window.location.href = "/hospital/user/signup/selecttype"
			});
		} 
	            
    	allCheckbox.addEventListener('change', function () {
			const isChecked = allCheckbox.checked;
            termsCheckbox.checked = isChecked;
			privacyCheckbox.checked = isChecked;
		});
	});
                    
	function validateAgreement(termsCheckbox, privacyCheckbox, allCheckbox) {
		if (!termsCheckbox.checked && !privacyCheckbox.checked) {
		    alert('이용약관 및 개인정보 수집에 모두 동의해주세요.');
			return false;
		}
		
		if (!termsCheckbox.checked || !privacyCheckbox.checked) {
			if (!termsCheckbox.checked) {
				alert('이용약관에 동의해주세요.');
				return false;
			}
	                    	        
			if (!privacyCheckbox.checked) {
				alert('개인정보 수집 및 이용에 동의해주세요.');
				return false;
			}
		}
        
		hideAlert();
		 return true;
		}
	
		function showAlert(message) {
			const alertBox = document.getElementById('alert-box');
			alertBox.textContent = message;
			alertBox.style.display = 'block';
		}
		
		function hideAlert() {
			const alertBox = document.getElementById('alert-box');
			alertBox.style.display = 'none';
		}
</script>
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
	    width: 90%;
	    max-width: 600px;
	    background: white;
	    padding: 20px;
	    margin: 20px auto;
	    border-radius: 8px;
	    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}
	
	h1 {
	    font-size: 1.5rem;
	    text-align: center;
	    margin-bottom: 20px;
	    color: #333;
	}
	
	.checkbox-group {
	    margin-bottom: 20px;
	    display: flex;
	    align-items: center;
	}
	
	.checkbox-group input[type="checkbox"] {
	    margin-right: 10px;
	}
	
	.checkbox-group label {
	    font-size: 1rem;
	    color: #333;
	}
	
	.btn-container {
	    display: flex;
	    justify-content: space-between;
	    margin-top: 20px;
	}
	
	.btn {
	    width: 48%;
	    padding: 10px;
	    font-size: 1rem;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	}
	
	.btn-primary {
	    background-color: #007bff;
	    color: white;
	}
	
	.btn-primary:hover {
	    background-color: #0056b3;
	}
	
	.btn-secondary {
	    background-color: #6c757d;
	    color: white;
	}
	
	.btn-secondary:hover {
	    background-color: #5a6268;
	}
	
	.alert {
	    display: none;
	    background-color: #f8d7da;
	    color: #721c24;
	    padding: 10px;
	    border: 1px solid #f5c6cb;
	    margin-top: 10px;
	    border-radius: 5px;
	}
	
	.visuallyhidden {border: 0; clip: rect(0 0 0 0); height: 1px; margin: -1px; overflow: hidden; padding: 0; position: absolute; width: 1px;}
</style>
</head>
<body>
	<header>
		<a href="/hospital/index.jsp">아이티윌병원</a>
		<ol class="signup_class">
			<li class="act"><span>약관동의<p class="visuallyhidden">현재페이지</p></span></li>
			<li><span>회원정보입력</span></li>
			<li><span>가입완료</span></li>
		</ol>
	</header>
	
    <div class="container">
		<h1>약관 동의</h1>
		<form action="register" method="get">
			<input type="hidden" name="type" value="${param.type }">
			<div class="checkbox-group">
				<input type="checkbox" id="all-checkbox">
				<label for="all-checkbox">전체 동의</label>
			</div>
			<div class="checkbox-group">
				<input type="checkbox" id="terms-checkbox">
				<label for="terms-checkbox">이용 약관 동의 (필수)</label>
			</div>
			<div class="checkbox-group">
				<input type="checkbox" id="privacy-checkbox">
				<label for="privacy-checkbox">개인정보 수집 및 이용 동의 (필수)</label>
			</div>
	
			<div class="btn-container">
				<button class="btn btn-secondary" id="prev-btn">이전</button>
				<button class="btn btn-primary" id="submit-btn" type="submit">다음</button>
			</div>
	
			<div class="alert" id="alert-box"></div>
		</form>
	</div>
</body>
</html>









