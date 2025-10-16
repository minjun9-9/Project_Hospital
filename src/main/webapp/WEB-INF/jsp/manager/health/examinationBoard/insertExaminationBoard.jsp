<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<meta charset="UTF-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>(관리자) 검사, 치료 게시글 INSERT </title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/minseo_css/default.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/top-right.css" />
	<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/design.js"></script>
<style>

.doc_center {
    padding: 30px 25%;
    box-sizing: border-box;
    display: flex; /* Flexbox 활성화 */
    flex-direction: column; /* 수직 정렬 */
    align-items: center; /* 자식 요소를 수평 중앙 정렬 */
    justify-content: center; /* 자식 요소를 수직 중앙 정렬 */
    width: 100%;
}

.doc_center .doc_con {
    margin-bottom: 20px; /* 각 컨테이너 간 간격 추가 */
    display: flex; /* 내부 요소 정렬을 위한 Flexbox */
    flex-direction: column; /* 내부 요소 수직 정렬 */
    align-items: stretch; /* 내부 요소를 부모의 전체 너비로 확장 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
    width: 100%; /* doc_con이 부모 너비를 차지 */
}


.doc_center .doc_con input,
.doc_center .doc_con select,
.doc_center .doc_con textarea {
    width: 100%; /* 입력 요소의 너비를 doc_con에 맞춤 */
    text-align: left; /* 입력된 텍스트 왼쪽 정렬 */
}

.doc_center .doc_con select{ /*선택박스 사이즈 조절*/
	width: 60%;
	background: url(${pageContext.request.contextPath }/resources/images/selectbox.png) no-repeat calc(100% - 10px) center; /* 오른쪽에서 약간 왼쪽으로 배치 */
}

#resetBtn {
	background-color: #D5D5D5;
	border-color: #D5D5D5;
	border-radius: 0;
	align-self: flex-end;
}


</style>
</head>
<body>
<div class="body_wrap">
		
<!-- 사이드바 -->
<%@ include file="WEB-INF/../../../../common/sidebar.jspf"%>
	
		<div class="content">
			<div class="top_bar bg_w">
				<a href="#" class="top_left doctor_con"><span>검사, 치료 게시글 등록</span></a>
				<!-- 탑바 right 컨텐츠-->
				<%@ include file="WEB-INF/../../../../common/topbarContent.jspf"%>
			</div>
			
			
			
			<div class="con_wrap bg_13">
				<!-- content시작 -->
				<form action="insertExaminationBoard" id="examinationBoardInsertForm" method="post" enctype="multipart/form-data">
					<div class="doctor">
						<div class="doc_center bg_w">
							<div class="doc_con">
								<p class="f_s17 f_w500">신체 분류</p>
								<select name="bodyPartId" id="selectBox-body" required>
									<option value="-1" selected disabled hidden="">신체 분류</option>
									<c:forEach var="body" items="${bodyClassificationList}">
										<option value="${body.bodyPartId }" >${body.bodyPartName}</option>
									</c:forEach>
								</select>
							</div>
							<div class="doc_con" id="nameBox">
								<p class="f_s17 f_w500">검사, 치료 명칭</p>
								<input type="text" placeholder="검사 혹은 치료의 명칭을 입력해주세요." id="examinationName" name="examinationName">
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">썸네일 이미지</p>
								<div class="mb-3">
								  <input class="form-control" type="file" name="uploadFile" id="fileUploadTag">
								  <br>
								  	<span>업로드 가능한 파일 유형 : 사진</span><br>
									<span>최대 파일 개수 : 1개</span>
								</div>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">내용</p>
								<textarea name="content" id="contentInput" placeholder="검사 및 치료에 대한 내용을 입력해주세요."></textarea>
							</div>
							<input class="btn btn-primary" type="reset" value="초기화" id="resetBtn">
						</div>
					</div>
						<div class="doc_bottom f_s16 f_w600">
							
							<a href="#" class="bg_2" id="submitBtn">등록하기</a>
							<a href="#" id="goBack">목록으로</a>
						</div>
					</form>
				</div>
			<div class="footer bg_13 f_s15">2023 Hanyang University Medical Center All right Reserved.</div>
		</div>
	</div>


	

<c:if test="${result == 1}">
	<script>
		alert("검사, 치료 게시글 등록이 완료되었습니다. 게시글 목록 페이지로 이동합니다.");
		location.href="examinationBoardManagePage";
	</script>
</c:if>
<c:if test="${result == -1}">
	<script>
		alert("검사, 치료 게시글 등록중 문제가 발생했습니다. 담당부서로 연락주세요.(tel.1234-1234)");
		location.href="examinationBoardManagePage";
	</script>
</c:if>

<script>
	//내용 초기화
	document.getElementById('resetBtn').addEventListener('click', e => {
		e.preventDefault();
		location.href="";
	});
	
	//뒤로가기
	document.getElementById('goBack').addEventListener('click', e => {
		e.preventDefault();
		location.href="examinationBoardManagePage"; 
	});

	var submitBtn = document.getElementById('submitBtn');
	submitBtn.addEventListener('click', function(event) {
		event.preventDefault();
		
		//신체 분류값 검증
		let selectedBodyPartId = $("#selectBox-body option:selected").val();
		console.log("selectBox 선택 신체 ID : " + selectedBodyPartId);
		if(selectedBodyPartId == -1) {
			alert("신체 분류를 선택해주세요.");
			return;
		}
		
		//검사, 치료 명칭값 검증
		let examinationName = document.getElementById('examinationName').value.trim();
		if(examinationName == "") {
			alert("검사, 치료 명칭을 입력하세요.");
			document.getElementById('examinationName').focus();
			return;
		}
		
		
		//내용값 검증
		let contentInput = document.getElementById('contentInput').value.trim();
		if (contentInput == "") {
			alert("내용을 입력하세요.");
			document.getElementById('contentInput').focus();
			return;
		}
		
		//업로드 파일 개수 제한
		var MaxFileCnt = 1; //첨부파일 최대 개수
		var attachedFileCnt = document.getElementById("fileUploadTag").files.length; //추가된 첨부파일 수 
		
		if (attachedFileCnt > 1)  {
			alert("첨부파일은 최대 " + MaxFileCnt + "개 까지 첨부할 수 있습니다.");
			return;
		}
		
		//첨부파일 검증
		var attachedFiles = document.getElementById("fileUploadTag").files;
		console.log(attachedFiles);
		let isValid = true;
		for (const file of attachedFiles) {
			if (!validation(file)) {
				isValid = false;
				break;
			} 
		}
		
		//검증 후 제출
		if (isValid) {
			if(confirm("게시글을 등록하시겠습니까?")) {
				console.log("제출");
				let form = document.getElementById("examinationBoardInsertForm");
				form.submit();
			} else {
				return;
			}
		}
		
	});
	
	//첨부파일 검증 메소드 validation(obj)
	function validation(obj) {
		const fileTypes = ['image/png', 'image/jpeg', 'image/bmp', 'image/tiff'];
		if (obj.size > 10000000) {
			alert("최대 파일 용량인 10MB를 초과한 파일은 업로드하실 수 없습니다.");
			console.log("Client uploaded file size :  ", obj.size);
			return false;
		} else if (obj.name.lastIndexOf('.') == -1) {
			alert("확장자가 없는 파일은 첨부하실 수 없습니다.");
			return false;
		} else if (!fileTypes.includes(obj.type)) {
			alert("첨부가 불가능한 유형의 파일을 선택하셨습니다.\n첨부 가능한 유형 : 사진파일");
			console.log("Client uploaded file type :  ", obj.type)
			return false;
		} else {
			return true;
		}
	}
	
	
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script>
	// 사이드바 토글 움직임
	document.querySelector('.healthul').classList.add('on');
	document.querySelector('.healthBoard').classList.add('on');
	
</script>
</body>
</html>