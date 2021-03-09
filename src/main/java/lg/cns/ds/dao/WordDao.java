package lg.cns.ds.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lg.cns.ds.domain.User;
import lg.cns.ds.domain.Word;
import lg.cns.ds.dto.JqGridRequest;

@Repository
public class WordDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Word> getWordList(User oCurrentUser, int offset, int limit, JqGridRequest req) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("limit", limit);
		params.put("orderby", req.getSidx());
		params.put("ordertype", req.getSord());
		params.put("username", oCurrentUser.getUsername());
		params.put("requester", req.getRequester());
		params.put("rejectionReason", req.getRejectionReason());
		params.put("queryContent", req.getQueryContent());
		params.put("requestStatus", req.getRequestStatus());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		List<Word> aWord = null;
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			aWord = sqlSession.selectList("lg.cns.ds.mapper.wordMapper.selectList", params);
		}
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			aWord = sqlSession.selectList("lg.cns.ds.mapper.wordMapper.selectListAdmin", params);
		}
		if (aWord == null) {
			aWord = new ArrayList<Word>();
		}
		return aWord;
	}
	
	public Word insert(Word word) {
		sqlSession.insert("lg.cns.ds.mapper.wordMapper.insert", word);
		return word;
	}

	public int getRecordCount(User oCurrentUser, JqGridRequest req) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("username", oCurrentUser.getUsername());
		params.put("requester", req.getRequester());
		params.put("rejectionReason", req.getRejectionReason());
		params.put("queryContent", req.getQueryContent());
		params.put("requestStatus", req.getRequestStatus());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		int iResult = 0;
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			iResult = sqlSession.selectOne("lg.cns.ds.mapper.wordMapper.selectCount", params);
		}
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			iResult = sqlSession.selectOne("lg.cns.ds.mapper.wordMapper.selectCountAdmin", params);
		}
		return iResult;
	}

	public int updateExistingWord(Word word) {
		return sqlSession.update("lg.cns.ds.mapper.wordMapper.update", word);
	}
	
	public int updateRejectionStatus(Word word) {
		return sqlSession.update("lg.cns.ds.mapper.wordMapper.updateRejectionReason", word);
	}

	public void makeRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.wordMapper.makeRequest", aRequest);
	}

	public void cancelRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.wordMapper.cancelRequest", aRequest);
	}

	public void approveRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.wordMapper.approveRequest", aRequest);
	}

	public void rejectRequest(HashMap<String, Object> aRequest) {
		sqlSession.update("lg.cns.ds.mapper.wordMapper.rejectRequest", aRequest);
	}

	public List<Word> searchWord(String sWord) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("word", sWord);
		return sqlSession.selectList("lg.cns.ds.mapper.wordMapper.searchWord", params);
	}

	public int getRecordCount(JqGridRequest req) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("requester", req.getRequester());
		params.put("queryContent", req.getQueryContent());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		return sqlSession.selectOne("lg.cns.ds.mapper.wordMapper.selectCountApproved", params);
	}
	
	public List<Word> getWordList(int offset, int limit, JqGridRequest req) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("offset", offset);
		params.put("limit", limit);
		params.put("orderby", req.getSidx());
		params.put("ordertype", req.getSord());
		params.put("requester", req.getRequester());
		params.put("queryContent", req.getQueryContent());
		params.put("dateStart", req.getDateStart());
		params.put("dateEnd", req.getDateEnd());
		return sqlSession.selectList("lg.cns.ds.mapper.wordMapper.selectListApproved", params);
	}

	public List<Word> getWordListApproved(HashMap<String, Object> aRequest) {
		return sqlSession.selectList("lg.cns.ds.mapper.wordMapper.selectListApproved2", aRequest);
	}

	public boolean checkWord(int iId, String standardWord, String abbrevationEng) {
		Map<String, Object> params = new HashMap<String, Object>();
		if (iId != -1) {
			params.put("requestId", iId);
		}
		params.put("word", standardWord);
		params.put("abbrevationEng", abbrevationEng);
		int iResult = sqlSession.selectOne("lg.cns.ds.mapper.wordMapper.searchWordCount", params);
		return iResult > 0;
	}
}
