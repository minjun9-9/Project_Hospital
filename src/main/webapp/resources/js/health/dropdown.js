//네비게이션 드롭다운 스크립트 -------
	$(document).ready(function() {
		
		$('.dropdown').click(function (e) {
	        e.preventDefault(); // 기본 동작 방지 (a 태그 클릭 기본 동작 방지)
	
	        const dropdownContent = $(this).next('.custom-scroll'); // 현재 클릭한 버튼에 해당하는 드롭다운 콘텐츠
	        const dropdownImg = $(this).find('.downArrow_img');
	        const dropupImg = $(this).find('.upArrow_img');
	
	        // 모든 드롭다운 숨기기
	        $('.custom-scroll').not(dropdownContent).hide();
	        $('.downArrow_img').not(dropdownImg).show(); // 다른 화살표 초기화
	        $('.upArrow_img').not(dropupImg).hide();
	
	        // 클릭한 요소 토글
	        if (dropdownContent.is(':visible')) {
	            dropdownContent.hide(); // 드롭다운 숨김
	            dropdownImg.show(); // 아래 화살표 표시
	            dropupImg.hide(); // 위 화살표 숨김
	        } else {
	            dropdownContent.show(); // 드롭다운 표시
	            dropdownImg.hide(); // 아래 화살표 숨김
	            dropupImg.show(); // 위 화살표 표시
	        }
	    });
	
	    // 초기 상태에서 upArrow 숨기기
	    $('.upArrow_img').hide();
		
		
	});