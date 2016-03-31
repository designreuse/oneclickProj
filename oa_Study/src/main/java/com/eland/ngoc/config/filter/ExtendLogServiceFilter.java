package com.eland.ngoc.config.filter;

import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.filter.Filter;
import ch.qos.logback.core.spi.FilterReply;

public class ExtendLogServiceFilter extends Filter<ILoggingEvent>{

	@Override
	public FilterReply decide(ILoggingEvent event) {
		if(event.getLoggerName().equals("eland.log.service.ElandLogService"))
			return FilterReply.DENY;
		else
			return FilterReply.ACCEPT;
	}
}
