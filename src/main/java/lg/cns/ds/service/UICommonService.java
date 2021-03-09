package lg.cns.ds.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import lg.cns.ds.dao.UICommonDao;
import lg.cns.ds.domain.UICommon;

@Service
public class UICommonService {

	@Autowired
	private UICommonDao dao;

	public List<UICommon> getUICdList(String cnd) {
		List<UICommon> result = new ArrayList();
		UICommon ds = new UICommon();
		
		result = dao.getUICdList();
		
		if(cnd.equals("0")) {
			ds.setCode("");
			ds.setName("--전체--");
			result.add(0, ds);
		}
		
		if(cnd.equals("1")) {
			ds.setCode("");
			ds.setName("--선택--");
			result.add(0, ds);
		}
		return result;
	}
	
	public List<UICommon> getPrjtCdList(String cnd) {
		List<UICommon> result = new ArrayList();
		UICommon ds = new UICommon();
		
		result = dao.getPrjtCdList();
		
		if(cnd.equals("0")) {
			ds.setCode("");
			ds.setName("--전체--");
			result.add(0, ds);
		}
		
		if(cnd.equals("1")) {
			ds.setCode("");
			ds.setName("--선택--");
			result.add(0, ds);
		}
		return result;
	}
}
