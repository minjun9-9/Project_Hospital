package com.project.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.hospital.admindrMain.dto.AdminDrMainQnaDTO;
import com.project.hospital.admindrMain.dto.QnaCountDTO;

@Mapper
public interface QnaMapperDAO {

	QnaCountDTO getTotalAndCompleteCount(Map<String, String> optionMap);

	List<AdminDrMainQnaDTO> getQnaDescThirdList(Map<String, String> optionMap);

	Map<String, Integer> getQnaCnt(Map<String, String> optionMap);


}
