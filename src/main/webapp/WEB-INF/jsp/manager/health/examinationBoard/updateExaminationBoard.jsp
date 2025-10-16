<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<meta charset="UTF-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>(관리자) 검사 게시글 UPDATE </title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/minseo_css/default.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/top-right.css" />
	<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/design.js"></script>
	
<style>
		
	#selectedImage {
		border: none;
	    outline: none;
	    border: 1px solid #DDDDDD;
	    width: 300px;
	    height: 270px;
	    box-sizing: border-box;
	    font-size: 16px;
	    font-weight: 400;
	    text-align: center;
	    padding-left: 0;
	    margin-top: 10px;
	    margin-bottom: 20px;
	    
	    display: flex;
		justify-content: center; /* 수평 중앙 */
		align-items: center;     /* 수직 중앙 */
	    
	}
	
	#selectedImage img {
	 width: 100%;
   	 height: 100%;
   	 /* object-fit: cover; 다 차지만 조금 잘림 */
   	 object-fit: contain; /*약간 남아도 비율 맞게 최대한 채워짐*/
	}
	
	.card {
		border:	1px solid #DDDDDD;
		border-radius: 0;
		transition: none;
		width: 500px;
	}
	#resetBtn {
	background-color: #D5D5D5;
	border-color: #D5D5D5;
	border-radius: 0;
	align-self: flex-end;
	display: block;
	margin-left: auto;
}
</style>
</head>
<body>
<div class="body_wrap">
		<!-- 사이드바 -->
		<%@ include file="WEB-INF/../../../../common/sidebar.jspf"%>
		<div class="content">
			<div class="top_bar bg_w">
				<a href="#" class="top_left doctor_con"><span>검사 게시글 수정</span></a>	
				<!-- 탑바 right 컨텐츠-->
				<%@ include file="WEB-INF/../../../../common/topbarContent.jspf"%>
			</div>
			<div class="con_wrap bg_13">
				<!-- content시작 -->
				<form action="updateExaminationBoard" id="examinationBoardUpdateForm" method="post" enctype="multipart/form-data">
					<div class="doctor">
						<div class="doc_left bg_w">
							<div class="doc_con">
								<p class="f_s17 f_w500">신체 분류</p>
								<select name="bodyPartId" id="selectBox-body" required>
									<c:forEach var="body" items="${bodyClassificationList}">
										<option value="${body.bodyPartId }"
											<c:if test="${body.bodyPartId eq dto.bodyPartId }">
												selected
											</c:if>	
										>
											${body.bodyPartName }	
										</option>
									</c:forEach>
								</select>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">검사, 치료 명칭</p>
								<input type="text" placeholder="질환의 한글 명칭을 입력해주세요." id="title_korean" value="${dto.examinationName }" name="examinationName">
							</div>
						</div>
						<div class="doc_right bg_w">
							<div class="doc_con">
								<p class="f_s17 f_w500">썸네일 이미지</p>
								<div class="mb-3">
									<div id="selectedImage">
										<c:if test="${dto.filePath != null}">
											<img src="${pageContext.request.contextPath }${dto.filePath }" data-img-flag="${dto.fileOne }">
										</c:if>
										<c:if test="${dto.filePath eq null}">
											<img src="${pageContext.request.contextPath }/resources/images/no_image.jpg" data-img-flag="0">
										</c:if>
									</div>
									<p class="d-inline-flex gap-1">
									  <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample" style="background-color: #436DFF; border-color: #436DFF; border-radius: 0;">
									    	사진 수정
									  </button>
 									  <!-- <input class="btn btn-primary" type="reset" value="사진 삭제" id="deleteImgBtn" style="background-color: #D5D5D5; border-color: #D5D5D5; border-radius: 0;"> -->
									</p>
									<div class="collapse" id="collapseExample">
									  <div class="card card-body">
									    <input class="form-control" type="file" name="uploadFile" id="fileUploadTag"><br>
									 	<span>업로드 가능한 파일 유형 : 사진</span><br>
										<span>최대 파일 개수 : 1개</span>
									  </div>
									</div>
						
								</div>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">내용</p>
								<textarea name="content" id="contentInput" placeholder="검사 및 치료에 대한 내용을 입력해주세요.">
									${dto.content}
								</textarea>
							</div>
							<input class="btn btn-primary" type="reset" value="초기화" id="resetBtn">
						</div>
					</div>
						<div class="doc_bottom f_s16 f_w600">
							<input type="hidden" name="examinationId" value="${dto.examinationId }">
							<input type="hidden" name="fileDelete" value="false">
							
							<a href="#" class="bg_2" id="submitBtn">수정하기</a>
							<a href="#" id="goBack">목록으로</a>
						</div>
					</form>
				</div>
			<div class="footer bg_13 f_s15">2023 Hanyang University Medical Center All right Reserved.</div>
		</div>
	</div>


	

<c:if test="${result == 1}">
	<script>
		alert("질환 게시글 수정이 완료되었습니다. 게시글 목록 페이지로 이동합니다.");
		location.href="examinationBoardManagePage";
	</script>
</c:if>
<c:if test="${result == -1}">
	<script>
		alert("질환 게시글 수정 중 문제가 발생했습니다. 담당부서로 연락주세요.(tel.1234-1234)");
		location.href="examinationBoardManagePage";
	</script>
</c:if>

<script>

	//기존 파일 삭제 
	/*
	document.getElementById('deleteImgBtn').addEventListener('click', e => {
		e.preventDefault();
		if(confirm('기존 첨부 사진을 삭제하시겠습니까?')) {
			let deleteImg  = "<img src='${pageContext.request.contextPath }/resources/images/no_image.jpg' data-img-flag='0'>";
			document.querySelector('input[name="fileDelete"]').value = "true";
			$('#selectedImage').html(deleteImg);
		} else {
			return;
		}
	});
	*/
	
	//뒤로가기 버튼
	document.getElementById('goBack').addEventListener('click', e => {
		e.preventDefault();
		location.href="examinationBoardManagePage";
	});
	
	
	//내용 초기화
	document.getElementById('resetBtn').addEventListener('click', e => {
		e.preventDefault();
		location.href="";
	});

	var submitBtn = document.getElementById('submitBtn');
	submitBtn.addEventListener('click', function(event) {
		event.preventDefault();
		var form = document.getElementById("examinationBoardUpdateForm");
		
		//신체 분류값 검증
		let selectedBodyPartId = $("#selectBox-body option:selected").val();
		console.log("selectBox 선택 신체 ID : " + selectedBodyPartId);
		if(selectedBodyPartId == -1) {
			alert("신체 분류를 선택해주세요.");
			return;
		}
		
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
		
		//1) 첨부 파일 가져오기
		var attachedFiles = document.getElementById("fileUploadTag").files;
		console.log("새롭게 첨부된 파일 : " + attachedFiles);
		
		//2) 기존 첨부된 이미지 있는지 없는지 확인
		let selectedImageDiv = document.getElementById('selectedImage');
		let imgFlag = selectedImageDiv.querySelector('img').dataset.imgFlag;
		console.log("기존 첨부 있는지 없는지 확인 : " + imgFlag); //첨부된 이미지 있으면 != 0, 이미지 없으면 0
		
		//3) 로직 분기
		if(imgFlag != 0) { 
			if(attachedFiles && attachedFiles.length > 0) { 
				console.log("기존 사진 O, 새로운 사진 첨부O"); //새롭게 첨부된 사진 보내면 됌
			} else {
				console.log("기존 사진 O, 새로운 사진 첨부X"); //서버에서 update시 파일은 안 건들이면 됌
			}
		} else {
			if(attachedFiles && attachedFiles.length > 0) {
				console.log("기존 사진 X, 새로운 사진 첨부O"); //새롭게 첨부된 사진 보내면 됌
			} else {
				console.log("기존 사진 X, 새로운 사진 첨부X"); //서버에서 update시 파일은 안 건들이면 됌
			}
		}
		
		let isValid = true;
		for (const file of attachedFiles) {
			if (!validation(file)) {
				isValid = false;
				break;
			} 
		}
		
		//검증 후 제출
		if (isValid) {
			if(confirm("게시글을 수정하시겠습니까?")) {
				console.log("수정");
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