package lg.cns.ds.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lg.cns.ds.domain.Domain;
import lg.cns.ds.domain.UIInspectMng;
import lg.cns.ds.domain.User;
import lg.cns.ds.domain.UICmpnMng;
import lg.cns.ds.dto.JqGridRequest;
import lg.cns.ds.domain.UIInspectMngSearchCnd;
import lg.cns.ds.domain.CmpnVldtRsltHst;

@Repository
public class UIInspectMngDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<UIInspectMng> getVldtRsltList(User oCurrentUser, int offset, int limit, UIInspectMngSearchCnd cnd) {
		Map<String , Object> params = new HashMap<String , Object>();
		
		params.put("offset", offset);
		params.put("limit",limit);
		params.put("username", oCurrentUser.getUsername());
		params.put("dateStart", cnd.getDateStart());
		params.put("dateEnd", cnd.getDateEnd());
		params.put("selected_uitool", cnd.getSelected_uitool());
		params.put("selected_prjtCd", cnd.getSelected_prjtCd());
		params.put("search_vldtRstYn", cnd.getSearch_vldtRstYn());
		params.put("search_itrtSeq", cnd.getSearch_itrtSeq());
		params.put("search_flId", cnd.getSearch_flId());
		params.put("search_vldtSbjTermCd", cnd.getSearch_vldtSbjTermCd());
		params.put("search_vldtSbjTermNm", cnd.getSearch_vldtSbjTermNm());
		params.put("search_vldtRuleCd", cnd.getSearch_vldtRuleCd());
		params.put("search_vldtRuleNm", cnd.getSearch_vldtRuleNm());
		params.put("search_frstCrtrId", cnd.getSearch_frstCrtrId());
		
		List<UIInspectMng> UIvldtRslt = null;
		
		UIvldtRslt = sqlSession.selectList("lg.cns.ds.mapper.uiInspectMngMapper.selectVldtRsltList", params);
		
		if (UIvldtRslt == null) {
			UIvldtRslt = new ArrayList<UIInspectMng>();
		}
		return UIvldtRslt;
	}

	public int getRecordCount(UIInspectMngSearchCnd cnd) {
		Map<String , Object> params = new HashMap<String , Object>();
		
		params.put("dateStart", cnd.getDateStart());
		params.put("dateEnd", cnd.getDateEnd());
		params.put("selected_uitool", cnd.getSelected_uitool());
		params.put("selected_prjtCd", cnd.getSelected_prjtCd());
		params.put("search_vldtRstYn", cnd.getSearch_vldtRstYn());
		params.put("search_itrtSeq", cnd.getSearch_itrtSeq());
		params.put("search_flId", cnd.getSearch_flId());
		params.put("search_vldtSbjTermCd", cnd.getSearch_vldtSbjTermCd());
		params.put("search_vldtSbjTermNm", cnd.getSearch_vldtSbjTermNm());
		params.put("search_vldtRuleCd", cnd.getSearch_vldtRuleCd());
		params.put("search_vldtRuleNm", cnd.getSearch_vldtRuleNm());
		params.put("search_frstCrtrId", cnd.getSearch_frstCrtrId());
		
		int iResult = 0;
		
		iResult = sqlSession.selectOne("lg.cns.ds.mapper.uiInspectMngMapper.selectCount", params);
		
		return iResult;
	}
	
	public List<UICmpnMng> getCmpnList(User oCurrentUser, int offset, int limit, String uiCd) {
		Map<String , Object> params = new HashMap<String , Object>();
		
		params.put("offset", offset);
		params.put("limit",limit);
		params.put("username", oCurrentUser.getUsername());
		params.put("uiCd", uiCd);
		
		List<UICmpnMng> cmpnList = null;
		
		cmpnList = sqlSession.selectList("lg.cns.ds.mapper.uiInspectMngMapper.selectCmpnList", params);
		
		if (cmpnList == null) {
			cmpnList = new ArrayList<UICmpnMng>();
		}
		return cmpnList;
	}
	
	//비교대상 컴포넌트 및 속성 조회
	public List<CmpnVldtRsltHst> getCmprCmpnPrptyList() {
				
		List<CmpnVldtRsltHst> cmprCmpnPrptyList = null;
		
		cmprCmpnPrptyList = sqlSession.selectList("lg.cns.ds.mapper.uiInspectMngMapper.selectCmprCmpnPrptyList");
		
		if (cmprCmpnPrptyList == null) {
			cmprCmpnPrptyList = new ArrayList<CmpnVldtRsltHst>();
		}
		return cmprCmpnPrptyList;
	}

	public int getItrtSeq() {
		
		int itrtSeq = 0;
		
		itrtSeq = sqlSession.selectOne("lg.cns.ds.mapper.uiInspectMngMapper.selectItrtSeq");
				
		return itrtSeq;
	}
	
	public int insertCmprCmpnResult(Map<String , Object> result){
		return sqlSession.insert("lg.cns.ds.mapper.uiInspectMngMapper.insertCmprCmpnPrptyResult", result);
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
