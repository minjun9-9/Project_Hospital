package com.project.hospital.search.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.doctorInfo.DoctorInfoCntDTO;
import com.project.hospital.search.QnaSearchDTO;
import com.project.hospital.search.SearchService;

// @Service : @Component 상속확장 어노테이션
// 		비즈니스 로직 처리 서비스 영역에 사용
@Service("searchService")
public class SearchSerivceImpl implements SearchService {

	@Autowired
	private SearchDAO searchDAO;
	
	
	
	public SearchSerivceImpl() {
		System.out.println("SearchSerivceImpl() 객체생성");
	}



	@Override
	public List<QnaSearchDTO> searchQnA(String query) {
		return searchDAO.searchQnA(query);
	}

	@Override
	public List<DoctorInfoCntDTO> searchDoctors(String query) {
		return searchDAO.searchDoctors(query);
	}

	@Override
	public int countQnA(String query) {
		return searchDAO.countQnA(query);
	}
	
	@Override
	public int countDoctors(String query) {
		return searchDAO.countDoctors(query);
	}






}
