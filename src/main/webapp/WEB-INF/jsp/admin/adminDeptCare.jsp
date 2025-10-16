<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료과 관리</title>
<style>
	.deptHeadTable {
		font-size: 15px;
	}
	.deptHeadTable th, .deptHeadTable td,
	.deptDoctorsTable th, .deptDoctorsTable td { 
		padding-bottom: 20px;	
		
	}
	.deptDoctorsTable th, .deptDoctorsTable td {
		padding: 0.3rem; /* 셀 내부 여백 줄이기 */
    	vertical-align: middle; /* 내용 세로 정렬 */
	}
	.deptDoctorsTable button {
	    height: 20px; /* 버튼 높이 */
	    padding: 0 0.5rem; /* 버튼 내부 좌우 여백 */
	    font-size: 0.8rem; /* 버튼 글씨 크기 */
	}
	#searchResults {
	    z-index: 1000;
	    max-height: 200px;
	    overflow-y: auto;
	    background-color: white;
	    border: 1px solid #ddd;
	    border-top: none;
	    border-radius: 0 0 4px 4px;
	    margin-left: 0;
   	    margin-right: auto;
	}
	#searchResults li {
	    padding: 10px;
	    cursor: pointer;
	    font-size: 15px;
	}
	#searchResults li:hover {
	    background-color: #f8f9fa;
	}
	#searchInput {
	    border-bottom-right-radius: 0;
	}
	#searchResults {
	    border-top-right-radius: 0;
	}
	.resetImg {
		width: 10%;
		height: inherit;
	}
	.resetImg:hover {
		cursor: pointer;
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
	let contextPath = '/hospital';
	
	window.addEventListener("load", function(){
		const resetImg = document.querySelector(".resetImg");
		resetImg.addEventListener("click", () => {
			location.reload(true);
		}); 
		
		const searchInput = document.querySelector("#searchInput");
		
		//검색어 입력 이벤트 처리
		searchInput.addEventListener("keyup", () => {
			let query = searchInput.value.trim();
			
			if (query) {
			fetch(contextPath + "/searchDeptIdName?query=" + query, {
				method : "GET"
			})
				.then(response => {
					if (!response.ok) {
						throw new Error("Ajax 에러 발생");
					}
					return response.json();
				})
				.then(dataList => {
					searchResults.innerHTML = "";
					 if (dataList.length > 0) {
						 searchResults.classList.remove("d-none");
						 for (let data of dataList) {
							 let li = document.createElement("li");
							 li.textContent = data.deptName;
							 //li.dataset.value = data.deptId;
							 searchResults.appendChild(li);
						 }
					 } else {
						 searchResults.classList.add("d-none");
					 }
				})
				.catch(error => {
					alert(error);
				})
			} else {
				searchResults.classList.add("d-none");
			}
			
		});
		
		// 이벤트 위임: 검색 결과 클릭 처리
		//let selectedDeptId = null;
	    searchResults.addEventListener("click", (event) => {
	    	if (event.target.tagName === "LI") {
	    		const selectedDeptName = event.target.textContent;
	    		//selectedDeptId = event.target.dataset.value;
	    		searchInput.value = selectedDeptName;
	    		searchResults.classList.add("d-none");
	    	}
	    });
	    
	    //검색 버튼 클릭시 서버로 데이터 요청
	    const searchBtn = document.querySelector("#searchBtn");
	    const searchResultDiv = document.querySelector("#searchResultDiv");
	    searchBtn.addEventListener("click", () => {
	    	getSearchDept();
	    	
	    });
	    
	    //input태그에서 엔터 누를시 서버로 데이터 요청
	    searchInput.addEventListener("keydown", (event) => {
	    	if (event.key === "Enter") {
	    		getSearchDept();
	    	}
	    });
	    
	    //이벤트 위침
	    searchResultDiv.addEventListener("click", (event) => {
	        if (event.target.classList.contains("modalBtns")) {
	            const modal = document.querySelector("#exampleModal"); //모달요소
	    		const content = document.querySelector("#content"); //모달외부요소
	    		const bootstrapModal = new bootstrap.Modal(modal); // Bootstrap 모달 인스턴스
	    		
	    		// 모달 닫기
	    		const modalCloseBtns = document.querySelectorAll(".modalClose");
	    		for (let modalCloseBtn of modalCloseBtns) {
	    		    modalCloseBtn.addEventListener("click", () => {
	    		    	bootstrapModal.hide(); 
	    			});
	    		}
	    		
	    		modal.addEventListener("hidden.bs.modal", () => {
	    			content.removeAttribute("inert"); // 모달 외부 콘텐츠 활성화
	    		});
	    		
	            const cardBody = event.target.closest(".card-body");
	            if (cardBody) {
	            	const deptHeadId = cardBody.querySelector(".hiddenDeptHeadId").value;
	                const deptId = cardBody.querySelector(".hiddenDeptId").value;
	                const deptName = cardBody.querySelector(".hiddenDeptName").value;
	                
	                const deptObj = {
    					deptHeadId : deptHeadId,
    					deptId : deptId
    				}
	                
	                fetch(contextPath + "/getDeptDrInfo", {
						method : "POST",
						headers : { "Content-Type" : "application/json" },
						body : JSON.stringify(deptObj)
					})
						.then(response => {
							if (!response.ok) {
								throw new Error("[modalBtn] Ajax 요청 에러발생" + response.statusText);
							}
							return response.json();
						})
						.then(dataList => {
							const modalTitle = document.querySelector("#modalTitle");
							const deptHeadImg = document.querySelector("#deptHeadImg");
							const deptHeaderTitle = document.querySelector("#deptHeaderTitle");
							const deptTitle = document.querySelector("#deptTitle");
							const deptHeadTableBodyTd1 = document.querySelector("#deptHeadTableBody tr:nth-child(1) td");
							const deptHeadTableBodyTd2 = document.querySelector("#deptHeadTableBody tr:nth-child(2) td");
							const deptDrTableBody = document.querySelector("#deptDrTableBody");
							const deptHeadATag = document.querySelector("#deptHeadATag");
							
							modalTitle.innerHTML = deptName + " 상세";
							deptHeaderTitle.innerHTML = deptName + "장";
							deptTitle.innerHTML = deptName + " 의료진";
							
							let deptDrTableHtml = "";
							let doctorCnt = 0;
							if (dataList){ //진료과에 의료진이 있는지 없는지 판별(아직 판별할 수 없기때문에 문제 생길시 여기 수정해야함)
								for (let i = 0; i < dataList.length; i++) {
									if (dataList[i].drId !== deptHeadId) {
										doctorCnt++;
									}
								}
							
								for (let data of dataList) {
									//진료과장에 대한 데이터
									if (data.drId === deptHeadId && data.filePath != null) {
										setTimeout(() => {
											  deptHeadImg.setAttribute("src", contextPath + data.filePath);
											}, 0);
									} else {
										deptHeadImg.setAttribute("src", contextPath + "/resources/images/photo.png");
									}
									if (data.drId === deptHeadId) {
										setTimeout(() => {
										  deptHeadTableBodyTd1.innerHTML = data.drName;
										  deptHeadTableBodyTd2.innerHTML = data.drPosition;
										}, 0);
										deptHeadATag.setAttribute("href", contextPath + "/doctor/doctorInfoUpdate?drId=" + data.drId);
										
									} else {
										deptHeadTableBodyTd1.innerHTML = "진료과장 없음";
										deptHeadTableBodyTd2.innerHTML = "";
										deptHeadATag.setAttribute("disabled", "disabled");
									}
									
									//진료과 의료진 리스트에 데이터 삽입
									if (doctorCnt > 0) {
										if (data.drId === deptHeadId) continue;
										deptDrTableHtml += "<tr>";
										deptDrTableHtml += "<td>" + data.drName + "</td>";
										deptDrTableHtml += "<td>" + data.drPosition + "</td>";
										deptDrTableHtml += "<td>";
										deptDrTableHtml += "<a href='" + contextPath + "/doctor/doctorInfoUpdate?drId=" + data.drId + "'>";
										deptDrTableHtml += "<img alt='img' src='${pageContext.request.contextPath}/resources/images/pencil.png'>";
										deptDrTableHtml += "</a>";
										deptDrTableHtml += "</td>";
										deptDrTableHtml += "</tr>";
									} else {
										deptDrTableHtml += "<tr>";
										deptDrTableHtml += "<td colspan='3'>의료진 없음</td>";
										deptDrTableHtml += "</tr>";
									}
									if (data.drId === "empty") {
										deptDrTableHtml = "<tr>";
										deptDrTableHtml += "<td colspan='3'>의료진 없음</td>";
										deptDrTableHtml += "</tr>";
									}
								}
								deptDrTableBody.innerHTML = deptDrTableHtml;
								
								//hidden input에 진료과 ID 값 넣기
								document.querySelector("#deptIdHidden").value = deptId;
							} else {
								console.log("의료진이 없습니다");
							}
							
						})
						.catch(error => {
							alert(error);
						})
						
						content.setAttribute("inert", "");
						bootstrapModal.show();
	            }
	        }
	    });
	    
	  	//---------------
		//진료과 삭제 버튼
		const deptDeleteBtn = document.querySelector("#deptDelete");
		deptDeleteBtn.addEventListener("click", () => {
			if (!confirm("정말 삭제 하시겠습니까?")) {
				return false;
			} else {
				//삭제하기 yes를 했을때 처리할 로직 작성
				const deptId = document.querySelector("#deptIdHidden").value;
				location.href = "deletedeptInfo?deptId=" + deptId;
			}
		});
		//진료과 수정 버튼
		const updateDeptInfoBtn = document.querySelector("#updateDeptInfo");
		updateDeptInfoBtn.addEventListener("click", () => {
			const deptId = document.querySelector("#deptIdHidden").value;
			location.href = "deptInfoUpdate?deptId=" + deptId;
		});
	    
		//외부 입력시 검색창 숨기기
	    document.addEventListener("click", (event) => {
	        if (!searchResults.contains(event.target) && event.target !== searchInput) {
	            searchResults.classList.add("d-none");
	        }
	    });
	});
	
	window.addEventListener("load", function(){
		const deptRegister = document.querySelector("#deptRegister");
		deptRegister.addEventListener("click", () => {
			location.href = contextPath + "/admin/adminDeptRegister";
		});
	});
function getSearchDept() {
	const searchInputValue = searchInput.value.trim();
	if (searchInputValue) {
		//여기서 서버로 데이터 요청하면 된다
		fetch(contextPath + "/seachDeptByName?query=" + searchInputValue, {
			method : "GET"
		})
			.then(response => {
				if (!response.ok) {
					throw new Error("Ajax 에러 발생");
				}
				return response.json();
			})
			.then(dataList => {
				if (!dataList.length == 0) {
    				searchResultDiv.innerHTML = "";
    				
    				const rowDiv = document.createElement("div");
    				rowDiv.className = "row";
    				
    				for (let data of dataList) {
    					const colDiv = document.createElement("div");
    	                colDiv.className = "col-md-4";
    	                
    	                const cardDiv = document.createElement("div");
    	                cardDiv.className = "card mb-3";
    	                cardDiv.style.width = "100%";
    	                cardDiv.style.height = "300px";
    	                cardDiv.style.overflow = "hidden";
    	                
    	                const img = document.createElement("img");
    	                img.className = "img-fluid rounded-start";
    	                img.alt = "image";
    	                img.style.width = "100%";
    	                img.style.height = "70%";
    	                img.src = data.filePath 
                        ? `\${contextPath}\${data.filePath}` 
                        : `\${contextPath}/resources/images/question_image.png`;
                        
    	                const cardBody = document.createElement("div");
    	                cardBody.className = "card-body";
    	                cardBody.style.height = "50%";
    	                cardBody.style.display = "flex";
    	                cardBody.style.flexDirection = "column";
    	                cardBody.style.justifyContent = "space-between";
    	                
    	                const cardTitle = document.createElement("h5");
    	                cardTitle.className = "card-title text-center";
    	                cardTitle.style.fontSize = "23px";
    	                cardTitle.style.fontWeight = "bold";
    	                cardTitle.style.whiteSpace = "nowrap";
    	                cardTitle.style.overflow = "hidden";
    	                cardTitle.style.textOverflow = "ellipsis";
    	                cardTitle.textContent = data.deptName;
    	                
    	                const hiddenDeptHeadId = document.createElement("input");
    	                hiddenDeptHeadId.type = "hidden";
    	                hiddenDeptHeadId.className = "hiddenDeptHeadId";
    	                hiddenDeptHeadId.value = data.drId;
    	                
    	                const hiddenDeptId = document.createElement("input");
    	                hiddenDeptId.type = "hidden";
    	                hiddenDeptId.className = "hiddenDeptId";
    	                hiddenDeptId.value = data.deptId;

    	                const hiddenDeptName = document.createElement("input");
    	                hiddenDeptName.type = "hidden";
    	                hiddenDeptName.className = "hiddenDeptName";
    	                hiddenDeptName.value = data.deptName;
    	                
    	                const button = document.createElement("button");
    	                button.type = "button";
    	                button.className = "btn btn-primary btn-sm modalBtns";
    	                button.textContent = "상세보기";
    	                
    	                cardBody.appendChild(cardTitle);
    	                cardBody.appendChild(hiddenDeptHeadId);
    	                cardBody.appendChild(hiddenDeptId);
    	                cardBody.appendChild(hiddenDeptName);
    	                cardBody.appendChild(button);

    	                cardDiv.appendChild(img);
    	                cardDiv.appendChild(cardBody);
    	                colDiv.appendChild(cardDiv);
    	                rowDiv.appendChild(colDiv);
    				}
    				
    				searchResultDiv.appendChild(rowDiv);
    				
    				searchInput.value = "";
    				
    				searchInput.value = "";
				    searchResults.classList.add("d-none");
				} else {
					searchResults.classList.add("d-none");
					alert("검색 결과가 없습니다");
					return;
				}
			})
			.catch(error => {
				alert(error);
			})
		
	}
}
</script>
</head>
<body>
<!-- 부트스트랩 modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title" id="modalTitle" style="font-size: 18px;">진료과 상세</h3>
        <button type="button" id="modalClose" class="btn-close modalClose" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      	<div class="container-fluid" style="width: 85%; height: 300px;">
	      	<!-- 진료과장 데이터  -->
	      	<div class="text-center mb-2" id="deptHeaderTitle" style="font-size: 18px;">진료과장</div>
	      	
	      	<div class="card mb-3" style="max-width: 540px; height: 50%;">
			  <div class="row g-0" style="height: 100%;">
			    <div class="col-md-4" style="height: inherit;">
			      <img src="${pageContext.request.contextPath}/resources/images/photo.png" id="deptHeadImg" 
			      		class="img-fluid rounded-start" alt="deptHeadImg" style="height: 100%;">
			    </div>
			    <div class="col-md-8">
			      <div class="card-body ms-3 mt-3">
			        <table class="table deptHeadTable">
		          		<colgroup>
							<col width="55px">
							<col width="55px">
						</colgroup>
						<tbody id="deptHeadTableBody">
							<tr>
								<th>이름</th>
								<td>진료과장 없음</td>
							</tr>
							<tr>
								<th>직책</th>
								<td>&nbsp;</td>
							</tr>
						</tbody>
	          		</table>
	          		<div class="d-flex justify-content-end">
	          			<a href='#' id="deptHeadATag">
	          				<img alt="img" src="${pageContext.request.contextPath}/resources/images/pencil.png">
	          			</a>
	          		</div>
			      </div>
			    </div>
			  </div>
			</div>
			<!-- 진료과장 데이터  -->
	      	<div id="deptTitle" class="text-center mb-2" style="font-size: 18px;">진료과 의료진</div>
	      	<div>
		      	<table class="table text-center deptDoctorsTable">
		       		<colgroup>
						<col width="55px">
						<col width="55px">
						<col width="55px">
					</colgroup>
					<thead>
						<tr>
							<th>이름</th>
							<th>직책</th>
							<th>의료진 수정</th>
						</tr>
					</thead>
					<tbody id="deptDrTableBody">
						<tr>
							<td colspan="3">의료진 없음</td>
						</tr>
					</tbody>
		 		</table>
	 		</div>
      	</div>
      </div>
      <input id="deptIdHidden" type="hidden" value="">
      <div class="modal-footer d-flex">
		  <div class="d-flex justify-content-center w-100">
		  	<button type="button" id="updateDeptInfo" class="btn btn-info me-2">
		  		<img src="${pageContext.request.contextPath}/resources/images/pencil.png"><span class="ms-1">수정</span>
		    </button>
		    <button type="button" id="deptDelete" class="btn btn-warning">
		  		<img src="${pageContext.request.contextPath}/resources/images/delete.png"><span class="ms-1">삭제</span>
		    </button>
		  </div>
		  <button type="button" class="btn btn-secondary ms-auto modalClose" data-bs-dismiss="modal">닫기</button>
	  </div>
    </div>
  </div>
</div>
<!-- ------------부트스트랩 modal 끝---------------- -->

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
				
				<div class="container mt-3" style="width: 70%; height: 100%;">
				
				<div class="d-flex justify-content-center">
					<div class="mt-3" >
						<div class="d-flex justify-content-center" >
						    <div class="mt-3" style="width: 500px;">
						        <div class="d-flex position-relative">
						            <!-- 검색 입력 및 결과 -->
						            <div class="flex-grow-1 me-2 position-relative" >
						                <input 
						                    class="form-control me-2 py-3" 
						                    id="searchInput" 
						                    type="search" 
						                    placeholder="진료과 검색" 
						                    aria-label="Search">
						                <ul 
						                    class="list-group position-absolute w-100 d-none" 
						                    id="searchResults" 
						                    style="top: calc(100% + 2px);">
						                    <!-- 검색 결과가 동적으로 추가 -->
						                </ul>
						            </div>
						            <!-- 검색 버튼 -->
						            <button 
						                class="btn btn-outline-primary text-nowrap" 
						                id="searchBtn" 
						                type="button">
						                <img 
						                    src="${pageContext.request.contextPath}/resources/images/ico_search.png" 
						                    class="me-1" 
						                    style="width: 17px; height: 17px;">검색
						            </button>
						            	<img src="${pageContext.request.contextPath}/resources/images/reset_image5.png"
						            		 class="ms-2 resetImg">
						        </div>
						    </div>
						</div>
					</div>
				</div>
	
				<div class="d-flex justify-content-between align-items-center" style="height: 70px;">
					<div class="text-start">
				    	<span class="subtit f_s20 f_w700">진료과 목록</span>
				  	</div>
			  		<div class="d-flex align-items-center" style="width: auto; height: 50px;">
			    		<button class="btn btn-primary text-nowrap ms-5" id="deptRegister" type="button" 
					            style="min-width: 100px; height: 100%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">진료과 등록
				        </button>
				    </div>
				</div>
				
				
				<!-- 스크롤 생성용 div -->
				<div id="searchResultDiv" style="height: 80%; overflow-y: auto; overflow-x: hidden;">
				
				<!-- 부트스트랩 카드 -->
				<div class="row">
					<c:forEach var="deptAndFile" items="${deptAndFileList }">
					<div class="col-md-4">
				      <div class="card mb-3" style="width: 100%; height: 300px; overflow: hidden;">
				      	<c:if test="${not empty deptAndFile.filePath}">
			          	<img src="${pageContext.request.contextPath}${deptAndFile.filePath}" 
			            		class="img-fluid rounded-start" alt="image" style="width: 100%; height: 70%;">
			            </c:if>
			            <c:if test="${empty deptAndFile.filePath}">
			          	<img src="${pageContext.request.contextPath}/resources/images/question_image.png" 
			            		class="img-fluid rounded-start" alt="image" style="width: 100%; height: 70%;">
			            </c:if>
			            <div class="card-body" style="height: 50%; display: flex; flex-direction: column; justify-content: space-between;">
			              <h5 class="card-title text-center" style="font-size: 23px; font-weight: bold; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
			              		${deptAndFile.deptName }
			              </h5>
			              <input class="hiddenDeptHeadId" type="hidden" value="${deptAndFile.drId }">
			              <input class="hiddenDeptId" type="hidden" value="${deptAndFile.deptId }">
			              <input class="hiddenDeptName" type="hidden" value="${deptAndFile.deptName }">
			              <button type="button" class="btn btn-primary btn-sm modalBtns">상세보기
			              </button>
			            </div>
				      </div>
				    </div>
				    </c:forEach>
				</div> <!-- row div 끝 -->
				
				</div> <!-- 스크롤 div 끝 -->
				
				</div>
			</div>
		</div>
		<div class="footer bg_13 f_s15">2025 ITWILL Medical Center All right Reserved.</div>
	</div>
	<!-- 컨텐츠 끝  -->
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