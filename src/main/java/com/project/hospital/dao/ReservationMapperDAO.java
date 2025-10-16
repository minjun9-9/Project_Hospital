package com.project.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.hospital.vo.ReservationVO;

@Mapper
public interface ReservationMapperDAO {
	
	
	List<ReservationVO> getListByDrId(String drId);

	List<String> getOtIdListByDrIdAndDate(Map<String, Object> optionMap);

	Map<String, Integer> getCntTodayMonth(Map<String, String> createCntMapper);
	
	List<Map<String, Integer>> getCntVisit(Map<String, String> visitCntMapper);
	List<Map<String, Integer>> getCntReserv(Map<String, String> visitCntMapper);

	List<Map<String, String>> getReservPhoneAndTime(Map<String, String> createCntMapper);

	
}
