<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>건강 게시판 페이지</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/minseo_css/diseaseSearch.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/minseo_css/health/healthBoard.css" />
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
	
	<article id="content">
		<div class="content-header" data-cms-content="/health/_content/title">
			<h2 class="content-title">건강 뉴스</h2>
		</div>
		<div class="content-body cms-search cms-print" id="cms-content">
			<div class="ko board list co-board ">
				<div class="container board06">
					<div class="bn-search01 type01">
						<!-- 검색 -->
						<div class="search_wrap">
							<div class="searchBox">
								<input type="text" class="search_input_box" name="searchKeyword" placeholder="검색어를 입력해 주세요" id="searchBox">
								<input type="button" value="검색" id="searchBtn">
							</div>
						</div>
					</div>
					
					<div class="container my-5">
						<div id="card-container" class="row row-cols-1 row-cols-md-4 g-4"> 
							<!-- 컨텐츠 표시 영역 -->
						</div>
						<!-- 더보기 버튼 -->
						<div class="button-container">
							<button type="button" id="loadMoreBtn" class="btn btn-outline-secondary ">더보기
							 	<img src="${pageContext.request.contextPath }/resources/images/downArrow.png" class="btn-icon" alt="arrow">
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</article>

	
	
<script src="${pageContext.request.contextPath}/resources/js/health/healthBoard.js"></script>
<%@include file ="/resources/footer/footer.jspf" %>

</body>
</html>