package com.project.hospital.view.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/userclient/mypage")
public class MyPageController {
	
	/**
	 * 마이 페이지 메인페이지 이동
	 */
	@GetMapping("/mainPage")
	public String myPageMainPage() {
		return "userclient/mypage/mainPage";
	}
	
	/**
	 * 마이 페이지 예약현황 페이지 이동
	 */
	@GetMapping("/reservSchedule")
	public String reservSchedulePage() {
		return "userclient/mypage/reservSchedule";
	}
	
	/**
	 * 마이 페이지 과거 진료내역 페이지 이동
	 */
	@GetMapping("/historyMedicalRecord")
	public String historyMedicalRecordPage() {
		return "userclient/mypage/historyMedicalRecord";
	}

}
