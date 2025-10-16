package com.project.hospital.view.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.hospital.admin.HpMemberScheduleService;
import com.project.hospital.admin.HpMemberService;
import com.project.hospital.admin.dto.ChangeDateListDTO;
import com.project.hospital.admin.dto.DoctorInfoDTO;
import com.project.hospital.admin.dto.HpMemberScheduleDTO;
import com.project.hospital.admin.dto.SearchDrInfoDTO;
import com.project.hospital.common.Result;

/**
 * 
 * 기능 목록
 * 1. 의료진 등록
 * 2. 선택된 의료진 스케줄 반환
 * 3. 수정 스케줄 업데이트 
 *
 */

@RestController
public class AdminDrAjaxController {
	
	
	private final HpMemberService service;
	private final HpMemberScheduleService hpScheduleService; // 하나의 서비스에 여러 서비스를 이용할때
	
	@Autowired
	public AdminDrAjaxController(HpMemberService service, HpMemberScheduleService hpScheduleService) {
		super();
		this.service = service;
		this.hpScheduleService = hpScheduleService;
	}
	
	/**
	 * 의료진 등록
	 */
	@PostMapping("/insertDrInfo")
	public Map<String, String> insertDrInfo(@RequestParam("drInfo") String drInfoJson,
											@RequestParam(value = "profileImage", required = false) List<MultipartFile> profileImage) {

		
		return service.insertDrInfo(drInfoJson, profileImage);
		
	}
	
	/**
	 * 의료진 정보 리스트 반환(검색 -> 수정전)
	 */
	@PostMapping("/searchDrInfo")
	public List<DoctorInfoDTO> searchDrInfo(@RequestBody SearchDrInfoDTO requsetJSON) {
		
		return service.searchDrInfo(requsetJSON.getKeyword(), requsetJSON.getValue());
	}
	
	/**
	 * 의료진 정보 리스트 반환(검색 -> 수정본)
	 */
	@GetMapping("/searchDrInfo")
	public List<String> searchDrName(@RequestParam String keyword, @RequestParam String query) {
		return service.searchDrName(keyword, query);
	}
	
	/**
	 * 검색 버튼 or 검색어 엔터키 처리 메소드
	 */
	@GetMapping("/seachDrInfoByName")
	public List<DoctorInfoDTO> seachDrInfoByName(@RequestParam String keyword, @RequestParam String query) {
		return service.searchDrInfo(keyword, query);
	}
	
	/**
	 *  의료진 한명정보 반환
	 */
	@PostMapping("/getOneDrInfo")
	public DoctorInfoDTO getOneDrInfo(@RequestBody Map<String, String> requestJSON) {
		
		return service.getOneDrInfo(requestJSON.get("drId"));
	}
	
	
	/*
	 * 선택된 의료진 스케줄 반환
	 */
	@PostMapping("/hpMemberAdmin/findSchedule")
	@ResponseBody
	public Result<List<HpMemberScheduleDTO>> findSchedule(@RequestBody Map<String, String> requestData ) {		
		
		String drId = requestData.get("drId");
		String date = requestData.get("date");
		List<HpMemberScheduleDTO> list = hpScheduleService.findSchedule(drId, date);
		
		return new Result<List<HpMemberScheduleDTO>>(list, list.size());
	}
	
	/**
	 *  수정 된 스케줄 DB반영
	 */
	@PostMapping("/hpMemberAdmin/updateSchedule")
	@ResponseBody
	public Result<List<String>> updateSchedule(@RequestBody ChangeDateListDTO changeDataDto) {
		
		List<String> responseDateList = new ArrayList<String>();
		
		try {
			responseDateList = hpScheduleService.updateSchedule(changeDataDto);
		} catch (Exception e) {
			// 삽입, 업데이트 에러 발생 시 클라이언트 측에서 에러 페이지로 이동
			e.printStackTrace();
			responseDateList.add("서버에러");
		}
		
		return new Result<List<String>>(responseDateList, responseDateList.size());
	}
	
	/**
	 * 의료진 순위 변경
	 */
	@PutMapping("/updateDrRank")
	public Map<String, String> updateDrRank(@RequestBody Map<String, List<String>> newDrRankObj) {
		return service.updateDrRank(newDrRankObj.get("drIdList"));
	}

}
