package com.project.hospital.view.user;

import java.time.LocalDate;
import java.time.Year;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.hospital.user.UserService;
import com.project.hospital.user.UserDoubleVO;

@Controller
@RequestMapping("/user")
public class UserLoginController {
	
	@Autowired
	private UserService userService;
	
	public UserLoginController() {
		System.out.println("===== UserLoginController() 객체 생성");
	}
	
	@Autowired
	public UserLoginController(UserService userService) {
		System.out.println("===== UserLoginController(UserService) 객체 생성");
		this.userService = userService;
	}
	
//	// 로그인 페이지 이동
//    @GetMapping("/login/login")
//    public String loginPage(@ModelAttribute("user") UserDoubleVO vo) {
//    	System.out.println(">> 로그인 화면 이동 - loginPage() -------------");
//    	System.out.println("vo" + vo);
//        return "user/login/login"; // login.jsp로 이동
//    }
    // 로그인 페이지 이동
    @GetMapping("/login/login")
    public String loginPage(@ModelAttribute("user") UserDoubleVO vo, HttpServletRequest request) {
    	System.out.println(">> 로그인 화면 이동 - loginPage() -------------");
    	System.out.println("vo" + vo);
    	String referer = request.getHeader("Referer");
    	if(referer != null) {
    		request.getSession().setAttribute("prevPage", referer);
    	} else {
    		request.getSession().setAttribute("prevPage", "/index.jsp");
    	}
    	return "user/login/login"; // login.jsp로 이동
    }
    
//	// 로그인 처리
//    @PostMapping("/login/login")
//	@ResponseBody
//	public Map<String, Object> login(@RequestBody UserDoubleVO vo, HttpSession session) {
//		System.out.println(">> 로그인 처리 ---------------");
//		System.out.println("vo : " + vo);
//		
//		Map<String, Object> response = new HashMap<String, Object>();
//		UserDoubleVO user = userService.loginUser(vo);
//		System.out.println("user : " + user);
//		
//	    if (user != null && user.getUserPw().equals(vo.getUserPw())) {
//	    	session.setAttribute("user", user);
//	    	response.put("success", true);
//	    	System.out.println("::로그인 성공");
//	    } else {
//	    	response.put("success", false);
//	    	response.put("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
//	    	System.out.println("::로그인 실패");
//	    }
//	    return response;
//	}
 // 로그인 처리
    @PostMapping("/login/login")
	@ResponseBody
	public Map<String, Object> login(@RequestBody UserDoubleVO vo, HttpSession session) {
		System.out.println(">> 로그인 처리 ---------------");
		System.out.println("vo : " + vo);
		
		Map<String, Object> response = new HashMap<String, Object>();
		UserDoubleVO user = userService.loginUser(vo);
		System.out.println("user : " + user);
		
	    if (user != null && user.getUserPw().equals(vo.getUserPw())) {
	    	session.setAttribute("user", user);
	    	response.put("success", true);
	    	System.out.println("::로그인 성공");
	    	
	    	String prevPage = (String) session.getAttribute("prevPage");
	    	response.put("redirectUrl", prevPage != null ? prevPage : "/index.jsp");
	    } else {
	    	response.put("success", false);
	    	response.put("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
	    	System.out.println("::로그인 실패");
	    }
	    return response;
	}
	
	// 로그아웃 처리
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate();
	    return "redirect:/index.jsp";
	}
    
	
	
}
