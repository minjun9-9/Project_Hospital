package com.project.hospital.service;

import java.util.List;

import com.project.hospital.dto.HpMemberDeptDTO;
import com.project.hospital.vo.ReservationVO;

public interface HpMemberDeptService {
	List<HpMemberDeptDTO> hpMemberDeptList(ReservationVO vo);
}
