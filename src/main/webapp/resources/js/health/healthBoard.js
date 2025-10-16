//페이지 로드시  
$(document).ready(function() {
	const cardContainer = document.getElementById('card-container');
	const loadMoreBtn = document.getElementById('loadMoreBtn');
	
	let itemsPerPage = 12; //한 번에 보여줄 카드 개수
	let currentPage = 1; //현재 페이지
	
	
	//전체 데이터 가져오기
	let cardsData = [];
	$.ajax({
		url: "getHealthBoardListClientPage"
		, method : "get"
		, success : function(data) {
			cardsData = data;
			
			//초기 카드 로드
			addCards(0, itemsPerPage);
			
		}
		, error : function(error) {
			alert("실패 : " + error);
		}
	});
	
	
	
	//카드 추가 함수
	function addCards(startIndex, endIndex, flag) {
		console.log("파라미터 확인 : " + startIndex + ", endIndex : " + endIndex);
		
		let innerHtml = "";
		
		//데이터 없으면
		if(cardsData == "") {
			console.log("데이터 없음시 표시");
			innerHtml += `
						<div class="no-data-container">
							<div class="no-data">
								<img src="${contextPath}/resources/images/warning.png">
								<p>검색된 결과가 없습니다.</p>
							</div>
						</div>
						`;
			$('.my-5').html(innerHtml);
			loadMoreBtn.style.display = "none"; //더보기 버튼 숨기기
			
		} else if (flag === 1) { //검색 데이터면
			console.log("검색 실행 후 데이터 표시");
			
			//더보기 버튼 
			if(endIndex >= cardsData.length) {
				loadMoreBtn.style.display = "none";
			}
			
			//데이터 출력
			cardsData.slice(startIndex, endIndex).forEach((card) => {
				innerHtml += `
							<div class="col">
								<a href="getHealthBoardDetailPage?hbId=${card.hbId}">
									<div class="card h-100">
							`;
				if(card.filePath === null) {
					innerHtml += `
								<img src="${contextPath}/resources/images/no_image.jpg" class="card-img-top" alt="사진 없음">
								`;
				} else {
					innerHtml += `
								<img src="${contextPath}${card.filePath}" class="card-img-top" alt="${card.title}">
								`;
				}
				innerHtml += `
							<div class="card-body">
								<p class="card-title">${card.title}</p>
								</div>
							</div>
						</a>
					</div>
							`;
			});
			
			$('.row').html(innerHtml);
			
		} else {
			console.log("초기 데이터 표시");
			
			//더보기 버튼 
			if(endIndex >= cardsData.length) {
				loadMoreBtn.style.display = "none";
			}
			
			//데이터 출력
			cardsData.slice(startIndex, endIndex).forEach((card) => {
				innerHtml += `
							<div class="col">
								<a href="getHealthBoardDetailPage?hbId=${card.hbId}">
									<div class="card h-100">
							`;
				if(card.filePath === null) {
					innerHtml += `
								<img src="${contextPath}/resources/images/no_image.jpg" class="card-img-top" alt="사진 없음">
								`;
				} else {
					innerHtml += `
								<img src="${contextPath}${card.filePath}" class="card-img-top" alt="${card.title}">
								`;
				}
				innerHtml += `
							<div class="card-body">
								<p class="card-title">${card.title}</p>
								</div>
							</div>
						</a>
					</div>
							`;
			});
			
			$('.row').append(innerHtml);
		}
		
		
	}
	
	//더보기버튼 클릭 이벤트 연결
	loadMoreBtn.addEventListener('click', function() {
		const startIndex = currentPage * itemsPerPage;
		const endIndex = startIndex + itemsPerPage;
		
		//추가 카드 렌더링
		addCards(startIndex, endIndex);
		currentPage++;
		
		if(endIndex >= cardsData.length) {
			loadMoreBtn.style.display = "none";
		}
		
		
	});
	
	
	//검색 폼 
	$('#searchBtn').click(function(event) {
		 event.preventDefault();
		 
		 //emptyCheck
		 let searchKeyword = document.getElementById('searchBox').value.trim();
		 console.log("검색어 : " + searchKeyword);
		 
		 if (searchKeyword == "") {
			location.reload();
			return;
		 }
		 
		 searchAjax(searchKeyword);
		 
	});
	
	let searchFlag = 0;
	
	//검색 ajax
	function searchAjax(keyword) {
		console.log("파라미터 확인 : " + keyword);
		
		$.ajax({
			url : "getHealthBoardBySearchKeyword"
			, method : "post"
			, contentType : "application/json"
			, data : JSON.stringify({keyword : keyword})
			, dataType : "json"
			, success : function(data) {
				console.log(data);
				
				cardsData = data;
				searchFlag = 1;
				addCards(0, itemsPerPage, searchFlag);
				
			} 
			, error : function() {
				alert('실패');
			}
		});
	}
});