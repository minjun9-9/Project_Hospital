<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(관리자) 건강 정보 : 질환 분류 관리 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
</head>
<body>
	<h3>(관리자) 건강 정보 : 질환 분류 관리 페이지</h3>
	<div class="body_wrap">
		<!-- 사이드바 -->
		<%@ include file="WEB-INF/../../../../common/sidebar.jspf"%>
	</div>
	
	<!-- content 시작 -->
	<div class="content">
		<div class="top_bar bg_w">
			<a href="#" class="top_left health_con"><span>질환 분류 관리</span></a>
			<!-- 탑바 right 컨텐츠-->
			<%@ include file="WEB-INF/../../../../common/topbarContent.jspf"%>
		</div>
	</div>
	<div class="con_wrap bg_13">
		<!-- 컨텐츠 시작 -->
		<div class="tab03_wrap normal bg_w">
			<!-- tab1 메인 화면 -->
			<div class="tab03_li">
				<p class="tab03_btn f_w700 f_s17 c_3 bor_2">메인화면</p>
			</div>
			<div class="up_date">
				<p>Date</p>
				<div class="calendar">
					<input type="date" value="2023-03-05">
					<span>-</span>
					<input type="date" value="2023-03-05">
				</div>
				<ul>
					<li class="bor_2 on"><a href="#">전체</a></li>
					<li class="bor_2"><a href="#">오늘</a></li>
					<li class="bor_2"><a href="#">1주일</a></li>
					<li class="bor_2"><a href="#">1달</a></li>
				</ul>
			</div>
			<div class="left_down">
				<div class="find_box bg_8">
					<label for="search" class="f_s16 f_w500"><input type="radio" name="type" checked>제목만</label>
					<label for="search" class="f_s16 f_w500"><input type="radio" name="type">내용만</label>
					<label for="search" class="f_s16 f_w500"><input type="radio" name="type">태그만</label>
				</div>
				<div class="search">
					<input type="text" class="search_box" placeholder="Search">
					<a href="#">검색</a>
				</div>
			</div>
			<div class="tab03_mid">
				<span class="subtit f_s20 f_w700">Hihy 건강저장소 TV</span>
				<div class="mid_btn">
					<a href="#" id="multi_deleteBtn">삭제</a>
					<a href="insertDiseaseClassificationPage" class="bg_2 f_w500 f_s15">질환 분류 추가</a>
				</div>
			</div>
			<table class="table_sty01">
				<caption>Hihy 건강저장소 TV</caption>
				<colgroup>
					<col width="80px">
					<col width="150px">
					<col width="80px">
					<col width="80px">
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="checkAll"></th>
						<th><span>질환 분류 명칭</span></th>
						<th><span>수정</span></th>
						<th><span>삭제</span></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="disease" items="${diseaseClassificationList}">
					<tr>
						<td><input type="checkbox" class="chk" value="${disease.diseasePartId}"></td>
						<td>${disease.diseasePartName }</td>
						<td><a href="updateDiseasePartNamePage?diseasePartId=${disease.diseasePartId}"><span class="pencil">수정</span></a></td>
						<td>
							<div class="del_box">
								<a href="" class="deleteBtnClass" data-disease-part-id="${disease.diseasePartId}"><img src="${pageContext.request.contextPath }/resources/images/delete.png" alt="">삭제</a>
							</div>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
<script>

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
	
	//여러개 삭제 기능
	let multi_deleteBtn = document.getElementById("multi_deleteBtn");
	
	multi_deleteBtn.addEventListener('click', function(event) {
		event.preventDefault();
		
		const checkboxes = document.querySelectorAll(".chk");
		const selectedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked);
		const selectedIds = selectedCheckboxes.map(checkbox => checkbox.value);
		if (selectedCheckboxes.length == 0) {
			alert("삭제할 항목을 선택해주세요.");
			return;
		}
		
		if(confirm("정말 삭제하시겠습니까?")) {
			deleteAjax(selectedIds);
		} else {
			location.reload(); //선택한 체크박스 해제하기
		}
		
	});
	
	//각각 삭제 기능
	document.querySelectorAll('.deleteBtnClass').forEach(btn => {
		btn.addEventListener('click', function(event) {
			event.preventDefault();
			
			const diseasePartId = this.dataset.diseasePartId; //data-disease-part-id 속성값 가져오기
			console.log("삭제 선택한 id : " + diseasePartId);
			
			if(confirm("정말 삭제하시겠습니까?")) {
				deleteAjax(diseasePartId);
			} else {
				return;
			}
			
		})
	})
	
	
	function deleteAjax(selectedIds) {
		console.log("삭제할 id : " + selectedIds);
		console.log(JSON.stringify({selectedId : selectedIds}));
		const dataToSend = Array.isArray(selectedIds) ? selectedIds : [selectedIds]; // 항상 배열로 변환--> 이거 추가하니까 되네...?
					//배열이면 그냥 보내고, 배열 아니면 []배열로 만들기
					//값이 하나인 경우에도 배열 형태로 보내지 않으면 매핑 오류!!!!!!! 하나 선택에서 보내면 String 타입으로 넘어가는거지., dto는 String[] 이니까
		
		$.ajax({
			url : "deleteDiseaseClassification"
			, method : "delete"
			, data : JSON.stringify({selectedId : dataToSend})
			, dataType : "json"
			, contentType : "application/json"
			, success : function(data) {
				console.log("삭제된 행 수 : " + data);
				if (data >= 1) {
					alert("삭제가 완료되었습니다.");
					location.reload();
				} else {
					alert("삭제 도중 문제가 발생했습니다.");
				}
			}
			, error : function() {
				alert("실패");
			}
			
		});
	}
	
	
	
</script>
<script>
	// 사이드바 토글 움직임
	document.querySelector('.healthul').classList.add('on');
	document.querySelector('.healthDisease').classList.add('on');
	
</script>	
</body>
</html>