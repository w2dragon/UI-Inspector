package lg.cns.ds.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import lg.cns.ds.domain.User;
import lg.cns.ds.domain.UIInspectMngSearchCnd;
import lg.cns.ds.domain.UIInspectMng;
import lg.cns.ds.domain.CmpnVldtRsltHst;
import lg.cns.ds.dto.JqGridRequest;
import lg.cns.ds.dto.JqGridResponse;
import lg.cns.ds.service.UIInspectMngService;
import lg.cns.ds.service.DomainService;

import org.xml.sax.Attributes;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

import com.opencsv.exceptions.CsvDataTypeMismatchException;
import com.opencsv.exceptions.CsvRequiredFieldEmptyException;


@RestController
@RequestMapping("/UIInspectMng")
public class UIInspectMngController {
	
	@Autowired
	DomainService domainService;
	
	@Autowired
	UIInspectMngService uiInspectMngService;
	
	private static final Logger LOG = LoggerFactory.getLogger(UIInspectMngController.class);
			
	@PostMapping("/vldtrsltlist")	
	public JqGridResponse<UIInspectMng> vldtRsltList(JqGridRequest req, UIInspectMngSearchCnd cnd) {
		
		LOG.debug("UIInspectMngSearchCnd selected_uitool: " + cnd.getSelected_uitool());
		LOG.debug("UIInspectMngSearchCnd DateStart: " + cnd.getDateStart());
		LOG.debug("UIInspectMngSearchCnd DateEnd: " + cnd.getDateEnd());
		LOG.debug("UIInspectMngSearchCnd selected_prjtCd: " + cnd.getSelected_prjtCd());
		LOG.debug("UIInspectMngSearchCnd search_vldtRstYn: " + cnd.getSearch_vldtRstYn());
		LOG.debug("UIInspectMngSearchCnd search_itrtSeq: " + cnd.getSearch_itrtSeq());
		LOG.debug("UIInspectMngSearchCnd search_flId: " + cnd.getSearch_flId());
		LOG.debug("UIInspectMngSearchCnd search_vldtSbjTermCd: " + cnd.getSearch_vldtSbjTermCd());
		LOG.debug("UIInspectMngSearchCnd search_vldtSbjTermNm: " + cnd.getSearch_vldtSbjTermNm());
		LOG.debug("UIInspectMngSearchCnd search_vldtRuleCd: " + cnd.getSearch_vldtRuleCd());
		LOG.debug("UIInspectMngSearchCnd search_vldtRuleNm: " + cnd.getSearch_vldtRuleNm());
		LOG.debug("UIInspectMngSearchCnd search_frstCrtrId: " + cnd.getSearch_frstCrtrId());
		
		if (cnd.getDateStart() != null) {
			if (cnd.getDateStart().trim().length() > 0) {
				cnd.setDateStart(cnd.getDateStart().trim() + " 00:00:00");
			}
		}
		if (cnd.getDateEnd() != null) {
			if (cnd.getDateEnd().trim().length() > 0) {
				cnd.setDateEnd(cnd.getDateEnd().trim() + " 23:59:59");
			}
		}
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		JqGridResponse<UIInspectMng> res = new JqGridResponse<UIInspectMng>();
		int iTotalCount = uiInspectMngService.getRecordCount(cnd);
		res.setRecords(iTotalCount);
		res.setPage(req.getPage());
		res.setTotal((iTotalCount + req.getRows() - 1) / req.getRows());
		int offset = (req.getPage() - 1) * req.getRows();
		List<UIInspectMng> list = uiInspectMngService.getVldtRsltList(oCurrentUser ,offset, Math.min(offset + req.getRows(), iTotalCount), cnd);
		
		res.setRows(list);
		return res;
	}
	
	@PostMapping("/inspect")
	public int initChkUI(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> filePath) throws IOException, ParserConfigurationException, SAXException {
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		String userId =  oCurrentUser.getUsername();
		
		//현재일자 기준 검사차수 조회
		int itrtSeq = uiInspectMngService.getItrtSeq();
				
		int rsltCnt = 0; //검증결과 생성건수 return 전역변수
		
		rsltCnt += chkRuleCmpr(itrtSeq, userId, filePath, rsltCnt);
		
		System.out.println("rsltCnt = "+rsltCnt);
		return rsltCnt;
	}
		
	public int chkRuleCmpr(int itrtSeq, String userId, @RequestBody Map<String, String> filePath, int rsltCnt) throws IOException, ParserConfigurationException, SAXException {
		
		//비교대상 컴포넌트 및 속성 조회
		List<CmpnVldtRsltHst> cmprCmpnPrptyList = uiInspectMngService.getCmprCmpnPrptyList();
				
		//검사결과 List 선언
		HashMap<String, Object> param = new HashMap<String, Object>();
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		
		LOG.debug("filePath: " + filePath.get("filePath"));
		
		File dir = new File(filePath.get("filePath"));
		
		if(dir.isFile()) {
			
			result = processFileValidation(dir, cmprCmpnPrptyList, userId, result);
			
		}else {
		
			File files[] = dir.listFiles();
			
			for (int i = 0; i < files.length; i++) {
		        File file = files[i];		        
		        
		        if (file.isDirectory()) { //디렉토리 일 때,
		        	Map<String, String> reFilePath = new HashMap<String, String>();
		        	reFilePath.put("filePath", file.getPath());
		        	chkRuleCmpr(itrtSeq, userId, reFilePath, rsltCnt); //재귀호출
		        }else {		 		        	
		        	result = processFileValidation(file, cmprCmpnPrptyList, userId, result);
					
		        } 
		    }
		}
		
		//검사결과 insert
		if(!result.isEmpty()) {
			param.put("result", result);
						
			for(int w = 0; w < result.size(); w++) {
				result.get(w).put("itrtSeq",itrtSeq);
			}
			
			rsltCnt += uiInspectMngService.insertCmprCmpnResult(param);			
		}
		System.out.println("insertResult = "+rsltCnt);
		return rsltCnt;
	}
	
	public List<Map<String, Object>> processFileValidation(File file, List<CmpnVldtRsltHst> cmprCmpnPrptyList, String userId, List<Map<String, Object>> result) 
			throws IOException, ParserConfigurationException, SAXException{

		String fileName = file.getName(); // 파일명
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1); //파일 확장자
        
		if(!file.isHidden() && file.isFile() && ext.equals("xfdl")){ // 숨겨진 파일이 아니고, 파일인 경우
            System.out.println("file 내 검사 시작 ");
			try {
	            //Path path = Paths.get("/home/mjs/test/text.txt");
	            Path path = Paths.get(file.getPath());
	            System.out.println(path.toString());
	            	                	                
	            SAXParserFactory spf = SAXParserFactory.newInstance();
	            spf.setFeature("http://xml.org/sax/features/external-general-entities", false);
	            spf.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
	            spf.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);
	            SAXParser sp = spf.newSAXParser();
	            XMLParserHandler parserHandler = new XMLParserHandler();
	            sp.parse(file, parserHandler);        // Start Parsing                    
	            //ArrayList<String> tagList = parserHandler.getTagList();
	            Map<String, Object> fileCmpnList = parserHandler.getFileCmpnList(); // End Parsing
	            
	            System.out.println("==========================================");
	            Iterator<String> f_keys = fileCmpnList.keySet().iterator();
	                                                    
	            while( f_keys.hasNext() ){
	                String key = f_keys.next();
	                //Map value = (Map)fileCmpnList.get(key);
	                //System.out.println("키 : "+key+", 값 : "+value);
	                System.out.println("파일명 : "+key);
	                Map f_value = (Map)fileCmpnList.get(key);
	                
	                //스크립트 존재 시, String 배열에 한줄씩 넣음
	                String script = "";
	                String[] line_script = new String[5000]; 
	                if(f_value.containsKey("script") && f_value.get("script") != null) {
	                	//스크립트 내용을 String 형식으로 type 변 경
            			script = f_value.get("script").toString();
            			
            			System.out.println("주석제거: "+script.replaceAll("(?:/\\*(?:[^*]|(?:\\*+[^*/]))*\\*+/)|(?://.*)",""));
            			script = script.replaceAll("(?:/\\*(?:[^*]|(?:\\*+[^*/]))*\\*+/)|(?://.*)",""); //주석제거된 script
            			
            			line_script = script.split("\n");
	                }
	                
	                Iterator<String> c_keys = f_value.keySet().iterator();
	                
	                while( c_keys.hasNext() ){
	                    String c_key = c_keys.next();
	                    //Map value = (Map)fileCmpnList.get(key);
	                    //System.out.println("키 : "+key+", 값 : "+value);
	                    System.out.println("컴포넌트명 : "+c_key);
	                    Map c_value = (Map)f_value.get(c_key);
	                                                
	                    Iterator<String> p_keys = c_value.keySet().iterator();
	                    
	                    for(int p = 0; p < cmprCmpnPrptyList.size(); p++) {                            	
	                    	Map<String, Object> cmpnVldtRsltHst = new HashMap<String, Object>();
	                    	
	    	                cmpnVldtRsltHst.put("flId", path.toString()); // 파일명(path포함)
	    	                cmpnVldtRsltHst.put("prjtCd", cmprCmpnPrptyList.get(p).getPrjtCd()); //프로젝트코드
	    	                cmpnVldtRsltHst.put("uiCd", cmprCmpnPrptyList.get(p).getUiCd()); //UI코드    
	    	                //cmpnVldtRsltHst.put("itrtSeq", itrtSeq); // 차수
	    	                cmpnVldtRsltHst.put("frstCrtrId", userId); // 최초생성자ID
	    	                cmpnVldtRsltHst.put("lstMdfrId", userId); // 최종수정자ID
	    	                
	                    	//파일내 컴포넌트 key가 비교대상 컴포넌트 key값을 포함하면
	                    	if(c_key.contains(cmprCmpnPrptyList.get(p).getCmpnKey())) { 
	                    		cmpnVldtRsltHst.put("cmpnCd", cmprCmpnPrptyList.get(p).getCmpnCd()); //컴포넌트코드
	                    		cmpnVldtRsltHst.put("vldtSbjTermCd", cmprCmpnPrptyList.get(p).getVldtSbjTermCd()); //검사대상용어코드
	                    		if(c_key.contains("Cell")) { // 그리드인 경우, 프로그램컴포넌트 ID를 조합한다.
	                    			String cell_editType = "";
	                    			if(c_value.get("edittype") != null) {
	                    				cell_editType = (String)c_value.get("edittype"); //그리드 cell의 edit type
	                    			}else {
	                    				cell_editType = "none"; //그리드 cell의 edit type이 없으면 default 값인 "none" 셋팅
	                    			}
	                    			
	                    			String grdNm = c_key.substring(c_key.lastIndexOf(":")+1);
	                    			String temp_cellNm =  c_key.replace("Cell","");
	                    			String cellNm = temp_cellNm.substring(0,temp_cellNm.indexOf(":"));
	                    			
	                    			System.out.println("prgmCmpnId : "+grdNm + "." + cellNm);
	                    			
	                    			// 그리드 cell edittype이 text, mask 로 입력형태이면
	                    			if(cell_editType.equals("text")||cell_editType.equals("mask")) {	                            				                            			
	                        			cmpnVldtRsltHst.put("prgmCmpnId", grdNm + "." + cellNm); //프로그램컴포넌트ID
	                        			
	                        		// 그리드 cell edittype이 입력형태가 아니면
	                    			}else {
	                    				continue;
	                    			}
	                    			
	                    		}else {
	                    			cmpnVldtRsltHst.put("prgmCmpnId", (String)c_value.get("id")); //프로그램컴포넌트ID
	                    		}
	                    		                            		
	                    		// "userproperty" 속성이 존재하면
	                    		//if(c_value.containsKey("userproperty")) {
	                    			
	                    			// "userproperty" 속성값이 검사규칙코드를 포함하면
	                    			//if(c_value.get("userproperty").toString().contains(cmprCmpnPrptyList.get(p).getVldtRuleCd())) {
	                    				cmpnVldtRsltHst.put("vldtRuleCd", cmprCmpnPrptyList.get(p).getVldtRuleCd()); //검사규칙코드
	                    				
			                            //while( p_keys.hasNext() ){ // 파일 컴포넌트의 property와 값을 비교 시작
			                                String p_key = p_keys.next();
			                                String p_value = (String)c_value.get(p_key);
			                                System.out.println("프로퍼티 : "+p_key+", 값 : "+p_value);
			                                
		                                cmpnVldtRsltHst.put("prpty", cmprCmpnPrptyList.get(p).getPrpty()); //프로퍼티
	                    				cmpnVldtRsltHst.put("prptyVl", cmprCmpnPrptyList.get(p).getPrptyVl()); //프로퍼티값
	                    				cmpnVldtRsltHst.put("dfltVl", cmprCmpnPrptyList.get(p).getDfltVl()); //디폴트값                            				
	                    				
	                    				//프로퍼티값이 ","로 구분되어 여러개가 들어가는 경우에 대처하기 위해
	                    				String temp_mstPrpty = cmprCmpnPrptyList.get(p).getPrptyVl().replace(" ","");
	                    				String [] mstPrpty = temp_mstPrpty.split(",");
	                    				String strPgmPrpty = "";
	                    				String temp_pgmPrpty = "";
	                    				String [] pgmPrpty = new String[15];
	                    				
	                    				//System.out.println("프로퍼티 : " +cmprCmpnPrptyList.get(p).getPrpty());
	                    				//System.out.println("프로퍼티값 : " +cmprCmpnPrptyList.get(p).getPrptyVl());
	                    				//System.out.println("mstPrpty길이 : " +mstPrpty.length);
	                    				
	                    				//프로퍼티값이 null이 아닐 때
	                    				if(c_value.get(cmprCmpnPrptyList.get(p).getPrpty()) != null) {
	                        				strPgmPrpty = (String)c_value.get(cmprCmpnPrptyList.get(p).getPrpty());
	                        				temp_pgmPrpty = strPgmPrpty.replace(" ","");
	                        				pgmPrpty = temp_pgmPrpty.split(",");
	                        				//System.out.println("프로그램 프로퍼티값 : " +strPgmPrpty);
	                        				
	                    				}else {
	                    					strPgmPrpty = "";
	                        				temp_pgmPrpty = strPgmPrpty.replace(" ","");
	                        				pgmPrpty = temp_pgmPrpty.split(",");
	                    				}
	                    				
	                    				//검사하려는 프로퍼티가 존재하고, 마스터 프로퍼티값의 갯수와 프로그램 프로퍼티값의 갯수가 동일하면
	                    				if(c_value.containsKey(cmprCmpnPrptyList.get(p).getPrpty())&& mstPrpty.length == pgmPrpty.length) {
	                    					
	                    					//System.out.println("프로퍼티 : " +strPgmPrpty);
	                    					int cnt = 0;
	                    						
	                						//반복문으로 마스터 프로퍼티값과 프로그램 프로퍼티값 하나씩 모두 비교
	                						for(int k = 0; k < mstPrpty.length; k++) {
	                							for(int m = 0; m < pgmPrpty.length; m++) {
	                								//System.out.println("mstPrpty[k]"+mstPrpty[k]);
	            									//System.out.println("pgmPrpty[m]"+pgmPrpty[m]);
	                								if(mstPrpty[k].equals(pgmPrpty[m])) {
	                									cnt++;
	                									//System.out.println("mstPrpty[k]"+mstPrpty[k]);
	                									//System.out.println("pgmPrpty[m]"+pgmPrpty[m]);
	                								}else continue;
	                							}                            							                            							
	                						}
	                						//System.out.println("cnt"+cnt);
	                						
	                						//마스터 프로퍼티값과 프로그램 프로퍼티값 여러개 이고, 그 값이 동일하면 
	                						if(mstPrpty.length == cnt) {
	                							cmpnVldtRsltHst.put("vldtRstYn", "Y"); //검사결과여부
	                        					cmpnVldtRsltHst.put("prgmVl", (String)c_value.get(cmprCmpnPrptyList.get(p).getPrpty())); //프로그램값
	                        					cmpnVldtRsltHst.put("rmrk", "프로퍼티 셋팅값과 프로그램 셋팅값 동일. 정상완료"); 
	                						}else {
	                							cmpnVldtRsltHst.put("vldtRstYn", "N"); //검사결과여부
	                           					cmpnVldtRsltHst.put("prgmVl", (String)c_value.get(cmprCmpnPrptyList.get(p).getPrpty())); //프로그램값
	                           					cmpnVldtRsltHst.put("rmrk", "프로퍼티 셋팅값과 프로그램 셋팅값 다름.");
	                						}                            					
	                    					
	                    				//프로그램에 셋팅된 속성을 손대지 않아 속성값이 없는 경우, 프로그램값에 디폴트값을 넣음
	                    				}else if(!c_value.containsKey(cmprCmpnPrptyList.get(p).getPrpty())) {
	                       					cmpnVldtRsltHst.put("vldtRstYn", "N"); //검사결과여부
	                       					cmpnVldtRsltHst.put("prgmVl", cmprCmpnPrptyList.get(p).getDfltVl()); //프로그램값
	                       					cmpnVldtRsltHst.put("rmrk", "프로그램 셋팅값 없음. Default값으로 대체됨");
	                       				//셋팅된 프로퍼티값과 프로그램에 셋팅된 속성값이 다르면
	                    				}else {
	                       					cmpnVldtRsltHst.put("vldtRstYn", "N"); //검사결과여부
	                       					cmpnVldtRsltHst.put("prgmVl", (String)c_value.get(cmprCmpnPrptyList.get(p).getPrpty())); //프로그램값
	                       					cmpnVldtRsltHst.put("rmrk", "프로퍼티 셋팅값과 프로그램 셋팅값 다름.");
	                    				}                                                           
			                            //}
	                    			//}else { //"userproperty" 속성값이 검사규칙코드를 포함하지 않으면
	                    				//continue;
										/*
										 * cmpnVldtRsltHst.put("vldtRuleCd",
										 * cmprCmpnPrptyList.get(p).getVldtRuleCd()); //검사규칙코드
										 * cmpnVldtRsltHst.put("prpty", null); //프로퍼티
										 * cmpnVldtRsltHst.put("prptyVl",null); //프로퍼티값
										 * cmpnVldtRsltHst.put("dfltVl", null); //디폴트값 cmpnVldtRsltHst.put("prgmVl",
										 * null); //프로그램값 cmpnVldtRsltHst.put("vldtRstYn", "N"); //검사결과여부
										 * cmpnVldtRsltHst.put("rmrk", "userproperty 속성값에 검사규칙코드 미존재. 검사불가.");
										 */  
	                    			//}
	                    		//}else { // "userproperty" 속성이 존재하지않으면
	                    			//continue;
									/*
									 * cmpnVldtRsltHst.put("cmpnCd", cmprCmpnPrptyList.get(p).getCmpnCd()); //컴포넌트코드
									 * cmpnVldtRsltHst.put("vldtSbjTermCd",
									 * cmprCmpnPrptyList.get(p).getVldtSbjTermCd()); //검사대상용어코드
									 * cmpnVldtRsltHst.put("vldtRuleCd", null); //검사규칙코드
									 * cmpnVldtRsltHst.put("prpty", null); //프로퍼티
									 * cmpnVldtRsltHst.put("prptyVl",null); //프로퍼티값 cmpnVldtRsltHst.put("dfltVl",
									 * null); //디폴트값 cmpnVldtRsltHst.put("prgmVl", null); //프로그램값
									 * cmpnVldtRsltHst.put("vldtRstYn", "N"); //검사결과여부 cmpnVldtRsltHst.put("rmrk",
									 * "userproperty 속성 미존재. 검사불가.");
									 */
	                    		//}
	                    		
	                    		//검사 스크립트 패턴이 등록되어있으면, 해당 스크립트가 작성되어있는지 여부를 검사
	                    		if(!cmprCmpnPrptyList.get(p).getScrpCntn().equals(null)&&!cmprCmpnPrptyList.get(p).getScrpCntn().equals("")){ 
	                    			
	                    			String temp_scrpCntn = cmprCmpnPrptyList.get(p).getScrpCntn().replace(" ","");
	                				String [] mstScrpCntn = temp_scrpCntn.split(",");
	                				int scrpCnt = 0;
	                				String vldtScrpCntn = "";
	                				String fail_vldtScrpCntn = "";
	                				
	                        		if(f_value.containsKey("script") && f_value.get("script") != null) {                                			
	                    				
	                        			for(int q = 0; q < mstScrpCntn.length; q++) {
	                            			System.out.println("검사 스크립트 패턴 : this."+(String)c_value.get("id")+"."+mstScrpCntn[q]);
	                            			if(f_value.get("script").toString().contains("this."+(String)c_value.get("id")+"."+mstScrpCntn[q])){
	                            				scrpCnt++;
	                            				vldtScrpCntn = "this."+(String)c_value.get("id")+"."+mstScrpCntn[q];
	                            			}else {
	                            				fail_vldtScrpCntn = "this."+(String)c_value.get("id")+"."+mstScrpCntn[q];
	                            			}	                                			
	                        			}
	                        			//검사 스크립트 패턴이 스크립트 내 존재하면
	                        			if(scrpCnt >= 1){
	                        				cmpnVldtRsltHst.put("vldtRstYn", "Y"); //검사결과여부
	                        				cmpnVldtRsltHst.put("vldtScrpCntn", vldtScrpCntn); //검사스크립트내용
	                        				cmpnVldtRsltHst.put("scrpExstYn", "Y"); //스크립트존재여부                               					
	                       					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n검사 스크립트 패턴이 존재함. 정상완료");
	                       				//검사 스크립트 패턴이 스크립트 내 존재하지 않으면
	                        			}else {
	                        				//프로퍼티로 셋팅하여 검사결과가 이미 "Y"(정상)인 경우
	                        				if(cmpnVldtRsltHst.get("vldtRstYn").equals("Y")) {
	                            				cmpnVldtRsltHst.put("vldtScrpCntn", fail_vldtScrpCntn); //검사스크립트내용
	                            				cmpnVldtRsltHst.put("scrpExstYn", "N"); //스크립트존재여부                               					
	                           					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n검사 스크립트 패턴이 프로그램 스크립트에 미존재하나, 프로퍼티 셋팅으로 정상완료");
	                           				//프로퍼티에 셋팅하지 않은 경우
	                        				}else {
	                        					cmpnVldtRsltHst.put("vldtScrpCntn", fail_vldtScrpCntn); //검사스크립트내용
	                            				cmpnVldtRsltHst.put("scrpExstYn", "N"); //스크립트존재여부                               					
	                           					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n검사 스크립트 패턴이 프로그램 스크립트에 미존재.");
	                        				}
	                        			}	                        			
	                        		}else {//script에 아무것도 작성되어있지 않을 때
	                        			cmpnVldtRsltHst.put("vldtScrpCntn", "this."+(String)c_value.get("id")+"."+mstScrpCntn[0]); //검사스크립트내용 --> 프로그램 스크립트 미작성 시, 마스터의 검사 스크립트 패턴 중 첫번째 것을 입력
	                    				cmpnVldtRsltHst.put("scrpExstYn", "N"); //스크립트존재여부                               					
	                   					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n프로그램 스크립트 작성안함.");
	                        		}
	                        	//검사 스크립트 패턴이 등록되어있지 않으면
	                    		}else {
	                        		cmpnVldtRsltHst.put("scrpExstYn", "N"); //스크립트존재여부                               					
	               					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n검사 스크립트 패턴 미등록.");
	                        	}
	                    		
	                    		//검사대상용어에 체크해야할 함수명이 등록되어있으면, 해당 함수가 작성되어있는지 여부를 검사
	                    		if(!cmprCmpnPrptyList.get(p).getEvntNm().equals(null)&&!cmprCmpnPrptyList.get(p).getEvntNm().equals("")){ 
                    					                        			
                        			int lineNo = 0;
                        			int chk_cnt = 0;
                        			String vldtLine = "";
                        			
                        			for(String line : line_script) {
                        			          
                        				//프로그램컴포넌트ID가 해당 line에 존재하면
                        				if(!line.isEmpty() && !line.equals("\t") && !line.equals("\t\t") &&
                        				   //!line.contains("{") && !line.contains("}") && 
                        				   !line.equals("\t\t\t") &&
                        				   line.contains((String)c_value.get("id"))) {		                        					
                        					lineNo++;
                        					System.out.println("["+lineNo+"]라인: "+line);
                        					
                        					if(line.contains(cmprCmpnPrptyList.get(p).getEvntNm())) {
                        						System.out.println("라인: "+line);
                        						chk_cnt++; 
                        						vldtLine = line;
                        					}
                        				}
                        			}
                        			
                        			if(chk_cnt > 0) {
                        				cmpnVldtRsltHst.put("vldtScrpCntn", cmpnVldtRsltHst.get("vldtScrpCntn")+"\n"+vldtLine.replace("\t", "")); //검사함수 포함되는 프로그램 내용
                						cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n검사대상용어에 사용해야하는 함수가 사용됨.");
                        			}else {
                						cmpnVldtRsltHst.put("vldtRstYn", "N"); //검사결과여부
                						cmpnVldtRsltHst.put("vldtScrpCntn", cmpnVldtRsltHst.get("vldtScrpCntn")+"\n"+cmprCmpnPrptyList.get(p).getEvntNm()+"함수작성 필요"); //검사함수 포함되는 프로그램 내용
                						cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n검사대상용어에 사용해야하는 함수가 작성되지않음.");
                					}  
	                        	}
	                    	}else { //파일내 컴포넌트 key가 비교대상 컴포넌트 key값을 미포함하면 
	                    		continue;
								/*
								 * cmpnVldtRsltHst.put("cmpnCd", cmprCmpnPrptyList.get(p).getCmpnCd()); //컴포넌트코드
								 * cmpnVldtRsltHst.put("vldtSbjTermCd",
								 * cmprCmpnPrptyList.get(p).getVldtSbjTermCd()); //검사대상용어코드
								 * cmpnVldtRsltHst.put("vldtRuleCd", null); //검사규칙코드
								 * cmpnVldtRsltHst.put("prpty", null); //프로퍼티
								 * cmpnVldtRsltHst.put("prptyVl",null); //프로퍼티값 cmpnVldtRsltHst.put("dfltVl",
								 * null); //디폴트값 cmpnVldtRsltHst.put("prgmVl", null); //프로그램값
								 * cmpnVldtRsltHst.put("vldtRstYn", "N"); //검사결과여부 cmpnVldtRsltHst.put("rmrk",
								 * "비교대상 컴포넌트 없음. 검사불가.");
								 */
	                    	}
	                    	
	                    	result.add(cmpnVldtRsltHst);
	                    }
	                }
	            }
	            System.out.println("==========================================");
	            
	        } catch (IOException e) {
	            e.printStackTrace();
	        } catch (StackOverflowError e) {
	        	e.printStackTrace();
	        }
			System.out.println("file 내 검사 종료 ");
		}
		
		return result;
	}
	
	public class XMLParserHandler  extends DefaultHandler {
		private String elementName = "";
	    private StringBuffer sBuffer = new StringBuffer();
	    private String filename = "";
	    
	    Map<String, Object> fileCmpn = new HashMap<String, Object>();
        Map<String, Object> cmpnList = new HashMap<String, Object>();
        //Map<String, String> prptyList = new HashMap<String, String>();
        private String stringScript = "";
        private String grdId = ""; //그리드ID를 얻기위한 임시변수
            
	    public void setDocumentLocator(Locator loc){ 
	    	filename = loc.getSystemId();
	    	System.out.println("[파일] "+loc.getSystemId());   
	    }
	    // XML 문서의 시작이 인식되었을 때 발생하는 이벤트를 처리
	    public void startDocument() {
	        //System.out.println("Start Document");		    	
	    }
	     
	    // XML 문서의 끝이 인식되었을 때 발생하는 이벤트를 처리
	    public void endDocument() {
	        //System.out.println("End Document");
	    	 fileCmpn.put(filename, cmpnList); //파일명, 파일 내 컴포넌트와 properties & value
	    	 cmpnList = new HashMap<String, Object>(); //cmpnList Map 초기화
	    }
	  
	    // 엘리먼트의 시작을 인식했었을 때 발생하는 이벤트를 처리
	    public void startElement(String uri, String localName, String qname, Attributes attr) {
	        elementName = qname;    //element명을 멤버 변수에 넣어 둔다.
	        //int attrCount=attr.getLength(); // 태그 개수
	        //String attrName=attr.getQName(0); // 첫번째 태그 임의 설정
	        //String attrValue=attr.getValue(attrName);
	       
	        Map<String, String> prptyList = new HashMap<String, String>();//엘리먼트 시작마다 prptyList Map 초기화
	        
	        String attrName = "";
	        String attrValue = "";     	       
	        
	        // 제외 컴포넌트 : FDL / Form / Layouts / Layout	 / Formats/ Format / Objects / Dataset / ColumnInfo / Column 
	        //             Rows / Row / Col / Columns
	        if(!qname.equals("FDL")&&!qname.equals("Form")&&!qname.equals("Layouts")&&!qname.equals("Layout")&&
	           !qname.equals("Formats")&&!qname.equals("Format")&&!qname.equals("Objects")&&!qname.equals("Dataset")&&
	           !qname.equals("ColumnInfo")&&!qname.equals("Column")&&!qname.equals("Rows")&&!qname.equals("Row")&&
	           !qname.equals("Col")&&!qname.equals("Columns")){
		        int attrCount=attr.getLength(); // 태그 개수
		        System.out.print("[컴포넌트] " + qname+" : "); 
		        	for(int i=0; i<attrCount; i++){ // element 내 태그 갯수 만큼 loop
		        		attrName=attr.getQName(i);
		        		attrValue=attr.getValue(attrName);
		        		/*
		        		if(attrName.equals("file")){
		        			if(attrValue.length() >= 9){
		        				String file_nm = attrValue.substring(attrValue.lastIndexOf(".")-6);
		        				tagList.add(file_nm); 
		                }*/
		        		if(!qname.equals("Grid")&&attrName.equals("id")) { //태그가 id 일때
		        			qname = qname + attrValue; // element명 + id의 value(예:EditSSN1)
		        		}else if(qname.equals("Grid")&& attrName.equals("id")) {
		        			grdId = attrValue;
		        			System.out.print("grdId0"+" = "+grdId); 
		        		}else if(qname.equals("Cell") && attrName.equals("text")) { 
		        			//그리드 Cell 검사를 위해 Cell에 바인딩되는 바인딩컬럼명을 qname에 attach 함
		        			//예시 : <Cell text="bind:SSN" edittype="text" editinputtype="digit" editmaxlength="13"/>
		        			//예시 : qname = Cell + SSN
		        			qname = qname + attrValue.substring(attrValue.lastIndexOf(":")+1)+":"+grdId;
		        			System.out.print("grdId1"+" = "+grdId); 
		        		}
		        		
		            	System.out.print(attrName+" = "+attrValue+", "); 
		            	prptyList.put(attrName, attrValue); //properties & value
		            }		         
		        	System.out.println("");
		        	cmpnList.put(qname, prptyList); //하나의 element 속성읽기 끝나기전에 컴포넌트 Map 에 put
	         }
	          
	        //System.out.println("속성값=============" + attrName+"=="+attrValue);
	       
	        sBuffer.setLength(0);    // buffer 초기화
	    }
	  
	    // 엘리먼트의 끝을 인식했었을 때 발생하는 이벤트를 처리
	    public void endElement(String uri, String localName, String qname) {   
	        System.out.println("End element, Name: " + qname);
	        if(qname.equals("Script")) {
	        	Map<String, String> scriptCntn = new HashMap<String, String>();
	        	scriptCntn.put("script",stringScript);
	        	cmpnList.put("script", scriptCntn);
	        }
	    }
	  
	    // 각 element의 값 (인식된 문자의 각 세그먼트에 대해서 호출)
	    public void characters(char[] ch, int start, int length) throws SAXException {
	        String strValue = "";
	  
	        // element의 값을 구하기 위해서는 buffer에 인식된 각 문자를 start에서 length만큼 append한다.
	        sBuffer.append(new String(ch, start, length));
	        strValue = sBuffer.toString().trim();
	        stringScript = sBuffer.toString().trim();
	        System.out.println("characters length : " + length);
	        if (strValue != null && strValue.length() != 0 && !strValue.equals("\n")) {
	           System.out.println("elementName: " + elementName + ", strValue: "+ strValue);
	        }
	    }
	     
	    public Map<String, Object> getFileCmpnList() {
	    	return fileCmpn;
	    }
	}

	@PostMapping("/download_excel_all")
	public void download_excel_all(HttpServletRequest request, HttpServletResponse response, JqGridRequest req, UIInspectMngSearchCnd cnd) throws CsvDataTypeMismatchException, CsvRequiredFieldEmptyException, IOException {
		
		if (cnd.getDateStart() != null) {
			if (cnd.getDateStart().trim().length() > 0) {
				cnd.setDateStart(cnd.getDateStart().trim() + " 00:00:00");
			}
		}
		if (cnd.getDateEnd() != null) {
			if (cnd.getDateEnd().trim().length() > 0) {
				cnd.setDateEnd(cnd.getDateEnd().trim() + " 23:59:59");
			}
		}
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;

		int iTotalCount = uiInspectMngService.getRecordCount(cnd);

		List<UIInspectMng> list = uiInspectMngService.getVldtRsltList(oCurrentUser , 0, iTotalCount, cnd);
		
		OutputStream os = null;
		try {

			 String[] columns = new String[]  
	                {		
	                		//"프로젝트코드",
	            			"프로젝트명", 
	            			//"UI코드",
	            			"UI명",
	            			//"컴포넌트코드",
	            			"컴포넌트명",
	            			"검사대상용어코드",
	            			"검사대상용어명",
	            			"검사규칙코드",
	            			"검사규칙명",
	            			"디폴트값",
	            			"검사일자",
	            			"차수",
	            			"파일명",
	            			"프로그램컴포넌트ID",
	            			"검사대상프로퍼티",
	            			"검사대상프로퍼티값",
	            			"프로그램프로퍼티값",
	            			"검사대상스크립트",
	            			"프로그램 내 스크립트 존재여부",
	            			"검사결과",
	            			"비고",
	            			"검사수행일시",
	            			"검사수행ID"
	                }; 

            HSSFWorkbook wb = new HSSFWorkbook();//Whole book
            HSSFSheet currentSheet = allocateNewSheet(wb, "SHEET");//Initial sheet
            int sheetCounter = 1;//Start at 1 because we already created Initial sheet
            int rowCounter = 0;//1st row in sheet
            for(UIInspectMng t: list) {//Loop through data
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
            	//row.createCell(cellIndex++).setCellValue(t.getPrjtCd());
            	row.createCell(cellIndex++).setCellValue(t.getPrjtNm());
            	//row.createCell(cellIndex++).setCellValue(t.getUiCd());
            	row.createCell(cellIndex++).setCellValue(t.getUiNm());
            	//row.createCell(cellIndex++).setCellValue(t.getCmpnCd());
                row.createCell(cellIndex++).setCellValue(t.getCmpnNm());
                row.createCell(cellIndex++).setCellValue(t.getVldtSbjTermCd());
                row.createCell(cellIndex++).setCellValue(t.getVldtSbjTermNm());
                row.createCell(cellIndex++).setCellValue(t.getVldtRuleCd());
                row.createCell(cellIndex++).setCellValue(t.getVldtRuleNm());
                row.createCell(cellIndex++).setCellValue(t.getDfltVl());
                row.createCell(cellIndex++).setCellValue(t.getVldtDt());
                row.createCell(cellIndex++).setCellValue(t.getItrtSeq());
                row.createCell(cellIndex++).setCellValue(t.getFlId());
                row.createCell(cellIndex++).setCellValue(t.getPrgmCmpnId());
                row.createCell(cellIndex++).setCellValue(t.getPrpty());
                row.createCell(cellIndex++).setCellValue(t.getPrptyVl());
                row.createCell(cellIndex++).setCellValue(t.getPrgmVl());
                row.createCell(cellIndex++).setCellValue(t.getVldtScrpCntn());
                row.createCell(cellIndex++).setCellValue(t.getScrpExstYn());
                row.createCell(cellIndex++).setCellValue(t.getVldtRstYn());
                row.createCell(cellIndex++).setCellValue(t.getRmrk());
                row.createCell(cellIndex++).setCellValue(t.getFrstCrdt());
                row.createCell(cellIndex++).setCellValue(t.getFrstCrtrId());
                
            }

			SimpleDateFormat formatter = new SimpleDateFormat ("yyyyMMddHHmmss");
    		Calendar cal = Calendar.getInstance();
    		String sTimeStamp = formatter.format(cal.getTime());
    		String saveName = "UI Inspect Result_" + sTimeStamp;

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
}
