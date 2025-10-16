package com.project.hospital.admindrMain;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.project.hospital.admin.HpMemberService;
import com.project.hospital.admindrMain.dto.AdminDrMainLogInDTO;
import com.project.hospital.admindrMain.dto.LoginResultDTO;
import com.project.hospital.admindrMain.dto.MainPageReservDTO;
import com.project.hospital.admindrMain.dto.QnaCountDTO;
import com.project.hospital.admindrMain.dto.UserJoinCntGraphDTO;
import com.project.hospital.dao.AdminDrMainDAO;
import com.project.hospital.health.HealthService;
import com.project.hospital.qna.QnaService;
import com.project.hospital.reserve.ReservationService;

@Service
@Transactional(readOnly = true)
public class AdminDrMainServiceImpl implements AdminDrMainService{
	
	private final QnaService qnaService;
	private final HpMemberService hpMemService;
	private final AdminService adminService;
	private final UserClinetService userService;
	private final ExaminationService examService;
	private final DiseaseService diseaseService;
	private final HealthService healthService;
	private final AdminDrMainDAO dao;
	private final ReservationService reservService;
	
	@Autowired
	public AdminDrMainServiceImpl(QnaService qnaService, HpMemberService hpMemService, AdminService adminService,
			UserClinetService userService, ExaminationService examService, DiseaseService diseaseService,
			HealthService healthService, AdminDrMainDAO dao, ReservationService reservService) {
		super();
		this.qnaService = qnaService;
		this.hpMemService = hpMemService;
		this.adminService = adminService;
		this.userService = userService;
		this.examService = examService;
		this.diseaseService = diseaseService;
		this.healthService = healthService;
		this.dao = dao;
		this.reservService = reservService;
	}


	/**
	 * 입력받은 ID,PW 검증 후 값 셋팅 해 반환 
	 */
	@Transactional
	@Override
	public String findByIdAndPw(AdminDrMainLogInDTO logindto, Model model, HttpServletRequest request) {
		
		boolean flag = logindto.getAdminLogin();
		LoginResultDTO resultDto = new LoginResultDTO();
		HttpSession ss = request.getSession();
		
		// 의료진 로그인
		if(!flag) {
			
			// 존재여부 확인
			resultDto = hpMemService.findByIdAndPw(logindto.getId(), logindto.getPw());
			
			//추가 ***********(해쉬값 확인)
			if (resultDto.getDrId() != null && resultDto.getHashPw() != null) {
				boolean bcrypt = isPasswordMatch(logindto.getPw(), resultDto.getHashPw());
				if (bcrypt) {
					setMainContent(ss);
					ss.setAttribute("resultDto", resultDto);
					return "admin/adminMain";
				}
			}
			// 있는 경우 의료진페이지로 이동 
			if(resultDto.getDrId() != null) {
				setMainContent(ss);
				ss.setAttribute("resultDto", resultDto);
				return "admin/adminMain";
			}
			
			// 관리자 로그인
		} else {
			
			// 존재여부 확인
			resultDto = adminService.findByIdAndPw(logindto.getId(), logindto.getPw());
			// 있는 경우 관리자페이지로 이동 
			if(resultDto.getAdminId() != null) {
				setMainContent(ss);
				ss.setAttribute("resultDto", resultDto);
				return "admin/adminMain";
			}
			
		}
		
		// 오류 메시지 삽입
		ss.setAttribute("message", "아이디 또는 비밀번호가 잘못되었거나 존재하지 않습니다.\\n확인 후 다시 입력해주세요");
		
		return "redirect:/adminDoctorMain/loginPage";
	}


	/**
	 * 편의 메서드
	 */
	

	// 메인페이지 컨텐츠 값 셋팅
	private void setMainContent(HttpSession ss) {
		
		// 의료관리자 메인 페이지 qna 접수 총 카운트, 해결 카운트 , 페이징 리스트 데이터 추출
		QnaCountDTO qnaCntdto = qnaService.getQnaCountAndList();
		
		// 회원 가입수 + 그래프로 보기
		UserJoinCntGraphDTO userCntGraphdto = userService.getJoinCntAndGraph();
		
		// 게시글 바로가기 새글/이번달 => 메인 게시글 순위대로
		Map<String, Integer> qnaCntMap = qnaService.getQnaCnt();
		Map<String, Integer> examCntMap = examService.getExamCnt();
		Map<String, Integer> diseaseCntMap = diseaseService.getDiseaseCnt();
		Map<String, Integer> healthCntMap = healthService.getHealthCnt();
		
		// 전체 새로운 게시글 어제보다 오늘 얼마나 생겼는지 
		Map<String, String> allBoardCnt = setAllBoardCnt(dao.getAllBoardCnt(createDateMapper()));
		
		// 오늘 / 이번달 예약 횟수, 예약과 부재 cnt와 그 노쇼비율, 예약접수확인 고객전화번호, 예약, 방문여부, 시간
		MainPageReservDTO reservDto = reservService.getMainReservData();
		
		// 내가 쓴 글 
		
		// model 등록
		ss.setAttribute("reservDto", reservDto);
		ss.setAttribute("allBoardCnt", allBoardCnt);
		ss.setAttribute("qnaCntMap", qnaCntMap);
		ss.setAttribute("examCntMap", examCntMap);
		ss.setAttribute("diseaseCntMap", diseaseCntMap);
		ss.setAttribute("healthCntMap", healthCntMap);
		ss.setAttribute("qnaCntdto", qnaCntdto);
		ss.setAttribute("userCntGraphdto", userCntGraphdto);
	}

	// [전체 새로운 게시글 어제보다 오늘 얼마나 생겼는지] 반환 값 셋팅
	private Map<String, String> setAllBoardCnt(Map<String, Integer> result) {
		
		Map<String, String> allBoardCnt = new HashMap<String, String>();
		
		int today =  Integer.parseInt(String.valueOf(result.get("TODAY")));
		int yesterday =  Integer.parseInt(String.valueOf(result.get("YESTERDAY")));
		
		/**
		 *  			많거나 같으면	     		적으면
		 *  클래스명 : today_green c_g || today_red c_r
		 *  텍스트 : 		+					-
		 *  	 
		 */
		
		String className = "";
		String text = "";
		String differ = "";
		
		// 갯수 분기문
		if (today >= yesterday) {
			
			className = "today_green c_g";
			text = "+";
			differ = String.valueOf((today - yesterday));
		} else {
			className = "today_red c_r";
			text = "-";
			differ = String.valueOf((yesterday - today));
		}
		
		allBoardCnt.put("className", className);
		allBoardCnt.put("text", text);
		allBoardCnt.put("today", String.valueOf(today));
		allBoardCnt.put("differ", differ);
		
		return allBoardCnt;
	}


	// [전체 새로운 게시글 어제보다 오늘 얼마나 생겼는지] 매퍼 
	private Map<String, String> createDateMapper() {
		
		LocalDate today = LocalDate.now();
		String start = " 00:00:00"; // DB 검색 범위 설정
		String end = " 23:59:59";
		
		Map<String, String> optionMap = new HashMap<String, String>(); 
		optionMap.put("yesterStart", today.minusDays(1).toString() + start);
		optionMap.put("yesterEnd", today.minusDays(1).toString() + end);
		optionMap.put("todayStart", today.toString() + start);
		optionMap.put("todayEnd", today.toString() + end);
		
		return optionMap;
	}
	
	//추가 ************ (해쉬값 확인 메소드)
	private static boolean isPasswordMatch(String rawPassword, String encryptedPassword) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        return encoder.matches(rawPassword, encryptedPassword);
    }

	
}
