package com.project.hospital.view.admindrmain;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hospital.admindrMain.AdminDrMainService;
import com.project.hospital.admindrMain.dto.AdminDrMainLogInDTO;

@Controller
@RequestMapping("/adminDoctorMain")
public class AdminDrMainController {
	
	private final AdminDrMainService service;
	
	@Autowired
	public AdminDrMainController(AdminDrMainService service) {
		super();
		this.service = service;
	}
	
	/**
	 * 로그인 페이지로 이동
	 */
	@GetMapping("/loginPage")
	public String loginPage(HttpServletRequest request) {
		HttpSession ss = request.getSession();
		ss.invalidate();
		return "/admindoctor/login";
	}
	
	/**
	 * 로그인 검증 후 페이지 이동
	 */
	@PostMapping("/login")
	public String login(@ModelAttribute AdminDrMainLogInDTO logindto,
						Model model, 
						HttpServletRequest request) {
		
		return service.findByIdAndPw(logindto, model, request);

	}
	
	/**
	 * 메인페이지로 이동
	 */
	@GetMapping("/mainPage")
	public String adminMainPage() {
		
		return "admin/adminMain";
	}
}
