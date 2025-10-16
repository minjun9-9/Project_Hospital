<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
	<%@include file="/resources/header/header.jspf" %>
<style>
/* 전체 레이아웃 */
.page-container {
    display: flex;
    flex-direction: row;
    min-height: 100vh;
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
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

/* 안내 문구 */
.info-box {
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 5px;
    font-size: 14px;
    margin-bottom: 15px;
}

/* 폼 컨테이너 */
.form-container {
    width: 1000px;
    margin: 50px auto;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    background: #f9f9f9;
    text-align: center;
}

/* 입력 필드 */
.input-text {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
}

/* 비밀번호 정책 안내 */
.pwd-policy {
    font-size: 13px;
    color: #555;
    margin-top: 5px;
}

.pwd-policy li {
    list-style: none;
    padding-left: 20px;
    position: relative;
    margin-bottom: 5px;
    text-align: left;
}

.pwd-policy li:before {
    content: "✔";
    position: absolute;
    left: 0;
    color: #007bff;
    font-size: 14px;
}

/* 버튼 */
.button {
    width: 20%;
    padding: 10px;
    font-size: 1rem;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

.button-gray {
    background-color: #6c757d;
    color: white;
}

.button-blue {
    background-color: #007bff;
    color: white;
}

.button:hover {
    transform: translateY(-2px);
}

.button:active {
    transform: translateY(0);
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
</style>
<script>
    function changePassword() {
        const currentPw = document.getElementById("currentPw").value;
        const newPw = document.getElementById("newPw").value;
        const confirmPw = document.getElementById("confirmPw").value;

        // 입력 필드 검증
        if (!currentPw || !newPw || !confirmPw) {
            alert("모든 필드를 입력하세요.");
            return;
        }
        if (newPw.length < 8 || newPw.length > 20) {
            alert("비밀번호는 8~20자 이내로 설정하세요.");
            return;
        }
        if (newPw !== confirmPw) {
            alert("새 비밀번호가 일치하지 않습니다.");
            return;
        }

        // 비밀번호 변경 요청
        fetch("/hospital/user/userpage/passwordmodify", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                currentPw: currentPw,
                newPw: newPw
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert(data.message);
                window.location.href = "/hospital/user/userpage/userpage";
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            console.error("비밀번호 변경 중 오류 발생:", error);
            alert("비밀번호 변경 중 오류가 발생했습니다.");
        });
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
		
		<div class="form-container">
			<form action="updatePassword" method="post" id="updatePassword">
				<section>
					<div class="section-heading section-heading-top">
						<h3 class="section-heading-title">비밀번호 변경</h3>
					</div>
					
					<div class="board-util board-util-top02">
						<div class="board-util-right">
							<label><span class="board-util-text color-red" style="color: red;">* </span>필수 입력 항목</label>
						</div>
					</div>
				</section>
				<section>
					<div class="info-box">
						고객님의 소중한 정보보호를 위하여 3개월 주기로 비밀번호를 변경하여 주시기 바랍니다.
					</div>
				</section>
					
				<!-- 안내 메시지 -->
				<section>
					<div class="table-wrapper" role="form">
						<table class="table-default board-form table-member-PWDWDWDWDWDWDmodify">
							<tbody>
								<tr>
									<th scope="row"><label for="currentPw">기존 비밀번호 <span style="color: red;">*</span></label></th>
									<td>
										<div class="input-inside-table">
											<input type="password" id="currentPw" class="input-text" placeholder="현재 비밀번호" required>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="newPw">변경 비밀번호 <span style="color: red;">*</span></label></th>
									<td>
										<div class="input-inside-table">
											<input type="password" id="newPw" class="input-text" placeholder="새 비밀번호 (8~20자)" required>
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<div class="input-inside-table">
											<ul class="pwd-policy">
												<li>비밀번호 8~20자 입력</li>
												<li>영문/숫자/특수문자 또는 영문/숫자 혼합 사용</li>
												<li>동일한 숫자, 문자 3자 이상 반복 미사용</li>
												<li>연속된 숫자 3자 이상 미사용</li>
											</ul>	
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="confirmPw">변경 비밀번호 확인 <span style="color: red;">*</span></label></th>
									<td>
										<div class="input-inside-table">
											<input type="password" id="confirmPw" class="input-text" placeholder="비밀번호 확인" required>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</section>
				
				<!-- 버튼 -->
				<section>
					<div class="button-container">
						<button type="button" class="button button-gray" onclick="window.location.href='/hospital/user/userpage/userpage'">3개월 후 변경</button>
						<button type="button" class="button button-blue" onclick="changePassword()">변경완료</button>
					</div>
				</section>
			</form>
		</div>
	</div>
	<%@include file="/resources/footer/footer.jspf" %>
</body>
</html>