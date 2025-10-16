package com.project.hospital.view.info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hospital.doctorInfo.DoctorinfoService;

@Controller
@RequestMapping("/info")
public class InfoController {
	
	@Autowired
	private DoctorinfoService doctorInfoService;
	
	
	
	@GetMapping("/map")
	public String mapInfo(){
		
		return "info/map"; 
	}
	@GetMapping("/parking")
	public String parkingInfo(){
		
		return "info/parking"; 
	}
	@GetMapping("/noticeView")
	public String noticeInfo(){
		
		return "info/noticeView"; 
	}
	@GetMapping("/remodel")
	public String noticeRemodel(){
		
		return "info/noticeRemodel"; 
	}
	

	
	
	
}
