package com.project.hospital.view.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hospital.admin.DeptService;
import com.project.hospital.service.HospitalService;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HospitalVO;

@Controller
@RequestMapping("hospital")
public class HospitalController {
	@Autowired
	private HospitalService hospitalService;
	@Autowired
	private DeptService deptService;
	
	@RequestMapping("/hospitalList")
	public String hospitalList(Model model){
		List<HospitalVO> hospitalList = hospitalService.hospitalList();
		model.addAttribute("hospitalList",hospitalList);
		
		return "hospital/hospitalList";
	}
	
	@RequestMapping("/hospitalSearchList")
	public String hospitalSearchList(Model model){
		List<HospitalVO> hospitalList = hospitalService.hospitalSearchList();
		model.addAttribute("hospitalList",hospitalList);
		
		return "hospital/hospitalSearchList";
	}
	
	@RequestMapping("/hospitalSearchListRegion")
	public String hospitalSearchListRegion(HospitalVO vo, Model model){
		List<HospitalVO> hospitalList = hospitalService.hospitalSearchListRegion(vo);
		model.addAttribute("hospitalList",hospitalList);
		
		return "hospital/hospitalSearchList";
	}
	
	@RequestMapping("/hospitalSearchListName")
	public String hospitalSearchListName(HospitalVO vo, Model model){
		List<HospitalVO> hospitalList = hospitalService.hospitalSearchListName(vo);
		model.addAttribute("hospitalList",hospitalList);
		
		return "hospital/hospitalList";
	}
	
	@RequestMapping("/hospitalOne")
	public String hospitalOne(HospitalVO vo, Model model){
		HospitalVO hospitalOne = hospitalService.hospitalOne(vo);
		List<DeptVO> deptList = deptService.deptlList(vo);
		
		model.addAttribute("hospitalOne", hospitalOne);
		model.addAttribute("deptList",deptList);
		
		return "hospital/hospitalOne";
	}
	
	@GetMapping("/hospitalInsert")
	public String hospitalInsertPage(){
		
		return "hospital/hospitalInsert";
	}
	
	@PostMapping("/hospitalInsert")
	public String hospitalInsert(HospitalVO vo, HttpSession session){
		hospitalService.hospitalInsert(vo);
		
		session.setAttribute("message", "등록되었습니다.");
		
		//return "redirect:../index.jsp";
		return "redirect:hospitalList";
	}
	
	@GetMapping("/hospitalUpdate")
	public String hospitalUpdatePage(HospitalVO vo, Model model){
		HospitalVO hospitalOne = hospitalService.hospitalOne(vo);
		model.addAttribute("hospitalOne", hospitalOne);
		
		return "hospital/hospitalUpdate";
	}
	
	@PostMapping("/hospitalUpdate")
	public String hospitalUpdate(HospitalVO vo, HttpSession session){
		hospitalService.hospitalUpdate(vo);

		//메세지 등록
		session.setAttribute("message", "수정 되었습니다.");
		
		/*
		 * List<HospitalVO> hospitalList = hospitalService.hospitalList();
		 * model.addAttribute("hospitalList",hospitalList);
		 * model.addAttribute("message", "수정되었습니다.");
		 */
		
		
		//return "hospital/hospitalList";
		return "redirect:hospitalList";
	}
	
	@RequestMapping("/hospitalDelete")
	public String hospitalDelete(HospitalVO vo, HttpSession session){
		HospitalVO hospitalOne = hospitalService.hospitalOne(vo);
		if(hospitalOne.getQuit().equals("1")) {
			/*
			 * model.addAttribute("hospitalOne", hospitalOne); 
			 * model.addAttribute("message", "이미 탈퇴 처리된 병원입니다.");
			 */
			session.setAttribute("message", "이미 미승인 처리된 병원입니다.");
			
			return "redirect:hospitalList";
		}
		else {
			hospitalService.hospitalDelete(vo);
			
			session.setAttribute("message", "미승인 되었습니다.");
			
			return "redirect:hospitalList";
		}
		
	}
	
	@RequestMapping("/hospitalAccess")
	public String hospitalAccess(HospitalVO vo, HttpSession session){
		HospitalVO hospitalOne = hospitalService.hospitalOne(vo);
		if(hospitalOne.getQuit().equals("0")) {
			/*
			 * model.addAttribute("hospitalOne", hospitalOne); 
			 * model.addAttribute("message", "이미 탈퇴 처리된 병원입니다.");
			 */
			session.setAttribute("message", "이미 승인 처리된 병원입니다.");
			
			return "redirect:hospitalList";
		}
		else {
			hospitalService.hospitalAccess(vo);
			
			session.setAttribute("message", "승인 되었습니다.");
			
			return "redirect:hospitalList";
		}
		
	}

}
