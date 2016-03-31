package com.eland.ngoc.common.model;

/**
 * @author park.sanghyuk
 *
 */
public class Email {
	
	/**
	 * 고유번호
	 */
	private int seqIdx;
	/**
	 * 메일 제목
	 */
	private String subject;
	/**
	 * 회원 EMAIL
	 */
	private String qry;
	/**
	 * 거부 그룹(미사용)
	 */
	private int rejectSlistIdx;
	/**
	 * 블록 그룹(미사용)
	 */
	private int blockGroupIdx;
	/**
	 * 보내는 사람
	 */
	private String mailFrom;
	/**
	 * 받는사람
	 */
	private String mailTo;
	/**
	 * 회신 주소
	 */
	private String replyTo;
	/**
	 * 에러 회신 주소
	 */
	private String errorSto;
	/**
	 * 0:text, 1:html
	 */
	private int html;
	/**
	 * 0:text, 1:base64
	 */
	private int encoding;
	/**
	 *  euc-kr, utf-8...
	 */
	private String charset;
	/**
	 * 발송 시간
	 */
	private String sDate;
	/**
	 * 메일의 수신 확인 종료 시각
	 */
	private String tDate;
	/**
	 * 0:측정하지 않음, 1: duration 측정(초단위 열람 시간), 2: open 측정
	 */
	private int durationSet;
	/**
	 * 0:링크 클릭 측정하지 않음 1: 링크 클릭 측정
	 */
	private int clickSet;
	/**
	 * 0:사이트 측정하지 않음1: 사이트 측정
	 */
	private int siteSet;
	/**
	 * 0:첨부파일 없음 1: 첨부파일을 파일로 보내기, 2: 첨부파일을 링크로 보내기 
	 */
	private int atcSET;
	/**
	 * 구분값 임의 필드
	 */
	private String gubun;
	/**
	 * qry 필드에 입력된 데이터의 필드 순으로 참조명을 입력하면 
	 * 해당 참조명으로 매크로 확장을 사용할 수 있습니다. 
	 * 예를 들어 qry 필드에 SSV: kykim@infomail.co.kr, 김가이, kykim으로 입력한 후 
	 * rname에 email, name, user_id로 입력하면 제목 및 컨텐츠에 [$email$], [$name$], [$user_id$] 
	 * 등으로 매크로를 확장할 수 있습니다. 일반적으로는 qry필드에 입력한 데이터 순서대로 
	 * [$csv0$], [$csv1$] ... 등으로 매크로를 사용합니다.
	 */
	private String rname;
	/**
	 * 0:일반메일, 1: html + text 메일, 2: 보안메일
	 */
	private int mType;
	/**
	 * User 고유 번호
	 */
	private int uIdx;
	/**
	 * Group 고유 번호
	 */
	private int gIdx;
	/**
	 * 0: 발송전, 99: 발송 후
	 */
	private int msgFlag;
	/**
	 * 메인 인덱스(가이드 문서에 필드 없음)
	 */
	private int mailIdx;
	/**
	 * 서버 ID(가이드 문서에 필드 없음)
	 */
	private String serverId;
	/**
	 * tranDate(가이드 문서에 필드 없음)
	 */
	private String tranDate;
	/**
	 * 메일 내용
	 */
	private String content;
	
	public int getSeqIdx() {
		return seqIdx;
	}
	public void setSeqIdx(int seqIdx) {
		this.seqIdx = seqIdx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getQry() {
		return qry;
	}
	public void setQry(String qry) {
		this.qry = qry;
	}
	public int getRejectSlistIdx() {
		return rejectSlistIdx;
	}
	public void setRejectSlistIdx(int rejectSlistIdx) {
		this.rejectSlistIdx = rejectSlistIdx;
	}
	public int getBlockGroupIdx() {
		return blockGroupIdx;
	}
	public void setBlockGroupIdx(int blockGroupIdx) {
		this.blockGroupIdx = blockGroupIdx;
	}
	public String getMailFrom() {
		return mailFrom;
	}
	public void setMailFrom(String mailFrom) {
		this.mailFrom = mailFrom;
	}
	public String getMailTo() {
		return mailTo;
	}
	public void setMailTo(String mailTo) {
		this.mailTo = mailTo;
	}
	public String getReplyTo() {
		return replyTo;
	}
	public void setReplyTo(String replyTo) {
		this.replyTo = replyTo;
	}
	public String getErrorSto() {
		return errorSto;
	}
	public void setErrorSto(String errorSto) {
		this.errorSto = errorSto;
	}
	public int getHtml() {
		return html;
	}
	public void setHtml(int html) {
		this.html = html;
	}
	public int getEncoding() {
		return encoding;
	}
	public void setEncoding(int encoding) {
		this.encoding = encoding;
	}
	public String getCharset() {
		return charset;
	}
	public void setCharset(String charset) {
		this.charset = charset;
	}
	public String getsDate() {
		return sDate;
	}
	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
	public String gettDate() {
		return tDate;
	}
	public void settDate(String tDate) {
		this.tDate = tDate;
	}
	public int getDurationSet() {
		return durationSet;
	}
	public void setDurationSet(int durationSet) {
		this.durationSet = durationSet;
	}
	public int getClickSet() {
		return clickSet;
	}
	public void setClickSet(int clickSet) {
		this.clickSet = clickSet;
	}
	public int getSiteSet() {
		return siteSet;
	}
	public void setSiteSet(int siteSet) {
		this.siteSet = siteSet;
	}
	public int getAtcSET() {
		return atcSET;
	}
	public void setAtcSET(int atcSET) {
		this.atcSET = atcSET;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public int getmType() {
		return mType;
	}
	public void setmType(int mType) {
		this.mType = mType;
	}
	public int getuIdx() {
		return uIdx;
	}
	public void setuIdx(int uIdx) {
		this.uIdx = uIdx;
	}
	public int getgIdx() {
		return gIdx;
	}
	public void setgIdx(int gIdx) {
		this.gIdx = gIdx;
	}
	public int getMsgFlag() {
		return msgFlag;
	}
	public void setMsgFlag(int msgFlag) {
		this.msgFlag = msgFlag;
	}
	public int getMailIdx() {
		return mailIdx;
	}
	public void setMailIdx(int mailIdx) {
		this.mailIdx = mailIdx;
	}
	public String getServerId() {
		return serverId;
	}
	public void setServerId(String serverId) {
		this.serverId = serverId;
	}
	public String getTranDate() {
		return tranDate;
	}
	public void setTranDate(String tranDate) {
		this.tranDate = tranDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	 
	 
}
