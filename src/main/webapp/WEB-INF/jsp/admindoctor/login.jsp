<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<c:if test="${not empty sessionScope.message}">
        <script>
            alert("${sessionScope.message}");
        </script>
        <c:remove var="message" scope="session" />
</c:if>
<style>

	html, body {
		width: 100%;
		height: 100%;
		margin: 0px;
		padding: 0px;
	}

	main {
		margin: 0px;
		padding: 0px;
	}

	.content { 

		width: 100%;
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
	}
</style>
<body>
	
	<div class="content">
		<h1 class="text-center">병원관리페이지</h1>
		<main class="form-signin w-25 m-auto mt-5 mb-5 pt-5 pb-5">
			<form method="post" action="login" id="loginForm">
				<h1 class="h3 mb-3 fw-normal"><strong>로그인</strong></h1>

				<div class="form-floating">
					<input type="text" class="form-control" id="id" placeholder="ID" name="id">
					<label for="floatingInput">ID</label>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" id="pw" placeholder="Password" name="pw">
					<label for="floatingPassword">Password</label>
				</div>
				
				<div class="d-flex justify-content-start my-3">
					<div class="form-check me-4">
						<!-- 아이디 저장 체크박스 -->
						<input class="form-check-input" type="checkbox" name="remember" value="true" id="flexCheckDefault">
						<label class="form-check-label" for="flexCheckDefault">
								아이디 저장
						</label>
					</div>
					
					<div class="form-check">
						<!-- 관리자 로그인 체크박스 -->
						<!-- 체크시 ADMIN 테이블 로그인, 아닐시 HP_MEMBER 테이블 로그인  -->
						<input class="form-check-input" type="checkbox" name="adminLogin" value="true" id="flexCheckDefault2">
						<label class="form-check-label" for="flexCheckDefault2">
								관리자 로그인
						</label>
					</div>
				</div>
				
				<button class="btn btn-primary w-100 py-2" type="submit">로그인</button>
				
				
			</form>
			
			
		</main>
	</div>
	
<script>
	document.getElementById("loginForm").addEventListener("submit", function(event) {
	    // ID와 Password 필드 가져오기
	    var id = document.getElementById("id").value.trim();
	    var pw = document.getElementById("pw").value.trim();
	    
	    // ID와 Password가 빈칸인지 확인
	    if (id === "" || pw === "") {
	        // 빈칸이 있을 경우 경고 메시지
	        alert("ID와 비밀번호를 모두 입력해 주세요.");
	        // 폼 제출을 막기
	        event.preventDefault();
	    }
	});
</script>	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>	
</body>
</html>