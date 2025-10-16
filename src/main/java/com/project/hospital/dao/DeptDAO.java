package com.project.hospital.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HospitalVO;

@Repository
public class DeptDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	public List<DeptVO> deptlList(HospitalVO vo) {
		return mybatis.selectList("dept.deptList", vo);
	}



}
