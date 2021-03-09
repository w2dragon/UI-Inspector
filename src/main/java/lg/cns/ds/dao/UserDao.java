package lg.cns.ds.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lg.cns.ds.domain.User;

@Repository
public class UserDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public User findByUsername(String username) {
		return sqlSession.selectOne("lg.cns.ds.mapper.userMapper.findByUsername", username);
	}

	public int insert(User user) {
		return sqlSession.insert("lg.cns.ds.mapper.userMapper.insert", user);
	}
	
	public void changePass(User vo) {
		sqlSession.update("lg.cns.ds.mapper.userMapper.changePass", vo);
	}
	
	public User getUserId(User vo) {
		return sqlSession.selectOne("lg.cns.ds.mapper.userMapper.getUserId", vo);
	}
}
