<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객의 소리 답글달기</title>
</head>
<body>

<h3>고객의 소리 답글달기</h3>

<!-- 관리자 정보 session에서 가져올거임!!!!
	(이름, 이메일)		
-->

<div class="qnaReplyForm-div">
	<form action="replyQna" id="qnaForm" method="post">
		<table>
			<tbody>
			<tr>
				<th>이름 </th>
				<td colspan="3"><input value="${user.name }관리자 session으로 추후 추가 예정" name="userName"></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td colspan="3"><input value="${user.email }관리자 session으로 추후 추가 예정" name="userEmail" ></td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">
					<input type="text" name="title" readonly id="titleInput" value="RE:${qna.title }">
					 <!-- maxlength="" 구현하기 1000바이트임
					 onkeyup='fn_filterChk(this)' 이것도 있드라 -->
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<textarea rows="" cols="" id="contentInput" name="reply">${qna.reply }</textarea>
					<span class="input-conut-limit"><strong><em id="content_len">0</em> byte / 최대 4000 byte</strong> (한글 2000자, 영문 4000자)</span>
				</td>
			</tr>
			</tbody>
		</table>
		
		<input type="hidden" name="qnaId" value="${qnaId}">
		<button type="button" id="submitBtn"><span>등록하기</span></button>
		
	</form>
</div>

<script>
	var submitBtn = document.getElementById("submitBtn");

	submitBtn.addEventListener("click", function() {
	
		let content = document.getElementById("contentInput").value;
		if (content.trim() === "") {
			alert("내용을 입력하세요.");
			document.getElementById("contentInput").focus();
			return;
		}
		
		let form = document.getElementById("qnaForm");
		form.submit();
});

</script>


<c:if test="${message != null}">
	<script>
		alert("${message}");
		location.href="qnaListPage"; 
	</script>
</c:if>

</body>
</html>