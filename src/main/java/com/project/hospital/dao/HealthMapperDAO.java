package com.project.hospital.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface HealthMapperDAO {
	Map<String, Integer> getHealthCnt(Map<String, String> map);

}
