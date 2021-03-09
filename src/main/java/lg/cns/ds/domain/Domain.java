package lg.cns.ds.domain;

import java.io.Serializable;

import com.opencsv.bean.CsvBindByName;

public class Domain extends Request implements Serializable {

	private static final long serialVersionUID = 1L;

	@CsvBindByName(column = "*도메인")
	private String domain;
	@CsvBindByName(column = "도메인타입")
	private String domainType;
	private String type;
	@CsvBindByName(column = "*유형")
	private String typeText;
	@CsvBindByName(column = "단어조합")
	private String wordUnionKor;
	@CsvBindByName(column = "영문명")
	private String wordUnionEng;
	private String dataType;
	@CsvBindByName(column = "*데이터타입")
	private String dataTypeText;
	@CsvBindByName(column = "*데이터길이")
	private String dataLength;
	@CsvBindByName(column = "데이터타입(길이)")
	private String dataTypeLength;
	@CsvBindByName(column = "정의")
	private String definition;
	private int word1Id;
	private int word2Id;
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getWordUnionKor() {
		return wordUnionKor;
	}
	public void setWordUnionKor(String wordUnionKor) {
		this.wordUnionKor = wordUnionKor;
	}
	public String getWordUnionEng() {
		return wordUnionEng;
	}
	public void setWordUnionEng(String wordUnionEng) {
		this.wordUnionEng = wordUnionEng;
	}
	public String getDataType() {
		return dataType;
	}
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	public String getDataLength() {
		return dataLength;
	}
	public void setDataLength(String dataLength) {
		this.dataLength = dataLength;
	}
	public String getDefinition() {
		return definition;
	}
	public void setDefinition(String definition) {
		this.definition = definition;
	}
	public int getWord1Id() {
		return word1Id;
	}
	public void setWord1Id(int word1Id) {
		this.word1Id = word1Id;
	}
	public int getWord2Id() {
		return word2Id;
	}
	public void setWord2Id(int word2Id) {
		this.word2Id = word2Id;
	}
	public String getTypeText() {
		return typeText;
	}
	public void setTypeText(String typeText) {
		this.typeText = typeText;
	}
	public String getDataTypeText() {
		return dataTypeText;
	}
	public void setDataTypeText(String dataTypeText) {
		this.dataTypeText = dataTypeText;
	}
	public String getDataTypeLength() {
		return dataTypeLength;
	}
	public void setDataTypeLength(String dataTypeLength) {
		this.dataTypeLength = dataTypeLength;
	}
	public String getDomainType() {
		return domainType;
	}
	public void setDomainType(String domainType) {
		this.domainType = domainType;
	}
		
}
