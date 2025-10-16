<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="kor">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../resources/css/default.css" />
	<script src="../resources/js/jquery-1.11.2.min.js"></script>
	<script src="../resources/js/swiper.min.js"></script>
	<script src="../resources/js/design.js"></script>
    <script src="https://kit.fontawesome.com/209bda59e8.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="${pageContext.request.contextPath }/resources/js/userClient/mypage/reservSchedule.js" defer></script>
	<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
</head>

<style>

    /* 공통 */
    ul, ol, li {
        list-style: none;
    }

    /* 폰트 */
    .f_w500{
        font-weight: 500px;
    }

    .f_s15{
        font-size: 15px;
    }

    html, body {width:100%; height:100%; margin:0; padding:0; font-family:'Pretendard', 'Noto Sans Korean', 'Nanum Gothic', Nanum Gothic, '나눔고딕', Dotum, '돋움', Gulim, '굴림',sans-serif; -webkit-text-size-adjust: none;  -moz-text-size-adjust: none;  -ms-text-size-adjust: none; }


    /* 백그라운드 컬러 */

    .bg_13{
        background-color: #F3F4F8;
    }

    /*모달안 달력*/
    .calendar table {
        width: 100%;
        margin-top: 10px;
    }
    .calendar th {
        background-color: rgb(224, 224, 224);
        color: #6c757d;
    }
    .calendar td {
        height: 60px;
        vertical-align: middle;
        cursor: pointer;
    }
    .calendar td:hover {
        background-color: #e9ecef;
    }
    .calendar td.selected {
        background-color: #0d6efd;
        color: white;
    }

    /* 모달 (달력)*/
    .modal-content {
        height: 1100px;
    }

    .modal-header {
        height: 120px;
        flex-direction: column;
        justify-content: space-between;
    }
	.mask_date > select {
		padding-right: 20px;
		background: url(../../images/selectbox.png) no-repeat right center;
		font-weight: 600;
		font-size: 20px;
		color: #202020;
		border: none;
		outline: none;
	}


    /*TABLE*/
    .table_top {

        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 40px;
    }

    .table_top > ul {
        display: flex;
        padding: 12px 20px;
        gap: 20px;
        height: 45px;
    }

    .table_top select {
        margin-right: 50px;
    }

    .modal-header-title {
        width: 100%;
        display: flex;
        justify-content: space-between;
        height: 40px;
    }

    .modal-title {
        margin-left: 15px;
        font-weight: bold;
        font-size: 24px;
    }

	/*TABLE tbody*/
	table > tbody > tr:nth-child(odd) > td {

		width: 157.81px;
		height: 30px;
		background-color: #f8f9fa;
	}
    
	table > tbody > tr:nth-child(even) > td {

		width: 157.81px;
		height: 100px;
	}

</style>

<body>
  
    <div class="btn btn-primary scheduleModal" id="${user.userNum}" data-bs-toggle="modal" data-bs-target="#scheduleModal">
        진료스케줄
    </div>
    
    <!-- Modal -->
    <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="modal-header-title">
                        <h5 class="modal-title" id="scheduleModalLabel">진료 스케줄</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="margin: 0px;"></button>
                    </div>
                    <div class="table_top">
                        <ul class="f_w500 f_s15 bg_13" style="margin-bottom: 0px;">
                            <li>
								<i class="fas fa-solid fa-stethoscope"></i>
								<span class="bul_sche sche01">외래진료</span>
							</li>
                            <li>
								<i class="fa-solid fa-syringe"></i>
								<span class="bul_sche sche02">검사진료</span>
							</li>
                            <li>
								<i class="fa-solid fa-hospital"></i>
								<span class="bul_sche sche03">입원</span>
							</li>
                        </ul>
                        <div class="mask_date">
                            <select id="year" name="year" onchange="selectYear()"></select>
                            <select id="month" class="month" onchange="selectMonth()">
                                <option value="1">01월</option>
                                <option value="2">02월</option>
                                <option value="3">03월</option>
                                <option value="4">04월</option>
                                <option value="5">05월</option>
                                <option value="6">06월</option>
                                <option value="7">07월</option>
                                <option value="8">08월</option>
                                <option value="9">09월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
                       
                    </div>
                </div>
                <div class="modal-body">

                    <!-- 달력 -->
                    <div class="calendar"> 
                        <table class="table table-bordered text-center">
                            <colgroup>
                                <col>
                                <col>
                                <col>
                                <col>
                                <col>
                                <col>
                                <col>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="red" style="color: red;">일</th>
                                    <th>월</th>
                                    <th>화</th>
                                    <th>수</th>
                                    <th>목</th>
                                    <th>금</th>
                                    <th class="blue" style="color:blue">토</th>
                                </tr>
                            </thead>
            
                            <tbody>
            
                                <!-- 첫째주 -->	
                                <tr id="firstWeek" class="bg_13"></tr>
                                <tr id="firstWeekChoice"></tr>
            
                                <!-- 둘째주 -->
                                <tr id="secondWeek" class="bg_13"></tr>
                                <tr id="secondWeekChoice"></tr>
            
                                <!-- 셋째주 -->
                                <tr id="thirdWeek" class="bg_13"></tr>
                                <tr id="thirdWeekChoice"></tr>
            
                                <!-- 넷째주 -->
                                <tr id="fourthWeek" class="bg_13"></tr>
                                <tr id="fourthWeekChoice"></tr>
            
                                <!-- 다섯주 -->
                                <tr id="lastWeek" class="bg_13"></tr>
                                <tr id="lastWeekChoice"></tr>
            
                                <!-- 혹시모를째주 -->
                                <tr id="fifthWeek"  class="bg_13"></tr>
                                <tr id="fifthWeekChoice"></tr>
            
            
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
</body>
</html>