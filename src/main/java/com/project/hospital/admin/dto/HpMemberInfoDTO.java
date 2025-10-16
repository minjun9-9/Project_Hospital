package com.project.hospital.admin.dto;

public class HpMemberInfoDTO {
	
	private String drId;
	private String deptName;
	private String drPosition;
	private String drName;
	private String drField;
	
	
	public HpMemberInfoDTO() {
		super();
	}

	

	public HpMemberInfoDTO(String drId, String deptName, String drPosition, String drName, String drField) {
		super();
		this.drId = drId;
		this.deptName = deptName;
		this.drPosition = drPosition;
		this.drName = drName;
		this.drField = drField;
	}

	

	public void setDrId(String drId) {
		this.drId = drId;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public void setDrName(String drName) {
		this.drName = drName;
	}

	public void setDrField(String drField) {
		this.drField = drField;
	}
	
	
	
	public String getDrPosition() {
		return drPosition;
	}



	public void setDrPosition(String drPosition) {
		this.drPosition = drPosition;
	}



	public String getDrId() {
		return drId;
	}



	public String getDeptName() {
		return deptName;
	}



	public String getDrName() {
		return drName;
	}



	public String getDrField() {
		return drField;
	}



	@Override
	public String toString() {
		return "HpMemberListDTO [drId=" + drId + ", deptName=" + deptName + ", drPosition=" + drPosition + ", drName="
				+ drName + ", drField=" + drField + "]";
	}

	
	
	
}
