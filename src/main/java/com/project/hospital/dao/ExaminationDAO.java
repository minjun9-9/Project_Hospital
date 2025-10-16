package com.project.hospital.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ExaminationDAO {

	Map<String, Integer> getExamCnt(Map<String, String> map);

}
