<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<style>
p{
	margin-bottom: 15px;
}
table th{
	background-color: #EFEFF3;
}
table th,
table td {
	border-left: 1px black solid;
    border-right: 1px black solid;
    border-bottom: 1px black solid; /* 일반적으로 모든 셀에 아래 테두리 */
    border-collapse: collapse;
    text-align: center;
    padding: 10px 20px;
}
table td {
	
	 background-color: #FFCC99;
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
table{
	width: 100%; border-collapse: collapse;

}
.a1{
	background-color: white;
}
</style>
<body>
    <%@ include file = "/resources/header/header.jspf" %>
   	<div class="container" style="margin-top: 30px;">
	<p><h2>아이티서울병원 리모델링으로 인한 변경 안내</h2></p>
	<p>&nbsp</p>
	<p>아이티서울병원 리모델링으로 인한 변경 안내</p>
	<div class="changeDoorway" style="margin-bottom: 50px;">
	<strong>1.응급실 주 출입구 임시 변경</strong>
	<p>-공사 내용: 감염병센터 건립으로 인한 응급실 주출입구 임시 변경<br>
	-공사 기간: '23년 11월 4일 ~ '25년 7월까지
	</p>
	</div>
	<div class="changeFloor">
		<table>
			<tr>
				<th>장소</th>
				<th>기존 위치</th>
				<th>변경 위치</th>
				<th>이전 오픈 일자</th>
			</tr>
			<tr>
				<td>소화기센터 외래</td>
				<td>본관 4F</td>
				<td>별관 B2</td>
				<td>‘24/11/25(월)</td>
			</tr>
			<tr>
				<td rowspan="2">심장뇌혈관병원 외래</td>
				<td rowspan="2">본관 2F</td>
				<td>암병원 1F(부정맥, 이미징 파트)</td>
				<td rowspan="2">‘24/11/25(월)</td>
			</tr>
			<tr>
				<td>별관 B2 (심장센터, 뇌졸중센터, 혈관센터,예방재활센터) </td>
			</tr>
			<tr>
				<td>본관 심전도실 </td>
				<td>본관 2F </td>
				<td>별관 B2 </td>
				<td>‘24/11/25(월) </td>
			</tr>
			<tr>
				<td>본관 심전도실 </td>
				<td>본관 2F </td>
				<td>별관 B2 </td>
				<td>‘24/11/25(월) </td>
			</tr>
			<tr>
				<td>본관 심전도실 </td>
				<td>본관 2F </td>
				<td>별관 B2 </td>
				<td>‘24/11/25(월) </td>
			</tr>
			<tr>
				<td rowspan="2">심장뇌혈관병원 외래</td>
				<td rowspan="2">본관 2F</td>
				<td>암병원 1F(부정맥, 이미징 파트)</td>
				<td rowspan="2">‘24/11/25(월)</td>
			</tr>
			<tr>
				<td>별관 B2 (심장센터, 뇌졸중센터, 혈관센터,예방재활센터) </td>
			</tr>
			<tr>
				<td class="a1">본관 심전도실 </td>
				<td class="a1">본관 2F </td>
				<td class="a1">별관 B2 </td>
				<td class="a1">‘24/11/25(월) </td>
			</tr>
			<tr>
				<td class="a1">본관 심전도실 </td>
				<td class="a1">본관 2F </td>
				<td class="a1">별관 B2 </td>
				<td class="a1">‘24/11/25(월) </td>
			</tr>
			<tr>
				<td class="a1">본관 심전도실 </td>
				<td class="a1">본관 2F </td>
				<td class="a1">별관 B2 </td>
				<td class="a1">‘24/11/25(월) </td>
			</tr>
			<tr>
				<td rowspan="2" class="a1">심장뇌혈관병원 외래</td>
				<td rowspan="2" class="a1">본관 2F</td>
				<td class="a1">암병원 1F(부정맥, 이미징 파트)</td>
				<td rowspan="2" class="a1">‘24/11/25(월)</td>
			</tr>
			<tr>
				<td class="a1">별관 B2 (심장센터, 뇌졸중센터, 혈관센터,예방재활센터) </td>
			</tr>
			<tr>
				<td class="a1">본관 심전도실 </td>
				<td class="a1">본관 2F </td>
				<td class="a1">별관 B2 </td>
				<td class="a1">‘24/11/25(월) </td>
			</tr>
			
		</table>
	</div>
   	</div>
    <%@ include file = "/resources/footer/footer.jspf" %>
<style>
body{
	background-color: white;
}
</style>
    
</body>
</html>
