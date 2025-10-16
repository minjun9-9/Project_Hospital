package com.project.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.hospital.admindrMain.dto.MonthCntDTO;
import com.project.hospital.admindrMain.dto.UserJoinCntGraphDTO;

@Mapper
public interface UserClientMapperDAO {

	UserJoinCntGraphDTO getJoinCnt(Map<String, String> optionMap);

	List<MonthCntDTO> getGraphCnt(Map<String, Object> graphOptionMap);

}
