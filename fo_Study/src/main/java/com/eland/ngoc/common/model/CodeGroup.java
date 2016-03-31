package com.eland.ngoc.common.model;

/**
 * <pre>
 * Code model
 *
 */
public class CodeGroup extends BaseModel {
	private String codeGroupId;
	private String codeGroupName;
	private String codeGroupType;
	private String codeGroupDesc;
	
	public String getCodeGroupId() {
		return codeGroupId;
	}
	public void setCodeGroupId(String codeGroupId) {
		this.codeGroupId = codeGroupId;
	}
	public String getCodeGroupName() {
		return codeGroupName;
	}
	public void setCodeGroupName(String codeGroupName) {
		this.codeGroupName = codeGroupName;
	}
	public String getCodeGroupType() {
		return codeGroupType;
	}
	public void setCodeGroupType(String codeGroupType) {
		this.codeGroupType = codeGroupType;
	}
	public String getCodeGroupDesc() {
		return codeGroupDesc;
	}
	public void setCodeGroupDesc(String codeGroupDesc) {
		this.codeGroupDesc = codeGroupDesc;
	}
}
