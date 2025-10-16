package com.project.hospital.health.dto;

import java.util.Arrays;

public class DeleteDTO {
	private String[] selectedId;

	public DeleteDTO() {
		super();
	}

	public DeleteDTO(String[] selectedId) {
		super();
		this.selectedId = selectedId;
	}

	public String[] getSelectedId() {
		return selectedId;
	}

	public void setSelectedId(String[] selectedId) {
		this.selectedId = selectedId;
	}

	@Override
	public String toString() {
		return "DeleteDTO [selectedId=" + Arrays.toString(selectedId) + "]";
	}

	
	

}
