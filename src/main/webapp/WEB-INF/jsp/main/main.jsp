<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css" />
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/design.js"></script>
<!-- src/main/webapp/resources/css -->
</head>
<body>
<div class="body_wrap">

		<%@include file="/resources/common/menu.jspf" %>
		
		<div class="content">
			<div class="top_bar bg_w">
				<a href="#" class="top_left home" target="_blank">
					<span>한양대학교 병원 바로가기</span>
				</a>
				<div class="top_right">
					<a href="#" class="option"><img src="${pageContext.request.contextPath}/resources/images/top_option.png" alt="option"></a>
					<a href="#">
						<!-- title -->
						<c:set var="name" value="${admin.adminName }" />
						<span class="profile bg_5 f_s20">${fn:substring(name, 0, 1)}</span>
						<%-- <span class="name c_2 f_s15">${admin.adminName }님</span> --%>
						<span class="name c_2 f_s15">${name } 님</span>
					</a>
				</div>
			</div>
			<div class="con_wrap bg_13">
				<!-- content시작 -->
				<div class="main">
					<!-- left/right -->
					<!-- left - today/total -->
					<div class="main_left">
						<!-- today -->
						<div class="main_today bg_w">
							<div class="noti date bg_8">
								<p class="today_tit c_3 f_s15 f_w500">today</p>
								<span class="date_bold c_b f_s20 f_w700">2023-02-10</span>
								<p class="today_txt c_3">월요일</p>
							</div>
							<div class="noti bor_2">
								<p class="today_tit c_3 f_s15 f_w500">홈페이지 접속</p>
								<span class="today_bold f_w800 c_b">15,098명</span>
								<p class="today_txt today_red c_r"><span>어제보다 - 150명</span></p>
							</div>
							<div class="noti bor_2">
								<p class="today_tit c_3 f_s15 f_w500">새로운 게시글</p>
								<span class="today_bold f_w800 c_b">83</span>
								<p class="today_txt today_green c_g"><span>어제보다 + 12개</span></p>
							</div>
							<div class="noti bor_2">
								<p class="today_tit c_3 f_s15 f_w500">칭찬합시다</p>
								<span class="today_bold f_w800 c_b">12</span>
								<p class="today_txt today_green c_g"><span>어제보다 + 1개</span></p>
							</div>
							<div class="noti my_page bor_2">
								<p class="today_tit c_3 f_s15 f_w500">나의 활동</p>
								<span href="#" class="today_bold option f_w800 c_b">홍길동님</span>
								<p href="#" class="today_txt c_b"><span>내가 쓴 글</span> <em class="f_w600">58개</em></p>
							</div>
						</div>
						<!-- total -->
						<div class="main_total bg_w">
							<!-- 01 - 고객의 소리 -->
							<div class="total_con total01">
								<p class="total_tit">고객의 소리</p>
								<ul class="total01_ul">
									<li>
										<div class="li01_con bg_w bor_2">
											<div class="con_txt1">
												<p class="f_s16 f_w600">접수 / <span class="c_4">처리</span></p>
												<p class="f_s16 f_w700 c_b">15 / <span class="c_4">9</span>
												</p>
											</div>
											<div class="con01_graghbox">
												<img src="${pageContext.request.contextPath}/resources/images/total01_gragh.png" alt="고객의 소리 접수/처리 69%">
											</div>
										</div>
									</li>
									<li class="bor_2">
										<a href="#">
											<div class="li_tit">
												<p class="f_w600 c_b f_s15"><span class="submit">접수</span>오지현</p>
												<span class="time c_78 f_s15 f_w600">7분전</span>
											</div>
											<p class="li_txt f_s15 f_w500 c_78">대장암 환자에게 유산균이 도움 될까요. 누구에게 문의를 하면 될지 몰라
												이곳에 대장암 환자에게 유산균이 도움 될까요. 누구에게 문의를 하면 될지 몰라 이곳에</p>
										</a>
									</li>
									<li class="bor_2">
										<a href="#">
											<div class="li_tit">
												<p class="f_w600 c_b f_s15"><span class="check">답변완료</span>오지현</p>
												<span class="time c_78 f_s15 f_w600">7분전</span>
											</div>
											<p class="li_txt f_s15 f_w500 c_78">대장암 환자에게 유산균이 도움 될까요. 누구에게 문의를 하면 될지 몰라
												이곳에 대장암 환자에게 유산균이 도움 될까요. 누구에게 문의를 하면 될지 몰라 이곳에</p>
										</a>
									</li>
									<li class="bor_2">
										<a href="#">
											<div class="li_tit">
												<p class="f_w600 c_b f_s15"><span class="no_check">미처리</span>오지현</p>
												<span class="time c_78 f_s15 f_w600">7분전</span>
											</div>
											<p class="li_txt f_s15 f_w500 c_78">대장암 환자에게 유산균이 도움 될까요. 누구에게 문의를 하면 될지 몰라
												이곳에 대장암 환자에게 유산균이 도움 될까요. 누구에게 문의를 하면 될지 몰라 이곳에</p>
										</a>
									</li>
								</ul>
								<a href="#" class="btn01">전체보기</a>
							</div>
							<!-- 02 - 회원가입수/인기검색어 -->
							<div class="total_con total02">
								<p class="total_tit">회원가입수</p>
								<div class="sign bor_4">
									<ul>
										<li class="sign_today bor_4">
											<span class="c_b f_s16 f_w500">오늘</span>
											<p class="f_w800">57</p>
										</li>
										<li>
											<span class="c_78 f_w500 f_s16">이번달</span>
											<p class="c_78 f_w500">1,700</p>
										</li>
									</ul>
									<p class="c_5 f_s15 f_w500">전체 <span class="c_b">1,981,974명</span></p>
									<a href="#" class="f_s16 f_w600 c_4">회원 전체보기</a>
								</div>
								<p class="total_tit">인기검색어</p>
								<div class="tab_sty01">
									<div class="tab_li01 on">
										<p class="tab_btn01 bor_4">오늘 TOP 10</p>
										<div class="tab_con01">
											<ul class="f_s16 f_w500">
												<li class="on"><a href="#"><span>1</span>
														<p>척추측만증</p>
													</a></li>
												<li><a href="#"><span>2</span>
														<p>편두통</p>
													</a></li>
												<li><a href="#"><span>3</span>
														<p>가정의학과</p>
													</a></li>
												<li><a href="#"><span>4</span>
														<p>대상포진</p>
													</a></li>
												<li><a href="#"><span>5</span>
														<p>휴무일자</p>
													</a></li>
											</ul>
										</div>
									</div>
									<div class="tab_li01">
										<p class="tab_btn01 bor_4">금주 TOP 10</p>
										<div class="tab_con01">
											<ul class="f_s16 f_w500">
												<li class="on"><a href="#"><span>1</span>예시01</a></li>
												<li><a href="#"><span>2</span>예시02</a></li>
												<li><a href="#"><span>3</span>예시03</a></li>
												<li><a href="#"><span>4</span>예시04</a></li>
												<li><a href="#"><span>5</span>예시05</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<!-- 03 - 그래프로 보기/게시글바로가기 -->
							<div class="total_con total03">
								<p class="total_subtit">그래프로 보기</p>
								<div class="chart_stick">
									<a class="chart_a c_b f_w500 bor_4" href="#">회원가입 분석</a>
									<div class="stick_wrap chrat01 on">
										<p class="chart_btn bg_9 f_w500 c_78">2023</p>
										<div class="chart_bg">
											<ul class="c_78 f_w400">
												<li>10</li>
												<li>7.5</li>
												<li>5</li>
												<li>2.5</li>
												<li>0</li>
											</ul>
										</div>
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
										</div>
									</div>
									<div class="stick_wrap chrat02">
										<p class="chart_btn bg_9 f_w500 c_78">2022</p>
										<div class="chart_bg">
											<ul class="c_78 f_w400">
												<li>예시2</li>
												<li>7.5</li>
												<li>5</li>
												<li>2.5</li>
												<li>0</li>
											</ul>
										</div>
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
										</div>
									</div>
									<div class="stick_wrap chrat03">
										<p class="chart_btn bg_9 f_w500 c_78">2021</p>
										<div class="chart_bg">
											<ul class="c_78 f_w400">
												<li>예시3</li>
												<li>7.5</li>
												<li>5</li>
												<li>2.5</li>
												<li>0</li>
											</ul>
										</div>
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
										</div>
									</div>
								</div>
								<p class="total_tit">게시글 바로가기</p>
								<div class="gallery_wrap">
									<div class="gallery">
										<div class="gal_top bg_3 f_w500 f_s15">
											<p>게시판</p>
											<span>새글/이번달</span>
										</div>
										<div class="gal_bot bg_4">
											<ul class="f_s16 f_w600">
												<li class="on"><a href="#">Hihy 건강저장소<span class="f_w500 bor_2"><em>4
															</em>/ 145</span></a></li>
												<li><a href="#">건강자료실<span class="f_w500 bor_2"><em>7 </em>/
															188</span></a></li>
												<li><a href="#">검사 수술 정보<span class="f_w500 bor_2"><em>17 </em>/
															128</span></a></li>
												<li><a href="#">질병정보<span class="f_w500 bor_2"><em>3 </em>/
															388</span></a></li>
												<li><a href="#">임상실험 공고<span class="f_w500 bor_2"><em>1 </em>/
															68</span></a></li>
											</ul>
										</div>
									</div>
									<div class="gallery">
										<div class="gal_top bg_3 f_w500 f_s15">
											<p>게시판</p>
											<span>새글/이번달</span>
										</div>
										<div class="gal_bot bg_4">
											<ul class="f_s16 f_w600">
												<li><a href="#">병원소식<span class="f_w500 bor_2"><em>4 </em>/
															145</span></a></li>
												<li><a href="#">언론보도<span class="f_w500 bor_2"><em>7 </em>/
															188</span></a></li>
												<li><a href="#">한양人<span class="f_w500 bor_2"><em>17 </em>/
															128</span></a></li>
												<li><a href="#">한양토픽<span class="f_w500 bor_2"><em>3 </em>/
															388</span></a></li>
												<li><a href="#">사랑실천<span class="f_w500 bor_2"><em>1 </em>/
															68</span></a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- right -빠른 예약/예약 접수 확인 -->
					<div class="main_right">
						<!-- 빠른 예약 -->
						<p class="total_tit bul_plus">빠른 예약</p>
						<div class="tab_sty02 bor_4">
							<ul class="sty02_btn">
								<li class="on"><a href="#">오늘</a></li>
								<li><a href="#">이번달</a></li>
							</ul>
							<div class="sty02_con on">
								<p class="num f_w800">1,182회</p>
								<div class="chart_box">
									<p class="f_s18 f_w600">통화 후 예약 <span class="c_b">60%</span></p>
									<div class="chart">
										<span class="green bg_11"></span>
										<span class="blue bg_10"></span>
										<span class="red bg_12"></span>
									</div>
								</div>
								<ul>
									<li>
										<p class="f_s14 f_w400"><span class="bg_11"></span>통화</p>
										<p class="c_b f_w700">1,061</p>
									</li>
									<li>
										<p class="f_s14 f_w400"><span class="bg_10"></span>예약</p>
										<p class="c_b f_w700">764</p>
									</li>
									<li>
										<p class="f_s14 f_w400"><span class="bg_12"></span>부재</p>
										<p class="c_b f_w700">76</p>
									</li>
								</ul>
							</div>
							<div class="sty02_con">
								<p class="num f_w800">nnn회</p>
								<div class="chart_box">
									<p class="f_s18 f_w600">통화 후 예약 <span class="c_b">60%</span></p>
									<div class="chart">
										<span class="green bg_11"></span>
										<span class="blue bg_10"></span>
										<span class="red bg_12"></span>
									</div>
								</div>
								<ul>
									<li>
										<p class="f_s14 f_w400"><span class="bg_11"></span>통화</p>
										<p class="c_b f_w700">1,061</p>
									</li>
									<li>
										<p class="f_s14 f_w400"><span class="bg_10"></span>예약</p>
										<p class="c_b f_w700">764</p>
									</li>
									<li>
										<p class="f_s14 f_w400"><span class="bg_12"></span>부재</p>
										<p class="c_b f_w700">76</p>
									</li>
								</ul>
							</div>
							<a href="#" class="btn01">전체보기</a>
						</div>
						<!-- 예약접수 확인 -->
						<p class="total_tit">예약 접수 확인</p>
						<ul class="check">
							<li><a href="#" class="submit">
									<span>접수</span>
									<p>010-8876-6821</p><em>9분전</em>
								</a></li>
							<li><a href="#" class="submit">
									<span>접수</span>
									<p>010-8876-6821</p><em>54분전</em>
								</a></li>
							<li><a href="#" class="submit">
									<span>접수</span>
									<p>010-8876-6821</p><em>5시간전</em>
								</a></li>
							<li><a href="#" class="call">
									<span>통화</span>
									<p>010-8876-6821</p><em>06/01</em>
								</a></li>
							<li><a href="#" class="submit">
									<span>접수</span>
									<p>010-8876-6821</p><em>052/12</em>
								</a></li>
							<li><a href="#" class="call">
									<span>통화</span>
									<p>010-8876-6821</p><em>03/05</em>
								</a></li>
							<li><a href="#" class="reserve">
									<span>예약</span>
									<p>010-8876-6821</p><em>01/06</em>
								</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="footer bg_13 f_s15">2023 Hanyang University Medical Center All right Reserved.</div>
		</div>
	</div>
</body>
</html>