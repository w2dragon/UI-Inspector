package lg.cns.ds.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lg.cns.ds.domain.CommonDict;

@Repository
public class CommonDictDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<CommonDict> getCommonDictList(String sGrpId) {
		return sqlSession.selectList("lg.cns.ds.mapper.commonDictMapper.selectList", sGrpId);
	}
	
}
