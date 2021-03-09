package lg.cns.ds.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import lg.cns.ds.dao.CommonDictDao;
import lg.cns.ds.domain.CommonDict;

@Service
public class CommonDictService {

	@Autowired
	private CommonDictDao dao;

	public List<CommonDict> getCommonDictList(String sGrpId) {
		return dao.getCommonDictList(sGrpId);
	}
}
