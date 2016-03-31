package com.eland.ngoc.common.model;

/**
 * <pre>
 * Code model
 *
 */
public class Code extends BaseModel {
	private String codeGroupId;
	private String code;
	private String codeName;
	private String codeDesc;
	private int sort;
	private String useYn;
	
	public String getCodeGroupId() {
		return codeGroupId;
	}
	public void setCodeGroupId(String codeGroupId) {
		this.codeGroupId = codeGroupId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getCodeDesc() {
		return codeDesc;
	}
	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
}
