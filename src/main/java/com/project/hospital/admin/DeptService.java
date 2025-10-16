package com.project.hospital.admin;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.project.hospital.admin.dto.DeptAndFileDTO;
import com.project.hospital.admin.dto.DeptDrInfoDTO;
import com.project.hospital.admin.dto.DeptForJsonDTO;
import com.project.hospital.admin.dto.SearchDeptIdName;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HospitalVO;
	
public interface DeptService {
	public List<DeptAndFileDTO> getDeptInfo();
	public List<DeptDrInfoDTO> getDeptDrInfo(DeptForJsonDTO deptForJsonDTO);
	public List<DeptDrInfoDTO> getDeptDrInfo(String deptId);
	public boolean isDuplicateDeptID(String deptId);
	public Map<String, String> adminDeptRegister(String deptInfoJson, MultipartFile deptImage);
	public int deletedeptInfo(String deptId);
	public DeptAndFileDTO getOneDeptInfo(String deptId);
	public DeptDrInfoDTO getDeptOneDrInfo(String drId);
	public Map<String, String> adminDeptUpdate(String deptUpdateInfoJson, MultipartFile deptImage);
	public List<SearchDeptIdName> getDeptIdName(String deptName);
	public List<DeptAndFileDTO> getDeptInfoByName(String deptName);
	
	// 통합 후 추가
	List<DeptVO> deptlList(HospitalVO vo);
}
