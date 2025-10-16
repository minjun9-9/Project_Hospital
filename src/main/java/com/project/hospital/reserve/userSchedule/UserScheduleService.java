package com.project.hospital.reserve.userSchedule;

import java.util.List;

import com.project.hospital.reserve.dto.ReservRequestDTO;
import com.project.hospital.reserve.dto.ReserveResponDTO;

public interface UserScheduleService {
	
	List<ReserveResponDTO> findMedicalSchedule(ReservRequestDTO requestDto);
	
}
