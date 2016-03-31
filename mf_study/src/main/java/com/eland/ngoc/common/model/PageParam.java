
package com.eland.ngoc.common.model;

import java.io.Serializable;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

/**
 * Instantiates a new page param.
 */
public class PageParam implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** default 한페이지에 노출 row수. */
	private static final int pagePerSize = 30;

	// ~ Instance fields. ~~~~~~~~~~~~~~
	/** The pageable. */
	Pageable pageable;

	// ~ Public Methods. ~~~~~~~~~~~~~~~
	/**
	 * 현재 조회 페이지 수. 0 부터 시작함.
	 * 스프링 페이지는 첫페이지를 0부터 시작하기
	 * 때문에 컨트롤러에서 호출할때는 1부터 시작
	 * 그래서 -1를 현재 페이지로 설정 한다.
	 * 
	 *
	 * @param currentPage the current page
	 */
	public PageParam(int currentPage) {
		this.pageable = new PageRequest(currentPage-1, pagePerSize);

	}

	/**
	 * Instantiates a new page param.
	 *
	 * @param currentPage the current page
	 * @param pagePerSize the page per size
	 */
	public PageParam(int currentPage, int pageSize) {
		this.pageable = new PageRequest(currentPage-1, pageSize);
	}

	/**
	 * between 쿼리에서 첫번 째 인덱스.
	 *
	 * @return the begin index
	 */
	public int getBeginIndex() {
		return this.pageable.getOffset() + 1;
	}

	/**
	 * between 쿼리에서 두번 째 인덱스.
	 *
	 * @return the begin index
	 */
	public int getEndIndex() {
		return (getBeginIndex() + pageable.getPageSize()) -1;
	}
	
	public Pageable getPageable() {
		return pageable;
	}

	public void setPageable(Pageable pageable) {
		this.pageable = pageable;
	}

	public int getPageRange() {
		return pageRange;
	}

	public void setPageRange(int pageRange) {
		this.pageRange = pageRange;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPagePerRowSize() {
		return pagePerRowSize;
	}

	public void setPagePerRowSize(int pagePerRowSize) {
		this.pagePerRowSize = pagePerRowSize;
	}

	public long getTotalRow() {
		return totalRow;
	}

	public void setTotalRow(long totalRow) {
		this.totalRow = totalRow;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public boolean isFirstFlag() {
		return firstFlag;
	}

	public void setFirstFlag(boolean firstFlag) {
		this.firstFlag = firstFlag;
	}

	public boolean isLastFlag() {
		return lastFlag;
	}

	public void setLastFlag(boolean lastFlag) {
		this.lastFlag = lastFlag;
	}

	public boolean isPreFlag() {
		return preFlag;
	}

	public void setPreFlag(boolean preFlag) {
		this.preFlag = preFlag;
	}

	public boolean isNextFlag() {
		return nextFlag;
	}

	public void setNextFlag(boolean nextFlag) {
		this.nextFlag = nextFlag;
	}

	public int getDisplayPrePage() {
		return displayPrePage;
	}

	public void setDisplayPrePage(int displayPrePage) {
		this.displayPrePage = displayPrePage;
	}

	public int getDisplayNextPage() {
		return displayNextPage;
	}

	public void setDisplayNextPage(int displayNextPage) {
		this.displayNextPage = displayNextPage;
	}

	public int getDisplayBeginPage() {
		return displayBeginPage;
	}

	public void setDisplayBeginPage(int displayBeginPage) {
		this.displayBeginPage = displayBeginPage;
	}

	public int getDisplayEndPage() {
		return displayEndPage;
	}

	public void setDisplayEndPage(int displayEndPage) {
		this.displayEndPage = displayEndPage;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public static int getPagepersize() {
		return pagePerSize;
	}



	int pageRange;
	int currentPage;
	int pagePerRowSize;
	long totalRow;
	int totalPage;
	boolean firstFlag;
	boolean lastFlag;
	boolean preFlag;
	boolean nextFlag;
	int displayPrePage;
	int  displayNextPage;
	int displayBeginPage;
	int displayEndPage;
}
