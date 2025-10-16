package com.project.hospital.view.privacyPolicy;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("privacyPolicy")
public class PrivacyPolicyController {
	
	//개인정보처리방침 페이지 전환
	@GetMapping("/privacyPolicyPage")
	public String privacyPolicyPage() {
		return "privacyPolicy/privacyPolicy";
	}

}
