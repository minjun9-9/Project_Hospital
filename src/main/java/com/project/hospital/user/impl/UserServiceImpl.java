package com.project.hospital.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.dto.ReservationDTO;
import com.project.hospital.user.UserService;
import com.project.hospital.user.UserDoubleVO;
import com.project.hospital.user.dao.UserDAO;
import com.project.hospital.vo.RecordVO;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDAO userDAO;
	
	@Override
	public boolean checkUserId(String userId) {
		return userDAO.getUserById(userId) != null;
	}
	
	@Override
	public void insertAdultUser(UserDoubleVO vo) {
		userDAO.insertAdultUser(vo);
		
	}

	@Override
	public void insertYouthUser(UserDoubleVO vo) {
		userDAO.insertYouthUser(vo);
	}

	@Override
	public UserDoubleVO loginUser(UserDoubleVO vo) {
		return userDAO.getUser(vo);
	}

	@Override
	public UserDoubleVO getUserInfo(int userNum) {
		return userDAO.getUserInfo(userNum);
	}

	@Override
	public ReservationDTO getReservationHistory(int userNum) {
		return userDAO.getReservationHistory(userNum);
	}

	@Override
	public RecordVO getRecordHistory(int userNum) {
		return userDAO.getRecordHistory(userNum);
	}
	
	@Override
	public String findIdByPhoneNum(String userName, String userPhoneNum) {
		return userDAO.findIdByPhoneNum(userName, userPhoneNum);
	}

	@Override
	public String findIdByEmail(String userName, String userEmail) {
		return userDAO.findIdByPhoneNum(userName, userEmail);
	}

	@Override
	public String findPwByPhoneNum(String userId, String userName, String userPhoneNum) {
		return userDAO.findPwByPhoneNum(userId, userName, userPhoneNum);
	}

	@Override
	public String findPwByEmail(String userId, String userName, String userEmail) {
		return userDAO.findPwByEmail(userId, userName, userEmail);
	}

	@Override
	public boolean checkPassword(String userId, String userPw) {
		String storedPassword = userDAO.getPasswordById(userId);
		return storedPassword.equals(userPw);
	}
	
	@Override
	public void updateUser(UserDoubleVO vo) {
		userDAO.updateUser(vo);
	}

	@Override
	public boolean updatePassword(String userId, String currentPassword, String newPassword) {
        UserDoubleVO user = userDAO.getUserById(userId);
        if (user != null && user.getUserPw().equals(currentPassword)) {
            user.setUserPw(newPassword);
            userDAO.updateUserPassword(user);
            return true;
        }
        return false;
	}

	@Override
	public boolean deleteUser(String userId, String inputPassword) {
	    UserDoubleVO user = userDAO.getUserById(userId);
	    if (user != null && user.getUserPw().equals(inputPassword)) {
	        try {
	            userDAO.deleteUserRecords(userId);  // 관련 데이터 삭제
	            userDAO.deleteUser(userId);
	            return true;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	    return false;
	}

	





}
