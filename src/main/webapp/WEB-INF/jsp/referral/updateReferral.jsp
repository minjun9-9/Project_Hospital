<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>진료의뢰서 작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/default.css" />
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/design.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script>
    function validateForm() {
        // 결과 입력란 값 가져오기
        var resultContent = document.querySelector("textarea[name='result']");

        // 결과 입력란이 비어있는지 확인
        if (resultContent.value.trim() === "") {
            alert("결과를 입력해주세요.");  // 경고 메시지 표시
            resultContent.focus();  // 결과 입력란에 포커스
            return false;  // 폼 제출 막기
        }

        // 결과가 입력되었다면 true를 반환하여 폼이 제출되도록 함
        return true;
    }
</script>
</head>
<body>
	<div class="body_wrap">
	
		<%@include file="/resources/common/menu.jspf" %>
		
		<div class="content">
			<div class="top_bar bg_w">
				<a href="#" class="top_left doctor_con"><span>진료의뢰서 확인</span></a>
				<%@include file="/resources/common/profile.jspf" %>
			</div>
			<div class="con_wrap bg_13">
				<!-- content시작 -->
					<div class="doctor">
						<div class="doc_left bg_w">
							<div class="doc_con">
								<p class="f_s17 f_w500">보낸 병원</p>
								<input type="text" id="hospital" value="${referral.sHpName}" readonly="readonly">
								<%-- <select id="doc_sel01" name="doc_sel01" onchange="updateDepartments()">
									<option selected disabled>선택</option>
									<c:forEach var="vo" items="${hospitalList }">
										<option value="${vo.hpId }">${vo.hpName }</option>	
									</c:forEach>
								</select> --%>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">진료과</p>
								<input type="text" id="dept" value="${referral.sDeptName}" readonly="readonly">
								<!-- <select id="doc_sel02" name="doc_sel02" onchange="updateDoctor()">
									<option selected disabled>선택</option>
								</select> -->
							</div>
							<div class="doc_con">
								<%-- <p class="f_s17 f_w500">성명</p>
								<input type="text" placeholder="성명을 입력하세요" value="${admin.adminName }"> --%>
								 <p class="f_s17 f_w500">의사</p>
								 <input type="text" id="dr" value="${referral.sDrName}" readonly="readonly">
							    <!-- <select id="personList" name="personList">
							      <option selected disabled>선택</option>
							    </select> -->
							</div>
							<div class="doc_con">
								 <p class="f_s17 f_w500">환자</p>
								 <input type="text" id="user" value="${referral.userName}" readonly="readonly">
							    <%-- <select id="userList" name="userList" onchange="updateUser()">
							      <option selected disabled>선택</option>
								  <c:forEach var="user" items="${userList }">
										<option value="${user.userNum }">${user.userName }</option>	
								  </c:forEach>
							    </select> --%>
							</div>
						</div>
						<div class="doc_right bg_w">
							<div class="doc_con">
								<p class="f_s17 f_w500">의뢰내용</p>
								<textarea name="content" placeholder="의뢰내용을 입력하세요" readonly="readonly">${referral.referContent}</textarea>
							</div>
							<div class="doc_con">
								<p class="f_s17 f_w500">결과</p>
								<textarea name="result" placeholder="결과를 입력하세요">${referral.resultContent}</textarea>
							</div>
							
							<%-- <div class="doc_con">
								<p class="f_s17 f_w500">파일 등록</p>
								<div class="profile on">
									<a href="#" class="c_4 f_s15 f_w500">파일 선택</a>
									<div class="file f_s16 f_w400">업로드된_파일명.jpg</div>
									<span class="profile_img"><img src="${pageContext.request.contextPath}/resources/images/ico_plus.png" alt=""></span>
								</div>
								<div class="profile">
									<a href="#" class="c_4 f_s15 f_w500">파일 선택</a>
									<div class="file f_s16 f_w400">파일을 선택해 주세요.</div>
									<span class="profile_img"><img src="${pageContext.request.contextPath}/resources/images/ico_minus.png" alt=""></span>
								</div>
							</div> --%>
							<!-- <div class="doc_con" style="width: 90%;">
								<p class="f_s17 f_w500">프로필 이미지<button id="filecancleBtn" class="btn btn-secondary btn-sm ms-2" type="button" style="height: 25px; line-height: normal;">취소</button></p>
								<p class="f_s17 f_w500">파일 등록<button type="button" id="fileResetBtn" class="ms-2 resetBtn"></button></p>
								<div class="d-flex align-items-center position-relative">
									숨겨진 파일 입력 필드
    								<input type="file" id="fileInput" name="fileone" class="form-control-file" style="display: none;" multiple/>
									<input type="text" id="fileText" name="fileText" class="form-control flex-grow-1 bottomMargin" 
											placeholder="파일을 선택해 주세요" style="width: 80%; height: 50px;" readonly>
									<span style="width: 1%; text-align: center;"> </span>
									<button type="button" id="uploadFileBtn" class="btn btn-secondary text-nowrap" style="width: 19%; height: 50px; margin-bottom: 5.2px">파일 선택</button>
									<span type="button" class="btn-close ms-2" style="visibility: hidden;"></span> 레이아웃용도
								</div>
							</div> -->
						</div>
					</div>
					<div class="d-flex justify-content-center align-items-center f_s16 f_w600 gap-3"><!-- doc_bottom -->
					
							<c:if test="${referral.receiveChk == '확인 전'}">
								<a href="updateReceive?referId=${referral.referId }&receiveChk=${referral.receiveChk}" class="btn btn-primary btn-lg">
									확인하기
								</a>
								<a href="updateReceive?referId=${referral.referId }&receiveChk=cancel" class="btn btn-danger btn-lg">취소</a>
							</c:if>
							<c:if test="${referral.receiveChk == '진행 중'}">
								<a href="updateReceive?referId=${referral.referId }&receiveChk=${referral.receiveChk}" class="btn btn-primary btn-lg" onclick="return validateForm();">
									의뢰 완료
								</a>
								<a href="updateReceive?referId=${referral.referId }&receiveChk=cancel" class="btn btn-danger btn-lg">취소</a>
							</c:if>
							
						<!-- <a href="window.history.back()" class="btn btn-secondary btn-lg">목록으로</a> -->
						<button onclick="history.back()" class="btn btn-secondary btn-lg">목록으로</button>
					</div>
			</div>
			<div class="footer bg_13 f_s15">2025 ITWILL.</div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>	
</body>
</html>