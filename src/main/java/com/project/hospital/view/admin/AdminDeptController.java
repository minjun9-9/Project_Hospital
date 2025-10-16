package com.project.hospital.view.admin;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hospital.admin.DeptService;
import com.project.hospital.admin.dto.DeptAndFileDTO;
import com.project.hospital.admin.dto.DeptDrInfoDTO;

@Controller
@RequestMapping("/admin")
public class AdminDeptController {
	private final DeptService service;
	
	@Autowired
	public AdminDeptController(DeptService service) {
		this.service = service;
	}
	
	/**
	 * 진료과 관리 페이지 이동
	 */
	@GetMapping("/adminDeptCare")
	public String adminDeptCarePage(Model model) {
		List<DeptAndFileDTO> deptAndFileList = service.getDeptInfo();
		
		model.addAttribute("deptAndFileList", deptAndFileList);
		
		return "admin/adminDeptCare";
	}
	
	/**
	 * 진료과 등록 페이지 이동
	 */
	@GetMapping("/adminDeptRegister")
	public String adminDeptRegisterPage() {
		return "admin/adminDeptRegister";
	}
	
	/**
	 * 진료과 삭제
	 */
	@GetMapping("/deletedeptInfo")
	public String deletedeptInfo(String deptId) {
		service.deletedeptInfo(deptId);
		return "redirect:adminDeptCare";
	}
	
	/**
	 * 진료과 수정
	 */
	@GetMapping("/deptInfoUpdate")
	public String deptInfoUpdatePage(String deptId, Model model) {
		DeptAndFileDTO deptInfo = service.getOneDeptInfo(deptId);
		List<DeptDrInfoDTO> deptDrInfoList = service.getDeptDrInfo(deptInfo.getDeptId());
		DeptDrInfoDTO deptHeadInfo = null;
		DeptDrInfoDTO forDelete = null;
		if (deptInfo.getDrId() != null) {
			deptHeadInfo = service.getDeptOneDrInfo(deptInfo.getDrId());
			for (DeptDrInfoDTO deptDrInfo : deptDrInfoList ) {
				if (deptInfo.getDrId().equals(deptDrInfo.getDrId())) {
					forDelete = deptDrInfo;
				}
			}
			deptDrInfoList.remove(forDelete);
		}
		model.addAttribute("deptDrInfoList", deptDrInfoList);
		model.addAttribute("deptHeadInfo", deptHeadInfo);
		model.addAttribute("deptInfo", deptInfo);
		
		return "admin/adminDeptUpdate";
	}
	
	
}
