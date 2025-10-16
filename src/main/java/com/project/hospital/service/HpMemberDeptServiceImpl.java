package com.project.hospital.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.dao.HpMemberDeptDAO;
import com.project.hospital.dto.HpMemberDeptDTO;
import com.project.hospital.vo.ReservationVO;

@Service("hpMemberDeptService")
public class HpMemberDeptServiceImpl implements HpMemberDeptService{
	@Autowired
	private HpMemberDeptDAO hpMemberDeptDAO;

	@Override
	public List<HpMemberDeptDTO> hpMemberDeptList(ReservationVO vo) {
		return hpMemberDeptDAO.hpMemberDeptList(vo);
	}

}
