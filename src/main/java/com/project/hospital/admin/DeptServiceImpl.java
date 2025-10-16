package com.project.hospital.admin;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hospital.admin.dto.DeptAndFileDTO;
import com.project.hospital.admin.dto.DeptDrInfoDTO;
import com.project.hospital.admin.dto.DeptForJsonDTO;
import com.project.hospital.admin.dto.DeptRegisterDTO;
import com.project.hospital.admin.dto.DeptUpdateDTO;
import com.project.hospital.admin.dto.SearchDeptIdName;
import com.project.hospital.admin.dto.UpdateFileStoreDTO;
import com.project.hospital.dao.DeptCareDAO;
import com.project.hospital.dao.DeptDAO;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.FileStoreVO;
import com.project.hospital.vo.HospitalVO;

@Service("DeptService")
public class DeptServiceImpl implements DeptService{

	private final DeptCareDAO deptCareDAO;
	private final DeptDAO deptDAO;
	
	@Autowired
	public DeptServiceImpl(DeptDAO deptDAO, DeptCareDAO deptCareDAO) {
		super();
		this.deptCareDAO = deptCareDAO;
		this.deptDAO = deptDAO;
	}

	/**
	 * 진료과 + 진료과 파일 가져오는 메소드
	 */
	@Override
	public List<DeptAndFileDTO> getDeptInfo() {
		return deptCareDAO.getDeptInfo();
	}
	
	/**
	 * 진료과 의료진 목록 가져오는 메소드
	 */
	@Override
	public List<DeptDrInfoDTO> getDeptDrInfo(DeptForJsonDTO deptForJsonDTO) {
		String deptHeadId = deptForJsonDTO.getDeptHeadId();
		
		List<DeptDrInfoDTO> DeptDrInfoDTOList = deptCareDAO.getDeptDrInfo(deptForJsonDTO.getDeptId());
		if (DeptDrInfoDTOList.isEmpty()) {
			DeptDrInfoDTOList.add(new DeptDrInfoDTO());
			DeptDrInfoDTOList.get(0).setDrId("empty");
			return DeptDrInfoDTOList;
		}
		
		
		for (DeptDrInfoDTO deptDrInfoDTO : DeptDrInfoDTOList) {
			if (deptDrInfoDTO.getDrId() != null && deptHeadId != null) {
				if (deptDrInfoDTO.getDrId().equals(deptHeadId)) {
					String filePath = deptCareDAO.getDeptHeadFile(deptHeadId);
					deptDrInfoDTO.setFilePath(filePath);
				}
			}
		}
		return DeptDrInfoDTOList;
	}
	
	/**
	 * 진료과 의료진 목록 가져오는 메소드(오버로딩)
	 */
	@Override
	public List<DeptDrInfoDTO> getDeptDrInfo(String deptId) {
		return deptCareDAO.getDeptDrInfo(deptId);
	}

	
	/**
	 * 진료과 ID 중복값 체크하는 메소드
	 */
	@Override
	public boolean isDuplicateDeptID(String deptId) {
		String deptIdCheck = deptCareDAO.getOneDeptId(deptId);
		return deptIdCheck == null ? true : false;
	}

	/**
	 * 진료과 등록 메소드
	 */
	@Override
	public Map<String, String> adminDeptRegister(String deptInfoJson, MultipartFile deptImage) {
		
		Map<String, String> message = new HashMap<String, String>();
		DeptRegisterDTO forMappingDTO = null;
		
		//전달받은 JSON데이터 처리
		ObjectMapper objMapper = new ObjectMapper();
		try {
			forMappingDTO = objMapper.readValue(deptInfoJson, DeptRegisterDTO.class);
		} catch (Exception e) {
			System.out.println("DeptServiceImpl adminDeptRegister json 데이터 매핑 오류");
			e.printStackTrace();
			message.put("msg", "진료과 등록에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		} 
		
		if (forMappingDTO.getDeptId() == null || forMappingDTO.getDeptName() == null) {
			message.put("msg", "진료과 등록에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		}
			
		//DB insert 작업
		if (deptImage != null) { 
			String destFilePath = "C:/MyStudy/Project_Hospital/Images/Department/";
			String urlPath = "/images/DrProfiles/";
			String fileExtention = "";
			
			String oriFileName = deptImage.getOriginalFilename();
			String savedFileName = forMappingDTO.getDeptId() + "-" + 1;
			fileExtention = "." + oriFileName.substring(oriFileName.lastIndexOf(".") + 1);
			destFilePath += savedFileName + fileExtention;
			urlPath += savedFileName + fileExtention;
			
			
			//파일 업로드
			try {
				deptImage.transferTo(new File(destFilePath));
			} catch (Exception e) {
				//파일 업로드 실패시 파일 삭제처리
				File deleteFile = new File(destFilePath);
				if (deleteFile.exists()) {
					boolean isDelete = deleteFile.delete();
					System.out.println("파일 업로드 실패시 파일삭제 여부확인 : " + isDelete);
				}
				message.put("msg", "진료과 등록에 실패하였습니다.");
				message.put("result", "fail");
				return message;
			} 
			
			//DTO, VO에 데이터 담기
			forMappingDTO.setFileone(savedFileName);
			FileStoreVO fileStoreVO = new FileStoreVO(savedFileName, oriFileName, urlPath);
			
			//DB연동 작업
			try {
				deptCareDAO.deptAndImgFileRegister(forMappingDTO, fileStoreVO);
			} catch (Exception e) {
				message.put("msg", "진료과 등록에 실패하였습니다.");
				message.put("result", "fail");
				return message;
			}
			
			
		} else {
			//파일 첨부 없을시 진료과 데이터 DB insert
			try {
				deptCareDAO.deptRegister(forMappingDTO);
			} catch (Exception e) {
				message.put("msg", "진료과 등록에 실패하였습니다.");
				message.put("result", "fail");
				return message;
			}
		}
			
		message.put("msg", "진료과 등록을 완료했습니다");
		message.put("result", "success");
		
		return message;
	}

	/**
	 * 진료과 삭제
	 */
	@Override
	public int deletedeptInfo(String deptId) {
		return deptCareDAO.deleteDeptInfo(deptId);
	}

	/**
	 * 진료과 1개의 정보만 가져오는 메소드
	 */
	@Override
	public DeptAndFileDTO getOneDeptInfo(String deptId) {
		return deptCareDAO.getOneDeptInfo(deptId);
	}

	/**
	 * 진료과 한명 의료진 정보 가져오는 메소드(파일정보 포함)
	 */
	@Override
	public DeptDrInfoDTO getDeptOneDrInfo(String drId) {
		return deptCareDAO.getDeptOneDrInfo(drId);
	}

	/**
	 * 진료과 수정 메소드
	 */
	public Map<String, String> adminDeptUpdate(String deptUpdateInfoJson, MultipartFile deptImage) {
		
		Map<String, String> message = new HashMap<String, String>();
		DeptUpdateDTO deptUpdateDTO = null;
		
		//전달받은 JSON데이터 처리
		ObjectMapper objMapper = new ObjectMapper();
		
		try {
			deptUpdateDTO = objMapper.readValue(deptUpdateInfoJson, DeptUpdateDTO.class);
		} catch (Exception e) {
			System.out.println("DeptServiceImpl adminDeptUpdate json 데이터 매핑 오류");
			e.printStackTrace();
			message.put("msg", "진료과 수정에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		} 
		
		if (deptUpdateDTO.getDeptId() == null || deptUpdateDTO.getDeptName() == null) {
			message.put("msg", "진료과 수정에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		}
		
		if (deptUpdateDTO.getDeptHeadId().isEmpty()) {
			deptUpdateDTO.setDeptHeadId(null);
		}
		
		//파일처리(업로드 및 삭제)
		//deptImage -> not null 파일 업로드 처리
		if (deptImage != null) {
			System.out.println("파일 업로드 진행");
			String destFilePath = "C:/MyStudy/Project_Hospital/Images/Department/";
			String urlPath = "/images/DrProfiles/";
			String fileExtention = "";
			
			
			String oriFileName = deptImage.getOriginalFilename();
			String savedFileName = "";
			fileExtention = "." + oriFileName.substring(oriFileName.lastIndexOf(".") + 1);
			
			UpdateFileStoreDTO updateFileStoreDTO = null;
			
			if (deptUpdateDTO.isExistFile()) {
				//isExistFile -> true 기존에 업로드한 파일 있음 -> 수정 처리
				System.out.println("기존 파일이 존재 합니다 수정처리 하세요");
				String deptFileOne = deptCareDAO.getDeptFileColumn(deptUpdateDTO.getDeptId());
				String oriDestFilePath = destFilePath + deptFileOne + fileExtention;
				try {
					int originalFileNum = Integer.parseInt(deptFileOne.substring(deptFileOne.lastIndexOf("-") + 1));
					savedFileName = deptUpdateDTO.getDeptId() + "-" + (originalFileNum + 1);
					destFilePath += savedFileName + fileExtention;
					urlPath += savedFileName + fileExtention;
				} catch (NumberFormatException e) {
					System.out.println("숫자 형변환 에러 발생");
					message.put("msg", "진료과 수정에 실패하였습니다.");
					message.put("result", "fail");
					return message;
				}
				
				updateFileStoreDTO = new UpdateFileStoreDTO(deptFileOne ,savedFileName, oriFileName, urlPath);
				deptUpdateDTO.setFileone(savedFileName);
				
				//파일 업로드
				try {
					deptImage.transferTo(new File(destFilePath));
				} catch (Exception e) {
					e.printStackTrace();
					//파일 업로드 실패시 파일 삭제처리
					File deleteFile = new File(destFilePath);
					if (deleteFile.exists()) {
						boolean isDelete = deleteFile.delete();
						System.out.println("파일 업로드 실패시 파일삭제 여부확인 : " + isDelete);
					}
					message.put("msg", "진료과 수정에 실패하였습니다.");
					message.put("result", "fail");
					return message;
				} 
				
				//DB연동    기존 fileone컬럼 null, filestore 테이블 update, dept테이블 update
				deptCareDAO.updateDeptInfo(updateFileStoreDTO, deptUpdateDTO);
				
				//기존 파일 삭제 처리
				File deleteFile = new File(oriDestFilePath);
				if (deleteFile.exists()) {
					boolean isDelete = deleteFile.delete();
					System.out.println("파일 파일삭제 여부확인 : " + isDelete);
				}
				
			} else {
				//isExistFile -> false 기존에 업로드한 파일 없음 -> 입력 처리
				System.out.println("기존 파일이 없습니다 입력처리 하세요");
				savedFileName = deptUpdateDTO.getDeptId() + "-" + 1;
				destFilePath += savedFileName + fileExtention;
				urlPath += savedFileName + fileExtention;
				
				FileStoreVO fileStoreVO = new FileStoreVO(savedFileName, oriFileName, urlPath);
				deptUpdateDTO.setFileone(savedFileName);
				
				//파일 업로드
				try {
					deptImage.transferTo(new File(destFilePath));
				} catch (Exception e) {
					e.printStackTrace();
					//파일 업로드 실패시 파일 삭제처리
					File deleteFile = new File(destFilePath);
					if (deleteFile.exists()) {
						boolean isDelete = deleteFile.delete();
						System.out.println("파일 업로드 실패시 파일삭제 여부확인 : " + isDelete);
					}
					message.put("msg", "진료과 수정에 실패하였습니다.");
					message.put("result", "fail");
					return message;
				} 
				
				//DB연동 FileStore 테이블 입력, Dept 테이블 수정
				deptCareDAO.updateDeptInfo(fileStoreVO, deptUpdateDTO);
				
			}
			
		} else if (deptImage == null && deptUpdateDTO.isDeleteFile()){
			//파일 비우기 버튼 누르고 새로 업로드 안했을 경우 삭제 처리
			System.out.println("기존 파일을 삭제 처리 합니다");
			String destFilePath = "C:/MyStudy/Project_Hospital/Images/Department/";
			String fileExtention = ""; 
			
			String deptFileOne = deptCareDAO.getDeptFileColumn(deptUpdateDTO.getDeptId());
			String oriFilePath = deptCareDAO.getFilePath(deptFileOne);
			fileExtention = "." + oriFilePath.substring(oriFilePath.lastIndexOf(".") + 1);
			String oriDestFilePath = destFilePath + deptFileOne + fileExtention;
			
			
			//DB에 먼저 삭제  dept 정보 업데이트 처리(파일컬럼 null이 되어야함), 파일 테이블 delete처리
			deptCareDAO.updateDeptInfo(deptFileOne, deptUpdateDTO);
			
			//기존 파일 삭제 처리
			File deleteFile = new File(oriDestFilePath);
			if (deleteFile.exists()) {
				boolean isDelete = deleteFile.delete();
				System.out.println("파일 파일삭제 여부확인 : " + isDelete);
			}
			
		} else {
			//파일 테이블말고 진료과 테이블만 update
			System.out.println("파일 업로드 안함 진료과 정보만 업데이트 하세요");
			deptCareDAO.updateDeptInfo(deptUpdateDTO);
		}
		
		message.put("msg", "진료과 수정을 완료했습니다");
		message.put("result", "success");
		
		return message;
	}
	
	/**
	 * 진료과 ID, 이름 가져오는 메소드
	 */
	@Override
	public List<SearchDeptIdName> getDeptIdName(String deptName) {
		return deptCareDAO.getDeptIdName(deptName);
	}

	/**
	 * 진료과 정보 이름으로 검색 메소드
	 */
	@Override
	public List<DeptAndFileDTO> getDeptInfoByName(String deptName) {
		return deptCareDAO.getDeptInfoByName(deptName);
	}
	
	
	// 통합 후 추가
	@Override
	public List<DeptVO> deptlList(HospitalVO vo) {
		return deptDAO.deptlList(vo);
	}




	

}
