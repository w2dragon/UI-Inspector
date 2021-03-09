package lg.cns.ds.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lg.cns.ds.domain.Domain;
import lg.cns.ds.domain.User;
import lg.cns.ds.dto.JqGridRequest;

@Repository
public class DomainDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Domain> getDomainList(User oCurrentUser, int offset, int limit, JqGridRequest req) {
		Map<String , Object> params = new HashMap<String , Object>();
		params.put("offset", offset);
		params.put("limit",limit);
		params.put("orderby",req.getSidx());
		params.put("ordertype",req.getSord());
		params.put("username", oCurrentUser.getUsername());
		params.put("requester", req.getRequester());
		params.put("rejectionReason", req.getRejectionReason());
		params.put("queryContent", req.getQueryContent());
		params.put("requestStatus", req.getRequestStatus());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		List<Domain> aDomain = null;
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			aDomain = sqlSession.selectList("lg.cns.ds.mapper.domainMapper.selectList", params);
		}
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			aDomain = sqlSession.selectList("lg.cns.ds.mapper.domainMapper.selectListAdmin", params);
		}
		if (aDomain == null) {
			aDomain = new ArrayList<Domain>();
		}
		return aDomain;
	}

	public int getRecordCount(User oCurrentUser, JqGridRequest req) {
		Map<String , Object> params = new HashMap<String , Object>();
		params.put("username", oCurrentUser.getUsername());
		params.put("requester", req.getRequester());
		params.put("rejectionReason", req.getRejectionReason());
		params.put("queryContent", req.getQueryContent());
		params.put("requestStatus", req.getRequestStatus());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		int iResult = 0;
		if(oCurrentUser.getRole().equals("ROLE_USER")) {
			iResult = sqlSession.selectOne("lg.cns.ds.mapper.domainMapper.selectCount", params);
		}
		if(oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			iResult = sqlSession.selectOne("lg.cns.ds.mapper.domainMapper.selectCountAdmin" , params);
		}
		return iResult;
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
	public List<Domain> getDomainList(int offset, int limit, JqGridRequest req) {
		Map<String , Object> params = new HashMap<String , Object>();
		params.put("offset", offset);
		params.put("limit",limit);
		params.put("orderby",req.getSidx());
		params.put("ordertype",req.getSord());
		params.put("requester", req.getRequester());
		params.put("queryContent", req.getQueryContent());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		return sqlSession.selectList("lg.cns.ds.mapper.domainMapper.selectListApproved", params);
	}

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
