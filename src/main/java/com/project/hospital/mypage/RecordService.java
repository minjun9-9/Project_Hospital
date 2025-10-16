package com.project.hospital.mypage;

import java.util.List;

import com.project.hospital.common.Paging;
import com.project.hospital.mypage.dto.RequestRecordDTO;
import com.project.hospital.mypage.dto.ResponseRecordDTO;

public interface RecordService {
	
	public Paging pageSet(RequestRecordDTO requestDTO);
	public List<ResponseRecordDTO> findRecordListForPage(int begin, int end, RequestRecordDTO requestDTO);

}
