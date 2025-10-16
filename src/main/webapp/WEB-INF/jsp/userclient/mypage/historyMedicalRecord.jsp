<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>진료내역</title>
	<script src="https://kit.fontawesome.com/209bda59e8.js" crossorigin="anonymous"></script>
	<%@include file ="/resources/header/header.jspf" %>
</head>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');

    *{
        font-family: "Nanum Gothic", serif;
        font-weight: 400;
        font-style: normal;
    }

    html, body {width:100%; height:100%; margin:0; padding:0; -webkit-text-size-adjust: none;  -moz-text-size-adjust: none;  -ms-text-size-adjust: none; background-color: rgb(243, 242, 242);}

    .common {
        width: 850px;
        height: 100px;
        margin: 40px;
    }

	.content {
		height: 70%;
	}

    .noti > span {
        display: block;
        margin-top: 10px;
    }


    .searchForm {

        background-color: white;
        border-bottom: 1px solid rgb(224, 222, 222);
        display: flex;
        justify-content: center;
        height: 70px;
    }

    .searchForm > div {
        margin: 15px 0px;
        text-align: center;
        padding: 8px;
    }

    .searchForm div:nth-child(2){
        display: flex;
    }

	.searchForm button {
		height: 40px;
		width: 40px;
		margin: 15px 0px;
		padding: 8px;
		border: 0px;
		background-color: #0084ff;
	}

    .content-title {

        height: 50px;
        border-bottom: 1px solid black;
        font-size: large;
        font-weight: bold;
    }

    .content-main-span {
        
        font-weight: bold;
        text-align: center;
        border-bottom: 1px solid hsla(227, 17%, 43%, 0.3);
        color: #5b6380be;
        padding: 20px 0px;
    }

	.content-main-paging {

		width: 850px;
		height: 50px;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.content-main-table-div {
		text-align: center;
        border-bottom: 1px solid hsla(227, 17%, 43%, 0.3);
	}

	.content-main-table-div > table {
		width: 850px;
		height: 100px;
	}

	thead > tr {
		height: 50px;
	} 

	thead > tr > th {
		font-weight: 600;
		color: #373030;
	}

	tbody > tr {
		height: 50px;
	}

	tbody > tr > td {

		border-top: 1px solid #c2c0c0;
	}

	
	
	.paging {

		width: 400px;
		height: 50px;
		display: flex;
		justify-content: center;
		align-items: center;
		flex-wrap: wrap;
		margin: 0px;
		padding: 0px;
		list-style: none;
	}

	.paging > li {
		margin: 10px;
		padding: 10px;
		text-align: center;
		border: 1px solid;
		border-radius: 6px;
		color: #f1f1f1;
		background-color: #777474;
		font-weight: bold;
	}


	.noti1 {
		font-size: 23px;
		font-weight: 750;
	}

	.noti2 {
		font-size: 15px;
		font-weight: 750;
	}

</style>

<script>

	let startDate;
	let endDate;
	let userNum = "${user.userNum}";
	let cPage;

	// 서버에 데이터 보내기 전 검증 후 요청
	function searchRecord() {

		// 입력받은값 추출
		startDate = document.getElementById('startDate').value; // 반환 값 형식 : yyyy-mm-dd String
		endDate = document.getElementById('endDate').value;

		// 현재일 추출
		let today = new Date();
		
		let year = parseInt(today.getFullYear());
		let month = parseInt(today.getMonth() + 1);
		let date = parseInt(today.getDate());

		// 시작일 숫자로 파싱
		let startYear = parseInt(subStrYear(startDate));
		let startMonth = parseInt(subStrMonth(startDate));
		let startDay = parseInt(subStrDay(startDate));
		// 끝일 숫자로 파싱
		let endYear = parseInt(subStrYear(endDate));
		let endMonth = parseInt(subStrMonth(endDate));
		let endDay = parseInt(subStrDay(endDate));


		// 최대 1년 단위로 검색가능 분기문 작성, 현재 연도를 기준으로 최대 10년까지 검색가능 
		// 조건 1. (현재 연도 -10) X
		// 조건 2. 시작연도 +1 or 같은 지
		// 조건 3. 월 범위
		// 		 +1연도면 1 ~ 시작월, 같은연도 시작월보다 크게
		// 조건 4. 일 범위
		// 		 같은 월 선택 시 시작일보다 같거나 작게

		// 조건 1. (현재 연도 -10) X
		if (!(startYear < (year - 10))){
			// 조건 2. 끝연도 = 시작연도 +1 or 같은 지
			if (endYear == startYear || endYear == (startYear + 1)) {
				// 조건 3. 월 범위
				// 같은연도시 시작월보다 크거나 같다
				if(endYear == startYear){
					// 시작월보다 크거나 같다
					if(startMonth <= endMonth) {
						// 시작월과 같은 경우
						if(startMonth == endMonth){
							// 일의 범위 : 시작일보다 크거나 같게
							if(startDay <= endDay){
								// 서버에 보내기 
								callDataAndShow(startDate, endDate);
								return;
							} else {
								alert('시작일로부터 최대 1년까지 검색가능합니다\n다시 입력해주세요');
								return;
							}

							// 시작월보다 큰 경우 일 검증 X
						} else {
							// 서버에 보내기 
							callDataAndShow(startDate, endDate);
							return;
						}

					} else {
						alert('시작일로부터 최대 1년까지 검색가능합니다\n다시 입력해주세요');
						return;
					}
				}



				//  +1연도면
				if(endYear == (startYear + 1)) {
					// 월 범위 : 1 ~ 시작월
					if(1 <= endMonth && endMonth <= startMonth){
						// 시작월과 같은 경우
						if(startMonth == endMonth){
							// 일의 범위 : 시작일보다 크거나 같게
							if(startDay >= endDay){
								// 서버에 보내기 
								callDataAndShow(startDate, endDate);
								return;
							} else {
								alert('시작일로부터 최대 1년까지 검색가능합니다\n다시 입력해주세요');
								return;
							}

							// 시작월보다 작은 경우 
						} else {
							// 서버에 보내기 
							callDataAndShow(startDate, endDate);
							return;
						}

					} else {
						alert('시작일로부터 최대 1년까지 검색가능합니다\n다시 입력해주세요');
						return;
					}
				}



			} else {
				alert('시작일로부터 최대 1년까지 검색가능합니다\n다시 입력해주세요');
				return;
			}
		} else {
			alert('현재일 기준으로 최대 10년까지 검색가능합니다\n다시 입력해주세요');	
			return;
		}

	}

	// 서버에 진료기록 요청
	function callDataAndShow (startDate, endDate, cPage){

		// 서버에 데이터 요청
		console.log('서버에 데이터 요청');
		fetch('/hospital/mypage/findRecord', {

			method : 'POST',
			headers : {'Content-Type' : 'application/json'},
			body : JSON.stringify({
				startDate : startDate,
			    endDate : endDate,
			    userNum : userNum,
			    cPage : cPage,
			}),

		})
		.then(response => {

			if (!response.ok){
             throw new Error('HTTP ERROR Status : ${response.status}');
             alert("서버 오류입니다 잠시 후에 시도해주세요\n관리자 번호 : 010-8282-5353");
         	}
 
         return response.json();

		})
		.then(data => {

			console.log(data);

			let content = data.content;
			let paging = data.paging;
			console.log(content);
			console.log(paging);

			const span = document.querySelector('.content-main-span');
			const table = document.querySelector('.content-main-table-div');

			// 데이터가 있을 때만
			if (content.length != 0){

				span.style.display = 'none';
				table.style.display = 'block';

				// 넘어온 데이터 생성 
				let tbody = document.querySelector('.tbody');
				// 이전 데이터 제거
				tbody.replaceChildren();

				// tbody 데이터 생성
				for (let i = 0; i < content.length; i++){

					// tr
					const tr = document.createElement('tr');

					// td 6개
					const td1 = document.createElement('td');
					let td1Text = document.createTextNode(content[i].recordType);
					td1.appendChild(td1Text);
					tr.appendChild(td1);

					const td2 = document.createElement('td');
					let td2Text = document.createTextNode(content[i].deptName);
					td2.appendChild(td2Text);
					tr.appendChild(td2);

					const td3 = document.createElement('td');
					let td3Text = document.createTextNode(content[i].drName);
					td3.appendChild(td3Text);
					tr.appendChild(td3);

					const td4 = document.createElement('td');
					let td4Text = document.createTextNode(content[i].createdAt);
					td4.appendChild(td4Text);
					tr.appendChild(td4);

					const td5 = document.createElement('td');
					let td5Text = document.createTextNode(content[i].treatmentPeriod);
					td5.appendChild(td5Text);
					tr.appendChild(td5);

					const td6 = document.createElement('td');
					let td6Text = document.createTextNode(content[i].cost + '원');
					td6.appendChild(td6Text);
					tr.appendChild(td6);

					tbody.appendChild(tr);
					// for (let j = 1; j <= 6; j++){
					// 	tr.appendChild(td + j)
					// }
				}

				// 페이징 처리 생성
				let pagingOl = document.querySelector('.paging');
				// 이전 데이터 제거
				pagingOl.replaceChildren();

				// 이전으로 사용여부 처리
				const liBefore = document.createElement('li');
				if (paging.beginPage == 1){
					liBefore.setAttribute('class', 'disable');
					let text = document.createTextNode('이전');
					liBefore.appendChild(text);
					pagingOl.appendChild(liBefore);
				} else if (paging.beginPage != 1) {
					liBefore.setAttribute('onclick', 'callDataAndShow(startDate, endDate, ' + (parseInt(paging.beginPage) - 1) + ')');
					let text = document.createTextNode('이전');
					liBefore.appendChild(text);
					pagingOl.appendChild(liBefore);
				}

				// 블록내에 표시할 페이지 태그 작성
				const liblock = document.createElement('li');
				for (let i = paging.beginPage; i <= paging.endPage; i++){
					if(i == paging.nowPage){
						const text = document.createTextNode(i);
						liblock.appendChild(text);
						pagingOl.appendChild(liblock);
					} else {
						const text = document.createTextNode(i);
						liblock.appendChild(text);
						liblock.setAttribute('onclick', 'callDataAndShow(startDate, endDate, ' + i + ')');
						pagingOl.appendChild(liblock);
					}
				}

				const liAfter = document.createElement('li');
				// [다음으로] 사용여부 처리 
				if (paging.endPage < paging.totalPage){
						liAfter.setAttribute('onclick', 'callDataAndShow(startDate, endDate, ' + (parseInt(paging.endPage) + 1) + ')');
						let text = document.createTextNode('다음');
						liAfter.appendChild(text);
						pagingOl.appendChild(liAfter);
					} else if (paging.endPage >= paging.totalPage) {
						liAfter.setAttribute('class', 'disable');
						let text = document.createTextNode('다음');
						liAfter.appendChild(text);
						pagingOl.appendChild(liAfter);
				}

			} else {
				span.style.display = 'block';
				table.style.display = 'none';
			}	// // 데이터가 있을 때만 분기문 끝
		}) // ajax 응답 끝
	}// callDataAndShow 끝

	// 연도 자르기
	function subStrYear(date){
		return date.substr(0, 4);
	}

	// 월 자르기
	function subStrMonth(date){
		return date.substr(5, 7);
	}
	
	// 일 자르기
	function subStrDay(date){
		return date.substr(8);
	}

</script>
<body>

		<!-- <div>
			본인인증 검증 div
		</div> -->


		<!-- <header> -->
		<div class="container">
			<div class="noti common">
				<p class="noti1"><span class="noti1" style="color: blue;">${user.userName}</span>님의 과거진료내역을 검색합니다.</p>
				<span class="noti2" style="color: #959191;">&#8251; 조회가능한 기간은 현재일 기준으로 10년까지이며, 최대 1년 단위로 검색가능합니다.</span>
				<span class="noti2" style="color: #f52000;">&#40;과거진료내역 조회는 10년이내까지만 조회 가능하지만, 의무기록사본 신청은 10년 이전 기록도 가능합니다.&#41;</span>
			</div>

			<div class="searchForm common">
				<div>검색</div>
				<div>
                    <input type="date" id="startDate">
				    <div style="margin: 0px 5px;">~</div>
                    <input type="date" id="endDate">
                </div>

				<label for="searchBtn">
					<button id="searchBtn" onclick="searchRecord()" style="cursor: pointer;">
						<i class="fa-solid fa-magnifying-glass fa-lg" style="color: #ffffff;"></i>
					</button>
				</label>
			</div>
		<!-- </header> -->

		<div class="content common">
			<div class="content-title">과거진료내역</div>
			<div class="content-main-span">
				<span>수진이력이 없습니다.</span>
			</div>

			<div class="content-main-table-div" style="display: none;">
				<table>
                    <thead>
                        <tr>
                            <th>진료구분</th>
                            <th>진료과</th>
                            <th>의사명</th>
                            <th>진료일시</th>
                            <th>진료기간</th>
							<th>진료비</th>
                        </tr>
                    </thead>
					
					<tbody class="tbody"></tbody>

               
                </table>
			</div>
			<div class="content-main-paging">
				<ol class="paging"></ol>
			</div>
		</div> 
</div> 
		<footer>
		</footer>
<%@include file ="/resources/footer/footer.jspf" %>
</body>

</html>