package lg.cns.ds.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lg.cns.ds.domain.Domain;
import lg.cns.ds.domain.Term;
import lg.cns.ds.domain.User;
import lg.cns.ds.dto.JqGridRequest;

@Repository
public class TermDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<Term> getTermList(User oCurrentUser, int offset, int limit, JqGridRequest req) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("limit", limit);
		params.put("orderby", req.getSidx());
		params.put("ordertype", req.getSord());
		params.put("username", oCurrentUser.getUsername());
		params.put("requester", req.getRequester());
		params.put("rejectionReason", req.getRejectionReason());
		params.put("domainContent", req.getDomainContent());
		params.put("queryContent", req.getQueryContent());
		params.put("requestStatus", req.getRequestStatus());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		List<Term> aTerm = null;
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			aTerm = sqlSession.selectList("lg.cns.ds.mapper.termMapper.selectList", params);
		}
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			aTerm = sqlSession.selectList("lg.cns.ds.mapper.termMapper.selectListAdmin", params);
		}
		if (aTerm == null) {
			aTerm = new ArrayList<Term>();
		}
		return aTerm;
	}

	public Term insert(Term term) {
		sqlSession.insert("lg.cns.ds.mapper.termMapper.insert", term);
		return term;
	}

	public int getRecordCount(User oCurrentUser, JqGridRequest req) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("username", oCurrentUser.getUsername());
		params.put("requester", req.getRequester());
		params.put("rejectionReason", req.getRejectionReason());
		params.put("domainContent", req.getDomainContent());
		params.put("queryContent", req.getQueryContent());
		params.put("requestStatus", req.getRequestStatus());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		int iResult = 0;
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			iResult = sqlSession.selectOne("lg.cns.ds.mapper.termMapper.selectCount", params);
		}
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			iResult = sqlSession.selectOne("lg.cns.ds.mapper.termMapper.selectCountAdmin", params);
		}
		return iResult;
	}

	public int updateExistingTerm(Term term) {
		return sqlSession.update("lg.cns.ds.mapper.termMapper.update", term);
	}
	
	public int updateRejectionStatus(Term term) {
		return sqlSession.update("lg.cns.ds.mapper.termMapper.updateRejectionReason", term);
	}

	public List<Domain> findDomain(String sWord) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("word", sWord);
		return sqlSession.selectList("lg.cns.ds.mapper.termMapper.findDomain", params);
	}

	public void makeRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.termMapper.makeRequest", aRequest);
	}

	public void cancelRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.termMapper.cancelRequest", aRequest);
	}

	public void approveRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.termMapper.approveRequest", aRequest);
	}

	public void rejectRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.termMapper.rejectRequest", aRequest);
	}

	public int getRecordCount(JqGridRequest req) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("requester", req.getRequester());
		params.put("domainContent", req.getDomainContent());
		params.put("queryContent", req.getQueryContent());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		return sqlSession.selectOne("lg.cns.ds.mapper.termMapper.selectCountApproved", params);
	}

	public List<Term> getTermList(int offset, int limit, JqGridRequest req) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("limit", limit);
		params.put("orderby", req.getSidx());
		params.put("ordertype", req.getSord());
		params.put("requester", req.getRequester());
		params.put("domainContent", req.getDomainContent());
		params.put("queryContent", req.getQueryContent());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		return sqlSession.selectList("lg.cns.ds.mapper.termMapper.selectListApproved", params);
	}

	public List<Term> getTermListApproved(HashMap<String, Object> aRequest) {
		return sqlSession.selectList("lg.cns.ds.mapper.termMapper.selectListApproved2", aRequest);
	}

	public boolean checkTerm(int iId, String term) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (iId != -1) {
			params.put("requestId", iId);
		}
		params.put("term", term);
		int iResult = sqlSession.selectOne("lg.cns.ds.mapper.termMapper.searchTermCount", params);
		return iResult > 0;
	}
}
