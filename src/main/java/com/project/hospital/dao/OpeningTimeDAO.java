package com.project.hospital.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.vo.OpeningTimeVO;

@Repository
public class OpeningTimeDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	public List<String> openingTimeList(OpeningTimeVO vo) {
		return mybatis.selectList("openingTime.openingTimeList", vo);
	}
	
	public void openingTimeImpossibleUpdate(String otId) {
		mybatis.update("openingTime.openingTimeImpossibleUpdate", otId);
	}
	
	public void openingTimePossibleUpdate(String otId) {
		mybatis.update("openingTime.openingTimePossibleUpdate", otId);
	}
}
