package com.project.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.hospital.vo.OpeningTimeVO;

@Mapper
public interface OpeningTimeMapperDAO {
	
	List<OpeningTimeVO> getListByDrIdAndDate(Map<String, String> optionMap);

	void insertSchedule(Map<String, Object> optionMap);

	void updateSchedule(Map<String, Object> optionMap);

}
