<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료진 순위</title>
<style>
	.list-title {
		font-weight: bold;
		position: sticky;
   		top: 0;
   		z-index: 100;
	}
	.list-group-item {
		display: block;
		border: 1px solid #ccc;
	}
	.drListGroup > .list-group-item:hover {
		background-color: #b4b4b4;
	}
	.drName, .deptName {
		display: inline-block;
		width: 33%;
		vertical-align: top;
	}
	.Rank {
		display: inline-block;
		width: 15%;
		vertical-align: top;
	}
	.number {
		color: blue; 
	}
	.ul-container {
		height: 85%;
		overflow: hidden;
		overflow-y: auto;
	}
	.ul-container::-webkit-scrollbar {
		height: 80%;
	}
</style>
<!-- 부트스트랩 링크  -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<!-- 받은 파일 링크  -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/top-right.css" />
<script src="${pageContext.request.contextPath }/resources/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/design.js"></script>
<script>
	const contextPath = '/hospital';
	
	window.addEventListener("load", function(){
		const drListGroup = document.querySelector(".drListGroup");
		
		let picked = null;
		let pickedIndex = null;
		
		drListGroup.addEventListener("dragstart", (event) => {
			const obj = event.target.closest(".list-group-item");
			
			if (!obj) return;
			
			picked = obj;
			pickedIndex = [...obj.parentNode.children].indexOf(obj);
		});
		
		drListGroup.addEventListener("dragover", (event) => {
			event.preventDefault();
		});
		
		let dropIndex = null;
		drListGroup.addEventListener("drop", (event) => {
			event.preventDefault();
			
			const obj = event.target.closest(".list-group-item");;
			if (!obj || !drListGroup.contains(obj)) {
		      return; // 드롭이 ul 내부에서만 동작하도록 제한
		    }
			
			dropIndex = [...obj.parentNode.children].indexOf(obj);
			
			if (picked && obj !== picked) {
				const parent = obj.parentNode;
				const allChildren = [...parent.children];
				
				parent.innerHTML = "";
				
				allChildren.splice(pickedIndex, 1);
				allChildren.splice(dropIndex, 0, picked);
				
				allChildren.forEach(child => parent.appendChild(child));
				
			}
		})
		
		const changeRankBtn = document.querySelector("#changeRank");
		changeRankBtn.addEventListener("click", () => {
			//의료진 ID만 바뀐 순서로 리스트에 넣어준다
			const newDrRankList = [];
			for (let newLi of drListGroup.children) {
				newDrRankList.push(newLi.querySelector("input").value);
			}
			const newDrRankObj = {
				drIdList : newDrRankList
			}
			//DB에 update 요청
			fetch(contextPath + "/updateDrRank", {
				method : "PUT",
				headers : { "Content-Type" : "application/json" },
				body : JSON.stringify( newDrRankObj )
			})
				.then(response => {
					if (!response.ok) {
						throw new Error("Ajax 에러 발생");
					}
					return response.json();
				})
				.then(message => {
					alert(message.msg);
					if (message.result === "success"){
						location.reload(true);
					}
				})
				.catch(error => {
					alert(error);
				})
		});
		
	});
</script>
</head>
<body>
<div id="content" class="body_wrap">
	<!-- 사이드바 -->
	<%@ include file="WEB-INF/../../common/sidebar.jspf"%>
	
	<!-- 컨텐츠 시작 -->
	<div class="content">
		<!-- 헤더 -->
		<div class="top_bar bg_w">
			<a href="#" class="top_left doctor_con"><span>의료진 관리</span></a>
			<!-- 탑바 컨텐츠 -->
			<%@ include file="WEB-INF/../../common/topbarContent.jspf"%>
		</div>
		
	<div class="con_wrap bg_13">
		<!-- main content시작 -->
		<div class="dummy">
		
			<div class="container" style="padding-top: 40px; width: 35%; height: 100%;">
				<div class="text-start text-center mb-3 pe-4">
			    	<span class="subtit f_s20 f_w700">의료진 순위 변경</span>
			  	</div>
			  	
				<div class="d-flex justify-content-end mb-1 pe-4">
					<button id="changeRank" type="button" class="btn btn-primary btn-sm">변경하기</button>
				</div>
				
				<div class="ul-container pe-2">
					<ul class="list-group mb-3 list-title mt-3">
						<li class="list-group-item">
							<span class="Rank">순위</span>
							<span class="drName">이름</span>
							<span class="deptName">부서</span>
							<span>직책</span>
						</li>
					</ul>
					<ul class="list-group drListGroup">
						<c:forEach var="drInfoOrderByRank" items="${drInfoOrderByRankList }">
							<li class="list-group-item" draggable="true">
								<span class="Rank number">${drInfoOrderByRank.rank }</span>
								<span class="drName">${drInfoOrderByRank.drName }</span>
								<span class="deptName">${drInfoOrderByRank.deptName }</span>
								<span>${drInfoOrderByRank.drPosition }</span>
								<input type="hidden" value="${drInfoOrderByRank.drId }">
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
			<div class="footer bg_13 f_s15">2023 Hanyang University Medical Center All right Reserved.</div>
		</div>
		<!-- 컨텐츠 끝  -->
	</div>
</div>
								




<!-- 부트스트랩 링크  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
	// 사이드바 토글 움직임
	document.querySelector('.drul').classList.add('on');
	document.querySelector('.drliRank').classList.add('on');
	
</script>
</body>
</html>