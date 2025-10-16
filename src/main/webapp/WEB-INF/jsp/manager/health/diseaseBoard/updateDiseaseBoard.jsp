ㅈ<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<meta charset="UTF-8">
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>(관리자) 질환 게시글 UPDATE </title>
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
}
</style>
</head>
<body>
<div class="body_wrap">
		<!-- 사이드바 -->
		<%@ include file="WEB-INF/../../../../common/sidebar.jspf"%>
		
		<!-- 컨텐츠  -->
		<div class="content">
			<div class="top_bar bg_w">
				<a href="#" class="top_left doctor_con"><span>질환 게시글 수정</span></a>					
				<!-- 탑바 right 컨텐츠-->
				<%@ include file="WEB-INF/../../../../common/topbarContent.jspf"%>
			</div>
			<div class="con_wrap bg_13">
				<!-- content시작 -->
				<form action="updateDiseaseBoard" id="diseaseBoardUpdateForm" method="post" enctype="multipart/form-data">
					<div class="doctor">
						<div class="doc_left bg_w">
							<div class="doc_con">
								<p class="f_s17 f_w500">질환 분류</p>
								<select name="diseasePartId" id="selectBox-disease" required>
									<c:forEach var="disease" items="${diseaseClassificationList}">
										<option value="${disease.diseasePartId}"
										    <c:if test="${disease.diseasePartId eq dto.diseasePartId}">
										        selected
										    </c:if>
										>
										    ${disease.diseasePartName}
										</option>
									</c:forEach>
								</select>
							</div>
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
								<p class="f_s17 f_w500">질환 한글 명칭</p>
								<input type="text" placeholder="질환의 한글 명칭을 입력해주세요." id="title_korean" value="${dto.koreanTitle }">
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">질환 영어 명칭</p>
								<input type="text" placeholder="질환의 영어 명칭을 입력해주세요." id="title_english" value="${dto.englishTitle }">
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
									</p>
									<div class="collapse" id="collapseExample">
									  <div class="card card-body">
									    <input class="form-control" type="file" name="uploadFile" id="fileUploadTag"><br>
									 	<span>업로드 가능한 파일 유형 : 사진</span><br>
										<span>최대 파일 개수 : 1개</span>
									  </div>
									</div>
									
								<!--  
								<button type="button" class="btn btn-primary" style="background-color: #436DFF; border-color: #436DFF; border-radius: 0;">사진 수정하기</button>
									<div hidden="">
									 <input class="form-control" type="file" name="uploadFile" id="fileUploadTag"><br>
									 	<span>업로드 가능한 파일 유형 : 사진</span><br>
										<span>최대 파일 개수 : 1개</span>
									</div>
								-->
								</div>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">내용</p>
								<textarea name="content" id="contentInput" placeholder="소제목과 내용 형식으로 작성 권장드립니다.&#13;&#10;*권장소제목: ~(이)란?, ~의 증상, ~의 원인, ~의 검사, ~의 치료 등등&#13;&#10;*소제목과 내용은 #으로 구분해주세요 : ex.)간암이란?#간암은...#간암의 증상#간암의 증산은..# (줄바꿈은 자유롭게 사용하셔도 됩니다.) ">
									${dto.content}
								</textarea>
							</div>
							<input class="btn btn-primary" type="reset" value="초기화" id="resetBtn">
						</div>
					</div>
						<div class="doc_bottom f_s16 f_w600">
							<input type="hidden" name="title" id="final_title">
							<input type="hidden" name="diseaseName" id="final_diseaseName">
							<input type="hidden" name="diseaseBoardId" value="${dto.diseaseBoardId }">
							
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
		alert("질환 게시글 수정이 완료되었습니다. 게시글 목록 페이지로 이동합니다.");
		location.href="diseaseBoardManagePage";
	</script>
</c:if>
<c:if test="${result == -1}">
	<script>
		alert("질환 게시글 수정 중 문제가 발생했습니다. 담당부서로 연락주세요.(tel.1234-1234)");
		location.href="diseaseBoardManagePage";
	</script>
</c:if>

<script>

	//내용 초기화
	document.getElementById('resetBtn').addEventListener('click', e => {
		e.preventDefault();
		location.href="";
	});
	
	//뒤로가기 버튼
	document.getElementById('goBack').addEventListener('click', e => {
		e.preventDefault();
		location.href="diseaseBoardManagePage";
	});


	var submitBtn = document.getElementById('submitBtn');
	submitBtn.addEventListener('click', function(event) {
		event.preventDefault();
		var form = document.getElementById("diseaseBoardUpdateForm");
		
		//질환 분류값 검증
		let selectedDiseasePartId = $("#selectBox-disease option:selected").val();
		console.log("selectBox 선택 질환 ID : " + selectedDiseasePartId);
		if(selectedDiseasePartId == -1) {
			alert("질환 분류를 선택해주세요.");
			return;
		}
		
		//신체 분류값 검증
		let selectedBodyPartId = $("#selectBox-body option:selected").val();
		console.log("selectBox 선택 신체 ID : " + selectedBodyPartId);
		if(selectedBodyPartId == -1) {
			alert("신체 분류를 선택해주세요.");
			return;
		}
		
		//한글 제목값 검증
		let title_korean = document.getElementById('title_korean').value.trim();
		if(title_korean == "") {
			alert("질환 한글 명칭을 입력하세요.");
			document.getElementById('title_korean').focus();
			return;
		}
		
		//영어 제목값 검증
		let title_english = document.getElementById('title_english').value.trim();
		if(title_english == "") {
			alert("질환 영어 명칭을 입력하세요.");
			document.getElementById('title_english').focus();
			return;
		}
		
		//질환 명칭 한, 영 조합해서 VO로 넘기기 
		let title_final = `\${title_korean} [\${title_english}]`;
		console.log(title_final);
		document.getElementById('final_title').value = title_final;
		document.getElementById('final_diseaseName').value = title_final;
		
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
		//이미 첨부한 파일 있고 '사진 수정' 안 누르고 그냥 등록하기 눌렀을 때> 기존 사진 사용 
		//이미 첨부한 파일 있고 '사진 수정' 누르고 첨부파일 첨부했을 떼 > 새로운 사진 사용
		//이미 첨부한 파일 있고 '사진 수정' 누르고 첨부파일 첨부 안 했을 떼 > > 기존 사진 사용
		//---> 그냥 첨부파일 첨부 안 했을 때 기존 사진 있으면 기존 꺼 사용, 시존 사진 없으면 없는 대로 업데이트
		
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