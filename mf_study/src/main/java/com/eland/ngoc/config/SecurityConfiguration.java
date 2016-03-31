package com.eland.ngoc.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;




@Configuration
@EnableWebMvcSecurity
//@PropertySource("classpath:config/security.properties")
public class SecurityConfiguration extends WebSecurityConfigurerAdapter  {
	
//    @Autowired
//    private UserDetailsService userDetailsService;
	
  @Autowired
  private javax.sql.DataSource dataSource;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.
				authorizeRequests().antMatchers("/**")
				.permitAll()
				.and()
				.formLogin()
				.loginPage("/login")
				.permitAll();
		http.csrf().disable();
		
	}
	
//	@Override
//	protected void configure(AuthenticationManagerBuilder auth)
//			throws Exception {
//		auth.userDetailsService(userDetailsService)
//		.passwordEncoder(new ShaPasswordEncoder(256));
//	}
	
	@Override
		protected void configure(AuthenticationManagerBuilder auth) throws Exception {
				auth.jdbcAuthentication().dataSource(dataSource);
		}
	
	
}
