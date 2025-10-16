package com.project.hospital.view.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hospital.admin.HpMemberService;
import com.project.hospital.admin.dto.DepartmentIdNameDTO;
import com.project.hospital.admin.dto.DoctorInfoDTO;
import com.project.hospital.admin.dto.DoctorInfoOrderByRankDTO;
import com.project.hospital.common.Paging;

@Controller
@RequestMapping("/admin")
public class AdminDrController {
	
	private final HpMemberService service;
	
	@Autowired
	public AdminDrController(HpMemberService service) {
		super();
		this.service = service;
	}
	
	/**
	 * 관리자 메인페이지로 이동 
	 */
	@GetMapping("/adminMain")
	public String adminMainPage() {
		
		return "admin/adminMain";
	}
	
	/*
	 * 의료진 관리 메뉴 이동 및 의료진 목록 추출과 페이징
	 */
	@GetMapping("/adminDoctorCare")
	public String adminDoctorCarePage(Model model, String cPage) {
		
		// 페이징 셋팅
		Paging p = service.pageSet(cPage);
		
		//5. 의료진 리스트 jsp로 보내기
		List<DoctorInfoDTO> drInfoList = service.getDrInfoList(p.getBegin(), p.getEnd());
		
		model.addAttribute("paging", p);
		model.addAttribute("drInfoList", drInfoList);
		
		return "admin/adminDoctorCare";
	}
	
	/**
	 * 의료진 등록 페이지 이동
	 */
	@GetMapping("/adminDoctorRegister")
	public String adminDoctorRegister(Model model) {
		List<DepartmentIdNameDTO> deptIdNameList = service.getDeptIdName();
		
		model.addAttribute("deptIdNameList", deptIdNameList);
		
		return "admin/adminDoctorRegister";
	}
	
	/**
	 * 의료진 삭제
	 */
	@GetMapping("/deleteDrInfo")
	public String deleteDrInfo(String drId) {
		int result = service.deleteDrInfo(drId);
		return "redirect:adminDoctorCare";
	}
	
	/**
	 * 의료진 순위 관리
	 */
	@RequestMapping("/adminDoctorRank")
	public String adminDoctorRankPage(Model model) {
		List<DoctorInfoOrderByRankDTO> drInfoOrderByRankList = service.getDrInfoOrderByRank();
		model.addAttribute("drInfoOrderByRankList", drInfoOrderByRankList);
		return "admin/adminDoctorRank";
	}
	
}
