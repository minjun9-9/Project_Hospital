let contextPath = '/hospital';

window.addEventListener("load", function(){
	const resetImg = document.querySelector(".resetImg");
	resetImg.addEventListener("click", () => {
		location.reload(true);
	}); 
	
	const searchInput = document.querySelector("#searchInput");
	const radioDiv = document.querySelector(".radioDiv");
	
	//외부 입력시 검색창 숨기기
    document.addEventListener("click", (event) => {
        if (!searchResults.contains(event.target) && event.target !== searchInput) {
            searchResults.classList.add("d-none");
        }
    });
	
	//radio value 가져오기.  radio -> Div로 이벤트 위임
	let keyword = "name";
	radioDiv.addEventListener("change", (event) => {
		if (event.target.tagName === "INPUT" && event.target.checked) {
			keyword = event.target.value;
			searchInput.value = "";
		}
	});
	
	//검색어에 입력시 목록 가져오는 이벤트 처리
	searchInput.addEventListener("keyup", () => {
		let query = searchInput.value.trim();
		
		if (query) {
			fetch(contextPath + "/searchDrInfo?keyword=" + keyword + "&query=" + query, {
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
    					if (keyword === "field") {
    						for (let data of dataList) {
    							if (data.includes(",")) {
    								let newDatas = data.split(",");
    								for (let newData of newDatas) {
    									if (newData.includes(query)) {
    										searchResults.classList.remove("d-none");
    										let li = document.createElement("li");
    										li.textContent = newData;
    										searchResults.appendChild(li);
    									}
    								}
    							} else {
    								if (data.includes(query)) {
    									searchResults.classList.remove("d-none");
    									let li = document.createElement("li");
    		    						li.textContent = data;
    		    						searchResults.appendChild(li);
    								}
    							}
    						}
    					} else {
	    					searchResults.classList.remove("d-none");
	    					for (let data of dataList) {
	    						let li = document.createElement("li");
	    						li.textContent = data;
	    						searchResults.appendChild(li);
	    					}
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
    searchResults.addEventListener("click", (event) => {
    	if (event.target.tagName === "LI") {
    		searchInput.value = event.target.textContent;
    		searchResults.classList.add("d-none");
    	}
    });
	
  	//검색 버튼 클릭시 서버로 데이터 요청
    const searchBtn = document.querySelector("#searchBtn");
    const searchResultDiv = document.querySelector("#searchResultDiv");
    searchBtn.addEventListener("click", () => {
    	getSearchDrInfo(keyword);
    });
    
    //인풋 박스에서 엔터키 눌렀을때 서버로 데이터 요청
    searchInput.addEventListener("keydown", (event) => {
    	if (event.key === "Enter") {
    		getSearchDrInfo(keyword);
    	}
    });
    
    const modal = document.querySelector("#exampleModal"); //모달요소
	const content = document.querySelector("#content"); //모달외부요소
    const bootstrapModal = new bootstrap.Modal(modal); // Bootstrap 모달 인스턴스
    
    modal.addEventListener("hidden.bs.modal", () => {
		content.removeAttribute("inert"); // 모달 외부 콘텐츠 활성화
	});
    
    const tbody = document.getElementById("drListTbody");
    tbody.addEventListener("click", (event) => {
    	 if (event.target.closest(".modalBtns")) {
    		 const modalButton = event.target.closest(".modalBtns");
             const drId = modalButton.querySelector("input[type='hidden']").value;
             
    		 fetch(contextPath + '/getOneDrInfo', {
 				method : "POST",
 				headers: { "Content-Type": "application/json" },
 				body : JSON.stringify({ drId })
 			})
 				.then(response => {
 					if (!response.ok) {
 						throw new Error("[modalBtn] Ajax 요청 에러발생" + response.statusText);
 					}
 					return response.json();
 				})
 				.then(data => {
 					//파일 처리
 					const profileImgArr = document.querySelectorAll(".profileImg");
 					const profileTextArr = document.querySelectorAll(".profileText");
 					
 					const filePathArr = data.filePath;
 					if (filePathArr != null) {
 						for (let i = 0; i < filePathArr.length; i++) {
 							profileImgArr[i].setAttribute("src", contextPath + filePathArr[i]);
 							profileTextArr[i].innerHTML = "프로필 이미지" + (i + 1);
 						}
 						
 						for (let profileImg of profileImgArr) {
 							if (profileImg.getAttribute("src") === "#") {
 								profileImg.setAttribute("src", contextPath + "/resources/images/photo.png");
 							}
 						}
 					} else {
 						for (let profileImg of profileImgArr) {
 							
 							profileImg.setAttribute("src", contextPath + "/resources/images/photo.png");
 						}
 					}
 					
 					const nbsp2 = '&nbsp;&nbsp;';
 					const nbsp3 = '&nbsp;&nbsp;&nbsp;';
 					const nbsp8 = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp';
 					const hiddenRow = "<td class='hiddenRow'>--</td>";
 					//tbody1
 					let tbodyHTML = "<tr>";
 					tbodyHTML += "<th>아" + nbsp2 + "이" + nbsp2 + "디</th>";
 					tbodyHTML += hiddenRow;
 					tbodyHTML += "<td>" + data.drId + "</td>";
 					tbodyHTML += "</tr>";
 					
 					tbodyHTML += "<tr>";
 					tbodyHTML += "<th>성" + nbsp8 + "명</th>";
 					tbodyHTML += hiddenRow;
 					tbodyHTML += "<td>" + data.drName + "</td>";
 					tbodyHTML += "</tr>";
 					
 					tbodyHTML += "<tr>";
 					tbodyHTML += "<th>학" + nbsp8 + "력</th>";
 					tbodyHTML += hiddenRow;
 					tbodyHTML += "<td>" + data.drEducation + "</td>";
 					tbodyHTML += "</tr>";
 					
 					tbodyHTML += "<tr>";
 					tbodyHTML += "<th>진" + nbsp2 + "료" + nbsp2 + "과</th>";
 					tbodyHTML += hiddenRow;
 					tbodyHTML += "<td>" + data.deptName + "</td>";
 					tbodyHTML += "</tr>";
 					
 					tbodyHTML += "<tr>";
 					tbodyHTML += "<th>직" + nbsp8 + "책</th>";
 					tbodyHTML += hiddenRow;
 					tbodyHTML += "<td>" + data.drPosition + "</td>";
 					tbodyHTML += "</tr>";
 					
 					
 					document.querySelector("#modalTbody1").innerHTML = tbodyHTML;
 					
 					let addresses = data.drAddress.split(",");
 					
 					//tbody2
 					let tbodyHTML2 = "<tr>";
 					tbodyHTML2 += "<th>전화번호</th>";
 					tbodyHTML2 += hiddenRow;
 					tbodyHTML2 += "<td>" + data.drPhoneNum + "</td>";
 					tbodyHTML2 += "</tr>";
 					
 					tbodyHTML2 += "<tr>";
 					tbodyHTML2 += "<th>주" + nbsp8 + "소</th>";
 					tbodyHTML2 += hiddenRow;
 					tbodyHTML2 += "<td>" + addresses[0] + nbsp3 + addresses[1] + "</td>";
 					tbodyHTML2 += "</tr>";
 					
 					tbodyHTML2 += "<tr>";
 					tbodyHTML2 += "<th>우편번호</th>";
 					tbodyHTML2 += hiddenRow;
 					tbodyHTML2 += "<td>" + addresses[2] + "</td>";
 					tbodyHTML2 += "</tr>";
 					
 					tbodyHTML2 += "<tr>";
 					tbodyHTML2 += "<th>주민번호</th>";
 					tbodyHTML2 += hiddenRow;
 					tbodyHTML2 += "<td>" + data.drPersonNum + "</td>";
 					tbodyHTML2 += "</tr>";
 					
 					
 					document.querySelector("#modalTbody2").innerHTML = tbodyHTML2;
 					
 					//tbody3
 					let key = "전문과목";
 					let returnDataStr = "";
 					returnDataStr = dataArrFnt(data, key);
 					
 					let tbodyHTML3 = "<tr>";
 					tbodyHTML3 += "<th>전문과목</th>";
 					tbodyHTML3 += hiddenRow;
 					tbodyHTML3 += "<td>" + returnDataStr + "</td>";
 					tbodyHTML3 += "</tr>";
 					
 					key = "경력";
 					returnDataStr = dataArrFnt(data, key, hiddenRow, nbsp8);
 					
 					tbodyHTML3 += "<tr>";
 					tbodyHTML3 += "<th>경" + nbsp8 + "력</th>";
 					tbodyHTML3 += hiddenRow;
 					tbodyHTML3 += returnDataStr;
 					
 					
 					key = "학회";
 					returnDataStr = dataArrFnt(data, key, hiddenRow, nbsp8);
 					
 					tbodyHTML3 += "<tr>";
 					tbodyHTML3 += "<th>학" + nbsp8 + "회</th>";
 					tbodyHTML3 += hiddenRow;
 					tbodyHTML3 += returnDataStr;
 					
 					
 					key = "수상";
 					returnDataStr = dataArrFnt(data, key, hiddenRow, nbsp8);
 					
 					tbodyHTML3 += "<tr>";
 					tbodyHTML3 += "<th>수" + nbsp8 + "상</th>";
 					tbodyHTML3 += hiddenRow;
 					tbodyHTML3 += returnDataStr;
 					
 					
 					document.querySelector("#modalTbody3").innerHTML = tbodyHTML3;
 					
 					//hidden input에 ID 값 넣기
 					document.querySelector("#drIdHidden").value = data.drId;
 					
 				})
 				.catch(error => {
 					alert(error);
 				})
 			
 			content.setAttribute("inert", "");
 			bootstrapModal.show();
    		 
    	 }
    	
    });
	
    //modal 의료진 수정 처리버튼(페이지 전환 처리만)
	const updateDrInfoBtn = document.querySelector("#updateDrInfo");
	updateDrInfoBtn.addEventListener("click", () => {
		location.href = contextPath + "/doctor/doctorInfoUpdate?drId=" + document.querySelector("#drIdHidden").value;
	});
	
	//modal 의료진 삭제 처리버튼
	//통합 이후 수정함
	const deleteDrInfoBtn = document.querySelector("#deleteDrInfo");
	deleteDrInfoBtn.addEventListener("click", () => {
		if (!confirm("정말 삭제 하시겠습니까?")) {
			return false;
		} else {
			//삭제하기 yes를 했을때 처리할 로직 작성
			const drId = document.querySelector("#drIdHidden").value;
			location.href = "deleteDrInfo?drId=" + drId;
		}
	});
	
	
	
});

function goDrRegister() {
	location.href = "adminDoctorRegister";
}
/**
 * 통합 검색 기능
 */
function getSearchDrInfo(keyword) {
	const searchInputValue = searchInput.value.trim();
	if (searchInputValue) {
		//여기서 서버로 데이터 요청하면 된다
		fetch(contextPath + "/seachDrInfoByName?keyword=" + keyword + "&query=" + searchInputValue, {
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
					const tbody = document.getElementById("drListTbody");
				    tbody.innerHTML = "";
				    
				    for (let data of dataList) {
				    	const tr = document.createElement("tr");
				        tr.classList.add("doctorList");
				        
				        const tdId = document.createElement("td");
				        tdId.textContent = data.drId;
				        tr.appendChild(tdId);
				        
				        const tdName = document.createElement("td");
				        tdName.textContent = data.drName;
				        tr.appendChild(tdName);
				        
				        const tdPosition = document.createElement("td");
				        tdPosition.textContent = data.drPosition;
				        tr.appendChild(tdPosition);
				        
				        const tdDeptName = document.createElement("td");
				        tdDeptName.textContent = data.deptName;
				        tr.appendChild(tdDeptName);
				        
				        let drFieldArr = [];
						let drField = "전문과목 없음";
						if (data.drField != null) {
							let drFieldStr = data.drField;
							drFieldArr = drFieldStr.split(",");
							let drFieldComma = "";
							for (let field of drFieldArr) {
								drFieldComma += field;
								drFieldComma += ", ";
							}
							drField = drFieldComma.slice(0, drFieldComma.length - 2);
						}
				        
				        const tdField = document.createElement("td");
				        tdField.textContent = drField;
				        tr.appendChild(tdField);
				        
				        const tdCalendar = document.createElement("td");
				        const calendarLink = document.createElement("a");
				        calendarLink.classList.add("mask_calendar");
				        calendarLink.id = data.drId;
				        calendarLink.style.cursor = "pointer";
				        
				        const calendarImg = document.createElement("img");
				        calendarImg.src = `${contextPath}/resources/images/caldendar_blue.png`;
				        calendarLink.appendChild(calendarImg);
				        tdCalendar.appendChild(calendarLink);
				        tr.appendChild(tdCalendar);
				        
				        const tdModal = document.createElement("td");
				        const modalLink = document.createElement("a");
				        modalLink.classList.add("modalBtns");
				        modalLink.dataset.bsToggle = "modal";
				        modalLink.dataset.bsTarget = "#exampleModal";
				        modalLink.style.cursor = "pointer";
				        
				        const modalImg = document.createElement("img");
				        modalImg.src = `${contextPath}/resources/images/view_all.png`;
				        modalImg.style.width = "25px";
				        modalLink.appendChild(modalImg);
				        
				        const hiddenInput = document.createElement("input");
				        hiddenInput.type = "hidden";
				        hiddenInput.value = data.drId;
				        modalLink.appendChild(hiddenInput);
				        
				        tdModal.appendChild(modalLink);
				        tr.appendChild(tdModal);
				        
				        tbody.appendChild(tr);
				        
				    }
				    searchInput.value = "";
				    searchResults.classList.add("d-none");
			        const paginationLis = document.querySelectorAll(".pagination li");
			        for (let paginationLi of paginationLis) {
			       	 	paginationLi.classList.add("disabled");
			        }
				} else {
					searchResults.classList.add("d-none");
					alert("검색 결과가 없습니다.");
					return;
				}
			})
			.catch(error => {
				alert(error);
			})
	}
}
function dataArrFnt(data, key, hiddenRow, nbsp8) {
	let fntHTML = "";
	if (key === "전문과목") {
		let fieldTableArr = [];
		let fieldTableStrFirst = "";
		let fieldTableStrLast = "";
		if (data.drField != null) {
			fieldTableArr = data.drField.split(",");
			for (let fi of fieldTableArr) {
				fieldTableStrFirst += fi;
				fieldTableStrFirst += ", ";
			}
			fieldTableStrLast = fieldTableStrFirst.slice(0, fieldTableStrFirst.length - 2);
			return fieldTableStrLast;
		} else {
			fieldTableStrLast = "전문과목 없음";
			return fieldTableStrLast;
		}
	}
	else if (key === "경력") {
		let careerTableArr = [];
		let careerTableStr = "경력 없음";
		if (data.drCareer != null) {
			careerTableArr = data.drCareer.split(",");
			if (careerTableArr.length === 1) {
				fntHTML += "<td>" + careerTableArr[0] + "</td></tr>";
				return fntHTML;
			} else {
				fntHTML += "<td>" + careerTableArr[0] + "</td></tr>";
			}
			for (let i = 1; i < careerTableArr.length; i++) {
				fntHTML += "<tr>";
				fntHTML += hiddenRow; //th대용
				fntHTML += hiddenRow; //칸 띄우기
				fntHTML += "<td>" + careerTableArr[i] + "</td>" //데이터
				fntHTML += "</tr>";
			}
			return fntHTML;
		} else {
			fntHTML += "<td>" + careerTableStr + "</td>";
			fntHTML += "</tr>";
			return fntHTML;
		}
	}
	else if (key === "학회") {
		let academicTableArr = [];
		let academicTableStr = "학회 없음";
		if (data.drAcademic != null) {
			academicTableArr = data.drAcademic.split(",");
			if (academicTableArr.length === 1) {
				fntHTML += "<td>" + academicTableArr[0] + "</td></tr>";
				return fntHTML;
			} else {
				fntHTML += "<td>" + academicTableArr[0] + "</td></tr>";
			}
			for (let i = 1; i < academicTableArr.length; i++) {
				fntHTML += "<tr>";
				fntHTML += hiddenRow; //th대용
				fntHTML += hiddenRow; //칸 띄우기
				fntHTML += "<td>" + academicTableArr[i] + "</td>" //데이터
				fntHTML += "</tr>";
			}
			return fntHTML;
		} else {
			fntHTML += "<td>" + academicTableStr + "</td>";
			fntHTML += "</tr>";
			return fntHTML;
		}
	}
	else if (key === "수상") {
		let awardsTableArr = [];
		let awardsTableStr = "수상 없음";
		if (data.drAwards != null) {
			awardsTableArr = data.drAwards.split(",");
			if (awardsTableArr.length === 1) {
				fntHTML += "<td>" + awardsTableArr[0] + "</td></tr>";
				return fntHTML;
			} else {
				fntHTML += "<td>" + awardsTableArr[0] + "</td></tr>";
			}
			for (let i = 1; i < awardsTableArr.length; i++) {
				fntHTML += "<tr>";
				fntHTML += hiddenRow; //th대용
				fntHTML += hiddenRow; //칸 띄우기
				fntHTML += "<td>" + awardsTableArr[i] + "</td>" //데이터
				fntHTML += "</tr>";
			}
			return fntHTML;
		} else {
			fntHTML += "<td>" + awardsTableStr + "</td>";
			fntHTML += "</tr>";
			return fntHTML;
		}
	}
}