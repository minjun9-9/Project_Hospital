package com.project.hospital.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.common.Paging;
import com.project.hospital.dao.RecordDAO;
import com.project.hospital.mypage.dto.RequestRecordDTO;
import com.project.hospital.mypage.dto.ResponseRecordDTO;

@Service
@Transactional(readOnly = true)
public class RecordServiceImpl implements RecordService {
	
	private final RecordDAO dao;
	
	@Autowired
	public RecordServiceImpl(RecordDAO dao) {
		super();
		this.dao = dao;
	}

	/**
	 * 페이징 셋팅
	 */
	@Override
	public Paging pageSet(RequestRecordDTO requestDTO) {
		
		//1. 총 의료진 갯수 구하기, 총 페이지 갯수 세팅
		Paging p = new Paging();
		
		int recordCount = dao.getRecordCount(setMapperForRecordCnt(requestDTO));
		p.setTotalRecord(recordCount); 
		p.setTotalPage();
		p.setTotalBlock(); //여기 에러나면 수정해야함(set메소드) 
		
		//2. 현재 페이지 번호 받아와 새팅
		if (requestDTO.getcPage() != null) {
			p.setNowPage(Integer.parseInt(requestDTO.getcPage()));
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
	 * 진료기록 조회
	 */
	@Override
	public List<ResponseRecordDTO> findRecordListForPage(int begin, int end, RequestRecordDTO requestDTO) {
		
		return dao.findRecordListForPage(setMapperForPage(begin, end, requestDTO));
	}
	
	/**
	 * 편의 메서드
	 */
	// 총 페이지 갯수 설정 시 사용하는 매퍼
	public Map<String, String> setMapperForRecordCnt(RequestRecordDTO requestDTO){
		
		Map<String, String> optionMap = new HashMap<String, String>();
		optionMap.put("userNum", requestDTO.getUserNum());
		
		String startDate = requestDTO.getStartDate() + " 00:00:00";
		String endDate = requestDTO.getEndDate() + " 23:59:59";
		optionMap.put("startDate", startDate);
		optionMap.put("endDate", endDate);
		
		return optionMap;
	}
	
	// 페이징처리해서 가져올 매퍼
	public Map<String, Object> setMapperForPage(int begin, int end, RequestRecordDTO requestDTO){
		
		Map<String, Object> optionMap = new HashMap<String, Object>();
		optionMap.put("begin", begin);
		optionMap.put("end", end);
		optionMap.put("userNum", requestDTO.getUserNum());
		optionMap.put("startDate", requestDTO.getStartDate());
		optionMap.put("endDate", requestDTO.getEndDate());
		return optionMap;
	}
}
