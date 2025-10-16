package com.project.hospital.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.dao.OpeningTimeTableDAO;
import com.project.hospital.dto.OpeningTimeTableDTO;
import com.project.hospital.vo.OpeningTimeVO;
import com.project.hospital.vo.ReservationVO;

@Service("openingTimeTableService")
public class OpeningTimeTableServiceImpl implements OpeningTimeTableService{
	@Autowired
	private OpeningTimeTableDAO openingTimeTableDAO;

	@Override
	public List<OpeningTimeTableDTO> openingTimeTableList(OpeningTimeVO vo) {
		return openingTimeTableDAO.openingTimeTableList(vo);
	}
	
	@Override
	public List<OpeningTimeTableDTO> openingTimeTablereservationList(ReservationVO vo) {
		return openingTimeTableDAO.openingTimeTablereservationList(vo);
	}
	
	@Override
	public OpeningTimeTableDTO openingTimeTableOne(OpeningTimeVO vo) {
		return openingTimeTableDAO.openingTimeTableOne(vo);
	}

}
