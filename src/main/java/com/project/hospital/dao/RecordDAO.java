package com.project.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.hospital.mypage.dto.ResponseRecordDTO;

@Mapper
public interface RecordDAO {

	int getRecordCount(Map<String, String> optionMap);

	List<ResponseRecordDTO> findRecordListForPage(Map<String, Object> setMapperForPage);
	

}
