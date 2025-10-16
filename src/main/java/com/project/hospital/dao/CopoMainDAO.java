package com.project.hospital.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.hospital.dto.ReferralSearchDTO;
import com.project.hospital.vo.DeptVO;
import com.project.hospital.vo.HospitalVO;
import com.project.hospital.vo.HpMemberVO;
import com.project.hospital.vo.ReferralVO;
import com.project.hospital.vo.UserVO;

@Repository
public class CopoMainDAO {
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public CopoMainDAO() {
		System.out.println("MainDAO()");
	}

	public CopoMainDAO(SqlSessionTemplate mybatis) {
		System.out.println("MainDAO(mybatis)");
		this.mybatis = mybatis;
	}
	
	
	//병원 전체 리스트
	public List<HospitalVO> getHospitalList(){
		List<HospitalVO> list = null;
		
		list = mybatis.selectList("mainDAO.getHospitalList");
		
		return list;
	}
	
	//유저 전체 리스트
	public List<UserVO> getUserList(){
		List<UserVO> list = null;
		
		list = mybatis.selectList("mainDAO.getUserList");
		
		return list;
	}
	
	//진료과 전체 조회
	public List<DeptVO> getDeptList(){
		List<DeptVO> list = null;

		list = mybatis.selectList("mainDAO.getDeptList");
		
		return list;
	}
	
	//진료과 병원ID로 조회
	public List<DeptVO> getDeptListByHpId(HospitalVO vo){
		List<DeptVO> list = null;

		list = mybatis.selectList("mainDAO.getDeptListByHpId", vo.getHpId());
		
		return list;
	}
	
	//의사 진료과ID로 조회
	public List<HpMemberVO> getHpMemberList(DeptVO vo){
		List<HpMemberVO> list = null;
		
		list = mybatis.selectList("mainDAO.getHpMemberList", vo.getDeptId());
		
		return list;
	}
	
	//진료의뢰 전체 조회
	public List<ReferralVO> getReferralListAll(){
		List<ReferralVO> list = null;

		list = mybatis.selectList("mainDAO.getReferralListAll");
		
		return list;
	}
	
	//진료의뢰 전체 조회(페이징)
	public List<ReferralVO> getReferralListAll(int begin, int end){
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("begin", begin);
		map.put("end", end);
		
		List<ReferralVO> list = null;

		list = mybatis.selectList("mainDAO.getReferralListAll", map);
		
		return list;
	}

	//진료의뢰 의사id로 조회
	public List<ReferralVO> getReferralList(HpMemberVO vo){
		List<ReferralVO> list = null;

		list = mybatis.selectList("mainDAO.getReferralList", vo.getDrId());
		
		return list;
	}
	
	//진료의뢰 의사id로 조회(page)
	public List<ReferralVO> getReferralList(HpMemberVO vo, int begin, int end, ReferralSearchDTO rsDTO){
		System.out.println("getReferralList 시작 ");
		System.out.println("vo : "+vo);
		System.out.println("begin : "+begin);
		System.out.println("end : "+end);
		System.out.println("drId : "+vo.getDrId());
		System.out.println("keyword : "+rsDTO.getSearchKeyword());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", begin);
		map.put("end", end);
		map.put("drId", vo.getDrId());
		map.put("searchKeyword", rsDTO.getSearchKeyword());
		
		List<ReferralVO> list = null;

		list = mybatis.selectList("mainDAO.getReferralList", map);
		
		return list;
	}
	
	//보낸 진료의뢰 의사id로 조회
	public List<ReferralVO> getSendReferralList(HpMemberVO vo){
		
		List<ReferralVO> list = null;

		list = mybatis.selectList("mainDAO.getSendReferralList", vo.getDrId());
		
		return list;
	}
	
	//보낸 진료의뢰 의사id로 조회(page)
	public List<ReferralVO> getSendReferralList(HpMemberVO vo, int begin, int end, ReferralSearchDTO rsDTO){
		System.out.println("getSendReferralList 시작 ");
		System.out.println("vo : "+vo);
		System.out.println("begin : "+begin);
		System.out.println("end : "+end);
		System.out.println("drId : "+vo.getDrId());
		System.out.println("keyword : "+rsDTO.getSearchKeyword());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", begin);
		map.put("end", end);
		map.put("drId", vo.getDrId());
		map.put("searchKeyword", rsDTO.getSearchKeyword());
		
		List<ReferralVO> list = null;

		list = mybatis.selectList("mainDAO.getSendReferralList", map);
		
		return list;
	}
	
	//진료의뢰 상세 조회
	public ReferralVO getReferral(ReferralVO vo) {
		System.out.println("DAO getReferral 시작 vo :"+vo);
		ReferralVO referral = null;
		
		referral = mybatis.selectOne("mainDAO.getReferral", vo.getReferId());
		
		return referral;
	}
	
	//진료의뢰서 작성
	public void insertReferral(ReferralVO vo) {
		System.out.println("DAO insertReferral 시작 vo : "+vo);
		
		mybatis.insert("mainDAO.insertReferral", vo);
		
	}
	
	
	
	public void updateReceive(ReferralVO vo) {
		System.out.println("DAO updateReceive시작 vo :"+vo);
		
		/*
		 * if("cancel".equals(vo.getReceiveChk())) {
		 * mybatis.update("mainDAO.cancelReceive"); } else {
		 * mybatis.update("mainDAO.updateReceive", vo); }
		 */
		
		mybatis.update("mainDAO.updateReceive", vo);
	}
	
	//보낸 진료의뢰 갯수
	public int getSendReferCnt(HpMemberVO vo, ReferralSearchDTO rsDTO) {
		System.out.println("vo : "+vo );
		System.out.println("rsDTO : "+rsDTO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("drId", vo.getDrId());
		map.put("searchKeyword", rsDTO.getSearchKeyword());
		
		return mybatis.selectOne("mainDAO.getSendReferCnt", map);
	}
	
	/*
	 * //보낸 진료의뢰 전체 갯수 public int getSendReferCntAll() { return
	 * mybatis.selectOne("mainDAO.getSendReferCntAll"); }
	 */
	
	//받은 진료의뢰 갯수
	public int getReferCnt(HpMemberVO vo, ReferralSearchDTO rsDTO) {
		System.out.println("vo : "+vo );
		System.out.println("rsDTO : "+rsDTO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("drId", vo.getDrId());
		map.put("searchKeyword", rsDTO.getSearchKeyword());
		
		return mybatis.selectOne("mainDAO.getReferCnt", map);
	}
	
	//진료의뢰 전체 갯수
	public int getReferCntAll() {
		return mybatis.selectOne("mainDAO.getReferCntAll");
	}
	
	
}
