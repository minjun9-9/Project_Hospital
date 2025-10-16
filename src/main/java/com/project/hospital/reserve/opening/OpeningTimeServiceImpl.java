package com.project.hospital.reserve.opening;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.dao.OpeningTimeDAO;
import com.project.hospital.dao.OpeningTimeMapperDAO;
import com.project.hospital.vo.OpeningTimeVO;

@Service
@Transactional(readOnly = true)
public class OpeningTimeServiceImpl implements OpeningTimeService {

	private final OpeningTimeMapperDAO dao;
	private final OpeningTimeDAO openingTimeDAO;
	
	@Autowired
	public OpeningTimeServiceImpl(OpeningTimeMapperDAO dao, OpeningTimeDAO openingTimeDAO) {
		super();
		this.dao = dao;
		this.openingTimeDAO = openingTimeDAO;
	}

	/**
	 * drId를 통해 진료시간표 조회
	 */
	@Override
	public List<OpeningTimeVO> getListByDrIdAndDate(String drId, String date) {
		
		date = date + "%";
		Map<String, String> optionMap = new HashMap<String, String>();
		optionMap.put("drId", drId);
		optionMap.put("date", date);
		
		return dao.getListByDrIdAndDate(optionMap);
	}

	
	
	/**
	 *  변경된 스케줄 insert
	 */
	@Override
	public void insertSchedule(List<String> timeIdList, String insertStatus, String date, String drId) {
		
		Map<String, Object> optionMap = new HashMap<String, Object>();
		optionMap.put("timeIdList", timeIdList);
		optionMap.put("status", insertStatus);
		optionMap.put("date", date);
		optionMap.put("drId", drId);
		
		dao.insertSchedule(optionMap);
	}
	
	/**
	 *  변경된 스케줄 update
	 */

	@Override
	public void updateSchedule(List<String> timeIdList, String updateStatus, String date, String drId) {
		
		Map<String, Object> optionMap = new HashMap<String, Object>();
		optionMap.put("timeIdList", timeIdList);
		optionMap.put("status", updateStatus);
		optionMap.put("date", date);
		optionMap.put("drId", drId);
		
		dao.updateSchedule(optionMap);
		
	}
	
	
	// 통합 후 추가
	@Override
	public List<String> openingTimeList(OpeningTimeVO vo) {
		return openingTimeDAO.openingTimeList(vo);
	}
	
	@Override
	public void openingTimeImpossibleUpdate(String otId) {
		openingTimeDAO.openingTimeImpossibleUpdate(otId);
	}
	
	@Override
	public void openingTimePossibleUpdate(String otId) {
		openingTimeDAO.openingTimePossibleUpdate(otId);
	}
	
	
	
}
