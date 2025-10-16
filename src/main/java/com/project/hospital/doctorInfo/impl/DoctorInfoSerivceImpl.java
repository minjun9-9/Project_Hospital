package com.project.hospital.doctorInfo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.dao.DoctorInfoDAO;
import com.project.hospital.doctorInfo.DoctorInfoCntDTO;
import com.project.hospital.doctorInfo.DoctorinfoService;
import com.project.hospital.vo.DeptVO;

// @Service : @Component 상속확장 어노테이션
// 		비즈니스 로직 처리 서비스 영역에 사용
@Service("doctorInfoService")
public class DoctorInfoSerivceImpl implements DoctorinfoService {

	@Autowired
	private DoctorInfoDAO doctorInfoDAO;
	
	
	
	public DoctorInfoSerivceImpl() {
		System.out.println("DoctorInfoSerivceImpl() 객체생성");
	}



	@Override
	public List<DoctorInfoCntDTO> getDoctorInfoList(DoctorInfoCntDTO dto) {
		return doctorInfoDAO.getDoctorInfoList(dto);
	}


 
	@Override
	public List<DoctorInfoCntDTO> getDoctorInfoList(String drName, String deptName) {
		// TODO Auto-generated method stub
		return null;
	}



	@Override
	public List<DoctorInfoCntDTO> TopDoctorInfoList(DoctorInfoCntDTO dto) {
		// TODO Auto-generated method stub
		return doctorInfoDAO.TopDoctorInfoList(dto);
	}



	@Override
	public List<DoctorInfoCntDTO> getHospitalId() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
    public List<DeptVO> getDepartmentList() {
        return doctorInfoDAO.getDepartmentList();
    }
}
