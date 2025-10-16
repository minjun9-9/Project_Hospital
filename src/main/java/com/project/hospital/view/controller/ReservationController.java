package com.project.hospital.view.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.hospital.admin.DeptService;
import com.project.hospital.admin.HpMemberService;
import com.project.hospital.dto.HpMemberDeptDTO;
import com.project.hospital.dto.OpeningTimeTableDTO;
import com.project.hospital.reserve.ReservationService;
import com.project.hospital.reserve.opening.OpeningTimeService;
import com.project.hospital.service.HpMemberDeptService;
import com.project.hospital.service.OpeningTimeTableService;
import com.project.hospital.service.UserClientService;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HospitalVO;
import com.project.hospital.vo.HpMemberVO;
import com.project.hospital.vo.ReservationVO;
import com.project.hospital.vo.UserClientVO;

@Controller
@RequestMapping("reservation")
public class ReservationController {
	@Autowired
	private DeptService deptService;
	@Autowired
	private OpeningTimeTableService openingTimeTableService;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private HpMemberService hpMemberService;
	@Autowired
	private OpeningTimeService openingTimeService;
	@Autowired
	private UserClientService userClientService;
	@Autowired
	private HpMemberDeptService hpMemberDeptService;

	@RequestMapping("/deptList")
	public String deptList(Model model, HospitalVO vo){
		List<DeptVO> deptList = deptService.deptlList(vo);
		
		model.addAttribute("deptList",deptList);
		
		return "reservation/deptList";
	}
	
	@RequestMapping("/hpMemberList")
	public String hpMemberList(Model model, DeptVO vo){
		List<HpMemberVO> hpMemberList = hpMemberService.hpMemberSearchList(vo);
		
		model.addAttribute("hpMemberList",hpMemberList);
		
		return "reservation/hpMemberList";
	}
	
	@RequestMapping("/reservationList")
	public String reservationList(Model model, ReservationVO vo){
		List<ReservationVO> reservationList = reservationService.reservationList(vo);
		List<HpMemberDeptDTO> hpMemberDeptList = hpMemberDeptService.hpMemberDeptList(vo);
		List<OpeningTimeTableDTO> openingTimeTablereservationList = openingTimeTableService.openingTimeTablereservationList(vo);
		UserClientVO userClientOne = userClientService.userClientOne(vo);
		System.out.println("userClientOne(진료조회시 조회) : " +userClientOne);
		System.out.println("hpMemberDeptList(진료조회시 조회) : " +hpMemberDeptList);
		System.out.println("reservationList(진료조회시 조회) : " +reservationList);
		System.out.println("openingTimeTablereservationList(진료조회시 조회) : " +openingTimeTablereservationList);
		model.addAttribute("reservationList",reservationList);
		model.addAttribute("hpMemberDeptList",hpMemberDeptList);
		model.addAttribute("openingTimeTablereservationList",openingTimeTablereservationList);
		model.addAttribute("userClientOne",userClientOne);
		
		return "reservation/reservationList";
	}
	
	@GetMapping("/reservationInsert")
	public String reservationInsertPage(Model model, HospitalVO vo, ReservationVO vor){
		UserClientVO userClientOne = userClientService.userClientOne(vor);
		List<DeptVO> deptList = deptService.deptlList(vo);
		
		model.addAttribute("userClientOne",userClientOne);
		model.addAttribute("deptList",deptList);
		
		return "reservation/reservationInsert";
	}
	
	@PostMapping("/reservationInsert")
	public String reservationInsert(ReservationVO vo, HttpSession session){
		reservationService.reservationInsert(vo);
		openingTimeService.openingTimeImpossibleUpdate(vo.getOtId());
		
		session.setAttribute("message", "예약이 완료되었습니다.");
		
		return "redirect:../index.jsp";
	}
	
	@RequestMapping("/reservationDelete")
	public String reservationDelete(ReservationVO vo, HttpSession session){
		reservationService.reservationDelete(vo);
		openingTimeService.openingTimePossibleUpdate(vo.getOtId());
		
		session.setAttribute("message", "예약이 취소되었습니다.");
		
		return "redirect:../index.jsp";
	}
	
}
