package com.project.hospital.coporationMain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.hospital.dao.CopoMainDAO;
import com.project.hospital.dto.ReferralSearchDTO;
import com.project.hospital.vo.UserVO;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HospitalVO;
import com.project.hospital.vo.HpMemberVO;
import com.project.hospital.vo.ReferralVO;

@Service("mainService")
public class MainServiceImpl implements MainService {
	
	@Autowired
	private CopoMainDAO mainDAO;
	
	public MainServiceImpl() {
		System.out.println("MainServiceImpl() 시작");
	}

	@Override
	public List<HospitalVO> getHospitalList() {
		
		return mainDAO.getHospitalList();
	}

	@Override
	public List<UserVO> getUserList() {
		
		return mainDAO.getUserList();
	}

	@Override
	public List<DeptVO> getDeptList() {
		return mainDAO.getDeptList();
	}

	@Override
	public List<ReferralVO> getReferralListAll() {
		return mainDAO.getReferralListAll();
	}

	@Override
	public ReferralVO getReferral(ReferralVO vo) {
		return mainDAO.getReferral(vo);
	}

	@Override
	public List<DeptVO> getDeptListByHpId(HospitalVO vo) {
		return mainDAO.getDeptListByHpId(vo);
	}

	@Override
	public List<HpMemberVO> getHpMemberList(DeptVO vo) {
		return mainDAO.getHpMemberList(vo);
	}

	

	@Override
	public void insertReferral(ReferralVO vo) {
		mainDAO.insertReferral(vo);
	}

	
	@Override
	public List<ReferralVO> getSendReferralList(HpMemberVO vo) {
		return mainDAO.getSendReferralList(vo);
	}
	
	@Override
	public List<ReferralVO> getReferralList(HpMemberVO vo) {
		return mainDAO.getReferralList(vo);
	}
	
	@Override
	public List<ReferralVO> getReferralList(HpMemberVO vo, int begin, int end, ReferralSearchDTO rsDTO) {
		return mainDAO.getReferralList(vo, begin, end, rsDTO);
	}
	
	@Override
	public List<ReferralVO> getSendReferralList(HpMemberVO vo, int begin, int end, ReferralSearchDTO rsDTO) {
		
		return mainDAO.getSendReferralList(vo, begin, end, rsDTO);
	}
	

	@Override
	public void updateReceive(ReferralVO vo) {
		mainDAO.updateReceive(vo);
	}

	@Override
	public int getSendReferCnt(HpMemberVO vo, ReferralSearchDTO rsDTO) {
		return mainDAO.getSendReferCnt(vo, rsDTO);
	}

	
	@Override
	public int getReferCnt(HpMemberVO vo, ReferralSearchDTO rsDTO) {
		return mainDAO.getReferCnt(vo, rsDTO);
	}

	@Override
	public int getReferCntAll() {
		return mainDAO.getReferCntAll();
	}

	@Override
	public List<ReferralVO> getReferralListAll(int begin, int end) {
		return mainDAO.getReferralListAll(begin, end);
	}

	


	

	

	


}
