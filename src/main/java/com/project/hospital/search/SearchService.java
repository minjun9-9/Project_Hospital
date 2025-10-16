package com.project.hospital.search;

import java.util.List;

import com.project.hospital.doctorInfo.DoctorInfoCntDTO;

public interface SearchService {

	List<QnaSearchDTO> searchQnA(String query);

	List<DoctorInfoCntDTO>searchDoctors(String query);

	int countQnA(String query);
	
	int countDoctors(String query);
}
