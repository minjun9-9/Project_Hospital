package com.project.hospital.login.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.login.AdminVO;
import com.project.hospital.login.CoporAdminService;
import com.project.hospital.login.dto.AdminDTO;
import com.project.hospital.vo.HpMemberVO;

@Service("coporAdminService")
public class CoporAdminServiceImpl implements CoporAdminService {
	
	@Autowired
	private AdminDAO adminDAO;
	
	public CoporAdminServiceImpl() {
		System.out.println("AdminServiceImpl() 실행");
	}

	@Override
	public AdminVO getUser(AdminDTO admin) {
		return adminDAO.getUser(admin);
	}

	@Override
	public HpMemberVO getHpMember(AdminDTO admin) {
		return adminDAO.getHpMember(admin);
	}

}
