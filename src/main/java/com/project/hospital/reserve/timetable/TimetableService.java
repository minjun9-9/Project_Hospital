package com.project.hospital.reserve.timetable;

import java.util.List;

import com.project.hospital.reserve.dto.TimeDateDTO;
import com.project.hospital.vo.TimetableVO;

public interface TimetableService {
	
	List<TimetableVO> getList();

	List<TimeDateDTO> findReservSchedule(String userNum, String date);
}
