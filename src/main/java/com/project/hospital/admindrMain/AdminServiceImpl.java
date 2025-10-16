package com.project.hospital.admindrMain;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.admindrMain.dto.LoginResultDTO;
import com.project.hospital.dao.AdminMapperDAO;

@Service
@Transactional(readOnly = true)
public class AdminServiceImpl implements AdminService{
		
	private final AdminMapperDAO dao;
	
	@Autowired
	public AdminServiceImpl(AdminMapperDAO dao) {
		super();
		this.dao = dao;
	}

	/**
	 *	로그인 id,pw 검증
	 */
	@Override
	public LoginResultDTO findByIdAndPw(String id, String pw) {
		
		Map<String, String> optionMap = new HashMap<String, String>();
		optionMap.put("id", id);
		optionMap.put("pw", pw);
		
		LoginResultDTO resultDto = dao.findByIdAndPw(optionMap);
		
		if (resultDto == null) {
			resultDto = new LoginResultDTO();
		}
		resultDto.setType("admin");
		return resultDto;
	}
	
	
	
}
