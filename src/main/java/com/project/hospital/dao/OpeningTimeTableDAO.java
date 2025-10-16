package com.project.hospital.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.dto.OpeningTimeTableDTO;
import com.project.hospital.vo.OpeningTimeVO;
import com.project.hospital.vo.ReservationVO;

@Repository
public class OpeningTimeTableDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public List<OpeningTimeTableDTO> openingTimeTableList(OpeningTimeVO vo) {
		return mybatis.selectList("openingTimeTable.openingTimeTableList", vo);
	}
	
	public List<OpeningTimeTableDTO> openingTimeTablereservationList(ReservationVO vo) {
		return mybatis.selectList("openingTimeTable.openingTimeTablereservationList", vo);
	}
	
	public OpeningTimeTableDTO openingTimeTableOne(OpeningTimeVO vo) {
		return mybatis.selectOne("openingTimeTable.openingTimeTableOne", vo);
	}
}
