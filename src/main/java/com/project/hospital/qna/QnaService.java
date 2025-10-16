package com.project.hospital.qna;

import java.util.List;
import java.util.Map;

import com.project.hospital.admindrMain.dto.QnaCountDTO;
import com.project.hospital.qna.dto.QnaDTO;
import com.project.hospital.vo.FileStoreVO;

public interface QnaService {

	List<QnaDTO> getQnaList();
	//QnaVO getQna(QnaVO vo);
	QnaDTO getQna(QnaDTO dto);
	void insertQna(QnaDTO dto);
	void replyQna(QnaDTO dto);
	QnaDTO getReply(QnaDTO dto);
	void deleteQna(QnaDTO dto);
	void deleteSingleQna(QnaDTO dto);
	void insertFiles(FileStoreVO fileStoreVO);
	
	// 강우 추가
	QnaCountDTO getQnaCountAndList();
	Map<String, Integer> getQnaCnt();

}
