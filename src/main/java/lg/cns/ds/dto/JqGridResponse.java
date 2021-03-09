package lg.cns.ds.dto;

import java.util.List;

public class JqGridResponse<T> {

	/**
	 * current page
	 */
	private int page;
	/**
	 * total number of pages
	 */
	private int total;
	/**
	 * total number of records
	 */
	private int records;
	/**
	 * rows of current page
	 */
	private List<T> rows;

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

}
