package com.project.hospital.qna;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Period;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.hospital.admindrMain.dto.AdminDrMainQnaDTO;
import com.project.hospital.admindrMain.dto.QnaCountDTO;
import com.project.hospital.dao.QnaDAO;
import com.project.hospital.dao.QnaMapperDAO;
import com.project.hospital.qna.dto.QnaDTO;
import com.project.hospital.vo.FileStoreVO;

//@Service : @Component 상속 확장한 annotation
//	: 비즈니스(업무 처리) 로직  서비스 영역에 사용
@Service("qnaService")
@Transactional(readOnly = true)
public class QnaServiceImpl implements QnaService{
	
	private final QnaDAO qnaDAO;
	private final QnaMapperDAO dao;
	
	@Autowired
	public QnaServiceImpl(QnaDAO qnaDAO, QnaMapperDAO dao) {
		super();
		this.qnaDAO = qnaDAO;
		this.dao = dao;
	}

	@Override
	public List<QnaDTO> getQnaList() {
		return qnaDAO.getQnaList();
	}

//	@Override
//	public QnaVO getQna(QnaVO vo) {
//		return qnaDAO.getQna(vo);
//	}
	
	@Override
	public QnaDTO getQna(QnaDTO dto) {
		return qnaDAO.getQna(dto);
	}

	@Override
	public void insertQna(QnaDTO dto) {
		qnaDAO.insertQna(dto);
	}

	@Override
	public void replyQna(QnaDTO dto) {
		qnaDAO.replyQna(dto);
		
	}

	@Override
	public QnaDTO getReply(QnaDTO dto) {
		return qnaDAO.getReply(dto);
	}

	@Override
	public void deleteQna(QnaDTO dto) {
		qnaDAO.deleteQna(dto);
	}

	@Override
	public void deleteSingleQna(QnaDTO dto) {
		qnaDAO.deleteSingleQna(dto);
	}

	@Override
	public void insertFiles(FileStoreVO fileStoreVO) {
		qnaDAO.insertFiles(fileStoreVO);
		
	}
	
	// 강우 추가

	/**
	 * 의료관리자 메인 페이지 접수 총 카운트, 해결 카운트 , 페이징 리스트 데이터 추출
	 */
	@Override
	public QnaCountDTO getQnaCountAndList() {
		
		// 이번달 전체 글수 / 접수완료 글수 매퍼 생성
		Map<String, String> optionMap = createDateMapper();
		
		// 이번달 전체 글수 / 접수완료 글수
		QnaCountDTO dto = dao.getTotalAndCompleteCount(optionMap);
		
		// 이번달 상위 3순위 글 추출
		List<AdminDrMainQnaDTO> list = dao.getQnaDescThirdList(optionMap);
		
		// 답변 스테이터스 css클래스명 삽입과 시간 계산
		for (AdminDrMainQnaDTO qnaDto : list) {
			
			// 답변 검증에 따른 값 셋팅
			qnaDto.setReplyClass(validateReply(qnaDto));
			
			// 메인 페이지 시간표시 계산 후 삽입 (현 시간 몇분 전인지)
			qnaDto.setDateTime(caculatorDateTime(qnaDto.getCreatedAt()));
		}
		
		// 셋팅된 리스트 dto 셋
		dto.setQnaDescThird(list);
		
		// 퍼센트 계산
		calculatorPercent(dto);
		
		return dto;
	}

	

	/**
	 * 게시글 바로가기 새글/이번달 cnt 추출 
	 */
	@Override
	public Map<String, Integer> getQnaCnt() {
		
		Map<String, String> optionMap = createCntMapper();
		
		
		return dao.getQnaCnt(optionMap);
	}

	/**
	 * 편의 메서드
	 */
	
	// 메인페이지 고객의 소리 퍼센트 계산
	private void calculatorPercent(QnaCountDTO dto) {
		
		int totalCnt = dto.getTotalcnt();
		int completeCnt = dto.getCompletecnt();
		
		double result = (double) completeCnt / (double) totalCnt;
		dto.setQnaPercent(String.format("%.2f", result));
		
	}
	
	// 답변 검증에 따른 값 반환
	private String validateReply(AdminDrMainQnaDTO qnaDto) {
		
		if(qnaDto.getReply().equals("답변대기")) {
			return "no_check";
		} else {
			qnaDto.setReply("처리완료");
			return "check";
		}
	}

	// 메인 페이지 시간표시 계산 후 삽입 (현 시간 몇분 전인지)
	private String caculatorDateTime(String createdAt) {
		
		 /**
         *  1시간 이내면 분표시
         *  24시간 이내면 시간표시
         *  이상이면 일표시
         */

        // 현재 날짜와 시간
        LocalDate ld = LocalDate.now();
        LocalTime lt = LocalTime.now();
        
        // db에서 넘어온 값 파싱
        LocalDate date = LocalDate.parse(createdAt.substring(0, 10));
        LocalTime time = LocalTime.parse(createdAt.substring(11, 19));
        
        // 몇일 전인지 계산
        Period betweenDate = Period.between(date, ld);

        // 당일이 아닌 경우 일로 표시
        if (0 < betweenDate.getDays()){
        	
            return betweenDate.getDays() + "일전";
            
            // 당일인 경우
        } else {
        	
            long betweenMinutes = ChronoUnit.MINUTES.between(time, lt);
            // 60분이상인지 확인
            if (60 < betweenMinutes){
            	// 이상인 경우 시간으로 표시
                return (betweenMinutes / 60) + "시간전";
            } else {
            	// 아닌 경우 분으로 표시
            	return betweenMinutes + "분전";
            }
        }
	}

	// 이번달 전체 글수 / 접수완료 글수 매퍼 생성
	private Map<String, String> createDateMapper() {
		
		Map<String, String> optionMap = new HashMap<String, String>();
		
		LocalDate today = LocalDate.now();
		
		// 해당월에 맞는 끝일 넣기
		LocalDate firstDay = LocalDate.of(today.getYear(), today.getMonthValue(), 1);
        LocalDate LastDay = LocalDate.of(today.getYear(), today.getMonthValue() + 1, 1).minusDays(1);
		
		String start = firstDay + " 00:00:00"; // DB 검색 범위 설정
		String end = LastDay + " 23:59:59";
		
		optionMap.put("start", start);
		optionMap.put("end", end);
		
		return optionMap;
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

	
	

}
