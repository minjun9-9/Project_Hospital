package com.project.hospital.reserve.opening;

import java.util.List;

import com.project.hospital.vo.OpeningTimeVO;

public interface OpeningTimeService {
	
	List<OpeningTimeVO> getListByDrIdAndDate(String drId, String date);

	void insertSchedule(List<String> timeIdList, String insertStatus, String date, String drId);

	void updateSchedule(List<String> timeIdList, String updateStatus, String date, String drId);
	
	// 통합 후 추가
	List<String> openingTimeList(OpeningTimeVO vo);
	void openingTimeImpossibleUpdate(String otId);
	void openingTimePossibleUpdate(String otId);
}
