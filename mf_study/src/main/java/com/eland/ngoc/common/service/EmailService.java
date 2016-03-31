
package com.eland.ngoc.common.service;

import com.eland.ngoc.common.model.EmailTemplete;
import com.eland.ngoc.member.model.MemberDTO;


/**
 * EMail 서비스
 */
public interface EmailService {
	
	public EmailTemplete getEmailTemplete(String emailType);
	
	public void sendEmail(MemberDTO memberDto, String templType, String templPart);
}
