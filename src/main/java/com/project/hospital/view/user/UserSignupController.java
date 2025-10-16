package com.project.hospital.view.user;

import java.time.LocalDate;
import java.time.Year;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.hospital.user.UserService;
import com.project.hospital.user.UserDoubleVO;

@Controller
@RequestMapping("/user")
public class UserSignupController {
	
	@Autowired
	private UserService userService;
	
	public UserSignupController() {
		System.out.println("===== UserSignController() 객체 생성");
	}
	@Autowired
	public UserSignupController(UserService userService) {
		System.out.println("===== UserSignupController(UserService) 객체 생성");
		this.userService = userService;
	}
    // 회원가입 페이지 이동
	@GetMapping("/signup/selecttype")
    public String selectType() {
		return "user/signup/selecttype";
    }

    // 약관 동의 페이지
    @GetMapping("/signup/terms")
    public String terms(@RequestParam String type, Model model) {
        model.addAttribute("type", type);
        return "user/signup/terms";
    }
    
    // 회원 정보 입력 페이지(14세 이상/미만 통합)
    @GetMapping("/signup/register")
    public String showRegisterPage(@RequestParam("type") String type, Model model) {
    	model.addAttribute("type", type);
    	return "user/signup/register";
    }
    
    // 회원가입 완료
    @GetMapping("/signup/complete")
    public String completePage(@ModelAttribute("user") UserDoubleVO vo) {
    	System.out.println(">> 회원가입 완료 - completePage() -------------");
        return "user/signup/complete";
    }
    
    
    // 아이디 중복 확인
    @GetMapping("/signup/check-id")
    public ResponseEntity<Boolean> checkUserId(@RequestParam("userId") String userId) {
    	boolean isDuplicate = userService.checkUserId(userId);
    	return ResponseEntity.ok(isDuplicate);
    }

    // 회원가입 완료 처리
    @PostMapping("/signup/register")
    public String registerUser(@ModelAttribute UserDoubleVO vo, @RequestParam("type") String type, RedirectAttributes redirectAttributes) {
        // 생년월일 설정
        String userBirth = String.format("%04d/%02d/%02d",
            Integer.parseInt(vo.getBirthYear()),
            Integer.parseInt(vo.getBirthMonth()),
            Integer.parseInt(vo.getBirthDay()));
        vo.setUserBirth(userBirth);
        
        // 휴대폰 번호
        String userPhoneNum = vo.getUserPhoneNum1() + "-" + vo.getUserPhoneNum2() + "-" + vo.getUserPhoneNum3();
        String guardianPhoneNum = vo.getGuardianPhoneNum1() + "-" + vo.getGuardianPhoneNum2() + "-" + vo.getGuardianPhoneNum3();
        vo.setUserPhoneNum(userPhoneNum);
        vo.setGuardianPhoneNum(guardianPhoneNum);
        
        // 이메일 설정
        String userEmail = vo.getEmail1() + "@" + vo.getEmail2();
        String guardianEmail = vo.getGuardianEmail1() + "@" + vo.getGuardianEmail2();
        vo.setUserEmail(userEmail);
        vo.setGuardianEmail(guardianEmail);

        // 주소 설정
        System.out.println("받은 주소 : " + vo.getUserAddress());
        
        // 기본 이미지 설정
        vo.setUserImg("@profile_default");

        // 약관 동의 기본 설정
        vo.setSendState("Y");
    	
        if ("adult".equals(type)) {
        	userService.insertAdultUser(vo);
        } else if ("youth".equals(type)) {
        	userService.insertYouthUser(vo);
        }
        redirectAttributes.addFlashAttribute("message", "회원가입 완료");
        return "redirect:complete";
    }

	
}
