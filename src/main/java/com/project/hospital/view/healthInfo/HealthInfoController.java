package com.project.hospital.view.healthInfo;

import java.io.File;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.hospital.health.HealthService;
import com.project.hospital.health.dto.DiseaseBoardDTO;
import com.project.hospital.health.dto.DiseaseBoardTotalCountDTO;
import com.project.hospital.health.dto.ExaminationBoardDTO;
import com.project.hospital.health.dto.ExaminationBoardPageDTO;
import com.project.hospital.health.dto.HealthBoardDTO;
import com.project.hospital.health.dto.HealthBoardPageDTO;
import com.project.hospital.vo.BodyClassificationVO;
import com.project.hospital.vo.DiseaseBoardVO;
import com.project.hospital.vo.DiseaseClassificationVO;
import com.project.hospital.vo.ExaminationBoardVO;
import com.project.hospital.vo.HealthBoardVO;

@Controller
@RequestMapping("health")
public class HealthInfoController {
	
	private HealthService healthService;
	
	@Autowired
	public HealthInfoController(HealthService healthService) {
		this.healthService = healthService;
	}
	
	
	//신체 분류 테이블 ModelAttribute
	@ModelAttribute("bodyClassificationList")
	public List<BodyClassificationVO> bodyClassificationList() {
		return healthService.getBodyClassificationList();
	}
	
	//질환 분류 테이블 ModelAttribute
	@ModelAttribute("diseaseClassificationList")
	public List<DiseaseClassificationVO> diseaseClassificationList() {
		return healthService.getDiseaseClassificationList();
	}
	
	//질환 게시판 테이블 ModelAttribute
	@ModelAttribute("diseaseBoardList")
	public List<DiseaseBoardDTO> diseaseBoardList() {
		return healthService.getDiseaseBoardList();
	}
	
	//건강 게시판 테이블 ModelAttribute
	@ModelAttribute("healthBoardList")
	public List<HealthBoardDTO> healthBoardList(Model model) {
		List<HealthBoardDTO> list = healthService.getHealthBoardList();
		int healthBoardListTotalCount = 0;
		for(HealthBoardDTO dto : list ) {
			healthBoardListTotalCount = dto.getTotalCount();
		}
		model.addAttribute("healthBoardListTotalCount", healthBoardListTotalCount);
		return healthService.getHealthBoardList();
	}
	
	//검사, 치료 테이블 ModelAttribute
	@ModelAttribute("examinationBoardList")
	public List<ExaminationBoardDTO> examinationBoardList() {
		return healthService.getExaminationBoardList();
	}
	
	
	//건강정보 페이지로 전환
	@GetMapping("/healthIndexPage")
	public String healthIndexPage() {
		return "health/healthIndex";
	}
	
	//질환정보 상세 페이지 전환
	@GetMapping("/getDiseaseBoardDetailPage")
	public String getDiseaseBoardDetailPage(DiseaseBoardVO diseaseBoardVO, Model model) {
		System.out.println(">> 질환 정보 상세 페이지 id : " + diseaseBoardVO);
		DiseaseBoardDTO diseaseContent = healthService.getDiseaseBoardDetail(diseaseBoardVO);
		System.out.println("가져온 질환 게시글 1개 정보 : " + diseaseContent);
		model.addAttribute("diseaseContent", diseaseContent);
		
		//영어, 한글 명칭 추출
		String title = diseaseContent.getTitle();
		int idx = title.indexOf("[");
		String koreanTitle = title.substring(0, idx);
		String englishTitle = title.substring(idx+1, title.length()-1);
		System.out.println("koreanTitle : " + koreanTitle);
		System.out.println("englishTitle : " + englishTitle);
		
		model.addAttribute("englishTitle", englishTitle);
		model.addAttribute("koreanTitle", koreanTitle);
		
		
		
		//content 나누기
		Map<Integer, String> splitedContentMap = new LinkedHashMap<Integer, String>();
		String[] splitContentArr = diseaseContent.getContent().split("#");
		for (int i = 0; i < splitContentArr.length; i++) {
			splitedContentMap.put(i+1, splitContentArr[i]);
		}
		for (Map.Entry<Integer, String> set : splitedContentMap.entrySet()) {
			System.out.println("key : " + set.getKey() + ", value : " + set.getValue());
		}
		model.addAttribute("splitedContentMap", splitedContentMap);
		return "health/disease/diseaseDetail";
	}
	
	//검사정보 상세 페이지 전환
	@GetMapping("/getExaminationBoardDetailPage")
	public String getExaminationBoardDetailPage(ExaminationBoardVO examinationBoardVO, Model model) {
		System.out.println(">> 검사 정보 상세 페이지 id : " + examinationBoardVO.getExaminationId());
		ExaminationBoardDTO examinationInfo = healthService.getExaminationBoardDetail(examinationBoardVO);
		System.out.println("가져온 검사 정보 확인  : " + examinationInfo);
		model.addAttribute("examinationInfo", examinationInfo);
		
		return "health/examination/examinationDetail";
	}
	
	
	//질환 찾기 페이지 전환
	@GetMapping("/diseaseSearchPage")
	public String diseaseSearchPage() {
		return "health/disease/search/diseaseSearch";
	}
	
	//질환 찾기 - 신체부위별 찾기 페이지 전환
	@GetMapping("/diseaseSearchByBodyPage")
	public String diseaseSearchByBodyPage() {
		return "health/disease/search/diseaseSearchByBody";
	}
		
	//질환 찾기 - 질환 분류별 찾기 페이지 전환
	@GetMapping("/diseaseSearchByDiseasePage")
	public String diseaseSearchByDiseasePage() {
		return "health/disease/search/diseaseSearchByDisease";
	}
	
	//건강 게시판 페이지 전환
	@GetMapping("/healthBoardPage")
	public String healthBoardPage() {
		return "health/healthBoard/healthBoard";
	}
	
	//검사, 치료 게시판 페이지 전환
	@GetMapping("/examinationBoardPage")
	public String examinationBoardPage() {
		return "health/examination/examinationBoard";
	}
	
	//건강 게시글 상세 페이지 이동
	@GetMapping("/getHealthBoardDetailPage")
	public String healthBoardDetailPage(HealthBoardVO hbVO, Model model) {
		System.out.println("hbID 확인 : " + hbVO.getHbId() );
		HealthBoardDTO health = healthService.getHealthBoardDetail(hbVO);
		System.out.println("가져온 건강정보 상세 정보 확인 : " + health);
		model.addAttribute("healthDetail", health);
		return "health/healthBoard/healthDetail";
	}
	
	
	
	// 관리자_건강정보--------------------------------
	//1. 질환 분류 관리  
	@GetMapping("/diseaseClassificationManagePage")
	public String diseaseClassificationManagePage() {
		return "manager/health/diseaseClassification/diseaseClassificationManage";
	}
	
	//질환 분류 이름 UPDATE 페이지 전환
	@GetMapping("/updateDiseasePartNamePage")
	public String updateDiseasePartNamePage(DiseaseClassificationVO diseaseClassificationVO, Model model) {
		System.out.println("수정하려는 질환 ID : " + diseaseClassificationVO.getDiseasePartId());
		DiseaseClassificationVO oneDisease =  healthService.getDiseaseClassificationById(diseaseClassificationVO);
		model.addAttribute("disease", oneDisease);
		return "manager/health/diseaseClassification/updateDiseaseClassification";
	}
	
	//질환 분류 INSERT 페이지 전환
	@GetMapping("/insertDiseaseClassificationPage")
	public String insertDiseaseClassification() {
		return "manager/health/diseaseClassification/insertDiseaseClassification";
	}
	
	//2. 신체 분류 관리
	@GetMapping("/bodyClassificationManagePage")
	public String bodyClassificationManagePage() {
		return "manager/health/bodyClassification/bodyClassificationManage";
	}
	
	//신체 분류 UPDATE 페이지 전환
	@GetMapping("/updateBodyPartNamePage")
	public String updateBodyPartNamePage(BodyClassificationVO bodyClassificationVO, Model model) {
		System.out.println("수정하려는 신체 부위 ID : " + bodyClassificationVO.getBodyPartId());
		BodyClassificationVO oneBody = healthService.getBodyClassificationById(bodyClassificationVO);
		model.addAttribute("body", oneBody);
		return "manager/health/bodyClassification/updateBodyClassification";
		
	}
	
	//신체 분류 INSERT 페이지 전환
	@GetMapping("/insertbodyClassificationPage")
	public String insertbodyClassificationPage() {
		return "manager/health/bodyClassification/insertbodyClassification";
	}
	
	
	//3. 질환 게시판 관리
	@GetMapping("/diseaseBoardManagePage")
	public String diseaseBoardManagePage(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		//총 게시글 개수
		DiseaseBoardTotalCountDTO diseaseBoardTotalCount = healthService.getDiseaseBoardTotalCount();
		model.addAttribute("diseaseBoardTotalCount", diseaseBoardTotalCount);
		
		//페이지당 표시할 게시글 수
		int pageSize = 10;
		
		//총 페이지 수 (총 게시글 수 / 페이지당 개수)
		int totalPageCount = (int) Math.ceil((double) diseaseBoardTotalCount.getTotalCount() / pageSize);
		
		//현재 페이지 유효성 체크
		if(page < 1) {
			page = 1;
		} else if (page > totalPageCount) {
			page = totalPageCount;
		}
		
		model.addAttribute("currentPage", page); //현재 페이지 번호
		model.addAttribute("totalPageCount", totalPageCount); //총 페이지 수 
		
		return "manager/health/diseaseBoard/diseaseBoardManage";
	}
	
	//질환 게시글 INSERT 페이지 전환
	@GetMapping("/insertDiseaseBoardPage")
	public String insertDiseaseBoardPage() {
		return "manager/health/diseaseBoard/insertDiseaseBoard";
	}
	
	//질환 게시글 INSERT
	@PostMapping("/insertDiseaseBoard")
	public String insertDiseaseBoard(MultipartFile uploadFile, DiseaseBoardDTO diseaseBoardDTO, RedirectAttributes redirectAttributes) throws IllegalStateException, IOException {
		System.out.println("질환 게시글 INSERT : " + diseaseBoardDTO);
		
		//파일 업로드 안하면 .getSize == 0
		if(uploadFile.getSize() == 0) { //파일 업로드 안 했을때
			System.out.println("파일 업로드 안 함");
		} else { //파일 업로드 하면
			System.out.println("파일 업로드 했음");
			String ogFileName = uploadFile.getOriginalFilename();
			System.out.println("원본 파일 명 : " + ogFileName);
			diseaseBoardDTO.setOriginalName(ogFileName); //fileStore INSERT용 set
			
			//확장명 추출
			String[] availiableFileTypeList = {".png", ".jpeg", ".jpg", ".bmp", ".tif", ".tiff"};
			String extension = "";
			for(int i = 0; i < availiableFileTypeList.length; i++) {
				if(ogFileName.contains(availiableFileTypeList[i])) {
					extension = availiableFileTypeList[i];
				}
			}
			System.out.println("찾은 확장명 : " + extension);
			
			//저장할 랜덤 파일명 생성
			String savedFileName = UUID.randomUUID().toString() + extension;
			System.out.println("생성한 파일명 : " + savedFileName);
			diseaseBoardDTO.setFilestoreId(savedFileName); //fileStoreId(=fileOne) INSERT용 set
			
			//실제 파일 경로 설정
			//String path = "C:/MyStudy/70_Spring/Project_Hospital/Project_Hospital/src/main/webapp/resources/uploadedFiles/manager/diseaseBoard/";
			//경로 외부로 프로젝트폴더 외부로 빼고 presentation-layer에 mvc:resources 추가 (diseaseBoardManage.jsp하다가)
			String uploadDir = "C:/MyStudy/Project_Hospital/manager/diseaseBoard/";
			File dir = new File(uploadDir); 
			if(!dir.exists()) { //폴더 없으면 만들기
				dir.mkdirs();
			}
			
			//실제 시스템에서 파일 접근하는 경로 C:/MyStudy/Project_Hospital_uploadedFiles/manager/diseaseBoard/
			String filePath = uploadDir + savedFileName;
			System.out.println("실제 시스템에서 파일 접근하는 경로 + 파일이름 : " + filePath);
			
			//클라이언트에서 파일 접근하는 URL 경로
			//fileStore INSERT용 set (웹 경로 설정)
			String webPath = "/Project_Hospital_uploadedFiles/manager/diseaseBoard/" + savedFileName;
			diseaseBoardDTO.setFilePath(webPath);
			
			//파일 업로드
			try {
				uploadFile.transferTo(new File(filePath));
				System.out.println("Health 파일 업로드 성공 : " + filePath);
			} catch (Exception e) {
				System.out.println("Health 파일 업로드 실패 ");
				e.printStackTrace();
				 
			}
			
		}
		
		System.out.println("쿼리 날리기 전 최종 DTO : " + diseaseBoardDTO);
		int result = healthService.insertDiseaseBoard(diseaseBoardDTO);
		if (result == 1) {
			System.out.println("INSERT 성공 : " + result);
		} else {
			System.out.println("INSERT 실패 : " + result);
			result = -1;
		}
		redirectAttributes.addFlashAttribute("result", result);
 		return "redirect:insertDiseaseBoardPage";
	}
	
	
	
	@GetMapping("/healthManagerMainPage")
	public String healthManagerMainPage() {
		return "manager/health/managerIndex";
	}
	
	
	//질환 게시판 UPDATE 페이지 전환 .. 아님 그냥 모달창으로 할까? 근데 그냥 insert페이지 만들어놨으니까 그걸로 하는게 나을거같기도
	@GetMapping("/updateDiseaseBoardPage")
	public String updateDiseaseBoardPage(DiseaseBoardVO diseaseBoardVO, Model model) {
		System.out.println("수정하려는 질환 게시글 ID : " + diseaseBoardVO.getDiseaseBoardId());
		DiseaseBoardDTO diseaseBoardDTO = healthService.getDiseaseBoardDetail(diseaseBoardVO);
		System.out.println("수정하려는 질환 게시글 전체 정보 : " + diseaseBoardDTO);
		
		//타이틀 한글, 영어로 문자열 나누기
		String title = diseaseBoardDTO.getTitle();
        String[] parts = title.split("\\[|\\]");
        
        // 결과 출력
        String koreanName = parts[0];
        String englishTitle = parts[1];
        
        System.out.println("한글 이름: " + koreanName);
        System.out.println("English Title: " + englishTitle);
        
        diseaseBoardDTO.setKoreanTitle(koreanName);
        diseaseBoardDTO.setEnglishTitle(englishTitle);
		
        System.out.println("수정 dto 확인 : " + diseaseBoardDTO);
        model.addAttribute("dto", diseaseBoardDTO);
		return "manager/health/diseaseBoard/updateDiseaseBoard";
	}
	
	//질환 게시판 UPDATE
	@PostMapping("/updateDiseaseBoard")
	public String updateDiseaseBoard(MultipartFile uploadFile, DiseaseBoardDTO diseaseBoardDTO, DiseaseBoardVO diseaseBoardVO, Model model) {
		System.out.println("수정할 데이터 담은 dto : " + diseaseBoardDTO);

		//새로운 첨부파일 있는지 없는지 확인
		if(uploadFile.getSize() == 0) {
			System.out.println("파일 업로드 안 함");
			int result = healthService.updateDiseaseBoardExceptFile(diseaseBoardDTO);
			if (result == 1) {
				System.out.println("파일 제외 업데이트 성공 : " + result);
			} else {
				System.out.println("파일 제외 업데이트 실패 : " + result);
			}
			model.addAttribute("result", result);
				
		} else {
			System.out.println("파일 업로드 함");
			
			String ogFileName = uploadFile.getOriginalFilename();
			System.out.println("원본 파일 명 : " + ogFileName);
			diseaseBoardDTO.setOriginalName(ogFileName); //fileStore INSERT용 set
			
			//확장명 추출
			String[] availiableFileTypeList = {".png", ".jpeg", ".jpg", ".bmp", ".tif", ".tiff"};
			String extension = "";
			for(int i = 0; i < availiableFileTypeList.length; i++) {
				if(ogFileName.contains(availiableFileTypeList[i])) {
					extension = availiableFileTypeList[i];
				}
			}
			System.out.println("찾은 확장명 : " + extension);
			
			//저장할 랜덤 파일명 생성
			String savedFileName = UUID.randomUUID().toString() + extension;
			System.out.println("생성한 파일명 : " + savedFileName);
			diseaseBoardDTO.setFilestoreId(savedFileName); //fileStoreId(=fileOne) INSERT용 set
			
			//실제 파일 경로 설정
			String uploadDir = "C:/MyStudy/Project_Hospital/manager/diseaseBoard/";
			File dir = new File(uploadDir); 
			if(!dir.exists()) { //폴더 없으면 만들기
				dir.mkdirs();
			}
			
			String filePath = uploadDir + savedFileName;
			System.out.println("실제 시스템에서 파일 접근하는 경로 + 파일이름 : " + filePath);
			
			//클라이언트에서 파일 접근하는 URL 경로
			//fileStore INSERT용 set (웹 경로 설정)
			String webPath = "/Project_Hospital_uploadedFiles/manager/diseaseBoard/" + savedFileName;
			diseaseBoardDTO.setFilePath(webPath);
			
			//파일 업로드
			try {
				uploadFile.transferTo(new File(filePath));
				System.out.println("Health 파일 업로드 성공 : " + filePath);
			} catch (Exception e) {
				System.out.println("Health 파일 업로드 실패 ");
				e.printStackTrace();
				 
			}
			
			System.out.println("파일O 수정 날리기 전 dto 확인 : " + diseaseBoardDTO);
			int result = healthService.updateDiseaseBoardWithFile(diseaseBoardDTO);
			if(result == 1) {
				System.out.println("수정 성공");
			} else {
				System.out.println("수정 실패");
			}
			model.addAttribute("result", result);
		}
		
		return "manager/health/diseaseBoard/updateDiseaseBoard";
		
		
	}
	
	//4. 검사 치료 게시판
	//검사 치료 게시판 관리 페이지 전환
	@GetMapping("/examinationBoardManagePage")
	public String examinationBoardManagePage(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		//총 게시글 개수
		ExaminationBoardPageDTO examinationBoardTotalCount = healthService.getExaminationBoardTotalCount();
		model.addAttribute("examinationBoardTotalCount", examinationBoardTotalCount);
		
		//페이지당 표시할 게시글 수
		int pageSize = 10;
		
		//총 페이지 수 (총 게시글 수 / 페이지당 개수)
		int totalPageCount = (int) Math.ceil((double) examinationBoardTotalCount.getTotalCount() / pageSize);
		
		//현재 페이지 유효성 체크
		if(page < 1) {
			page = 1;
		} else if (page > totalPageCount) {
			page = totalPageCount;
		}
		
		model.addAttribute("currentPage", page); //현재 페이지 번호 (기본값 1)
		model.addAttribute("totalPageCount", totalPageCount); //총 페이지 수 
				
		return "manager/health/examinationBoard/examinationBoardManage";
	}
	
	//검사 치료 게시판 INSERT 페이지 전환
	@GetMapping("/insertExaminationBoardPage")
	public String insertExaminationBoardPage() {
		return "manager/health/examinationBoard/insertExaminationBoard";
	}
	
	//검사 치료 게시판 INSERT
	@PostMapping("/insertExaminationBoard")
	public String insertExaminationBoard(MultipartFile uploadFile, ExaminationBoardDTO examinationBoardDTO, RedirectAttributes redirectAttributes) {
		System.out.println("검사 치료 게시글 INSERT : " + examinationBoardDTO);
		
		//파일 업로드 안하면 .getSize == 0
		if(uploadFile.getSize() == 0) { //파일 업로드 안 했을때
			System.out.println("파일 업로드 안 함");
		} else { //파일 업로드 하면
			System.out.println("파일 업로드 했음");
			String ogFileName = uploadFile.getOriginalFilename();
			System.out.println("원본 파일 명 : " + ogFileName);
			examinationBoardDTO.setOriginalName(ogFileName); //fileStore INSERT용 set
			
			//확장명 추출
			String[] availiableFileTypeList = {".png", ".jpeg", ".jpg", ".bmp", ".tif", ".tiff"};
			String extension = "";
			for(int i = 0; i < availiableFileTypeList.length; i++) {
				if(ogFileName.contains(availiableFileTypeList[i])) {
					extension = availiableFileTypeList[i];
				}
			}
			System.out.println("찾은 확장명 : " + extension);
			
			//저장할 랜덤 파일명 생성
			String savedFileName = UUID.randomUUID().toString() + extension;
			System.out.println("생성한 파일명 : " + savedFileName);
			examinationBoardDTO.setFilestoreId(savedFileName); //fileStoreId(=fileOne) INSERT용 set
			
			//실제  시스템에서 파일 접근하는 경로 설정
			String uploadDir = "C:/MyStudy/Project_Hospital/manager/examinationBoard/";
			File dir = new File(uploadDir); 
			if(!dir.exists()) { //폴더 없으면 만들기
				dir.mkdirs();
			}
			
			String filePath = uploadDir + savedFileName;
			System.out.println("실제 시스템에서 파일 접근하는 경로 + 파일이름 : " + filePath);
			
			//클라이언트에서 파일 접근하는 URL 경로
			//fileStore INSERT용 set (웹 경로 설정)
			String webPath = "/Project_Hospital_uploadedFiles/manager/examinationBoard/" + savedFileName;
			examinationBoardDTO.setFilePath(webPath);
			
			//파일 업로드
			try {
				uploadFile.transferTo(new File(filePath));
				System.out.println("Health 파일 업로드 성공 : " + filePath);
			} catch (Exception e) {
				System.out.println("Health 파일 업로드 실패 ");
				e.printStackTrace();
			}
		}
		System.out.println("쿼리 날리기 전 최종 DTO : " + examinationBoardDTO);
		int result = healthService.insertExaminationBoard(examinationBoardDTO);
		if (result == 1) {
			System.out.println("INSERT 성공 : " + result);
		} else {
			System.out.println("INSERT 실패 : " + result);
			result = -1;
		}
		redirectAttributes.addFlashAttribute("result", result);
 		return "redirect:insertExaminationBoardPage";
	}
	
	//검사, 치료 게시판 UPDATE 페이지 전환
	@GetMapping("/updateExaminationBoardPage")
	public String updateExaminationBoardPage(ExaminationBoardVO examinationBoardVO, Model model) {
		System.out.println("수정하려는 검사 게시글 ID : " + examinationBoardVO.getExaminationId());
		ExaminationBoardDTO examinationBoardDTO = healthService.getExaminationBoardDetail(examinationBoardVO);
        model.addAttribute("dto", examinationBoardDTO);
		return "manager/health/examinationBoard/updateExaminationBoard";
	}
	
	//검사, 치료 게시판 UPDATE
	@PostMapping("/updateExaminationBoard")
	public String updateExaminationBoard(MultipartFile uploadFile, ExaminationBoardDTO examinationBoardDTO, ExaminationBoardVO examinationBoardVO, Model model) {
		System.out.println("수정할 데이터 담은 dto : " +  examinationBoardDTO);
		
		/*
		System.out.println("사진 삭제 요청 확인 : " + examinationBoardDTO.isFileDelete());
		if(examinationBoardDTO.isFileDelete() && uploadFile.getSize() != 0) {
			System.out.println("사진 삭제 요청 O && 파일 업로드 x: " + examinationBoardDTO.isFileDelete());
			//사진 삭제 요청 o -> 업로드 x : mapper에 파일 삭제 추가
			//사진 삭제 요청 x -> 업로드 x : 기존 유지 (파일 업로드함)
			//사진 삭제 요청 o -> 업로드 o : 기존 유지 (파일 업로드 함)
			//사진 삭제 요청 x -> 업로드 o : 기존 유지 (파일 업로드 함)
			int result = healthService.updateExaminationBoardDeleteFile(examinationBoardDTO);
			if (result == 1 ) {
				System.out.println("사진 삭제 + 업데이트 성공 : " + result);
			} else {
				System.out.println("사진 삭제 + 업데이트 실패 : " + result);
			}
			model.addAttribute("result", result);
		}
		*/
		
		//새로운 첨부파일 있는지 없는지 확인
		if(uploadFile.getSize() == 0) {
			System.out.println("파일 업로드 안 함");
			int result = healthService.updateExaminationBoardExceptFile(examinationBoardDTO);
			if (result == 1) {
				System.out.println("파일 제외 업데이트 성공 : " + result);
			} else {
				System.out.println("파일 제외 업데이트 실패 : " + result);
			}
			model.addAttribute("result", result);
				
		} else {
			System.out.println("파일 업로드 함");
			
			String ogFileName = uploadFile.getOriginalFilename();
			System.out.println("원본 파일 명 : " + ogFileName);
			examinationBoardDTO.setOriginalName(ogFileName); //fileStore INSERT용 set
			
			//확장명 추출
			String[] availiableFileTypeList = {".png", ".jpeg", ".jpg", ".bmp", ".tif", ".tiff"};
			String extension = "";
			for(int i = 0; i < availiableFileTypeList.length; i++) {
				if(ogFileName.contains(availiableFileTypeList[i])) {
					extension = availiableFileTypeList[i];
				}
			}
			System.out.println("찾은 확장명 : " + extension);
			
			//저장할 랜덤 파일명 생성
			String savedFileName = UUID.randomUUID().toString() + extension;
			System.out.println("생성한 파일명 : " + savedFileName);
			examinationBoardDTO.setFilestoreId(savedFileName); //fileStoreId(=fileOne) INSERT용 set
			
			//실제 파일 경로 설정
			String uploadDir = "C:/MyStudy/Project_Hospital/manager/examinationBoard/";
			File dir = new File(uploadDir); 
			if(!dir.exists()) { //폴더 없으면 만들기
				dir.mkdirs();
			}
			
			String filePath = uploadDir + savedFileName;
			System.out.println("실제 시스템에서 파일 접근하는 경로 + 파일이름 : " + filePath);
			
			//클라이언트에서 파일 접근하는 URL 경로
			//fileStore INSERT용 set (웹 경로 설정)
			String webPath = "/Project_Hospital_uploadedFiles/manager/examinationBoard/" + savedFileName;
			examinationBoardDTO.setFilePath(webPath);
			
			//파일 업로드
			try {
				uploadFile.transferTo(new File(filePath));
				System.out.println("Health 파일 업로드 성공 : " + filePath);
			} catch (Exception e) {
				System.out.println("Health 파일 업로드 실패 ");
				e.printStackTrace();
				 
			}
			
			System.out.println("파일O 수정 날리기 전 dto 확인 : " + examinationBoardDTO);
			int result = healthService.updateExaminationBoardWithFile(examinationBoardDTO);
			if(result == 1) {
				System.out.println("수정 성공");
			} else {
				System.out.println("수정 실패");
			}
			model.addAttribute("result", result);
		}
		
		return "manager/health/examinationBoard/updateExaminationBoard";
	}
	
	//5. 건강 정보 게시판 
	@GetMapping("/healthBoardManagePage")
	public String healthBoardManagePage(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		
		//총 게시글 개수 (modelAttribute에 칼럼 totalCount 추가함)
		HealthBoardPageDTO healthBoardPageDTO = healthService.getHealthBoardTotalCount();
		model.addAttribute("healthBoardPageDTO", healthBoardPageDTO);
		
		//페이지당 표시할 게시글 수
		int pageSize = 10;
		
		//총 페이지 수 (총 게시글 수 / 페이지당 개수)
		int totalPageCount = (int) Math.ceil((double) healthBoardPageDTO.getTotalCount() / pageSize);
		
		//현재 페이지 유효성 체크
		
		if(page < 1) {
			page = 1;
		} else if (page > totalPageCount) {
			page = totalPageCount;
		}

		model.addAttribute("currentPage", page); //현재 페이지 번호 (기본값 1)
		model.addAttribute("totalPageCount", totalPageCount); //총 페이지 수
		
				
		return "manager/health/healthBoard/healthBoardManage";
		
	}
	
	@GetMapping("/insertHealthBoardPage")
	public String insertHealthBoardPage() {
		System.out.println("건강 게시판 등록 페이지 전환");
		return "manager/health/healthBoard/insertHealthBoard";
	}

	
	@PostMapping("/insertHealthBoard")
	public String insertHealthBoard(MultipartFile uploadFile, HealthBoardDTO healthBoardDTO, RedirectAttributes redirectAttributes) {
		System.out.println("건강 게시글 INSERT : " + healthBoardDTO);
		
		//파일 업로드 안하면 .getSize == 0
		if(uploadFile.getSize() == 0) { //파일 업로드 안 했을때
			System.out.println("파일 업로드 안 함");
		} else { //파일 업로드 하면
			System.out.println("파일 업로드 했음");
			String ogFileName = uploadFile.getOriginalFilename();
			System.out.println("원본 파일 명 : " + ogFileName);
			healthBoardDTO.setOriginalName(ogFileName); //fileStore INSERT용 set
			
			//확장명 추출
			String[] availiableFileTypeList = {".png", ".jpeg", ".jpg", ".bmp", ".tif", ".tiff"};
			String extension = "";
			for(int i = 0; i < availiableFileTypeList.length; i++) {
				if(ogFileName.contains(availiableFileTypeList[i])) {
					extension = availiableFileTypeList[i];
				}
			}
			System.out.println("찾은 확장명 : " + extension);
			
			//저장할 랜덤 파일명 생성
			String savedFileName = UUID.randomUUID().toString() + extension;
			System.out.println("생성한 파일명 : " + savedFileName);
			healthBoardDTO.setFilestoreId(savedFileName); //fileStoreId(=fileOne) INSERT용 set
			
			//실제  시스템에서 파일 접근하는 경로 설정
			String uploadDir = "C:/MyStudy/Project_Hospital/manager/healthBoard/";
			File dir = new File(uploadDir); 
			if(!dir.exists()) { //폴더 없으면 만들기
				dir.mkdirs();
			}
			
			String filePath = uploadDir + savedFileName;
			System.out.println("실제 시스템에서 파일 접근하는 경로 + 파일이름 : " + filePath);
			
			//클라이언트에서 파일 접근하는 URL 경로
			//fileStore INSERT용 set (웹 경로 설정)
			String webPath = "/Project_Hospital_uploadedFiles/manager/healthBoard/" + savedFileName;
			healthBoardDTO.setFilePath(webPath);
			
			//파일 업로드
			try {
				uploadFile.transferTo(new File(filePath));
				System.out.println("Health 파일 업로드 성공 : " + filePath);
			} catch (Exception e) {
				System.out.println("Health 파일 업로드 실패 ");
				e.printStackTrace();
			}
		}
		System.out.println("쿼리 날리기 전 최종 DTO : " + healthBoardDTO);
		int result = healthService.insertHealthBoard(healthBoardDTO);
		if (result == 1) {
			System.out.println("INSERT 성공 : " + result);
		} else {
			System.out.println("INSERT 실패 : " + result);
			result = -1;
		}
		redirectAttributes.addFlashAttribute("result", result);
 		return "redirect:insertHealthBoardPage";
	}
	
	@GetMapping("/updateHealthBoardPage")
	public String updateHealthBoardPage(HealthBoardVO healthBoardVO, Model model) {
		System.out.println("아작스 게시글 수정 실행 : " + healthBoardVO);
		HealthBoardDTO healthDto = healthService.getHealthBoardDetail(healthBoardVO);
		System.out.println("가져온 결과 : " + healthDto);
		model.addAttribute("healthBoardDto", healthDto);
		return "manager/health/healthBoard/updateHealthBoard";
	}
	
	@PostMapping("/updateHealthBoard")
	public String updateHealthBoard(MultipartFile uploadFile, HealthBoardDTO healthBoardDTO, Model model) {
		System.out.println("수정할 데이터 담은 dto : " +  healthBoardDTO);
		
		if(uploadFile.getSize() == 0) {
			System.out.println("파일 업로드 안 함");
			int result = healthService.updateHealthBoardExceptFile(healthBoardDTO);
			if (result == 1) {
				System.out.println("파일 제외 업데이트 성공 : " + result);
			} else {
				System.out.println("파일 제외 업데이트 실패 : " + result);
			}
			model.addAttribute("result", result);
				
		} else {
			System.out.println("파일 업로드 함");
			
			String ogFileName = uploadFile.getOriginalFilename();
			System.out.println("원본 파일 명 : " + ogFileName);
			healthBoardDTO.setOriginalName(ogFileName); //fileStore INSERT용 set
			
			//확장명 추출
			String[] availiableFileTypeList = {".png", ".jpeg", ".jpg", ".bmp", ".tif", ".tiff"};
			String extension = "";
			for(int i = 0; i < availiableFileTypeList.length; i++) {
				if(ogFileName.contains(availiableFileTypeList[i])) {
					extension = availiableFileTypeList[i];
				}
			}
			System.out.println("찾은 확장명 : " + extension);
			
			//저장할 랜덤 파일명 생성
			String savedFileName = UUID.randomUUID().toString() + extension;
			System.out.println("생성한 파일명 : " + savedFileName);
			healthBoardDTO.setFilestoreId(savedFileName); //fileStoreId(=fileOne) INSERT용 set
			
			//실제 파일 경로 설정
			String uploadDir = "C:/MyStudy/Project_Hospital/manager/healthBoard/";
			File dir = new File(uploadDir); 
			if(!dir.exists()) { //폴더 없으면 만들기
				dir.mkdirs();
			}
			
			String filePath = uploadDir + savedFileName;
			System.out.println("실제 시스템에서 파일 접근하는 경로 + 파일이름 : " + filePath);
			
			//클라이언트에서 파일 접근하는 URL 경로
			//fileStore INSERT용 set (웹 경로 설정)
			String webPath = "/Project_Hospital_uploadedFiles/manager/healthBoard/" + savedFileName;
			healthBoardDTO.setFilePath(webPath);
			
			//파일 업로드
			try {
				uploadFile.transferTo(new File(filePath));
				System.out.println("Health 파일 업로드 성공 : " + filePath);
			} catch (Exception e) {
				System.out.println("Health 파일 업로드 실패 ");
				e.printStackTrace();
				 
			}
			
			System.out.println("파일O 수정 날리기 전 dto 확인 : " + healthBoardDTO);
			int result = healthService.updateHealthBoardWithFile(healthBoardDTO);
			if(result == 1) {
				System.out.println("수정 성공");
			} else {
				System.out.println("수정 실패");
			}
			model.addAttribute("result", result);
		}
		
		return "manager/health/healthBoard/updateHealthBoard";
	}

	
	
	
	
	
	

}
