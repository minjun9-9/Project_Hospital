package com.project.hospital.view.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.hospital.vo.RecordVO;
import com.project.hospital.vo.ReservationVO;
import com.project.hospital.dto.ReservationDTO;
import com.project.hospital.user.UserService;
import com.project.hospital.user.UserDoubleVO;

@Controller
@RequestMapping("/user")
public class UserPageController {
	
	@Autowired
	private UserService userService;
	
	public UserPageController() {
		System.out.println("===== UserPageController() 객체 생성");
	}
	
	@Autowired
	public UserPageController(UserService userService) {
		System.out.println("===== UserPageController(UserService) 객체 생성");
		this.userService = userService;
	}
	
	// 마이페이지 이동
    @GetMapping("/userpage/userpage")
    public String userPage(HttpSession session, Model model) {
    	System.out.println(">> 마이페이지 화면 이동 - userPage() -------------");
    	UserDoubleVO user = (UserDoubleVO) session.getAttribute("user");
    	if (user == null) {
    		return "redirect:user/login/login";
    	}
    	
    	int userNum = user.getUserNum();
    	
    	// 기본 정보
    	UserDoubleVO userInfo = userService.getUserInfo(userNum);
    	model.addAttribute("userInfo", userInfo);
    	
    	// 예약 현황 
    	ReservationDTO reservation = userService.getReservationHistory(userNum);
    	model.addAttribute("reservation", reservation);
    	
    	// 진료 현황
    	RecordVO record = userService.getRecordHistory(userNum);
    	model.addAttribute("record", record);
    	
        return "user/userpage/userpage";
    }
    
	// 내정보 변경페이지 이동
    @GetMapping("/userpage/usermodify")
    public String usermodifyPage(HttpSession session, Model model) {
    	System.out.println(">> 내 정보 수정 화면 이동 - usermodifyPage() -------------");
    	UserDoubleVO user = (UserDoubleVO) session.getAttribute("user");
    	System.out.println("user : " + user);
    	if (user == null) {
    		return "redirect:user/login/login";
    	}
    	
    	// 기본 정보
    	int userNum = user.getUserNum();
    	UserDoubleVO userInfo = userService.getUserInfo(userNum);
    	model.addAttribute("userInfo", userInfo);
    	
    	String userPhone = user.getUserPhoneNum();
    	String[] phoneParts = userPhone.split("-");
    	
    	model.addAttribute("userPhoneNum1", phoneParts[0]);
    	model.addAttribute("userPhoneNum2", phoneParts[1]);
    	model.addAttribute("userPhoneNum3", phoneParts[2]);
    	
    	String userEmail = user.getUserEmail();
    	String[] emailParts = userEmail.split("@");
    	
    	model.addAttribute("userMainAddress", emailParts[0]);
    	model.addAttribute("userDetailAddress", emailParts[1]);
    	
        return "user/userpage/usermodify";
    }
    
    @PostMapping("/userpage/validatePassword")
    @ResponseBody
    public Map<String, Boolean> validatePassword(@RequestBody Map<String, String> requestBody, HttpSession session) {
        String userPw = requestBody.get("userPw");
        UserDoubleVO user = (UserDoubleVO) session.getAttribute("user");
        
        Map<String, Boolean> response = new HashMap<String, Boolean>();
        if (user != null && userService.checkPassword(user.getUserId(), userPw)) {
            response.put("valid", true);
        } else {
            response.put("valid", false);
        }
        return response;
    }
    
    // 기본 정보 수정 처리
    @PostMapping("/userpage/usermodify")
    public String updateUser(@RequestParam("userId") String userId,
                             @RequestParam("userPw") String userPw,
                             @RequestParam("userPhoneNum") String userPhoneNum,
                             @RequestParam("userEmail") String userEmail,
                             HttpSession session, RedirectAttributes redirectAttributes) {
    	
        UserDoubleVO user = (UserDoubleVO) session.getAttribute("user");

        if (userService.checkPassword(user.getUserId(), userPw)) {
            user.setUserPhoneNum(userPhoneNum);
            user.setUserEmail(userEmail);
            userService.updateUser(user);
            redirectAttributes.addFlashAttribute("success", "회원정보가 수정되었습니다.");
            return "redirect:userpage";
        } else {
            redirectAttributes.addFlashAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "redirect:usermodify";
        }
    }
    
	// 비밀번호 변경페이지 이동
    @GetMapping("/userpage/passwordmodify")
    public String passwordmodifyPage(HttpSession session, Model model) {
    	System.out.println(">> 내 정보 수정 화면 이동 - passwordmodifyPage() -------------");
    	UserDoubleVO user = (UserDoubleVO) session.getAttribute("user");
    	if (user == null) {
    		return "redirect:user/login/login";
    	}
    	
    	int userNum = user.getUserNum();
    	
    	// 기본 정보
    	UserDoubleVO userInfo = userService.getUserInfo(userNum);
    	model.addAttribute("userInfo", userInfo);
        return "user/userpage/passwordmodify";
    }
    
    // 비밀번호 변경 처리
    @PostMapping("/userpage/passwordmodify")
    public String updatePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 HttpSession session, Model model) {
        UserDoubleVO loginUser = (UserDoubleVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/user/login";
        }

        boolean result = userService.updatePassword(loginUser.getUserId(), currentPassword, newPassword);
        if (result) {
            model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        } else {
            model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
        }
        return "passwordmodify";
    }
    
	// 회원탈퇴 페이지 이동
    @GetMapping("/userpage/memberleave")
    public String memberLeavePage(HttpSession session, Model model) {
    	System.out.println(">> 내 정보 수정 화면 이동 - memberLeavePage() -------------");
    	UserDoubleVO user = (UserDoubleVO) session.getAttribute("user");
    	if (user == null) {
    		return "redirect:user/login/login";
    	}
    	
    	int userNum = user.getUserNum();
    	
    	// 기본 정보
    	UserDoubleVO userInfo = userService.getUserInfo(userNum);
    	model.addAttribute("userInfo", userInfo);
        return "user/userpage/memberleave";
    }
    
    // 회원 탈퇴 처리
    @PostMapping("/memberleave")
    public String deleteUser(@RequestParam String confirmPassword, HttpSession session, Model model) {
        UserDoubleVO loginUser = (UserDoubleVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/user/login";
        }

        boolean deleted = userService.deleteUser(loginUser.getUserId(), confirmPassword);
        if (deleted) {
            session.invalidate();
            return "redirect:/user/login?deleted";
        } else {
            model.addAttribute("error", "비밀번호가 일치하지 않거나 삭제에 실패했습니다.");
            return "user/userpage/memberleave";
        }
    }
    

}
