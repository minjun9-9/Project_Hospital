let userNum; // 캘린더 모양 클릭 시 자동주입
let responseData; // 응답받은 객체리스트

let firstDate; // 월 시작일
let lastDate; // 월 마지막일
let basicDate; // '연-월'
let year; // 선택한 연도
let month; // 선택할 달


// 캘린더 모양 클릭시 발생
$('.scheduleModal').click(function(){

    userNum = $(this).attr("id");
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

    callDataAndPrintCalendar(userNum, year, month);

})


// 서버에 진료시간표 데이터 요청
function callDataAndPrintCalendar(userNum, year, month){

    basicDate = year + '-' + month;

    // 비동기
    fetch('/hospital/mypage/findSchedule', {

        method : 'POST',
        headers : {'Content-Type' : 'application/json'},
        body : JSON.stringify({
 
            userNum : userNum,
             date : basicDate
 
        }),
 
     })
     // 결과확인
     .then(response => {
 
         if (!response.ok){
             throw new Error('HTTP ERROR Status : ${response.status}');
             alert("서버 오류입니다 잠시 후에 시도해주세요\n관리자 번호 : 010-8282-5353");
         }
 
         return response.json();
 
     })
 
     .then(data => {
         
        responseData = data.content;

        printCalendar(year, month, responseData);
     })

}

// 캘린더 출력
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

                createTime(firstWeekChoice, content[contentIndex]);
                contentIndex++;
            }
            secondFlag = true;
        }
    
        if (i > count) {
            
            
            // 2,3,4째주 값 기입
            if (secondFlag){
                
                const numTd = document.createElement('td');
                numTd.innerText = i;
                secondWeek.appendChild(numTd);
                weekCount--;
            }
            
            if (secondFlag && weekCount == 0){
    
                for (let k = 0; k < 7; k++){
                    createTime(secondWeekChoice, content[contentIndex]);
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
                thirdWeek.appendChild(numTd);
                weekCount--;
            }
            
            if (thirdFlag && weekCount == 0){
    
                for (let k = 0; k < 7; k++){
                    createTime(thirdWeekChoice, content[contentIndex]);
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
                fourthWeek.appendChild(numTd);
                weekCount--;
            }
            
            if (fourthFlag && weekCount == 0){
    
                for (let k = 0; k < 7; k++){
                    createTime(fourthWeekChoice, content[contentIndex]);
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
        
                            createTime(lastWeekChoice, content[contentIndex]);
                            contentIndex++;
                        }
                    }
                    

                    const numTd = document.createElement('td');
                    numTd.innerText = i;
                    fifthWeek.appendChild(numTd);
                    fifthFlag = true;

                    // weekCount = 7;
                    // lastFlag = false;
                    if (i == lastDate){
    
                        for (let k = 0; k <= lastDay; k++){
                            
                            createTime(fifthWeekChoice, content[contentIndex]);
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
                    lastWeek.appendChild(numTd);
                    weekCount--;
                }
                
            }
            
            if (lastFlag && i == lastDate){
    
                for (let k = 0; k <= lastDay; k++){
                    
                    createTime(lastWeekChoice, content[contentIndex]);
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

// 오전, 오후 스케줄 적용 칸 생성
function createTime(choiceId, content){

    // 넣고자 하는 곳
    let td = document.createElement('td');
    let timeList = content.timeList;

    // timelist가 존재할 때 
    if(!(timeList.length === 0)) {
        // 예약배열 길이 만큼
        for (let i = 0; i < timeList.length; i++) {
            
            const icon = document.createElement('i');
            icon.setAttribute('class', 'fas fa-solid fa-stethoscope');
            icon.setAttribute('aria-hidden', 'false');
            td.appendChild(icon);
            
            const text = document.createTextNode('외래진료 ' + timeList[i]);
            td.appendChild(text);
            
            // 마지막 데이터 줄바꿈 제외 
            if(i != timeList.length - 1){
                td.appendChild(document.createElement('br'));
            }
        }

    }
    choiceId.appendChild(td);

}

// 선택한 연도 달력 출력
function selectYear(){

    year = document.getElementById('year').value; // selected
    month = document.getElementById('month').value; // selected
    if (month.length == 1){
        month = '0' + month;
    }
    callDataAndPrintCalendar(userNum, year, month);

}

// 선택한 달 달력 출력
function selectMonth() {

    year = document.getElementById('year').value; // selected
    month = document.getElementById('month').value; // selected
    if (month.length == 1){
        month = '0' + month;
    }
    callDataAndPrintCalendar(userNum, year, month);

}




