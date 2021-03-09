package lg.cns.ds.domain;

import java.io.Serializable;

import com.opencsv.bean.CsvBindByName;

public class UICmpnMng extends Request implements Serializable {

	private static final long serialVersionUID = 1L;

	private String uiCd;
	private String cmpnCd;
	private String cmpnNm;
	private String useYn;
	private String frstCrtrId;
	private String frstCrdt;
	private String lstMdfrId;
	private String lstMddt;
	
	
	public String getCmpnCd() {
		return cmpnCd;
	}
	public void setCmpnCd(String cmpnCd) {
		this.cmpnCd = cmpnCd;
	}
	public String getCmpnNm() {
		return cmpnNm;
	}
	public void setCmpnNm(String cmpnNm) {
		this.cmpnNm = cmpnNm;
	}
	public String getUiCd() {
		return uiCd;
	}
	public void setUiCd(String uiCd) {
		this.uiCd = uiCd;
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
