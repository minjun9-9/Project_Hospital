package com.project.hospital.view.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.hospital.service.HospitalService;
import com.project.hospital.vo.HospitalVO;

@RestController
@RequestMapping("hospital")
public class HospitalAjaxController {
	@Autowired
	private HospitalService hospitalService;
	
	@PostMapping("/hospitalOneJson")
	public HospitalVO hospitalOne(@RequestBody HospitalVO vo){
		HospitalVO hospitalOne = hospitalService.hospitalOne(vo);
		
		if(hospitalOne == null) {
			vo.setHpId("사용가능");
			hospitalOne = vo;
		}
		
		return hospitalOne;
	}
}
