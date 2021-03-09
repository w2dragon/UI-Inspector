package lg.cns.ds;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

import lg.cns.ds.config.WebSecurityConfigurer;

public class ServletInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	protected Class<?>[] getRootConfigClasses() {
		return new Class<?>[] { WebMvcConfigurerImpl.class, WebSecurityConfigurer.class };
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return null;
	}

	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}
}