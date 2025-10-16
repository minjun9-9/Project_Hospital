package com.project.hospital.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.qna.dto.QnaDTO;
import com.project.hospital.vo.FileStoreVO;

@Repository
public class QnaDAO {
	private SqlSessionTemplate mybatis;

	@Autowired
	public QnaDAO(SqlSessionTemplate mybatis) {
		System.out.println("QnaDAO 생성");
		this.mybatis = mybatis;
	}
	
	
	//전체 qna 목록 가져오기
	public List<QnaDTO> getQnaList() {
		System.out.println(">> 전체 qna 목록 가져오기");
		return mybatis.selectList("qnaDAO.getQnaList");
	}

//	//qna 상세페이지
//	public QnaVO getQna(QnaVO vo) {
//		return mybatis.selectOne("qnaDAO.getQna", vo);
//	}
//	//qna 상세페이지
	public QnaDTO getQna(QnaDTO dto) {
		return mybatis.selectOne("qnaDAO.getQna", dto);
	}


	public void insertQna(QnaDTO dto) { // 250110 파일 업로드 안되고 있음!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		if (dto.getFilePath() == null) {
			mybatis.insert("qnaDAO.insertQnaNoFile", dto);
		} else {
			Map<String, Object> map = new LinkedHashMap<String, Object>();
			map.put("dto", dto);
			String[] pathArr = new String[dto.getFilePath().size()]; 
			for (int i = 0; i < dto.getFilePath().size(); i++) {
				pathArr[i] = dto.getFilePath().get(i);
				map.put("filePath" + i, pathArr[i]);
			}
			//확인용
			for (Map.Entry<String, Object> entrySet : map.entrySet()) {
				System.out.println("key : " + entrySet.getKey() + ", value : " + entrySet.getValue());
			}
			mybatis.insert("qnaDAO.insertQnaWithFile", map);
		}
	}


	public void replyQna(QnaDTO dto) {
		mybatis.update("qnaDAO.replyQna", dto);
		
	}


	public QnaDTO getReply(QnaDTO dto) {
		return mybatis.selectOne("qnaDAO.getReply", dto);
	}


	public void deleteQna(QnaDTO dto) {
		List<String> list = dto.getQnaIds();
		System.out.println("mapper 연결 직전 list 확인 : " + list);
		mybatis.delete("qnaDAO.deleteQna", list);
	}


	public void deleteSingleQna(QnaDTO dto) {
		mybatis.delete("qnaDAO.deleteSingleQna", dto);
		
	}


	public void insertFiles(FileStoreVO fileStoreVO) {
		System.out.println("insert파일 쿼리 직전 확인 : " + fileStoreVO);
		mybatis.insert("fileStoreDAO.insertFiles", fileStoreVO);
	}
	
	
	
	
	
	
}
