package com.project.hospital.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.admin.dto.DeptAndFileDTO;
import com.project.hospital.admin.dto.DeptDrInfoDTO;
import com.project.hospital.admin.dto.DeptRegisterDTO;
import com.project.hospital.admin.dto.DeptUpdateDTO;
import com.project.hospital.admin.dto.SearchDeptIdName;
import com.project.hospital.admin.dto.UpdateFileStoreDTO;
import com.project.hospital.vo.FileStoreVO;

@Repository
public class DeptCareDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	/**
	 * 진료과 + 진료과 파일 가져오는 메소드
	 */
	public List<DeptAndFileDTO> getDeptInfo() {
		return mybatis.selectList("deptCare.getDeptInfo");
	}
	
	/**
	 * 진료과 의료진 목록 가져오는 메소드
	 */
	public List<DeptDrInfoDTO> getDeptDrInfo(String deptId) {
		return mybatis.selectList("deptCare.getDeptDrInfo", deptId);
	}
	
	/**
	 * 진료과장 이미지 파일 경로 가져오는 메소드
	 */
	public String getDeptHeadFile(String drId) {
		return mybatis.selectOne("deptCare.getDeptHeadFile", drId);
	}
	
	/**
	 * 진료과 ID 하나만 가져오는 메소드
	 */
	public String getOneDeptId(String deptId) {
		return mybatis.selectOne("deptCare.getOneDeptId", deptId);
	}
	
	/**
	 * 진료과 등록 메소드
	 */
	public int deptRegister(DeptRegisterDTO dto) throws Exception{
		return mybatis.insert("deptCare.deptRegister", dto);
	}
	
	/**
	 * 진료과 정보 및 진료과 이미지 파일 등록 메소드(트랜잭션)
	 */
	@Transactional
	public int deptAndImgFileRegister(DeptRegisterDTO dto, FileStoreVO vo) throws Exception{
		int deptInfoResult = mybatis.insert("deptCare.deptRegister", dto);
		int deptImgFileResult = mybatis.insert("deptCare.deptImgFileRegister", vo);
		
		return deptInfoResult + deptImgFileResult;
	}
	
	/**
	 * 진료과 삭제 메소드
	 */
	public int deleteDeptInfo(String deptId) {
		return mybatis.update("deptCare.deleteDeptInfo", deptId);
	}
	
	/**
	 * 진료과 1개의 정보만 가져오는 메소드
	 */
	public DeptAndFileDTO getOneDeptInfo(String deptId) {
		return mybatis.selectOne("deptCare.getOneDeptInfo", deptId);
	}
	
	/**
	 * 진료과장 정보 가져오는 메소드(파일정보 포함)
	 */
	public DeptDrInfoDTO getDeptOneDrInfo(String drId) {
		return mybatis.selectOne("deptCare.getDeptOneDrInfo", drId);
	}
	
	/**
	 * 진료과 FILEONE 컬럼만 가져오는 메소드
	 */
	public String getDeptFileColumn(String deptId) {
		return mybatis.selectOne("deptCare.getDeptFileColumn", deptId);
	}
	
	/**
	 * 진료과 수정 메소드
	 */
	public int updateDeptInfo(DeptUpdateDTO deptUpdateDTO) {
		return mybatis.update("deptCare.updateDeptInfo", deptUpdateDTO);
	}
	
	/**
	 * 진료과 수정 메소드(오버로딩)
	 */
	@Transactional
	public void updateDeptInfo(UpdateFileStoreDTO updateFileStoreDTO, DeptUpdateDTO deptUpdateDTO) {
		//파일 테이블 수정 처리
		mybatis.update("deptCare.updateFileToNull", deptUpdateDTO.getDeptId());
		mybatis.update("deptCare.updateFileTable", updateFileStoreDTO);
		mybatis.update("deptCare.updateDeptInfo", deptUpdateDTO);
	}
	/**
	 * 진료과 수정 메소드(오버로딩)
	 */
	@Transactional
	public void updateDeptInfo(FileStoreVO fileStoreVO, DeptUpdateDTO deptUpdateDTO) {
		//파일 테이블 입력 처리
		mybatis.insert("deptCare.deptImgFileRegister", fileStoreVO);
		mybatis.update("deptCare.updateDeptInfo", deptUpdateDTO);
	}
	
	/**
	 * 진료과 수정 메소드(오버로딩)
	 */
	@Transactional
	public void updateDeptInfo(String fileStoreId, DeptUpdateDTO deptUpdateDTO) {
		//파일 테이블 삭제 처리
		mybatis.update("deptCare.updateDeptInfo", deptUpdateDTO);
		mybatis.delete("deptCare.deleteDeptFileTable", fileStoreId);
	}
	
	/**
	 * 진료과 파일패스 가져오는 메소드 
	 */
	public String getFilePath(String fileStoreId) {
		return mybatis.selectOne("deptCare.getFilePath", fileStoreId);
	}
	
	/**
	 * 진료과 ID, 이름 가져오는 메소드
	 */
	public List<SearchDeptIdName> getDeptIdName(String deptName) {
		return mybatis.selectList("deptCare.getDeptIdName", deptName);
	}
	
	/**
	 * 진료과 정보 이름으로 검색 메소드
	 */
	public List<DeptAndFileDTO> getDeptInfoByName(String deptName) {
		return mybatis.selectList("deptCare.getDeptInfoByName", deptName);
	}
	
	
}
