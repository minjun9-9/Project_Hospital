package com.project.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.hospital.admin.dto.HpMemberInfoDTO;
import com.project.hospital.admindrMain.dto.LoginResultDTO;

@Mapper
public interface HpMemberMapperDAO {
	
	List<HpMemberInfoDTO> findListDtoAll();

	LoginResultDTO findByIdAndPw(Map<String, String> optionMap);
	

}
