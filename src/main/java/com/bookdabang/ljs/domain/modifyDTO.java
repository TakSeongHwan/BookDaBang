package com.bookdabang.ljs.domain;

public class modifyDTO {
	
	private String userId;
	private String userName;
	private String nickName;
	private String phoneNum;
	private String userEmail;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	@Override
	public String toString() {
		return "modifyDTO [userId=" + userId + ", userName=" + userName + ", nickName=" + nickName + ", phoneNum="
				+ phoneNum + ", userEmail=" + userEmail + "]";
	}
	
		
	

}
