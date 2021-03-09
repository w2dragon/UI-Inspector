package lg.cns.ds.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lg.cns.ds.domain.UICommon;

@Repository
public class UICommonDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<UICommon> getUICdList() {
		return sqlSession.selectList("lg.cns.ds.mapper.uiCommonMapper.selectUICdList");
	}
	
	public List<UICommon> getPrjtCdList() {
		return sqlSession.selectList("lg.cns.ds.mapper.uiCommonMapper.selectPrjtCdList");
	}
	
}
