package com.bookdabang.ljs.domain;

public class LoginDTO {
	private String userId; 
	private String pwd;
	private boolean autoLogin;
	private String sessionId;
	
	public LoginDTO() {}

	public LoginDTO(String userId, String pwd, boolean autoLogin, String sessionId) {
		super();
		this.userId = userId;
		this.pwd = pwd;
		this.autoLogin = autoLogin;
		this.sessionId = sessionId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public boolean isAutoLogin() {
		return autoLogin;
	}

	public void setAutoLogin(boolean autoLogin) {
		this.autoLogin = autoLogin;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	@Override
	public String toString() {
		return "LoginDTO [userId=" + userId + ", pwd=" + pwd + ", autoLogin=" + autoLogin + ", sessionId=" + sessionId
				+ "]";
	}
	

	

	
	
	

}
