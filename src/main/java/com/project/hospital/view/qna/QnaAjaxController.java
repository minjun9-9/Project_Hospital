package com.project.hospital.view.qna;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.hospital.qna.QnaService;
import com.project.hospital.qna.dto.QnaDTO;

@RestController
@RequestMapping("qna")
public class QnaAjaxController {
	
	private QnaService qnaService;

	@Autowired
	public QnaAjaxController(QnaService qnaService) {
		this.qnaService = qnaService;
	}
	
	@PostMapping("/deleteQna")
	public void deleteQna(@RequestBody QnaDTO dto) {
		 System.out.println("ajax 이놈자슥 실행 : " + dto.getQnaIds());
		 qnaService.deleteQna(dto);
	}
	

}


