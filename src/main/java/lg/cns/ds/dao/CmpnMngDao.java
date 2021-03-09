package lg.cns.ds.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lg.cns.ds.domain.Domain;
import lg.cns.ds.domain.UIMng;
import lg.cns.ds.domain.User;
import lg.cns.ds.domain.UICmpnMng;
import lg.cns.ds.dto.JqGridRequest;
import lg.cns.ds.domain.CmpnMngSearchCnd;
import lg.cns.ds.domain.CmpnVldtRsltHst;

@Repository
public class CmpnMngDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<UIMng> getUItoolList(User oCurrentUser, int offset, int limit, CmpnMngSearchCnd cnd) {
		Map<String , Object> params = new HashMap<String , Object>();
		
		params.put("offset", offset);
		params.put("limit",limit);
		params.put("username", oCurrentUser.getUsername());
		params.put("dateStart", cnd.getDateStart());
		params.put("dateEnd", cnd.getDateEnd());
		params.put("selected_uitool", cnd.getSelected_uitool());
		
		List<UIMng> UItool = null;
		
		UItool = sqlSession.selectList("lg.cns.ds.mapper.cmpnMngMapper.selectUItoolList", params);
		
		if (UItool == null) {
			UItool = new ArrayList<UIMng>();
		}
		return UItool;
	}

	public int getRecordCount(CmpnMngSearchCnd cnd) {
		Map<String , Object> params = new HashMap<String , Object>();
		
		params.put("dateStart", cnd.getDateStart());
		params.put("dateEnd", cnd.getDateEnd());
		params.put("selected_uitool", cnd.getSelected_uitool());
		
		int iResult = 0;
		
		iResult = sqlSession.selectOne("lg.cns.ds.mapper.cmpnMngMapper.selectCount", params);
		
		return iResult;
	}
	
	public int getCmpnRecordCount(String uiCd) {
		Map<String , Object> params = new HashMap<String , Object>();
		
		params.put("uiCd", uiCd);
		
		int iResult = 0;
		
		iResult = sqlSession.selectOne("lg.cns.ds.mapper.cmpnMngMapper.selectCmpnCount", params);
				
		return iResult;
	}
	
	public List<UICmpnMng> getCmpnList(User oCurrentUser, int offset, int limit, String uiCd) {
		Map<String , Object> params = new HashMap<String , Object>();
		
		params.put("offset", offset);
		params.put("limit",limit);
		params.put("username", oCurrentUser.getUsername());
		params.put("uiCd", uiCd);
		
		List<UICmpnMng> cmpnList = null;
		
		cmpnList = sqlSession.selectList("lg.cns.ds.mapper.cmpnMngMapper.selectCmpnList", params);
		
		if (cmpnList == null) {
			cmpnList = new ArrayList<UICmpnMng>();
		}
		return cmpnList;
	}
	
	//비교대상 컴포넌트 및 속성 조회
	public List<CmpnVldtRsltHst> getCmprCmpnPrptyList() {
				
		List<CmpnVldtRsltHst> cmprCmpnPrptyList = null;
		
		cmprCmpnPrptyList = sqlSession.selectList("lg.cns.ds.mapper.cmpnMngMapper.selectCmprCmpnPrptyList");
		
		if (cmprCmpnPrptyList == null) {
			cmprCmpnPrptyList = new ArrayList<CmpnVldtRsltHst>();
		}
		return cmprCmpnPrptyList;
	}

	public int getItrtSeq() {
		
		int itrtSeq = 0;
		
		itrtSeq = sqlSession.selectOne("lg.cns.ds.mapper.cmpnMngMapper.selectItrtSeq");
				
		return itrtSeq;
	}
	
	public int insertCmprCmpnResult(Map<String , Object> result){
		return sqlSession.insert("lg.cns.ds.mapper.cmpnMngMapper.insertCmprCmpnPrptyResult", result);
	}
	
	public Domain insert(Domain domain) {
		sqlSession.insert("lg.cns.ds.mapper.domainMapper.insert" , domain);
		return domain;
	}
	public int updateExistingDomain(Domain domain) {
		return sqlSession.update("lg.cns.ds.mapper.domainMapper.update", domain);
	}
	
	public int updateRejectionStatus(Domain domain) {
		return sqlSession.update("lg.cns.ds.mapper.domainMapper.updateRejectionReason", domain);
	}
	
	public void cancelRequest(HashMap<String , Object> aRequest) {
		sqlSession.delete("lg.cns.ds.mapper.domainMapper.cancelRequest" , aRequest);
	}
	public void makeRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.domainMapper.makeRequest", aRequest);
	}
	public void approveRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.domainMapper.approveRequest", aRequest);
	}

	public void rejectRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.domainMapper.rejectRequest", aRequest);
	}
	public int getRecordCount(JqGridRequest req) {
		Map<String , Object> params = new HashMap<String , Object>();
		params.put("requester", req.getRequester());
		params.put("queryContent", req.getQueryContent());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		return sqlSession.selectOne("lg.cns.ds.mapper.domainMapper.selectCountApproved", params);
	}
	/*
	 * public List<Domain> getDomainList(int offset, int limit, JqGridRequest req) {
	 * Map<String , Object> params = new HashMap<String , Object>();
	 * params.put("offset", offset); params.put("limit",limit);
	 * params.put("orderby",req.getSidx()); params.put("ordertype",req.getSord());
	 * params.put("requester", req.getRequester()); params.put("queryContent",
	 * req.getQueryContent()); params.put("dateStart", req.getDateStart());
	 * params.put("dateEnd", req.getDateEnd()); return
	 * sqlSession.selectList("lg.cns.ds.mapper.domainMapper.selectListApproved",
	 * params); }
	 */

	public List<Domain> getDomainListApproved(HashMap<String, Object> aRequest) {
		return sqlSession.selectList("lg.cns.ds.mapper.domainMapper.selectListApproved2", aRequest);
	}

	public boolean checkDomain(int iId, String domain) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (iId != -1) {
			params.put("requestId", iId);
		}
		params.put("domain", domain);
		int iResult = sqlSession.selectOne("lg.cns.ds.mapper.domainMapper.searchDomainCount", params);
		return iResult > 0;
	}
	
}
