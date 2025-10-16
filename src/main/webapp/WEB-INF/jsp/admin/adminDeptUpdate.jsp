<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료과 수정</title>
<style>
	.resetBtn { 
		background-color: white; 
		border: none;
	}
	#fileText {
		width: 80%;
		height: 50px;
		min-width: 180px;
		max-width: none;
	}
	#uploadFileBtn {
		width: 19%;
		height: 50px;
		min-width: 60px;
	}
	.btnCSS {
		width: 25%;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis; 
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.btnCSS2 {
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis; 
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.deptImage {
		max-height: 130px;
		object-fit: contain;
	}
	.divBorder {
		overflow: hidden;
		overflow-y: auto;
		max-height: 700px;
		height: 100%; 
		width: 100%; 
    	box-sizing: border-box; 
	}
	.dupleCheck {
		font-size: 15px;
		color: gray;
	}
	.dupleCheckSuccess {
		color: green;
	}
	.dupleCheckFail {
		color: red;
	}
	.deptHeadTable {
		font-size: 15px;
	}
	.downImg {
		width: 10px;
		margin-left: 3px;
	}
	.dropdown-item {
		padding-top: 5px;
		padding-bottom: 5px;
		line-height: 1.2;
	}
	.dropdown-menu {
		height: 150px;
	    overflow: hidden;
	    overflow-y: auto;
    }
    .noDeptDrList {
    	height: 45px;
    	overflow: visible;
    }
</style>
<!-- 부트스트랩 링크  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<!-- 받은 파일 링크  -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/top-right.css" />
<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/design.js"></script>
<script>
	const contextPath = '/hospital';
	const regexKorean = /^[ㄱ-ㅎ|가-힣]+$/;
	
	window.addEventListener("load", function(){
		//파일 관련
		const uploadFileBtn = document.querySelector("#uploadFileBtn");
		const fileInput = document.querySelector("#fileInput");
		const fileText = document.querySelector("#fileText");
		const deptImage = document.querySelector("#deptImage");
		
		//수정페이지 오면 초기 해당 진료과 정보 세팅
		//진료과 ID 인풋 태그
		const deptIdInput = document.querySelector("#deptIdInput");
		//진료과 이름 인풋 태그
		const deptNameInput = document.querySelector("#deptNameInput");
		
		//진료과 관련정보 변수
		const deptId = '${deptInfo.deptId }';
		const beforeDeptName = '${deptInfo.deptName }';
		let deptHeadId = '${deptInfo.drId}';
		let beforeOriFileName = '${deptInfo.originalName }';
		let beforeOriFilestoreId = '${deptInfo.filestoreId }';
		let beforeOriFilePath = '${deptInfo.filePath }';
		
		//진료과 헤드 관련 정보
		const deptHeadName = '${deptHeadInfo.drName }';
		const deptHeadPosition = '${deptHeadInfo.drPosition }';
		const deptHeadFilePath = '${deptHeadInfo.filePath }';
		
		//파일 이미지 있는데 수정하지 않는경우  -> 스프링 멀티파트 데이터 null
		//파일 이미지 있는데 수정하는 경우  -> 스프링 멀티파트 데이터 not null
		
		//파일 이미지 없는데 새로 입력하지 않는 경우 -> 스프링 멀티파트 데이터 null 
		//파일 이미지 없는데 새로 입력하는 경우 -> 스프링 멀티파트 데이터 not null
		
		let isExistFile;
		isExistFile = OriFileCheck(beforeOriFilestoreId, isExistFile);
		let isDeleteFile = false;
		
		
		//진료과 의료진 리스트 가져오기
		const deptDrListLiTags = document.querySelectorAll(".deptDrList");
		const deptDrListIds = document.querySelectorAll(".deptDrListId");
		const deptHeadTd1 = document.querySelector("#deptHeadTd1");
		const deptHeadTd2 = document.querySelector("#deptHeadTd2");
		const deptHeadImage = document.querySelector("#deptHeadImage");
		for (let i = 0; i < deptDrListLiTags.length; i++) {
			deptDrListLiTags[i].addEventListener("click", () => {
				let deptDrId = deptDrListIds[i].value;
				const deptDrIdobj = {
					drId : deptDrId
				}
				
				fetch(contextPath + "/getOneDeptDrInfo", {
					method : "POST",
					headers : { "Content-Type" : "application/json" },
					body : JSON.stringify(deptDrIdobj)
				})
					.then(response => {
						if (!response.ok) {
							throw new Error("Ajax 에러 발생");
						}
						return response.json();
					})
					.then(data => {
						if (data) {
							let oneDrName = data.deptOneDrInfo.drName;
							let oneDrPosition = data.deptOneDrInfo.drPosition;
							let oneDrFilePath = data.deptOneDrInfo.filePath;
							
							
							deptHeadTd1.innerHTML = oneDrName;
							deptHeadTd2.innerHTML = oneDrPosition;
							
							if (oneDrFilePath) {
								deptHeadImage.setAttribute("src", contextPath + oneDrFilePath);
							} else {
								deptHeadImage.setAttribute("src", contextPath + "/resources/images/photo.png");
							}
							
							deptHeadId = data.deptOneDrInfo.drId;
						} else {
							alert("데이터 없음");
						}
					})
					.catch(error => {
						alert(error);
					})
				
			});
		}
		//진료과장 리셋 버튼 이벤트 처리
		const deptHeadResetBtn = document.querySelector("#deptHeadResetBtn");
		deptHeadResetBtn.addEventListener("click", () => {
			if (deptHeadName) {
				deptHeadTd1.innerHTML = deptHeadName;
				deptHeadTd2.innerHTML = deptHeadPosition;
			} else {
				deptHeadTd1.innerHTML = "진료과장 없음";
				deptHeadTd2.innerHTML = "";
			}
			if (deptHeadFilePath) {
				deptHeadImage.setAttribute("src", contextPath + deptHeadFilePath);
			} else {
				deptHeadImage.setAttribute("src", contextPath + "/resources/images/photo.png");
			}
			
		});
		
		
		const formData = new FormData();
		//파일 선택 이벤트
		uploadFileBtn.addEventListener("click", () => {
			fileInput.click();
		});
		
		
		fileInput.addEventListener("change", () => {
			let files = fileInput.files;
			let file =files[0];
			
			let dotIndex;
			if (file) {
				dotIndex = file.name.lastIndexOf(".");
				if (file.name.slice(dotIndex) !== '.jpg' && file.name.slice(dotIndex) !== '.jpeg' && 
						file.name.slice(dotIndex) !== '.png' && file.name.slice(dotIndex) !== '.gif') {
					alert("4가지 이미지 파일만 첨부 가능합니다(가능한 확장자 : jpg, jpeg, png, gif)");
					text = '';
					fileText.value = '';
					fileInput.value = '';
					files = null;
					file = null;
					return false;
				}
				const fileURL = URL.createObjectURL(file);
				
				deptImage.setAttribute("src", fileURL);
				
				let text = file.name;
				fileText.value = text;
				
				formData.append('deptImage', file);
				if (isExistFile) isDeleteFile = false;
				
			}
			
			
		});
		
		//파일 비우기 버튼 이벤트
		const fileResetBtn = document.querySelector("#fileResetBtn");
		fileResetBtn.addEventListener("click", () => {
			deptImage.setAttribute("src", contextPath + "/resources/images/file_image.png");
			text = '';
			fileText.value = '';
			fileInput.value = '';
			files = null;
			file = null;
			formData.delete('deptImage');
			if (isExistFile) isDeleteFile = true;
		});
		
		
		//수정 버튼 이벤트 처리
		const registerBtn = document.querySelector("#register");
		registerBtn.addEventListener("click", () => {
			//진료과 이름 값 체크
			let deptNameInputValue = deptNameInput.value.trim();
			if (deptNameInputValue === "") {
				alert("진료과 이름은 필수 입력 사항입니다"); 
				deptNameInput.focus();
				return false;
			}
			if (!regexKorean.test(deptNameInputValue)) {
				alert("진료과 이름은 한글만 입력 가능합니다"); 
				deptNameInput.value = "";
				deptNameInput.focus();
				return false;
			}
			if (isDeleteFile) {
				if (!confirm("기존 파일이 삭제처리 하시겠습니까?")) {
					return false;
				}
				
			}
			
			//진료과ID, 진료과이름, 기존파일여부, 파일데이터(formData에 넣어 서버로 보내면됨), 추가로 진료과 헤드 변경여부
			const deptInfoObj = {
				deptId : deptId,
				deptName : deptNameInputValue,
				isExistFile : isExistFile,
				isDeleteFile : isDeleteFile,
				deptHeadId : deptHeadId
			}
			
			formData.append("deptUpdateInfo", JSON.stringify(deptInfoObj));
			
			fetch(contextPath + "/deptUpdate", {
				method : "POST",
				body : formData
			})
				.then(response => {
					if (!response.ok) {
						throw new Error("[deptUpdate] Ajax 요청 에러발생" + response.statusText);
					}
					return response.json();
				})
				.then(message => {
					alert(message.msg);
					if (message.result === 'success') {
						//진료과 수정되면 페이지 새로고침해서 초기화
						location.reload(true);
					}
				})
				.catch(error => {
					alert(error);
				})
			
		}); 
		
		
	});
	
function goMain() {
	location.href = "adminMain";
}
//기존 파일 존재여부 확인 함수
function OriFileCheck(fileInfo, isExistFile) {
	if (fileInfo) {
		//기존 파일이 있는 경우
		isExistFile = true;
	} else {
		//기존 파일이 없는 경우
		isExistFile = false;
	}
		return isExistFile;
}
</script>
</head>
<body>

<div id="content" class="body_wrap">
	<!-- 사이드바 -->
	<%@ include file="WEB-INF/../../common/sidebar.jspf"%>
	<!-- 컨텐츠 시작 -->
	<div class="content">
		<div class="top_bar bg_w">
			<a href="#" class="top_left doctor_con"><span>진료과 관리</span></a>
			<!-- 탑바 컨텐츠 -->
			<%@ include file="WEB-INF/../../common/topbarContent.jspf"%>
		</div>
	<div class="con_wrap bg_13">
		<!-- main content시작 -->
		<div class="dummy">
		
			<div class="container" style="padding-top: 70px; width: 35%; height: 100vh; min-width: 300px;">
				
				<div class="border border-3 rounded py-5 shadow divBorder">
					<div class="text-start text-center">
				    	<span class="subtit f_s20 f_w700">진료과 수정</span>
				  	</div>
				  	
				  	<!-- 진료과장 정보 -->
				  	<div class="doc_con ms-4 mb-4" style="margin-top: 60px; width: 90%; height: 60px;">
					  	<div class="row">
					  		<!-- 진료과장 이미지 -->
					  		<div class="col-md-4 d-flex justify-content-center align-items-center">
					  		  <c:if test="${not empty deptHeadInfo }">
					  		  	  <c:choose>
					  		  	  	<c:when test="${not empty deptHeadInfo.filePath }">
								      <img src="${pageContext.request.contextPath}${deptHeadInfo.filePath }" 
								      		id="deptHeadImage" alt="deptHeadImage" style="height: 110px;">
							      	</c:when>
							      	<c:when test="${empty deptHeadInfo.filePath }">
								      <img src="${pageContext.request.contextPath}/resources/images/photo.png" 
								      		id="deptHeadImage" alt="deptHeadImage" style="height: 110px;">
							      	</c:when>
							      </c:choose>
						      </c:if>
					  		  <c:if test="${empty deptHeadInfo }">
						      <img src="${pageContext.request.contextPath}/resources/images/photo.png" 
						      		id="deptHeadImage" alt="deptHeadImage" style="height: 110px;">
						      </c:if>
						    </div>
					  		<div class="col-md-8">
						        <div id="deptIdDiv" class="d-flex justify-content-between align-items-center">
								  <p class="f_s17 f_w500 mb-3 m-0">진료과장
								  	<button type="button" id="deptHeadResetBtn" class="ms-2 resetBtn">
						        		<img src="${pageContext.request.contextPath }/resources/images/reset.png">
						        	</button>
								  </p>
								  <div class="btn-group btn-success" style="height: 25px; line-height: 5.0; display: flex; align-items: center; margin-bottom: 15px;">
									  <button class="btn btn-success btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
									   	 변경
									  </button>
									  <c:if test="${not empty deptDrInfoList }">
									   <ul class="dropdown-menu">
									  	<c:forEach var="deptDrInfo" items="${deptDrInfoList }">
									    	<li class="dropdown-item deptDrList">
									    	<table>
									    		<colgroup>
													<col width="90px">
													<col width="50px">
												</colgroup>
									    		<tr>
									    			<td class="me-2">${deptDrInfo.drName }</td>
									    			<td>(${deptDrInfo.drPosition })</td>
									    		</tr>
									    	</table>
									    	</li>
									    	<input type="hidden" class="deptDrListId" value="${deptDrInfo.drId }">
									    </c:forEach>
									   </ul>
									  </c:if>
									  <c:if test="${empty deptDrInfoList }">
									    <ul class="dropdown-menu noDeptDrList">
									    	<li class="dropdown-item deptDrList">
									    	<table>
									    		<colgroup>
													<col width="90px">
												</colgroup>
									    		<tr>
									    			<td colspan="2" class="me-2">의료진 없음</td>
									    		</tr>
									    	</table>
									    	</li>
									    </ul>
									  </c:if>
								  </div>
								  
								</div>
								<div class="d-flex align-items-center position-relative">
									<table class="table deptHeadTable">
						          		<colgroup>
											<col width="55px">
											<col width="55px">
										</colgroup>
										<tbody id="deptHeadTableBody">
											<tr>
												<th>이름</th>
												<c:if test="${not empty deptHeadInfo }">
												<td id="deptHeadTd1">${deptHeadInfo.drName }</td>
												<%-- <input type="hidden" id="hiddendeptHeadId" value="${deptHeadInfo.drId }"> --%>
												</c:if>
												<c:if test="${empty deptHeadInfo }">
												<td id="deptHeadTd1">진료과장 없음</td>
												<%-- <input type="hidden" id="hiddendeptHeadId" value="${deptHeadInfo.drId }"> --%>
												</c:if>
											</tr>
											<tr>
												<th>직책</th>
												<c:if test="${not empty deptHeadInfo }">
												<td id="deptHeadTd2">${deptHeadInfo.drPosition }</td>
												</c:if>
												<c:if test="${empty deptHeadInfo }">
												<td id="deptHeadTd2">&nbsp;</td>
												</c:if>
											</tr>
										</tbody>
					          		</table>
								</div>
						      </div>
						</div>
				  	</div>
				  	
				  	<!-- 파일 설정 -->
				  	<div class="doc_con ms-4 mb-4" style="margin-top: 90px; width: 90%;">
					  	<div class="row">
					  		<div class="col-md-4 d-flex justify-content-center align-items-center">
					  		  <c:if test="${not empty deptInfo.filePath }">
						      <img src="${pageContext.request.contextPath}${deptInfo.filePath }" 
						      		id="deptImage" alt="deptImage" style="height: 117px;">
						      </c:if>
					  		  <c:if test="${empty deptInfo.filePath }">
						      <img src="${pageContext.request.contextPath}/resources/images/file_image.png" 
						      		id="deptImage" alt="deptImage" style="height: 117px;">
						      </c:if>
						    </div>
					  		<div class="col-md-8">
						        <p class="f_s17 f_w500">진료과 이미지
						        	<button type="button" id="fileResetBtn" class="ms-2 resetBtn">
						        		<img src="${pageContext.request.contextPath }/resources/images/reset.png">
						        	</button>
						        </p>
								<div class="d-flex align-items-center position-relative">
									<!-- 숨겨진 파일 입력 필드 -->
									<input type="file" id="fileInput" name="ImgFile" class="form-control-file" style="display: none;"/>
									<c:if test="${not empty deptInfo.originalName }">
									<input type="text" id="fileText" name="fileText" class="form-control flex-grow-1" 
											placeholder="파일을 선택해 주세요" readonly value="${deptInfo.originalName }">
									</c:if>
									<c:if test="${empty deptInfo.originalName }">
									<input type="text" id="fileText" name="fileText" class="form-control flex-grow-1" 
											placeholder="파일을 선택해 주세요" readonly>
									</c:if>
									<span style="width: 1%; text-align: center;"> </span><!-- 공백 일부러  -->
									<button type="button" id="uploadFileBtn" class="btn btn-secondary text-nowrap btnCSS">파일</button>
								</div>
						      </div>
						</div>
				  	</div>
				  	
					<div class="doc_con ms-4 mb-5" style="width: 90%;">
					    <p class="f_s17 f_w500 mb-3 m-0">진료과 ID*<span id="dupleSpan" class="ms-3 dupleCheck">진료과 ID 수정 불가</span></p>
						<div class="d-flex align-items-center">
							<input type="text" id="deptIdInput" name="deptId" class="form-control flex-grow-1" placeholder="진료과 ID" disabled
								value="${deptInfo.deptId }">
						</div>
					</div>
					<div class="doc_con ms-4" style="margin-bottom: 80px; width: 90%;">
						  <p class="f_s17 f_w500 mb-3 m-0">진료과 이름*</p>
						<div class="d-flex align-items-center">
							<input type="text" id="deptNameInput" name="deptName" class="form-control flex-grow-1" placeholder="진료과 이름을 입력하세요"
								value="${deptInfo.deptName }">
						</div>
					</div>
					
					<div class="doc_bottom f_s16 f_w600">
						<button type="button" id="register" class="btn btn-primary btn-lg text-nowrap btnCSS">수정하기</button>
						<button type="button" class="btn btn-dark btn-lg text-nowrap btnCSS" onclick="goMain()">메인으로</button>
					</div>
					
				</div>
			</div>
		</div>
			<div class="footer bg_13 f_s15">2025 ITWILL Medical Center All right Reserved.</div>
		</div>
		<!-- 컨텐츠 끝  -->
	</div>
</div>












<!-- 부트스트랩 링크  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
	// 사이드바 토글 움직임
	document.querySelector('.deptul').classList.add('on');
	document.querySelector('.deptliCare').classList.add('on');
	
</script>
</body>
</html>