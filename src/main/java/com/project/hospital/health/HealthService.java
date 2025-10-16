package com.project.hospital.health;

import java.util.List;
import java.util.Map;

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

public interface HealthService {
	
	List<BodyClassificationVO> getBodyClassificationList();
	List<DiseaseClassificationVO> getDiseaseClassificationList();
	List<DiseaseBoardVO> getDiseaseListByBodyPart(String bodyPartName);
	List<DiseaseBoardDTO> getDiseaseBoardList();
	DiseaseBoardDTO getDiseaseBoardDetail(DiseaseBoardVO diseaseBoardVO);
	List<ExaminationBoardVO> getExaminationListByBodyPart(String bodyPartName);
	List<ExaminationBoardDTO> getExaminationBoardList();
	ExaminationBoardDTO getExaminationBoardDetail(ExaminationBoardVO examinationBoardVO);
	List<HealthBoardDTO> getHealthBoardList();
	HealthBoardDTO getHealthBoardDetail(HealthBoardVO hbVO);
	List<DiseaseBoardDTO> getDiseaseBoardBySearchKeyword(SearchDTO searchDTO);
	List<DiseaseBoardDTO> getDiseaseBoardOnlySearchByKeyword(SearchDTO searchDTO);
	List<DiseaseBoardDTO> getDiseaseBoardByDiseasePartAndSearchKeyword(SearchDTO searchDTO);
	List<ExaminationBoardDTO> getExaminListByBodyPartAndSearchKeyword(SearchDTO searchDTO);
	List<HealthBoardVO> getHealthBoardByKeyword(SearchDTO searchDTO);
	DiseaseClassificationVO getDiseaseClassificationById(DiseaseClassificationVO diseaseClassificationVO);
	int updateDiseasePartName(DiseaseClassificationVO diseaseClassificationVO);
	int insertDiseaseClassification(String inputText);
	int deleteDiseaseClassification(DeleteDTO deleteDTO);
	int insertBodyClassification(String inputText);
	int deleteBodyClassification(DeleteDTO deleteDTO);
	BodyClassificationVO getBodyClassificationById(BodyClassificationVO bodyClassificationVO);
	int updateBodyPartName(BodyClassificationVO bodyClassificationVO);
	int insertDiseaseBoard(DiseaseBoardDTO diseaseBoardDTO);
	int deleteDiseaseBoard(DeleteDTO deleteDTO);
	List<DiseaseBoardDTO> searchByCalendarDiseaseBoard(DiseaseBoardSearchDTO diseaseBoardSearchDTO);
	List<DiseaseBoardDTO> searchByTermDiseaseBoard(String term);
	List<DiseaseBoardDTO> searchDiseaseBoardByTitleOrContentAndKeyword(SearchDTO searchDTO);
	List<DiseaseBoardDTO> searchDiseaseBoardByClassification(SearchDTO searchDTO);
	int updateDiseaseBoardExceptFile(DiseaseBoardDTO diseaseBoardDTO);
	int updateDiseaseBoardWithFile(DiseaseBoardDTO diseaseBoardDTO);
	DiseaseBoardTotalCountDTO getDiseaseBoardTotalCount();
	List<DiseaseBoardDTO> getDiseaseBoardPage(int pageNum);
	int insertExaminationBoard(ExaminationBoardDTO examinationBoardDTO);
	ExaminationBoardPageDTO getExaminationBoardTotalCount();
	List<ExaminationBoardDTO> getExaminationBoardPage(int pageNum);
	List<ExaminationBoardDTO> searchExaminationBoardByBodyClassification(SearchDTO searchDTO);
	List<ExaminationBoardDTO> searchExaminationBoardByTitleOrContentAndKeyword(SearchDTO searchDTO);
	List<ExaminationBoardDTO> searchByCalendarExaminationBoard(SearchDTO searchDTO);
	List<ExaminationBoardDTO> searchByTermExaminationBoard(String term);
	int deleteExaminationBoard(DeleteDTO deleteDTO);
	int updateExaminationBoardExceptFile(ExaminationBoardDTO examinationBoardDTO);
	int updateExaminationBoardWithFile(ExaminationBoardDTO examinationBoardDTO);
	int updateExaminationBoardDeleteFile(ExaminationBoardDTO examinationBoardDTO);
	HealthBoardPageDTO getHealthBoardTotalCount();
	List<HealthBoardDTO> searchHealthBoardByTitleOrContentAndKeyword(SearchDTO searchDTO);
	List<HealthBoardDTO> searchByCalendarHealthBoard(SearchDTO searchDTO);
	List<HealthBoardDTO> getHealthBoardListPage(int pageNum);
	List<HealthBoardDTO> getHealthBoardCalendarPage(int pageNum, SearchDTO searchDTO);
	List<HealthBoardDTO> searchByTermHealthBoard(String term);
	int deleteHealthBoard(DeleteDTO deleteDTO);
	int insertHealthBoard(HealthBoardDTO healthBoardDTO);
	int updateHealthBoardExceptFile(HealthBoardDTO healthBoardDTO);
	int updateHealthBoardWithFile(HealthBoardDTO healthBoardDTO);
	List<DiseaseBoardDTO> getDiseaseBoardListClientPage();
	List<ExaminationBoardDTO> getExaminationBoardListClientPage();
	List<ExaminationBoardDTO> getExaminationBoardOnlySearchByKeyword(SearchDTO searchDTO);
	List<HealthBoardDTO> getHealthBoardListClientPage();
	List<HealthBoardDTO> getHealthBoardBySearchKeyword(SearchDTO searchDTO);
	Map<String, Integer> getHealthCnt();

}
