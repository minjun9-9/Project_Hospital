<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(고객) 고객의 소리 게시판 </title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
</head>
<body>
<h3>(고객) 고객의 소리 게시판</h3>

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>첨부</th>
			<th>등록일</th>
			<th>작성자</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="qna" items="${qnaList}" varStatus="status">
		<tr>
			<td>${status.count }</td>
			<td>
				<a href="getQna?qnaId=${qna.qnaId }">${qna.title }</a>
			</td>
			<c:choose>  <%-- file.png --%>
				<c:when test="${qna.fileOne != null && qna.fileTwo == null && qna.fileThree == null }">
					<td> ${qna.fileOne} </td>
				</c:when>
				<c:when test="${qna.fileOne != null && qna.fileTwo != null && qna.fileThree == null }">
					<td> 
						${qna.fileOne} <br> 
						${qna.fileTwo} 
					</td>
				</c:when>
				<c:when test="${qna.fileOne != null && qna.fileTwo != null && qna.fileThree != null }">
					<td> 
						${qna.fileOne} <br> 
						${qna.fileTwo} <br> 
						${qna.fileThree} 
					</td>
				</c:when>
				<c:otherwise>
					<td>첨부된 파일x img</td>
				</c:otherwise>
			</c:choose> 
			<td>${qna.createdAt} </td>
			<td>
				${qna.userName }
				<input type="hidden" value="${qna.userNum}" id="userNumInput">
			</td>
		</tr>
		<c:if test="${qna.reply != null }"> <!-- 답글 있으면 -->
			<tr>
				<td>화살표img</td>
				<td colspan="2">
					<a href="javascript:getReplyAjax" data-value="${qna.qnaId }"> RE:${qna.title}</a>
				</td>
				<td colspan="2">${qna.replyAt}</td>
			</tr>
		</c:if>
	</c:forEach>
	</tbody>
</table>

</body>

<script>
	function getReplyAjax() {
		//작성자 일치 여부 확인 --따라서 사전에 이 페이지 진입할 때 로그인 여부 체크해야 함!!!!
		//그런데 js를 밖으로 빼면 el, jstl 사용이 불가능하다는데.. 그럼 어떻게 해야되냐
		
		let author = document.getElementById("userNumInput");
		console.log(author);
		
		
	}
</script>
</html>