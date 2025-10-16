package com.project.hospital.admindrMain;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.admindrMain.dto.MonthCntDTO;
import com.project.hospital.admindrMain.dto.UserJoinCntGraphDTO;
import com.project.hospital.dao.UserClientMapperDAO;

@Service
@Transactional(readOnly = true)
public class UserClinetServiceImpl implements UserClinetService{
	
	private final UserClientMapperDAO dao;
	
	@Autowired
	public UserClinetServiceImpl(UserClientMapperDAO dao) {
		super();
		this.dao = dao;
	}


	/**
	 * [의료관리자 메인페이지] 회원 가입수 + 그래프로 보기
	 */
	@Override
	public UserJoinCntGraphDTO getJoinCntAndGraph() {
		
		/**
		 * 회원 가입 수  오늘/이번달/전체
		 */
		// DB 조건에 넣을 매퍼 생성 후 데이터 추출
		UserJoinCntGraphDTO dto = dao.getJoinCnt(createJoinCntMapper());
		
		/**
		 *  그래프로 보기 (회원수)
		 *  기준일 최근 2년 
		 *  연도별/월별cnt 
		 */
		// 최근 2년 연도별 월별 cnt 추출
		List<MonthCntDTO> monthdto = dao.getGraphCnt(createGraphCntMapper());
		
		// 그래프 리스트 추가, 연도 삽입
		dto.setGraphList(setYear(monthdto));
		
		return dto;
	}

	/**
	 * 편의 메서드
	 */
	public List<MonthCntDTO> setYear(List<MonthCntDTO> monthdto) {
		
		// 현재 날짜
        LocalDate today = LocalDate.now();
        monthdto.get(0).setYear(String.valueOf(today.minusYears(2).getYear()));
        monthdto.get(1).setYear(String.valueOf(today.minusYears(1).getYear()));
        monthdto.get(2).setYear(String.valueOf(today.minusYears(0).getYear()));
        
        // 리스트 순서 바꾸기 
        List<MonthCntDTO> result = new ArrayList<MonthCntDTO>();
        for(int i = (monthdto.size() - 1); 0 <= i; i--) {
        	result.add(monthdto.get(i));
        }
        
        return result;
	}
	
	// 회원가입 수 그래프 표현  DB 조건에 넣을 매퍼 생성
	private Map<String, Object> createGraphCntMapper() {
		
		// 현재 날짜
        LocalDate today = LocalDate.now();

        List<String> years = new LinkedList<String>(); 
        years.add(String.valueOf(today.getYear()));
        years.add(String.valueOf(today.minusYears(1).getYear()));
        years.add(String.valueOf(today.minusYears(2).getYear()));
        
        List<String> months = Arrays.asList("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12");
        
        Map<String, Object> optionMap = new HashMap<String, Object>();
        optionMap.put("years", years);
        optionMap.put("months", months);
        
		return optionMap;
	}

	// 회원가입 수  DB 조건에 넣을 매퍼 생성
	private Map<String, String> createJoinCntMapper() {
		
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
