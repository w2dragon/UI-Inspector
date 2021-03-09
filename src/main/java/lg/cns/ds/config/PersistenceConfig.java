package lg.cns.ds.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
@PropertySource("classpath:jdbc.properties")
public class PersistenceConfig {

	@Value("${jdbc.driverClassName}")
	private String driverClassName;
	@Value("${jdbc.url}")
	private String url;
	@Value("${jdbc.username}")
	private String username;
	@Value("${jdbc.password}")
	private String password;

	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource bds = new DriverManagerDataSource();
		bds.setDriverClassName(driverClassName);
		bds.setUrl(url);
		bds.setUsername(username);
		bds.setPassword(password);
		return bds;
	}

	@Bean
	public DataSourceTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}

	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(dataSource());
		factoryBean.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
		factoryBean.setMapperLocations(resolver.getResources("classpath:sqlmappers/**/*Mapper.xml"));
		return factoryBean.getObject();
	}

	@Bean
	public SqlSessionTemplate createSqlSessionTemplate() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory());
	}
}
