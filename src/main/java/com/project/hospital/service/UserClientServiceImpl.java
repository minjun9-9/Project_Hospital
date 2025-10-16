package com.project.hospital.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.dao.UserClientDAO;
import com.project.hospital.vo.ReservationVO;
import com.project.hospital.vo.UserClientVO;

@Service("userClientService")
public class UserClientServiceImpl implements UserClientService{
	@Autowired
	private UserClientDAO userClientDAO;

	@Override
	public UserClientVO userClientOne(ReservationVO vo) {
		return userClientDAO.userClientOne(vo);
	}

}
