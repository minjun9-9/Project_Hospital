package com.project.hospital.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.vo.HospitalVO;

@Repository
public class HospitalDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public List<HospitalVO> hospitalList() {
		return mybatis.selectList("hospital.hospitalList");
	}
	
	public List<HospitalVO> hospitalSearchList() {
		return mybatis.selectList("hospital.hospitalSearchList");
	}
	
	public List<HospitalVO> hospitalSearchListRegion(HospitalVO vo) {
		return mybatis.selectList("hospital.hospitalSearchListRegion", vo);
	}
	
	public List<HospitalVO> hospitalSearchListName(HospitalVO vo) {
		return mybatis.selectList("hospital.hospitalSearchListName", vo);
	}

	public HospitalVO hospitalOne(HospitalVO vo) {
		return mybatis.selectOne("hospital.hospitalOne",vo);
	}

	public void hospitalInsert(HospitalVO vo) {
		mybatis.insert("hospital.hospitalInsert",vo);
	}

	public void hospitalUpdate(HospitalVO vo) {
		mybatis.update("hospital.hospitalUpdate",vo);
	}

	public void hospitalDelete(HospitalVO vo) {
		mybatis.update("hospital.hospitalDelete",vo);
	}
	
	public void hospitalAccess(HospitalVO vo) {
		mybatis.update("hospital.hospitalAccess",vo);
	}

}
