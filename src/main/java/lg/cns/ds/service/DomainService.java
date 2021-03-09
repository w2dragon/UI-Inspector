package lg.cns.ds.service;

import java.util.ArrayList;
import java.util.HashMap;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lg.cns.ds.dao.DomainDao;
import lg.cns.ds.dao.WordDao;
import lg.cns.ds.domain.Domain;
import lg.cns.ds.domain.Word;
import lg.cns.ds.dto.JqGridRequest;

@Service
public class DomainService {

	@Autowired
	private DomainDao dao;
	
	@Autowired
	private WordDao wordDao;
	
	private static final Logger LOG = LoggerFactory.getLogger(DomainService.class);

	public int getRecordCount(lg.cns.ds.domain.User oCurrentUser, JqGridRequest req) {
		return dao.getRecordCount(oCurrentUser, req);
	}

	public List<Domain> getDomainList(lg.cns.ds.domain.User oCurrentUser, int offset, int limit, JqGridRequest req) {
		return dao.getDomainList(oCurrentUser, offset, limit, req);
	}

	public Domain createNewDomain(Domain domain) {
		return dao.insert(domain);
	}

	public int updateExistingDomain(Domain domain) {
		return dao.updateExistingDomain(domain);
	}
	
	public int updateRejectionStatus(Domain entity) {
		return dao.updateRejectionStatus(entity);
	}

	public void cancelRequest(HashMap<String, Object> aRequest) {
		dao.cancelRequest(aRequest);
	}

	public void makeRequest(HashMap<String, Object> aRequest) {
		dao.makeRequest(aRequest);
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
		// String[] alphabet = new String[]{"nacho", "mortal", "kombat"};
		// List<String> list = Arrays.asList(alphabet);
		if (sQuery.length() > 0) {
			String sCurrent = sQuery;
			while (sCurrent.length() > 0) {
				// LOG.debug("LOOP: " + sCurrent);
				// check if sCurrent value in the word database
				List<Word> aFoundWord = wordDao.searchWord(sCurrent);
				// if (list.contains(sCurrent)) {
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

	public List<Domain> getDomainList(int offset, int limit, JqGridRequest req) {
		return dao.getDomainList(offset, limit, req);
	}

	public List<Domain> getDomainListApproved(HashMap<String, Object> aRequest) {
		return dao.getDomainListApproved(aRequest);
	}

	public boolean checkDomain(int iId, String domain) {
		return dao.checkDomain(iId, domain);
	}

}
