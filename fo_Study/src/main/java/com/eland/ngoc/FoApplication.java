package com.eland.ngoc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.ImportResource;

import com.eland.ngoc.config.ExtendLogServiceConfiguration;

@ComponentScan(value = {"com.eland.ngoc"})
@Import(value = ExtendLogServiceConfiguration.class)
@EnableAutoConfiguration
public class FoApplication extends SpringBootServletInitializer {
	
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(FoApplication.class);
    }
	
	public static void main(String[] args) {
		SpringApplication.run(FoApplication.class, args);
	}
}
