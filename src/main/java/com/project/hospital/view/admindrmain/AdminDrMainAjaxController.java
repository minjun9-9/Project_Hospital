package com.project.hospital.view.admindrmain;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.hospital.admindrMain.AdminDrMainService;
import com.project.hospital.admindrMain.dto.QnaCountDTO;
import com.project.hospital.common.Result;

@RestController
@RequestMapping("/adminDoctorMain")
public class AdminDrMainAjaxController {
	
//	private final AdminDrMainService service;
//
//	@Autowired
//	public AdminDrMainAjaxController(AdminDrMainService service) {
//		super();
//		this.service = service;
//	}
//	
//	
//	@PostMapping("/getQnaCountAndList")
//	public Result<QnaCountDTO> getQnaCountAndList() {
//		
//		QnaCountDTO dto = service.getQnaCountAndList();
//		
//		return new Result<QnaCountDTO>(dto, dto.getQnaDescThird().size());
//	}
//	

}
