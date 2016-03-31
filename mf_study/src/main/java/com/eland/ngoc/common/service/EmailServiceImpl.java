package com.eland.ngoc.common.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Service;

import com.eland.ngoc.common.OneClickConstants;
import com.eland.ngoc.common.dao.EmailDao;
import com.eland.ngoc.common.model.Email;
import com.eland.ngoc.common.model.EmailTemplete;
import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.member.model.MemberDTO;

/**
 * 페이지 처리를 위한 기본 서비스.
 */
@PropertySources({
	@PropertySource("classpath:/config/common-${spring.profiles.active}.properties"),
	@PropertySource("classpath:/message/messages_ko.properties")
})
@Service
public class EmailServiceImpl implements EmailService {
	
	// logger 선언
    private final static Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);

    @Autowired
    EmailDao emailRepository;

    @Value("${elandMall.url}")
	private String elandMallUrl;
    
    @Value("${elandCore.url}")
    private String elandCoreUrl;
    
    @Value("${oneclick.url}")
    private String oneclickUrl;
    
    @Value("${oneclick.name}")
    private String oneclickName;
    
    @Value("${name.elandmall}")
    private String elandmallName;
    
    @Value("${name.elandretail}")
    private String elandretailName;
    
    
	@Override
	public EmailTemplete getEmailTemplete(String emailType) {
		
		return emailRepository.selectEmailTemplete(emailType);
	}

	@Override
	public void sendEmail(MemberDTO memberDto, String templType, String templPart) {		
		
		try {
			if (OneClickConstants.ELAND_RETAIL_MALL_SITE_CODE.equals(memberDto.getCurrentSiteCode())) {
				memberDto.setPartnerUrl(elandMallUrl);
				memberDto.setPartnerName(elandmallName);
			} else if (OneClickConstants.ECORE_SITE_CODE.equals(memberDto.getCurrentSiteCode())) {
				memberDto.setPartnerUrl(elandCoreUrl);
				memberDto.setPartnerName(elandretailName);
			} else {
				memberDto.setPartnerUrl(oneclickUrl);
				memberDto.setPartnerName(oneclickName);
			}
			
			String joinSite = "";
			if ("Y".equals(memberDto.getRetailMallPartnerShipYn())) {
				joinSite += elandmallName + "(" +  elandMallUrl + ")";
			}
			if ("Y".equals(memberDto.getCorePartnerShipYn())) {
				if (StringUtil.isNotEmpty(joinSite)) {
					joinSite += "<br/>"; 	
				}
				joinSite += elandretailName + "(" +  elandCoreUrl + ")";
			}
			
			
			String qry = "SSV:".concat(memberDto.getEmail()).concat(",");
			EmailTemplete templete = emailRepository.selectEmailTemplete(templType);
			
			Email email = new Email();
			email.setSubject(templete.getTemplTitle());
			email.setMailFrom("<test@elandOnclick.com>");
			email.setMailTo('"' + memberDto.getName() + '"' + "<" + (memberDto.getEmail() + ">"));
			email.setReplyTo("<test@elandOnclick.com>");
			email.setErrorSto("<test@elandOnclick.com>");
			email.setContent(templete.getTemplCont());
			
			// 아이디, 이메일 ** 보안처리			
			String membId = memberDto.getWebId().substring(0, memberDto.getWebId().length()-3).concat("***");		
			String emailArray[] = memberDto.getEmail().split("@");
			String emailAddr = emailArray[0].substring(0, emailArray[0].length()-3).concat("***").concat("@").concat(emailArray[1]);
			
			// templPart : 회원 가입, 정보 수정, 휴면 해제
			if ("01".equals(templPart)) {
				String strRname = "email,name,id, asteriskEmail,joinSite";
				qry += memberDto.getName().concat(",").concat(membId).concat(",").concat(emailAddr).concat(",").concat(joinSite);
				
				// 이메일 수신 동의 여부
				String emailAgreeY = "";
				String emailAgreeN = "";
				if ("Y".equals(memberDto.getRetailMallEmailYn())) {
					if ("Y".equals(memberDto.getCoreEmailYn())) {
						emailAgreeY += elandmallName.concat("<br/>").concat(elandretailName);
					} else {
						emailAgreeY += elandmallName;
						emailAgreeN += elandretailName;
					}
				} else {
					if ("Y".equals(memberDto.getCoreEmailYn())) {
						emailAgreeN += elandmallName;
						emailAgreeY += elandretailName;
					}
				}
				strRname += ",emailOk,emailNo";
				qry += ",".concat(emailAgreeY).concat(",").concat(emailAgreeN);
				
				// 문자 수신 동의 여부
				String smsAgreeY = "";
				String smsAgreeN = "";
				if ("Y".equals(memberDto.getRetailMallSmsYn())) {
					if ("Y".equals(memberDto.getCoreSmsYn())) {					
						smsAgreeY += elandmallName.concat("<br/>").concat(elandretailName);
					} else {
						smsAgreeY += elandmallName;
						smsAgreeN += elandretailName;
					}
				} else {
					if ("Y".equals(memberDto.getCoreSmsYn())) {
						smsAgreeN += elandmallName;
						smsAgreeY += elandretailName;
					}
				}
				strRname += ",smsOk,smsNo";
				qry += ",".concat(smsAgreeY).concat(",").concat(smsAgreeN);
				
				// DM 수신 동의 여부
				if ("Y".equals(memberDto.getCoreDmYn())) {
					strRname += ",ecoreDmOk,ecoreDmNo";
					qry += ",".concat(elandretailName).concat(",").concat(elandmallName);
				} else {
					strRname += ",ecoreDmOk,ecoreDmNo";
					qry += ",".concat(" ").concat(",").concat(elandmallName).concat("<br/>").concat(elandretailName);
				}
				
				email.setRname(strRname);
			}
			
			// templPart : 휴면 해제_ 제목에 이름이 들어감
			else if ("02".equals(templPart)) {
				String strRname = "email,name,name,id,asteriskEmail";
				qry += memberDto.getName().concat(",").concat(memberDto.getName())
						.concat(",").concat(membId).concat(",").concat(emailAddr);
				
				// 이메일 수신 동의 여부
				String emailAgreeY = "";
				String emailAgreeN = "";
				if ("Y".equals(memberDto.getRetailMallEmailYn())) {
					if ("Y".equals(memberDto.getCoreEmailYn())) {
						emailAgreeY += elandmallName.concat("<br/>").concat(elandretailName);
					} else {
						emailAgreeY += elandmallName;
						emailAgreeN += elandretailName;
					}
				} else {
					if ("Y".equals(memberDto.getCoreEmailYn())) {
						emailAgreeN += elandmallName;
						emailAgreeY += elandretailName;
					}
				}
				strRname += ",emailOk,emailNo";
				qry += ",".concat(emailAgreeY).concat(",").concat(emailAgreeN);
				
				// 문자 수신 동의 여부
				String smsAgreeY = "";
				String smsAgreeN = "";
				if ("Y".equals(memberDto.getRetailMallSmsYn())) {
					if ("Y".equals(memberDto.getCoreSmsYn())) {
						smsAgreeY += elandmallName.concat("<br/>").concat(elandretailName);
					} else {
						smsAgreeY += elandmallName;
						smsAgreeN += elandretailName;
					}
				} else {
					if ("Y".equals(memberDto.getCoreSmsYn())) {
						smsAgreeN += elandmallName;
						smsAgreeY += elandretailName;
					}
				}
				strRname += ",smsOk,smsNo";
				qry += ",".concat(smsAgreeY).concat(",").concat(smsAgreeN);
				
				// DM 수신 동의 여부
				if ("Y".equals(memberDto.getCoreDmYn())) {
					strRname += ",ecoreDmOk,ecoreDmNo";
					qry += ",".concat(elandretailName).concat(",").concat(elandmallName);
				} else {
					strRname += ",ecoreDmOk,ecoreDmNo";
					qry += ",".concat(" ").concat(",").concat(elandmallName).concat("<br/>").concat(elandretailName);
				}
				
				email.setRname(strRname);
			} 
			
			// templPart : 임시 비밀 번호
			else if ("03".equals(templPart)) { 
				email.setRname("email,name,id,tempPassword");
				qry += memberDto.getName().concat(",").concat(membId).concat(",").concat(memberDto.getTempPassword());
			} 
			
			// templPart : 제휴사이트 탈퇴_ 제목에 이름, 탈퇴한 사이트가 들어감
			else if ("04".equals(templPart)){
				String strRname = "email,name,outSite,name,id,asteriskEmail";
				qry += memberDto.getName().concat(",").concat(memberDto.getOutSiteCode()).concat(",")
						.concat(memberDto.getName()).concat(",").concat(membId).concat(",").concat(emailAddr);
				
				email.setRname(strRname);
			}
			
			// templPart : 온라인 전체 탈퇴 & 온/오프라인(원클릭) 전체 탈퇴 & 비밀번호 변경 안내 & 휴면 확정_ 제목에 이름 들어감
			else if ("05".equals(templPart)){
				String strRname = "email,name,name,id,asteriskEmail";
				qry += memberDto.getName().concat(",").concat(memberDto.getName())
						.concat(",").concat(membId).concat(",").concat(emailAddr);
				
				email.setRname(strRname);
			}
			
			// templPart : 휴면 예정, 자동 탈퇴_ 소제목에 이름, 예정 날짜 들어감
			else if ("06".equals(templPart)){
				email.setRname("email,name,operDate,name,id,asteriskEmail");
				qry += memberDto.getName().concat(",").concat(memberDto.getOperDate()).concat(",")
						.concat(memberDto.getName()).concat(",").concat(membId).concat(",").concat(emailAddr);
			}
			
			// templPart 없음
			else {
				logger.debug("No templetePart: Please check templetePart(01~06");
			}
			
			email.setQry(qry);
			emailRepository.sendEmail(email);
			
		} catch (Exception e) {
			e.getMessage();
		}
	}
    
	
	
}
