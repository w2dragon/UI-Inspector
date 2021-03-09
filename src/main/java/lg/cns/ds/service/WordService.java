 package lg.cns.ds.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lg.cns.ds.dao.WordDao;
import lg.cns.ds.domain.User;
import lg.cns.ds.domain.Word;
import lg.cns.ds.dto.JqGridRequest;

@Service
public class WordService {

	@Autowired
	private WordDao dao;
	
	public int getRecordCount(User oCurrentUser, JqGridRequest req) {
		return dao.getRecordCount(oCurrentUser, req);
	}
	
	public List<Word> getWordList(User oCurrentUser, int offset, int limit, JqGridRequest req) {
		return dao.getWordList(oCurrentUser, offset, limit, req);
	}
	
	public Word createNewWord(Word word) {
		return dao.insert(word);
	}

	public int updateExistingWord(Word word) {
		return dao.updateExistingWord(word);
	}
	
	public int updateRejectionStatus(Word word) {
		return dao.updateRejectionStatus(word);
	}

	public void makeRequest(HashMap<String, Object> aRequest) {
		dao.makeRequest(aRequest);
	}

	public void cancelRequest(HashMap<String, Object> aRequest) {
		dao.cancelRequest(aRequest);
	}

	public void approveRequest(HashMap<String, Object> aRequest) {
		dao.approveRequest(aRequest);
	}

	public void rejectRequest(HashMap<String, Object> aRequest) {
		dao.rejectRequest(aRequest);
	}

	public int getRecordCount(JqGridRequest req) {
		return dao.getRecordCount(req);
	}
	
	public List<Word> getWordList(int offset, int limit, JqGridRequest req) {
		return dao.getWordList(offset, limit, req);
	}

	public List<Word> getWordListApproved(HashMap<String, Object> aRequest) {
		return dao.getWordListApproved(aRequest);
	}

	public boolean checkWord(int iId, String standardWord, String AbbrevationEng) {
		return dao.checkWord(iId, standardWord, AbbrevationEng);
	}

}
