<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(관리자) 신체 분류 INSERT </title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
</head>
<body>
	<h3>(관리자) 신체 분류 INSERT</h3>
	<div>
		신체 분류 명칭 <input placeholder="신체 분류 명칭을 입력하세요." id="inputText" name="bodyPartName">
		<input type="button" value="추가하기" id=insertBtn>
	</div>

<script>
	$('#insertBtn').click(function(event) {
		event.preventDefault();
		
		let inputText = document.getElementById('inputText').value.trim();
		console.log(inputText);
		if (inputText == "") {
			alert("추가할 신체 분류 명칭을 입력해주세요.");
			document.getElementById('inputText').focus();
			return;
		} else {
			insertAjax(inputText);
		}
		
	});
	
	//INSERT ajax
	function insertAjax(inputText) {
		console.log("넘어온 파라미터 : " + inputText);
		
		$.ajax({
			url : "insertBodyClassification/" + encodeURIComponent(inputText)
			, method : "post"
			, success : function(data) {
				console.log("인서트 성공 : " + data);
				if (data == 1) {
					alert("추가가 완료되었습니다. 목록 페이지로 이동합니다.");
					location.href="bodyClassificationManagePage";
				} else {
					alert("추가 도중에 문제가 생겼습니다.");
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