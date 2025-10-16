package com.project.hospital.admin;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.hospital.admin.dto.DepartmentIdNameDTO;
import com.project.hospital.admin.dto.DoctorInfoDTO;
import com.project.hospital.admin.dto.DoctorInfoJsonMappingVO;
import com.project.hospital.admin.dto.DoctorInfoOrderByRankDTO;
import com.project.hospital.admin.dto.SelectDrFileIdDTO;
import com.project.hospital.admin.dto.UpdateDrInfoDTO;
import com.project.hospital.admin.dto.UpdateDrRankDTO;
import com.project.hospital.admindrMain.dto.LoginResultDTO;
import com.project.hospital.common.Paging;
import com.project.hospital.dao.DoctorCareDAO;
import com.project.hospital.dao.HpMemberDAO;
import com.project.hospital.dao.HpMemberMapperDAO;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.FileStoreVO;
import com.project.hospital.vo.HpMemberVO;

@Service("HpMemberService")
@Transactional(readOnly = true)
public class HpMemberServiceImpl implements HpMemberService{
	
	private HpMemberMapperDAO hpMemberMapperDAO; // @Mapper 방식
	private DoctorCareDAO doctorCareDAO; // origin mapper방식
	private HpMemberDAO hpMemberDAO;

	@Autowired
	public HpMemberServiceImpl(HpMemberMapperDAO hpMemberMapperDAO, DoctorCareDAO doctorCareDAO, HpMemberDAO hpMemberDAO) {
		super();
		this.hpMemberMapperDAO = hpMemberMapperDAO;
		this.doctorCareDAO = doctorCareDAO;
		this.hpMemberDAO = hpMemberDAO;
	}
	
	/**
	 * 페이지 셋팅 
	 */
	@Override
	public Paging pageSet(String cPage) {
		
		//1. 총 의료진 갯수 구하기, 총 페이지 갯수 세팅
		Paging p = new Paging();
		int drCount = doctorCareDAO.getDrCount();
		p.setTotalRecord(drCount);
		p.setTotalPage();
		p.setTotalBlock(); //여기 에러나면 수정해야함(set메소드) 
		
		//2. 현재 페이지 번호 받아와 새팅
		if (cPage != null) {
			p.setNowPage(Integer.parseInt(cPage));
		}
		
		//3. 현재 페이지의 게시물 끝, 시작 세팅
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		
		if (p.getEnd() > p.getTotalRecord()) {
			p.setEnd(p.getTotalRecord());
		}
		
		//4. 현재 페이지 블락 구하기
		int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
		p.setNowBlock(nowBlock);
		
		p.setEndPage(nowBlock * p.getPagePerBlock());
		p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
		
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
		}
		return p;
	}
	
	
	/**
	 * 진료과ID, 이름 리스트 추출
	 */
	@Override //
	public List<DepartmentIdNameDTO> getDeptIdName() {
		return doctorCareDAO.getDeptIdName();
	}
	
	/**
	 * 의료진 등록 서비스 
	 */
	@Override
	public Map<String, String> insertDrInfo(String drInfoJson, List<MultipartFile> profileImage) {
		
		Map<String, String> message = new HashMap<String, String>();
		
		HpMemberVO forInsertVO = new HpMemberVO();
		
		String drId = "";
		
		//전달받은 JSON데이터 처리
		ObjectMapper objMapper = new ObjectMapper();
		try {
			DoctorInfoJsonMappingVO forMappingVO = objMapper.readValue(drInfoJson, DoctorInfoJsonMappingVO.class);
			
			//필수 값 이지만 그래도 서버쪽에서 한번 더  null체크
			if (forMappingVO.getDeptId() == null || forMappingVO.getDrAddress() == null || forMappingVO.getDrEducation() == null ||
					forMappingVO.getDrName() == null || forMappingVO.getDrPhoneNum() == null || forMappingVO.getDrPosition() == null ||
					forMappingVO.getDrPersonNum() == null) {
				
				message.put("msg", "의료진 등록에 실패하였습니다.");
				message.put("result", "fail");
				return message;
			}
			
			//전달받은 진료과 ID로 의료진 ID,PW 생성
			int maxNum = doctorCareDAO.getDrMaxIdNum();
			String hpDeptId = forMappingVO.getDeptId();
			String deptId =  hpDeptId.substring(2);
			drId = deptId + (maxNum + 1); 
			
			//초기 의사 비밀번호 = 의사ID + 전화번호 뒷자리
			String phoneNum = forMappingVO.getDrPhoneNum(); 
			String drPw = drId + phoneNum.substring(phoneNum.lastIndexOf("-") + 1); 
			
			
			//배열값 거내서 콤마(,)로 구분된 문자열 만들기(전문과목, 경력, 학회, 수상)
			String[] keyArr = {"field", "career", "academic", "award"};
			Map<String, List<String>> mapList = new HashMap<String, List<String>>();
			mapList.put("field", forMappingVO.getDrField()); 
			mapList.put("career", forMappingVO.getDrCareer());
			mapList.put("academic", forMappingVO.getDrAcademic());
			mapList.put("award", forMappingVO.getDrAwards());
			
			StringBuilder sb = new StringBuilder();
			
			//전문과목(필수x null값 체크)
			String field = listToString(forMappingVO, mapList, keyArr[0], sb);
			setVO(forInsertVO, field, keyArr[0]);
			
			//경력(필수x null값 체크)
			String career = listToString(forMappingVO, mapList, keyArr[1], sb);
			setVO(forInsertVO, career, keyArr[1]);
			
			//학회(필수x null값 체크)
			String academic = listToString(forMappingVO, mapList, keyArr[2], sb);
			setVO(forInsertVO, academic, keyArr[2]);
			
			//수상(필수x null값 체크)
			String award = listToString(forMappingVO, mapList, keyArr[3], sb);
			setVO(forInsertVO, award, keyArr[3]);
			
			forInsertVO.setDrId(drId);
			forInsertVO.setDrPw(drPw);
			forInsertVO.setDrPhoneNum(phoneNum); 
			forInsertVO.setDrPersonNum(forMappingVO.getDrPersonNum()); 
			forInsertVO.setDeptId(forMappingVO.getDeptId()); 
			forInsertVO.setDrAddress(forMappingVO.getDrAddress()); 
			forInsertVO.setDrPosition(forMappingVO.getDrPosition()); 
			forInsertVO.setDrEducation(forMappingVO.getDrEducation()); 
			forInsertVO.setDrName(forMappingVO.getDrName());
			
			
		} catch (Exception e) {
			System.out.println("AdminAjaxController json 매핑 오류발생");
			e.printStackTrace();
			message.put("msg", "의료진 등록에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		} 
		
		
		//파일 처리
		if (profileImage.size() > 3) {
			message.put("msg", "의료진 등록에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		}
		
		List<String> oriFileNameList = new ArrayList<String>();
		List<String> savedFileNameList = new ArrayList<String>();
		List<String> destFilePathList = new ArrayList<String>();
		List<String> urlPathList = new ArrayList<String>();
		List<FileStoreVO> proFileVOList = new ArrayList<FileStoreVO>();
		boolean uploadResult = false;
		
		//전달받은 파일이 없을때 의료진 테이블에만 INSERT처리
		if (profileImage == null || profileImage.isEmpty()) {
			//파일 없으면 바로 DB에 파일 없이 insert작업
			int result = doctorCareDAO.insertDoctorInfo(forInsertVO); //  잠시 DB연동작업 주석처리
			if (result < 1) {
				message.put("msg", "의료진 등록에 실패하였습니다.");
				message.put("result", "fail");
				return message;
			}
			message.put("msg", "의료진 등록을 완료했습니다");
			message.put("result", "success");
			return message;
		} else {
			
			//전달받은 파일이 있을때 원본파일명, 물리적파일명 ,경로 저장 후 업로드 / 업로드 유무에 따라 의료진 테이블 및 파일 테이블에 트랙잭션으로 INSERT처리
			String destFilePath = "C:/MyStudy/Project_Hospital/Images/Dr_Profile/";
			String urlPath = "/images/DrProfiles/";
			String fileExtention = "";
			int fileNum = 1;
			for (MultipartFile imgFile : profileImage) {
				if (!imgFile.isEmpty()) {
//					oriFileNameList.add(imgFile.getOriginalFilename());
//					savedFileNameList.add(drId + "0" +fileNum);
//					fileExtention = "." + imgFile.getOriginalFilename().substring(imgFile.getOriginalFilename().lastIndexOf(".") + 1);
//					destFilePathList.add(destFilePath + drId + "0" +fileNum + fileExtention);
//					urlPathList.add(urlPath + drId + "0" +fileNum + fileExtention);
//					fileNum++;
					oriFileNameList.add(imgFile.getOriginalFilename());
					savedFileNameList.add(drId + "-" +fileNum);
					fileExtention = "." + imgFile.getOriginalFilename().substring(imgFile.getOriginalFilename().lastIndexOf(".") + 1);
					destFilePathList.add(destFilePath + drId + "-" +fileNum + fileExtention);
					urlPathList.add(urlPath + drId + "-" +fileNum + fileExtention);
					fileNum++;
				}
			}
			int index = 0;
			for (MultipartFile imgFile : profileImage) {
				try {
					imgFile.transferTo(new File(destFilePathList.get(index)));
				} catch (Exception e) {
					//파일 업로드 실패시 파일 삭제처리
					int size = destFilePathList.size();
					for (int i = 0; i < size; i++) {
						File deleteFile = new File(destFilePathList.get(i));
						if (deleteFile.exists()) {
							boolean isDelete = deleteFile.delete();
							System.out.println("파일 업로드 실패시 파일삭제 여부확인 : " + isDelete);
						}
					}
					message.put("msg", "의료진 등록에 실패하였습니다.");
					message.put("result", "fail");
					return message;
				} 
				index++;
			}
			uploadResult = true;
			
			//DoctorProfileVO, DoctorRegisterVO에 데이터 넣기
			int size = destFilePathList.size();
			for (int i = 0; i < size; i++) {
				//proFileVOList.add(new DoctorProfileVO(savedFileNameList.get(i), oriFileNameList.get(i), destFilePathList.get(i)));
				proFileVOList.add(new FileStoreVO(savedFileNameList.get(i), oriFileNameList.get(i), urlPathList.get(i)));
			}
			int size2 = savedFileNameList.size();
			for (int i = 0; i < size2; i++) {
				if (i == 0) {
					forInsertVO.setFileone(savedFileNameList.get(i));
				} else if (i == 1) {
					forInsertVO.setFiletwo(savedFileNameList.get(i));
				} else if (i == 2) {
					forInsertVO.setFilethree(savedFileNameList.get(i));
				}
			}
			
		}
		
		//파일 업로드 성공시 트랙잭션 처리된 쿼리문 실행
		if (uploadResult) {
			insertDrInfoProfileInfo(forInsertVO, proFileVOList);
			message.put("msg", "의료진 등록을 완료했습니다");
			message.put("result", "success");
			return message;
		} else {
			//의료진 등록 실패 문자
			message.put("msg", "의료진 등록에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		}

	}
	
	
	
	@Transactional
	@Override //의사 정보 및 프로필 파일 같이 등록하는 메소드
	public int insertDrInfoProfileInfo(HpMemberVO drInfoVO, List<FileStoreVO> drProfileVOList) {
		int result2 = 0;
		for (FileStoreVO drProfileVO : drProfileVOList) {
			result2 = doctorCareDAO.insertDrProfileInfo(drProfileVO); //의사 프로필 파일 insert
		}
		int result1 = doctorCareDAO.insertDoctorInfo(drInfoVO); // 의사 등록 insert
		if (result1 > 0 && result2 > 0) {
			return result1 + result2;
		}
		return -1;
	}
	
	/**
	 * 의료진 리스트 가져오는 메소드
	 */
	@Override
	public List<DoctorInfoDTO> getDrInfoList(int begin, int end) {
		
		// 의료진 info DTO 추출해 jsp에 보낼 맵핑 작업 시작 
		List<DoctorInfoDTO> drInfoList = doctorCareDAO.getDrInfoList(begin, end);
		
		// mapping
		Map<String,String> deptMap = new HashMap<String,String>();
		StringBuilder sb = new StringBuilder();
		String[] drFields = null;
		
		for (DoctorInfoDTO drInfo : drInfoList) {
			drInfo.setDeptId(deptMap(deptMap, drInfo.getDeptId()));
			
			if (drInfo.getDrField() == null) {
				drInfo.setDrField("전문과목 없음");
				continue;
			}
			
			drFields = drInfo.getDrField().split(",");
			for (int i = 0; i < drFields.length; i++) {
				sb.append(drFields[i]);
				sb.append(", ");
			}
			
			sb.delete(sb.length() - 2, sb.length());
			drInfo.setDrField(sb.toString());
			sb.setLength(0);
		}
		
		return drInfoList;
	}

	
	/**
	 * 의료진 검색 후 리스트 추출
	 */
	@Override
	public List<DoctorInfoDTO> searchDrInfo(String keyword, String value) {
		return doctorCareDAO.searchDrInfo(keyword, value);
	}
	
	/**
	 * 의료진 이름만 검색
	 */
	@Override
	public List<String> searchDrName(String keyword, String value) {
		if ("name".equals(keyword)) {
			return doctorCareDAO.searchDrNames(value);
		} else if ("dept".equals(keyword)) {
			return doctorCareDAO.searchDeptName(value);
		} else {
			return doctorCareDAO.searchDrField(value);
		}
	}
//	@Override
//	public List<String> searchDrName(String keyword, String value) {
//		return doctorCareDAO.searchDrName(keyword, value);
//	}

	/**
	 * 의료진 한명 검색 메소드
	 */
	@Override
	public DoctorInfoDTO getOneDrInfo(String drId) {
		
		DoctorInfoDTO drInfoVO = doctorCareDAO.getOneDrInfo(drId);
		
		List<FileStoreVO> profiles = new ArrayList<FileStoreVO>();
		boolean[] fileNullCheck = {false, false, false};
		
		if (drInfoVO.getFileone() != null) {
			profiles.add(doctorCareDAO.getDrProFile(drInfoVO.getFileone()));
			fileNullCheck[0] = true;
		}
		if (drInfoVO.getFiletwo() != null) {
			profiles.add(doctorCareDAO.getDrProFile(drInfoVO.getFiletwo()));
			fileNullCheck[1] = true;
		}
		if (drInfoVO.getFilethree() != null) {
			profiles.add(doctorCareDAO.getDrProFile(drInfoVO.getFilethree()));
			fileNullCheck[2] = true;
		}
		
		if (fileNullCheck[0] == false && fileNullCheck[1] == false && fileNullCheck[2] == false) {
			return drInfoVO;
		}
		
		List<String> filestoreIdList = new ArrayList<String>();
		List<String> originalNameList = new ArrayList<String>();
		List<String> filePathList = new ArrayList<String>();
		
		
		for (FileStoreVO pVO : profiles) {
			filestoreIdList.add(pVO.getFilestoreId());
			originalNameList.add(pVO.getOriginalName());
			filePathList.add(pVO.getFilePath());
		}
		drInfoVO.setFilestoreId(filestoreIdList);
		drInfoVO.setOriginalName(originalNameList);
		drInfoVO.setFilePath(filePathList);
		
		return drInfoVO;
	}


	/**
	 *  로그인 시 idpw 검증
	 *  반환 시 의사이름, drID만 반환
	 */
	@Override
	public LoginResultDTO findByIdAndPw(String id, String pw) {
		
		Map<String, String> optionMap = new HashMap<String, String>();
		optionMap.put("id", id);
		optionMap.put("pw", pw);
		
		LoginResultDTO resultDto = hpMemberMapperDAO.findByIdAndPw(optionMap);
		
		if (resultDto == null) {
			resultDto = new LoginResultDTO();
		}
		
		return resultDto;
	}
	
	
	//통합 이후 추가한 메소드
	
	@Override
	public FileStoreVO getDrProFile(String filestoreId) {
		return doctorCareDAO.getDrProFile(filestoreId);
	}
	
	/**
	 * 의료진 정보 수정 메소드
	 */
	@Override
	public Map<String, String> updateDrInfo(String updateDrInfoJson, List<MultipartFile> profileImage) {
		
		Map<String, String> message = new HashMap<String, String>();
		
		UpdateDrInfoDTO forMappingDTO = null;
		String drId = "";
		
		//전달받은 JSON데이터 처리
		ObjectMapper objMapper = new ObjectMapper();
		
		try {
			forMappingDTO = objMapper.readValue(updateDrInfoJson, UpdateDrInfoDTO.class);
			
			//필수 값 이지만 그래도 서버쪽에서 한번 더  null체크
			if (forMappingDTO.getDeptId() == null || forMappingDTO.getDrAddress() == null || forMappingDTO.getDrEducation() == null ||
					forMappingDTO.getDrName() == null || forMappingDTO.getDrPhoneNum() == null || forMappingDTO.getDrPosition() == null ||
					forMappingDTO.getDrId() == null) {
				
				message.put("msg", "의료진 정보 수정에 실패하였습니다.");
				message.put("result", "fail");
				return message;
			}
			drId = forMappingDTO.getDrId();
			
			//배열값 거내서 콤마(,)로 구분된 문자열 만들기(전문과목, 경력, 학회, 수상)
			String[] keyArr = {"field", "career", "academic", "award"};
			Map<String, List<String>> mapList = new HashMap<String, List<String>>();
			mapList.put("field", forMappingDTO.getDrFieldList()); 
			mapList.put("career", forMappingDTO.getDrCareerList());
			mapList.put("academic", forMappingDTO.getDrAcademicList());
			mapList.put("award", forMappingDTO.getDrAwardsList());
			
			StringBuilder sb = new StringBuilder();
			
			//전문과목(필수x null값 체크)
			String field = listToString(forMappingDTO, mapList, keyArr[0], sb);
			setVO(forMappingDTO, field, keyArr[0]);
			
			//경력(필수x null값 체크)
			String career = listToString(forMappingDTO, mapList, keyArr[1], sb);
			setVO(forMappingDTO, career, keyArr[1]);
			
			//학회(필수x null값 체크)
			String academic = listToString(forMappingDTO, mapList, keyArr[2], sb);
			setVO(forMappingDTO, academic, keyArr[2]);
			
			//수상(필수x null값 체크)
			String award = listToString(forMappingDTO, mapList, keyArr[3], sb);
			setVO(forMappingDTO, award, keyArr[3]);
			
		} catch (Exception e) {
			System.out.println("HpMemberServiceImpl updateDrInfo() 에러 발생");
			e.printStackTrace();
			message.put("msg", "의료진 정보 수정에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		} 
		
		
		//파일 처리
		if (profileImage.size() > 3) {
			message.put("msg", "의료진 정보 수정에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		}
		
		if (profileImage == null || profileImage.isEmpty()) {
			message.put("msg", "의료진 정보 수정에 실패하였습니다.");
			message.put("result", "fail");
			return message;
		} else {
			String destFilePath = "C:/MyStudy/Project_Hospital/Images/Dr_Profile/";
			String urlPath = "/images/DrProfiles/";
			String fileExtention = "";
			
			int profileImageSize = profileImage.size();
			
			//기존에 존재하던 파일인지 아닌지 확인하는 로직
			String[] originalFilename = new String[profileImageSize];
			
			List<String> filestoreIdList = forMappingDTO.getFilestoreIdList();
			int filestoreIdSize = filestoreIdList.size();
			boolean[] existFile = {false, false, false};
			boolean[] existFileForDelete = {false, false, false};
			
			List<String> oriFileNameList = new ArrayList<String>();
			List<String> savedFileNameList = new ArrayList<String>();
			List<String> destFilePathList = new ArrayList<String>();
			List<String> urlPathList = new ArrayList<String>();
			List<FileStoreVO> doctorProfileVOList = new ArrayList<FileStoreVO>();
			
			if (!(filestoreIdSize == 0)) {
				
				List<String> filestoreIndexList = new ArrayList<String>(); 
				for (String filestoreId : filestoreIdList) {
					filestoreIndexList.add(filestoreId.substring(filestoreId.lastIndexOf(",") + 1));
				}
				
				
				for (int i = 0; i < profileImageSize; i++) {
					originalFilename[i] = profileImage.get(i).getOriginalFilename();
					String deleteName = "exist_file#%"+ i +".txt";
					if (deleteName.equals(originalFilename[i])) {
						existFileForDelete[i] = true;
					}
				}
				
				
				for (int i = 0; i < filestoreIdSize; i++) { 
					if ("0".equals(filestoreIndexList.get(i)) && "empty_file#%0.txt".equals(originalFilename[i])) {
						existFile[i] = true;
					} else if ("1".equals(filestoreIndexList.get(i)) && "empty_file#%1.txt".equals(originalFilename[i])) {
						existFile[i] = true;
					} else if ("2".equals(filestoreIndexList.get(i)) && "empty_file#%2.txt".equals(originalFilename[i])) {
						existFile[i] = true;
					}
				}
				
				//고유 파일이름 만들기 위한 로직
				SelectDrFileIdDTO drFileIdDto = doctorCareDAO.getDrProFileFromHP(drId);
				String[] fileIds = {drFileIdDto.getFileone(), drFileIdDto.getFiletwo(), drFileIdDto.getFilethree()};
				String[] filePaths = new String[fileIds.length];
				for (int i = 0; i < fileIds.length; i++) {
					String filePath = doctorCareDAO.getFilePath(fileIds[i]);
					filePaths[i] = filePath;
				}
				
				int[] fileIdNums = new int[fileIds.length];
				int fileIdMaxNum = 0;
				
				for (int i = 0; i < fileIds.length; i++) {
					if (!(fileIds[i] == null)) {
						try {
							fileIdNums[i] = Integer.parseInt(fileIds[i].substring(fileIds[i].indexOf("-") + 1));
						} catch (NumberFormatException e) {
							System.out.println("숫자 형변환 에러 발생");
							message.put("msg", "의료진 정보 수정에 실패하였습니다.");
							message.put("result", "fail");
							return message;
						}
					} else {
						fileIdNums[i] = 0;
					}
				}
				
				for (int num : fileIdNums) {
					if (fileIdMaxNum < num) {
						fileIdMaxNum = num;
					}
				}
				
				for (int i = 0; i < existFile.length; i++) {
					String emptyFile = "empty_file#%" + i + ".txt";
					String existFileStr = "exist_file#%" + i + ".txt";
					if (!existFile[i] && !(emptyFile.equals(originalFilename[i]) || existFileStr.equals(originalFilename[i]))) {
						//파일 확장자
						fileExtention = "." + originalFilename[i].substring(originalFilename[i].lastIndexOf(".") + 1);
						//원본 파일명
						oriFileNameList.add(originalFilename[i]);
						//물리적 파일명
						savedFileNameList.add(drId + "-" + ++fileIdMaxNum);
						//파일경로
						destFilePathList.add(destFilePath + drId + "-" + fileIdMaxNum + fileExtention);
						//DB저장 경로
						urlPathList.add(urlPath + drId + "-" +fileIdMaxNum + fileExtention);
						
					} else {
						oriFileNameList.add(null);
						savedFileNameList.add(null);
						destFilePathList.add(null);
						urlPathList.add(null);
					}
				}
				
				//1. 새로운 파일 업로드
				//기터 : 중간에 업로드 또는 DB연동 실패 로직 넣어야함
				for (int i = 0; i < profileImageSize; i++) {
					String emptyFile = "empty_file#%" + i + ".txt";
					String existFileStr = "exist_file#%" + i + ".txt";
					if (!(emptyFile.equals(originalFilename[i]) || existFileStr.equals(originalFilename[i])) || destFilePathList.get(i) != null) {
						try {
							profileImage.get(i).transferTo(new File(destFilePathList.get(i)));
						} catch (Exception e) {
							//파일 업로드 실패시 파일 삭제처리
							int size = destFilePathList.size();
							for (int j = 0; j < size; j++) {
								emptyFile = "empty_file#%" + j + ".txt";
								//if (!emptyFile.equals(originalFilename[j]) || destFilePathList.get(j) != null) { 수정전 코드
								if (destFilePathList.get(j) != null) {
									File deleteFile = new File(destFilePathList.get(j));
									if (deleteFile.exists()) {
										boolean isDelete = deleteFile.delete();
										System.out.println("파일 업로드 실패시 파일삭제 여부확인 : " + isDelete);
									}
								}
							}
							message.put("msg", "의료진 정보 수정에 실패하였습니다.");
							message.put("result", "fail");
							return message;
						} 
					}
				}
				
				//2. 데이터베이스에 새로운 파일 경로 업데이트(트랜잭션 처리)
				//2-1  수정 : 기존에 이미지 파일이 있었지만 바꾸는 경우
				//2-2  입력 : 파일이 존재하지 않았을 경우
				int savedFileNameListSize = savedFileNameList.size();
				int nullCnt = 0;
				for (int i = 0; i < savedFileNameListSize; i++) {
					if (savedFileNameList.get(i) == null) {
						nullCnt += 1;
					}
				}
				
				
				forMappingDTO.setFileone(savedFileNameList.get(0));
				forMappingDTO.setFiletwo(savedFileNameList.get(1));
				forMappingDTO.setFilethree(savedFileNameList.get(2));
				
				//여기도 수정함 추후 삭제 예정
				for (int i = 0; i < savedFileNameListSize; i++) {
					FileStoreVO doctorProfileVO = new FileStoreVO(
							savedFileNameList.get(i), oriFileNameList.get(i), urlPathList.get(i));
					
					doctorProfileVOList.add(doctorProfileVO);
				}
				
				//DB 연동작업
				boolean result;
				try {
					result = doctorCareDAO.updateDrInfo(existFile, existFileForDelete, fileIds, forMappingDTO, doctorProfileVOList, savedFileNameList);
				} catch (Exception e) {
					//DB 연동작업 실패시 업로드 파일 삭제 처리
					e.printStackTrace();
					int size = destFilePathList.size();
					for (int j = 0; j < size; j++) {
						if (destFilePathList.get(j) != null) {
							File deleteFile = new File(destFilePathList.get(j));
							if (deleteFile.exists()) {
								boolean isDelete = deleteFile.delete();
								System.out.println("파일 파일삭제 여부확인 : " + isDelete);
							}
						}
					}
					result = false;
					message.put("msg", "의료진 정보 수정에 실패하였습니다.");
					message.put("result", "fail");
					return message;
				}
				
				//3. 파일 업로드 및 경로 업데이트 처리 완료되면 기존 파일 삭제
				List<String> oriDestFilePathList = new ArrayList<String>();
				for (int i = 0; i < savedFileNameListSize; i++) {
					if (!existFile[i] && fileIds[i] != null) {
						//삭제처리시 확장자가 .txt로 붙어서 삭제처리 안된다 
						if (fileIds[i] != null) {
							fileExtention = "." + filePaths[i].substring(filePaths[i].lastIndexOf(".") + 1);
						} else {
							fileExtention = "." + originalFilename[i].substring(originalFilename[i].lastIndexOf(".") + 1);
						}
						oriDestFilePathList.add(destFilePath + fileIds[i] + fileExtention);
						
						File deleteFile = new File(oriDestFilePathList.get(i));
						if (deleteFile.exists()) {
							boolean isDelete = deleteFile.delete();
							System.out.println("파일 파일삭제 여부확인 : " + isDelete);
						}
					} else {
						oriDestFilePathList.add(null);
					}
				}
				
				//의료진 파일 컬럼 순서 조정 메소드 호출 
				setColumnOrder(forMappingDTO.getDrId());
				
				
				
			} else {
				//의료진 처음 등록시 이미지 하나도 입력하지 않은 의료진 처리
				int size = profileImage.size();
				int emptyFileCnt = 0;
				String emptyFile = "";
				for (int i = 0; i < size; i++) {
					emptyFile = "empty_file#%" + i + ".txt";
					if (emptyFile.equals(profileImage.get(i).getOriginalFilename())) {
						originalFilename[i] = null;
						emptyFileCnt++;
					} else {
						originalFilename[i] = profileImage.get(i).getOriginalFilename();
					}
				}
				
				//파일을 하나도 수정하지 않았을때 처리
				if (emptyFileCnt >= 3) {
					//이때 의료진 정보는 업데이트 처리해야함
					try {
						doctorCareDAO.updateDrInfo(forMappingDTO);
					} catch (Exception e) {
						message.put("msg", "의료진 정보 수정에 실패하였습니다.");
						message.put("result", "fail");
						return message;
					}
					
					message.put("msg", "의료진 정보가 수정 되었습니다.");
					message.put("result", "success");
					return message;
				}
				
				//새로운 파일 업로드 준비
				int fileNameNum = 0;
				for (int i = 0; i < size; i++) {
					emptyFile = "empty_file#%" + i + ".txt";
					if (!emptyFile.equals(profileImage.get(i).getOriginalFilename())) {
						//파일 확장자
						fileExtention = "." + originalFilename[i].substring(originalFilename[i].lastIndexOf(".") + 1);
						//원본 파일명
						oriFileNameList.add(profileImage.get(i).getOriginalFilename());
						//물리적 파일명
						savedFileNameList.add(drId + "-" + ++fileNameNum);
						//파일경로
						destFilePathList.add(destFilePath + drId + "-" + fileNameNum + fileExtention);
						//DB저장 경로
						urlPathList.add(urlPath + drId + "-" +fileNameNum + fileExtention);
					} else {
						oriFileNameList.add(null);
						savedFileNameList.add(null);
						destFilePathList.add(null);
						urlPathList.add(null);
					}
				}
				
				//새로운 파일 업로드
				int destFilePathListSize = destFilePathList.size();
				for (int i = 0; i < destFilePathListSize; i++) {
					if (destFilePathList.get(i) != null) {
						try {
							profileImage.get(i).transferTo(new File(destFilePathList.get(i)));
						} catch (Exception e) {
							//파일 업로드 실패시 파일 삭제처리
							for (int j = 0; j < destFilePathListSize; j++) {
								emptyFile = "empty_file#%" + j + ".txt";
								if (!emptyFile.equals(originalFilename[j]) || destFilePathList.get(j) != null) {
									File deleteFile = new File(destFilePathList.get(j));
									if (deleteFile.exists()) {
										boolean isDelete = deleteFile.delete();
										System.out.println("파일 업로드 실패시 파일삭제 여부확인 : " + isDelete);
									}
								}
							}
							message.put("msg", "의료진 정보 수정에 실패하였습니다.");
							message.put("result", "fail");
							return message;
						} 
					}
					
				}
				
				//DB연동 작업을 위한 작업
				int savedFileNameListSize = savedFileNameList.size();
				for (int i =0; i < savedFileNameListSize; i++) {
					if (savedFileNameList.get(i) != null) {
						FileStoreVO vo = new FileStoreVO(savedFileNameList.get(i), oriFileNameList.get(i), urlPathList.get(i));
						doctorProfileVOList.add(vo);
					} else {
						doctorProfileVOList.add(null);
					}
				}
				
				int doctorProfileVOListSize = doctorProfileVOList.size();
				for (int i = 0; i < doctorProfileVOListSize; i++) {
					if (doctorProfileVOList.get(i) != null) {
						if (i == 0) {
							forMappingDTO.setFileone(doctorProfileVOList.get(i).getFilestoreId());
						} else if (i == 1) {
							forMappingDTO.setFiletwo(doctorProfileVOList.get(i).getFilestoreId());
						} else if (i == 2) {
							forMappingDTO.setFilethree(doctorProfileVOList.get(i).getFilestoreId());
						}
					}
				}
				
				//DB연동(파일테이블 + 의료진테이블) / 기존에 프로필 이미지가 없었기 때문에 기존 파일 삭제 처리는 안해도됨
				try {
					doctorCareDAO.updateDrInfo(doctorProfileVOList, forMappingDTO);
				} catch (Exception e) {
					//DB연동 실패시 파일 업로드 삭제 처리
					e.printStackTrace();
					for (int j = 0; j < destFilePathListSize; j++) {
						emptyFile = "empty_file#%" + j + ".txt";
						if (destFilePathList.get(j) != null) {
							File deleteFile = new File(destFilePathList.get(j));
							if (deleteFile.exists()) {
								boolean isDelete = deleteFile.delete();
								System.out.println("파일 업로드 실패시 파일삭제 여부확인 : " + isDelete);
							}
						}
					}
					message.put("msg", "의료진 정보 수정에 실패하였습니다.");
					message.put("result", "fail");
					return message;
				}
				
				//의료진 파일 컬럼 순서 조정 메소드 호출 
				setColumnOrder(forMappingDTO.getDrId());
			}
			
			
			
			
			message.put("msg", "의료진 정보가 수정 되었습니다.");
			message.put("result", "success");
			
			
		}
		
		//진료과장 update 문
		if (forMappingDTO.isDeptHeadCheck()) {
			doctorCareDAO.updateDeptHead(forMappingDTO.getDrId(), forMappingDTO.getDeptId());
		} 
		
		return message;
	}

	/**
	 * 의료진 삭제 메소드
	 */
	@Override
	public int deleteDrInfo(String drId) {
		return doctorCareDAO.deleteDrInfo(drId);
	}
	
	
	/**
	 * 편의 메서드-------------------------------------------------------
	 */
	
	/**
	 *  [의료진 리스트 가져오는 메소드] mapping
	 */
	private String deptMap(Map<String,String> map, String deptId) {
		map.put("SWMG", "내과");
		map.put("SWGS", "외과");
		map.put("SWPD", "소아청소년과");
		map.put("SWOBGY", "산부인과");
		map.put("SWRD", "영상의학과");
		map.put("SWAN", "마취통증의학과");
		map.put("SWCP", "진단검사의학과");
		map.put("SWPC", "정신건강의학과");
		map.put("SWER", "응급의학과");
		
		return map.get(deptId);
	}
	

	/**
	 *  [의료진 등록] List를 콤마(,) 구분자인 String 으로 바꿔주는 메소드
	 */
	private String listToString(DoctorInfoJsonMappingVO vo, Map<String, List<String>> map, String key, StringBuilder sb) {
		List<String> list = map.get(key);
		if (!sb.toString().isEmpty()) {
			sb.setLength(0);
		}
		if (!list.isEmpty()) {
			for (String str : list) {
				sb.append(str);
				sb.append(",");
			}
			sb.deleteCharAt(sb.length() - 1);
		} else {
			return "";
		}
		
		return sb.toString();
	}
	
	/**
	 * [의료진 등록] null값 확인 후 VO에 데이터 저장
	 */
	private void setVO(HpMemberVO vo ,String str, String key) {
		if ("".equals(str)) {
			return;
		} else if ("field".equals(key)) { 
			vo.setDrField(str);
		} else if ("career".equals(key)) {
			vo.setDrCareer(str);
		} else if ("academic".equals(key)) {
			vo.setDrAcademic(str);
		} else if ("award".equals(key)) {
			vo.setDrAwards(str);
		}
		
	}
	
	/**
	 * listToString 오버로딩
	 */
	private String listToString(UpdateDrInfoDTO dto, Map<String, List<String>> map, String key, StringBuilder sb) {
		List<String> list = map.get(key);
		if (!sb.toString().isEmpty()) {
			sb.setLength(0);
		}
		if (!list.isEmpty()) {
			for (String str : list) {
				sb.append(str);
				sb.append(",");
			}
			sb.deleteCharAt(sb.length() - 1);
		} else {
			return "";
		}
		
		return sb.toString();
	}
	
	/**
	 * setVO 오버로딩
	 */
	private void setVO(UpdateDrInfoDTO dto ,String str, String key) {
		if ("".equals(str)) {
			return;
		} else if ("field".equals(key)) { 
			dto.setDrField(str);
		} else if ("career".equals(key)) {
			dto.setDrCareer(str);
		} else if ("academic".equals(key)) {
			dto.setDrAcademic(str);
		} else if ("award".equals(key)) {
			dto.setDrAwards(str);
		}
		
	}
	
	/**
	 * 컬럼 순서 맞추는  로직
	 */
	private void setColumnOrder(String drId) {
		SelectDrFileIdDTO selectDrFileIdDTO = doctorCareDAO.getDrProFileFromHP(drId);
		if (selectDrFileIdDTO == null) {
			return;
		}
		if (selectDrFileIdDTO.getFileone() == null && selectDrFileIdDTO.getFiletwo() == null && selectDrFileIdDTO.getFilethree() != null) {
			selectDrFileIdDTO.setFileone(selectDrFileIdDTO.getFilethree());
			selectDrFileIdDTO.setFilethree(null);
		} else if (selectDrFileIdDTO.getFileone() == null && selectDrFileIdDTO.getFiletwo() != null && selectDrFileIdDTO.getFilethree() == null) {
			selectDrFileIdDTO.setFileone(selectDrFileIdDTO.getFiletwo());
			selectDrFileIdDTO.setFiletwo(null);
		} else if (selectDrFileIdDTO.getFileone() == null && selectDrFileIdDTO.getFiletwo() != null && selectDrFileIdDTO.getFilethree() != null) {
			selectDrFileIdDTO.setFileone(selectDrFileIdDTO.getFiletwo());
			selectDrFileIdDTO.setFiletwo(selectDrFileIdDTO.getFilethree());
			selectDrFileIdDTO.setFilethree(null);
		} else if (selectDrFileIdDTO.getFileone() != null && selectDrFileIdDTO.getFiletwo() == null && selectDrFileIdDTO.getFilethree() != null) {
			selectDrFileIdDTO.setFiletwo(selectDrFileIdDTO.getFilethree());
			selectDrFileIdDTO.setFilethree(null);
		}
		selectDrFileIdDTO.setDrId(drId);
		
		int fileColResult = doctorCareDAO.updateDrFileColumnAll(selectDrFileIdDTO);
	}

	/**
	 * 의료진 리스트 순위 순서로 반환
	 */
//	@Override
//	public String getDrInfoOrderByRank() {
//		
//		List<DoctorInfoOrderByRankDTO> drInfoOrderByRankList = doctorCareDAO.getDrInfoOrderByRank();
//		
//		//Java List -> Json 문자열로 변환
//		ObjectMapper objectMapper = new ObjectMapper();
//		String jsonString = null;
//		try {
//			jsonString = objectMapper.writeValueAsString(drInfoOrderByRankList);
//			System.out.println("jsonString : " + jsonString);
//		} catch (JsonProcessingException e) {
//			System.out.println("json 문자열 변환 오류발생");
//			e.printStackTrace();
//		}
//		
//		return jsonString;
//	}

	/**
	 * 의료진 리스트 순위 순서로 반환
	 */
	@Override
	public List<DoctorInfoOrderByRankDTO> getDrInfoOrderByRank() {
		return doctorCareDAO.getDrInfoOrderByRank();
	}

	@Override
	public Map<String, String> updateDrRank(List<String> updateDrRankList) {
		Map<String, String> message = new HashMap<String, String>();
		int size = updateDrRankList.size();
		for (int i = 0; i < size; i++) {
			UpdateDrRankDTO dto = new UpdateDrRankDTO(updateDrRankList.get(i), i + 1);
			try {
				doctorCareDAO.updateDrRank(dto);
			} catch (Exception e) {
				e.printStackTrace();
				message.put("msg", "의료진 순위 변경에 실패 했습니다");
				message.put("result", "fail");
				return message;
			}
		}
		message.put("msg", "의료진 순위 변경를 변경하였습니다");
		message.put("result", "success");
		return message;
	}
	
	// 통합 후 추가
	@Override
	public List<HpMemberVO> hpMemberSearchList(DeptVO vo) {
		return hpMemberDAO.hpMemberSearchList(vo);
	}
	
	
}
