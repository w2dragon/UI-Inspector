package lg.cns.ds.service;

import java.util.ArrayList;
import java.util.HashMap;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lg.cns.ds.dao.UIInspectMngDao;
import lg.cns.ds.dao.WordDao;
import lg.cns.ds.domain.Domain;
import lg.cns.ds.domain.Word;
import lg.cns.ds.domain.UIMng;
import lg.cns.ds.domain.UIInspectMngSearchCnd;
import lg.cns.ds.domain.CmpnVldtRsltHst;
import lg.cns.ds.domain.UIInspectMng;
import lg.cns.ds.dto.JqGridRequest;

@Service
public class UIInspectMngService {

	@Autowired
	private UIInspectMngDao dao;
		
	private static final Logger LOG = LoggerFactory.getLogger(UIInspectMngService.class);

	public int getRecordCount(UIInspectMngSearchCnd cnd) {
		return dao.getRecordCount(cnd);
	}

	public List<UIInspectMng> getVldtRsltList(lg.cns.ds.domain.User oCurrentUser, int offset, int limit, UIInspectMngSearchCnd cnd) {
		return dao.getVldtRsltList(oCurrentUser, offset, limit, cnd);
	}
	
	//비교대상 컴포넌트 및 속성 조회
	public List<CmpnVldtRsltHst> getCmprCmpnPrptyList() {
		return dao.getCmprCmpnPrptyList();
	}
	
	public int getItrtSeq() {
        return dao.getItrtSeq();
	}
	
	public int insertCmprCmpnResult(HashMap<String , Object> result){
		return dao.insertCmprCmpnResult(result);
	}
	
}
