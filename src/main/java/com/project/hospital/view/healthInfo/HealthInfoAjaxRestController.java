package com.project.hospital.view.healthInfo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.hospital.health.HealthService;
import com.project.hospital.health.dto.DeleteDTO;
import com.project.hospital.health.dto.DiseaseBoardDTO;
import com.project.hospital.health.dto.DiseaseBoardPageDTO;
import com.project.hospital.health.dto.DiseaseBoardSearchDTO;
import com.project.hospital.health.dto.ExaminationBoardDTO;
import com.project.hospital.health.dto.ExaminationBoardPageDTO;
import com.project.hospital.health.dto.HealthBoardDTO;
import com.project.hospital.health.dto.HealthBoardPageDTO;
import com.project.hospital.health.dto.SearchDTO;
import com.project.hospital.vo.BodyClassificationVO;
import com.project.hospital.vo.DiseaseBoardVO;
import com.project.hospital.vo.DiseaseClassificationVO;
import com.project.hospital.vo.ExaminationBoardVO;
import com.project.hospital.vo.HealthBoardVO;

@RestController
@RequestMapping("health")
public class HealthInfoAjaxRestController {
	
	private HealthService healthService;
	
	@Autowired
	public HealthInfoAjaxRestController(HealthService healthService) {
		this.healthService = healthService;
	}
	
	@GetMapping("/getDiseaseListByBodyPart/{bodyPartName}")
	public List<DiseaseBoardVO> getDiseaseListByBodyPart(@PathVariable String bodyPartName) {
		System.out.println(">> 아작스(질환게시판) bodyPartName : " + bodyPartName);
		return healthService.getDiseaseListByBodyPart(bodyPartName);
	}
	
	@GetMapping("/getExaminListByBodyPart/{bodyPartName}")
	public List<ExaminationBoardVO> getExaminationListByBodyPart(@PathVariable String bodyPartName) {
		System.out.println(">> 아작스(검사게시판) bodyPartName : " + bodyPartName);
		return healthService.getExaminationListByBodyPart(bodyPartName);
	}
	
	@PostMapping("/getExaminListByBodyPartAndSearchKeyword")
	public List<ExaminationBoardDTO> getExaminListByBodyPartAndSearchKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println(">> 아작스(검사게시판) bodyPartName : " + searchDTO);
		return healthService.getExaminListByBodyPartAndSearchKeyword(searchDTO);
	}
	
	@PostMapping("/getExaminationBoardOnlySearchByKeyword")
	public List<ExaminationBoardDTO> getExaminationBoardOnlySearchByKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println(">> 아작스(검사게시판) 키워드 검색만 : " + searchDTO);
		return healthService.getExaminationBoardOnlySearchByKeyword(searchDTO);
	}
	
	@GetMapping("/getDiseaseBoardList")
	public List<DiseaseBoardDTO> getDiseaseBoardList() {
		System.out.println(">> 아작스 초기 설정 (질환) ");
		return healthService.getDiseaseBoardList();
	}
	
	@GetMapping("/getDiseaseBoardListClientPage") 
	public List<DiseaseBoardDTO> getDiseaseBoardListClientPage() {
		System.out.println(">> 질환 게시판 카드뉴스 출력 ");
		return healthService.getDiseaseBoardListClientPage();
	}
	
	
	@GetMapping("/getExaminBoardList")
	public List<ExaminationBoardDTO> getExaminationBoardList() {
		System.out.println(">> 아작스 초기 설정 (검사) ");
		return healthService.getExaminationBoardList();
	}
	
	@GetMapping("/getExaminationBoardListClientPage")
	public List<ExaminationBoardDTO> getExaminationBoardListClientPage() {
		System.out.println(">> 검사 게시판 카드뉴스 출력 ");
		return healthService.getExaminationBoardListClientPage();
	}
	

	@PostMapping("/getDiseaseBoardBySearchKeyword")
	public List<DiseaseBoardDTO> getDiseaseBoardBySearchKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println("검색어로 질환 찾기 : " + searchDTO); 
		List<DiseaseBoardDTO> test = healthService.getDiseaseBoardBySearchKeyword(searchDTO);
		System.out.println("검색된 결과 : " + test);
		return test;
	}
	
	@PostMapping("/getDiseaseBoardOnlySearchByKeyword")
	public List<DiseaseBoardDTO> getDiseaseBoardOnlySearchByKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println("전체 게시판에서 검색어로만 질환 찾기  : " + searchDTO); 
		List<DiseaseBoardDTO> test = healthService.getDiseaseBoardOnlySearchByKeyword(searchDTO);
		System.out.println("검색된 결과 : " + test);
		//return healthService.getDiseaseBoardBySearchKeyword(keyword);
		return test;
	}
	
	@PostMapping("/getDiseaseBoardByBodyPartAndSearchKeyword")
	public List<DiseaseBoardDTO> getDiseaseBoardByBodyAndSearchKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println("신체 부위 + 검색어로 질환 찾기 : " + searchDTO); 
		List<DiseaseBoardDTO> test = healthService.getDiseaseBoardBySearchKeyword(searchDTO);
		System.out.println("검색된 결과 : " + test);
		return test;
	}
	
	@PostMapping("/getDiseaseSearchByDiseasePartAndSearchKeyword")
	public List<DiseaseBoardDTO> getDiseaseSearchByDiseasePartAndSearchKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println("질환 분류 + 검색어로 질환 찾기 : " + searchDTO);
		List<DiseaseBoardDTO> test = healthService.getDiseaseBoardByDiseasePartAndSearchKeyword(searchDTO);
		System.out.println("검색 결과 : " + test);
		return test;
	}
	
	@PostMapping("/getHealthBoardByKeyword")
	public List<HealthBoardVO> getHealthBoardByKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println("건강 게시판 검색어로 찾기 : " + searchDTO);
		List<HealthBoardVO> test = healthService.getHealthBoardByKeyword(searchDTO);
		System.out.println("검색 결과 : " + test);
		return test;          
	}
	
	//관리자_건강정보 -------------------------------
	//1. 질환 분류 
	@PutMapping("/updateDiseaseClassification/{inputText}")
	public int updateDiseaseClassification(@PathVariable String inputText, @RequestBody DiseaseClassificationVO diseaseClassificationVO) {
		diseaseClassificationVO.setDiseasePartName(inputText);
		System.out.println("아작스 질환 분류 update 실행 : " + diseaseClassificationVO);
		int result = healthService.updateDiseasePartName(diseaseClassificationVO); //업데이트 행 반환
		if (result == 1) {
			return result;
		} else {
			return 0;
		}
	}
	
	@PostMapping("/insertDiseaseClassification/{inputText}")
	public int insertDiseaseClassification(@PathVariable String inputText) {
		System.out.println("아작스 질환 분류 INSERT 실행 : " + inputText);
		int result = healthService.insertDiseaseClassification(inputText);
		if (result == 1) {
			return 1;
		} else {
			return -0;
		}
	}
	
	@DeleteMapping("/deleteDiseaseClassification")
	public int deleteDiseaseClassification(@RequestBody DeleteDTO deleteDTO) {
		System.out.println("아작스 질환 분류 DELETE 실행 : " + deleteDTO);
		int result = healthService.deleteDiseaseClassification(deleteDTO);
		if (result >= 1) {
			return result;
		} else {
			return 0;
		}
	}
	
	//2. 신체 분류
	@PostMapping("/insertBodyClassification/{inputText}")
	public int insertBodyClassification(@PathVariable String inputText) {
		System.out.println("아작스 신체 분류 INSERT 실행 : " + inputText);
		int result = healthService.insertBodyClassification(inputText);
		if (result == 1) {
			return result;
		} else {
			return 0;
		}
	}
	
	@DeleteMapping("/deleteBodyClassification")
	public int deleteBodyClassification(@RequestBody DeleteDTO deleteDTO) {
		System.out.println("아작스 질환 분류 DELETE 실행 : " + deleteDTO);
		int result = healthService.deleteBodyClassification(deleteDTO);
		if (result >= 1) {
			return result;
		} else {
			return 0;
		}
	}
	
	@PutMapping("/updateBodyClassification/{inputText}")
	public int updateBodyClassification(@PathVariable String inputText, @RequestBody BodyClassificationVO bodyClassificationVO) {
		bodyClassificationVO.setBodyPartName(inputText);
		System.out.println("아작스 신체 분류 UPDATE 실행 : " + bodyClassificationVO);
		int result = healthService.updateBodyPartName(bodyClassificationVO);
		if (result == 1) {
			return result;
		} else {
			return 0;
		}
	}
	
	
	//3. 질환 게시판
	@DeleteMapping("/deleteDiseaseBoard")
	public int deleteDiseaseBoard(@RequestBody DeleteDTO deleteDTO ) {
		System.out.println("아작스 질환 게시판 DELETE 실행 : " + deleteDTO);
		int result = healthService.deleteDiseaseBoard(deleteDTO);
		if (result >= 1) {
			return result;
		} else {
			return 0;
		}
	}
	
	//캘린더 날짜 검색
	@PostMapping("/searchByCalendarDiseaseBoard")
	public List<DiseaseBoardDTO> searchByCalendarDiseaseBoard(@RequestBody DiseaseBoardSearchDTO diseaseBoardSearchDTO) {
		System.out.println("아작스 질환 게시판 캘린더 날짜 검색 실행 : " + diseaseBoardSearchDTO); //끼얏호
		return healthService.searchByCalendarDiseaseBoard(diseaseBoardSearchDTO);
	}
	
	//날짜 구간 검색
	@GetMapping("/searchByTermDiseaseBoard/{term}")
	public List<DiseaseBoardDTO> searchByTermDiseaseBoard(@PathVariable String term) {
		System.out.println("아작스 질환 게시판 날짜 구간 검색 실행 : " + term);
		return healthService.searchByTermDiseaseBoard(term);
	}
	
	//글 검색 기능(제목만, 내용만) + 키워드
	@PostMapping("/searchDiseaseBoardByTitleOrContentAndKeyword")
	public List<DiseaseBoardDTO> searchDiseaseBoardByTitleOrContentAndKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println("아작스 질환 게시판 제목만+내용만 키워드 검색 실행 : " + searchDTO);
		return healthService.searchDiseaseBoardByTitleOrContentAndKeyword(searchDTO);
	}
	
	//분류별(질환분류, 신체분류) 검색 기능
	@PostMapping("/searchDiseaseBoardByClassification")
	public List<DiseaseBoardDTO> searchDiseaseBoardByClassification(@RequestBody SearchDTO searchDTO) {
		System.out.println("아작스 질환 게시판 분류 종류별 검색 기능 : " + searchDTO);
		return healthService.searchDiseaseBoardByClassification(searchDTO);
	}
	
	//질환게시판 페이지네이션 
	@GetMapping("/getDiseaseBoardPage/{pageNum}")
	public DiseaseBoardPageDTO getDiseaseBoard2ndPage(@PathVariable int pageNum) {
		System.out.println("아작스 질환 게시판 페이지네이션 실행 : " + pageNum);
		
		//글목록 가져오기
		List<DiseaseBoardDTO> boardList = healthService.getDiseaseBoardPage(pageNum);
		
		//전체 게시글 개수 조회
		int totalCount = healthService.getDiseaseBoardTotalCount().getTotalCount();
		int pageSize = 10;
		int totalPageCount = (int) Math.ceil((double) totalCount / pageSize);
		
		DiseaseBoardPageDTO dto = new DiseaseBoardPageDTO();
		dto.setBoardList(boardList);
		dto.setCurrentPage(pageNum);
		dto.setTotalPageCount(totalPageCount);
		dto.setTotalCount(totalCount);
		
		return dto;
	}
	
	//4. 검사, 치료 게시판 페이지네이션
	//검사, 치료 게시판 페이지네이션
	@GetMapping("/getExaminationBoardPage/{pageNum}")
	public ExaminationBoardPageDTO getExaminationBoardPage(@PathVariable int pageNum) {
		System.out.println("아작스 검사, 치료 게시판 페이지네이션 실행 : " + pageNum);
		
		//글목록 가져오기
		List<ExaminationBoardDTO> boardList = healthService.getExaminationBoardPage(pageNum);
		
		//전체 게시글 개수 조회
		int totalCount = healthService.getExaminationBoardTotalCount().getTotalCount();
		int pageSize = 10;
		int totalPageCount = (int) Math.ceil((double) totalCount / pageSize);
		
		ExaminationBoardPageDTO dto = new ExaminationBoardPageDTO();
		dto.setBoardList(boardList);
		dto.setCurrentPage(pageNum);
		dto.setTotalPageCount(totalPageCount);
		dto.setTotalCount(totalCount);
		
		return dto;
	}
	
	//신체 분류별 검색 기능
	@PostMapping("/searchExaminationBoardByBodyClassification")
	public List<ExaminationBoardDTO> searchExaminationBoardByBodyClassification(@RequestBody SearchDTO searchDTO) {
		System.out.println("아작스 검사, 치료 게시판 신체분류별 검색 실행 : " + searchDTO);
		
		return healthService.searchExaminationBoardByBodyClassification(searchDTO);
		
		//10개 이상이면 페이지네이션 하려고 했는데 포기
		/*
		//없는 데이터는 null
		System.out.println(" 페이지네이션 O DTO " + map.get("examinationBoardPageDTO"));
		System.out.println(" 페이지네이션 X DTO " + map.get("examinationBoardDTO")); 
		if (map.get("examinationBoardPageDTO") != null ) {
			return (ExaminationBoardPageDTO) map.get("examinationBoardPageDTO");
		} 
		if (map.get("examinationBoardDTO") != null) {
			return (ExaminationBoardPageDTO) map.get("examinationBoardDTO");
		}
		*/
	}
	
	@PostMapping("/searchExaminationBoardByTitleOrContentAndKeyword")
	public List<ExaminationBoardDTO> searchExaminationBoardByTitleOrContentAndKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println("아작스 검사, 치료 게시판 내용/제목 키워드 검색 : " + searchDTO);
		return healthService.searchExaminationBoardByTitleOrContentAndKeyword(searchDTO);
	}
	
	@PostMapping("/searchByCalendarExaminationBoard")
	public ExaminationBoardPageDTO searchByCalendarExaminationBoard(@RequestBody SearchDTO searchDTO) {
		System.out.println("아작스 검사, 치료 게시판 캘린더 검색 : " + searchDTO);
		List<ExaminationBoardDTO> list = healthService.searchByCalendarExaminationBoard(searchDTO);
		ExaminationBoardPageDTO dto = new ExaminationBoardPageDTO();
		//검색으로 조회된 데이터 개수
		int totalCount = 0;
		for(ExaminationBoardDTO hb : list) {
			totalCount = Integer.parseInt(hb.getTotalCount());
		}
		System.out.println("조회된 글의 개수 : " + totalCount);
		dto.setTotalCount(totalCount);
		dto.setBoardList(list);
		return dto;
	}
	
	@GetMapping("/searchByTermExaminationBoard/{term}")
	public ExaminationBoardPageDTO searchByTermExaminationBoard(@PathVariable String term) {
		System.out.println("아작스 검사, 치료 게시판 구간 검색 : " + term);
		List<ExaminationBoardDTO> list = healthService.searchByTermExaminationBoard(term);
		ExaminationBoardPageDTO dto = new ExaminationBoardPageDTO();
		
		dto.setBoardList(list);
		int totalCount = 0;
		for(ExaminationBoardDTO hb : list) {
			totalCount = Integer.parseInt(hb.getTotalCount());
		}
		dto.setTotalCount(totalCount);
		return dto;
	}
	
	@DeleteMapping("/deleteExaminationBoard")
	public int deleteExaminationBoard(@RequestBody DeleteDTO deleteDTO) {
		System.out.println("아작스 검사, 치료 게시판 삭제 기능 : " + deleteDTO);
		int result = healthService.deleteExaminationBoard(deleteDTO);
		if (result >= 1) {
			return result;
		} else {
			return -1;
		}
	}
	
	@GetMapping("/getHealthBoardPage/{pageNum}")
	public HealthBoardPageDTO getHealthBoardPage(@PathVariable int pageNum) {
		System.out.println("아작스 건강 게시판 전체 데이터 페이지네이션 실행 : " + pageNum);
		
		//글목록 가져오기
		List<HealthBoardDTO> boardList = healthService.getHealthBoardListPage(pageNum);
		
		//전체 게시글 개수 조회
		int totalCount = healthService.getHealthBoardTotalCount().getTotalCount();
		int pageSize = 10;
		int totalPageCount = (int) Math.ceil((double) totalCount / pageSize);
		
		HealthBoardPageDTO dto = new HealthBoardPageDTO();
		dto.setBoardList(boardList);
		dto.setCurrentPage(pageNum);
		dto.setTotalPageCount(totalPageCount);
		dto.setTotalCount(totalCount);
		
		return dto;
	}
	
	//healthBoard.jsp
	@GetMapping("/getHealthBoardListClientPage")
	public List<HealthBoardDTO> getHealthBoardListClientPage() {
		System.out.println("사용자용 건강게시판 전체 데이터 ");
		return healthService.getHealthBoardListClientPage();
	}
	
	@PostMapping("/getHealthBoardBySearchKeyword") 
	public List<HealthBoardDTO> getHealthBoardBySearchKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println("사용자용 건강게시판 검색 데이터 ");
		return healthService.getHealthBoardBySearchKeyword(searchDTO);
	}
	
	@PostMapping("/searchHealthBoardByTitleOrContentAndKeyword")
	public HealthBoardPageDTO searchHealthBoardByTitleOrContentAndKeyword(@RequestBody SearchDTO searchDTO) {
		System.out.println("아작스 건강게시판 키워드 검색 실행 : " + searchDTO); 
		//키워드 검색 쿼리
		List<HealthBoardDTO> resultlist = healthService.searchHealthBoardByTitleOrContentAndKeyword(searchDTO);
		System.out.println("키워드 검색으로 가져온 데이터 : " + resultlist);
		
		HealthBoardPageDTO dto = new HealthBoardPageDTO();
		dto.setBoardList(resultlist);
		
		//검색으로 조회된 데이터 개수
		int totalCount = 0;
		for(HealthBoardDTO hb : resultlist) {
			totalCount = hb.getTotalCount();
		}
		int pageSize = 10;
		int totalPageCount = (int) Math.ceil((double) totalCount / pageSize);
		System.out.println("키워드 검색으로 조회된 데이터 개수 : " + totalCount);
		dto.setTotalCount(totalCount);
		dto.setTotalPageCount(totalPageCount);
		
		return dto;
		
	}
	
	@PostMapping("/searchByCalendarHealthBoard")
	public HealthBoardPageDTO searchByCalendarHealthBoard(@RequestBody SearchDTO searchDTO) {
		System.out.println("아작스 건강게시판 캘린더 검색 실행 : " + searchDTO);
		List<HealthBoardDTO> list = healthService.searchByCalendarHealthBoard(searchDTO);
		HealthBoardPageDTO dto = new HealthBoardPageDTO();
		//검색으로 조회된 데이터 개수
		int totalCount = 0;
		for(HealthBoardDTO hb : list) {
			totalCount = hb.getTotalCount();
		}
		dto.setTotalCount(totalCount);
		dto.setBoardList(list);
		return dto;
	}
	
	@PostMapping("/getHealthBoardCalendarPage/{pageNum}")
	public HealthBoardPageDTO getHealthBoardCalendarPage(@PathVariable int pageNum, @RequestBody SearchDTO searchDTO) {
		System.out.println("건강게시판 캘린더 검색 데이터에 대한 페이지네이션 실행 : " + pageNum);
		System.out.println("캘린더 검색 데이터 : " + searchDTO);
		
		//페이징처리된(10개씩) 글목록 가져오기
		List<HealthBoardDTO> boardList = healthService.getHealthBoardCalendarPage(pageNum, searchDTO);
		//검색 데이터 개수 가져오기
		List<HealthBoardDTO> list = healthService.searchByCalendarHealthBoard(searchDTO);
		
		int totalCount = 0;
		for(HealthBoardDTO hb : list) {
			totalCount = hb.getTotalCount();
		}
		
		int pageSize = 10;
		int totalPageCount = (int) Math.ceil((double) totalCount / pageSize);
		
		HealthBoardPageDTO dto = new HealthBoardPageDTO();
		dto.setBoardList(boardList);
		dto.setCurrentPage(pageNum);
		dto.setTotalPageCount(totalPageCount);
		dto.setTotalCount(totalCount);
		
		
		return dto;
		
	}
	
	
	
	@GetMapping("/searchByTermHealthBoard/{term}")
	public HealthBoardPageDTO searchByTermHealthBoard(@PathVariable String term) {
		System.out.println("건강 게시판 구간 검색 : " + term);
		List<HealthBoardDTO> list = healthService.searchByTermHealthBoard(term);
		HealthBoardPageDTO dto = new HealthBoardPageDTO();
		dto.setBoardList(list);
		int totalCount = 0;
		for(HealthBoardDTO hb : list) {
			totalCount = hb.getTotalCount();
		}
		dto.setTotalCount(totalCount);
		
		return dto;
	}
	
	@DeleteMapping("/deleteHealthBoard")
	public int deleteHealthBoard(@RequestBody DeleteDTO deleteDTO) {
		System.out.println("건강 게시판 삭제 기능 : " + deleteDTO);
		return healthService.deleteHealthBoard(deleteDTO);
	}
	
	//diseaseSearchByBody.jsp
	@GetMapping("/getBodyClassification")
	public List<BodyClassificationVO> getBodyClassification() {
		System.out.println("신체 분류 카테고리 불러오기 ajax");
		return healthService.getBodyClassificationList();
	}
	
	//diseaseSearchByDisease.jsp
	@GetMapping("/getDiseaseClassification")
	public List<DiseaseClassificationVO> getDiseaseClassification() {
		System.out.println("질환 분류 카테고리 불러오기 ajax");
		return healthService.getDiseaseClassificationList();
	}
	

}
