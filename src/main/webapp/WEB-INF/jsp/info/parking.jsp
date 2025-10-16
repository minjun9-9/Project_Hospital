<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
    <%@ include file = "/resources/header/header.jspf" %>
  	<div class="container" style="margin-top: 30px;">
  	<div style="width: 100%; margin-bottom: 30px;">
  		<img src="${pageContext.request.contextPath }/resources/images/위치도.png" alt="병원위치이미지" style="width: 100%;"/>
  	</div>
  	<div style="background-color: white; padding: 30px; align-content: center;">
  		<ul style="display: flex; align-items: center; text-align:center; align-content: center; margin: 0; padding: 0; justify-content: space-between;">
  			<li>
  				<span style="border-radius: 50%; background-color: #b3d4fc; padding: 10px; color: white;">P1</span>
  				<span>정문 주차장</span>
  			</li>
  			<li>
  				<span style="border-radius: 50%; background-color: #8592DD; padding: 10px; color: white;">P2</span>
  				<span>본관 주차장</span>
  			</li>
  			<li>
  				<span style="border-radius: 50%; background-color: #3276D1; padding: 10px; color: white;">P3</span>
  				<span>본관 지하 주차장</span>
  			</li>
  			<li>	
  				<span style="border-radius: 50%; background-color: #115BAB; padding: 10px; color: white;">P4</span>
  				<span>암 병원 지하 주차장</span>
  			</li>
  			<li>
  				<span style="border-radius: 50%; background-color: #88B43C; padding: 10px; color: white;">P5</span>
  				<span>장례식장 주차장</span>
  			</li>
  				
  		</ul>
  	</div>
  	<!-- 주차장 규모쪽 -->
<style>
table th{
	background-color: #EFEFF3;
}
table th,
table td {
	border-left: 1px black solid;
	border-right: 1px black solid;
	border-bottom: 1px black solid;
	border-collapse: collapse;
	text-align: center;
	align-content: center;
	align-items: center;
	justify-content: center;
	 padding: 10px 20px;
}
table th:first-child,
table td:first-child {
	border-left: 0;
}
table th:last-child,
table td:last-child {
	border-right: 0;
}
table tr:first-child th,
table tr:first-child td {
    border-top: 2px solid black;
}
table tr:last-child th,
table tr:last-child td {
    border-bottom: 0;
}
.parking-scale-head{
	padding: 20px 0;
}
table{
	width: 100%; border-collapse: collapse;

}
</style>
  	<div class="parking-scale">
  		<div class="parking-scale-head" >
  			<h2>주차장 규모</h2>
  		</div>
  		<table>
  			<tr> 
  				<th style=" width: 33.333%;  text-align: center; align-content: center;">
  					P1 정문 주차장
  				</th>
  				<td style="width: 66.666%; text-align: center; align-content: center;">
  					509대
  				</td>
  			</tr>
  			<tr>
  				<th>
  					P2 본관 주차장
  				</th>
  				<td>
  					507대
  				</td>
  			</tr>
  			<tr>
  				<th>
  					P2 본관 지하 주차장
  				</th>
  				<td>
  					995대
  				</td>
  			</tr>
  			<tr>
  				<th>
  					P4 암 병원 지하 주차장
  				</th>
  				<td>
  					405대
  				</td>
  			</tr>
  			<tr>
  				<th>
  					P5 장례식장 주차장
  				</th>
  				<td>
  					425대
  				</td>
  			</tr>
  		</table>
  		<p style="color: #115bab !important; padding: 15px 0px;">※ 총 2,841대의 주차공간이 확보되어 있습니다</p>
  	</div>
  	<div class="parking-charge">
  		<div class="parking-scale-head">
  			<h2>주차요금</h2>
  			<p style="text-align: right;">시행일-2025-01-09 </p>
  			
  			<table>
  				<tr>
  					<th style=" width: 23%;">구분</th>
  					<th style=" width: 46%;">무료주차시간</th>
  					<th style=" width: 31%;">요금내역</th>
  				</tr>
  				<tr>
  					<td>주간<br>(08:00~22:00)</td>
  					<td rowspan="2">입차 후 30분 무료</td>
  					<td>초과 시 10분당 \1,000 </td>
  				</tr>
  				<tr>
  					<td>야간<br>(22:00~08:00)</td>
  					<td>일괄 \1,000</td>
  				</tr>
  				<tr>
  					<td colspan="3">주차 요금은 평일/주말/휴일 동일하게 적용합니다.</td>
  				</tr>
  			</table>
  		</div>
  		<div class="free-parking">
  			<div class="free-parking-head">
  				<h2>무료주차</h2>
				<br>  			
	  			<table>
	  				<tr>
	  					<th style=" width: 33.333%;">구분</th>
	  					<th style=" width: 33.333%;">무료주차</th>
	  					<th style=" width: 33.333%;">출처방법</th>
	  				</tr>
	  				<tr>
	  					<td>
	  						예약환자, 입원환자 중간진료비 수납
	  					</td>
	  					<td>
	  						2시간 1대 1회
	  					</td>
	  					<td rowspan="4">
	  						진료환자는 요금계산소에 진료카드 또는 영수증을 제시하여 주시기 바랍니다.
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>
	  						외래(진료,검사,채혈)환자, 건강검진, 통원수술
	  					</td>
	  					<td>
	  						당일 수진 진료과별 무료
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>
	  						입원, 퇴원, 수술환자
	  					</td>
	  					<td>
	  						당일 1대 1회
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>
	  						응급실 환자(입실시간기준)
	  					</td>
	  					<td>
	  						당일 24시간/1회
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>
	  						장애인(동승/운전할경우)
	  					</td>
	  					<td colspan="2">
	  					복지카드를 제시하면 일반요금의 50%할인<br>
	  					(할인주차권은 장애인 50% 할인이 없습니다.)
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>
	  						할인주차권
	  					</td>
	  					<td colspan="2">
	  						할인권: 10,000원/1일(24시간 자유로이 입/출차가능)<br>
	  						입원기간 중 차량 1대에 한하여 1회 구입 가능합니다.<br>
	  						할인권 사용 후에는 일반요금이 적용됩니다.
	  					</td>
	  				</tr>
	  			</table>
	  			<p style="color: #115bab !important; padding: 15px 0px;">※ P4 암 병원 주차장은 매우 혼잡하여 할인권 구입 및 사용이 불가하여 일과중 암병원을 이용하시는 고객님들께서는 P5 후문 주차장을 이용하시면 보다 빠른 주차가 가능합니다</p>
  			</div>
  		</div>
  	
  	</div>
  	<div style="margin-bottom: 30px;"></div>
	</div>
    <%@ include file = "/resources/footer/footer.jspf" %>

    
</body>
</html>