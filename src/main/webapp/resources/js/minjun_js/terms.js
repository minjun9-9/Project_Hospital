// DOMContentLoaded 이벤트: DOM이 준비되면 로직 실행
document.addEventListener("DOMContentLoaded", function () {
    const selectAllCheckbox = document.getElementById("selectAll");
    const individualCheckboxes = document.querySelectorAll(".individual");

    // 전체 선택 동작
    selectAllCheckbox.addEventListener("change", function () {
        individualCheckboxes.forEach((checkbox) => {
            checkbox.checked = selectAllCheckbox.checked; // 전체 동의 상태에 따라 개별 체크박스 동기화
        });
    });

    // 개별 체크박스 상태 변경 시 전체 동의 동기화
    individualCheckboxes.forEach((checkbox) => {
        checkbox.addEventListener("change", function () {
            if (!this.checked) {
                selectAllCheckbox.checked = false; // 하나라도 선택되지 않으면 전체 동의 해제
            } else if (Array.from(individualCheckboxes).every((box) => box.checked)) {
                selectAllCheckbox.checked = true; // 모두 선택 시 전체 동의 체크
            }
        });
    });
    
    // 폼 제출 시 유효성 검사
    form.addEventListener("submit", function (event) {
        if (!Array.from(individualCheckboxes).every((checkbox) => checkbox.checked || !checkbox.hasAttribute("required"))) {
            event.preventDefault();
            alert("필수 약관에 동의해주세요.");
        } else {
            alert("동의가 완료되었습니다. 다음 단계로 이동합니다.");
        }
    });
});

// 이전 버튼 동작
function goBack() {
    window.history.back();
}