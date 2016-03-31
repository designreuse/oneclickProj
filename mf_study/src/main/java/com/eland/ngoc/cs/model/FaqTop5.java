package com.eland.ngoc.cs.model;

/**
 * 자주묻는 질문 Top5
 * Top5 조회와 전체 FAQ 조회를 구분하기 때문에 모델 별도 생성
 * 
 * @author kim.hyemi04
 *
 */
public class FaqTop5 {

	/**
	 * 자주묻는 질문 순번
	 */
	String faqSeq;
	/**
	 * 자주묻는 질문 제목
	 */
	String faqTitle;
	/**
	 * 자주묻는 질문 내용
	 */
	String faqCont;
	/**
	 * 카테고리 코드
	 */
	String ctgrCode;
	/**
	 * 카테고리 코드 이름
	 */
	String ctgrName;
	/**
	 * 탑5 여부
	 */
	String top5Yn;
	/**
	 * 정렬순서
	 */
	String sort;

	public String getFaqSeq() {
		return faqSeq;
	}

	public void setFaqSeq(String faqSeq) {
		this.faqSeq = faqSeq;
	}

	public String getFaqTitle() {
		return faqTitle;
	}

	public void setFaqTitle(String faqTitle) {
		this.faqTitle = faqTitle;
	}

	public String getFaqCont() {
		return faqCont;
	}

	public void setFaqCont(String faqCont) {
		this.faqCont = faqCont;
	}

	public String getCtgrCode() {
		return ctgrCode;
	}

	public void setCtgrCode(String ctgrCode) {
		this.ctgrCode = ctgrCode;
	}

	public String getCtgrName() {
		return ctgrName;
	}

	public void setCtgrName(String ctgrName) {
		this.ctgrName = ctgrName;
	}

	public String getTop5Yn() {
		return top5Yn;
	}

	public void setTop5Yn(String top5Yn) {
		this.top5Yn = top5Yn;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

}
