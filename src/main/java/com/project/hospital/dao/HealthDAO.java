package com.project.hospital.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

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

@Repository
public class HealthDAO {
	private SqlSessionTemplate mybatis;
	
	@Autowired
	public HealthDAO(SqlSessionTemplate mybatis) {
		this.mybatis = mybatis;
	}
	
	public List<BodyClassificationVO> getBodyClassificationList() {
		return mybatis.selectList("healthDAO.getBodyClassificationList");
	}
	
	public List<DiseaseClassificationVO> getDiseaseClassificationList() {
		return mybatis.selectList("healthDAO.getDiseaseClassificationList");
	}

	public List<DiseaseBoardVO> getDiseaseListByBodyPart(String bodyPartName) {
		return mybatis.selectList("healthDAO.getDiseaseListByBodyPartName", bodyPartName);
	}

	public List<DiseaseBoardDTO> getDiseaseBoardList() {
		return mybatis.selectList("healthDAO.getDiseaseBoardList");
	}

	public DiseaseBoardDTO getDiseaseBoardDetail(DiseaseBoardVO diseaseBoardVO) {
		mybatis.update("healthDAO.diseaseBoardIncreaseCnt", diseaseBoardVO);
		return mybatis.selectOne("healthDAO.getDiseaseBoardDetail", diseaseBoardVO);
	}

	public List<ExaminationBoardVO> getExaminationListByBodyPart(String bodyPartName) {
		return mybatis.selectList("healthDAO.getExaminationListByBodyPart", bodyPartName);
	}

	public List<ExaminationBoardDTO> getExaminationBoardList() {
		return mybatis.selectList("healthDAO.getExaminationBoardList");
	}

	public ExaminationBoardDTO getExaminationBoardDetail(ExaminationBoardVO examinationBoardVO) {
		mybatis.update("healthDAO.examinationBoardIncreaseCnt", examinationBoardVO);
		return mybatis.selectOne("healthDAO.getExaminationBoardDetail", examinationBoardVO);
	}

	public List<HealthBoardDTO> getHealthBoardList() {
		return mybatis.selectList("healthDAO.getHealthBoardList");
	}

	public HealthBoardDTO getHealthBoardDetail(HealthBoardVO hbVO) {
		mybatis.update("healthDAO.healthBoardIncreaseCnt", hbVO);
		return mybatis.selectOne("healthDAO.getHealthBoardDetail", hbVO);
	}

	public List<DiseaseBoardDTO> getDiseaseBoardBySearchKeyword(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.getDiseaseBoardBySearchKeyword", searchDTO);
	}

	public List<DiseaseBoardDTO> getDiseaseBoardByDiseasePartAndSearchKeyword(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.getDiseaseBoardByDiseasePartAndSearchKeyword", searchDTO);
	}

	public List<ExaminationBoardDTO> getExaminListByBodyPartAndSearchKeyword(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.getExaminListByBodyPartAndSearchKeyword", searchDTO);
	}

	public List<HealthBoardVO> getHealthBoardByKeyword(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.getHealthBoardByKeyword", searchDTO);
	}

	public DiseaseClassificationVO getDiseaseClassificationById(DiseaseClassificationVO diseaseClassificationVO) {
		return mybatis.selectOne("healthDAO.getDiseaseClassificationById", diseaseClassificationVO);
	}

	public int updateDiseasePartName(DiseaseClassificationVO diseaseClassificationVO) {
		return mybatis.update("healthDAO.updateDiseasePartName", diseaseClassificationVO);
	}

	public int insertDiseaseClassification(String inputText) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("inputText", inputText);
		return mybatis.insert("healthDAO.insertDiseaseClassification", map);
	}

	public int deleteDiseaseClassification(DeleteDTO deleteDTO) {
		return mybatis.delete("healthDAO.deleteDiseaseClassification", deleteDTO);
	}

	public int insertBodyClassification(String inputText) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("inputText", inputText);
		return mybatis.insert("healthDAO.insertBodyClassification", map);
	}

	public int deleteBodyClassification(DeleteDTO deleteDTO) {
		return mybatis.delete("healthDAO.deleteBodyClassification", deleteDTO);
	}

	public BodyClassificationVO getBodyClassificationById(BodyClassificationVO bodyClassificationVO) {
		return mybatis.selectOne("healthDAO.getBodyClassificationById", bodyClassificationVO);
	}

	public int updateBodyPartName(BodyClassificationVO bodyClassificationVO) {
		return mybatis.update("healthDAO.updateBodyPartName", bodyClassificationVO);
	}

	public int insertDiseaseBoard(DiseaseBoardDTO diseaseBoardDTO) {
		if (diseaseBoardDTO.getFilestoreId() != null) {
			mybatis.insert("fileStoreDAO.insertFiles", diseaseBoardDTO);
		}
		return mybatis.insert("healthDAO.insertDiseaseBoard", diseaseBoardDTO);
	}

	public int deleteDiseaseBoard(DeleteDTO deleteDTO) {
		return mybatis.delete("healthDAO.deleteDiseaseBoard", deleteDTO);
	}

	public List<DiseaseBoardDTO> searchByCalendarDiseaseBoard(DiseaseBoardSearchDTO diseaseBoardSearchDTO) {
		return mybatis.selectList("healthDAO.searchByCalendarDiseaseBoard", diseaseBoardSearchDTO);
	}

	public List<DiseaseBoardDTO> searchByTermDiseaseBoard(String term) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("term", term);
		return mybatis.selectList("healthDAO.searchByTermDiseaseBoard", map);
	}

	public List<DiseaseBoardDTO> searchDiseaseBoardByTitleOrContentAndKeyword(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.searchDiseaseBoardByTitleOrContentAndKeyword", searchDTO);
	}

	public List<DiseaseBoardDTO> searchDiseaseBoardByClassification(SearchDTO searchDTO) {
		return  mybatis.selectList("healthDAO.searchDiseaseBoardByClassification", searchDTO);
	}

	public int updateDiseaseBoardExceptFile(DiseaseBoardDTO diseaseBoardDTO) {
		return mybatis.update("healthDAO.updateDiseaseBoardExceptFile", diseaseBoardDTO);
	}

	public int updateDiseaseBoardWithFile(DiseaseBoardDTO diseaseBoardDTO) {
		mybatis.insert("fileStoreDAO.insertFiles", diseaseBoardDTO);
		return mybatis.update("healthDAO.updateDiseaseBoardWithFile", diseaseBoardDTO);
	}

	public DiseaseBoardTotalCountDTO getDiseaseBoardTotalCount() {
		return mybatis.selectOne("healthDAO.getDiseaseBoardTotalCount");
	}

	public List<DiseaseBoardDTO> getDiseaseBoardPage(Map<String, Object> map) {
		return mybatis.selectList("healthDAO.getDiseaseBoardPage", map);
	}

	public int insertExaminationBoard(ExaminationBoardDTO examinationBoardDTO) {
		if (examinationBoardDTO.getFilestoreId() != null) {
			mybatis.insert("fileStoreDAO.insertFiles", examinationBoardDTO);
		}
		return mybatis.insert("healthDAO.insertExaminationBoard", examinationBoardDTO);
	}

	public ExaminationBoardPageDTO getExaminationBoardTotalCount() {
		return mybatis.selectOne("healthDAO.getExaminationBoardTotalCount");
	}

	public List<ExaminationBoardDTO> getExaminationBoardPage(Map<String, Object> map) {
		return mybatis.selectList("healthDAO.getExaminationBoardPage", map);
	}

	public List<ExaminationBoardDTO> searchExaminationBoardByBodyClassification(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.searchExaminationBoardByBodyClassification", searchDTO);
	}

	public List<ExaminationBoardDTO> searchExaminationBoardByBodyClassificationPage(Map<String, Integer> map) {
		return mybatis.selectList("healthDAO.searchExaminationBoardByBodyClassificationPage", map);
	}

	public List<ExaminationBoardDTO> searchExaminationBoardByTitleOrContentAndKeyword(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.searchExaminationBoardByTitleOrContentAndKeyword", searchDTO);
	}

	public List<ExaminationBoardDTO> searchByCalendarExaminationBoard(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.searchByCalendarExaminationBoard", searchDTO);
	}

	public List<ExaminationBoardDTO> searchByTermExaminationBoard(Map<String, String> map) {
		return mybatis.selectList("healthDAO.searchByTermExaminationBoard", map);
	}

	public int deleteExaminationBoard(DeleteDTO deleteDTO) {
		return mybatis.delete("healthDAO.deleteExaminationBoard", deleteDTO);
	}

	public int updateExaminationBoardExceptFile(ExaminationBoardDTO examinationBoardDTO) {
		return mybatis.update("healthDAO.updateExaminationBoardExceptFile", examinationBoardDTO);
	}

	public int updateExaminationBoardWithFile(ExaminationBoardDTO examinationBoardDTO) {
		mybatis.insert("fileStoreDAO.insertFiles", examinationBoardDTO);
		return mybatis.update("healthDAO.updateExaminationBoardWithFile", examinationBoardDTO);
	}

	public int updateExaminationBoardDeleteFile(ExaminationBoardDTO examinationBoardDTO) {
		return mybatis.update("healthDAO.updateExaminationBoardDeleteFile", examinationBoardDTO);
	}

	public HealthBoardPageDTO getHealthBoardTotalCount() {
		return mybatis.selectOne("healthDAO.getHealthBoardTotalCount");
	}

	public List<HealthBoardDTO> searchHealthBoardByTitleOrContentAndKeyword(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.searchHealthBoardByTitleOrContentAndKeyword", searchDTO);
	}

	public List<HealthBoardDTO> searchByCalendarHealthBoard(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.searchByCalendarHealthBoard", searchDTO);
	}

	public List<HealthBoardDTO> getHealthBoardListPage(Map<String, Object> map) {
		return mybatis.selectList("healthDAO.getHealthBoardListPage", map);
	}

	public List<HealthBoardDTO> getHealthBoardCalendarPage(Map<String, Object> map) {
		return mybatis.selectList("healthDAO.getHealthBoardCalendarPage", map);
	}

	public List<HealthBoardDTO> searchByTermHealthBoard(Map<String, String> map) {
		return mybatis.selectList("healthDAO.searchByTermHealthBoard", map);
	}

	public int deleteHealthBoard(DeleteDTO deleteDTO) {
		return mybatis.delete("healthDAO.deleteHealthBoard", deleteDTO);
	}

	public int insertHealthBoard(HealthBoardDTO healthBoardDTO) {
		if (healthBoardDTO.getFilestoreId() != null) {
			mybatis.insert("fileStoreDAO.insertFiles", healthBoardDTO);
		}
		return mybatis.insert("healthDAO.insertHealthBoard", healthBoardDTO);
	}

	public int updateHealthBoardExceptFile(HealthBoardDTO healthBoardDTO) {
		return mybatis.update("healthDAO.updateHealthBoardExceptFile", healthBoardDTO);
	}

	public int updateHealthBoardWithFile(HealthBoardDTO healthBoardDTO) {
		mybatis.insert("fileStoreDAO.insertFiles", healthBoardDTO);
		return mybatis.update("healthDAO.updateHealthBoardWithFile", healthBoardDTO);
	}

	public List<DiseaseBoardDTO> getDiseaseBoardListClientPage() {
		return mybatis.selectList("healthDAO.getDiseaseBoardListClientPage");
	}

	public List<DiseaseBoardDTO> getDiseaseBoardOnlySearchByKeyword(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.getDiseaseBoardOnlySearchByKeyword", searchDTO);
	}

	public List<ExaminationBoardDTO> getExaminationBoardListClientPage() {
		return mybatis.selectList("healthDAO.getExaminationBoardListClientPage");
	}

	public List<ExaminationBoardDTO> getExaminationBoardOnlySearchByKeyword(SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.getExaminationBoardOnlySearchByKeyword", searchDTO);
	}

	public List<HealthBoardDTO> getHealthBoardListClientPage() {
		return mybatis.selectList("healthDAO.getHealthBoardListClientPage");
	}

	public List<HealthBoardDTO> getHealthBoardBySearchKeyword(@RequestBody SearchDTO searchDTO) {
		return mybatis.selectList("healthDAO.getHealthBoardBySearchKeyword", searchDTO);
	}


	
	

}
