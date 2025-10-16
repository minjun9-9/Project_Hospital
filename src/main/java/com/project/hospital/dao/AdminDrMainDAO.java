package com.project.hospital.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminDrMainDAO {

	Map<String, Integer> getAllBoardCnt(Map<String, String> createDateMapper);

}
