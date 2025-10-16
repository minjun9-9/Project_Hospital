package com.project.hospital.admin;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.admin.dto.ChangeDateListDTO;
import com.project.hospital.admin.dto.HpMemberScheduleDTO;
import com.project.hospital.reserve.ReservationService;
import com.project.hospital.reserve.opening.OpeningTimeService;
import com.project.hospital.reserve.timetable.TimetableService;
import com.project.hospital.vo.OpeningTimeVO;
import com.project.hospital.vo.TimetableVO;

@Service
@Transactional(readOnly = true)
public class HpMemberScheduleServiceImpl implements HpMemberScheduleService {

	
	private final ReservationService reservService;
	private final TimetableService timeService;
	private final OpeningTimeService openTimeService;
	
	@Autowired
	public HpMemberScheduleServiceImpl(ReservationService reservService, TimetableService timeService,
			OpeningTimeService openTimeService) {
		super();
		this.reservService = reservService;
		this.timeService = timeService;
		this.openTimeService = openTimeService;
	}
	
	/*
	 *  선택한 의료진 스케줄 반환
	 */
	@Override
	public List<HpMemberScheduleDTO> findSchedule(String drId, String date) {
		// 입력받은 date 파싱
		String[] dates = date.split("-");
		
		LocalDate thisMonth = LocalDate.of(Integer.parseInt(dates[0]), Integer.parseInt(dates[1]), 1); // 선택된 월 
		LocalDate nextMonth = thisMonth.plusMonths(1); // 선택된 월 다음달
		
		// 선택된 월 과 다음 달의 일수
		long between = ChronoUnit.DAYS.between(thisMonth, nextMonth);
		
		// 전송할 리스트 객체 생성 
		List<HpMemberScheduleDTO> resultList = new ArrayList<HpMemberScheduleDTO>();
		// 시간 출력 => 오전, 오후 나누기 위해 추출
		List<TimetableVO> timeList = timeService.getList();
		// 의료진id, 검색조건의 date에 해당하는 진료시간표 추출
		List<OpeningTimeVO> openTimeList = openTimeService.getListByDrIdAndDate(drId, date);
        // 상세시간 리스트 
        List<DetailTime> detailTimeList = new ArrayList<DetailTime>();
        
        // 선택월과 다음달 사이의 일수를 통해 1 ~ 마지막일 까지 객체 생성
        for (int i = 0; i < between; i++){
            LocalDate localDate = thisMonth.plusDays(i); // 반복문 진행하며 하루씩 증가
            
            HpMemberScheduleDTO resultDto = new HpMemberScheduleDTO(); // 빈 객체 생성
            
            // 해당 날짜의 정원초과가 모두 일 경우 바꿔 주기 위한 셋팅
            Set<String> amCheck = new HashSet<String>();
            Set<String> pmCheck = new HashSet<String>();
            
            // 상세시간 리스트 오전, 오후
            DetailTime dt = new DetailTime();
            
            // 해당 의료진의 진료시간표
    		for (OpeningTimeVO otVO : openTimeList) {
    			
    			// 날짜가 같은 경우에는 가지고 있는 시간표 추출 
    			if (otVO.getYearDate().equals(localDate.toString())) {
    				
	    			// 오전, 오후 구분
	    			for (TimetableVO timeVO : timeList) {
	    				
	    				// opentime과 timetable 조인
	    				if(otVO.getTimetableId().equals(timeVO.getTimetableId())) {
	    					
	    						// 오전 시간대 추출
	    					if(timeVO.getTimeType().equals("오전")) {
	    						resultDto.addAmList(otVO.getOtId());
	    						resultDto.setAmStatus(otVO.getOtState());
	    						amCheck.add(otVO.getOtState());
	    						dt.addTimeListAM(otVO.getOtId(), timeVO.getTime());
	    						
	    					} else if (timeVO.getTimeType().equals("오후")){ 
	    						// 오후 시간대 추출
	    						resultDto.addPmList(otVO.getOtId());
	    						resultDto.setPmStatus(otVO.getOtState());
	    						pmCheck.add(otVO.getOtState());
	    						dt.addTimeListPM(otVO.getOtId(), timeVO.getTime());
	    					} 
	    					
	    				} // opentime과 timetable 조인
	    			} // 오전, 오후 구분 반복문
    			} // 날짜가 같은 경우 추출 
    		} // 해당 의료진의 진료시간표 반복문
    		
    		/**
    		 *  해당 날짜의 모든 상태가 정원초과이면 정원초과 표시 아닐 경우 정상진료
    		 *  휴진이 포함되어있으면 그냥 진행
    		 */
    		if (amCheck.size() == 2) {
    			
    			if(amCheck.contains("정원초과")) {    				
    				resultDto.setAmStatus("정상진료");
    			}
    		}
    		
    		if (pmCheck.size() == 2) {
    			
    			if(pmCheck.contains("정원초과")) {    				
    				resultDto.setPmStatus("정상진료");
    			}
    		}
    		
    		resultDto.setDate(localDate.toString()); // 날짜 셋팅
    		resultList.add(resultDto); // 반환할 리스트에 dto 담기
    		detailTimeList.add(dt); // 상세시간 객체 담기
    		
        }// 선택월과 다음달 사이의 일수를 통해 1 ~ 마지막일 까지 객체 생성 반복문
        
        // drId, date를 이용해 예약  otID 리스트 추출
        List<String> reservOtIdList = reservService.getOtIdListByDrIdAndDate(drId, date);
        
        // 예약리스트에서 otId 추출해서 결과 리스트에 추가
        for (int i = 0; i < between; i++){
        	
        	HpMemberScheduleDTO resultDto = resultList.get(i);
        	String inputDate = resultDto.getDate().substring(5);
        	
        	// 해당일에 맞는 오전,오후 otId
        	List<String> amOtIdList = resultDto.getAmOtIdList();
        	List<String> pmOtIdList = resultDto.getPmOtIdList();
        	
        	Map<String, String> amList = detailTimeList.get(i).getDetailTimeListAM();
        	Map<String, String> pmList =detailTimeList.get(i).getDetailTimeListPM();
        	
        	// 오전
        	for (String amOtId : amOtIdList) {
        		// otID에 알맞는 시간 추출
        		String time = amList.get(amOtId);
        		// 예약 리스트에 포함되어있는 지 확인
        		if (reservOtIdList.contains(amOtId)) {
        			
        			time = inputDate + " " + time + " &#9675;";
        			resultDto.addAmReservList(time);
        		} else {
        			time = inputDate + " " + time + " &#9679;";
        			resultDto.addAmReservList(time);
        		}
        	}
        	
        	// 오후
        	for (String pmOtId : pmOtIdList) {
        		// otID에 알맞는 시간 추출
        		String time = pmList.get(pmOtId);
        		
        		// 예약 리스트에 포함되어있는 지 확인
        		if (reservOtIdList.contains(pmOtId)) {
        			time = inputDate + " " + time + " &#9675;";
        			resultDto.addPmReservList(time);
        		} else {
        			time = inputDate + " " + time + " &#9679;";
        			resultDto.addPmReservList(time);
        		}
        	}
        } // 반복문 끝
		return resultList;
	} // 스케줄 호출 메서드 끝

	/**
	 *  수정 스케줄 업데이트
	 */
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public List<String> updateSchedule(ChangeDateListDTO changeDataDto) {
		
		/**
		 *  0. 예약 조회 
		 *  1. 해당하는 날짜에 status가 있으면 진행
		 *  2. insert인지 update인지에 따른 분기 구문 진행
		 *  3. am pm에 따른 otID 파싱 후 진행
		 */
		// 클라이언트에서 전달받은 데이터 추출
		List<Map<String, Object>> list = changeDataDto.getChangeDateList();
		
		// 전달받은 drId
		String drId = changeDataDto.getDrId();
		
		// 전달받은 선택 연도와 월
		String selectYearMonth = convertStringValue(list, 0, "date").substring(0, 7);
		
		// // 날짜 1 ~ 최대 31 리스트 생성
		List<String> days = createDays(list);
		
		// 진료시간표 테이블 데이터 추출 (drId, 선택월)
		List<OpeningTimeVO> openingList = openTimeService.getListByDrIdAndDate(drId, selectYearMonth);
		
		// 타임테이블 데이터 추출 
		List<TimetableVO> timeList = timeService.getList();
		List<String> amTimeIdList = new ArrayList<String>();
		List<String> pmTimeIdList = new ArrayList<String>();
		
		// 오전/오후 timeId리스트 생성
		createAmPmList(timeList, amTimeIdList, pmTimeIdList);
		
		// key : 날짜 / value : otIdList Mapper 생성 [openingTime 테이블 기반]
		Map<String, List<String>> amOtIdMap = createAmOtIdMapper(days, openingList, amTimeIdList);
		Map<String, List<String>> pmOtIdMap = createPmOtIdMapper(days, openingList, pmTimeIdList);
		
		// 예약테이블 OT_ID 리스트 추출
		List<String> reservOtIdList = reservService.getOtIdListByDrIdAndDate(drId, selectYearMonth);
		
		// 클라이언트에 반환할 일정 리스트, 중복값 X 
		Set<String> validateDateList = new LinkedHashSet<String>();
		
		
		// 메인 진행하기 전 예약 검증 
		for(int i = 0; i < list.size(); i++) {
			
			// 날짜 추출 
			String date = convertStringValue(list, i, "date");
			// am,pm flag 추출
			boolean amFlag = Boolean.valueOf(convertStringValue(list, i, "amFlag"));
			boolean pmFlag = Boolean.valueOf(convertStringValue(list, i, "pmFlag"));
			String timeTypeFlag = "";
			
			// 전달 받은 리스트의 해당하는 날짜의 OtId 리스트
			List<String> amOtIdList = amOtIdMap.get(date);
			List<String> pmOtIdList = pmOtIdMap.get(date);
			
			// 전체 리스트 돌며 예약 되어있는 리스트 날짜 반환, 오전/오후 구분
			if (amFlag) {
				
				timeTypeFlag = "AM";
				validateReserv(reservOtIdList, amOtIdList, validateDateList, date, timeTypeFlag);
			}
			
			if (pmFlag) {
				
				timeTypeFlag = "PM";
				validateReserv(reservOtIdList, pmOtIdList, validateDateList, date, timeTypeFlag);
			}
		}
		
		// validateDateList 비어있으면 검증 통과 아니면 실패
		if (!validateDateList.isEmpty()) {
			
			List<String> responseDataList = new ArrayList<String>(validateDateList);
			return responseDataList;
		}
		
		
		// [메인] insert, update 진행
		for(int i = 0; i < list.size(); i++) {
			
			// 날짜 추출 
			String date = convertStringValue(list, i, "date");
			// am, pm flag 추출
			boolean amFlag = Boolean.valueOf(convertStringValue(list, i, "amFlag"));
			boolean pmFlag = Boolean.valueOf(convertStringValue(list, i, "pmFlag"));
			
			// 오전
			String amInsert = convertStringValue(list, i, "amInsert"); 
			String amUpdate = convertStringValue(list, i, "amUpdate"); 
			
			// 오후
			String pmInsert = convertStringValue(list, i, "pmInsert"); 
			String pmUpdate = convertStringValue(list, i, "pmUpdate"); 

			// 오전 / 오후 구분 삽입, 업데이트 진행
			if (amFlag) {
				
				if (!amInsert.equals("null")) {
					
					openTimeService.insertSchedule(amTimeIdList, amInsert, date, drId);
				}
				
				if (!amUpdate.equals("null")) {
					
					openTimeService.updateSchedule(amTimeIdList, amUpdate, date, drId);
				}
			}
			
			if (pmFlag) {
				
				if (!pmInsert.equals("null")) {
					
					openTimeService.insertSchedule(pmTimeIdList, pmInsert, date, drId);
				}
				
				if (!pmUpdate.equals("null")) {
					
					openTimeService.updateSchedule(pmTimeIdList, pmUpdate, date, drId);
					
				}
			}
			
		} // [메인] 
		List<String> responseDataList = new ArrayList<String>(validateDateList);
		return responseDataList; // 빈 리스트 반환
	} // updateSchedule 메서드 끝
	
	/**
	 * 편의 클래스
	 */
	static class DetailTime {
		
		private Map<String, String> detailTimeListAM = new LinkedHashMap<String, String>();
        private Map<String, String> detailTimeListPM = new LinkedHashMap<String, String>();
        
		public DetailTime() {
			super();
		}
		
		public DetailTime(Map<String, String> detailTimeListAM, Map<String, String> detailTimeListPM) {
			super();
			this.detailTimeListAM = detailTimeListAM;
			this.detailTimeListPM = detailTimeListPM;
		}
		
		public Map<String, String> getDetailTimeListAM() {
			return detailTimeListAM;
		}
		public void setDetailTimeListAM(Map<String, String> detailTimeListAM) {
			this.detailTimeListAM = detailTimeListAM;
		}
		public Map<String, String> getDetailTimeListPM() {
			return detailTimeListPM;
		}
		public void setDetailTimeListPM(Map<String, String> detailTimeListPM) {
			this.detailTimeListPM = detailTimeListPM;
		}
		
        public void addTimeListAM (String key, String value) {
        	detailTimeListAM.put(key, value);
        	
        }
        
        public void addTimeListPM (String key, String value) {
        	detailTimeListPM.put(key, value);
        	
        }

		@Override
		public String toString() {
			return "DetailTime [detailTimeListAM=" + detailTimeListAM + ", detailTimeListPM=" + detailTimeListPM + "]";
		}
		
        
	}
	
	/**
	 * 편의 메서드
	 */
	
	// 오전, 오후 timeId 리스트 생성
	private void createAmPmList(List<TimetableVO> timeList, List<String> amTimeIdList, List<String> pmTimeIdList) {
		
		for (TimetableVO time : timeList) {
			
			if (time.getTimeType().equals("오전")) {
				amTimeIdList.add(time.getTimetableId());
			} else {
				pmTimeIdList.add(time.getTimetableId());
			}
			
		}
		
	}
	
	// 예약이 존재하는 지 검증
	private void validateReserv(List<String> reservOtIdList, List<String> otIdList, Set<String> validateDateList, String date, String timeTypeFlag) {
		
		// 리스트에 인풋할 date
		String inputDate = "";
		
		// 예약이 있는 경우만 실행
		if (!reservOtIdList.isEmpty()) {
			for (String reservOtId : reservOtIdList) {
				if(otIdList.contains(reservOtId)) {
					
					if (timeTypeFlag.equals("AM")) {
						inputDate = date + " 오전";
					} else {
						inputDate = date + " 오후";
					}
					validateDateList.add(inputDate);
				}
			}
		}
		
	}
	
	// 날짜 리스트 생성 1 ~ 31
	private List<String> createDays(List<Map<String, Object>> list) {
		
		List<String> days = new ArrayList<String>();
		
		for(Map<String, Object> day : list) {
			
			String input = String.valueOf(day.get("date"));
			days.add(input);
		}
		
		return days;
	}
	
	// list 값 string 변환 메서드
	private String convertStringValue (List<Map<String, Object>> list, int index, String key) {
		
		return String.valueOf(list.get(index).get(key)); 
	}
	
	// 날짜에 따른 amOtIdMapper 생성
	private Map<String, List<String>> createAmOtIdMapper(List<String> days, List<OpeningTimeVO> openingOtIdList, List<String> timeIdList) {

		Map<String, List<String>> otIdMap = new HashMap<String, List<String>>();
		
		for(String day : days) {
			
			List<String> otIdList = new ArrayList<String>();
			
			for(OpeningTimeVO otVO : openingOtIdList) {
				
				// 날짜별 otID 그룹핑
				if(otVO.getYearDate().equals(day)) {
					// 오전 타임ID리스트와 같은 경우에만 삽입
					for(String timeId : timeIdList) {
						// 타임Id 검증 분기문
						if(otVO.getTimetableId().equals(timeId)) {
							
							otIdList.add(otVO.getOtId());
						}
					}
				}
			}
			
			otIdMap.put(day, otIdList);
		}
		
		return otIdMap;
	}
	
	// 날짜에 따른 pmOtIdMapper 생성
	private Map<String, List<String>> createPmOtIdMapper(List<String> days, List<OpeningTimeVO> openingOtIdList, List<String> timeIdList) {

		Map<String, List<String>> otIdMap = new HashMap<String, List<String>>();
		
		for(String day : days) {
			
			List<String> otIdList = new ArrayList<String>();
			
			for(OpeningTimeVO otVO : openingOtIdList) {
				
				// 날짜별 otID 그룹핑
				if(otVO.getYearDate().equals(day)) {
					// 오후 타임ID리스트와 같은 경우에만 삽입
					for(String timeId : timeIdList) {
						// 타임Id 검증 분기문
						if(otVO.getTimetableId().equals(timeId)) {
							
							otIdList.add(otVO.getOtId());
						}
					}
				}
			}
			otIdMap.put(day, otIdList);
		}
		
		return otIdMap;
	}

	
	
	
	
	
} // class 끝
