package com.project.hospital.view.doctor;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hospital.admin.HpMemberService;
import com.project.hospital.admin.dto.DepartmentIdNameDTO;
import com.project.hospital.admin.dto.DoctorInfoDTO;
import com.project.hospital.vo.FileStoreVO;

@Controller
@RequestMapping("/doctor")
public class DoctorController {
	@Autowired
	private final HpMemberService service;

	public DoctorController(HpMemberService service) {
		super();
		this.service = service;
	}

	@RequestMapping("/doctorInfoUpdate")
	public String drInfoUpdate(String drId, Model model) {
		
		//진료과 ID, NAME 가져오기
		List<DepartmentIdNameDTO> deptIdNameList = service.getDeptIdName();
		
		//의료진 한명 정보 가져오기
		DoctorInfoDTO drInfoVO = service.getOneDrInfo(drId);
		
		model.addAttribute("deptIdNameList", deptIdNameList);
		model.addAttribute("drInfoVO", drInfoVO);
		
		return "doctor/doctorInfoUpdate";
	}
	
	/**
	 * 의료진 비밀번호 변경 페이지 이동 
	 */
	@RequestMapping("/doctorPwChange")
	public String drPasswordChangePage() {
		return "/doctor/doctorPwChange";
	}
}
