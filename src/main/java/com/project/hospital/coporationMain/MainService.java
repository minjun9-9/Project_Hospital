package com.project.hospital.coporationMain;

import java.util.List;

import com.project.hospital.dto.ReferralSearchDTO;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HospitalVO;
import com.project.hospital.vo.HpMemberVO;
import com.project.hospital.vo.ReferralVO;
import com.project.hospital.vo.UserVO;

public interface MainService {
	List<HospitalVO> getHospitalList();
	List<UserVO> getUserList();
	List<DeptVO> getDeptList();
	List<DeptVO> getDeptListByHpId(HospitalVO vo);
	List<HpMemberVO> getHpMemberList(DeptVO vo);
	
	List<ReferralVO> getReferralListAll();
	List<ReferralVO> getReferralList(HpMemberVO vo);
	
	List<ReferralVO> getReferralListAll(int begin, int end);
	List<ReferralVO> getReferralList(HpMemberVO vo, int begin, int end, ReferralSearchDTO rsDTO);
	
	List<ReferralVO> getSendReferralList(HpMemberVO vo);
	List<ReferralVO> getSendReferralList(HpMemberVO vo, int begin, int end, ReferralSearchDTO rsDTO);
	
	ReferralVO getReferral(ReferralVO vo);
	void insertReferral(ReferralVO vo);
	void updateReceive(ReferralVO vo);
	
	int getSendReferCnt(HpMemberVO vo, ReferralSearchDTO rsDTO);
	/* int getSendReferCntAll(); */
	
	int getReferCnt(HpMemberVO vo, ReferralSearchDTO rsDTO);
	int getReferCntAll();
}
