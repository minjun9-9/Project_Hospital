<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file ="/resources/header/header.jspf" %>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- ajax용 style -->
<style>
      .card-footer{
      width: 50%;
      align-items: center;
      text-align: center;
      text-decoration: none;
        
    }
    .doctor-card{
        list-style-type: none;
        display: grid;
       /*  grid-template-columns: repeat(2, 1fr); */
        gap: 40px;
        padding: 0;
        justify-items: end;
        width: 45%;
    }
    #doctorResults{
        list-style-type: none;
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
        padding: 0;
        justify-items: end;
    }
	.doctor-profile{
        list-style-type: none;
		height: auto;
		background-color: white;
	}
    .doctor-img{
        margin: 20px;
    }
    .card-footer:hover{
        background-color: #3378C1;
    }
    .card-font{
        font-size: 14px;
        font: inherit;
        color: #44484f;
        text-align: center;
        align-items: center;
        justify-content: center;
    }
</style>
</head>
<body>
<script>
	function handleGroupSelectChange() {
		var groupSelectElement = document.getElementById('groupSelect');
		var deptName = document.getElementById('deptName');
		var searchQueryElement = document.getElementById('searchQuery');
		
		if(groupSelectElement.value ==='그룹선택'){
			deptName.innerHTML = '<option value="" disabled selected >선택</option>';
			deptName.style.display = 'inline-block';	
			
			searchQueryElement.value='';
		}else if(groupSelectElement.value ==='진료과'){
			
			var options = [
				'내과', '외과', '소아청소년과', '산부인과', '영상의학과', '마취통증의학과', '진단검사의학과', '정신건강의학과', '응급의학과'
			];
			
			deptName.innerHTML ='';
			options.forEach(function(optionText){
				var option = document.createElement('option');
				option.value = optionText;
				option.textContent = optionText;
				
				//스타일 적용
				option.style.backgroundColor = '#ededef';
				option.style.color = '#5d6167';
				
				deptName.appendChild(option);
			});
			deptName.style.display = 'inline-block';
			searchQueryElement.value='';
		}
		else{
			deptName.style.display = 'none';
		}
		searchDoctors();
	}
	
	
	/* resermain에서 넘어오는 ajax처리 */
window.onload = function() {
    const searchQuery = localStorage.getItem("searchQuery"); 
    const doctorList = JSON.parse(localStorage.getItem("doctorList")); 
	if(searchQuery) {
    	deptName = '';
	    document.getElementById('searchQuery').value = searchQuery;
    	
    }

    if (searchQuery && doctorList) {

    	console.log("검색어:", searchQuery);
        console.log("검색된 의사 목록:", doctorList);

        const resultContainer = document.getElementById("doctorResults");
        const resultsHeader = document.getElementById("doctorResults1");
        
        resultsHeader.innerHTML = '<p>의료진 검색결과(' + doctorList.length + ')</p>';

        
        resultContainer.innerHTML = ''; 

        if (doctorList.length === 0) {
            resultContainer.innerHTML = '<p>검색 결과가 없습니다.</p>';
        } else {
            doctorList.forEach(function(doctor) {
                const doctorElement = document.createElement("li");
                doctorElement.classList.add("doctor-profile");
                doctorElement.style.width = "501px";
                doctorElement.innerHTML = `
                    <div style="display: flex;">
                        <div class="doctor-img">
                            \${doctor.filePath} ? 
                                `<img src="/hospital${doctor.filePath}" alt="Doctor Image" width="150" height="150">` : 
                                `<svg xmlns="http://www.w3.org/2000/svg" width="125" height="125" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                                </svg>`
                            }
                        </div>
                        <div class="doctor-info">
                            <div class="doctor-info-names" style="display: flex;">
                                <h3 style="color: #115bab;">\${doctor.drName}</h3><h3> 교수</h3>
                                <h3 style="font-size: 1rem; align-content: center;">[\${doctor.deptName}]</h3>
                            </div>
                            <strong>[진료분야]</strong><br><br>
                            <span style="color: #72767e; font-weight: bold;">\${doctor.drField}</span>
                        </div>
                    </div>
                    <div style="display: flex; margin: 0; width: 100%;">
                        <a href="" class="card-footer"><div class="card-font" style="margin: 20px;">상세소개</div></a>
                        <a href="javascript:void(0);" onclick="checkLogin()" class="card-footer"><div class="card-font" style="margin: 20px;">진료예약</div></a>
                    </div>
                `;
                resultContainer.appendChild(doctorElement);
            });
        }
    } else {
        console.log("검색어 또는 의사 목록이 없습니다.");
    }
    window.localStorage.removeItem("searchQuery");
    window.localStorage.removeItem("doctorResults1");
};
</script>
<script>
	function checkLogin() {
		var user = '<%= session.getAttribute("user")%>';
		
		if(!user || user ==="null"){
			alert("로그인 후 예약이 가능합니다.");
			window.location.href = "<%=request.getContextPath() %>/user/login/login";
		} else {
			window.location.href = "<%=request.getContextPath() %>/reservation/reservationInsert?hpId=SSW&userNum="+"${sessionScope.user.userNum}";
		}
	}
</script>
<script>
function handleDeptChange(){
	document.getElementById('searchQuery').value = '';
	searchDoctors();
}

    document.addEventListener('DOMContentLoaded', function() {

    	searchDoctors();
		document.getElementById('deptName').addEventListener('change', handleDeptChange);
    });

    function searchDoctors() {
        var groupSelect = document.getElementById('groupSelect').value;
        var deptName = document.getElementById('deptName').value;
        var searchQuery = document.getElementById('searchQuery').value;

        if(groupSelect === '그룹선택') {
        	groupSelect = '';
        	deptName = '';
        	/* document.getElementById('searchQuery').value = '';
        	searchQuery = ''; */
        }
        if(deptName === '선택' || deptName ==='') deptName = '';
		
        var contextPath = '<%=request.getContextPath() %>';
        
        /* if(searchQuery) {
        	deptName = '';
        } */
        $.ajax({
            url: contextPath + '/reservation/doctorDetailInfoSearch',
            method: 'GET',
            data: {
                groupSelect: groupSelect,
                deptName: deptName,
                searchQuery: searchQuery
            },
            success: function (response) {
                if(response.length === 0) {
                    $('#doctorResults').empty();
                    $('#doctorResults1').empty();
                    $('#doctorResults1').append('<p>의료진 검색결과(' + response.length + ')</p>');
                    $('#doctorResults').append('<p>검색 결과가 없습니다.</p>');
                } else {
                    $('#doctorResults').empty();
                    $('#doctorResults1').empty();
                    $('#doctorResults1').append('<p>의료진 검색결과(' + response.length + ')</p>');
                    response.forEach(function(doctor){
                        $('#doctorResults').append('<li class="doctor-profile" style="width: 501px; ">' +
                            '<div style="display: flex;">' +
                            '<div class="doctor-img" >' +
                            (doctor.filePath ? /*/hospital + filestore_path */ 
                                '<img src="/hospital' + doctor.filePath + '" alt="Doctor Image" width="150" height="150">' : 
                                '<svg xmlns="http://www.w3.org/2000/svg" width="125" height="125" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">' +
                                '<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>' +
                                '<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>' +
                                '</svg>') +
                            '</div>' +
                            '<div class="doctor-info">' +
                            '<div class="doctor-info-names" style="display:flex;">' +
                            '<h3 style="color: #115bab;">' + doctor.drName + '&nbsp</h3><h3> 교수</h3> ' +
                            '<h3 style="font-size: 1rem; align-content: center;">[' + doctor.deptName + ']</h3>' +
                            '</div>' +
                            '<strong>[진료분야]</strong><br><br>' +
                            '<span style="color: #72767e; font-weight: bold;">' + doctor.drField + '</span>' +
                            '</div>' +
                            '</div>' +
                            '<div style="display: flex; margin: 0; width: 100%;">' +
                            '<a href="" class="card-footer"><div class="card-font" style="margin: 20px;">상세소개</div></a>' +
                            '<a href="javascript:void(0);" onclick="checkLogin()" class="card-footer"><div class="card-font" style="margin: 20px;">진료예약</div></a>' +
                            '</div>' +
                            '</li>');
                    });
                }
            },
            error: function(error) {
                console.log("Error:", error);
                alert("오류");
            }
        });
    }
</script>
	
	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/minjun_css/doctorDetailInfo.css">
	<!-- <h1>예약진행 페이지</h1> -->
	<div class="container">
	<form action="<%=request.getContextPath() %>/reservation/doctorDetailInfo" method="get" onsubmit="event.preventDefault(); searchDoctors();" style="margin-top: 30px;">
	<div class="form-container" style="justify-content: center;"><span style="font-size: 28px; color: #3378c1;">검색</span> 
		<select style="height:49.45px; border-radius:0; background-color: #3378c1; padding: 10px 15px; color: white;" class="group-select" id="groupSelect" onchange="handleGroupSelectChange()">
			 <option style="border-radius: 0; background-color: #ededef; color: #5d6167; ">그룹선택</option>
			 <option style="border-radius: 0; background-color: #ededef; color: #5d6167;">진료과</option>
		</select>
		
		<select class="option-select" id="deptName"  style="height:49.45px; border-radius:0; background-color: #3378c1; padding: 10px 15px; color: white;" >
			<option style="border-radius: 0; background-color: #ededef; color: #5d6167;" value="" disabled selected>선택</option>
		</select>
		
	      <input class="form-control-search" type="search" id="searchQuery" placeholder="의료진명 또는 질환명을 입력하세요" aria-label="Search" style="width: 40%; border-radius: 0px; border: 3px solid #3378c1;">
	      <button class="btn btn-outline-success" type="submit" style="height: 49.45px; background-color: #3378c1;">
	      	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" style="background-color:  #3378c1; color: white;" class="bi bi-search" viewBox="0 0 16 16">
				<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
			</svg>
	      </button>
	</div>
	</form>
	<div class="formControl" style="margin: 0 100px; margin-top: 30px;">
		<div id="doctorResults1">
	</div>
	<ul class="doctor-card">
	<div id="doctorResults">
</div>

<div id="doctorInfoContainer">
    <!-- 검색 결과 출력 -->
</div>
	</ul>
	</div>
	
	</div>
	<%@include file ="/resources/footer/footer.jspf" %>
</body>
</html>