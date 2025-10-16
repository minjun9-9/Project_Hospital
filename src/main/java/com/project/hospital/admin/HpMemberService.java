package com.project.hospital.admin;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.project.hospital.admin.dto.DepartmentIdNameDTO;
import com.project.hospital.admin.dto.DoctorInfoDTO;
import com.project.hospital.admin.dto.DoctorInfoOrderByRankDTO;
import com.project.hospital.admindrMain.dto.LoginResultDTO;
import com.project.hospital.common.Paging;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.FileStoreVO;
import com.project.hospital.vo.HpMemberVO;

public interface HpMemberService {
	
	public List<DepartmentIdNameDTO> getDeptIdName();
	public int insertDrInfoProfileInfo(HpMemberVO drInfoVO, List<FileStoreVO> drprofileVOList);
	public List<DoctorInfoDTO> getDrInfoList(int begin, int end);
	public List<DoctorInfoDTO> searchDrInfo(String keyword, String value);
	public DoctorInfoDTO getOneDrInfo(String drId);
	
	// 1번째 통합이후 추가한 메서드
	public FileStoreVO getDrProFile(String filestoreId);
	public Map<String, String> updateDrInfo(String updateDrInfoJson, List<MultipartFile> profileImage);
	public int deleteDrInfo(String drId);
	
	// 1번째 합칠 때 추가한 메서드
	public Paging pageSet(String cPage);
	public Map<String, String> insertDrInfo(String drInfoJson, List<MultipartFile> profileImage);
	
	public LoginResultDTO findByIdAndPw(String id, String pw);
	public List<String> searchDrName(String keyword, String value);
	public List<DoctorInfoOrderByRankDTO> getDrInfoOrderByRank();
	public Map<String, String> updateDrRank(List<String> updateDrRankList);
	
	// 통합 후 추가
	List<HpMemberVO> hpMemberSearchList(DeptVO vo);
}
