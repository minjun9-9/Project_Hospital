package com.project.hospital.view.doctor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.hospital.admin.HpMemberService;
import com.project.hospital.admin.dto.DoctorEmailDTO;
import com.project.hospital.admindrMain.dto.LoginResultDTO;
import com.project.hospital.doctor.DoctorService;

@RestController
public class DoctorAjaxController {
	
	private final HpMemberService service;
	private final DoctorService doctorService;
	
	@Autowired
	public DoctorAjaxController(HpMemberService service, DoctorService doctorService) {
		this.service = service;
		this.doctorService = doctorService;
	}
	
	
	//통합 이후 변경
	@PostMapping("/updateDrInfo")
	public Map<String, String> updateDrInfo(
			@RequestParam("updateDrInfo") String updateDrInfoJson,
			@RequestParam(value = "profileImage", required = false) List<MultipartFile> profileImage) {
		
		
		return service.updateDrInfo(updateDrInfoJson, profileImage);
	}
	
	/**
	 * 이메일로 인증 코드 발급
	 */
	@PostMapping("/authenticateByEmail")
	public Map<String, String> authenticateByEmail(@RequestBody DoctorEmailDTO doctorEmailDTO, HttpSession session) {
		return doctorService.authenticateByEmail(doctorEmailDTO, session);
	}
	
	/**
	 * 이메일에서 받은 인증 코드 확인
	 */
	@PostMapping("/verifyCode")
	public Map<String, String> verifyCode(@RequestBody Map<String, String> inputMap, HttpSession session) {
		String inputCode = inputMap.get("authenticateNumInputValue");
		
		return doctorService.verifyCode(inputCode, session);
	}
	
	/**
	 * 의료진 비밀 번호 변경
	 */
	@PostMapping("/changeDrPwd")
	public Map<String, String> changeDrPwd(@RequestBody Map<String, String> changePwdMap, HttpSession session) {
		LoginResultDTO loginResultDTO = (LoginResultDTO)session.getAttribute("resultDto");
		if (loginResultDTO != null) {
			if (loginResultDTO.getDrId() != null) {
				changePwdMap.put("drId", loginResultDTO.getDrId());
			} else {
				changePwdMap.put("drId", null);
			}
		} else {
			changePwdMap.put("drId", null);
		}
		
		return doctorService.changeDrPwd(changePwdMap, session);
	}

}
