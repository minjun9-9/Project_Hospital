package com.project.hospital.admin;

import java.util.List;

import com.project.hospital.admin.dto.ChangeDateListDTO;
import com.project.hospital.admin.dto.HpMemberScheduleDTO;


public interface HpMemberScheduleService {
	
	List<HpMemberScheduleDTO> findSchedule(String drId, String date);

	List<String> updateSchedule(ChangeDateListDTO changeDataList);
	
}
