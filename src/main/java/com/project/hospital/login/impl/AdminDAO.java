package com.project.hospital.login.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.login.AdminVO;
import com.project.hospital.login.dto.AdminDTO;
import com.project.hospital.vo.HpMemberVO;


@Repository
public class AdminDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public AdminDAO() {
		System.out.println("AdminDAO() ");
	}

	public AdminDAO(SqlSessionTemplate mybatis) {
		System.out.println("AdminDAO(mybatis) 시작");
		this.mybatis = mybatis;
	}
	
	public AdminVO getUser(AdminDTO admin) {
		System.out.println("===> MyBatis 사용 getUser(vo) 실행");
		System.out.println(admin);
		
		AdminVO adminVO = new AdminVO();
		try {
			//user = jdbcTemplate.queryForObject(USER_GET, new UserRowMapper(), vo.getId(), vo.getPassword());
			
			adminVO = mybatis.selectOne("adminDAO.getUser", admin);
			
			return adminVO;
			
		}catch (Exception e) {
			System.out.println("로그인 실패");
			return null;
		}
		
	}
	
	public HpMemberVO getHpMember(AdminDTO admin) {
		System.out.println("===> MyBatis 사용 getHpMember(vo) 실행");
		System.out.println(admin);
		
		//AdminVO adminVO = new AdminVO();
		HpMemberVO hpMemberVO = new HpMemberVO();
		try {
			//user = jdbcTemplate.queryForObject(USER_GET, new UserRowMapper(), vo.getId(), vo.getPassword());
			
			hpMemberVO = mybatis.selectOne("adminDAO.getHpMember", admin);
			
			return hpMemberVO;
			
		}catch (Exception e) {
			System.out.println("로그인 실패");
			return null;
		}
		
	}
	
	
}
