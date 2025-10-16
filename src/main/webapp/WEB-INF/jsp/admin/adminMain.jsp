<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="0">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/top-right.css" />
	<script>
		let qnaPercent = '${qnaCntdto.qnaPercent}';	
		let graphList = "${userCntGraphdto.graphList[0]}";
		let reservPercentDay = "${reservDto.d_DayNoShowPercent}"
		let reservPercentMonth = "${reservDto.d_MonthNoShowPercent}"
	</script>
	<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/design.js"></script>
	<title>관리자 메인</title>	
	<style>

	.con01_graghbox::after	{
		content: '';
		color: #202020;
		font-size: 18px;
		font-weight: 700;
		position: absolute;
		bottom: 0;
		left: 50%;
		transform: translateX(-50%);
		display: inline-block;
		width: 41px;
		height: 20px;
	}

	.sty01::after {
		height: 0px;
	}
	.sty02::after {
		height: 0px;
	}
	.sty03::after {
		height: 0px;
	}
	.sty04::after {
		height: 0px;
	}
	.sty05::after {
		height: 0px;
	}
	.sty06::after {
		height: 0px;
	}
	.sty07::after {
		height: 0px;
	}
	.sty08::after {
		height: 0px;
	}
	.sty09::after {
		height: 0px;
	}
	.sty10::after {
		height: 0px;
	}
	.sty11::after {
		height: 0px;
	}
	.sty12::after {
		height: 0px;
	}

	</style>
</head>
<body>
<div class="body_wrap">
	
	<!-- 사이드바 -->
	<%@ include file="WEB-INF/../../common/sidebar.jspf"%>
	

	<!-- 메인 컨텐츠 -->
	<div class="content">
		<!-- 탑바 -->
		<div class="top_bar bg_w">
			<a href="#" class="top_left doctor_con"><span>메인페이지</span></a>

			<!-- 탑바 컨텐츠 -->
			<%@ include file="WEB-INF/../../common/topbarContent.jspf"%>
			

		</div> <!-- top bar -->


		<!-- content시작 -->
		<div class="con_wrap bg_13">
			<div class="main">
				<!-- left/right -->
				<!-- left - today/total -->
				<div class="main_left">

					<!-- today bar -->
					<div class="main_today bg_w">
						<div class="noti date bg_8">
							<p class="today_tit c_3 f_s15 f_w500">today</p>
							<span id="today" class="date_bold c_b f_s20 f_w700"></span>
							<p id="day" class="today_txt c_3">${day}</p>
						</div>
						<div class="noti date bg_8">
							<p class="today_tit c_3 f_s15 f_w500">오늘의 날씨</p>
							<div style="display: flex;">
								<div style="margin-right: 20px;">
									<p id="day" class="today_txt c_3 f_w700 temp" style="color: black;"></p>
									<p id="day" class="today_txt c_3 f_w700 status" style="color: black;"></p>	
								</div>
								<div style="padding-left: 30px; padding-bottom: 30px;">
									<img class="weatherImg" style="width: 80px; height: 80px; background-color: white;" />
								</div>
							</div>
							
						</div>
						<div class="noti bor_2">
							<p class="today_tit c_3 f_s15 f_w500">새로운 게시글</p>
							<span class="today_bold f_w800 c_b">${allBoardCnt.get("today")}</span>
							<p class='today_txt ${allBoardCnt.get("className")}'><span>어제보다 ${allBoardCnt.get("text")} ${allBoardCnt.get("differ")}개</span></p>
							<!-- 개수 적으면 red -->
						</div>
						<div class="noti my_page bor_2">
							<p class="today_tit c_3 f_s15 f_w500">나의 활동</p>
							<span href="#" class="today_bold option f_w800 c_b">${resultDto.adminName}${resultDto.drName}님</span>
							<p href="#" class="today_txt c_b"><span>내가 쓴 글</span> <em class="f_w600">-개</em></p>
						</div>
					</div>  <!-- today -->
					

					<!-- total -->
					<div class="main_total bg_w" style="padding: 20px;">
						<!-- 01 - 고객의 소리 -->
						<div class="total_con total01">
							<p class="total_tit">이번 달 고객의 소리</p>
							<ul class="total01_ul">
								<li>
									<div class="li01_con bg_w bor_2">
										<div class="con_txt1">
											<p class="f_s16 f_w600">접수 / <span class="c_4">처리</span></p>
											<p id="totalCnt" class="f_s16 f_w700 c_b">${qnaCntdto.totalcnt}/<span id="completeCnt" class="c_4">${qnaCntdto.completecnt}</span>
											</p>
										</div>
										<div class="con01_graghbox">
											<canvas id="doughnutCanvas" width="300" height="150" alt="고객의 소리 접수/처리 69%"></canvas>
											<!-- <img src="${pageContext.request.contextPath }/resources/images/total01_gragh.png" alt="고객의 소리 접수/처리 69%"> -->
										</div>
									</div>
								</li>
									
								<!-- 고객접수 내용 반복문 -->
								<c:set var="list" value="${qnaCntdto.qnaDescThird }" />
								<c:forEach var="dto" items="${list}">
									<li class="bor_2">
										<a href="#">
											<div class="li_tit">
												<p class="f_w600 c_b f_s15"><span class="${dto.replyClass}">${dto.reply }</span>${dto.userName }</p>
												<span id="time1" class="time c_78 f_s15 f_w600">${dto.dateTime}</span>
											</div>
											<p class="li_txt f_s15 f_w500 c_78">${dto.content }</p>
										</a>
									</li>
								</c:forEach>
								 
							</ul>
							<!-- 답변 등록하는 곳으로 연결링크 -->
							<a href="#" class="btn01">전체보기</a>
						</div> <!-- 01 - 고객의 소리 -->

						<!-- 02 - 회원가입수/게시글바로가기 -->
						<div class="total_con total02" style="margin-left: 70px;">
							<p class="total_tit">회원가입수</p>
							<div class="sign bor_4">
								<ul>
									<li class="sign_today bor_4">
										<span class="c_b f_s16 f_w500">오늘</span>
										<p class="f_w800">${userCntGraphdto.todayCnt}</p>
									</li>
									<li>
										<span class="c_78 f_w500 f_s16">이번달</span>
										<p class="c_78 f_w500">${userCntGraphdto.monthCnt}</p>
									</li>
								</ul>
								<p class="c_5 f_s15 f_w500">전체 <span class="c_b">${userCntGraphdto.totalCnt}명</span></p>
							</div> <!-- 회원가입수 -->
							<!-- 게시글 바로가기 -->
							<p class="total_tit">게시글 바로가기</p>
							<div class="gallery_wrap">
								<div class="gallery">
									<div class="gal_top bg_3 f_w500 f_s15">
										<p>게시판</p>
										<span>새글/이번달</span>
									</div>
									<div class="gal_bot bg_4">
										<ul class="f_s16 f_w600">
											<li class="on"><a href="#">QnA 게시판<span class="f_w500 bor_2"><em>${qnaCntMap.get("TODAY_CNT")} </em>/${qnaCntMap.get("MONTH_CNT")}</span></a></li>
											<li><a href="${pageContext.request.contextPath }/health/diseaseBoardManagePage">건강자료실<span class="f_w500 bor_2"><em>${healthCntMap.get("TODAY_CNT")} </em>/${healthCntMap.get("MONTH_CNT")}</span></a></li>
											<li><a href="#">검사 수술 정보<span class="f_w500 bor_2"><em>${examCntMap.get("TODAY_CNT")} </em>/${examCntMap.get("MONTH_CNT")}</span></a></li>
											<li><a href="#">질병정보<span class="f_w500 bor_2"><em>${diseaseCntMap.get("TODAY_CNT")} </em>/${diseaseCntMap.get("MONTH_CNT")}</span></a></li>
										</ul>
									</div>
								</div>
							</div> <!-- 게시글 바로가기 -->

						</div> <!-- 02 - 회원가입수/게시글바로가기 -->
							
						<!-- 03 - 그래프로 보기 -->
						<div class="total_con total03" style="margin-left: 70px;">
							<!-- 그래프로 보기 -->
							<p class="total_subtit">그래프로 보기</p>
							<div class="chart_stick">
								<!-- 최근 연도별 -->
								<div class="stick_wrap chrat01 on">
									<c:set var="list" value="${userCntGraphdto.graphList}" />
									<c:forEach var="dto" items="${list }">
										<p class="chart_btn bg_9 f_w500 c_78" onclick="graphSizeControl(this, '${dto}')" style="cursor: pointer;">${dto.year }</p>
									</c:forEach>
									<!-- 차트 세로 -->
									<div class="chart_bg">
										<ul class="c_78 f_w400">
											<li>10</li>
											<li>7.5</li>
											<li>5</li>
											<li>2.5</li>
											<li>0</li>
										</ul>
									</div>  <!-- 차트 세로 -->
									<!-- 차트 가로 -->
									<div class="chart_con">
										<ul>
											<li class="sty01">01</li>
											<li class="sty02">02</li>
											<li class="sty03">03</li>
											<li class="sty04">04</li>
											<li class="sty05">05</li>
											<li class="sty06">06</li>
											<li class="sty07">07</li>
											<li class="sty08">08</li>
											<li class="sty09">09</li>
											<li class="sty10">10</li>
											<li class="sty11">11</li>
											<li class="sty12">12</li>
										</ul>
									</div> <!-- 차트 가로 -->
								</div> <!-- 최근 연도별 1 -->
							</div> <!-- 그래프로 보기 -->
						</div>  <!-- 03 - 그래프로 보기 -->
					</div> <!-- total -->
				</div> <!-- left - today/total -->


				<!-- right -예약/예약 접수 확인 -->
				<div class="main_right">
					<!-- 예약 -->
					<p class="total_tit bul_plus">예약 횟수</p>
					<div class="tab_sty02 bor_4">
						<ul class="sty02_btn">
							<li class="on"><a href="#">오늘</a></li>
							<li><a href="#">이번달</a></li>
						</ul>
						<!-- 오늘예약 -->
						<div class="sty02_con on">
							<p class="num f_w800">${reservDto.todayReservCnt}회</p>
							<div class="chart_box">
								<p class="f_s18 f_w600">방문율 <span class="c_b">${reservDto.d_DayNoShowPercent}%</span></p>
								<div class="chart">
									<span class="blue bg_10 showBar"></span>
									<span class="red bg_12 noShowBar"></span>
								</div>
							</div>
							<ul>
								<li>
									<p class="f_s14 f_w400"></span>오늘 예약</p>
									<p class="c_b f_w700">${reservDto.d_DayReservCnt}</p>
								</li>
								<li>
									<p class="f_s14 f_w400"><span class="bg_11"></span>방문</p>
									<p class="c_b f_w700">${reservDto.d_DayShowCnt}</p>
								</li>
								<li>
									<p class="f_s14 f_w400"><span class="bg_12"></span>부재</p>
									<p class="c_b f_w700">${reservDto.d_DayNoShowCnt}</p>
								</li>
							</ul>
						</div> <!-- 오늘예약 -->
						
						<!-- 이번달 예약 -->
						<div class="sty02_con">
							<p class="num f_w800">${reservDto.monthReservCnt}회</p>
							<div class="chart_box">
								<p class="f_s18 f_w600">방문율 <span class="c_b">${reservDto.d_MonthNoShowPercent}%</span></p>
								<div class="chart">
									<span class="green bg_11 reservBarMonth"></span>
									<span class="red bg_12 noShowBarMonth"></span>
								</div>
							</div>
							<ul>
								<li>
									<p class="f_s14 f_w400"></span>이번달 예약</p>
									<p class="c_b f_w700">${reservDto.d_MonthReservCnt}</p>
								</li>
								<li>
									<p class="f_s14 f_w400"><span class="bg_11"></span>방문</p>
									<p class="c_b f_w700">${reservDto.d_MonthShowCnt}</p>
								</li>
								<li>
									<p class="f_s14 f_w400"><span class="bg_12"></span>부재</p>
									<p class="c_b f_w700">${reservDto.d_MonthNoShowCnt}</p>
								</li>
							</ul>
						</div> <!-- 이번달 예약 -->
					</div>
					<!-- 예약접수 확인 -->
					<p class="total_tit">예약 접수 확인</p>
					<ul class="check">
						<!-- 반복문 -->
						<c:forEach var="dto" items="${reservDto.reservPhoneAndTime }">
							<li>
								<a href="#" class="submit">
									<span>예약</span>
									<p>${dto.get("USER_PHONE_NUM")}</p><em>${dto.get("time")}</em>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div> <!-- right -빠른 예약/예약 접수 확인 -->

			</div> 		<!-- content main -->
		</div> 		<!-- content wrap -->
		<div class="footer bg_13 f_s15">2025 ITWIll Medical Center All right Reserved.</div>
	</div>
</div>



<script src="${pageContext.request.contextPath }/resources/js/admindr-main.js"></script>
</body>
</html>