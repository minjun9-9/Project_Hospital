<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
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
	
	.visuallyhidden {border: 0; clip: rect(0 0 0 0); height: 1px; margin: -1px; overflow: hidden; padding: 0; position: absolute; width: 1px;}
	
	.container {
	    text-align: center;
	    padding: 30px;
	    background-color: #fff;
	    border-radius: 10px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	    width: 100%;
	    max-width: 500px;
	    margin: auto;
	}
	
	.container h1 {
	    font-size: 24px;
	    margin-bottom: 20px;
	    color: #333;
	}
	
	.container p {
	    font-size: 16px;
	    color: #666;
	    margin-bottom: 30px;
	}
	
	.container button {
	    display: inline-block;
	    padding: 10px 20px;
	    margin: 0 10px;
	    background-color: #007bff;
	    color: white;
	    border: none;
	    border-radius: 5px;
	    font-size: 16px;
	    cursor: pointer;
	    text-decoration: none;
	}
	
	.container button:hover {
	    background-color: #0056b3;
	}
	
	.container .link-group a {
	    font-size: 14px;
	    color: #007bff;
	    text-decoration: none;
	    margin-top: 15px;
	    display: inline-block;
	}
	
	.container .link-group a:hover {
	    text-decoration: underline;
	}
</style>
<body>
	<header>
		<a href="/hospital/index.jsp">아이티윌병원</a>
		<ol class="signup_class">
			<li><span>약관동의</span></li>
			<li><span>회원정보입력</span></li>
			<li class="act"><span>가입완료<p class="visuallyhidden">현재페이지</p></span></li>
		</ol>
	</header>
	
	<div class="container">
		<h1>회원가입이 완료되었습니다!</h1>
		<p>가입해주셔서 감사합니다. 이제 로그인을 통해 서비스를 이용하실 수 있습니다.</p>
		<div class="button-group">
			<a href="user/login/login" class="button">로그인</a> |
			<a href="/hospital/index.jsp" class="button">홈으로</a>
		</div>
	</div>
	
	
</body>
</html>