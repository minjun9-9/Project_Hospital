<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 유형 선택</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f7fc;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        height: 100vh;
    }

    header {
        width: 100%;
        background-color: #007bff;
        padding: 20px 0;
        text-align: center;
        color: white;
        font-weight: bold;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    header a {
        color: white;
        text-decoration: none;
        font-size: 1.5rem;
        font-weight: bold;
    }

    .container {
        text-align: center;
        margin: auto;
        padding: 20px;
        width: 100%;
        max-width: 500px;
    }

    .container h1 {
        font-size: 2rem;
        color: #333;
        margin-bottom: 30px;
        font-weight: 600;
    }

    .button {
        display: block;
        width: 80%;
        max-width: 400px;
        margin: 15px auto;
        padding: 15px;
        font-size: 1.2rem;
        font-weight: bold;
        text-align: center;
        color: white;
        background-color: #007bff;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s, transform 0.2s, box-shadow 0.2s;
    }

    .button:hover {
        background-color: #0056b3;
        transform: translateY(-4px);
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    }

    .button:active {
        transform: translateY(0);
        background-color: #004494;
        box-shadow: 0 3px 6px rgba(0, 0, 0, 0.1);
    }

    @media (max-width: 600px) {
        header a {
            font-size: 1.2rem;
        }

        .container h1 {
            font-size: 1.8rem;
        }

        .button {
            font-size: 1rem;
            padding: 12px;
        }
    }
</style>
</head>
<body>
	<header>
		<div class="input-group">
			<a href="/hospital/index.jsp">아이티서울병원</a>
			<p class="txt">회원 유형 선택</p>
		</div>
	</header>
    <div class="container">
		<a href="terms?type=adult"><button class="button">일반 가입 (만 14세 이상)</button></a><br>
		<a href="terms?type=youth"><button class="button">소아/청소년 가입 (만 14세 미만)</button></a>
	</div>
</body>
</html>