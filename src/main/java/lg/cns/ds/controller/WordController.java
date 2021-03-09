package lg.cns.ds.controller;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.opencsv.exceptions.CsvDataTypeMismatchException;
import com.opencsv.exceptions.CsvRequiredFieldEmptyException;

import lg.cns.ds.domain.CommonDict;
import lg.cns.ds.domain.User;
import lg.cns.ds.domain.Word;
import lg.cns.ds.dto.JqGridRequest;
import lg.cns.ds.dto.JqGridResponse;
import lg.cns.ds.service.CommonDictService;
import lg.cns.ds.service.WordService;


@RestController
@RequestMapping("/word")
public class WordController {
	
	@Autowired
	WordService wordService;
	
	@Autowired
	CommonDictService commonDictService;

	private static final Logger LOG = LoggerFactory.getLogger(WordController.class);
	
	@PostMapping("/download_excel")
	public void download_excel(HttpServletRequest request, HttpServletResponse response, @RequestBody HashMap<String, Object> aRequest) {
		String sTemplatePath = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/excel_template");
		List<Word> list = wordService.getWordListApproved(aRequest);
		List<CommonDict> aCommonDictList6 = commonDictService.getCommonDictList("6");
		for (int i = 0; i < list.size(); i += 1) {
			Word oWord = list.get(i);
			oWord.setFirstname(oWord.getFirstname() + " (" + oWord.getUsername() + ")");
			if (oWord.getRegistStatus().equals("2")) {
				// modified
				for (int j = 0; j < aCommonDictList6.size(); j += 1) {
					CommonDict oCommonDict = aCommonDictList6.get(j);
					if (oCommonDict.getGrpCode().equals("1")) {
						// Y
						oWord.setIsModified(oCommonDict.getName());
						break;
					}
				}
			} else {
				// initial
				for (int j = 0; j < aCommonDictList6.size(); j += 1) {
					CommonDict oCommonDict = aCommonDictList6.get(j);
					if (oCommonDict.getGrpCode().equals("2")) {
						// N
						oWord.setIsModified(oCommonDict.getName());
						break;
					}
				}
			}
		}
	    try (InputStream is = new FileInputStream(sTemplatePath + "/word_template.xls")) {
	    	try (OutputStream os = response.getOutputStream()) {
	    		response.setContentType("application/vnd.ms-excel");
	    		SimpleDateFormat formatter = new SimpleDateFormat ("yyyyMMddHHmmss");
	    		Calendar cal = Calendar.getInstance();
	    		String sTimeStamp = formatter.format(cal.getTime());
	    		String saveName = "wordlist_" + sTimeStamp;
				response.setHeader("Content-Disposition", "attachment; filename=\"" + saveName + ".xls\"");
	            Context context = new Context();
	            context.putVar("words", list);
	            JxlsHelper.getInstance().processTemplate(is, os, context);
	        }
	    } catch (IOException e) {
			e.printStackTrace();
		}
		return;
	}
	@PostMapping("/download_excel_all")
	public void download_excel_all(HttpServletRequest request, HttpServletResponse response, JqGridRequest req) throws CsvDataTypeMismatchException, CsvRequiredFieldEmptyException, IOException {
		String sTemplatePath = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/excel_template");
		req.setSidx("requestId");
		req.setSord("desc");
		if (req.getDateStart() != null) {
			if (req.getDateStart().trim().length() > 0) {
				req.setDateStart(req.getDateStart().trim() + " 00:00:00");
			}
		}
		if (req.getDateEnd() != null) {
			if (req.getDateEnd().trim().length() > 0) {
				req.setDateEnd(req.getDateEnd().trim() + " 23:59:59");
			}
		}
		int iTotalCount = wordService.getRecordCount(req);
		List<Word> list = wordService.getWordList(0, iTotalCount, req);
		
		List<CommonDict> aCommonDictList6 = commonDictService.getCommonDictList("6");
		for (int i = 0; i < list.size(); i += 1) {
			Word oWord = list.get(i);
			oWord.setFirstname(oWord.getFirstname() + " (" + oWord.getUsername() + ")");
			if (oWord.getRegistStatus().equals("2")) {
				// modified
				for (int j = 0; j < aCommonDictList6.size(); j += 1) {
					CommonDict oCommonDict = aCommonDictList6.get(j);
					if (oCommonDict.getGrpCode().equals("1")) {
						// Y
						oWord.setIsModified(oCommonDict.getName());
						break;
					}
				}
			} else {
				// initial
				for (int j = 0; j < aCommonDictList6.size(); j += 1) {
					CommonDict oCommonDict = aCommonDictList6.get(j);
					if (oCommonDict.getGrpCode().equals("2")) {
						// N
						oWord.setIsModified(oCommonDict.getName());
						break;
					}
				}
			}
		}
		//exporting excell worksheet starts here.
		OutputStream os = null;
		try {
			
			 String[] columns = new String[]  
	                {		
	                		"ID", // requestStatus
	            		    "상태", // registStatus
	            		    "구분", // isNormal
	            		    "검사",
	            		    "*표준 단어",
	            		    "*영문 약어",
	            		    "*영문명",
	            		    "유사어", // isClassified
	            		    "분류어 여부",
	            		    "출처",
	            		    "*정의",
	            		    "신청자", // username
	            		    "신청일시",
	            		    "변경여부"
	                }; 
            
            HSSFWorkbook wb = new HSSFWorkbook();//Whole book
            HSSFSheet currentSheet = allocateNewSheet(wb, "SHEET");//Initial sheet
            int sheetCounter = 1;//Start at 1 because we already created Initial sheet
            int rowCounter = 0;//1st row in sheet
            for(Word t: list) {//Loop through data
                if(rowCounter % 65535 == 0) {//Max row reached, build new sheet
                    //Increase sheetCounter
                    if(rowCounter > 0){
                    	sheetCounter++;
	                    String new_sheetName = "SHEET_"+sheetCounter;//Name of sheet
	                    currentSheet = allocateNewSheet(wb, new_sheetName);//Point currentSheet to new sheet
                    }
                    //Reset rowCounter to 0
                    rowCounter = 0;
                    HSSFRow row0 = currentSheet.createRow(rowCounter);
                    for(int i=0;i<columns.length;i++){
                    	row0.createCell(i).setCellValue(columns[i]);
                    }
                }
                rowCounter++;
                HSSFRow row = currentSheet.createRow(rowCounter);
                //Write data.......
            	int cellIndex = 0;
                //first place in row is name
            	row.createCell(cellIndex++).setCellValue(t.getRequestId());
            	row.createCell(cellIndex++).setCellValue(t.getRequestStatusText());
            	row.createCell(cellIndex++).setCellValue(t.getRegistStatusText());
            	row.createCell(cellIndex++).setCellValue(t.getIsNormalText());
                row.createCell(cellIndex++).setCellValue(t.getStandardWord());
                row.createCell(cellIndex++).setCellValue(t.getAbbrevationEng());
                row.createCell(cellIndex++).setCellValue(t.getStandardWordEng());
                row.createCell(cellIndex++).setCellValue(t.getSynonyms());
                row.createCell(cellIndex++).setCellValue(t.getIsClassifiedText());
                row.createCell(cellIndex++).setCellValue(t.getSource());
                row.createCell(cellIndex++).setCellValue(t.getDefinition());
                row.createCell(cellIndex++).setCellValue(t.getFirstname());
                row.createCell(cellIndex++).setCellValue(t.getCreatedDate());
                row.createCell(cellIndex++).setCellValue(t.getIsModified());
            }
			
			SimpleDateFormat formatter = new SimpleDateFormat ("yyyyMMddHHmmss");
    		Calendar cal = Calendar.getInstance();
    		String sTimeStamp = formatter.format(cal.getTime());
    		String saveName = "wordlist_" + sTimeStamp;
			
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + saveName + ".xls\"");
			
			os = response.getOutputStream();
			wb.write(os);
			
			os.flush();
			os.close();
		}
		catch (IOException e) {
			LOG.error("MakeExcel Exception : {}", e.getMessage(), e);
		}
		finally {
			if (os != null)
				os = null;
		}
        return;
	}
	
	private static HSSFSheet allocateNewSheet(HSSFWorkbook wb, String sheetName) {
	    HSSFSheet sheet = wb.createSheet(sheetName);
	    return sheet;
	}
	
	
	@PostMapping("/list_approved")
	public JqGridResponse<Word> wordlist_approved(JqGridRequest req) {
		if (req.getDateStart() != null) {
			if (req.getDateStart().trim().length() > 0) {
				req.setDateStart(req.getDateStart().trim() + " 00:00:00");
			}
		}
		if (req.getDateEnd() != null) {
			if (req.getDateEnd().trim().length() > 0) {
				req.setDateEnd(req.getDateEnd().trim() + " 23:59:59");
			}
		}
		JqGridResponse<Word> res = new JqGridResponse<Word>();
		int iTotalCount = wordService.getRecordCount(req);
		res.setRecords(iTotalCount);
		res.setPage(req.getPage());
		res.setTotal((iTotalCount + req.getRows() - 1) / req.getRows());
		int offset = (req.getPage() - 1) * req.getRows();
		List<Word> list = wordService.getWordList(offset, Math.min(offset + req.getRows(), iTotalCount), req);
		List<CommonDict> aCommonDictList6 = commonDictService.getCommonDictList("6");
		for (int i = 0; i < list.size(); i += 1) {
			Word oWord = list.get(i);
			oWord.setFirstname(oWord.getFirstname() + " (" + oWord.getUsername() + ")");
			if (oWord.getRegistStatus().equals("2")) {
				// modified
				for (int j = 0; j < aCommonDictList6.size(); j += 1) {
					CommonDict oCommonDict = aCommonDictList6.get(j);
					if (oCommonDict.getGrpCode().equals("1")) {
						// Y
						oWord.setIsModified(oCommonDict.getName());
						break;
					}
				}
			} else {
				// initial
				for (int j = 0; j < aCommonDictList6.size(); j += 1) {
					CommonDict oCommonDict = aCommonDictList6.get(j);
					if (oCommonDict.getGrpCode().equals("2")) {
						// N
						oWord.setIsModified(oCommonDict.getName());
						break;
					}
				}
			}
		}
		res.setRows(list);
		return res;
	}
	
	@PostMapping("/list")
	public JqGridResponse<Word> wordlist(JqGridRequest req, @RequestParam(required=false, value="aRequestStatus[]") String[] aRequestStatus) {
		if (aRequestStatus != null) {
			if (aRequestStatus.length > 0) {
				List<String> aList = new ArrayList<String>();
				for (int i = 0; i < aRequestStatus.length; i += 1) {
					aList.add(aRequestStatus[i]);
				}
				req.setRequestStatus(aList);
			}
		}
		if (req.getDateStart() != null) {
			if (req.getDateStart().trim().length() > 0) {
				req.setDateStart(req.getDateStart().trim() + " 00:00:00");
			}
		}
		if (req.getDateEnd() != null) {
			if (req.getDateEnd().trim().length() > 0) {
				req.setDateEnd(req.getDateEnd().trim() + " 23:59:59");
			}
		}
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		JqGridResponse<Word> res = new JqGridResponse<Word>();
		int iTotalCount = wordService.getRecordCount(oCurrentUser, req);
		res.setRecords(iTotalCount);
		res.setPage(req.getPage());
		res.setTotal((iTotalCount + req.getRows() - 1) / req.getRows());
		int offset = (req.getPage() - 1) * req.getRows();
		List<Word> list = wordService.getWordList(oCurrentUser, offset, Math.min(offset + req.getRows(), iTotalCount), req);
		List<CommonDict> aCommonDictList6 = commonDictService.getCommonDictList("6");
		for (int i = 0; i < list.size(); i += 1) {
			Word oWord = list.get(i);
			oWord.setFirstname(oWord.getFirstname() + " (" + oWord.getUsername() + ")");
			if (oWord.getRegistStatus().equals("2")) {
				// modified
				for (int j = 0; j < aCommonDictList6.size(); j += 1) {
					CommonDict oCommonDict = aCommonDictList6.get(j);
					if (oCommonDict.getGrpCode().equals("1")) {
						// Y
						oWord.setIsModified(oCommonDict.getName());
						break;
					}
				}
			} else {
				// initial
				for (int j = 0; j < aCommonDictList6.size(); j += 1) {
					CommonDict oCommonDict = aCommonDictList6.get(j);
					if (oCommonDict.getGrpCode().equals("2")) {
						// N
						oWord.setIsModified(oCommonDict.getName());
						break;
					}
				}
			}
		}
		res.setRows(list);
		return res;
	}
	
	@PostMapping("/post")
	public Map<String, Object> postWord(Word word) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		Map<String, Object> oResult = new HashMap<String, Object>();
		oResult.put("result", 0);
		oResult.put("message", "Forbidden");
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			boolean bFound = true;
			if ((word.getStandardWord() == null || word.getStandardWord().equals("")) && (word.getAbbrevationEng() == null || word.getAbbrevationEng().equals(""))) {
				bFound = false;
			} else {
				bFound = wordService.checkWord(word.getRequestId(), word.getStandardWord(), word.getAbbrevationEng());
			}
			if (bFound == false) {
				if (word.getStandardWord().trim().length() > 0 && word.getStandardWordEng().trim().length() > 0 && word.getAbbrevationEng().trim().length() > 0 && word.getDefinition().trim().length() > 0) {
					word.setIsNormal("1"); // normal
				} else {
					word.setIsNormal("2"); // abnormal
				}
				if (word.getRequestId() == -1) {
					word.setUsername(oCurrentUser.getUsername());
					word.setRequestType("word");
					word.setRequestStatus("1");
					word.setRegistStatus("1");
					wordService.createNewWord(word);
					oResult.put("result", 1);
					oResult.put("message", "Added");
					oResult.put("entity", word);
				} else {
					word.setUsername(oCurrentUser.getUsername());
					word.setRequestType("word");
					wordService.updateExistingWord(word);
					//clearing rejection reason when status is rejection
					if("4".equals(word.getRequestStatus())){
						word.setRejectionReason("");
						wordService.updateRejectionStatus(word);
					}
					
					oResult.put("result", 2);
					oResult.put("message", "Updated");
					oResult.put("entity", word);
				}
			} else {
				oResult.put("result", 3);
				oResult.put("message", "Duplicated");
			}
		}
		return oResult;
	}
	
	@PostMapping("/updateRejectionReason")
	public Map<String, Object> updateRejectionReason(Word word) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		Map<String, Object> oResult = new HashMap<String, Object>();
		oResult.put("result", 0);
		oResult.put("message", "Forbidden");
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			wordService.updateRejectionStatus(word);
			oResult.put("result", 2);
			oResult.put("message", "Updated");
			oResult.put("entity", word);
		}
		return oResult;
	}
	
	@PostMapping("/make_request")
	public void makeRequest(@RequestBody HashMap<String, Object> aRequest) {
		// LOG.debug("List of request ID: " + aRequest.get("aSelectedRequestId"));
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			aRequest.put("username", oCurrentUser.getUsername());
			wordService.makeRequest(aRequest);
		}
	}
	
	@PostMapping("/cancel_request")
	public void cancelRequest(@RequestBody HashMap<String, Object> aRequest) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			aRequest.put("username", oCurrentUser.getUsername());
			wordService.cancelRequest(aRequest);
		}
	}
	
	@PostMapping("/approve_request")
	public void approveRequest(@RequestBody HashMap<String, Object> aRequest) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			aRequest.put("username", oCurrentUser.getUsername());
			wordService.approveRequest(aRequest);
		}
	}
	
	@PostMapping("/reject_request")
	public void rejectRequest(@RequestBody HashMap<String, Object> aRequest) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			aRequest.put("username", oCurrentUser.getUsername());
			wordService.rejectRequest(aRequest);
		}
	}
}
