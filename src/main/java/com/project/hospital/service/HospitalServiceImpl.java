package com.project.hospital.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.dao.HospitalDAO;
import com.project.hospital.vo.HospitalVO;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService{
	@Autowired
	private HospitalDAO hospitalDAO;

	@Override
	public List<HospitalVO> hospitalList() {
		return hospitalDAO.hospitalList();
	}
	
	@Override
	public List<HospitalVO> hospitalSearchList() {
		return hospitalDAO.hospitalSearchList();
	}
	
	@Override
	public List<HospitalVO> hospitalSearchListRegion(HospitalVO vo) {
		return hospitalDAO.hospitalSearchListRegion(vo);
	}
	
	@Override
	public List<HospitalVO> hospitalSearchListName(HospitalVO vo) {
		return hospitalDAO.hospitalSearchListName(vo);
	}

	@Override
	public HospitalVO hospitalOne(HospitalVO vo) {
		return hospitalDAO.hospitalOne(vo);
	}

	@Override
	public void hospitalInsert(HospitalVO vo) {
		hospitalDAO.hospitalInsert(vo);
	}

	@Override
	public void hospitalUpdate(HospitalVO vo) {
		hospitalDAO.hospitalUpdate(vo);
	}

	@Override
	public void hospitalDelete(HospitalVO vo) {
		hospitalDAO.hospitalDelete(vo);
	}
	
	@Override
	public void hospitalAccess(HospitalVO vo) {
		hospitalDAO.hospitalAccess(vo);
	}

}
