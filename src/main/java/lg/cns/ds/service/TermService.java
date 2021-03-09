package lg.cns.ds.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lg.cns.ds.dao.TermDao;
import lg.cns.ds.dao.WordDao;
import lg.cns.ds.domain.Domain;
import lg.cns.ds.domain.Term;
import lg.cns.ds.domain.User;
import lg.cns.ds.domain.Word;
import lg.cns.ds.dto.JqGridRequest;

@Service
public class TermService {

	@Autowired
	private TermDao dao;
	
	@Autowired
	private WordDao wordDao;

	private static final Logger LOG = LoggerFactory.getLogger(TermService.class);

	public int getRecordCount(User oCurrentUser, JqGridRequest req) {
		return dao.getRecordCount(oCurrentUser, req);
	}

	public List<Term> getTermList(User oCurrentUser, int offset, int limit, JqGridRequest req) {
		return dao.getTermList(oCurrentUser, offset, limit, req);
	}

	public Term createNewTerm(Term term) {
		return dao.insert(term);
	}

	public int updateExistingTerm(Term term) {
		return dao.updateExistingTerm(term);
	}
	
	public int updateRejectionStatus(Term entity) {
		return dao.updateRejectionStatus(entity);
	}

	public List<Domain> findDomain(String sWord) {
		return dao.findDomain(sWord);
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

	public List<Word> searchWord(String sQuery) {
		ArrayList<String> aWord = new ArrayList<String>();
		ArrayList<Word> aWordObject = new ArrayList<Word>();
		if (sQuery.length() > 0) {
			String sCurrent = sQuery;
			while (sCurrent.length() > 0) {
				// LOG.debug("LOOP: " + sCurrent);
				// check if sCurrent value in the word database
				List<Word> aFoundWord = wordDao.searchWord(sCurrent);
				if (aFoundWord.size() > 0) {
					// remove word from initial
					aWord.add(sCurrent);
					aWordObject.add(aFoundWord.get(0));
					// exclude founded words from original sQuery
					sCurrent = sQuery;
					for (int i = 0; i < aWord.size(); i += 1) {
						sCurrent = sCurrent.substring(aWord.get(i).length());
					}
				} else {
					// remove last character
					sCurrent = sCurrent.substring(0, sCurrent.length() - 1);
				}
			}
		}
		return aWordObject;
	}

	public int getRecordCount(JqGridRequest req) {
		return dao.getRecordCount(req);
	}

	public List<Term> getTermList(int offset, int limit, JqGridRequest req) {
		return dao.getTermList(offset, limit, req);
	}

	public List<Term> getTermListApproved(HashMap<String, Object> aRequest) {
		return dao.getTermListApproved(aRequest);
	}

	public boolean checkTerm(int iId, String term) {
		return dao.checkTerm(iId, term);
	}
}
