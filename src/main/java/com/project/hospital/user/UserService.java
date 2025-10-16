package com.project.hospital.user;

import com.project.hospital.dto.ReservationDTO;
import com.project.hospital.vo.RecordVO;

public interface UserService {
	
	// 로그인 관련
	UserDoubleVO loginUser(UserDoubleVO vo);
	
	// 회원가입 관련
	boolean checkUserId(String userId);
	void insertAdultUser(UserDoubleVO vo);
	void insertYouthUser(UserDoubleVO vo);
	
	// 회원찾기 관련
	String findIdByPhoneNum(String userName, String userPhoneNum);
	String findIdByEmail(String userName, String userEmail);
	String findPwByPhoneNum(String userId, String userName, String userPhoneNum);
	String findPwByEmail(String userId, String userName, String userEmail);
	
	// 회원마이페이지 관련
	UserDoubleVO getUserInfo(int userNum);
	ReservationDTO getReservationHistory(int userNum);
	RecordVO getRecordHistory(int userNum);
	
	boolean checkPassword(String userId, String userPw);
	void updateUser(UserDoubleVO vo);
	boolean updatePassword(String userId, String currentPassword, String newPassword);
	boolean deleteUser(String userId, String inputPassword);
	
	
}
