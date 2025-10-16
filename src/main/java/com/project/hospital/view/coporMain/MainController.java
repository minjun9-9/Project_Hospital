package com.project.hospital.view.coporMain;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.project.hospital.common.Paging;
import com.project.hospital.dto.ReferralSearchDTO;
import com.project.hospital.coporationMain.MainService;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HospitalVO;
import com.project.hospital.vo.HpMemberVO;
import com.project.hospital.vo.ReferralVO;
import com.project.hospital.vo.UserVO;

@Controller
@RequestMapping("main")
public class MainController {
	
	private MainService mainService;
	
	public MainController() {
		System.out.println("MainController() 시작");
	}
	
	@Autowired
	public MainController(MainService mainService) {
		this.mainService = mainService;
	}


	@GetMapping("/mainPage")
	public String mainPage() {
		System.out.println("main 컨트롤러 사용");
		return "main/main";
	}
	
	@GetMapping("/getSearch")
	public String getSearch(ReferralSearchDTO rsDTO) {
		System.out.println("검색시작");
		System.out.println(rsDTO);
		
		return null;
	}
	
	//받은 진료의뢰서 확인
	@GetMapping("/referralPage")
	public String referralPage(Model model, HttpSession session, String cPage, ReferralSearchDTO rsDTO) {
		System.out.println("referral 페이지 이동");
		
		HpMemberVO hpMemberVO = (HpMemberVO) session.getAttribute("hpMember");
		System.out.println("세션 확인 : "+hpMemberVO);
		
		System.out.println("검색 확인 : "+rsDTO);
		
		if(rsDTO.getSearchKeyword() != null) {
			session.setAttribute("keyword", rsDTO.getSearchKeyword());
		}
		
		
		//페이징 처리
		Paging p = new Paging();
		
		//의료진 로그인 했을때 해당 의료진이 받은 진료의뢰서 보기
		if (hpMemberVO != null) {
			
			int referCnt = mainService.getReferCnt(hpMemberVO, rsDTO);
			System.out.println("총 게시물 갯수 : "+referCnt);
			p.setTotalRecord(referCnt);
			p.setTotalPage();
			p.setTotalBlock();
			
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
			
			List<ReferralVO> referralList = mainService.getReferralList(hpMemberVO, p.getBegin(), p.getEnd(), rsDTO);
			model.addAttribute("paging", p);
			model.addAttribute("referralListAll", referralList);
		}
		
		//관리자 로그인시 전체 진료의뢰서 보기
		else {
			int referCnt = mainService.getReferCntAll();
			System.out.println("총 게시물 갯수 : "+referCnt);
			p.setTotalRecord(referCnt);
			p.setTotalPage();
			p.setTotalBlock();
			
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
			
			List<ReferralVO> referralListAll = mainService.getReferralListAll(p.getBegin(), p.getEnd());
			model.addAttribute("paging", p);
			model.addAttribute("referralListAll", referralListAll);
		}
		
		
		return "referral/referral";
	}
	
	//작성한 진료의뢰서 확인
	@GetMapping("/sendReferralPage")
	public String sendReferralPage(Model model, HttpSession session, String cPage, ReferralSearchDTO rsDTO) {
		System.out.println("보낸 진료의뢰 확인 페이지 이동");
		
		HpMemberVO hpMemberVO = (HpMemberVO) session.getAttribute("hpMember");
		System.out.println("세션 확인 : "+hpMemberVO);

		System.out.println("검색 확인 : "+rsDTO);
		
		//페이징 처리
		Paging p = new Paging();
		
		//의료진 로그인 했을때 해당 의료진이 작성한 진료의뢰서 보기
		if (hpMemberVO != null) {
			
			int referCnt = mainService.getSendReferCnt(hpMemberVO, rsDTO);
			System.out.println("총 게시물 갯수 : "+referCnt);
			p.setTotalRecord(referCnt);
			p.setTotalPage();
			p.setTotalBlock();
			
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
			
			List<ReferralVO> referralList = mainService.getSendReferralList(hpMemberVO, p.getBegin(), p.getEnd(), rsDTO);
			
			model.addAttribute("paging", p);
			model.addAttribute("referralListAll", referralList);
		}
		//관리자 로그인 시 전체 리스트 보기
		else {
			int referCnt = mainService.getReferCntAll();
			p.setTotalRecord(referCnt);
			p.setTotalPage();
			p.setTotalBlock();
			
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
			
			
			List<ReferralVO> referralListAll = mainService.getReferralListAll(p.getBegin(), p.getEnd());
			
			model.addAttribute("paging", p);
			model.addAttribute("referralListAll", referralListAll);
		}
		
		return "referral/referralSend";
	}
	
	
	@GetMapping("/goPage")
	public String goPage(Model model) {
		System.out.println("등록 페이지 이동");
		
		List<DeptVO> deptList = mainService.getDeptList();
		model.addAttribute("deptList", deptList);
		
		return "referral/adminDoctorRegister";
	}
	
	
	@GetMapping("/insertReferralPage")
	public String insertReferralPage(Model model, ReferralVO vo) {
		System.out.println("insertReferral 페이지 이동");
		System.out.println("referral vo : "+vo);
		
		if(vo.getReferId() != null) {
			System.out.println(">>>> 진료의뢰 상세보기 시작");
			ReferralVO referral = mainService.getReferral(vo);
			System.out.println("상세보기 referral : "+referral);
			model.addAttribute("referral", referral);
			
			return "referral/updateReferral";
		}
		
		//병원목록
		List<HospitalVO> hospitalList = mainService.getHospitalList();
		System.out.println("hospitalList : "+hospitalList);
		model.addAttribute("hospitalList", hospitalList);
		
		//유저목록
		List<UserVO> userList = mainService.getUserList();
		System.out.println("userList : "+userList);
		model.addAttribute("userList", userList);
		
		return "referral/insertReferral";
	}
	
	@PostMapping("/insertReferral")
	public String insertReferral(ReferralVO vo) throws IllegalStateException, IOException {
		System.out.println("insert vo : "+vo);
		
		MultipartFile uploadFile = vo.getFile();
		System.out.println(uploadFile);
		
		if(uploadFile == null) {
			System.out.println(":: uploadFile 파라미터가 없음");
		}else if(uploadFile.isEmpty()) {
			System.out.println(":: 전달받은 파일데이터가 없음");
		}else { //파일데이터가 있는 경우
			System.out.println("uploadFile.isEmpty() : "+uploadFile.isEmpty());
			String fileName = uploadFile.getOriginalFilename(); //원본파일명
			System.out.println(">> 원본파일명 : "+fileName);
			String savedFileName = UUID.randomUUID().toString(); //임의의 문자열 만듦 -> 물리적 저장 파일명 사용을  위해 생성
			System.out.println(">> 저장파일명 : "+savedFileName);
			
			//물리적 파일복사 작업
			String destPathFile = "c:/MyStudy/temp/file/" + savedFileName;
			uploadFile.transferTo(new File(destPathFile)); // 하는일? 찾아보기
		}
		
		mainService.insertReferral(vo);
		
		return "redirect:sendReferralPage";
	}
	
	@GetMapping("/updateReceive")
	public String updateReceive(ReferralVO vo) {
		System.out.println("receive 업데이트 시작");
		System.out.println("vo : "+vo);
		/* System.out.println("referId : "+vo.getReferId()); */
		
		mainService.updateReceive(vo);
		
		return "redirect:referralPage";
	}
	

}
