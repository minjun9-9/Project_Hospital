package com.project.hospital.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.doctorInfo.DoctorInfoCntDTO;
import com.project.hospital.vo.DeptVO;

@Repository
public class DoctorInfoDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public DoctorInfoDAO() {
		System.out.println(">> DoctorInfoDAO() 객체 생성");
	}

	public List<DoctorInfoCntDTO> getDoctorInfoList(DoctorInfoCntDTO dto){
		
		System.out.println("==>MyBatis 사용 getDoctorInfoList 실향");
		System.out.println("dto : " + dto);
		if(dto.getDeptName() == null) {
			dto.setDeptName("");
		}
		if(dto.getDrName() == null) {
			dto.setDrName("");
		}
		if(dto.getSearchQuery() == null) {
			dto.setSearchQuery("");
		}
		
		return mybatis.selectList("doctorInfoDAO.getDoctorInfoList", dto);
	}

	public List<DoctorInfoCntDTO> TopDoctorInfoList(DoctorInfoCntDTO dto) {
		System.out.println("==>MyBatis 사용 TopDoctorInfoList 실향");
		System.out.println("dto : " + dto);
		return  mybatis.selectList("doctorInfoDAO.getTopDoctorInfoList", dto);
	}
	
	public List<DoctorInfoCntDTO> getHospitalId() {
		System.out.println("==>MyBatis 사용 getHospitalId 실향");
		return  mybatis.selectList("doctorInfoDAO.getHospitalId");
	}
	
	 public List<DeptVO> getDepartmentList() {
	        return mybatis.selectList("doctorInfoDAO.getDepartmentList");
    }
	
}








