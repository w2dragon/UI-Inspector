package lg.cns.ds.domain;

import java.io.Serializable;

import com.opencsv.bean.CsvBindByName;

public class Request implements Serializable {

	private static final long serialVersionUID = 1L;
	@CsvBindByName(column = "REQUESTID")
	private int requestId;
	private String requestType;
	private String requestStatus;
	@CsvBindByName(column = "상태")
	private String requestStatusText;
	private String registStatus;
	@CsvBindByName(column = "구분")
	private String registStatusText;
	private String isNormal;
	@CsvBindByName(column = "검사")
	private String isNormalText;
	private String username;
	@CsvBindByName(column = "신청자")
	private String firstname;
	@CsvBindByName(column = "신청일시")
	private String createdDate;
	private String approveDate;
	private String rejectionReason;
	
	
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public String getRequestType() {
		return requestType;
	}
	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	public String getRequestStatus() {
		return requestStatus;
	}
	public void setRequestStatus(String requestStatus) {
		this.requestStatus = requestStatus;
	}
	public String getRegistStatus() {
		return registStatus;
	}
	public void setRegistStatus(String registStatus) {
		this.registStatus = registStatus;
	}
	public String getIsNormal() {
		return isNormal;
	}
	public void setIsNormal(String isNormal) {
		this.isNormal = isNormal;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}
	public String getApproveDate() {
		return approveDate;
	}
	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}
	public String getRequestStatusText() {
		return requestStatusText;
	}
	public void setRequestStatusText(String requestStatusText) {
		this.requestStatusText = requestStatusText;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getIsNormalText() {
		return isNormalText;
	}
	public void setIsNormalText(String isNormalText) {
		this.isNormalText = isNormalText;
	}
	public String getRegistStatusText() {
		return registStatusText;
	}
	public void setRegistStatusText(String registStatusText) {
		this.registStatusText = registStatusText;
	}
	public String getRejectionReason() {
		return rejectionReason;
	}
	public void setRejectionReason(String rejectionReason) {
		this.rejectionReason = rejectionReason;
	}
}
