<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
	<%@include file="/resources/header/header.jspf" %>
<style>
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
		<div>
			<section id="contents">
				<h2 class="hidden">회원탈퇴</h2>
				<form name="memberleave" method="post" action="memberleave">
				<input type="hidden" name="mode" value="delete"/>
					<div class="default-info-heading box-default">
						회원 탈퇴를 위하여 본인 여부를 확인하고 있습니다. 정확한 정보를 입력해 주세요.
					</div>
					<div class="board-util board-util-top">
						<div class="board-util-right">
							<span class="board-util-text color-red">* 필수 입력 항목</span>
						</div>
					</div>

					<div class="table-wrapper">
						<table class="table-default board-form">
							<caption>회원탈퇴</caption>
							<colgroup>
								<col style="width: 140px" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">이름 <span class="required">*</span></th>
									<td>
										<div class="input-inside-table">
											<input type="text" name="userName" id="userName" class="input-text" title="이름" role="textbox" />
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">비밀번호 <span class="required">*</span></th>
									<td>
										<div class="input-inside-table">
											<input type="password" name="userPasswd" id="userPasswd" class="input-text" title="비밀번호" role="textbox" />
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">탈퇴사유</th>
									<td>
										<div class="input-inside-table">
											<textarea name="outReason" id="outReason" class="input-textarea" title="탈퇴사유" role="textbox" aria-multiline="true"></textarea>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="board-util">
						<div class="board-util-right">
							<button type="button" class="button button-large button-blue" role="button" onclick="chkForm();"><span class="button-text">회원탈퇴</span></button>
							<button type="button" class="button button-large button-gray" role="button" onclick="goPage();"><span class="button-text">취소</span></button>
						</div>
					</div>
				</form>
			</section>
		</div>
	</div>
	<%@include file="/resources/footer/footer.jspf" %>
</body>
</html>