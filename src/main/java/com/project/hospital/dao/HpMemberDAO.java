package com.project.hospital.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HpMemberVO;

@Repository
public class HpMemberDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public List<HpMemberVO> hpMemberSearchList(DeptVO vo) {
		return mybatis.selectList("hpMember.hpMemberSearchList", vo);
	}

}
