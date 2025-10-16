package com.project.hospital.admindrMain;

import com.project.hospital.admindrMain.dto.LoginResultDTO;

public interface AdminService {

	LoginResultDTO findByIdAndPw(String id, String pw);
	
}
