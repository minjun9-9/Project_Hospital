document.addEventListener("DOMContentLoaded", function () {
    const emailDomainSelect = document.getElementById("emailDomain");
    const emailCustomDomain = document.getElementById("emailCustomDomain");
    const passwordField = document.getElementById("password");
    const passwordConfirmField = document.getElementById("passwordConfirm");

    // 이메일 도메인 선택
    emailDomainSelect.addEventListener("change", function () {
        if (this.value === "") {
            emailCustomDomain.style.display = "block";
            emailCustomDomain.required = true;
        } else {
            emailCustomDomain.style.display = "none";
            emailCustomDomain.value = "";
            emailCustomDomain.required = false;
        }
    });

    // 비밀번호 확인
    passwordConfirmField.addEventListener("input", function () {
        if (passwordField.value !== passwordConfirmField.value) {
            passwordConfirmField.setCustomValidity("비밀번호가 일치하지 않습니다.");
        } else {
            passwordConfirmField.setCustomValidity("");
        }
    });
});

// 성별 선택
function selectGender(selectedGender) {
    document.querySelectorAll('.gender-button').forEach(button => {
        button.classList.remove('active');
    });

    document.getElementById(selectedGender === 'M' ? 'male' : 'female').classList.add('active');
    document.getElementById('gender').value = selectedGender;
}

// 아이디 중복 확인
function checkId() {
    const userId = document.getElementById("id").value;

    if (!userId) {
        alert("아이디를 입력해주세요.");
        return;
    }

    fetch("/user/check-id", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId })
    })
        .then((response) => response.json())
        .then((data) => {
            if (data.available) {
                alert("사용 가능한 아이디입니다.");
            } else {
                alert("이미 사용 중인 아이디입니다.");
            }
        })
        .catch((error) => {
            alert("아이디 확인 중 오류가 발생했습니다.");
            console.error(error);
        });
}

// 주소 검색
function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색 결과에서 주소 입력
            const roadAddr = data.roadAddress; // 도로명 주소
            const jibunAddr = data.jibunAddress; // 지번 주소
            const userAddress = document.getElementById("userAddress");

            // 주소 입력
            userAddress.value = roadAddr || jibunAddr;

            // 상세 주소 입력 필드에 포커스
            document.getElementById("userDetailAddress").focus();
        }
    }).open();
}

// 이전 버튼 동작
function goBack() {
    window.history.back();
}