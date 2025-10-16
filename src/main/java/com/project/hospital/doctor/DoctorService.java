package com.project.hospital.doctor;

import java.util.Map;

import javax.servlet.http.HttpSession;

import com.project.hospital.admin.dto.DoctorEmailDTO;

public interface DoctorService {
	public Map<String, String> authenticateByEmail(DoctorEmailDTO doctorEmailDTO, HttpSession session);
	public Map<String, String> verifyCode(String inputCode, HttpSession session);
	public Map<String, String> changeDrPwd(Map<String, String> changePwdMap, HttpSession session);
}
