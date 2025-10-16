package com.project.hospital.view.coporMain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.hospital.coporationMain.MainService;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HospitalVO;
import com.project.hospital.vo.HpMemberVO;

@RestController
/* @RequestMapping("/main") */
public class MainAjaxController {
	
	@Autowired
	private MainService mainService;
	
	
	@PostMapping("/depts") 
	public List<DeptVO> depts(@RequestBody HospitalVO vo){
		
		System.out.println("depts 시작"); 
		System.out.println("vo : "+vo);
		List<DeptVO> deptList = mainService.getDeptListByHpId(vo);
	  
		return deptList;  
	}
	
	@PostMapping("/hpMembers") 
	public List<HpMemberVO> hpMembers(@RequestBody DeptVO vo){
		
		System.out.println("depts 시작"); 
		System.out.println("vo : "+vo);
		List<HpMemberVO> hpMemberList = mainService.getHpMemberList(vo);
	  
		return hpMemberList;  
	}
	  
	 

}
