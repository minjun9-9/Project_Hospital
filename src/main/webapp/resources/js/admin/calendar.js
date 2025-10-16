let selectedDrId = ''; // 캘린더 모양 클릭 시 자동주입
let responseData; // 응답받은 객체리스트
let firstDate; // 월 시작일
let lastDate; // 월 마지막일
let basicDate; // '연-월'
let selectedAfterStatus = new Array();  // 상태 변경한 객체 리스트 
let year;
let month;

// 일괄 적용 시 사용할 날짜들
let mondays = [];
let tuesdays = [];
let wednesdays = [];
let thursdays = [];
let fridays = [];
let saturdays = []; 
let sundays = [];
let days = [mondays, tuesdays, wednesdays, thursdays, fridays, saturdays, sundays];


// 캘린더 모양 클릭시 발생
$('.mask_calendar').click(function(){

    
    // 클릭된 의사 id 추출
    selectedDrId = $(this).attr("id");
    
    console.log('type : ' + loginType);
	console.log('접속한 drId :' + loginDrId);
	console.log('클릭한 selectedDrId : ' + selectedDrId);

    if(loginType === 'doctor'){

		if (loginDrId !== selectedDrId){
			alert('타 의료진 정보에는 접근하실 수 없습니다.');
            return;
		} else {
            $('.mask').addClass('on'); // 달력 표시         
        }
	} else {

        $('.mask').addClass('on'); // 달력 표시 
    }



    let today = new Date();

    let dateString = today.toISOString();

    year = dateString.substring(0, 4);
    month = dateString.substring(5, 7);

    // yearSelect에 option 추가
    let yearSelect = document.getElementById('year');
    yearSelect.replaceChildren();

    // 오늘 연도 기준으로 4년 전까지만
    for (let i = year; i >= year - 4; i--){
        const yearOption = document.createElement('option');
        yearOption.setAttribute('value', i);
        yearOption.innerText = i;
        yearSelect.appendChild(yearOption);
    }
    
    callDataAndPrintCalendar(selectedDrId, year, month);
    
})

// [메인] 서버에 진료시간표 데이터 요청
function callDataAndPrintCalendar(selectedDrId, year, month){

    basicDate = year + '-' + month;

    // 비동기
    fetch('/hospital/hpMemberAdmin/findSchedule', {

        method : 'POST',
        headers : {'Content-Type' : 'application/json'},
        body : JSON.stringify({
 
             drId : selectedDrId,
             date : basicDate
 
        }),
 
     })
     // 결과확인
     .then(response => {
 
         if (!response.ok){
             alert("서버 오류입니다 잠시 후에 시도해주세요\n관리자 번호 : 010-8282-5353");
             throw new Error('HTTP ERROR Status : ${response.status}');
         }
 
         return response.json();
 
     })
 
     .then(data => {
         
        responseData = data.content;
        selectedAfterStatus = JSON.parse(JSON.stringify(data.content)); // 깊은 복사
        
        console.log('---- 전달받은 데이터 ----');
        console.log(responseData);
        printCalendar(year, month, responseData);
 
 
 
     })

}

// [메인] 캘린더 출력
function printCalendar(year, month, content){
    
    // 문자열이라 int로 파싱 후 + 1
    let parseMonth = parseInt(month);
    
    // 오늘 달을 기준으로 
    const thisMonthFirstDay = new Date(year, parseMonth - 1, 1); // Date 0 ~ 11 1월 ~ 12월
    const nextMonth = new Date(year, parseMonth, 1);
    
    // 이번 달 마지막 날 구하기
    nextMonth.setDate(nextMonth.getDate() - 1);
    let thisMonthlastDay = nextMonth; 
    let index = parseInt(month) - 1;

    // 첫 페이지 입장 시 오늘 날짜 기준으로 selected
    document.querySelectorAll("select[id=month] option")[index].selected = true;
    
    let firstDay = thisMonthFirstDay.getDay(); // 첫주의 요일 (0 ~ 6), 빈칸 생성 횟수
    let lastDay = thisMonthlastDay.getDay(); // 마지막주 요일
    firstDate = thisMonthFirstDay.getDate(); // 첫 일
    lastDate = thisMonthlastDay.getDate(); // 마지막 일
    let count = 7 - firstDay;
    let contentIndex = 0;
    let weekCount = 7;
    let secondFlag = false;
    let thirdFlag = false;
    let fourthFlag = false;
    let lastFlag = false;
    let fifthFlag = false;
    
    // 공간에 넣을 변수 위치
    let firstWeek = document.getElementById('firstWeek');
    let firstWeekChoice = document.getElementById('firstWeekChoice');
    let secondWeek = document.getElementById('secondWeek');
    let secondWeekChoice = document.getElementById('secondWeekChoice');
    let thirdWeek = document.getElementById('thirdWeek');
    let thirdWeekChoice = document.getElementById('thirdWeekChoice');
    let fourthWeek = document.getElementById('fourthWeek');
    let fourthWeekChoice = document.getElementById('fourthWeekChoice');
    let lastWeek = document.getElementById('lastWeek');
    let lastWeekChoice = document.getElementById('lastWeekChoice');
    let fifthWeek = document.getElementById('fifthWeek');
    let fifthWeekChoice = document.getElementById('fifthWeekChoice');
    
    if (firstWeek != null && firstWeekChoice != null){
        firstWeek.replaceChildren();
        firstWeekChoice.replaceChildren();
    }
    if (secondWeek != null && secondWeekChoice != null){
        secondWeek.replaceChildren();
        secondWeekChoice.replaceChildren();
    }
    if (thirdWeek != null && thirdWeekChoice != null){
        thirdWeek.replaceChildren();
        thirdWeekChoice.replaceChildren();
    }
    if (fourthWeek != null && fourthWeekChoice != null){
        fourthWeek.replaceChildren();
        fourthWeekChoice.replaceChildren();
    }
    if (lastWeek != null && lastWeekChoice != null){
        lastWeek.replaceChildren();
        lastWeekChoice.replaceChildren();
    }
    if (fifthWeek != null && fifthWeekChoice != null){
        fifthWeek.replaceChildren();
        fifthWeekChoice.replaceChildren();
    }
    
    // 이 달 토요일, 일요일날짜 배열 생성
    createDate(firstDay, lastDate);

    // 공백 생성
    for (let j = 0; j < firstDay; j++){
            const spaceTd = document.createElement('td');
            firstWeek.appendChild(spaceTd);
    }
    
    // 날짜를 뿌림과 동시에 해당 월에 맞는 달력 설정
    for (let i = firstDate; i <= lastDate; i++){
        
        // 숫자 기입
        if(i <= count){
            const numTd = document.createElement('td');
            numTd.innerText = i;
            numTd.style.cursor = 'pointer';
            numTd.addEventListener('click', () => showDetailReserve(i));
            firstWeek.appendChild(numTd);
        }
    
        // 선택사항 기입
        if (i == count) {
    
            // 공백 생성
            for (let j = 0; j < firstDay; j++){
                const spaceTd = document.createElement('td');
                firstWeekChoice.appendChild(spaceTd);
            }
            
            for (let k = 0; k < count; k++){

                createAmPm(firstWeekChoice, k);
                setStatus(content[contentIndex], contentIndex);
                contentIndex++;
            }
            secondFlag = true;
        }
    
        if (i > count) {
            
            
            // 2,3,4째주 값 기입
            if (secondFlag){
                
                const numTd = document.createElement('td');
                numTd.innerText = i;
                numTd.style.cursor = 'pointer';
                numTd.addEventListener('click', () => showDetailReserve(i));
                secondWeek.appendChild(numTd);
                weekCount--;
            }
            
            if (secondFlag && weekCount == 0){
    
                for (let k = 0; k < 7; k++){
                    createAmPm(secondWeekChoice, contentIndex);
                    setStatus(content[contentIndex], contentIndex);
                    contentIndex++;
                }
    
                secondFlag = false;
                weekCount = 7;
                thirdFlag = true;
                continue;
            }
    
            // 세번째 위크
            if (thirdFlag){
                
                const numTd = document.createElement('td');
                numTd.innerText = i;
                numTd.style.cursor = 'pointer';
                numTd.addEventListener('click', () => showDetailReserve(i));
                thirdWeek.appendChild(numTd);
                weekCount--;
            }
            
            if (thirdFlag && weekCount == 0){
    
                for (let k = 0; k < 7; k++){
                    createAmPm(thirdWeekChoice, contentIndex);
                    setStatus(content[contentIndex], contentIndex);
                    contentIndex++;
                }
    
                thirdFlag = false;
                weekCount = 7;
                fourthFlag = true;
                continue;
            }
    
            // 네번째 위크
            if (fourthFlag){
                
                const numTd = document.createElement('td');
                numTd.innerText = i;
                numTd.style.cursor = 'pointer';
                numTd.addEventListener('click', () => showDetailReserve(i));
                fourthWeek.appendChild(numTd);
                weekCount--;
            }
            
            if (fourthFlag && weekCount == 0){
    
                for (let k = 0; k < 7; k++){
                    createAmPm(fourthWeekChoice, contentIndex);
                    setStatus(content[contentIndex], contentIndex);
                    contentIndex++;
                }
    
                fourthFlag = false;
                weekCount = 7;
                lastFlag = true;
                continue;
            }
    
            // 마지막 위크
            if (lastFlag){

                // 만약 6째주가 생긴다면 
                if(weekCount == 0) {
                    
                    // 한번만 생성되게
                    if (!fifthFlag){
                        for (let k = 0; k < 7; k++){
        
                            createAmPm(lastWeekChoice, contentIndex);
                            setStatus(content[contentIndex], contentIndex);
                            contentIndex++;
                        }
                    }
                    

                    const numTd = document.createElement('td');
                    numTd.innerText = i;
                    numTd.style.cursor = 'pointer';
                    numTd.addEventListener('click', () => showDetailReserve(i));
                    fifthWeek.appendChild(numTd);
                    fifthFlag = true;

                    // weekCount = 7;
                    // lastFlag = false;
                    if (i == lastDate){
    
                        for (let k = 0; k <= lastDay; k++){
                            
                            createAmPm(fifthWeekChoice, contentIndex);
                            setStatus(content[contentIndex], contentIndex);
                            contentIndex++;
                        }
        
                        // 공백 생성
                        for (let j = 0; j < (6 - lastDay) ; j++){
                            const spaceTd = document.createElement('td');
                            const spaceTd2 = document.createElement('td');
                            fifthWeek.appendChild(spaceTd);
                            fifthWeekChoice.appendChild(spaceTd2);
                        }
            
                        weekCount = 7;
                        lastFlag = false;
                        fifthFlag = false;
                        break;
                    }
    
                } else {
                    
                    const numTd = document.createElement('td');
                    numTd.innerText = i;
                    numTd.style.cursor = 'pointer';
                    numTd.addEventListener('click', () => showDetailReserve(i));
                    lastWeek.appendChild(numTd);
                    weekCount--;
                }
                
            }
            
            if (lastFlag && i == lastDate){
    
                for (let k = 0; k <= lastDay; k++){
                    
                    createAmPm(lastWeekChoice, contentIndex);
                    setStatus(content[contentIndex], contentIndex);
                    contentIndex++;
                }

                // 공백 생성
                for (let j = 0; j < (6 - lastDay) ; j++){
                    const spaceTd = document.createElement('td');
                    const spaceTd2 = document.createElement('td');
                    lastWeek.appendChild(spaceTd);
                    lastWeekChoice.appendChild(spaceTd2);
                }
    
                weekCount = 7;
                lastFlag = false;
            }
        }
    
    }
} 

// [상세 예약날짜] 상세 예약날짜 표시 
function showDetailReserve(date){

    //기존자식 삭제 
    deleteDetailTbody();

    // 열기
    const mask2 = document.querySelector('.mask2');
    mask2.className += ' on';

    // daySelect에 option 추가
    let daySelect = document.getElementById('day');
    daySelect.replaceChildren();

    // 선택한 월의 일수만큼 option생성
    for (let i = firstDate; i <= lastDate; i++){

        const dayOption = document.createElement('option');
        dayOption.setAttribute('value', i);

        // 한자릿수 0붙이기
        if (i.toString().length == 1){
            i = '0' + i.toString();
        }

        let setValue = month + '-' + i;

        dayOption.innerText = setValue;
        daySelect.appendChild(dayOption);
    }
    
    // 선택일 표시
    document.querySelectorAll('select[id=day] option')[date - 1].selected = true;

    // [메인] 예약 상세내역 표시
    /**
     *  1. status 먼저 확인 휴진인 경우 휴진 메시지 표시  
     *  2. 예약리스트에서 데이터 추출 
     *  3. 문자열 끝에 R이 있는 경우 예약 되어있음
     *  4. 비어있는거 완성 후 해당하는 것에 넣자 
     *   
     */
    // 전달 받은 데이터 리스트에서 선택한 날짜 객체만 추출
    let selectDayData = responseData[date - 1];

    // 진료시간표 표시 로직
    if(!(selectDayData.amReservOtIdList.length === 0 && selectDayData.pmReservOtIdList.length === 0)) {

        // 오전, 오후 상태 휴진일 경우 return 처리
        if (selectDayData.amStatus == '휴진-진료없음' && selectDayData.pmStatus == '휴진-진료없음') {
            alert('해당날짜는 [휴진-진료없음] 입니다. 다른 날짜를 선택해주세요');
            const detailTbody = document.getElementById('detailTbody');
            // 기존 자식 삭제
            detailTbody.replaceChildren();
            return;
        } else {

            /**
             *  오전, 오후 둘다 상태 존재할 때
             */
            if (selectDayData.amStatus != null && selectDayData.pmStatus != null){
                
                if(selectDayData.amStatus == '정원초과' && selectDayData.pmStatus == '정원초과'){
                    alert('[상세일정 예약여부]\n해당 날짜의 모든 진료예약 시간이 [정원초과]입니다.');
                    return;
                } else if(selectDayData.amStatus == '정상진료' && selectDayData.pmStatus == '휴진-진료없음'){
                    createDetailTrTdAM(selectDayData);   
                    return;
                } else if(selectDayData.amStatus == '정원초과' && selectDayData.pmStatus == '휴진-진료없음'){
                    // 전체 정원초과 인경우에는 메시지 없고 아닌 경우에는 alert 
                    // 메서드 생성
                    validateFullOverReserv(selectDayData, 0);
                    createDetailTrTdAM(selectDayData);   
                    return;
                } else if (selectDayData.amStatus == '휴진-진료없음' && selectDayData.pmStatus == '정상진료') {
                    createDetailTrTdPM(selectDayData); 
                    return;
                } else if (selectDayData.amStatus == '휴진-진료없음' && selectDayData.pmStatus == '정원초과') {
                    validateFullOverReserv(selectDayData, 1);
                    createDetailTrTdPM(selectDayData); 
                    return;
                } else {
                    if(selectDayData.amStatus == '정원초과' || selectDayData.pmStatus == '정원초과') {
                        validateFullOverReserv(selectDayData, 2);
                    }
                    createDetailTrTd(selectDayData);
                }
            } else {
                alert('[상세일정 예약여부]\n오전, 오후 두 시간대 모두 진료 시간이 등록되어야 합니다.\n다시 확인해주세요 ');
            }
        } // 오전, 오후 상태 휴진일 경우 return 처리 분기문 끝
        
    } else {
        deleteDetailTbody();
        alert('[상세일정 예약여부]\n진료 시간표가 등록되지 않은 시간표입니다.');
    }
}


// 전체 정원초과가 아닌 경우 임시 정원초과인 상태 
function validateFullOverReserv(selectDayData, num) {

    let amList = selectDayData.amReservOtIdList;
    let pmList = selectDayData.pmReservOtIdList;

    switch(num) {

        case 0: // 오전 정원초과

            for (let i = 0; i < amList.length; i++){
                // 하나라도 정상진료가 있을 경우 
                let time = amList[i];
                let status = time.substring(12);
                if(status == '&#9679;'){
                    alert("해당 진료예약시간표의 정원초과는 임시정원초과 입니다.\n(임시정원초과 : 현장대기가 너무 많아 예약을 막아놓은 상태)");
                    break;
                }
            }
            break;


        case 1: // 오후 정원초과

            for (let i = 0; i < pmList.length; i++){
                // 하나라도 정상진료가 있을 경우 
                let time = pmList[i];
                let status = time.substring(12);
                if(status == '&#9679;'){
                    alert("해당 진료예약시간표의 정원초과는 임시정원초과 입니다.\n(임시정원초과 : 현장대기가 너무 많아 예약을 막아놓은 상태)");
                    break;
                }
            }
            break;

        case 2: // 오전,오후 정원초과
            
            let amFlag = false;
            let pmFlag = false;

            for (let i = 0; i < amList.length; i++){
                // 하나라도 정상진료가 있을 경우 
                let time = amList[i];
                let status = time.substring(12);
                if(status == '&#9679;'){
                    amFlag = true;
                    break;
                }
            }
            for (let i = 0; i < pmList.length; i++){
                // 하나라도 정상진료가 있을 경우 
                let time = pmList[i];
                let status = time.substring(12);
                if(status == '&#9679;'){
                    pmFlag = true;
                    break;
                }
            }

            // 둘중 하나라도 만족 시 
            if (amFlag || pmFlag){
                alert("해당 진료예약시간표의 정원초과는 임시정원초과 입니다.\n(임시정원초과 : 현장대기가 너무 많아 예약을 막아놓은 상태)");
            }
            break;

    }

}

// [상세 예약날짜] 기존 detailTbody 자식 삭제
function deleteDetailTbody() {
    const detailTbody = document.getElementById('detailTbody');
    // 기존 자식 삭제
    detailTbody.replaceChildren();
}

// [상세 예약날짜] tr & td생성
function createDetailTrTd(selectDayData){

    deleteDetailTbody();

    for (let i = 0; i < 15; i++){

        const tr = document.createElement('tr');
        let count = i;
        let count2 = i;

        for (let j = 0; j < 2; j++){
            const td = document.createElement('td');
            td.setAttribute('colspan', 2);
            let value = selectDayData.amReservOtIdList[count];
            
            if(value != null) {
                td.innerHTML = value;
            }
            
            td.setAttribute('style', 'background-color: white;');
            tr.appendChild(td);
            count += 15;
        }

        for(let k = 0; k < 2; k++){
            const td = document.createElement('td');
            td.setAttribute('colspan', 2);
            let value = selectDayData.pmReservOtIdList[count2];
            
            if(value != null) {
                td.innerHTML = value;
            }
            td.setAttribute('style', 'background-color: white;');
            tr.appendChild(td);
            count2 += 15;
        }

        detailTbody.appendChild(tr);
    }
}
// [상세 예약날짜] 오전만 존재할 때
function createDetailTrTdAM(selectDayData){

    deleteDetailTbody();

    for (let i = 0; i < 15; i++){

        const tr = document.createElement('tr');
        let count = i;

        for (let j = 0; j < 2; j++){

            /**
             *  마지막 td는 colspan 4 rowspan 15
             */
            const td = document.createElement('td');
            td.setAttribute('colspan', 2);
            let value = selectDayData.amReservOtIdList[count];
            
            if(value != null) {
                td.innerHTML = value;
            }
            
            td.setAttribute('style', 'background-color: white;');
            tr.appendChild(td);
            count += 15;
            
            if (count == 30) {
                const td2 = document.createElement('td');
                td2.setAttribute('colspan', 4);
                td2.setAttribute('rowspan', 15);
                td2.innerHTML = '휴진-진료없음';
                td2.setAttribute('style', 'background-color: #E7E8EC;');
                tr.appendChild(td2);
            }
        }

        detailTbody.appendChild(tr);
    }

}
// [상세 예약날짜] 오후만 존재할때
function createDetailTrTdPM(selectDayData){

    deleteDetailTbody();

    for (let i = 0; i < 15; i++){

        const tr = document.createElement('tr');
        let count = i;

        for (let j = 0; j < 2; j++){

            if (count == 0) {
                const td2 = document.createElement('td');
                td2.setAttribute('colspan', 4);
                td2.setAttribute('rowspan', 15);
                td2.innerHTML = '휴진-진료없음';
                td2.setAttribute('style', 'background-color: #E7E8EC;');
                tr.appendChild(td2);
            }


            const td = document.createElement('td');
            td.setAttribute('colspan', 2);
            let value = selectDayData.pmReservOtIdList[count];
            
            if(value != null) {
                td.innerHTML = value;
            }
            td.setAttribute('style', 'background-color: white;');
            tr.appendChild(td);
            count += 15;
            
        }

        detailTbody.appendChild(tr);
    }

}

// [일괄적용 기능] 요일별 날짜 배열 담기 
function createDate(firstDay, lastDate) {

    // 요일별 초기화
    daysReset();

    // 사용 예시
    const basicArray = [1, 2, 3, 4, 5, 6, 7];
    let array = rotateArray(basicArray, firstDay);

    for (let j = 0; j < 4; j++){

        // 첫 배열값 입력
        if (mondays.length == 0){
                
            for(let k = 0; k < array.length; k++){

                days[k].push(array[k]);
            }

        }

        for (let i = 0; i < array.length; i++){

            let value = days[i][j] + 7

            // 마지막 날짜를 넘으면 push X 분기문
            if (value <= lastDate){
                days[i].push(value);
            }
            
        }
    } 

}

// [일괄적용 기능] 요일별 배열 초기화
function daysReset(){

    mondays.splice(0);
    tuesdays.splice(0);
    wednesdays.splice(0);
    thursdays.splice(0);
    fridays.splice(0);
    saturdays.splice(0); 
    sundays.splice(0);
}

// [일괄적용 기능] 배열 회전
function rotateArray(arr, shiftBy) {
    const len = arr.length;
    // 주어진 값을 배열 길이로 나눈 나머지로 제한 (불필요한 회전 방지) 배열의 길이가 넘어 가는 숫자가 들어오면 불필요한회전이 발생 
    shiftBy = shiftBy % len;

    // 뒤쪽에서 값을 앞으로 이동
    return arr.slice(-shiftBy).concat(arr.slice(0, -shiftBy));
}

// 오전, 오후 스케줄 적용 칸 생성
function createAmPm(choiceId, index){

    let td = document.createElement('td');
    let amSelect = document.createElement('select');
    let pmSelect = document.createElement('select');

    amSelect.setAttribute('name', 'amSelect');
    amSelect.setAttribute('class', 'amSelect' + index);
    amSelect.setAttribute('id', 'amSelect' + index);
    amSelect.setAttribute('onchange', 'selectedStatus(this)');
    amSelect.style.marginRight = '5px';

    pmSelect.setAttribute('name', 'pmSelect');
    pmSelect.setAttribute('class', 'pmSelect' + index);
    pmSelect.setAttribute('id', 'pmSelect' + index);
    pmSelect.setAttribute('onchange', 'selectedStatus(this)');

    const amOption0 = document.createElement('option');
    const amOption1 = document.createElement('option');
    const amOption2 = document.createElement('option');
    const amOption3 = document.createElement('option');
    amOption0.setAttribute('value', '0');
    amOption0.innerText = '일괄'
    amOption1.setAttribute('value', '1');
    amOption1.innerHTML = '&#9679;' 
    amOption2.setAttribute('value', '2');
    amOption2.innerHTML = '&#9678;'
    amOption3.setAttribute('value', '3');
    amOption3.innerHTML = '&#9675;'

    amSelect.appendChild(amOption0);
    amSelect.appendChild(amOption1);
    amSelect.appendChild(amOption2);
    amSelect.appendChild(amOption3);


    const pmOption0 = document.createElement('option');
    const pmOption1 = document.createElement('option');
    const pmOption2 = document.createElement('option');
    const pmOption3 = document.createElement('option');
    pmOption0.setAttribute('value', '0');
    pmOption0.innerText = '일괄'
    pmOption1.setAttribute('value', '1');
    pmOption1.innerHTML = '&#9679;'
    pmOption2.setAttribute('value', '2');
    pmOption2.innerHTML = '&#9678;'
    pmOption3.setAttribute('value', '3');
    pmOption3.innerHTML = '&#9675;'

    pmSelect.appendChild(pmOption0);
    pmSelect.appendChild(pmOption1);
    pmSelect.appendChild(pmOption2);
    pmSelect.appendChild(pmOption3);

    choiceId.appendChild(td);
    td.appendChild(amSelect);
    td.appendChild(pmSelect);


}

// 응답받은 결과로 selectd status 설정
function setStatus(content, index) {
    /**
     *  상태가 들어있다면 상태를 selected
     *  아닌 경우에는 그냥 표시
     * 
     *  &#9679 : 정상진료
     *  &#9678 : 휴진-진료없음
     *  &#9675 : 정원초과
     *  
     */
    switch(content.amStatus){

        case null:
            document.querySelectorAll("select[class=amSelect" + index + "] option")[0].selected = true;
        break;
        
        case '정상진료':
            document.querySelectorAll("select[class=amSelect" + index + "] option")[1].selected = true;
        break;

        case '휴진-진료없음':
            document.querySelectorAll("select[class=amSelect" + index + "] option")[2].selected = true;
        break;

        case '정원초과':
            document.querySelectorAll("select[class=amSelect" + index + "] option")[3].selected = true;
        break;
    }

    switch(content.pmStatus){
        
        case null:
            document.querySelectorAll("select[class=pmSelect" + index + "] option")[0].selected = true;
        break;

        case '정상진료':
            document.querySelectorAll("select[class=pmSelect" + index + "] option")[1].selected = true;
        break;

        case '휴진-진료없음':
            document.querySelectorAll("select[class=pmSelect" + index + "] option")[2].selected = true;
        break;

        case '정원초과':
            document.querySelectorAll("select[class=pmSelect" + index + "] option")[3].selected = true;
        break;
    }

}

// 선택한 일 예약 상세 페이지 출력
function selectDay(selectDay) {
    
    showDetailReserve(selectDay.value);
}

// 선택한 연도 달력 출력
function selectYear(){

    // 일괄처리 영역 초기화
    applyBulkReset();

    year = document.getElementById('year').value; // selected
    month = document.getElementById('month').value; // selected
    if (month.length == 1){
        month = '0' + month;
    }
    callDataAndPrintCalendar(selectedDrId, year, month);

}

// 선택한 달 달력 출력
function selectMonth() {

    // 일괄처리 영역 초기화
    applyBulkReset();

    year = document.getElementById('year').value; // selected
    month = document.getElementById('month').value; // selected
    if (month.length == 1){
        month = '0' + month;
    }
    callDataAndPrintCalendar(selectedDrId, year, month);

}

// 선택한 진료시간표 상태 배열에 삽입
function selectedStatus(status) {

    // 값 추출
    let selectedValue = status.options[status.selectedIndex].value; // 선택된 값
    let statusTime = status.id.substring(0, 8); // 오전, 오후 구분
    let selectedIdIndex = status.id.substring(8); // 인덱스 추출

    // 문자로 값 변환
    let value = convertStatusString(selectedValue);

    // 오전
    if(statusTime == 'amSelect'){

        selectedAfterStatus[selectedIdIndex].amStatus = value;

        // 오후
    } else if (statusTime == 'pmSelect') {

        selectedAfterStatus[selectedIdIndex].pmStatus = value;

    }


}

// selectedValue 값 문자열로 변환
function convertStatusString(selectedValue){

    switch(selectedValue) {

        case '0':
        return null;

        case '1':
        return '정상진료';

        case '2':
        return '휴진-진료없음';

        case '3':
        return '정원초과';

    }

}

// 진료시간표 업데이트
function updateCalendar(){

    // 적용 대상이 없는 지 검증
    let validateFlag = validateUpdate();

    if (validateFlag){

        let changeDateList = [];

        // 업데이트 한 내역 배열 담기
        for (let i = 0; i < lastDate; i++){

            let firstStatusAM = responseData[i].amStatus;
            let firstStatusPM = responseData[i].pmStatus;

            let afterStatusAM = selectedAfterStatus[i].amStatus;
            let afterStatusPM = selectedAfterStatus[i].pmStatus;

            let changeDate = createChangeDataObj();        
            changeDate.date = responseData[i].date;

            // AM 체크
            if (firstStatusAM == null && afterStatusAM != null){
            // insert 요청
                changeDate.amInsert = afterStatusAM;
                changeDate.amFlag = true;

            } else if (firstStatusAM != null & afterStatusAM != null) {

                // 첫 데이터 두 번째 데이터 상태 변경 ++ 같은 상태이면 제외
                if (!(firstStatusAM === afterStatusAM)){
                    changeDate.amUpdate = afterStatusAM;
                    changeDate.amFlag = true;
                }
                
            }

            // PM 체크
            if (firstStatusPM == null && afterStatusPM != null){
                changeDate.pmInsert = afterStatusPM;
                changeDate.pmFlag = true;
            // insert 요청

            } else if (firstStatusPM != null & afterStatusPM != null) {
                // 첫 데이터 두 번째 데이터 상태 변경 ++ 같은 상태이면 제외
                if (!(firstStatusPM === afterStatusPM)){
                    changeDate.pmUpdate = afterStatusPM;
                    changeDate.pmFlag = true;
                }

            }

            changeDateList.push(changeDate);

        } // 날짜일수 만큼의 반복문 끝

        // ----------------- 서버에 비동기 요청 처리-------------------------------
        /**
         *  request :  changeDateList, drId 보내기
         *  response : (성공) 성공적으로 반영되었다는 메시지와 다시 캘린더를 출력[기존에 가지고 있던 업데이트 객체리스트를 통해]
         *             (실패) 실패 메시지 내용은 아래
         * 
         *                  변경하고자 하시는 일정에 예약이 존재합니다 예약 일정 수정 후 다시 시도해주세요
                            현 예약 일정 : 
        */
        
        
        fetch('/hospital/hpMemberAdmin/updateSchedule', {

            method : 'POST',
            headers : {'Content-Type' : 'application/json' },
            body : JSON.stringify({

                changeDateList : changeDateList,
                drId : selectedDrId
                
            }),

        })
        .then(response => {

            if(!response.ok) {

                alert("서버 오류입니다 잠시 후에 시도해주세요\n관리자 번호 : 010-8282-5353");
                throw new Error('HTTP ERROR Status : ${response.status}');
            }

            return response.json();

        })
        .then(data => {

            // 전달받은 예약 리스트
            let content = data.content;

            if (data.count == 0){

                // 업데이트 된 배열, 초기 배열로 옮기기
                responseData = JSON.parse(JSON.stringify(selectedAfterStatus));
                callDataAndPrintCalendar(selectedDrId, year, month)
                alert("요청하신 작업이 정상적으로 완료되었습니다.");
            } else {
                
                // 첫 값으로 서버에러 확인
                let firstValue = content[0];

                if (firstValue == "서버에러") {
                    alert("서버 오류입니다 잠시 후에 시도해주세요\n관리자 번호 : 010-8282-5353");
                } else {
                    
                    let reservSchedule = "";

                    for (let i = 0; i < content.length; i++){

                        reservSchedule = reservSchedule + content[i] + "\n";

                    }

                    alert("변경하고자 하시는 일정에 예약이 존재합니다\n예약 일정 수정 후 다시 시도해주세요\n해당 예약 일정 : " + reservSchedule);

                }


            }


        })// 비동기 요청 끝
    } else {
        alert('적용대상이 없습니다 적용 후 다시 시도해주세요.');
    }
} // 함수 끝

// 적용대상이 없는 지 검증
function validateUpdate() {

    let validate = new Set();
    let validateFlag = true;

    for (let i = 0; i < lastDate; i++) {

        let firstStatusAM = responseData[i].amStatus;
        let firstStatusPM = responseData[i].pmStatus;

        let afterStatusAM = selectedAfterStatus[i].amStatus;
        let afterStatusPM = selectedAfterStatus[i].pmStatus;

        if (firstStatusAM == afterStatusAM && firstStatusPM == afterStatusPM){
            validate.add('N');
        } else {
            validate.add('Y');
        }

    }

    if (validate.size == 1){
        validateFlag = false;
    }

    return validateFlag;

}

// 서버에 보낼 업데이트용 객체 생성
function createChangeDataObj () {

    const changeData = new Object();
    changeData.amInsert;
    changeData.amUpdate;
    changeData.amFlag = false;
    changeData.pmInsert;
    changeData.pmUpdate;
    changeData.pmFlag = false;
    changeData.date = null;

    return changeData;
}

// 선택일 전체 일괄처리 
function selectedDayUpdate(day) {

    if(confirm('선택 시 해당 요일에 전체 적용되어집니다\n계속 진행하시겠습니까?')){

        // 선택된 값 추출 상태, 시간타입, 요일
        let chooseStatus = day.options[day.selectedIndex].value;
        let chooseTime = day.id.substring(8, 10);
        let chooseDay = day.id.substring(10);

        // 선택한 요일의 날짜들
        let chooseDays = days[parseInt(chooseDay)];

        // 요일을 꺼냄과 동시에 상태 적용
        for (let i = 0; i < chooseDays.length; i++){

            // 객체배열 인덱스
            let index = chooseDays[i] - 1;
            // 문자로 값 변환
            let value = convertStatusString(chooseStatus);

            /**
             * 1. 상태 변환 배열에 담기 
             * 2. 요일에 맞는 일자별 selected 적용
             */ 
            if(chooseTime == 'AM'){
                selectedAfterStatus[index].amStatus = value;
                setStatus(selectedAfterStatus[index], index);
                
            } else if(chooseTime == 'PM'){
                selectedAfterStatus[index].pmStatus = value;
                setStatus(selectedAfterStatus[index], index);
            }

        }
    } else {
        let reset = day.options;
        reset[0].selected = true;
    }

}

// 전체 일정 초기화 (처음 전달 받았던 일정으로)
function resetCalendar() {

    if(confirm('전체 일정을 초기화 합니다. 계속하시겠습니까?')){

        // 처음 전달받았던 데이터로 리셋
        selectedAfterStatus = JSON.parse(JSON.stringify(responseData));

        // 캘린더 다시 표시
        printCalendar(year, month, responseData);
        // 특정 요일 일괄선택 선택된 표시 리셋
        applyBulkReset();

    }
}

// 특정 요일 일괄선택 선택된 표시 리셋
function applyBulkReset() {

    for (let i = 0; i <= 6; i++){

        let bulkSelectAm = document.getElementById('totalDayAM' + i);
        let bulkSelectPm = document.getElementById('totalDayPM' + i);

        bulkSelectAm.options[0].selected = true;
        bulkSelectPm.options[0].selected = true;
    }
}




