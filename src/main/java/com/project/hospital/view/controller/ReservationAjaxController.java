package com.project.hospital.view.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.hospital.admin.HpMemberService;
import com.project.hospital.dto.OpeningTimeTableDTO;
import com.project.hospital.dto.ReservationDTO;
import com.project.hospital.reserve.ReservationService;
import com.project.hospital.reserve.opening.OpeningTimeService;
import com.project.hospital.service.OpeningTimeTableService;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HpMemberVO;
import com.project.hospital.vo.OpeningTimeVO;
import com.project.hospital.vo.ReservationVO;

@RestController
@RequestMapping("reservation")
public class ReservationAjaxController {
	@Autowired
	private OpeningTimeTableService openingTimeTableService;
	@Autowired
	private HpMemberService hpMemberService;
	@Autowired
	private OpeningTimeService openingTimeService;
	@Autowired
	private ReservationService reservationService;
	
	@PostMapping("/hpMemberSearchListJson")
	public List<HpMemberVO> hpMemberSearchList(@RequestBody DeptVO vo){
		List<HpMemberVO> hpMemberList = hpMemberService.hpMemberSearchList(vo);
		
		return hpMemberList;
	}
	
	@PostMapping("/openingTimeListJson")
	public List<String> openingTimeList(@RequestBody OpeningTimeVO vo){
		List<String> openingTimeList = openingTimeService.openingTimeList(vo);
		
		return openingTimeList;
	}
	
	@PostMapping("/openingTimeTableListJson")
	public List<OpeningTimeTableDTO> openingTimeTableList(@RequestBody OpeningTimeVO vo){
		List<OpeningTimeTableDTO> openingTimeTableList = openingTimeTableService.openingTimeTableList(vo);
		
		return openingTimeTableList;
	}
	
	@PostMapping("/reservationInsertCheckJson")
	public ReservationVO reservationInsertCheck(@RequestBody ReservationDTO dto){
		ReservationVO rvo = null;
		ReservationVO vo = reservationService.reservationInsertCheck(dto);
		
		if(vo == null) {
			rvo = new ReservationVO();
			rvo.setReservId("예약진행");
		}
		return rvo;
	}
	
	@PostMapping("/reservationInsertJson")
	public OpeningTimeTableDTO reservationInsert(@RequestBody OpeningTimeVO vo){
		OpeningTimeTableDTO openingTimeTableOne = openingTimeTableService.openingTimeTableOne(vo);
		
		return openingTimeTableOne;
	}
	
	
	
}
