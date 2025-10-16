package com.project.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.hospital.reserve.dto.TimeDateDTO;
import com.project.hospital.vo.TimetableVO;

@Mapper
public interface TimetableDAO {
	
	List<TimetableVO> getList();

	List<TimeDateDTO> findReservSchedule(Map<String, String> optionMap);

}
