package com.project.hospital.service;

import java.util.List;

import com.project.hospital.vo.HospitalVO;

public interface HospitalService {
	List<HospitalVO> hospitalList();
	List<HospitalVO> hospitalSearchList();
	List<HospitalVO> hospitalSearchListRegion(HospitalVO vo);
	List<HospitalVO> hospitalSearchListName(HospitalVO vo);
	HospitalVO hospitalOne(HospitalVO vo);
	void hospitalInsert(HospitalVO vo);
	void hospitalUpdate(HospitalVO vo);
	void hospitalDelete(HospitalVO vo);
	void hospitalAccess(HospitalVO vo);
}
