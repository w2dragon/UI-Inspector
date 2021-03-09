package lg.cns.ds.domain;

import java.io.Serializable;

import com.opencsv.bean.CsvBindByName;
public class Word extends Request implements Serializable {

	private static final long serialVersionUID = 1L;
	@CsvBindByName(column = "*표준단어")
	private String standardWord;
	@CsvBindByName(column = "*영문명")
	private String standardWordEng;
	@CsvBindByName(column = "*영문약어")
	private String abbrevationEng;
	@CsvBindByName(column = "유사어")
	private String synonyms;
	private String isClassified;
	@CsvBindByName(column = "분류어 여부")
	private String isClassifiedText;
	@CsvBindByName(column = "출처")
	private String source;
	@CsvBindByName(column = "*정의")
	private String definition;
	@CsvBindByName(column = "변경여부")
	private String isModified;
	
	public String getStandardWord() {
		return standardWord;
	}
	public void setStandardWord(String standardWord) {
		this.standardWord = standardWord;
	}
	public String getStandardWordEng() {
		return standardWordEng;
	}
	public void setStandardWordEng(String standardWordEng) {
		this.standardWordEng = standardWordEng;
	}
	public String getAbbrevationEng() {
		return abbrevationEng;
	}
	public void setAbbrevationEng(String abbrevationEng) {
		this.abbrevationEng = abbrevationEng;
	}
	public String getSynonyms() {
		return synonyms;
	}
	public void setSynonyms(String synonyms) {
		this.synonyms = synonyms;
	}
	public String getIsClassified() {
		return isClassified;
	}
	public void setIsClassified(String isClassified) {
		this.isClassified = isClassified;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getDefinition() {
		return definition;
	}
	public void setDefinition(String definition) {
		this.definition = definition;
	}
	public String getIsClassifiedText() {
		return isClassifiedText;
	}
	public void setIsClassifiedText(String isClassifiedText) {
		this.isClassifiedText = isClassifiedText;
	}
	public String getIsModified() {
		return isModified;
	}
	public void setIsModified(String isModified) {
		this.isModified = isModified;
	}
}
