<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A page</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
</head>
<body>

<h3>Q&A page</h3>

<span><a href="javascript:deleteAjax()">삭제</a></span>

<table>
	<thead>
		<tr>
			<th><input type="checkbox" id="checkAll"></input></th>
			<th>번호</th>
			<th>제목</th>
			<th>첨부</th>
			<th>등록일</th>
			<th>작성자</th>
			<th>답글등록</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="qna" items="${qnaList}" varStatus="status">
		<tr>
			<td><input type="checkbox" class="chk" name="qnaId" value="${qna.qnaId }"></td>
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
			<td>${qna.userName }</td>
			<c:if test="${qna.reply == null }">
				<td><a href="replyQna?qnaId=${qna.qnaId }"><button>답글달기</button></a></td> <!-- pencil.png -->
			</c:if> 
			<c:if test="${qna.reply != null }">
				<td><a href="replyQna?qnaId=${qna.qnaId }"><button>답글수정</button></a></td> <!-- pencil.png -->
			</c:if>
			<td><a href="deleteSingleQna?qnaId=${qna.qnaId }" class="deleteLink"><button>삭제</button></a></td>	<!--delete.png  -->
		</tr>
	</c:forEach>
	</tbody>
</table>


</body>
<script>
	function deleteAjax() {
		
		var checkBoxArr = [];
		$("input:checkbox[name='qnaId']:checked").each(function() {
			checkBoxArr.push($(this).val());
			console.log(checkBoxArr);
		})
		
		if (checkBoxArr.length === 0) {
			alert("선택된 항목이 없습니다.");
			return;
		}
		
		if (confirm("선택된 항목을 삭제하시겠습니까?")) {
			$.ajax("deleteQna", {
				type: "post",
				contentType: "application/json",
				data: JSON.stringify({qnaIds : checkBoxArr}),
				success: function () {
					alert("삭제가 완료되었습니다. ");
					location.reload();
				} ,
				error: function() {
					alert("삭제가 실패하였습니다.");
				}
				
			});
		} else {
			location.reload();
			return;
		}
		
	}
	
	//삭제 버튼 연결했더니 length에서 걸리네. 일단 따로 구현 근데 나중에 알아보기
	//$(document).on("click", "#deleteBtn", deleteAjax);
	
	//따로 구현
	$(document).on("click", ".deleteLink", function(event) {
		if (!confirm("정말 삭제하시겠습니까?")) {
			event.preventDefault();
		}
	});

	
	//전체 체크 기능
	let checkAll = document.getElementById("checkAll");
	
	checkAll.addEventListener("click", function() {
		
		const isChecked = checkAll.checked;
		if (isChecked) {
			const checkboxes = document.querySelectorAll(".chk");
			for (const checkbox of checkboxes) {
				checkbox.checked = true;
			}
		} else {
			const checkboxes = document.querySelectorAll(".chk");
			for (const checkbox of checkboxes) {
				checkbox.checked = false;
			}
		}
		
	});
</script>

</html>