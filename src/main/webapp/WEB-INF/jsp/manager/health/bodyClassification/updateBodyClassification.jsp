<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(관리자) 신체 분류 이름 수정 </title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
</head>
<body>
	<h3>(관리자) 신체 분류 이름 수정</h3>
	<div>
		신체 부위 명칭 <input value="${body.bodyPartName }" id="inputText" name="bodyPartName">
		<input type="hidden" value="${body.bodyPartId}" id="bodyPartId">
		<input type="button" value="수정하기" id="updateBtn">
	</div>

<script>
	$('#updateBtn').click(function(event) {
		event.preventDefault();
		
		let inputText = document.getElementById('inputText').value.trim();
		console.log(inputText);
		if (inputText == "") {
			alert("수정할 명칭을 입력해주세요.");
			document.getElementById('inputText').focus();
			return;
		} else {
			let bodyPartId = document.getElementById('bodyPartId').value;
			updateAjax(inputText, bodyPartId);
		}
		
	});
	
	//업데이트 ajax (경로변수_@PathVariable + 본문에 변수_@RequestBody)
	function updateAjax(inputText, bodyPartId) {
		console.log("넘어온 파라미터 : " + inputText + ", ID : " + bodyPartId);
		
		$.ajax({
			url : "updateBodyClassification/" + encodeURIComponent(inputText)
			, method : "put"
			, data : JSON.stringify({bodyPartId : bodyPartId})
			, dataType : "json"
			, contentType : "application/json"
			, success : function(data) {
				console.log("업데이트 성공 : " + data);
				if (data == 1) {
					alert("업데이트가 완료되었습니다. 목록 페이지로 이동합니다.");
					location.href="bodyClassificationManagePage";
				} else {
					alert("업데이트 도중에 문제가 생겼습니다.");
				}
			}
			, error : function() {
				alert("실패");
			}
		});
	}
</script>
</body>
</html>