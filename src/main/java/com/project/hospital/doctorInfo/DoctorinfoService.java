package com.project.hospital.doctorInfo;

import java.util.List;

import com.project.hospital.vo.DeptVO;

public interface DoctorinfoService {
	List<DoctorInfoCntDTO> getDoctorInfoList(String drName, String deptName);

	List<DoctorInfoCntDTO> getDoctorInfoList(DoctorInfoCntDTO dto);
	List<DoctorInfoCntDTO> TopDoctorInfoList(DoctorInfoCntDTO dto);
	List<DoctorInfoCntDTO> getHospitalId();
	
	List<DeptVO> getDepartmentList();
}
