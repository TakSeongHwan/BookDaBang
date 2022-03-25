package com.bookdabang.common.domain;

public class AddressVO {

	private int address_no;
	private String userId; 
	private String recipient;
	private String postalcode; 
	private String mainAddress; 
	private String remainaddress;
	private String phonenumber;
	private String deliverymessage;
	public AddressVO() {}
	public AddressVO(int address_no, String userId, String recipient, String postalcode, String mainAddress,
			String remainaddress, String phonenumber, String deliverymessage) {
		super();
		this.address_no = address_no;
		this.userId = userId;
		this.recipient = recipient;
		this.postalcode = postalcode;
		this.mainAddress = mainAddress;
		this.remainaddress = remainaddress;
		this.phonenumber = phonenumber;
		this.deliverymessage = deliverymessage;
	}
	public int getAddress_no() {
		return address_no;
	}
	public void setAddress_no(int address_no) {
		this.address_no = address_no;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getPostalcode() {
		return postalcode;
	}
	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}
	public String getMainAddress() {
		return mainAddress;
	}
	public void setMainAddress(String mainAddress) {
		this.mainAddress = mainAddress;
	}
	public String getRemainaddress() {
		return remainaddress;
	}
	public void setRemainaddress(String remainaddress) {
		this.remainaddress = remainaddress;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getDeliverymessage() {
		return deliverymessage;
	}
	public void setDeliverymessage(String deliverymessage) {
		this.deliverymessage = deliverymessage;
	}
	@Override
	public String toString() {
		return "AddressVO [address_no=" + address_no + ", userId=" + userId + ", recipient=" + recipient
				+ ", postalcode=" + postalcode + ", mainAddress=" + mainAddress + ", remainaddress=" + remainaddress
				+ ", phonenumber=" + phonenumber + ", deliverymessage=" + deliverymessage + "]";
	}
	
	
}
