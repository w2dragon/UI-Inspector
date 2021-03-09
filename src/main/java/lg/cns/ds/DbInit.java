package lg.cns.ds;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import lg.cns.ds.dao.UserDao;
import lg.cns.ds.domain.User;

//@Component
public class DbInit implements ApplicationListener<ContextRefreshedEvent> {

	private static final Logger LOG = LoggerFactory.getLogger(DbInit.class);

	@Autowired
	UserDao dao;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		User user = new User();
		user.setUsername("user");
		user.setPassword(passwordEncoder.encode("user#123"));
		user.setRole("ROLE_USER");
		user.setEnabled(true);
		user.setFirstname("Firstname");
		user.setLastname("Lastname");

		try {
			dao.insert(user);
		} catch (DuplicateKeyException e) {
			LOG.info("Default user already exists");
		} catch (Exception e) {
			e.printStackTrace();
		}

		User admin = new User();
		admin.setUsername("admin");
		admin.setPassword(passwordEncoder.encode("admin#123"));
		admin.setRole("ROLE_ADMIN");
		admin.setEnabled(true);
		admin.setFirstname("Firstname");
		admin.setLastname("Lastname");

		try {
			dao.insert(admin);
		} catch (DuplicateKeyException e) {
			LOG.info("Default admin already exists");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
