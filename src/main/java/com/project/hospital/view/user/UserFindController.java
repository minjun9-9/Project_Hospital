package com.project.hospital.view.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hospital.user.UserService;

@Controller
@RequestMapping("/user")
public class UserFindController {
	
	@Autowired
	private UserService userService;
	
	public UserFindController() {
		System.out.println("===== UserFindController() 객체 생성");
	}
	
	@Autowired
	public UserFindController(UserService userService) {
		System.out.println("===== UserLoginController(UserService) 객체 생성");
		this.userService = userService;
	}
	
    // 아이디 찾기 페이지 이동
	@GetMapping("/find/findid")
    public String findIdPage() {
		return "user/find/findid";
    }

	// 비밀번호 찾기 페이지 이동
	@GetMapping("/find/findpw")
	public String findPwPage() {
		return "user/find/findpw";
	}
}
