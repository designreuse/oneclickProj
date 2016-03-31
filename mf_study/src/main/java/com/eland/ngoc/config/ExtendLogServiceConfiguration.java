package com.eland.ngoc.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.security.core.token.TokenService;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RestController;

import eland.log.config.LogServiceConfiguration;
import eland.log.message.LogMessage;
import eland.log.type.LoggingAnnotationTypes;
import eland.log.type.LoggingSkipClassTypes;

@Configuration
@Import(LogServiceConfiguration.class)
public class ExtendLogServiceConfiguration {

    @Bean
    public LoggingAnnotationTypes loggingAnnotationTypes() {
        LoggingAnnotationTypes loggingAnnotationTypes = new LoggingAnnotationTypes();
        loggingAnnotationTypes.add(Controller.class);
        loggingAnnotationTypes.add(RestController.class);
        loggingAnnotationTypes.add(Service.class);
        loggingAnnotationTypes.add(Repository.class);
        return loggingAnnotationTypes;
    }

    @Bean
    public LoggingSkipClassTypes loggingSkipClassTypes() {
        LoggingSkipClassTypes loggingSkipClassTypes = new LoggingSkipClassTypes();
        loggingSkipClassTypes.add(TokenService.class);
        return loggingSkipClassTypes;
    }

    @Bean
    public LogMessage logMessage() {
        LogMessage logMessage = new LogMessage();
        return logMessage;
    }
}
