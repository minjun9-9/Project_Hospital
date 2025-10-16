package com.project.hospital.view.search;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.hospital.admin.DeptService;
import com.project.hospital.doctorInfo.DoctorinfoService;
import com.project.hospital.search.SearchService;

@Controller
@RequestMapping("/search")
public class searchController {
	
	@Autowired
	private DoctorinfoService doctorInfoService;
	@Autowired
	private SearchService searchService;
	@Autowired
	private DeptService deptService;
	@GetMapping("/search")
	public String searchResult(@RequestParam("query") String query, Model model) {
		System.out.println("검색: "+query);
		model.addAttribute("query", query);
		model.addAttribute("qnaResults", searchService.searchQnA(query));
		model.addAttribute("doctorResults", searchService.searchDoctors(query));
		
		model.addAttribute("qnaCount", searchService.countQnA(query));
		model.addAttribute("doctorCount", searchService.countDoctors(query));
		return "search/search";
	}
	
	

	
	
	
}
