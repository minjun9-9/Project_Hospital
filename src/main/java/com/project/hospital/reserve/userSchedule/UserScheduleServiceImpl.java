package com.project.hospital.reserve.userSchedule;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.reserve.dto.ReservRequestDTO;
import com.project.hospital.reserve.dto.ReserveResponDTO;
import com.project.hospital.reserve.dto.TimeDateDTO;
import com.project.hospital.reserve.opening.OpeningTimeService;
import com.project.hospital.reserve.timetable.TimetableService;

@Service
@Transactional(readOnly = true)
public class UserScheduleServiceImpl implements UserScheduleService {
	
	private final TimetableService timeService;
	
	@Autowired
	public UserScheduleServiceImpl(TimetableService timeService) {
		super();
		this.timeService = timeService;
	}

	/**
	 * userNum과 date를 이용해 예약 리스트 가져와 진료스케줄로 반환
	 */
	@Override
	public List<ReserveResponDTO> findMedicalSchedule(ReservRequestDTO requestDto) {
		
		// 클라이언트에 전달 받은 값 추출
		String userNum = requestDto.getUserNum();
		String date = requestDto.getDate();
		
		// 입력받은 date 파싱
		String[] dates = date.split("-");
		
		LocalDate thisMonth = LocalDate.of(Integer.parseInt(dates[0]), Integer.parseInt(dates[1]), 1); // 선택된 월 
		LocalDate nextMonth = thisMonth.plusMonths(1); // 선택된 월 다음달
		
		// 선택된 월 과 다음 달의 일수
		long between = ChronoUnit.DAYS.between(thisMonth, nextMonth);
		
		// userNum과 date 조건을 이용해 예약 내역에 맞는 시간, 날짜 추출
		List<TimeDateDTO> reservList = timeService.findReservSchedule(userNum, date);
		
		List<ReserveResponDTO> resultList = new ArrayList<ReserveResponDTO>();
		
		// 1일부터 월에 해당하는 말일까지
		for (int i = 0; i < between; i++){
            LocalDate localDate = thisMonth.plusDays(i); // 반복문 진행하며 하루씩 증가
            
            ReserveResponDTO responDto = new ReserveResponDTO(); // 빈 객체 생성
            responDto.setDate(localDate.toString());
            
            // 서버에서 전달받은 날짜와 일치하면 해당 시간리스트 추가
            for (TimeDateDTO dto : reservList) {
            	
            	if(dto.getYearDate().equals(localDate.toString())) {
            		responDto.addTime(dto.getTime());
            		
            	}
            }
            
            // 다 담은 객체 리스트에 추가 
            resultList.add(responDto);
            
		}
		
		return resultList;
	}

	
	
	
}
