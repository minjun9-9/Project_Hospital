package com.project.hospital.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DiseaseDAO {

	Map<String, Integer> getDiseaseCnt(Map<String, String> map);

}
