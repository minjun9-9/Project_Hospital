package com.project.hospital.admindrMain;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.dao.ExaminationDAO;

@Service
@Transactional(readOnly = true)
public class ExaminationServiceImpl implements ExaminationService{

	private final ExaminationDAO dao;
	
	@Autowired
	public ExaminationServiceImpl(ExaminationDAO dao) {
		super();
		this.dao = dao;
	}

	/**
	 * 메인페이지 새글/이번달 cnt 추출 
	 */
	@Override
	public Map<String, Integer> getExamCnt() {
		
		return dao.getExamCnt(createCntMapper());
	}
	
	// 메인페이지 새글/이번달 cnt DB 조건에 넣을 매퍼 생성
	private Map<String, String> createCntMapper() {
		
		String start = " 00:00:00";
		String end = " 23:59:59";
				
		LocalDate today = LocalDate.now();
		
		// 해당월에 맞는 끝일 넣기
		LocalDate firstDay = LocalDate.of(today.getYear(), today.getMonthValue(), 1);
        LocalDate LastDay = LocalDate.of(today.getYear(), today.getMonthValue() + 1, 1).minusDays(1);
		
		Map<String, String> optionMap = new HashMap<String, String>();
		optionMap.put("todayStart", today.toString() + start);
		optionMap.put("todayEnd", today.toString() + end);
		optionMap.put("monthStart", firstDay.toString() + start);
		optionMap.put("monthEnd", LastDay.toString() + end);
		
		return optionMap;
	}
	
	

}
