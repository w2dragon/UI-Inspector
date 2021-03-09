package lg.cns.ds.domain;

import java.io.Serializable;

public class CommonDict implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int id;
	private String grpId;
	private String grpCode;
	private String name;
	private String attr1;
	private String attr2;
	private String attr3;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGrpId() {
		return grpId;
	}
	public void setGrpId(String grpId) {
		this.grpId = grpId;
	}
	public String getGrpCode() {
		return grpCode;
	}
	public void setGrpCode(String grpCode) {
		this.grpCode = grpCode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAttr1() {
		return attr1;
	}
	public void setAttr1(String attr1) {
		this.attr1 = attr1;
	}
	public String getAttr2() {
		return attr2;
	}
	public void setAttr2(String attr2) {
		this.attr2 = attr2;
	}
	public String getAttr3() {
		return attr3;
	}
	public void setAttr3(String attr3) {
		this.attr3 = attr3;
	}
	
	
	
	
}
