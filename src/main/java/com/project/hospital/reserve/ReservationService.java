package com.project.hospital.reserve;

import java.util.List;

import com.project.hospital.admindrMain.dto.MainPageReservDTO;
import com.project.hospital.dto.ReservationDTO;
import com.project.hospital.vo.ReservationVO;

public interface ReservationService {
	
	List<ReservationVO> getListByDrId(String DrId);

	List<String> getOtIdListByDrIdAndDate(String drId, String date);

	MainPageReservDTO getMainReservData();
	
	//통합 후 추가
	List<ReservationVO> reservationList(ReservationVO vo);
	ReservationVO reservationInsertCheck(ReservationDTO dto);
	void reservationInsert(ReservationVO vo);
	void reservationDelete(ReservationVO vo);
}
