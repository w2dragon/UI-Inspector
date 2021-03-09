package lg.cns.ds.service;

import static org.apache.commons.lang3.StringUtils.isBlank;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lg.cns.ds.dao.UserDao;
import lg.cns.ds.domain.User;

@Service
public class UserDetailServiceImpl implements UserDetailsService {

	@Autowired
	private UserDao dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = dao.findByUsername(username);

		if (user == null || isBlank(user.getUsername())) {
			throw new UsernameNotFoundException(username);
		}

		return user;
	}
	
	public HashMap<String, Object> checkUser(User vo) {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
		User user = dao.getUserId(vo);
		
		if(user == null) {
			returnMap.put("RESULT", "WRONG");
		}else {
			returnMap.put("RESULT", "OK");
		}

		return returnMap;
	}
	
	public HashMap<String, Object> changePass(User vo) {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		
		try {
			BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			String changedPass = passwordEncoder.encode(vo.getPassword());
			vo.setPassword(changedPass);
			dao.changePass(vo);
			returnMap.put("RESULT", "OK");
		} catch (Exception e) {
			returnMap.put("RESULT", "");
		}	

		return returnMap;
	}

}
