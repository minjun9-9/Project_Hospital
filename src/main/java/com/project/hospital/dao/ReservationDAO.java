package com.project.hospital.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.dto.ReservationDTO;
import com.project.hospital.vo.ReservationVO;

@Repository
public class ReservationDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public List<ReservationVO> reservationList(ReservationVO vo) {
		return mybatis.selectList("reservation.reservationList", vo);
	}
	
	public ReservationVO reservationInsertCheck(ReservationDTO dto) {
		return mybatis.selectOne("reservation.reservationInsertCheck", dto);
	}
	
	public void reservationInsert(ReservationVO vo) {
		mybatis.insert("reservation.reservationInsert",vo);
	}
	
	public void reservationDelete(ReservationVO vo) {
		mybatis.delete("reservation.reservationDelete",vo);
	}

}
