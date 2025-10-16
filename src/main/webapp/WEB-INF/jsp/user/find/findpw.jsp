<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
	<header class="header member-header" role="banner" data-spy="affix" data-offset-top="240">
		<div class="inner-wrap">
			<h1 id="brand">
				<a href="/home/main/index.do" class="brand-logo brand-login-center" title="메인으로 이동"><span class="brand-text">아이티윌병원 통합로그인센터</span></a>
			</h1>
		</div>
		<div class="inner-wrap" role="navigation">
			<ul id="gnb" class="menubar root-level" role="menubar" title="전체메뉴">
				<li class="menu-parent gnb-A" role="presentation">
					<a id="gnb_menu_A" href="user/signup/selecttype" role="menuitem" aria-haspopup="false" >
						<span class="sound-only"><em>통합회원가입</em></span>
					</a>
				</li>
		
				<li class="menu-parent gnb-B" role="presentation">
					<a id="gnb_menu_B" href="user/login/login" role="menuitem" aria-haspopup="false" >
						<span class="sound-only"><em>로그인</em></span>
					</a>
				</li>
		
				<li class="menu-parent gnb-C" role="presentation">
					<a id="gnb_menu_C" href="/hospital/user/find/findid" role="menuitem" aria-haspopup="false" >
						<span class="sound-only"><em>아이디 찾기</em></span>
					</a>
				</li>

				<li class="menu-parent gnb-C02" role="presentation">
					<a id="gnb_menu_C02" href="/hospital/user/find/findpw" role="menuitem" aria-haspopup="false" >
						<span class="sound-only"><em>비밀번호 찾기</em></span>
					</a>
				</li>
		
				<li class="menu-parent gnb-D" role="presentation">
					<a id="gnb_menu_D" href="#" role="menuitem" aria-haspopup="false" >
						<span class="sound-only"><em>회원약관</em></span>
					</a>
				</li>
		
				<li class="menu-parent gnb-E" role="presentation">
					<a id="gnb_menu_E" href="#" role="menuitem" aria-haspopup="false" aria-current="true">
						<span class="sound-only"><em>개인정보처리방침</em></span>
					</a>
				</li>
			</ul>
		</div>
	</header>
	<section id="contents">
		<h2 class="hidden">비밀번호 찾기</h2>
		<h3 class="info-txt info-txt-large">비밀번호를 잊어버리셨나요? <br> 휴대폰 또는 이메일 확인을 하시면 임시비밀번호를 발급해드립니다.</h3>
		<div class="certify-area certify-area-input" id="div_PW"  style="height:auto;padding:30px 35px">
			<div class="certify">
				<div class="input-radio-group">
					<label class="input-radio">
						<input type="radio" id="findPwdByCP" name="findPwdMethod" value="H" role="radio" onclick="setFindMethod(this.id)" checked="checked" />
						<i aria-hidden="true"></i><span class="label-text">휴대폰 확인</span>
					</label>
					<label class="input-radio">
						<input type="radio" id="findPwdByEmail" name="findPwdMethod" value="E" role="radio" onclick="setFindMethod(this.id)" />
						<i aria-hidden="true"></i><span class="label-text">이메일 확인</span>
					</label>
				</div>
					<!-- 비밀번호 찾기 폼(휴대폰 확인) [S] -->
				<form id="findPwdByCPForm" name="findPwdByCPForm" action="/home/member/findIdPwPersist.do" method="post" onsubmit="return doSubmitPw(this)">
					<filedset>
						<legend>비밀번호 찾기 폼(휴대폰 확인)</legend>
						<input type="hidden" name="gubun" value="PWD">	
						<input type="hidden" name="findIdPwd" value="H">
						<div class="wrap_table_form table03">
							<table id="table03-1" class="table-default table-type03 table-line-none">
								<caption>비밀번호 찾기</caption>
								<colgroup>
									<col style="width:12%;">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="userId1">아이디</label><span class="star" title="필수입력">*</span></th>
										<td>
											<input type="text" id="userId1" name="userId" onkeyup="chkInputID(this.value, this.id)" class="input-text input-width-normal" role="textbox" />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="userName3">이름</label><span class="star" title="필수입력">*</span></th>
										<td>
											<input type="text" id="userName3" name="userName" class="input-text input-width-normal" role="textbox" maxlength="35" />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="userPhone3_1">휴대폰</label> <span class="star" title="필수입력">*</span></th>
										<td>
											<div class="input-selectbox">
												<select id="userPhone3_1" name="tel1" title="휴대폰 첫번째 자리 입력" maxlength="3" style="width:71px">
													<option value="010">010</option>
													<option value="011">011</option>
													<option value="016">016</option>
													<option value="017">017</option>
													<option value="018">018</option>
													<option value="019">019</option>
												</select>
												- <input type="text" id="userPhone3_2" name="tel2" class="input-text input-width-small" role="textbox" title="휴대폰 두번째 자리 입력" maxlength="4" onkeyup="chkInputNum(this.value, this.id)" />
												- <input type="text" id="userPhone3_3"  name="tel3" class="input-text input-width-small" role="textbox" title="휴대폰 세번째 자리 입력" maxlength="4" onkeyup="chkInputNum(this.value, this.id)" />
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</filedset>
				</form>
				<!-- 비밀번호 찾기 폼(휴대폰 확인) [E] -->
				
				<!-- 비밀번호 찾기 폼(이메일 확인) [S] -->
				<form id="findPwdByEmailForm" name="findPwdByEmailForm" action="/home/member/findIdPwPersist.do" method="post" onsubmit="return doSubmitPw(this)">
					<filedset>
						<legend>비밀번호 찾기 폼(이메일 확인)</legend>
						<input type="hidden" name="gubun" value="PWD">	
						<input type="hidden" name="findIdPwd" value="E">
						<div class="wrap_table_form table04">
							<table id="table04-1" class="table-default table-type03 table-line-none">
								<caption>비밀번호 찾기</caption>
								<colgroup>
									<col style="width:12%;">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><label for="userId2">아이디</label><span class="star" title="필수입력">*</span></th>
										<td>
											<input type="text" id="userId2" name="userId" onkeyup="chkInputID(this.value, this.id)" class="input-text input-width-normal" role="textbox" />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="userName4">이름</label><span class="star" title="필수입력">*</span></th>
										<td>
											<input type="text" id="userName4" name="userName" class="input-text input-width-normal" role="textbox" maxlength="35" />
										</td>
									</tr>
									<tr>
										<th scope="row"><label for="userEmail4_1">이메일</label> <span class="star" title="필수입력">*</span></th>
										<td>
											<div class="input-selectbox">
												<input type="text" id="userEmail4_1" name="email1" class="input-text input-width-normal" role="textbox" maxlength="15" />
												@<input type="text" id="userEmail4_2" name="email2" class="input-text input-width-normal" role="textbox" title="이메일 주소 입력" />
												<select id="userEmail4_3" name="email3" onchange="applyEmailInput(this.id)">
												    <option value="직접입력">직접입력</option>
												    <option value="naver.com">naver.com</option>
												    <option value="hanmail.net">hanmail.net</option>
												    <option value="gmail.com">gmail.com</option>
												</select>									
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</filedset>
				</form>
				<!-- 비밀번호 찾기 폼(이메일 확인) [E] -->					
			</div>
		</div>
		<div class="btns-wrap" id="btn_PW" style="display: none;">
			<a href="/home/main/index.do" class="button button-large button-gray" role="button"><span class="button-text">취소</span></a>
			<button type="button" onclick="findPwdSubmit()" class="button button-large button-blue" role="button"><span class="button-text">확인</span></button>
		</div>
<div id="dataFocus" tabindex="0">		
	
	
	
	
	
		<div class="join-link"> <!-- 회원가입 링크 [S] -->			
			<p class="info-txt info-txt-normal">
				아직 가입하지 않으셨다면 지금 회원으로 가입하세요.<br>삼성서울병원이 제공하는 다양하고 유용한 온라인서비스를 이용하실 수 있습니다.
			</p>
			<a href="/home/create/createAccount.do" class="button button-large button-blue" role="button"><span class="button-text">회원가입</span></a>
		</div> <!-- 회원가입 링크 [E] -->
	
	
</div>
	</section>
</body>
</html>