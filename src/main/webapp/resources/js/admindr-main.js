
/* 날짜 변수들  */
let td = new Date();
let year = td.getFullYear();
let month = td.getMonth() + 1;
// 한자릿수 0 붙이기
let date = td.getDate();
// 요일 배열
const days = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];

// 오늘 날짜와 요일
if (month.toString().length == 1){
    month = '0' + month.toString();
}

let today = year + '-' + month + '-' + date;
let day = days[td.getDay()];

/* 고객의 소리 이미지  */
const lineWidth = 35;
const canvasWidth = 300; // Actual canvas size
const canvasHeight = 150; // Half height for doughnut
const radiusDoughnut = canvasWidth / 2 - lineWidth;
const canvas = document.getElementById('doughnutCanvas');
const ctx = canvas.getContext('2d');


window.onload = function () {

    // 오늘 날짜 동적삽입
    document.getElementById('today').innerHTML = today;
    document.getElementById('day').innerHTML = day;
    
    // console.log('------ graphList ------');
    // console.log(graphList);
    // console.log(typeof graphList);
    

    // 고객의 소리 반원형 생성
	drawDoughnut(ctx, qnaPercent);
    // 예약 게이지 생성
    createReservBar(reservPercentDay, reservPercentMonth);
    // 내 위치 확인 및 날씨 API호출
    callWeather();
    // 그래픽 게이지 생성 2025년꺼만
    graphSizeControl(undefined, graphList);
    
}


// 날씨 API 호출
function callWeatherAPI(lat, lon) {

    fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&units=metric&lang=kr&appid=bef119771ad328891babad432d595f2e`)
    .then(response => {

        if (!response.ok){
            throw new  Error('날씨 정보를 불러올 수 없습니다 ' + response.status);
        }

        return response.json();
    })
    .then(data => {

        const temp = document.querySelector(".temp");
        const status = document.querySelector(".status");
        const weatherImg = document.querySelector(".weatherImg");

        temp.textContent = `기온 : ${data.main.temp}`;
        status.textContent = `상태 : ${data.weather[0].description}`;

        const iconURL = `http://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png`
        weatherImg.setAttribute('src', iconURL);

    })

}

// 내 위치 확인 및 날씨 API호출
function callWeather() {

    const status = document.querySelector(".status");

    status.textContent = "";

    function success(position) {
        let lat = position.coords.latitude; // 위도
        let lon = position.coords.longitude; // 경도

        console.log('lat : ' + lat + ' lon : ' + lon);

        // 소수점 둘째자리 까지만
        lat = lat.toFixed(2);
        lon = lon.toFixed(2);

        callWeatherAPI(lat, lon);

    }

    function error() {
        alert("현재 위치를 가져올 수 없음");
    }

    if (!navigator.geolocation) {
        alert("브라우저가 위치 정보를 지원하지 않음");
    } else {
        status.textContent = "위치 파악 중…";
        navigator.geolocation.getCurrentPosition(success, error);
    }
    
}

// 고객의 소리 반원형 및 퍼센트 텍스트 생성
function drawDoughnut(ctx, percentage) {
    const centerX = canvasWidth / 2;
    const centerY = canvasHeight;

    // Clear canvas
    ctx.clearRect(0, 0, canvasWidth, canvasHeight);

    // Calculate angles
    const totalAngle = Math.PI; // Half circle
    const leftAngle = totalAngle * percentage;
    const rightAngle = totalAngle * (1 - percentage);

    // Draw left part
    ctx.lineWidth = lineWidth;
    ctx.strokeStyle = '#436DFF';
    ctx.beginPath();
    ctx.arc(centerX, centerY, radiusDoughnut, Math.PI, Math.PI + leftAngle);
    ctx.stroke();

    // Draw right part
    ctx.strokeStyle = '#FF9E9E';
    ctx.beginPath();
    ctx.arc(centerX, centerY, radiusDoughnut, Math.PI + leftAngle, Math.PI + leftAngle + rightAngle);
    ctx.stroke();

    let result = percentage * 100.0;
    result = result + "%";
    
    const styleSheets = document.styleSheets;
    for (const sheet of styleSheets) {
        try {
          const rules = sheet.cssRules;
          for (const rule of rules) {
            // ::after 규칙인지 확인
            if (rule.selectorText === '.con01_graghbox::after') {
              // 3. content 값을 변수로 변경
              rule.style.content = `"${result}"`; // 변수 삽입
            }
          }
        } catch (e) {
          console.warn('Error accessing stylesheet:', e);
        }
      }

}

// 예약 게이지 생성
function createReservBar(reservPercentDay, reservPercentMonth){

    let showBar = document.querySelector('.showBar');
    let noShowBar = document.querySelector('.noShowBar');
    let reservBarMonth = document.querySelector('.reservBarMonth');
    let noShowBarMonth = document.querySelector('.noShowBarMonth');

    // 데이
    if (reservPercentDay === '100'){
        showBar.style.borderRadius = "10px 10px 10px 10px"; 
        showBar.style.width = "100%"; 
        noShowBar.style.display = "none"; 
    } else if(reservPercentDay === '0'){
        noShowBar.style.borderRadius = "10px 10px 10px 10px"; 
        noShowBar.style.width = "100%"; 
        showBar.style.display = "none"; 
    } else {

        let noShowPer = (100 - parseInt(reservPercentDay)).toString();
        showBar.style.width = reservPercentDay + "%"; 
        noShowBar.style.width = noShowPer + "%"; 
    }

    // 월
    if (reservPercentMonth === '100'){
        reservBarMonth.style.borderRadius = "10px 10px 10px 10px"; 
        reservBarMonth.style.width = "100%"; 
        noShowBarMonth.style.display = "none"; 
    } else if(reservPercentMonth === '0'){
        noShowBarMonth.style.borderRadius = "10px 10px 10px 10px"; 
        noShowBarMonth.style.width = "100%"; 
        reservBarMonth.style.display = "none"; 
    } else {

        let noShowPer = (100 - parseInt(reservPercentMonth)).toString();
        reservBarMonth.style.width = reservPercentMonth + "%"; 
        noShowBarMonth.style.width = noShowPer + "%"; 
    }


}

// 그래픽 사이즈 조절
function graphSizeControl(me, dto){

    resetColor();
    console.log("--- this ---");
    console.log(me);

    if (me != undefined){
        me.style.backgroundColor = '#fff';
        me.style.color = '#486DFF';
        me.style.border = '1px solid';
    }

    // substr 통해 배열 생성
    let monthArrays = createMonthArrays(dto);

    const styleSheets = document.styleSheets;

    for (const sheet of styleSheets) {
        try {
            const rules = sheet.cssRules;
            for (const rule of rules) {
                // ::after 규칙인지 확인
                for (let i = 1; i <= monthArrays.length; i++){
                    let name = '.sty';
                    // 자릿수에 따른 0
                    if (i < 10) {
                        name = name + '0' + i + '::after';
                    } else {
                        name = name + i + '::after';
                    }
                    
                    if (rule.selectorText === name) {
                        // 배열 카운트값 대입
                        let heightValue = parseInt(monthArrays[i - 1]) * 51;
                        rule.style.height = heightValue + 'px'; // 변수 삽입
                    }
                }   

            }
        } catch (e) {
          console.warn('Error accessing stylesheet:', e);
        }
    }


}

// 선택 시 전에 적용된 색깔 초기화 
function resetColor(){

    const chartBtns = document.querySelectorAll('.chart_btn');
    for (let chartBtn of chartBtns){

        chartBtn.style.backgroundColor = '#486DFF';
        chartBtn.style.color = '#fff';
        chartBtn.style.border = '0px';
    }
}

// 월 Cnt 배열 생성
function createMonthArrays(dto){

    let valueArrays = []

    for (let i = 1; i <= 12; i++){

        let index = dto.indexOf('month' + i);

        let value = 0;

        // 자릿수에 따른 인덱스 차이
        if(i >= 10){
            value = dto.substr(index + 8, 1);            
        } else {
            value = dto.substr(index + 7, 1);
        }

        valueArrays.push(value);
        
    }
    
    return valueArrays;

}