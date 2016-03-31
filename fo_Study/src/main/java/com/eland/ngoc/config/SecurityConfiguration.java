package com.eland.ngoc.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.servlet.configuration.EnableWebMvcSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.google.common.base.Charsets;
import com.google.common.hash.Hashing;




@Configuration
@EnableWebMvcSecurity
//@PropertySource("classpath:config/security.properties")
public class SecurityConfiguration extends WebSecurityConfigurerAdapter  {
	
//    @Autowired
//    private UserDetailsService userDetailsService;
	
  @Autowired
  private DataSource dataSource;
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
//		http.
//				authorizeRequests().antMatchers("/member/updateMember").hasRole("USER")
//				.anyRequest().authenticated()
//				.and()
//				.formLogin().
//				loginPage("/login")
//				.permitAll();
		http.csrf().disable();
		
	}
	
	 PasswordEncoder sha256PasswordEncoder = new PasswordEncoder() {
         @Override
         public String encode(CharSequence rawPassword) {
             return Hashing.sha256().hashString(rawPassword, Charsets.UTF_8).toString();
         }

         @Override
         public boolean matches(CharSequence rawPassword, String encodedPassword) {
             return encodedPassword.equals(Hashing.sha256().hashString(rawPassword, Charsets.UTF_8).toString());
         }
     };
	
	@Override
		protected void configure(AuthenticationManagerBuilder auth) throws Exception {
			auth.jdbcAuthentication().dataSource(dataSource).passwordEncoder(sha256PasswordEncoder);
		}
	
}
