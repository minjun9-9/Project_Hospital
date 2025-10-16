<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 글 상세페이지</title>
</head>
<body>
<h3>Q&A 글 상세페이지</h3>

<table>
	<tr>
		<th>제목</th>
		<td>${qna.title }</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>${qna.userNum }</td>
	</tr>
	<tr>
		<th>작성일</th>
		<td>${qna.createdAt }</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${qna.content }</td>
	</tr>
	<tr>
		<th>첨부파일</th>
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
	</tr>
</table>

</body>
</html>