package com.project.hospital.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.admin.dto.DepartmentIdNameDTO;
import com.project.hospital.admin.dto.DoctorInfoDTO;
import com.project.hospital.admin.dto.DoctorInfoOrderByRankDTO;
import com.project.hospital.admin.dto.SelectDrFileIdDTO;
import com.project.hospital.admin.dto.UpdateDrInfoDTO;
import com.project.hospital.admin.dto.UpdateDrRankDTO;
import com.project.hospital.vo.FileStoreVO;
import com.project.hospital.vo.HpMemberVO;

@Repository
public class DoctorCareDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	
	public List<DepartmentIdNameDTO> getDeptIdName() {
		return mybatis.selectList("doctorCare.getDeptName");
	}
	
	/**
	 * 의사 등록 insert
	 */
	public int insertDoctorInfo(HpMemberVO vo) {
		int result = mybatis.insert("doctorCare.insertDoctorInfo", vo);
		return result;
	}
	
	/**
	 * 의사ID 중 번호 가장 높은거 가져오는 메소드
	 */
	public int getDrMaxIdNum() {
		return mybatis.selectOne("doctorCare.getDrMaxIdNum");
	}
	
	/**
	 * 의사 프로필 파일 insert
	 */
	public int insertDrProfileInfo(FileStoreVO vo) {
		return mybatis.insert("doctorCare.insertDrProfileInfo", vo);
	}
	
	
	public List<DoctorInfoDTO> getDrInfoList(int begin, int end) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("begin", begin);
		map.put("end", end);
		
		return mybatis.selectList("doctorCare.getDrInfoList", map);
	}
	
	public int getDrCount() {
		return mybatis.selectOne("doctorCare.getDrCount");
	}
	
	public List<DoctorInfoDTO> searchDrInfo(String keyword, String value) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		
		if ("name".equals(keyword)) {
			map.put("drName", value);
		} else if ("dept".equals(keyword)) {
			map.put("deptName", value);
		} else {
			map.put("drField", value);
		}
		
		
		return mybatis.selectList("doctorCare.searchDrInfo", map);
	}
	
	public List<String> searchDrName(String keyword, String value) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		
		if ("name".equals(keyword)) {
			map.put("drName", value);
		} else if ("dept".equals(keyword)) {
			map.put("deptName", value);
		} else {
			map.put("drField", value);
		}
		
		
		return mybatis.selectList("doctorCare.searchDrName", map);
	}
	//여기 수정
	public List<String> searchDrNames(String drName) {
		return mybatis.selectList("doctorCare.searchDrNames", drName);
	}
	public List<String> searchDeptName(String deptName) {
		return mybatis.selectList("doctorCare.searchDeptName", deptName);
	}
	public List<String> searchDrField(String drField) {
		return mybatis.selectList("doctorCare.searchDrField", drField);
	}
	/////////////
	
	public DoctorInfoDTO getOneDrInfo(String drId) {
		return mybatis.selectOne("doctorCare.getOneDrInfo", drId);
	}
	
	public FileStoreVO getDrProFile(String filestoreId) {
		return mybatis.selectOne("doctorCare.getDrProFile", filestoreId);
	}
	
	//통합 이후 추가한 메소드
	
	public SelectDrFileIdDTO getDrProFileFromHP(String drId) {
		return mybatis.selectOne("doctorCare.getDrProFileFromHP", drId);
	}
	
	/**
	 * 의료진 파일 제외 업데이트(이미지 등록 안되어 있을때)
	 */
	public void updateDrInfo(UpdateDrInfoDTO updateDrInfoDTO) throws Exception {
		mybatis.update("doctorCare.updateDrInfo", updateDrInfoDTO);
	}
	
	/**
	 * 의료진 파일까지 업데이트(이미지 등록 안되어 있을때)
	 */
	//파일 DB연동 트랜잭션 처리(updateDrInfo 오버로딩)
	@Transactional
	public void updateDrInfo(List<FileStoreVO> fileVOList, UpdateDrInfoDTO updateDrInfoDTO) throws Exception {
		for (FileStoreVO vo : fileVOList) {
			if (vo != null) {
				int result = mybatis.insert("doctorCare.insertDrProfileInfo", vo);
			}
		}
		mybatis.update("doctorCare.updateDrInfoAndFile", updateDrInfoDTO);
	}
	
	/**
	 * 의료진 파일까지 업데이트
	 */
	//파일 DB연동 트랜잭션 처리(updateDrInfo 오버로딩)
	@Transactional
	public boolean updateDrInfo(boolean[] existFile, boolean[] existFileForDelete, String[] fileIds, UpdateDrInfoDTO updateDrInfoDTO, 
			List<FileStoreVO> doctorProfileVOList, List<String> savedFileNameList) throws Exception {
		
		boolean result = false;
		int size = savedFileNameList.size();
		for (int i = 0; i < size; i++) {
			if (!existFile[i] && fileIds[i] != null) {
				if (existFileForDelete[i]) {
					//삭제 처리할 파일
					System.out.println("기존 파일 입니다 , 삭제 처리 하세요" + i);
					if (i == 0) {
						//fileone 컬럼 null 처리
						int upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "one", null);
						//filestore 테이블 delete 처리
						int deResult = deleteFileStoreTable(fileIds[i]);
					} else if (i == 1) {
						//filetwo 컬럼 null 처리
						int upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "two", null);
						//filestore 테이블 delete 처리
						int deResult = deleteFileStoreTable(fileIds[i]);
					} else if (i == 2) {
						//filethree 컬럼 null 처리
						int upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "three", null);
						//filestore 테이블 delete 처리
						int deResult = deleteFileStoreTable(fileIds[i]);
					}
				} else {
					//업데이트 처리할 파일
					System.out.println("기존 파일 입니다 , 업데이트 처리 하세요" + i);
					//기존 HP_MEMBER 테이블 파일 컬럼 null로 update
					if (i == 0) {
						//fileone 컬럼 null 처리
						int upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "one", null);
						//fileStore테이블 update 처리
						int upResult2 = updateFileStoreTable(doctorProfileVOList.get(i), fileIds[i]);
						//fileone 컬럼 update 값으로 채우기
						upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "one", doctorProfileVOList.get(i).getFilestoreId());
					} else if (i == 1) {
						//filetwo 컬럼 null 처리
						int upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "two", null);
						//fileStore테이블 update 처리
						int upResult2 = updateFileStoreTable(doctorProfileVOList.get(i), fileIds[i]);
						//filetwo 컬럼 update 값으로 채우기
						upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "two", doctorProfileVOList.get(i).getFilestoreId());
					} else if (i == 2) {
						//filethree 컬럼 null 처리
						int upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "three", null);
						//fileStore테이블 update 처리
						int upResult2 = updateFileStoreTable(doctorProfileVOList.get(i), fileIds[i]);
						//filethree 컬럼 update 값으로 채우기
						upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "three", doctorProfileVOList.get(i).getFilestoreId());
					}
				}
			} else {
				if (savedFileNameList.get(i) != null) {
					//인서트 처리할 파일
					System.out.println("새로운 파일 입니다 ,  INSERT 처리 하세요 " + i); 
					if (i == 0) {
						int insertResult = insertDrProfileInfo(doctorProfileVOList.get(i));
						int upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "one", doctorProfileVOList.get(i).getFilestoreId());
					} else if (i == 1) {
						int insertResult = insertDrProfileInfo(doctorProfileVOList.get(i));
						int upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "two", doctorProfileVOList.get(i).getFilestoreId());
					} else if (i == 2) {
						int insertResult = insertDrProfileInfo(doctorProfileVOList.get(i));
						int upResult = updateDrFileColumn(updateDrInfoDTO.getDrId(), "three", doctorProfileVOList.get(i).getFilestoreId());
					}
				} 
			}
			
		}
		//의료진 정보 수정 처리
		int drInfoResult = mybatis.update("doctorCare.updateDrInfo", updateDrInfoDTO);
		
		result = true;
		return result;
	}
	
	public int updateDrFileColumn(String drId, String fileColumn, String value) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("fileColumn", fileColumn);
		map.put("drId", drId);
		
		if ("one".equals(fileColumn)) {
			map.put("fileone", value);
		} else if ("two".equals(fileColumn)) {
			map.put("filetwo", value);
		} else {
			map.put("filethree", value);
		}
		return mybatis.update("doctorCare.updateDrFileColumn", map);
	}
	
	public int updateFileStoreTable(FileStoreVO doctorProfileVO, String fileIds) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("updateFileId", doctorProfileVO.getFilestoreId());
		map.put("originalName", doctorProfileVO.getOriginalName());
		map.put("filePath", doctorProfileVO.getFilePath());
		map.put("existFileId", fileIds);
		
		return mybatis.update("doctorCare.updateFileStoreTable", map);
	}
	
	public int deleteFileStoreTable(String filestoreId) {
		return mybatis.delete("doctorCare.deleteFileStoreTable", filestoreId);
	}
	
	public int updateDrFileColumnAll(SelectDrFileIdDTO selectDrFileIdDTO) {
		return mybatis.update("doctorCare.updateDrFileColumnAll", selectDrFileIdDTO);
	}
	
	public String getFilePath(String filestoreId) {
		return mybatis.selectOne("doctorCare.getFilePath", filestoreId);
	}
	
	/**
	 * 의료진 삭제
	 */
	public int deleteDrInfo(String drId) {
		return mybatis.delete("doctorCare.deleteDrInfo", drId);
	}
	
	/**
	 * 의료진 진료과장으로 변경
	 */
	public int updateDeptHead(String drId, String deptId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("drId", drId);
		map.put("deptId", deptId);
		return mybatis.update("doctorCare.updateDeptHead", map);
	}
	
	/**
	 * 의료진 비밀번호 변경
	 */
	public int changeDrPwd(Map<String, String> changePwdMap) {
		return mybatis.update("doctorCare.changeDrPwd", changePwdMap);
	}
	
	/**
	 * 의료진 순위 오름차순으로 리스트 가져오기
	 */
	public List<DoctorInfoOrderByRankDTO> getDrInfoOrderByRank() {
		return mybatis.selectList("doctorCare.getDrInfoOrderByRank");
	}
	
	/**
	 * 의료진 순위 변경 메소드
	 */
	public void updateDrRank(UpdateDrRankDTO updateDrRankDTO) {
		mybatis.update("doctorCare.updateDrRank", updateDrRankDTO);
	}
	
	
	
}
