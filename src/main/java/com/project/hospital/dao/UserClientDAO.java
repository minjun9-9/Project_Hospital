package com.project.hospital.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.vo.ReservationVO;
import com.project.hospital.vo.UserClientVO;

@Repository
public class UserClientDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public UserClientVO userClientOne(ReservationVO vo) {
		return mybatis.selectOne("userClient.userClientOne", vo);
	}

}
