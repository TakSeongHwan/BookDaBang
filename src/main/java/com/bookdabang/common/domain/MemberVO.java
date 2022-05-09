package com.bookdabang.common.domain;

import java.sql.Timestamp;

public class MemberVO {
	private String userId;
	private String userPwd;
	private String nickName;
	private String userEmail;
	private String isAdmin;
	private String gender;
	private Timestamp birth;
	private String phoneNum;
	private Timestamp memberWhen;
	private Timestamp lastLogin;
	private String isDraw;
	private String userName;
	private String sessionId;
	private String apiType;

	public MemberVO(String userId, String userPwd, String nickName, String userEmail, String isAdmin, String gender,
			Timestamp birth, String phoneNum, Timestamp memberWhen, Timestamp lastLogin, String isDraw, String userName,
			String sessionId, String apiType) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.nickName = nickName;
		this.userEmail = userEmail;
		this.isAdmin = isAdmin;
		this.gender = gender;
		this.birth = birth;
		this.phoneNum = phoneNum;
		this.memberWhen = memberWhen;
		this.lastLogin = lastLogin;
		this.isDraw = isDraw;
		this.userName = userName;
		this.sessionId = sessionId;
		this.apiType = apiType;
	}
	
	public MemberVO(String userId, String nickName, String userEmail, String gender,
			String userName, String sessionId, String apiType) {
		
		super();
		this.userId = userId;
		this.nickName = nickName;
		this.userEmail = userEmail;
		this.gender = gender;
		this.userName = userName;
		this.sessionId = sessionId;
		
	}

	public MemberVO() {
		super();
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Timestamp getBirth() {
		return birth;
	}

	public void setBirth(Timestamp birth) {
		this.birth = birth;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public Timestamp getMemberWhen() {
		return memberWhen;
	}

	public void setMemberWhen(Timestamp memberWhen) {
		this.memberWhen = memberWhen;
	}

	public Timestamp getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Timestamp lastLogin) {
		this.lastLogin = lastLogin;
	}

	public String getIsDraw() {
		return isDraw;
	}

	public void setIsDraw(String isDraw) {
		this.isDraw = isDraw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getApiType() {
		return apiType;
	}

	public void setApiType(String apiType) {
		this.apiType = apiType;
	}

	@Override
	public String toString() {
		return "MemberVO [userId=" + userId + ", userPwd=" + userPwd + ", nickName=" + nickName + ", userEmail="
				+ userEmail + ", isAdmin=" + isAdmin + ", gender=" + gender + ", birth=" + birth + ", phoneNum="
				+ phoneNum + ", memberWhen=" + memberWhen + ", lastLogin=" + lastLogin + ", isDraw=" + isDraw
				+ ", userName=" + userName + ", sessionId=" + sessionId + ", apiType=" + apiType + "]";
	}

}
