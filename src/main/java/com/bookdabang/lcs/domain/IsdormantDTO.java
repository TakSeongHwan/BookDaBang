
package com.bookdabang.lcs.domain;

public class IsdormantDTO {
	private String userId;
	private String isdormant;
	
	public IsdormantDTO() {
		super();
	}

	public IsdormantDTO(String userId, String isdormant) {
		super();
		this.userId = userId;
		this.isdormant = isdormant;
	}

	public final String getUserId() {
		return userId;
	}
	public final void setUserId(String userId) {
		this.userId = userId;
	}
	public final String getIsdormant() {
		return isdormant;
	}
	public final void setIsdormant(String isdormant) {
		this.isdormant = isdormant;
	}
	@Override
	public String toString() {
		return "isdormantDTO [userId=" + userId + ", isdormant=" + isdormant + "]";
	}
	
}
