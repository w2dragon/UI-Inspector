package lg.cns.ds.domain;

import java.io.Serializable;

import com.opencsv.bean.CsvBindByName;

public class UIMng extends Request implements Serializable {

	private static final long serialVersionUID = 1L;

	private String uiCd;
	private String uiNm;
	private String useYn;
	private String frstCrtrId;
	private String frstCrdt;
	private String lstMdfrId;
	private String lstMddt;
	
	public String getUiCd() {
		return uiCd;
	}
	public void setUiCd(String uiCd) {
		this.uiCd = uiCd;
	}
	public String getUiNm() {
		return uiNm;
	}
	public void setUiNm(String uiNm) {
		this.uiNm = uiNm;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getFrstCrtrId() {
		return frstCrtrId;
	}
	public void setFrstCrtrId(String frstCrtrId) {
		this.frstCrtrId = frstCrtrId;
	}
	public String getFrstCrdt() {
		return frstCrdt;
	}
	public void setFrstCrdt(String frstCrdt) {
		this.frstCrdt = frstCrdt;
	}
	public String getLstMdfrId() {
		return lstMdfrId;
	}
	public void setLstMdfrId(String lstMdfrId) {
		this.lstMdfrId = lstMdfrId;
	}
	public String getLstMddt() {
		return lstMddt;
	}
	public void setLstMddt(String lstMddt) {
		this.lstMddt = lstMddt;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
