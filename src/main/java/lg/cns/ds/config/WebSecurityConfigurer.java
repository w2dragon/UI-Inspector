package lg.cns.ds.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class WebSecurityConfigurer extends WebSecurityConfigurerAdapter {
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.authorizeRequests()			
				.antMatchers("/checkUser", "/changePass", "/static/**").permitAll()
				.anyRequest().authenticated()
				.and()
			.formLogin()
				.loginPage("/login")
				.defaultSuccessUrl("/")
				.failureUrl("/login?error")
				.permitAll()
				.and()
			.logout()
				.logoutSuccessUrl("/login")
				.permitAll();
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new PasswordEnconderTest();
	}
	
	public class PasswordEnconderTest implements PasswordEncoder {
	    @Override
	    public String encode(CharSequence charSequence) {
	        return charSequence.toString();
	    }

	    @Override
	    public boolean matches(CharSequence charSequence, String s) {
	        return charSequence.toString().equals(s);
	    }
	}
}
