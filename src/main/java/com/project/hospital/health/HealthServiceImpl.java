package com.project.hospital.health;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.dao.HealthDAO;
import com.project.hospital.dao.HealthMapperDAO;
import com.project.hospital.health.dto.DeleteDTO;
import com.project.hospital.health.dto.DiseaseBoardDTO;
import com.project.hospital.health.dto.DiseaseBoardSearchDTO;
import com.project.hospital.health.dto.DiseaseBoardTotalCountDTO;
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

@Service("healthService")
public class HealthServiceImpl implements HealthService{
	
	private HealthDAO healthDAO;
	private HealthMapperDAO mapperDAO;
	
	@Autowired
	public HealthServiceImpl(HealthDAO healthDAO, HealthMapperDAO mapperDAO) {
		this.healthDAO = healthDAO;
		this.mapperDAO = mapperDAO;
	}

	@Override
	public List<BodyClassificationVO> getBodyClassificationList() {
		return healthDAO.getBodyClassificationList();
	}

	@Override
	public List<DiseaseClassificationVO> getDiseaseClassificationList() {
		return healthDAO.getDiseaseClassificationList();
	}

	@Override
	public List<DiseaseBoardVO> getDiseaseListByBodyPart(String bodyPartName) {
		return healthDAO.getDiseaseListByBodyPart(bodyPartName);
	}

	@Override
	public List<DiseaseBoardDTO> getDiseaseBoardList() {
		return healthDAO.getDiseaseBoardList();
	}

	@Override
	public DiseaseBoardDTO getDiseaseBoardDetail(DiseaseBoardVO diseaseBoardVO) {
		return healthDAO.getDiseaseBoardDetail(diseaseBoardVO);
	}

	@Override
	public List<ExaminationBoardVO> getExaminationListByBodyPart(String bodyPartName) {
		return healthDAO.getExaminationListByBodyPart(bodyPartName);
	}

	@Override
	public List<ExaminationBoardDTO> getExaminationBoardList() {
		return healthDAO.getExaminationBoardList();
	}

	@Override
	public ExaminationBoardDTO getExaminationBoardDetail(ExaminationBoardVO examinationBoardVO) {
		return healthDAO.getExaminationBoardDetail(examinationBoardVO);
	}

	@Override
	public List<HealthBoardDTO> getHealthBoardList() {
		return healthDAO.getHealthBoardList();
	}

	@Override
	public HealthBoardDTO getHealthBoardDetail(HealthBoardVO hbVO) {
		return healthDAO.getHealthBoardDetail(hbVO);
	}

	@Override
	public List<DiseaseBoardDTO> getDiseaseBoardBySearchKeyword(SearchDTO searchDTO) {
		return healthDAO.getDiseaseBoardBySearchKeyword(searchDTO);
	}

	@Override
	public List<DiseaseBoardDTO> getDiseaseBoardByDiseasePartAndSearchKeyword(SearchDTO searchDTO) {
		return healthDAO.getDiseaseBoardByDiseasePartAndSearchKeyword(searchDTO);
	}

	@Override
	public List<ExaminationBoardDTO> getExaminListByBodyPartAndSearchKeyword(SearchDTO searchDTO) {
		return healthDAO.getExaminListByBodyPartAndSearchKeyword(searchDTO);
	}

	@Override
	public List<HealthBoardVO> getHealthBoardByKeyword(SearchDTO searchDTO) {
		return healthDAO.getHealthBoardByKeyword(searchDTO);
	}

	@Override
	public DiseaseClassificationVO getDiseaseClassificationById(DiseaseClassificationVO diseaseClassificationVO) {
		return healthDAO.getDiseaseClassificationById(diseaseClassificationVO);
	}

	@Override
	public int updateDiseasePartName(DiseaseClassificationVO diseaseClassificationVO) {
		return healthDAO.updateDiseasePartName(diseaseClassificationVO);
	}

	@Override
	public int insertDiseaseClassification(String inputText) {
		return healthDAO.insertDiseaseClassification(inputText);
	}

	@Override
	public int deleteDiseaseClassification(DeleteDTO deleteDTO) {
		return healthDAO.deleteDiseaseClassification(deleteDTO);
	}

	@Override
	public int insertBodyClassification(String inputText) {
		return healthDAO.insertBodyClassification(inputText);
	}

	@Override
	public int deleteBodyClassification(DeleteDTO deleteDTO) {
		return healthDAO.deleteBodyClassification(deleteDTO);
	}

	@Override
	public BodyClassificationVO getBodyClassificationById(BodyClassificationVO bodyClassificationVO) {
		return healthDAO.getBodyClassificationById(bodyClassificationVO);
	}

	@Override
	public int updateBodyPartName(BodyClassificationVO bodyClassificationVO) {
		return healthDAO.updateBodyPartName(bodyClassificationVO);
	}

	@Override
	public int insertDiseaseBoard(DiseaseBoardDTO diseaseBoardDTO) {
		return healthDAO.insertDiseaseBoard(diseaseBoardDTO);
	}

	@Override
	public int deleteDiseaseBoard(DeleteDTO deleteDTO) {
		return healthDAO.deleteDiseaseBoard(deleteDTO);
	}

	@Override
	public List<DiseaseBoardDTO> searchByCalendarDiseaseBoard(DiseaseBoardSearchDTO diseaseBoardSearchDTO) {
		return healthDAO.searchByCalendarDiseaseBoard(diseaseBoardSearchDTO);
	}

	@Override
	public List<DiseaseBoardDTO> searchByTermDiseaseBoard(String term) {
		return healthDAO.searchByTermDiseaseBoard(term);
	}

	@Override
	public List<DiseaseBoardDTO> searchDiseaseBoardByTitleOrContentAndKeyword(SearchDTO searchDTO) {
		return healthDAO.searchDiseaseBoardByTitleOrContentAndKeyword(searchDTO);
	}

	@Override
	public List<DiseaseBoardDTO> searchDiseaseBoardByClassification(SearchDTO searchDTO) {
		return healthDAO.searchDiseaseBoardByClassification(searchDTO);
	}

	@Override
	public int updateDiseaseBoardExceptFile(DiseaseBoardDTO diseaseBoardDTO) {
		return healthDAO.updateDiseaseBoardExceptFile(diseaseBoardDTO);
	}

	@Override
	public int updateDiseaseBoardWithFile(DiseaseBoardDTO diseaseBoardDTO) {
		return healthDAO.updateDiseaseBoardWithFile(diseaseBoardDTO);
	}

	@Override
	public DiseaseBoardTotalCountDTO getDiseaseBoardTotalCount() {
		return healthDAO.getDiseaseBoardTotalCount();
	}

	//질환게시판 페이지네이션
	@Override
	public List<DiseaseBoardDTO> getDiseaseBoardPage(int pageNum) {
		int pageSize = 10;
		int startRow = (pageNum - 1) * pageSize + 1;
		int endRow = pageNum * pageSize;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return healthDAO.getDiseaseBoardPage(map);
	}

	@Override
	public int insertExaminationBoard(ExaminationBoardDTO examinationBoardDTO) {
		return healthDAO.insertExaminationBoard(examinationBoardDTO);
	}

	@Override
	public ExaminationBoardPageDTO getExaminationBoardTotalCount() {
		return healthDAO.getExaminationBoardTotalCount();
	}

	@Override
	public List<ExaminationBoardDTO> getExaminationBoardPage(int pageNum) {
		int pageSize = 10;
		int startRow = (pageNum - 1) * pageSize + 1;
		int endRow = pageNum * pageSize;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return healthDAO.getExaminationBoardPage(map);
	}

	//10개 이상이면 페이지네이션 처리하는 거 하려고 했는데 그냥 포기
	/*
	@Override
	public Map<Object, Object> searchExaminationBoardByBodyClassification(SearchDTO searchDTO) {
		Map<Object, Object> returnMap = new HashMap<Object, Object>();
		//만약 검색 결과 > 10 이면 페이지네이션 하기.... 
		List<ExaminationBoardDTO> list = healthDAO.searchExaminationBoardByBodyClassification(searchDTO);
		int totalCount = 0;
		for(ExaminationBoardDTO dt : list) {
			totalCount = Integer.parseInt(dt.getTotalCount());
		}
		
		System.out.println("게시글 개수 : " + totalCount);
		if (totalCount > 10) {
			System.out.println("10개 초과 페이지네이션 해야됌");
			//총 게시글 개수 totalCount 넘기기
			
			//페이지당 표시할 게시글 수
			int pageSize = 10;
			//총 페이지 수 (총 게시글 수 / 페이지당 개수) jsp로 넘겨야되는거 아님??
			int totalPageCount = (int) Math.ceil((double) totalCount / pageSize);
			
			
			//페이지네이션 필요, 다시 쿼리 날리기
			Map<String, Integer> map = new HashMap<>();
			int pageNum = 1; //시작은 1페이지니까
			int startRow = (pageNum - 1) * pageSize + 1;
			int endRow = startRow + 9;
			map.put("startRow", startRow);
			map.put("endRow", endRow);
			
			//페이지네이션 로우넘 있는 검색 쿼리 다시 날리기
			List<ExaminationBoardDTO> pagedList = healthDAO.searchExaminationBoardByBodyClassificationPage(map);
			
			ExaminationBoardPageDTO dto = new ExaminationBoardPageDTO();
			dto.setBoardList(pagedList);
			dto.setCurrentPage(pageNum);
			dto.setTotalPageCount(totalPageCount);
			dto.setTotalCount(totalCount);
			returnMap.put("examinationBoardPageDTO", dto); //페이지네이션 포함 DTO
			
		} else { //페이지네이션 불필요하면 컨트롤러에 그대로 보내기
			System.out.println("데이터 10개 이하 페이지네이션 불필요");
			returnMap.put("examinationBoardDTO", list); //페이지네이션 미포합 DTO
		}
		return returnMap;
	}
	*/
	@Override
	public List<ExaminationBoardDTO> searchExaminationBoardByBodyClassification(SearchDTO searchDTO) {
		Map<Object, Object> returnMap = new HashMap<Object, Object>();
		return healthDAO.searchExaminationBoardByBodyClassification(searchDTO);
		
	}

	@Override
	public List<ExaminationBoardDTO> searchExaminationBoardByTitleOrContentAndKeyword(SearchDTO searchDTO) {
		return healthDAO.searchExaminationBoardByTitleOrContentAndKeyword(searchDTO);
	}

	@Override
	public List<ExaminationBoardDTO> searchByCalendarExaminationBoard(SearchDTO searchDTO) {
		return healthDAO.searchByCalendarExaminationBoard(searchDTO);
	}

	@Override
	public List<ExaminationBoardDTO> searchByTermExaminationBoard(String term) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("term", term);
		return healthDAO.searchByTermExaminationBoard(map);
	}

	@Override
	public int deleteExaminationBoard(DeleteDTO deleteDTO) {
		return healthDAO.deleteExaminationBoard(deleteDTO);
	}

	@Override
	public int updateExaminationBoardExceptFile(ExaminationBoardDTO examinationBoardDTO) {
		return healthDAO.updateExaminationBoardExceptFile(examinationBoardDTO);
	}

	@Override
	public int updateExaminationBoardWithFile(ExaminationBoardDTO examinationBoardDTO) {
		return healthDAO.updateExaminationBoardWithFile(examinationBoardDTO);
	}

	@Override
	public int updateExaminationBoardDeleteFile(ExaminationBoardDTO examinationBoardDTO) {
		return healthDAO.updateExaminationBoardDeleteFile(examinationBoardDTO);
	}

	@Override
	public HealthBoardPageDTO getHealthBoardTotalCount() {
		return healthDAO.getHealthBoardTotalCount();
	}

	@Override
	public List<HealthBoardDTO> searchHealthBoardByTitleOrContentAndKeyword(SearchDTO searchDTO) {
		return healthDAO.searchHealthBoardByTitleOrContentAndKeyword(searchDTO);
	}

	@Override
	public List<HealthBoardDTO> searchByCalendarHealthBoard(SearchDTO searchDTO) {
		return healthDAO.searchByCalendarHealthBoard(searchDTO);
	}

	@Override
	public List<HealthBoardDTO> getHealthBoardListPage(int pageNum) {
		int pageSize = 10;
		int startRow = (pageNum - 1) * pageSize + 1;
		int endRow = pageNum * pageSize;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return healthDAO.getHealthBoardListPage(map);
	}

	@Override
	public List<HealthBoardDTO> getHealthBoardCalendarPage(int pageNum, SearchDTO searchDTO) {
		int pageSize = 10;
		int startRow = (pageNum - 1) * pageSize + 1;
		int endRow = pageNum * pageSize;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("startDate", searchDTO.getStartDate());
		map.put("endDate", searchDTO.getEndDate());
		
		return healthDAO.getHealthBoardCalendarPage(map);
	}

	@Override
	public List<HealthBoardDTO> searchByTermHealthBoard(String term) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("term", term);
		return healthDAO.searchByTermHealthBoard(map);
	}

	@Override
	public int deleteHealthBoard(DeleteDTO deleteDTO) {
		return healthDAO.deleteHealthBoard(deleteDTO);
	}

	@Override
	public int insertHealthBoard(HealthBoardDTO healthBoardDTO) {
		return healthDAO.insertHealthBoard(healthBoardDTO);
	}

	@Override
	public int updateHealthBoardExceptFile(HealthBoardDTO healthBoardDTO) {
		return healthDAO.updateHealthBoardExceptFile(healthBoardDTO);
	}

	@Override
	public int updateHealthBoardWithFile(HealthBoardDTO healthBoardDTO) { 
		return healthDAO.updateHealthBoardWithFile(healthBoardDTO);
	}

	@Override
	public List<DiseaseBoardDTO> getDiseaseBoardListClientPage() {
		return healthDAO.getDiseaseBoardListClientPage();
	}

	@Override
	public List<DiseaseBoardDTO> getDiseaseBoardOnlySearchByKeyword(SearchDTO searchDTO) {
		return healthDAO.getDiseaseBoardOnlySearchByKeyword(searchDTO);
	}

	@Override
	public List<ExaminationBoardDTO> getExaminationBoardListClientPage() {
		return healthDAO.getExaminationBoardListClientPage();
	}

	@Override
	public List<ExaminationBoardDTO> getExaminationBoardOnlySearchByKeyword(SearchDTO searchDTO) {
		return healthDAO.getExaminationBoardOnlySearchByKeyword(searchDTO);
	}

	@Override
	public List<HealthBoardDTO> getHealthBoardListClientPage() {
		return healthDAO.getHealthBoardListClientPage();
	}

	@Override
	public List<HealthBoardDTO> getHealthBoardBySearchKeyword(SearchDTO searchDTO) {
		return healthDAO.getHealthBoardBySearchKeyword(searchDTO);
	}
	
	
	/*
	 * 강우 추가 -------------------------------------------------------
	 */
	
	@Override
	public Map<String, Integer> getHealthCnt() {
		return mapperDAO.getHealthCnt(createCntMapper());
	}

	


	// 메인페이지 새글/이번달 cnt DB 조건에 넣을 매퍼 생성
	private Map<String, String> createCntMapper() {
		
		String start = " 00:00:00";
		String end = " 23:59:59";
				
		LocalDate today = LocalDate.now();
		
		// 해당월에 맞는 끝일 넣기
		LocalDate firstDay = LocalDate.of(today.getYear(), today.getMonthValue(), 1);
        LocalDate LastDay = LocalDate.of(today.getYear(), today.getMonthValue() + 1, 1).minusDays(1);
		
		Map<String, String> optionMap = new HashMap<String, String>();
		optionMap.put("todayStart", today.toString() + start);
		optionMap.put("todayEnd", today.toString() + end);
		optionMap.put("monthStart", firstDay.toString() + start);
		optionMap.put("monthEnd", LastDay.toString() + end);
		
		return optionMap;
	}
	
	/**
	 * -----------------------------------------------------------------
	 */

	

}
