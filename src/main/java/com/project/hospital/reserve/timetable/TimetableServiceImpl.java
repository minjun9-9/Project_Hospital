package com.project.hospital.reserve.timetable;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.dao.TimetableDAO;
import com.project.hospital.reserve.dto.TimeDateDTO;
import com.project.hospital.vo.TimetableVO;

@Service
@Transactional(readOnly = true)
public class TimetableServiceImpl implements TimetableService {
	
	private final TimetableDAO dao;
	
	@Autowired
	public TimetableServiceImpl(TimetableDAO dao) {
		super();
		this.dao = dao;
	}
	
	/**
	 *  타임테이블 전체 조회
	 */
	@Override
	public List<TimetableVO> getList() {
		
		return dao.getList();
	}

	@Override
	public List<TimeDateDTO> findReservSchedule(String userNum, String date) {
		
		date = date + "%";
		Map<String, String> optionMap = new HashMap<String, String>();
		optionMap.put("userNum", userNum);
		optionMap.put("date", date);
		
		return dao.findReservSchedule(optionMap);
	}
	
	
	
}
