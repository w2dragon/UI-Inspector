package lg.cns.ds.domain;

import java.io.Serializable;

import com.opencsv.bean.CsvBindByName;

public class Term extends Request implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@CsvBindByName(column = "*용어")
	private String term;
	private int domainId;
	@CsvBindByName(column = "도메인")
	private String domainText;
	@CsvBindByName(column = "도메인타입")
	private String domainTypeText;
	private String type;
	private String domainDataType;
	private String domainDataTypeText;
	private int domainDataLength;
	@CsvBindByName(column = "데이터 타입(길이)")
	private String domainDataTypeLength;
	@CsvBindByName(column = "단어분해")
	private String wordDecompositionKor;
	@CsvBindByName(column = "영문명")
	private String wordDecompositionEng;
	@CsvBindByName(column = "*정의")
	private String definition;

	public String getTerm() {
		return term;
	}

	public void setTerm(String term) {
		this.term = term;
	}

	public int getDomainId() {
		return domainId;
	}

	public void setDomainId(int domainId) {
		this.domainId = domainId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getWordDecompositionKor() {
		return wordDecompositionKor;
	}

	public void setWordDecompositionKor(String wordDecompositionKor) {
		this.wordDecompositionKor = wordDecompositionKor;
	}

	public String getWordDecompositionEng() {
		return wordDecompositionEng;
	}

	public void setWordDecompositionEng(String wordDecompositionEng) {
		this.wordDecompositionEng = wordDecompositionEng;
	}

	public String getDefinition() {
		return definition;
	}

	public void setDefinition(String definition) {
		this.definition = definition;
	}

	public String getDomainText() {
		return domainText;
	}

	public void setDomainText(String domainText) {
		this.domainText = domainText;
	}

	public String getDomainDataType() {
		return domainDataType;
	}

	public void setDomainDataType(String domainDataType) {
		this.domainDataType = domainDataType;
	}

	public String getDomainDataTypeText() {
		return domainDataTypeText;
	}

	public void setDomainDataTypeText(String domainDataTypeText) {
		this.domainDataTypeText = domainDataTypeText;
	}

	public int getDomainDataLength() {
		return domainDataLength;
	}

	public void setDomainDataLength(int domainDataLength) {
		this.domainDataLength = domainDataLength;
	}

	public String getDomainTypeText() {
		return domainTypeText;
	}

	public void setDomainTypeText(String domainTypeText) {
		this.domainTypeText = domainTypeText;
	}

	public String getDomainDataTypeLength() {
		return domainDataTypeLength;
	}

	public void setDomainDataTypeLength(String domainDataTypeLength) {
		this.domainDataTypeLength = domainDataTypeLength;
	}

}
