
package com.bookdabang.lcs.domain;

import java.sql.Timestamp;

public class MemberDTO {
	private String userId;
	private String userPwd;
	private String nickName;
	private String userEmail;
	private String gender;
	private String birth;
	private String phoneNum;
	private String userName;
	private Timestamp memberWhen;
	private Timestamp latsLogin;
	private String recommend;
	public MemberDTO() {
		super();
	}
	public MemberDTO(String userId, String userPwd, String nickName, String userEmail, String gender, String birth,
			String phoneNum, String userName, Timestamp memberWhen, Timestamp latsLogin, String recommend) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.nickName = nickName;
		this.userEmail = userEmail;
		this.gender = gender;
		this.birth = birth;
		this.phoneNum = phoneNum;
		this.userName = userName;
		this.memberWhen = memberWhen;
		this.latsLogin = latsLogin;
		this.recommend = recommend;
	}
	public final String getUserId() {
		return userId;
	}
	public final void setUserId(String userId) {
		this.userId = userId;
	}
	public final String getUserPwd() {
		return userPwd;
	}
	public final void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public final String getNickName() {
		return nickName;
	}
	public final void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public final String getUserEmail() {
		return userEmail;
	}
	public final void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public final String getGender() {
		return gender;
	}
	public final void setGender(String gender) {
		this.gender = gender;
	}
	public final String getBirth() {
		return birth;
	}
	public final void setBirth(String birth) {
		this.birth = birth;
	}
	public final String getPhoneNum() {
		return phoneNum;
	}
	public final void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public final String getUserName() {
		return userName;
	}
	public final void setUserName(String userName) {
		this.userName = userName;
	}
	public final Timestamp getMemberWhen() {
		return memberWhen;
	}
	public final void setMemberWhen(Timestamp memberWhen) {
		this.memberWhen = memberWhen;
	}
	public final Timestamp getLatsLogin() {
		return latsLogin;
	}
	public final void setLatsLogin(Timestamp latsLogin) {
		this.latsLogin = latsLogin;
	}
	public final String getRecommend() {
		return recommend;
	}
	public final void setRecommend(String recommend) {
		this.recommend = recommend;
	}
	@Override
	public String toString() {
		return "MemberDTO [userId=" + userId + ", userPwd=" + userPwd + ", nickName=" + nickName + ", userEmail="
				+ userEmail + ", gender=" + gender + ", birth=" + birth + ", phoneNum=" + phoneNum + ", userName="
				+ userName + ", memberWhen=" + memberWhen + ", latsLogin=" + latsLogin + ", recommend=" + recommend
				+ "]";
	}
	
}
