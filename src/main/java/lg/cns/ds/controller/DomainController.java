package lg.cns.ds.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.opencsv.CSVWriter;
import com.opencsv.bean.HeaderColumnNameMappingStrategy;
import com.opencsv.bean.StatefulBeanToCsv;
import com.opencsv.bean.StatefulBeanToCsvBuilder;
import com.opencsv.exceptions.CsvDataTypeMismatchException;
import com.opencsv.exceptions.CsvRequiredFieldEmptyException;

import org.apache.commons.collections4.comparators.FixedOrderComparator;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jxls.common.Context;
import org.jxls.util.JxlsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import lg.cns.ds.domain.Domain;
import lg.cns.ds.domain.User;
import lg.cns.ds.domain.Word;
import lg.cns.ds.dto.JqGridRequest;
import lg.cns.ds.dto.JqGridResponse;
import lg.cns.ds.service.DomainService;
@RestController
@RequestMapping("/domain")
public class DomainController {

	
	@Autowired
	DomainService domainService;
	
	private static final Logger LOG = LoggerFactory.getLogger(DomainController.class);
	
	@PostMapping("/download_excel")
	public void download_excel(HttpServletRequest request, HttpServletResponse response, @RequestBody HashMap<String, Object> aRequest) {
		String sTemplatePath = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/excel_template");
		List<Domain> list = domainService.getDomainListApproved(aRequest);
		for (int i = 0; i < list.size(); i += 1) {
			Domain oDomain = list.get(i);
			oDomain.setFirstname(oDomain.getFirstname() + " (" + oDomain.getUsername() + ")");
			if (oDomain.getDataTypeText() != null) {
				if (oDomain.getDataLength() != null && oDomain.getDataLength().length() > 0) {
					oDomain.setDataTypeLength(oDomain.getDataTypeText() + "(" + oDomain.getDataLength() + ")");
				} else {
					oDomain.setDataTypeLength(oDomain.getDataTypeText());
				}
				oDomain.setDomainType(oDomain.getDomain() + "_" + oDomain.getDataTypeText().substring(0, 1) + oDomain.getDataLength());
			}
		}
	    try (InputStream is = new FileInputStream(sTemplatePath + "/domain_template.xls")) {
	    	try (OutputStream os = response.getOutputStream()) {
	    		response.setContentType("application/vnd.ms-excel");
	    		SimpleDateFormat formatter = new SimpleDateFormat ("yyyyMMddHHmmss");
	    		Calendar cal = Calendar.getInstance();
	    		String sTimeStamp = formatter.format(cal.getTime());
	    		String saveName = "domainlist_" + sTimeStamp;
				response.setHeader("Content-Disposition", "attachment; filename=\"" + saveName + ".xls\"");
	            Context context = new Context();
	            context.putVar("domains", list);
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
		int iTotalCount = domainService.getRecordCount(req);
		List<Domain> list = domainService.getDomainList(0, iTotalCount, req);
		
		for (int i = 0; i < list.size(); i += 1) {
			Domain oDomain = list.get(i);
			oDomain.setFirstname(oDomain.getFirstname() + " (" + oDomain.getUsername() + ")");
			if (oDomain.getDataTypeText() != null) {
				if (oDomain.getDataLength() != null && oDomain.getDataLength().length() > 0) {
					oDomain.setDataTypeLength(oDomain.getDataTypeText() + "(" + oDomain.getDataLength() + ")");
				} else {
					oDomain.setDataTypeLength(oDomain.getDataTypeText());
				}
				oDomain.setDomainType(oDomain.getDomain() + "_" + oDomain.getDataTypeText().substring(0, 1) + oDomain.getDataLength());
			}
		}
		//exporting excell worksheet starts here.
		OutputStream os = null;
		try {

			 String[] columns = new String[]  
	                {		
	                		"ID",
	            			"상태",
	            			"구분 ",
	            			"검사",
	            			"도메인타입",
	            			"*도메인",
	            			"*유형",
	            			"단어조합",
	            			"영문명",
	            			"*데이터타입",
	            			"*데이터길이",
	            			"데이터타입(길이)",
	            			"*정의",
	            			"신청자",
	            			"신청일시"
	                }; 

            HSSFWorkbook wb = new HSSFWorkbook();//Whole book
            HSSFSheet currentSheet = allocateNewSheet(wb, "SHEET");//Initial sheet
            int sheetCounter = 1;//Start at 1 because we already created Initial sheet
            int rowCounter = 0;//1st row in sheet
            for(Domain t: list) {//Loop through data
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
                row.createCell(cellIndex++).setCellValue(t.getDomainType());
                row.createCell(cellIndex++).setCellValue(t.getDomain());
                row.createCell(cellIndex++).setCellValue(t.getTypeText());
                row.createCell(cellIndex++).setCellValue(t.getWordUnionKor());
                row.createCell(cellIndex++).setCellValue(t.getWordUnionEng());
                row.createCell(cellIndex++).setCellValue(t.getDataTypeText());
                row.createCell(cellIndex++).setCellValue(t.getDataLength());
                row.createCell(cellIndex++).setCellValue(t.getDataTypeLength());
                row.createCell(cellIndex++).setCellValue(t.getDefinition());
                row.createCell(cellIndex++).setCellValue(t.getFirstname());
                row.createCell(cellIndex++).setCellValue(t.getCreatedDate());
            }

			SimpleDateFormat formatter = new SimpleDateFormat ("yyyyMMddHHmmss");
    		Calendar cal = Calendar.getInstance();
    		String sTimeStamp = formatter.format(cal.getTime());
    		String saveName = "domainlist_" + sTimeStamp;

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
	public JqGridResponse<Domain> domainlist_approved(JqGridRequest req) {
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
		JqGridResponse<Domain> res = new JqGridResponse<Domain>();
		int iTotalCount = domainService.getRecordCount(req);
		res.setRecords(iTotalCount);
		res.setPage(req.getPage());
		res.setTotal((iTotalCount + req.getRows() - 1) / req.getRows());
		int offset = (req.getPage() - 1) * req.getRows();
		List<Domain> list = domainService.getDomainList(offset, Math.min(offset + req.getRows(), iTotalCount), req);
		for (int i = 0; i < list.size(); i += 1) {
			Domain oDomain = list.get(i);
			oDomain.setFirstname(oDomain.getFirstname() + " (" + oDomain.getUsername() + ")");
			if (oDomain.getDataTypeText() != null) {
				if (oDomain.getDataLength() != null && oDomain.getDataLength().length() > 0) {
					oDomain.setDataTypeLength(oDomain.getDataTypeText() + "(" + oDomain.getDataLength() + ")");
				} else {
					oDomain.setDataTypeLength(oDomain.getDataTypeText());
				}
				oDomain.setDomainType(oDomain.getDomain() + "_" + oDomain.getDataTypeText().substring(0, 1) + oDomain.getDataLength());
			}
		}
		res.setRows(list);
		return res;
	}
	
	@PostMapping("/list")
	public JqGridResponse<Domain> domainlist(JqGridRequest req, @RequestParam(required=false, value="aRequestStatus[]") String[] aRequestStatus) {
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
		JqGridResponse<Domain> res = new JqGridResponse<Domain>();
		int iTotalCount = domainService.getRecordCount(oCurrentUser, req);
		res.setRecords(iTotalCount);
		res.setPage(req.getPage());
		res.setTotal((iTotalCount + req.getRows() - 1) / req.getRows());
		int offset = (req.getPage() - 1) * req.getRows();
		List<Domain> list = domainService.getDomainList(oCurrentUser ,offset, Math.min(offset + req.getRows(), iTotalCount), req);
		for (int i = 0; i < list.size(); i += 1) {
			Domain oDomain = list.get(i);
			oDomain.setFirstname(oDomain.getFirstname() + " (" + oDomain.getUsername() + ")");
			if (oDomain.getDataTypeText() != null) {
				if (oDomain.getDataLength() != null && oDomain.getDataLength().length() > 0) {
					oDomain.setDataTypeLength(oDomain.getDataTypeText() + "(" + oDomain.getDataLength() + ")");
				} else {
					oDomain.setDataTypeLength(oDomain.getDataTypeText());
				}
				oDomain.setDomainType(oDomain.getDomain() + "_" + oDomain.getDataTypeText().substring(0, 1) + oDomain.getDataLength());
			}
		}
		res.setRows(list);
		return res;
	}
	
	@PostMapping("/post")
	public Map<String, Object> postDomain(Domain domain, @RequestParam(required=false, value="dataLength") String sDataLength) {
		// LOG.debug("domain.getRequestId(): " + domain.getRequestId());
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		Map<String, Object> oResult = new HashMap<String, Object>();
		oResult.put("result", 0);
		oResult.put("message", "Forbidden");
		if(oCurrentUser.getRole().equals("ROLE_USER")) {
				boolean bFound = domainService.checkDomain(domain.getRequestId(), domain.getDomain());
				if (bFound == false) {
					if (domain.getDomain() != null && domain.getType() != null && domain.getDataType() != null && domain.getDefinition() != null && sDataLength != null && domain.getWord1Id() != -1) {
						if (domain.getDomain().trim().length() > 0 && domain.getType().trim().length() > 0  && domain.getDataType().trim().length() > 0 && domain.getDefinition().trim().length() > 0 && sDataLength.trim().length() > 0) {
							domain.setIsNormal("1"); // normal
						} else {
							if (domain.getDataType().equals("2")) { // 2-DATE. If DataType is DATE then DataLength can be EMPTY
								if (domain.getDomain().trim().length() > 0 && domain.getType().trim().length() > 0  && domain.getDefinition().trim().length() > 0) {
									domain.setIsNormal("1"); // normal
								} else {
									domain.setIsNormal("2"); // abnormal
								}
							} else {
								domain.setIsNormal("2"); // abnormal
							}
						}
					} else {
						domain.setIsNormal("2"); // abnormal
					}
					if (domain.getRequestId() == -1) {
						domain.setUsername(oCurrentUser.getUsername());
						domain.setRequestType("domain");
						domain.setRequestStatus("1");
						domain.setRegistStatus("1");
						domainService.createNewDomain(domain);
						oResult.put("result", 1);
						oResult.put("message", "Added");
						oResult.put("entity", domain);
					} else {
						domain.setUsername(oCurrentUser.getUsername());    
						domain.setRequestType("domain");
						domainService.updateExistingDomain(domain);
						//clearing rejection reason when status is rejection
						if("4".equals(domain.getRequestStatus())){
							domain.setRejectionReason("");
							domainService.updateRejectionStatus(domain);
						}
						oResult.put("result", 2);
						oResult.put("message", "Updated");
						oResult.put("entity", domain);
					}
				} else {
					oResult.put("result", 3);
					oResult.put("message", "Duplicated");
				}
	   }
		return oResult;
	}
	
	@PostMapping("/updateRejectionReason")
	public Map<String, Object> updateRejectionReason(Domain entity) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		Map<String, Object> oResult = new HashMap<String, Object>();
		oResult.put("result", 0);
		oResult.put("message", "Forbidden");
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			domainService.updateRejectionStatus(entity);
			oResult.put("result", 2);
			oResult.put("message", "Updated");
			oResult.put("entity", entity);
		}
		return oResult;
	}
	
	@PostMapping("/cancel_request")
	public void cancelRequest(@RequestBody HashMap<String , Object> aRequest) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			aRequest.put("username",oCurrentUser.getUsername());
			domainService.cancelRequest(aRequest);
		}
	}
	@PostMapping("/make_request")
	public void makeRequest(@RequestBody HashMap<String, Object> aRequest) {
		// LOG.debug("List of request ID: " + aRequest.get("aSelectedRequestId"));
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		if (oCurrentUser.getRole().equals("ROLE_USER")) {
			aRequest.put("username", oCurrentUser.getUsername());
			domainService.makeRequest(aRequest);
		}}
	
	@PostMapping("/approve_request")
	public void approveRequest(@RequestBody HashMap<String, Object> aRequest) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			aRequest.put("username", oCurrentUser.getUsername());
			domainService.approveRequest(aRequest);
		}
	}
	
	@PostMapping("/reject_request")
	public void rejectRequest(@RequestBody HashMap<String, Object> aRequest) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		if (oCurrentUser.getRole().equals("ROLE_ADMIN")) {
			aRequest.put("username", oCurrentUser.getUsername());
			domainService.rejectRequest(aRequest);
		}
	}
	
	@PostMapping("/search_word")
	public List<Word> searchWord(@RequestBody(required=true) Map<String, String> payload) {
		String sQuery = payload.getOrDefault("sQuery", "");
		List<Word> aWord = null;
		if (sQuery.length() > 0) {
			aWord = domainService.searchWord(sQuery);
		}
		return aWord;
	}
}
