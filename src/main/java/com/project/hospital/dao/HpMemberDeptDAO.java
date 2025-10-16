package com.project.hospital.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.dto.HpMemberDeptDTO;
import com.project.hospital.vo.ReservationVO;

@Repository
public class HpMemberDeptDAO {
	@Autowired
	private SqlSessionTemplate mybatis;

	public List<HpMemberDeptDTO> hpMemberDeptList(ReservationVO vo) {
		return mybatis.selectList("hpMemberDept.hpMemberDeptList", vo);
	}

}
