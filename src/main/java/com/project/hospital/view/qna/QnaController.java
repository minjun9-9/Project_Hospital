package com.project.hospital.view.qna;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.hospital.qna.QnaService;
import com.project.hospital.qna.dto.QnaDTO;
import com.project.hospital.vo.FileStoreVO;


@Controller
@RequestMapping("qna")
public class QnaController {
	
	private QnaService qnaService;
	//private final Logger log = LoggerFactory.getLogger(getClass());
	//log.info("multipartFileList={}", multipartFileList); 이런식으로 쓰던데 뭐가 잔뜩 나와서 일단 포기
	
	@Autowired
	public QnaController(QnaService qnaService) {
		System.out.println("qnaController 객체 생성");
		this.qnaService = qnaService;
	}
	
	

	//(관리자) Q&A 전체 목록
	@GetMapping("/qnaListPage")
	public String qnaPage(Model model) {
		List<QnaDTO> qnaList = qnaService.getQnaList();
		System.out.println("가져온 qna 목록 조회 : " + qnaList);
		model.addAttribute("qnaList", qnaList);
		return "qna/qnaList";
	}
	
	@GetMapping("/getQna")
	public String getQna(QnaDTO dto, Model model) {
		System.out.println(">>글 상세정보 글ID : " + dto.getQnaId());
		QnaDTO qna = qnaService.getQna(dto);
		System.out.println(">> 가져온 해당 글 상세정보 : " + qna);
		model.addAttribute("qna", qna);
		return "qna/qna";
	}
	
	//건의사항 작성 페이지로 전환
	@GetMapping("/insertQnaPage")
	public String qnaWritePage(HttpSession session, Model model) {
		System.out.println(">> 건의사항 작성 페이지로 전환");
		return "qna/insertQna";
	}
	
	//고객의 소리 (건의) 작성
	@PostMapping("/insertQna")
	public String insertQna(@RequestParam(value = "uploadFileList", required = false) List<MultipartFile> multipartFileList ,
			FileStoreVO fileStoreVO, QnaDTO dto, Model model) throws IllegalStateException, IOException {
		//RedirectAttributes redirectAttributes 이거 잘 안돼서 나중에 기회되면 써보기
		System.out.println(">> 건의글 입력 처리");
		System.out.println("고객 작성 데이터 : " + dto);
		
		//아무것도 첨부 안 했을떄 List 사이즈 1, 1개 첨부했을 때도 사이즈 1
		//따라서 mapper에서 아무것도 첨부하지 않았을 때의 값을 거르려면 여기서 첨부 안한 사이즈 1로 넘기는게 아니라 따로 빈 List로 설정해주기
		if (multipartFileList == null || (multipartFileList.size() == 1 && multipartFileList.get(0).isEmpty() )) {
			multipartFileList = Collections.emptyList(); //빈 List로 설정해주기
			dto.setUploadFileList(multipartFileList); //dto값도 똑같이 설정
		}
		System.out.println("첨부파일 확인 (dto) : " + dto.getUploadFileList());
		System.out.println("첨부파일 확인 (dto의 길이) : " + dto.getUploadFileList().size());
		System.out.println("첨부파일 확인 (List): " + multipartFileList);
		System.out.println("첨부파일 확인 (List의 길이): " + multipartFileList.size());
		
		
		//다중 파일 업로드 ---------
		//List<MultipartFile>로 받기
		//--> 데이털르 구분자를 기준으로 나눠야 한다고 생각했는데 이미 File 타입에 getOriginalFilename() 이 메소드로 나눌 수 있었음! 반복문은 그냥 돌려서 get()하면 차례로 꺼낼 수 있고
		
		if (multipartFileList.isEmpty()) {
			System.out.println("파일 업로드 안함.");
			qnaService.insertQna(dto); //파일 업로드 안 했을 때에 DB QNA_BOARD insert
		} else {
			
			//업로드한 파일 수 확인
			System.out.println("업로드한 파일 수 : " + multipartFileList.size());
			dto.setUploadFileCount(multipartFileList.size()); //업로드한 파일 수 qnaDTO에 저장
			//업로드 가능한 파일 확장명 List에 저장
			String[] availiableFileTypeList = {".png", ".jpeg", ".jpg", ".bmp", ".tif", ".tiff", ".pdf", ".hwp", ".docx", ".doc", ".txt"};
			
			for(int i = 0; i < multipartFileList.size(); i++) {
				System.out.println("업로드한 파일 확인 ( " + (i+1) + "번째 파일 ) : "  + multipartFileList.get(i).getOriginalFilename());
			}
			
			//파일 경로 dto에 추가해주기
			List<String> filePathsList = new ArrayList<String>();
			
			//List<MultipartFile> 반복문 돌기
			for (MultipartFile uploadFile : multipartFileList) {
				
				//확장명 확인
				String extension = "";
				for (int i = 0; i < availiableFileTypeList.length; i++) {
					if (uploadFile.getOriginalFilename().contains(availiableFileTypeList[i])) { //일치하는 확장명 확인
						extension += availiableFileTypeList[i];
					}
				}
				System.out.println("-- 확인된 파일 확장명 : " + extension);
				
				//저장할 파일명 생성
				String savedFileName = UUID.randomUUID().toString() + extension;
				System.out.println("생성한 파일 이름 : " + savedFileName);
				
				//실제 파일 저장 경로 설정
				String uploadDir = "C:/MyStudy/Project_Hospital/user/qnaBoard/";
				File dir = new File(uploadDir);
				if(!dir.exists()) {
					dir.mkdirs();
				}
				
				//실제 시스템에서 파일 접근하는 경로
				String filePath = uploadDir + savedFileName;
				System.out.println("실제 시스템에서 파일 접근하는 경로 + 파일 이름: " + filePath);
				
				//파일 업로드하기
				uploadFile.transferTo(new File(filePath)); 
				
				//dto에 파일 경로 추가해주기
				//List<String> filePathsList = new ArrayList<>();
				filePathsList.add(filePath);
				dto.setFilePath(filePathsList);
				
				//fileStoreVO에 저장하기. 근데 이거 스프링이 알아서 해주지 않냐
				String webPath = "/Project_Hospital_uploadedFiles/user/qnaBoard/" + savedFileName;
				fileStoreVO.setFilePath(webPath); //이거 qnaBoard에 업로드 안됌
				fileStoreVO.setFilestoreId(savedFileName);
				fileStoreVO.setOriginalName(uploadFile.getOriginalFilename());
				
				//FileStoreDB에 파일 저장 (업로드한 파일 수 만큼 반복됌)
				qnaService.insertFiles(fileStoreVO);  //test할 때 주석처리
				
				//1. 업로드한 파일 개수 uploadFileCount DTO에 추가
				//2. uploadFileCount 값에 따른 mapper 날리기!
				
			} //List<MultipartFile> 반복문
			
			System.out.println("파일 경로들 List 확인 : " + dto.getFilePath());
			System.out.println("insert할 최종 qnaBoard 확인 : " + dto);
			qnaService.insertQna(dto);
			System.out.println(">> insertWithFile 성공--");
		}
		//단일 파일 처리할 때  ---------
		/*
		MultipartFile uploadFile = dto.getUploadFile();
		if (uploadFile.isEmpty()) {
			System.out.println("파일 업로드 안함");
		} else {
			System.out.println("uploadFile.isEmpty() : " + uploadFile.isEmpty());
			String ogFileName = uploadFile.getOriginalFilename();
			System.out.println("원본 파일 이름 : " + ogFileName);
			String savedFileName = UUID.randomUUID().toString();
			System.out.println("생성한 파일 이름 : " + savedFileName);
			String filePath = "c:/MyStudy/qnaFiles/" + savedFileName;
			uploadFile.transferTo(new File(filePath));
			System.out.println("최종 경로 : " + filePath);
			dto.setFilePath(filePath);
		}
		*/
		
//		System.out.println("insert할 최종 dto 확인 : " + dto);
//		qnaService.insertQna(dto);
		
		model.addAttribute("status", "completed");
		return "qna/insertQna";
	}
	
	//고객의 소리 답글달기 페이지로 전환
	@GetMapping("/replyQna")
	public String replyQna(QnaDTO dto, HttpSession session, Model model) {
		System.out.println("답글달기 qnaID 확인 : " + dto);
		session.setAttribute("qnaId", dto.getQnaId());
		QnaDTO qna = qnaService.getQna(dto);
		model.addAttribute("qna", qna);
		session.getAttribute(""); // 통합 이후에 관리자 정보 session에서 가져오기!!!!!
		return "qna/replyQna";
	} 
	
	//고객의 소리 답글 등록하기
	@PostMapping("/replyQna")
	public String replyQna(QnaDTO dto, RedirectAttributes redirectAttribute) {
		System.out.println("답글용 내용 확인 : " + dto); 
		qnaService.replyQna(dto);
		redirectAttribute.addFlashAttribute("message", "답글 등록이 완료되었습니다. 글목록 페이지로 이동합니다.");
		return "redirect:replyQna";
	}

	
	//고객의 소리 삭제하기
	@GetMapping("/deleteSingleQna")
	public String deleteSingleQna(QnaDTO dto, RedirectAttributes redirectAttribute) {
		System.out.println("건의글 삭제하기 qnaID 확인 : " + dto);
		qnaService.deleteSingleQna(dto);
		return "redirect:qnaListPage";
	}
	
	
	
	//(고객측) 고객의 소리 게시판 --세션에서 로그인 유저 정보 가져와야함!!
	@GetMapping("/qnaListClientPage")
	public String qnaListClientPage(Model model, HttpSession session) {
		List<QnaDTO> qnaList = qnaService.getQnaList();
		model.addAttribute("qnaList", qnaList);
		session.getAttribute(""); //유저 아이디 가져오기!!!!
		return "qna/qnaListClient";
	}
	
	
	//(고객측) 답변 확인하기 오 그런데 이거 한번 ajax로 해봐?????
//	@GetMapping("/getReplyQnaPage")
//	public String getReplyQnaPage(QnaDTO dto) {
//		return "qna/getReply";
//	}
	
	

}
