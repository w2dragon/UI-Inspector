package lg.cns.ds.domain;

import java.io.Serializable;

public class UIInspectMngSearchCnd implements Serializable {

	private static final long serialVersionUID = 1L;
		
	private String dateStart;
	private String dateEnd;
	private String selected_uitool;
	private String selected_prjtCd;
	private String search_vldtRstYn;
	private String search_itrtSeq;
	private String search_flId;
	private String search_vldtSbjTermCd;
	private String search_vldtSbjTermNm;
	private String search_vldtRuleCd;
	private String search_vldtRuleNm;
	private String search_frstCrtrId;
	
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
	public String getSelected_prjtCd() {
		return selected_prjtCd;
	}
	public void setSelected_prjtCd(String selected_prjtCd) {
		this.selected_prjtCd = selected_prjtCd;
	}
	public String getSearch_vldtRstYn() {
		return search_vldtRstYn;
	}
	public void setSearch_vldtRstYn(String search_vldtRstYn) {
		this.search_vldtRstYn = search_vldtRstYn;
	}
	public String getSearch_itrtSeq() {
		return search_itrtSeq;
	}
	public void setSearch_itrtSeq(String search_itrtSeq) {
		this.search_itrtSeq = search_itrtSeq;
	}
	public String getSearch_flId() {
		return search_flId;
	}
	public void setSearch_flId(String search_flId) {
		this.search_flId = search_flId;
	}
	public String getSearch_vldtSbjTermCd() {
		return search_vldtSbjTermCd;
	}
	public void setSearch_vldtSbjTermCd(String search_vldtSbjTermCd) {
		this.search_vldtSbjTermCd = search_vldtSbjTermCd;
	}
	public String getSearch_vldtSbjTermNm() {
		return search_vldtSbjTermNm;
	}
	public void setSearch_vldtSbjTermNm(String search_vldtSbjTermNm) {
		this.search_vldtSbjTermNm = search_vldtSbjTermNm;
	}
	public String getSearch_vldtRuleCd() {
		return search_vldtRuleCd;
	}
	public void setSearch_vldtRuleCd(String search_vldtRuleCd) {
		this.search_vldtRuleCd = search_vldtRuleCd;
	}
	public String getSearch_vldtRuleNm() {
		return search_vldtRuleNm;
	}
	public void setSearch_vldtRuleNm(String search_vldtRuleNm) {
		this.search_vldtRuleNm = search_vldtRuleNm;
	}
	public String getSearch_frstCrtrId() {
		return search_frstCrtrId;
	}
	public void setSearch_frstCrtrId(String search_frstCrtrId) {
		this.search_frstCrtrId = search_frstCrtrId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
}
