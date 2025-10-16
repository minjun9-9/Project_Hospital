package com.project.hospital.admindrMain;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.project.hospital.admindrMain.dto.AdminDrMainLogInDTO;
import com.project.hospital.admindrMain.dto.QnaCountDTO;

public interface AdminDrMainService {

	String findByIdAndPw(AdminDrMainLogInDTO logindto, Model model, HttpServletRequest request);

	
	
}
