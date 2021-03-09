package lg.cns.ds.domain;

import java.io.Serializable;

public class CmpnMngSearchCnd implements Serializable {

	private static final long serialVersionUID = 1L;
		
	private String dateStart;
	private String dateEnd;
	private String selected_uitool;
	
	
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


	public String getSelected_uitool() {
		return selected_uitool;
	}


	public void setSelected_uitool(String selected_uitool) {
		this.selected_uitool = selected_uitool;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
