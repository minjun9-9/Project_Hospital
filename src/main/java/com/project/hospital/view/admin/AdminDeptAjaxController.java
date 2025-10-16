package com.project.hospital.view.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.hospital.admin.DeptService;
import com.project.hospital.admin.dto.DeptAndFileDTO;
import com.project.hospital.admin.dto.DeptDrInfoDTO;
import com.project.hospital.admin.dto.DeptForJsonDTO;
import com.project.hospital.admin.dto.SearchDeptIdName;

@RestController
public class AdminDeptAjaxController {
	private final DeptService service;
	
	@Autowired
	public AdminDeptAjaxController(DeptService service) {
		this.service = service;
	}
	/**
	 * 진료과 의료진 목록 가져오는 메소드
	 */
	@PostMapping("/getDeptDrInfo")
	public List<DeptDrInfoDTO> getDeptDrInfo(@RequestBody DeptForJsonDTO deptForJsonDTO) {
		return service.getDeptDrInfo(deptForJsonDTO);
	}
	
	/**
	 * 진료과 ID 중복 체크
	 */
	@GetMapping("/deptIdCheck")
	public boolean deptIdCheck(String deptId) {
		return service.isDuplicateDeptID(deptId);
	}
	
	/**
	 * 진료과 등록
	 */
	@PostMapping("/deptRegister")
	public Map<String, String> adminDeptRegister(
			@RequestParam("deptInfo") String deptInfoJson,
			@RequestParam(value = "deptImage", required = false) MultipartFile deptImage) {
		
		return service.adminDeptRegister(deptInfoJson, deptImage);
	}
	
	/**
	 * 진료과 한명 의료진 데이터 가져오는 메소드
	 */
	@PostMapping("/getOneDeptDrInfo")
	public Map<String, DeptDrInfoDTO> getOneDeptDrInfo(@RequestBody DeptDrInfoDTO deptDrInfoDTO) {
		Map<String, DeptDrInfoDTO> map = new HashMap<String, DeptDrInfoDTO>();
		DeptDrInfoDTO deptOneDrInfo = service.getDeptOneDrInfo(deptDrInfoDTO.getDrId());
		deptOneDrInfo.setDrId(deptDrInfoDTO.getDrId());
		map.put("deptOneDrInfo", deptOneDrInfo);
		return map;
	}
	
	/**
	 * 진료과 수정 메소드
	 */
	@PostMapping("/deptUpdate")
	public Map<String, String> adminDeptUpdate(
			@RequestParam("deptUpdateInfo") String deptUpdateInfoJson,
			@RequestParam(value = "deptImage", required = false) MultipartFile deptImage) {
		
		return service.adminDeptUpdate(deptUpdateInfoJson, deptImage);
	}
	
	/**
	 * 진료과 검색 메소드
	 */
	@GetMapping("/searchDeptIdName")
	public List<SearchDeptIdName> searchDeptIdName(@RequestParam String query) {
		return service.getDeptIdName(query);
	}
	
	/**
	 * 진료과 검색 버튼 클릭시 데이터 가져오는 메소드
	 */
	@GetMapping("/seachDeptByName")
	public List<DeptAndFileDTO> seachDeptByName(@RequestParam String query) {
		return service.getDeptInfoByName(query);
	}
	
	
}
