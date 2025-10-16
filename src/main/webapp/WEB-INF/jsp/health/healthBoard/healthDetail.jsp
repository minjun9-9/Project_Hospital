<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>건강 정보 상세 페이지</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/minseo_css/diseaseSearch.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/minseo_css/health/healthDetail.css" />
	<%@include file ="/resources/header/header.jspf" %>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" ></script>
	<script src="${pageContext.request.contextPath}/resources/js/health/dropdown.js"></script>
	<!-- 컨텍스트 경로를 자바스크립트 변수로 정의 -->
    <script>
        var contextPath = "${pageContext.request.contextPath}";
    </script>
</head>
<body>


<div id="breadcrumb" class="light">
    	<div class="container">
        	<ul class="breadcrumb-list">
            	<!-- 홈버튼 -->
            	<li><a href="${pageContext.request.contextPath }/index.jsp"><span><img class="ico ico-home" src="${pageContext.request.contextPath }/resources/images/home.png"></span></a></li>
            
            	<!-- 질환 정보 -->
            	<li>
                	<a href="#" class="dropdown">
	                	<span>건강게시판</span>
	                	<img class="dropdown-icon downArrow_img downArrow_img1" src="${pageContext.request.contextPath }/resources/images/downArrow.png">
	                	<img class="dropdown-icon upArrow_img upArrow_img1"src="${pageContext.request.contextPath }/resources/images/upArrow.png">
	                </a>
                	<div id="dropdown_content1" class="custom-scroll" style="display: none;">
	                    <ul>
	                        <li class="active">
	                            <a href="${pageContext.request.contextPath }/health/diseaseSearchPage" id="disease-search" title="질환 정보">
	                                <span>질환 정보</span>
	                            </a>
	                        </li>
	                        <li>
	                            <a href="${pageContext.request.contextPath }/health/healthBoardPage" id="" title="건강게시판" target="_self">
	                                <span>건강게시판</span>
	                            </a>
	                        </li>
	                    </ul>
                	</div>
            	</li>
	        </ul>
	    </div>
	</div>
	
	<c:set var="health" value="${healthDetail }" />
	<article id="content">
		<div class="content-header" data-cms-content="/health/_content/title">
			<h2 class="content-title">건강 뉴스</h2>
		</div>
		<div class="content-body cms-search cms-print" id="cms-content">
			<div class="article-header">
				<div class="subject-area">
					<h3 class="subject">${health.title}</h3>
					<div class="article-info">
								<span class="item name">관리자</span>
						<span class="item date">${health.createdAt}</span>
						<span class="item hit"><strong>조회수</strong>${health.boardCount}</span>
					</div>
				</div>
			</div> 
		<div class="article-body">
			<div class="subtitle">
				<h3 id="title">${health.title}</h3>
			</div>
				<span>${health.content}</span><br><br>
			</div>
		<!-- 더보기 버튼 -->
		<button type="button" id="goToList" class="btn btn-outline-secondary ">목록으로</button>
		</div>
	
	</article>



</body>
<script>
	//목록으로 버튼
	let btn = document.getElementById('goToList');
	btn.addEventListener('click', function() {
		history.back();
	});
	
</script>
<%@include file ="/resources/footer/footer.jspf" %>
</html>