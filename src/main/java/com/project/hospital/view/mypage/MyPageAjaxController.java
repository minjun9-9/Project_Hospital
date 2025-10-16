package com.project.hospital.view.mypage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.project.hospital.common.Paging;
import com.project.hospital.common.Result;
import com.project.hospital.common.ResultPage;
import com.project.hospital.mypage.RecordService;
import com.project.hospital.mypage.dto.RequestRecordDTO;
import com.project.hospital.mypage.dto.ResponseRecordDTO;
import com.project.hospital.reserve.dto.ReservRequestDTO;
import com.project.hospital.reserve.dto.ReserveResponDTO;
import com.project.hospital.reserve.userSchedule.UserScheduleService;

@RestController
public class MyPageAjaxController {
	
	private final UserScheduleService userScheduleService;
	private final RecordService recordService;
	
	@Autowired
	public MyPageAjaxController(UserScheduleService userScheduleService, RecordService recordService) {
		super();
		this.userScheduleService = userScheduleService;
		this.recordService = recordService;
	}

	/**
	 * 고객의 진료 스케줄 조회
	 */
	@PostMapping("/mypage/findSchedule")
	public Result<List<ReserveResponDTO>> findMedicalSchedule(@RequestBody ReservRequestDTO requestDto) {
		
		List<ReserveResponDTO> list = userScheduleService.findMedicalSchedule(requestDto);
		
		return new Result<List<ReserveResponDTO>>(list, list.size());
	}
	

	/**
	 * 고객의 과거진료기록 조회
	 */
	@PostMapping("/mypage/findRecord")
	public ResultPage<List<ResponseRecordDTO>> findRecordListForPage(@RequestBody RequestRecordDTO requestDTO){
		
		Paging p = recordService.pageSet(requestDTO);
		List<ResponseRecordDTO> list = recordService.findRecordListForPage(p.getBegin(), p.getEnd(), requestDTO);
		
		return new ResultPage<List<ResponseRecordDTO>>(list, list.size(), p);
	}
	


}
