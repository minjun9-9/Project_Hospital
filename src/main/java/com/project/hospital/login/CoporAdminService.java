package com.project.hospital.login;

import com.project.hospital.login.dto.AdminDTO;
import com.project.hospital.vo.HpMemberVO;

public interface CoporAdminService {
	AdminVO getUser(AdminDTO admin);
	HpMemberVO getHpMember(AdminDTO admin);
}
