<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>건의사항 작성 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
</head>
<style>
	table {
		border-collapse: collapse;
		border: 1px solid black;
	}
</style>
<body>

<h3>건의사항 작성 페이지</h3>

<div class="agree-form">
	<ul class="list-form">
		<li>
			<strong>1. 개인정보 등의 수집ㆍ이용 목적</strong>
			<p>아이티윌병원은 고객 건의함 이용시 기초 자료 수집을 위하여 다음과 같이 귀하의 개인정보를 수집.이용합니다.</p>
		</li>
		<li>
			<strong>2. 수집하려는 개인정보의 항목</strong>
			<p>(필수) 이름, 이메일, 전화번호, 환자와의 관계</p>
		</li>
		<li>
			<strong>3. 개인정보 등의 보유 및 이용 기간</strong>
			<p>홈페이지 회원 탈퇴 시 파기(홈페이지 1년 이상 미이용 시에는 개인정보가 분리 보관 됨)</p>
		</li>
		<li>
			<strong>4. 동의를 거부할 권리가 있다는 사실 및 동의 거부에 따른 불이익이 있는 경우에는 그 불이익의 내용</strong>
		</li>
	</ul>
	<p>※ 위의 개인정보 수집·이용에 대한 동의를 거부할 권리가 있습니다. 그러나 동의를 거부할 경우 이용이 제한됩니다.</p>
</div>

<div class="agree-form-check">
	<input type="checkbox" id="agreeCheckbox" name="agreeChk" >
	<span>개인정보 수집 및 이용에 동의합니다.</span>
</div>

<div class="board-top">
	<div class="list-default">
		<ul>
			<li>삼성서울병원 “고객의 소리”는 정확한 업무처리를 위해 실명제로 운영됩니다.</li>
			<li>게시판의 주제와 무관한 내용, 비속어 사용, 광고, 개인정보 노출 등의 글은 임의 삭제 될 수 있습니다.</li>
			<li>작성 완료된 글은 조회, 수정 및 삭제가 불가능합니다.</li>
			<li>진료상담 및 예약문의는 전화예약실(8282-8282)을 이용해 주시기 바랍니다.</li>
		</ul>
	</div>
</div>

<div class="qnaForm-div">
	<form action="insertQna" id="qnaForm" method="post" enctype="multipart/form-data">
		<table>
			<tbody>
			<tr>
				<th>이름 <span class="required">*</span></th>
				<td colspan="3"><input value="${user.userName }" name="userName"></td>
			</tr>
			<tr>
				<th>이메일 <span class="required">*</span></th>
				<td colspan="3"><input value="${user.userEmail }" name="userEmail" ></td>
			</tr>
			<tr>
				<th>전화번호 <span class="required">*</span></th>
				<td colspan="3"><input value="${user.userPhoneNum }" name="userPhoneNum" ></td>
			</tr>
			<tr>
				<th>환자와의 관계 <span class="required">*</span></th>
				<td colspan="3">
					<input type="radio" id="option1" name="relation" value="self" checked="checked" >
					<span>본인</span>
					<input type="radio" id="option2" name="relation" value="family" >
					<span>가족</span>	
					<input type="radio" id="option3" name="relation" value="etc" >
					<span>기타</span>
				</td>
			</tr>
			<tr>
				<th>건의 유형<span class="required">*</span></th>
				<td colspan="3">
					<input type="radio" id="option1" name="qnaType" value="compliment" checked="checked" >
					<span>칭찬</span>
					<input type="radio" id="option2" name="qnaType" value="discontent" >
					<span>불만</span>	
					<input type="radio" id="option3" name="qnaType" value="suggestion" >
					<span>제안 및 건의</span>
				</td>
			</tr>
			<tr>
				<th>제목<span class="required">*</span></th>
				<td colspan="3">
					<input type="text" name="title" required="required" id="titleInput">
					 <!-- maxlength="" 구현하기 1000바이트임
					 onkeyup='fn_filterChk(this)' 이것도 있드라 -->
				</td>
			</tr>
			<tr>
				<th>내용<span class="required">*</span></th>
				<td colspan="3">
					<textarea rows="" cols="" id="contentInput" name="content"></textarea>
					<span class="input-conut-limit"><strong><em id="content_len">0</em> byte / 최대 4000 byte</strong> (한글 2000자, 영문 4000자)</span>
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일 </th>
				<td>
					<input type="file" name="uploadFileList" id="fileUploadTag" multiple><br>
					<div class="file-list"></div><br>
					<span>업로드 가능한 파일 유형 : pdf, 텍스트, 사진</span><br>
					<span>최대 파일 개수 : 3개</span>
				</td>
			</tr>
			</tbody>
		</table>
		<input type="hidden" name="userId" value="${user.userId }">
		<button type="button" id="submitBtn"><span>등록하기</span></button>
		
	</form>
</div>

<script>
	var submitBtn = document.getElementById("submitBtn");

	submitBtn.addEventListener("click", function(e) {
		e.preventDefault();
		
		let agreeBtn = document.getElementById("agreeCheckbox");
		if (!agreeBtn.checked) {
			alert("개인정보 수집 및 이용에 동의해야 합니다.");
			return;
		} 
	
		let title = document.getElementById("titleInput").value;
		if (title.trim() === "") {
			alert("제목을 입력하세요.");
			document.getElementById("titleInput").focus();
			return;
		}
	
		let content = document.getElementById("contentInput").value;
		if (content.trim() === "") {
			alert("내용을 입력하세요.");
			document.getElementById("contentInput").focus();
			return;
		}
		
		//업로드 파일 개수 제한
		var MaxFileCnt = 3; //첨부파일 최대 개수
		var attachedFileCnt = document.getElementById("fileUploadTag").files.length; //추가된 첨부파일 수 
		console.log(attachedFileCnt);
		
		if (attachedFileCnt > 3)  {
			alert("첨부파일은 최대 " + MaxFileCnt + "개 까지 첨부할 수 있습니다.");
			$('#fileUploadTag').val(''); //애는 작동 잘 안되는 거 같음
			return;
		} 
		
		//첨부파일 검증
		var attachedFiles = document.getElementById("fileUploadTag").files;
		console.log(attachedFiles);
		let isValid = true;
		for (const file of attachedFiles) {
			if (!validation(file)) {
				isValid = false;
				$('#fileUploadTag').val(''); //얘는 되는 거 같은데
				break;
			} 
		}
		
		if (isValid) {
			let form = document.getElementById("qnaForm");
			form.submit();
		}
	
	
	});
	
	//첨부파일 검증 메소드 validation(obj)
	function validation(obj) {
		const fileTypes = ['image/png', 'image/jpeg', 'image/bmp', 'image/tiff'
							, 'application/pdf', 'application/vnd.hancom.hwp','application/haansofthwp','application/x-hwp', 'application/msword', 'text/plain', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
		if (obj.size > 10000000) {
			alert("최대 파일 용량인 10MB를 초과한 파일은 업로드하실 수 없습니다."); //용량 넘었는데 여기서 못 거르네..?
			console.log("Client uploaded file size :  ", obj.size)
			return false;
		} else if (obj.name.lastIndexOf('.') == -1) {
			alert("확장자가 없는 파일은 첨부하실 수 없습니다.");
			return false;
		} else if (!fileTypes.includes(obj.type)) {
			alert("첨부가 불가능한 유형의 파일을 선택하셨습니다.");
			console.log("Client uploaded file type :  ", obj.type)
			return false;
		} else {
			return true;
		}
	}
	

</script>

<c:if test="${status eq 'completed' }">
	<script>
		alert("고객의 소리 등록이 완료되었습니다. 메인 페이지로 이동합니다.");
		location.href = "../index.jsp";
	</script>
</c:if>

<c:if test="${not empty message}">
	<script>
		alert('${message}');
		location.href = "index.jsp";
	</script>
</c:if>


</body>
</html>