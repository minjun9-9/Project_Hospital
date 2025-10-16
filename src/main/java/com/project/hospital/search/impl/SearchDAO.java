package com.project.hospital.search.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.doctorInfo.DoctorInfoCntDTO;
import com.project.hospital.search.QnaSearchDTO;

@Repository
public class SearchDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public SearchDAO() {
		System.out.println(">> SearchDAO() 객체 생성");
	}
	
	public List<QnaSearchDTO> searchQnA(String query){
		return mybatis.selectList("searchMapper.searchQnA", query);
	}
	
	public List<DoctorInfoCntDTO> searchDoctors(String query){
		return mybatis.selectList("searchMapper.searchDoctors", query);
	}

	public int countQnA(String query) {
		return mybatis.selectOne("searchMapper.countQnA", query);
	}

	public int countDoctors(String query) {
		return mybatis.selectOne("searchMapper.countDoctors", query);
	}
	

}








