package com.project.hospital.service;

import java.util.List;

import com.project.hospital.dto.OpeningTimeTableDTO;
import com.project.hospital.vo.OpeningTimeVO;
import com.project.hospital.vo.ReservationVO;

public interface OpeningTimeTableService {
	List<OpeningTimeTableDTO> openingTimeTableList(OpeningTimeVO vo);
	List<OpeningTimeTableDTO> openingTimeTablereservationList(ReservationVO vo);
	OpeningTimeTableDTO openingTimeTableOne(OpeningTimeVO vo);
}
