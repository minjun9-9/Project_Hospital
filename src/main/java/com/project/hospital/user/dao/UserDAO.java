package com.project.hospital.user.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.dto.ReservationDTO;
import com.project.hospital.user.UserDoubleVO;
import com.project.hospital.vo.RecordVO;

@Repository
public class UserDAO {
    @Autowired
    private SqlSessionTemplate mybatis;

    public UserDAO() {
        System.out.println(">> UserDAO() 객체 생성");
    }

    public UserDAO(SqlSessionTemplate mybatis) {
        System.out.println(">> UserDAO(SqlSessionTemplate) 객체 생성");
        this.mybatis = mybatis;
    }

    // 사용자 정보 조회 메서드
    public UserDoubleVO getUser(UserDoubleVO vo) {
        System.out.println("===> MyBatis 사용 getUser() 실행");
        return mybatis.selectOne("userDAO.getUser", vo);
    }
    
    // 회원 로그인
    public UserDoubleVO loginUser(UserDoubleVO vo) {
    	System.out.println("===> MyBatis 사용 loginUser() 실행");
    	return mybatis.selectOne("userDAO.loginUser", vo);
    }
    
    // 아이디 중복 확인
    public UserDoubleVO getUserById(String userId) {
    	return mybatis.selectOne("userDAO.getUserById", userId);
    }
    
    // 14세 이상 회원등록
    public void insertAdultUser(UserDoubleVO vo) {
    	System.out.println("===> MyBatis 사용 insertAdultUser() 실행");
    	mybatis.insert("userDAO.insertAdultUser", vo);
    }
    
    // 14세 미만 회원등록
    public void insertYouthUser(UserDoubleVO vo) {
        System.out.println("===> MyBatis 사용 insertYouthUser() 실행");
        mybatis.insert("userDAO.insertYouthUser", vo);
    }
    
    // 회원 기본정보 가져오기
    public UserDoubleVO getUserInfo(int userNum) {
    	System.out.println("===> MyBatis 사용 getUserInfo() 실행");
    	return mybatis.selectOne("userDAO.getUserInfo", userNum);
    }
    
    // 회원 예약 현황 가져오기
    public ReservationDTO getReservationHistory(int userNum) {
    	System.out.println("===> MyBatis 사용 getReservationHistory() 실행");
    	return mybatis.selectOne("userDAO.getReservationHistory", userNum);
    }
    
    // 회원 진료 현황 가져오기
    public RecordVO getRecordHistory(int userNum) {
    	System.out.println("===> MyBatis 사용 getRecordHistory() 실행");
    	return mybatis.selectOne("userDAO.getRecordHistory", userNum);
    }
    
    // 아이디 찾기(휴대폰)
    public String findIdByPhoneNum(String userName, String userPhoneNum) {
    	System.out.println("===> MyBatis 사용 findIdByPhoneNum() 실행");
    	
    	Map<String, String> paramMap = new HashMap<String, String>();
    	paramMap.put("userName", userName);
    	paramMap.put("userPhoneNum", userPhoneNum);
    	return mybatis.selectOne("userDAO.findIdByPhoneNum", paramMap);
    }
    
    // 아이디 찾기(이메일)
    public String findIdByEmail(String userName, String userEmail) {
    	System.out.println("===> MyBatis 사용 findIdByEmail() 실행");
    	
    	Map<String, String> paramMap = new HashMap<String, String>();
    	paramMap.put("userName", userName);
    	paramMap.put("userPhoneNum", userEmail);
    	return mybatis.selectOne("userDAO.findIdByPhoneNum", paramMap);
    }
    
    // 비밀번호 찾기(휴대폰)
    public String findPwByPhoneNum(String userId, String userName, String userPhoneNum) {
    	System.out.println("===> MyBatis 사용 findPwByPhoneNum() 실행");
    	
    	Map<String, String> paramMap = new HashMap<String, String>();
    	paramMap.put("userId", userId);
    	paramMap.put("userName", userName);
    	paramMap.put("userPhoneNum", userPhoneNum);
    	return mybatis.selectOne("userDAO.findIdByPhoneNum", paramMap);
    }
    
    // 비밀번호 찾기(이메일)
    public String findPwByEmail(String userId, String userName, String userEmail) {
    	System.out.println("===> MyBatis 사용 findPwByEmail() 실행");
    	
    	Map<String, String> paramMap = new HashMap<String, String>();
    	paramMap.put("userId", userId);
    	paramMap.put("userName", userName);
    	paramMap.put("userEmail", userEmail);
    	return mybatis.selectOne("userDAO.findIdByPhoneNum", paramMap);
    }
    
    public String getPasswordById(String userId) {
    	return mybatis.selectOne("userDAO.getPasswordById", userId);
    }
    
	public void updateUser(UserDoubleVO vo) {
		System.out.println("===> MyBatis 사용 updateUser() 실행");
		mybatis.update("userDAO.updateUser", vo);
	}

	public void updateUserPassword(UserDoubleVO vo) {
		System.out.println("===> MyBatis 사용 updateUserPassword() 실행");
		mybatis.update("userDAO.updateUserPassword", vo);
	}

	public void deleteUser(String userId) {
		System.out.println("===> MyBatis 사용 updateUserPassword() 실행");
		mybatis.delete("userDAO.deleteUser", userId);
	}

	public void deleteUserRecords(String userId) {
		
	}
    
}
