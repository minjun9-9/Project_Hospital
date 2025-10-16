package com.project.hospital.reserve;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.admindrMain.dto.MainPageReservDTO;
import com.project.hospital.dao.ReservationDAO;
import com.project.hospital.dao.ReservationMapperDAO;
import com.project.hospital.dto.ReservationDTO;
import com.project.hospital.vo.ReservationVO;

@Service
@Transactional(readOnly = true)
public class ReservationServiceImpl implements ReservationService {
	
	private final ReservationMapperDAO dao;
	private final ReservationDAO reservationDAO;
	
	@Autowired
	public ReservationServiceImpl(ReservationMapperDAO dao, ReservationDAO reservationDAO) {
		super();
		this.dao = dao;
		this.reservationDAO = reservationDAO;
	}
	
	/**
	 * drId를 이용해 예약 리스트 추출 
	 */
	@Override
	public List<ReservationVO> getListByDrId(String drId) {
		
		return dao.getListByDrId(drId);
	}

	/**
	 * drId, date를 이용해 예약 리스트 추출 
	 */
	@Override
	public List<String> getOtIdListByDrIdAndDate(String drId, String date) {
		
		date = date + "%";
		Map<String, Object> optionMap = new HashMap<String, Object>();	
		optionMap.put("drId", drId);
		optionMap.put("date", date);
		
		return dao.getOtIdListByDrIdAndDate(optionMap);
	}

	/**
	 * [의료관리자 메인페이지]
	 * 오늘 / 이번달 예약 횟수, 예약과 부재 cnt와 그 노쇼비율, 예약접수확인 고객전화번호, 예약, 시간
	 */
	@Override
	public MainPageReservDTO getMainReservData() {
		
		// 오늘 / 이번달 예약한 횟수
		Map<String, Integer> totalReservCnt = dao.getCntTodayMonth(createCntMapper());
		
		
		
		
		// 오늘 / 이번달 예약인 횟수 | 0: 오늘, 1: 이번달
		List<Map<String, Integer>> reservCnt = dao.getCntReserv(createVisitCntMapper());
		
		// 오늘 / 오늘 (현시간까지)/ 이번달 방문횟수
		List<Map<String, Integer>> visitCnt = dao.getCntVisit(createVisitCntMapper());
		
		// 예약접수확인 고객전화번호, 몇분 전 예약
		List<Map<String, String>> reservPhoneTimeMap = dao.getReservPhoneAndTime(createCntMapper());
		
		// 클라이언트에 반환할 객체 생성
		MainPageReservDTO mainPageReservDto = new MainPageReservDTO();
		
		// 오늘 / 이번달 예약 횟수 셋
		mainPageReservDto.setTodayReservCnt(Integer.parseInt(String.valueOf(totalReservCnt.get("TODAY_CNT"))));
		mainPageReservDto.setMonthReservCnt(Integer.parseInt(String.valueOf(totalReservCnt.get("MONTH_CNT"))));
		
		// 예약과 부재 계산 | 비율 계산 
		calculatorNoShowCntSet(visitCnt, reservCnt, mainPageReservDto);
		
		// 몇분전 계산 
		mainPageReservDto.setReservPhoneAndTime(createTime(reservPhoneTimeMap));
		
		return mainPageReservDto;
	}
	

	/**
	 * 편의 메서드
	 */
	
	// 몇분전 계산
	private List<Map<String, String>> createTime(List<Map<String, String>> reservPhoneTimeMap) {
		
		
		for (Map<String, String> map : reservPhoneTimeMap) {
			
			map.put("time", caculatorDateTime(String.valueOf(map.get("CREATED_AT"))));
		}
		
		return reservPhoneTimeMap;
	}
	
	// 메인 페이지 시간표시 계산 후 삽입 (현 시간 몇분 전인지)
	private String caculatorDateTime(String createdAt) {
		
		 /**
         *  1시간 이내면 분표시
         *  24시간 이내면 시간표시
         *  이상이면 일표시
         */

        // 현재 날짜와 시간
        LocalDate ld = LocalDate.now();
        LocalTime lt = LocalTime.now();
        
        // db에서 넘어온 값 파싱
        LocalDate date = LocalDate.parse(createdAt.substring(0, 10));
        LocalTime time = LocalTime.parse(createdAt.substring(11, 19));
        
        // 몇일 전인지 계산
        Period betweenDate = Period.between(date, ld);

        // 당일이 아닌 경우 일로 표시
        if (0 < betweenDate.getDays()){
        	
            return betweenDate.getDays() + "일전";
            
            // 당일인 경우
        } else {
        	
            long betweenMinutes = ChronoUnit.MINUTES.between(time, lt);
            // 60분이상인지 확인
            if (60 < betweenMinutes){
            	// 이상인 경우 시간으로 표시
                return (betweenMinutes / 60) + "시간전";
            } else {
            	// 아닌 경우 분으로 표시
            	return betweenMinutes + "분전";
            }
        }
	}
	
	// 예약과 부재 계산 | 비율 계산
	private void calculatorNoShowCntSet(List<Map<String, Integer>> visitCnt,
			List<Map<String, Integer>> reservCnt, MainPageReservDTO mainPageReservDto) {
		
		
		
		// 예약과 부재 cnt와 그 노쇼비율 | 0: 오늘, 1: 이번달
		int todayReservCnt = Integer.parseInt(String.valueOf(reservCnt.get(0).get("RESERV_CNT")));
		int todayReservCntUntilNow = Integer.parseInt(String.valueOf(reservCnt.get(1).get("RESERV_CNT")));
		int monthReservCnt = Integer.parseInt(String.valueOf(reservCnt.get(2).get("RESERV_CNT")));
		
		int todayVisitCntUntilNow = Integer.parseInt(String.valueOf(visitCnt.get(0).get("VISIT_CNT")));
		int monthVisitCnt = Integer.parseInt(String.valueOf(visitCnt.get(1).get("VISIT_CNT")));
		
		// 오늘 (현시간까지) 부재인 수 | 부재  = 예약수(현시간까지) - 방문(현시간까지)
		int todayNoShowUntilNow = todayReservCntUntilNow - todayVisitCntUntilNow;
		
		// 이번달 부재인 수
		int monthNoShow = monthReservCnt - monthVisitCnt;
		
		// 방문율 퍼센트 계산
		double todayNoShowPer = ((double) todayVisitCntUntilNow / (double) todayReservCntUntilNow) * 100.0;
		double monthNoShowPer = ((double) monthVisitCnt / (double) monthReservCnt) * 100.0;
		
		// DTO set
		mainPageReservDto.setD_DayReservCnt(todayReservCnt);
		mainPageReservDto.setD_DayShowCnt(todayVisitCntUntilNow);
		mainPageReservDto.setD_DayNoShowCnt(todayNoShowUntilNow);
		
		mainPageReservDto.setD_MonthReservCnt(monthReservCnt);
		mainPageReservDto.setD_MonthShowCnt(monthVisitCnt);
		mainPageReservDto.setD_MonthNoShowCnt(monthNoShow);
		mainPageReservDto.setD_DayNoShowPercent((int) Math.round(todayNoShowPer));
		mainPageReservDto.setD_MonthNoShowPercent((int) Math.round(monthNoShowPer));
		
	}
		
	
	//예약과 부재 횟수 매퍼
	private Map<String, String> createVisitCntMapper() {
		
		LocalDate today = LocalDate.now();
		LocalTime todayTime = LocalTime.now();
		
		Map<String, String> optionMap = new HashMap<String, String>();
		optionMap.put("today", today.toString());
		optionMap.put("month", today.toString().substring(0, 7) + "%");
		optionMap.put("time", todayTime.toString().substring(0, 5));
		
		System.out.println("[createVisitCntMapper] optionMap : " + optionMap);
		return optionMap;
	}
	
	// 메인페이지 오늘 / 이번달 예약 횟수 매퍼
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
	
	// 통합 후 추가
	@Override
	public List<ReservationVO> reservationList(ReservationVO vo) {
		return reservationDAO.reservationList(vo);
	}
	
	@Override
	public ReservationVO reservationInsertCheck(ReservationDTO dto) {
		return reservationDAO.reservationInsertCheck(dto);
	}
	
	@Override
	public void reservationInsert(ReservationVO vo) {
		reservationDAO.reservationInsert(vo);
	}
	
	@Override
	public void reservationDelete(ReservationVO vo) {
		reservationDAO.reservationDelete(vo);
	}
	
}
