package com.project.hospital.doctor;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.project.hospital.admin.dto.DoctorEmailDTO;
import com.project.hospital.dao.DoctorCareDAO;
import com.project.hospital.email.EmailSendForPassword;

@Service("doctorService")
public class DoctorServiceImpl implements DoctorService{
	private DoctorCareDAO doctorCareDAO;
	
	@Autowired
	public DoctorServiceImpl(DoctorCareDAO doctorCareDAO) {
		this.doctorCareDAO = doctorCareDAO;
	}
	
	@Override
	public Map<String, String> authenticateByEmail(DoctorEmailDTO doctorEmailDTO, HttpSession session) {
		Map<String, String> message = new HashMap<String, String>();
		EmailSendForPassword emailSendForPassword = new EmailSendForPassword();
		// 발신자 이메일 계정 및 비밀번호 (또는 앱 비밀번호)
        String fromEmail = doctorEmailDTO.getEmail();
        String password = doctorEmailDTO.getEmailPwd();
        
        // 수신자 정보 및 이메일 내용
        String toEmail = "jinee5050@naver.com";
        String subject = "Authentication Email from Project-Hospital";
        String authenticationCode = UUID.randomUUID().toString();
        LocalDateTime expirationTime = LocalDateTime.now().plusMinutes(1); //일단 테스트용으로 1분설정
        
        session.setAttribute("authenticationCode", authenticationCode);
        session.setAttribute("expirationTime", expirationTime);
        
        // 이메일 전송
        try {
			emailSendForPassword.sendEmail(fromEmail, password, toEmail, subject, authenticationCode);
		} catch (Exception e) {
			message.put("result", "fail");
			message.put("msg", "인증 요청에 실패 했습니다");
			e.printStackTrace();
			return message;
		}
        message.put("result", "success");
		message.put("msg", "인증 요청을 보냈습니다" + "\n" + "이메일을 확인해 주세요");
		return message;
	}
	
	/**
	 * 인증값 비교처리
	 */
	@Override
	public Map<String, String> verifyCode(String inputCode, HttpSession session) {
		Map<String, String> message = new HashMap<String, String>();
		boolean isValid = isAuthenticationCodeValid(inputCode, session);
		
		if (isValid) {
			message.put("result", "success");
			message.put("msg", "인증 완료");
		} else {
			message.put("result", "fail");
			message.put("msg", "인증 실패");
		}
		return message;
	}
	
	
	
	/**
	 * 세션을통해 인증코드 일치 여부 확인 및 만료 확인 메소드
	 */
	private boolean isAuthenticationCodeValid(String inputCode, HttpSession session) {
		String storedCode = (String)session.getAttribute("authenticationCode");
		LocalDateTime expirationTime = (LocalDateTime)session.getAttribute("expirationTime");
		
		//인증번호 없음
		if (storedCode == null || expirationTime == null) {
			return false;
		}
		
		//인증코드 만료시간 확인
		if (LocalDateTime.now().isAfter(expirationTime)) {
			session.removeAttribute("authenticationCode");
			session.removeAttribute("expirationTime");
			return false;
		}
		
		return storedCode.equals(inputCode);
	}

	/**
	 * 의료진 비밀번호 변경
	 */
	@Override
	public Map<String, String> changeDrPwd(Map<String, String> changePwdMap, HttpSession session) {
		Map<String, String> message = new HashMap<String, String>();
		if (changePwdMap == null || changePwdMap.get("drId") == null) {
			message.put("result", "fail"); 
			message.put("msg", "비밀번호 변경을 하지 못했습니다"); 
			return message;
		}
		
		boolean hasLowercase = Pattern.compile("[a-z]").matcher(changePwdMap.get("changePwdValue")).find();
		boolean hasUppercase = Pattern.compile("[A-Z]").matcher(changePwdMap.get("changePwdValue")).find();
		boolean hasSpecialCharacter = Pattern.compile("[^a-zA-Z0-9]").matcher(changePwdMap.get("changePwdValue")).find();
		System.out.println(hasLowercase + " : " + hasUppercase + " : " + hasSpecialCharacter);
		if (!hasLowercase && !hasUppercase && !hasSpecialCharacter) {
			message.put("result", "fail"); 
			message.put("msg", "비밀번호 변경을 하지 못했습니다"); 
			return message;
		}
		
		if (changePwdMap.get("changePwdValue").length() < 8 || changePwdMap.get("changePwdValue").length() > 20) {
			message.put("result", "fail"); 
			message.put("msg", "비밀번호 변경을 하지 못했습니다"); 
			return message;
		}
		
		try {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			changePwdMap.put("hashPw", encoder.encode(changePwdMap.get("changePwdValue")));
			System.out.println(changePwdMap);
			boolean test1 = encoder.matches(changePwdMap.get("changePwdValue"), changePwdMap.get("changePwdValue"));
			boolean test2 = encoder.matches(changePwdMap.get("changePwdValue"), changePwdMap.get("hashPw"));
			System.out.println(test1 + " : " + test2);
			
			int result = doctorCareDAO.changeDrPwd(changePwdMap);
			message.put("result", "success");
			if (result >= 0) { 
				message.put("msg","비밀번호가 변경되었습니다" + "\n" + "다시 로그인해 주세요");
				session.invalidate();
			}
		} catch (Exception e) {
			message.put("result", "fail"); 
			message.put("msg", "비밀번호 변경을 하지 못했습니다" + "\n" + "담당자에게 문의 하세요"); 
		}
		
		
		 
		return message;
	}


	

	
}
