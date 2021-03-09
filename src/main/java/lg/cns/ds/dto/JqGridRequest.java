package lg.cns.ds.dto;

import java.math.BigInteger;
import java.util.List;

public class JqGridRequest {

	private boolean _search;
	private BigInteger nd;
	/**
	 * rows per page
	 */
	private Integer rows;
	/**
	 * page number. starting from 0
	 */
	private Integer page;
	/**
	 * sort field
	 */
	private String sidx;
	/**
	 * sort order (asc, desc)
	 */
	private String sord;
	
	private String dateStart;
	
	private String dateEnd;
	
	private List<String> requestStatus;
	
	private String requester;
	
	private String rejectionReason;
	
	private String queryContent;
	
	private String domainContent;

	public boolean is_search() {
		return _search;
	}

	public void set_search(boolean _search) {
		this._search = _search;
	}

	public BigInteger getNd() {
		return nd;
	}

	public void setNd(BigInteger nd) {
		this.nd = nd;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public String getSidx() {
		return sidx;
	}

	public void setSidx(String sidx) {
		this.sidx = sidx;
	}

	public String getSord() {
		return sord;
	}

	public void setSord(String sord) {
		this.sord = sord;
	}
	
	public String getDateStart() {
		return dateStart;
	}

	public void setDateStart(String dateStart) {
		this.dateStart = dateStart;
	}

	public String getDateEnd() {
		return dateEnd;
	}

	public void setDateEnd(String dateEnd) {
		this.dateEnd = dateEnd;
	}

	public List<String> getRequestStatus() {
		return requestStatus;
	}

	public void setRequestStatus(List<String> requestStatus) {
		this.requestStatus = requestStatus;
	}

	public String getRequester() {
		return requester;
	}

	public void setRequester(String requester) {
		this.requester = requester;
	}

	public String getRejectionReason() {
		return rejectionReason;
	}

	public void setRejectionReason(String rejectionReason) {
		this.rejectionReason = rejectionReason;
	}

	public String getQueryContent() {
		return queryContent;
	}

	public void setQueryContent(String queryContent) {
		this.queryContent = queryContent;
	}

	public String toString() {
		String ret = "";
		if (requestStatus != null) {
			ret += "requestStatus[0]: " + requestStatus.get(0);
		}
		ret += " dateStart: " + dateStart + " rows: " + rows.toString() + " page: " + page.toString() + " sord: " + sord.toString() + " sidx: " + sidx.toString();
		return ret;
	}

	public String getDomainContent() {
		return domainContent;
	}

	public void setDomainContent(String domainContent) {
		this.domainContent = domainContent;
	}

}
