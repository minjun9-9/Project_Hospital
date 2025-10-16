package com.project.hospital.view.login;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.hospital.login.AdminVO;
import com.project.hospital.login.CoporAdminService;
import com.project.hospital.login.dto.AdminDTO;
import com.project.hospital.vo.HpMemberVO;

@Controller
@RequestMapping("login")
public class LoginController {
	
	private CoporAdminService adminService;
	
	public LoginController() {
		System.out.println("LoginController() 시작");
	}
	
	@Autowired
	public LoginController(CoporAdminService adminService) {
		System.out.println("LoginController(adminService) 시작");
		this.adminService = adminService;
	}

	
	@GetMapping("/loginPage")
	public String loginPage(){
		return "login/login"; 
	}
	
	@GetMapping("/regiPage")
	public String registerPage(){
		
		return "register/register"; 
	}
	
	@GetMapping("/myPage")
	public String myPage() {
		
		return "myInfo/myPage";
	}
	
	
	// 병합 후 추가
	@PostMapping("/login")
	public String login(AdminDTO admin, HttpServletRequest request,
			 @RequestParam(value = "remember", required = false) String remember,
	         @RequestParam(value = "adminLogin", required = false) String adminLogin){
		
		System.out.println(admin);
		System.out.println("admin ID : "+admin.getAdminId()+", PW : "+admin.getAdminPw());
		
		String path = null;
		
		if ("true".equals(remember)) {
            // 아이디 저장 체크박스가 선택되었을 때의 처리
            System.out.println("아이디 저장이 선택됨");
        }

        if ("true".equals(adminLogin)) {
            // 관리자 로그인 체크박스가 선택되었을 때의 처리
            System.out.println("관리자 로그인 체크됨");
            
            AdminVO vo = adminService.getUser(admin);
    		System.out.println("vo : "+vo);
    		
    		if (vo==null) {
    			System.out.println(":: 로그인 실패");
    			request.getSession().setAttribute("message", "아이디 및 비밀번호가 일치하지 않습니다.");
    			//return "redirect:/login/loginPage";
    			return "login/login";
    		}else {
    			System.out.println(":: 로그인 성공!");
    			
    			//세션에 데이터 올려줌
    			//HttpSession session = request.getSession();
    			request.getSession().setAttribute("admin", vo);
    			
    			//return "redirect:getBoardList.do";
    			path = "redirect:/main/mainPage";
    		}
        }else {
        	System.out.println("관리자 로그인 체크 해제");
        	HpMemberVO vo = adminService.getHpMember(admin);
        	
        	if (vo==null) {
    			System.out.println(":: 로그인 실패");
    			request.getSession().setAttribute("message", "아이디 및 비밀번호가 일치하지 않습니다.");
    			
    			return "redirect:/login/loginPage";
    		}else {
    			System.out.println(":: 로그인 성공!");
    			
    			//세션에 데이터 올려줌
    			//HttpSession session = request.getSession();
    			request.getSession().setAttribute("hpMember", vo);
    			
    			//return "redirect:getBoardList.do";
    			path = "redirect:/main/mainPage";
    		}
        }
		
		
		return path;
	}
	
	@RequestMapping("/logout")
	//@GetMapping("/logout.do")
	public String logout(HttpServletRequest request) {
		System.out.println(">> 로그아웃 처리");
		request.getSession().invalidate();
		
		request.getSession().setAttribute("message", "로그아웃 되었습니다.");
		
		return "login/login"; 
	}
}
