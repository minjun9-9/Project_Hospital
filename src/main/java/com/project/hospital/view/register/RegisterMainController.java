package com.project.hospital.view.register;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.hospital.doctorInfo.DoctorInfoCntDTO;
import com.project.hospital.doctorInfo.DoctorinfoService;
import com.project.hospital.vo.DeptVO;

@Controller
@RequestMapping("/reservation")
public class RegisterMainController {
	
	@Autowired
	private DoctorinfoService doctorInfoService;
	
	@GetMapping("/main")
	public String RegisterMainPage(Model model){
		DoctorInfoCntDTO dto = new DoctorInfoCntDTO();
		
		List<DoctorInfoCntDTO> topDoctors = doctorInfoService.TopDoctorInfoList(dto);
		
		model.addAttribute("topDoctors", topDoctors);
		
		return "reservation/resermain"; 
	}
	
	@GetMapping("/doctorDetailInfo")
	public String doctorDetailInfoPage(){
		//기존에 다른 컨트롤러에서 했던 작업 초기화를 위한 것
		
		return "reservation/doctorDetailInfo"; 
	}
	
	
	@GetMapping("/deptSearch")
    public String deptSearchPage(Model model) {
        // 부서 목록을 불러와서 Model에 추가
        List<DeptVO> deptList = doctorInfoService.getDepartmentList();
        model.addAttribute("deptList", deptList);

        return "reservation/deptSearch"; 
    }
	 
	 @GetMapping("/reservation") 
	 public String reserPage(HttpSession session, Model model){
		 
//		 String user = (String) session.getAttribute("user");
//		 model.addAttribute("user", user);
		 
		 model.addAttribute("hospitalId", "SSW");
		 
		 //여기에 현진이형 jsp 넣기
		 return "reservation/reservation11"; 
	 }
	 
	 
	 @GetMapping("/deptSearchForm") 
	    public String deptSearchFormPage(@RequestParam("initial") String initial, Model model) {
	        
	        model.addAttribute("initial", initial);
	        
	        return "redirect:/reservation/deptSearch"; 
	    }
	 
	 //세션 적용
	 
	 
	/*
	 * @GetMapping("/deptSearch") public String
	 * deptSearchPage(@RequestParam(required = false) String initial, Model model){
	 * 
	 * if(initial != null) { model.addAttribute("initial", initial); } return
	 * "reservation/deptSearch"; }
	 */
	
	//deptDetail페이지(여러개) 옮기기
	@GetMapping("/deptDetailInfo")
	public String deptDetailInfo(){
		
		return "reservation/deptDetailInfo"; 
	}
	
	//ajax 요청처리
	@GetMapping("/doctorDetailInfoSearch")
	@ResponseBody
	public List<DoctorInfoCntDTO> searchDoctors(@RequestParam(required = false) String drName,
			@RequestParam(required = false) String deptName,
			@RequestParam(required = false) String searchQuery ){
		DoctorInfoCntDTO dto = new DoctorInfoCntDTO();
		System.out.println("검색 실행중 drName: " + drName);
		System.out.println("검색 실행중 deptName: " + deptName);
		System.out.println("검색 실행중 searchQuery: " + searchQuery);
		dto.setDrName(drName != null ? drName : "");
		dto.setDeptName(deptName != null ? deptName : "");
		dto.setSearchQuery(searchQuery != null ? searchQuery : "");
		List<DoctorInfoCntDTO> count = doctorInfoService.getDoctorInfoList(dto);
		System.out.println("전달 결과 : " + count);
		return doctorInfoService.getDoctorInfoList(dto);
	}
	//resermain ajax 요청처리
//	@GetMapping("/doctorDetailInfoSearchMain")
//	@ResponseBody
////	public String doctorDetailInfoPage(@RequestParam(required = false) String searchQuery, Model model) {
//	public List<DoctorInfoCntDTO> doctorDetailInfoPage(@RequestParam(required = false) String searchQuery, Model model) {
//		System.out.println("받은 searchQuery :" +searchQuery);
//		DoctorInfoCntDTO dto = new DoctorInfoCntDTO();
//		dto.setSearchQuery(searchQuery != null ? searchQuery : "");
//		List<DoctorInfoCntDTO> doctorList = doctorInfoService.getDoctorInfoList(dto);
//		System.out.println("doctorList: "+doctorList);
////		model.addAttribute("doctorList", doctorList);
////		return "reservation/doctorDetailInfo";
//		
//		return doctorList;
//	}
	@GetMapping("/doctorDetailInfoSearchMain")
	@ResponseBody
	public List<DoctorInfoCntDTO> doctorDetailInfoPage(@RequestParam(required = false) String searchQuery) {
	    System.out.println("받은 searchQuery :" + searchQuery);
	    DoctorInfoCntDTO dto = new DoctorInfoCntDTO();
	    dto.setSearchQuery(searchQuery != null ? searchQuery : "");
	    List<DoctorInfoCntDTO> doctorList = doctorInfoService.getDoctorInfoList(dto);
	    System.out.println("검색된 doctorList: " + doctorList);
	    return doctorList;
//	    return doctorInfoService.getDoctorInfoList(dto);
	}

	
	
	
}
