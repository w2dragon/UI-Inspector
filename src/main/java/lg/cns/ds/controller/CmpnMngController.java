package lg.cns.ds.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import lg.cns.ds.domain.Domain;
import lg.cns.ds.domain.User;
import lg.cns.ds.domain.Word;
import lg.cns.ds.domain.CmpnMngSearchCnd;
import lg.cns.ds.domain.CmpnVldtRsltHst;
import lg.cns.ds.domain.UIMng;
import lg.cns.ds.domain.UICmpnMng;
import lg.cns.ds.dto.JqGridRequest;
import lg.cns.ds.dto.JqGridResponse;
import lg.cns.ds.service.CmpnMngService;
import lg.cns.ds.service.DomainService;

import org.xml.sax.Attributes;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;
import org.xml.sax.SAXNotRecognizedException;
import org.xml.sax.SAXNotSupportedException;
import org.xml.sax.helpers.DefaultHandler;


@RestController
@RequestMapping("/cmpnMng")
public class CmpnMngController {

	
	@Autowired
	DomainService domainService;
	
	@Autowired
	CmpnMngService cmpnMngService;
	
	private static final Logger LOG = LoggerFactory.getLogger(CmpnMngController.class);
			
	@PostMapping("/UItoollist")	
	public JqGridResponse<UIMng> UItoolList(JqGridRequest req, CmpnMngSearchCnd cnd) {
		
		LOG.debug("CmpnMngSearchCnd selected_uitool: " + cnd.getSelected_uitool());
		LOG.debug("CmpnMngSearchCnd DateStart: " + cnd.getDateStart());
		LOG.debug("CmpnMngSearchCnd DateEnd: " + cnd.getDateEnd());
		
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
		JqGridResponse<UIMng> res = new JqGridResponse<UIMng>();
		int iTotalCount = cmpnMngService.getRecordCount(cnd);
		res.setRecords(iTotalCount);
		res.setPage(req.getPage());
		res.setTotal((iTotalCount + req.getRows() - 1) / req.getRows());
		int offset = (req.getPage() - 1) * req.getRows();
		List<UIMng> list = cmpnMngService.getUItoolList(oCurrentUser ,offset, Math.min(offset + req.getRows(), iTotalCount), cnd);
		
		res.setRows(list);
		return res;
	}
	
	@PostMapping("/cmpnlist")
	public JqGridResponse<UICmpnMng> cmpnList(JqGridRequest req, @RequestParam(required=false, value="uiCd") String uiCd) {
		
		LOG.debug("uiCd: " + uiCd);
				
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		JqGridResponse<UICmpnMng> res = new JqGridResponse<UICmpnMng>();
		int iTotalCount = cmpnMngService.getCmpnRecordCount(uiCd);
		res.setRecords(iTotalCount);
		res.setPage(req.getPage());
		res.setTotal((iTotalCount + req.getRows() - 1) / req.getRows());
		int offset = (req.getPage() - 1) * req.getRows();
		List<UICmpnMng> list = cmpnMngService.getCmpnList(oCurrentUser ,offset, Math.min(offset + req.getRows(), iTotalCount), uiCd);
		
		res.setRows(list);
		return res;
	}
	
	int rsltCnt = 0; //???????????? ???????????? return ????????????
	
	@PostMapping("/test")
	public int initChkUI(HttpServletRequest request, HttpServletResponse response, @RequestBody Map<String, String> filePath) throws IOException, ParserConfigurationException, SAXException {
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User oCurrentUser = (User)principal;
		String userId =  oCurrentUser.getUsername();
		
		//???????????? ?????? ???????????? ??????
		int itrtSeq = cmpnMngService.getItrtSeq();
				
		rsltCnt = chkRuleCmpr(itrtSeq, userId, filePath, rsltCnt);
		
		System.out.println("rsltCnt = "+rsltCnt);
		return rsltCnt;
	}
		
	public int chkRuleCmpr(int itrtSeq, String userId, @RequestBody Map<String, String> filePath, int rsltCnt) throws IOException, ParserConfigurationException, SAXException {
		
		//???????????? ???????????? ??? ?????? ??????
		List<CmpnVldtRsltHst> cmprCmpnPrptyList = cmpnMngService.getCmprCmpnPrptyList();
				
		//???????????? List ??????
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
		        
		        if (file.isDirectory()) { //???????????? ??? ???,
		        	Map<String, String> reFilePath = new HashMap<String, String>();
		        	reFilePath.put("filePath", file.getPath());
		        	chkRuleCmpr(itrtSeq, userId, reFilePath, rsltCnt); //????????????
		        }else {		 		        	
		        	result = processFileValidation(file, cmprCmpnPrptyList, userId, result);
					
		        } 
		    }
		}
				
		//List<UICmpnMng> list = cmpnMngService.getCmpnList(oCurrentUser ,offset, Math.min(offset + req.getRows(), iTotalCount), uiCd);
		
		//???????????? insert
		if(!result.isEmpty()) {
			param.put("result", result);
						
			for(int w = 0; w < result.size(); w++) {
				result.get(w).put("itrtSeq",itrtSeq);
			}
			
			rsltCnt += cmpnMngService.insertCmprCmpnResult(param);			
		}
		System.out.println("insertResult = "+rsltCnt);
		return rsltCnt;
	}
	
	public List<Map<String, Object>> processFileValidation(File file, List<CmpnVldtRsltHst> cmprCmpnPrptyList, String userId, List<Map<String, Object>> result) 
			throws IOException, ParserConfigurationException, SAXException{

		String fileName = file.getName(); // ?????????
        String ext = fileName.substring(fileName.lastIndexOf(".") + 1); //?????? ?????????
        
		if(!file.isHidden() && file.isFile() && ext.equals("xfdl")){ // ????????? ????????? ?????????, ????????? ??????
            System.out.println("file ??? ?????? ?????? ");
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
	                //System.out.println("??? : "+key+", ??? : "+value);
	                System.out.println("????????? : "+key);
	                Map f_value = (Map)fileCmpnList.get(key);
	                
	                Iterator<String> c_keys = f_value.keySet().iterator();
	                
	                while( c_keys.hasNext() ){
	                    String c_key = c_keys.next();
	                    //Map value = (Map)fileCmpnList.get(key);
	                    //System.out.println("??? : "+key+", ??? : "+value);
	                    System.out.println("??????????????? : "+c_key);
	                    Map c_value = (Map)f_value.get(c_key);
	                                                
	                    Iterator<String> p_keys = c_value.keySet().iterator();
	                    
	                    for(int p = 0; p < cmprCmpnPrptyList.size(); p++) {                            	
	                    	Map<String, Object> cmpnVldtRsltHst = new HashMap<String, Object>();
	                    	
	    	                cmpnVldtRsltHst.put("flId", path.toString()); // ?????????(path??????)
	    	                cmpnVldtRsltHst.put("prjtCd", cmprCmpnPrptyList.get(p).getPrjtCd()); //??????????????????
	    	                cmpnVldtRsltHst.put("uiCd", cmprCmpnPrptyList.get(p).getUiCd()); //UI??????    
	    	                //cmpnVldtRsltHst.put("itrtSeq", itrtSeq); // ??????
	    	                cmpnVldtRsltHst.put("frstCrtrId", userId); // ???????????????ID
	    	                cmpnVldtRsltHst.put("lstMdfrId", userId); // ???????????????ID
	    	                
	                    	//????????? ???????????? key??? ???????????? ???????????? key?????? ????????????
	                    	if(c_key.contains(cmprCmpnPrptyList.get(p).getCmpnKey())) { 
	                    		cmpnVldtRsltHst.put("cmpnCd", cmprCmpnPrptyList.get(p).getCmpnCd()); //??????????????????
	                    		cmpnVldtRsltHst.put("vldtSbjTermCd", cmprCmpnPrptyList.get(p).getVldtSbjTermCd()); //????????????????????????
	                    		if(c_key.contains("Cell")) { // ???????????? ??????, ???????????????????????? ID??? ????????????.
	                    			String cell_editType = "";
	                    			if(c_value.get("edittype") != null) {
	                    				cell_editType = (String)c_value.get("edittype"); //????????? cell??? edit type
	                    			}else {
	                    				cell_editType = "none"; //????????? cell??? edit type??? ????????? default ?????? "none" ??????
	                    			}
	                    			
	                    			String grdNm = c_key.substring(c_key.lastIndexOf(":")+1);
	                    			String temp_cellNm =  c_key.replace("Cell","");
	                    			String cellNm = temp_cellNm.substring(0,temp_cellNm.indexOf(":"));
	                    			
	                    			System.out.println("prgmCmpnId : "+grdNm + "." + cellNm);
	                    			
	                    			// ????????? cell edittype??? text, mask ??? ??????????????????
	                    			if(cell_editType.equals("text")||cell_editType.equals("mask")) {	                            				                            			
	                        			cmpnVldtRsltHst.put("prgmCmpnId", grdNm + "." + cellNm); //????????????????????????ID
	                        			
	                        		// ????????? cell edittype??? ??????????????? ?????????
	                    			}else {
	                    				continue;
	                    			}
	                    			
	                    		}else {
	                    			cmpnVldtRsltHst.put("prgmCmpnId", (String)c_value.get("id")); //????????????????????????ID
	                    		}
	                    		                            		
	                    		// "userproperty" ????????? ????????????
	                    		//if(c_value.containsKey("userproperty")) {
	                    			
	                    			// "userproperty" ???????????? ????????????????????? ????????????
	                    			//if(c_value.get("userproperty").toString().contains(cmprCmpnPrptyList.get(p).getVldtRuleCd())) {
	                    				cmpnVldtRsltHst.put("vldtRuleCd", cmprCmpnPrptyList.get(p).getVldtRuleCd()); //??????????????????
	                    				
			                            //while( p_keys.hasNext() ){ // ?????? ??????????????? property??? ?????? ?????? ??????
			                                String p_key = p_keys.next();
			                                String p_value = (String)c_value.get(p_key);
			                                System.out.println("???????????? : "+p_key+", ??? : "+p_value);
			                                
		                                cmpnVldtRsltHst.put("prpty", cmprCmpnPrptyList.get(p).getPrpty()); //????????????
	                    				cmpnVldtRsltHst.put("prptyVl", cmprCmpnPrptyList.get(p).getPrptyVl()); //???????????????
	                    				cmpnVldtRsltHst.put("dfltVl", cmprCmpnPrptyList.get(p).getDfltVl()); //????????????                            				
	                    				
	                    				//?????????????????? ","??? ???????????? ???????????? ???????????? ????????? ???????????? ??????
	                    				String temp_mstPrpty = cmprCmpnPrptyList.get(p).getPrptyVl().replace(" ","");
	                    				String [] mstPrpty = temp_mstPrpty.split(",");
	                    				String strPgmPrpty = "";
	                    				String temp_pgmPrpty = "";
	                    				String [] pgmPrpty = new String[15];
	                    				
	                    				//System.out.println("???????????? : " +cmprCmpnPrptyList.get(p).getPrpty());
	                    				//System.out.println("??????????????? : " +cmprCmpnPrptyList.get(p).getPrptyVl());
	                    				//System.out.println("mstPrpty?????? : " +mstPrpty.length);
	                    				
	                    				//?????????????????? null??? ?????? ???
	                    				if(c_value.get(cmprCmpnPrptyList.get(p).getPrpty()) != null) {
	                        				strPgmPrpty = (String)c_value.get(cmprCmpnPrptyList.get(p).getPrpty());
	                        				temp_pgmPrpty = strPgmPrpty.replace(" ","");
	                        				pgmPrpty = temp_pgmPrpty.split(",");
	                        				//System.out.println("???????????? ??????????????? : " +strPgmPrpty);
	                        				
	                    				}else {
	                    					strPgmPrpty = "";
	                        				temp_pgmPrpty = strPgmPrpty.replace(" ","");
	                        				pgmPrpty = temp_pgmPrpty.split(",");
	                    				}
	                    				
	                    				//??????????????? ??????????????? ????????????, ????????? ?????????????????? ????????? ???????????? ?????????????????? ????????? ????????????
	                    				if(c_value.containsKey(cmprCmpnPrptyList.get(p).getPrpty())&& mstPrpty.length == pgmPrpty.length) {
	                    					
	                    					//System.out.println("???????????? : " +strPgmPrpty);
	                    					int cnt = 0;
	                    						
	                						//??????????????? ????????? ?????????????????? ???????????? ??????????????? ????????? ?????? ??????
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
	                						
	                						//????????? ?????????????????? ???????????? ??????????????? ????????? ??????, ??? ?????? ???????????? 
	                						if(mstPrpty.length == cnt) {
	                							cmpnVldtRsltHst.put("vldtRstYn", "Y"); //??????????????????
	                        					cmpnVldtRsltHst.put("prgmVl", (String)c_value.get(cmprCmpnPrptyList.get(p).getPrpty())); //???????????????
	                        					cmpnVldtRsltHst.put("rmrk", "???????????? ???????????? ???????????? ????????? ??????. ????????????"); 
	                						}else {
	                							cmpnVldtRsltHst.put("vldtRstYn", "N"); //??????????????????
	                           					cmpnVldtRsltHst.put("prgmVl", (String)c_value.get(cmprCmpnPrptyList.get(p).getPrpty())); //???????????????
	                           					cmpnVldtRsltHst.put("rmrk", "???????????? ???????????? ???????????? ????????? ??????.");
	                						}                            					
	                    					
	                    				//??????????????? ????????? ????????? ????????? ?????? ???????????? ?????? ??????, ?????????????????? ??????????????? ??????
	                    				}else if(!c_value.containsKey(cmprCmpnPrptyList.get(p).getPrpty())) {
	                       					cmpnVldtRsltHst.put("vldtRstYn", "N"); //??????????????????
	                       					cmpnVldtRsltHst.put("prgmVl", cmprCmpnPrptyList.get(p).getDfltVl()); //???????????????
	                       					cmpnVldtRsltHst.put("rmrk", "???????????? ????????? ??????. Default????????? ?????????");
	                       				//????????? ?????????????????? ??????????????? ????????? ???????????? ?????????
	                    				}else {
	                       					cmpnVldtRsltHst.put("vldtRstYn", "N"); //??????????????????
	                       					cmpnVldtRsltHst.put("prgmVl", (String)c_value.get(cmprCmpnPrptyList.get(p).getPrpty())); //???????????????
	                       					cmpnVldtRsltHst.put("rmrk", "???????????? ???????????? ???????????? ????????? ??????.");
	                    				}                                                           
			                            //}
	                    			//}else { //"userproperty" ???????????? ????????????????????? ???????????? ?????????
	                    				//continue;
										/*
										 * cmpnVldtRsltHst.put("vldtRuleCd",
										 * cmprCmpnPrptyList.get(p).getVldtRuleCd()); //??????????????????
										 * cmpnVldtRsltHst.put("prpty", null); //????????????
										 * cmpnVldtRsltHst.put("prptyVl",null); //???????????????
										 * cmpnVldtRsltHst.put("dfltVl", null); //???????????? cmpnVldtRsltHst.put("prgmVl",
										 * null); //??????????????? cmpnVldtRsltHst.put("vldtRstYn", "N"); //??????????????????
										 * cmpnVldtRsltHst.put("rmrk", "userproperty ???????????? ?????????????????? ?????????. ????????????.");
										 */  
	                    			//}
	                    		//}else { // "userproperty" ????????? ?????????????????????
	                    			//continue;
									/*
									 * cmpnVldtRsltHst.put("cmpnCd", cmprCmpnPrptyList.get(p).getCmpnCd()); //??????????????????
									 * cmpnVldtRsltHst.put("vldtSbjTermCd",
									 * cmprCmpnPrptyList.get(p).getVldtSbjTermCd()); //????????????????????????
									 * cmpnVldtRsltHst.put("vldtRuleCd", null); //??????????????????
									 * cmpnVldtRsltHst.put("prpty", null); //????????????
									 * cmpnVldtRsltHst.put("prptyVl",null); //??????????????? cmpnVldtRsltHst.put("dfltVl",
									 * null); //???????????? cmpnVldtRsltHst.put("prgmVl", null); //???????????????
									 * cmpnVldtRsltHst.put("vldtRstYn", "N"); //?????????????????? cmpnVldtRsltHst.put("rmrk",
									 * "userproperty ?????? ?????????. ????????????.");
									 */
	                    		//}
	                    		
	                    		if(!cmprCmpnPrptyList.get(p).getScrpCntn().equals(null)&&!cmprCmpnPrptyList.get(p).getScrpCntn().equals("")){ //?????? ???????????? ????????? ?????????????????????, ?????? ??????????????? ????????????????????? ????????? ??????
	                    			
	                    			String temp_scrpCntn = cmprCmpnPrptyList.get(p).getScrpCntn().replace(" ","");
	                				String [] mstScrpCntn = temp_scrpCntn.split(",");
	                				int scrpCnt = 0;
	                				String vldtScrpCntn = "";
	                				String fail_vldtScrpCntn = "";
	                				
	                        		if(f_value.containsKey("script") && f_value.get("script") != null) {                                			
	                    				
	                        			for(int q = 0; q < mstScrpCntn.length; q++) {
	                            			System.out.println("?????? ???????????? ?????? : this."+(String)c_value.get("id")+"."+mstScrpCntn[q]);
	                            			if(f_value.get("script").toString().contains("this."+(String)c_value.get("id")+"."+mstScrpCntn[q])){
	                            				scrpCnt++;
	                            				vldtScrpCntn = "this."+(String)c_value.get("id")+"."+mstScrpCntn[q];
	                            			}else {
	                            				fail_vldtScrpCntn = "this."+(String)c_value.get("id")+"."+mstScrpCntn[q];
	                            			}	                                			
	                        			}
	                        			//?????? ???????????? ????????? ???????????? ??? ????????????
	                        			if(scrpCnt >= 1){
	                        				cmpnVldtRsltHst.put("vldtRstYn", "Y"); //??????????????????
	                        				cmpnVldtRsltHst.put("vldtScrpCntn", vldtScrpCntn); //????????????????????????
	                        				cmpnVldtRsltHst.put("scrpExstYn", "Y"); //????????????????????????                               					
	                       					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n?????? ???????????? ????????? ?????????. ????????????");
	                       				//?????? ???????????? ????????? ???????????? ??? ???????????? ?????????
	                        			}else {
	                        				//??????????????? ???????????? ??????????????? ?????? "Y"(??????)??? ??????
	                        				if(cmpnVldtRsltHst.get("vldtRstYn").equals("Y")) {
	                            				cmpnVldtRsltHst.put("vldtScrpCntn", fail_vldtScrpCntn); //????????????????????????
	                            				cmpnVldtRsltHst.put("scrpExstYn", "N"); //????????????????????????                               					
	                           					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n?????? ???????????? ????????? ???????????? ??????????????? ???????????????, ???????????? ???????????? ????????????");
	                           				//??????????????? ???????????? ?????? ??????
	                        				}else {
	                        					cmpnVldtRsltHst.put("vldtScrpCntn", fail_vldtScrpCntn); //????????????????????????
	                            				cmpnVldtRsltHst.put("scrpExstYn", "N"); //????????????????????????                               					
	                           					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n?????? ???????????? ????????? ???????????? ??????????????? ?????????.");
	                        				}
	                        			}                                			
	                        		}else {//script??? ???????????? ?????????????????? ?????? ???
	                        			cmpnVldtRsltHst.put("vldtScrpCntn", "this."+(String)c_value.get("id")+"."+mstScrpCntn[0]); //???????????????????????? --> ???????????? ???????????? ????????? ???, ???????????? ?????? ???????????? ?????? ??? ????????? ?????? ??????
	                    				cmpnVldtRsltHst.put("scrpExstYn", "N"); //????????????????????????                               					
	                   					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n???????????? ???????????? ????????????.");
	                        		}
	                       		//?????? ???????????? ????????? ?????????????????? ?????????
	                        	}else {
	                        		cmpnVldtRsltHst.put("scrpExstYn", "N"); //????????????????????????                               					
	               					cmpnVldtRsltHst.put("rmrk", cmpnVldtRsltHst.get("rmrk").toString()+"\n?????? ???????????? ?????? ?????????.");
	                        	}
	                    	}else { //????????? ???????????? key??? ???????????? ???????????? key?????? ??????????????? 
	                    		continue;
								/*
								 * cmpnVldtRsltHst.put("cmpnCd", cmprCmpnPrptyList.get(p).getCmpnCd()); //??????????????????
								 * cmpnVldtRsltHst.put("vldtSbjTermCd",
								 * cmprCmpnPrptyList.get(p).getVldtSbjTermCd()); //????????????????????????
								 * cmpnVldtRsltHst.put("vldtRuleCd", null); //??????????????????
								 * cmpnVldtRsltHst.put("prpty", null); //????????????
								 * cmpnVldtRsltHst.put("prptyVl",null); //??????????????? cmpnVldtRsltHst.put("dfltVl",
								 * null); //???????????? cmpnVldtRsltHst.put("prgmVl", null); //???????????????
								 * cmpnVldtRsltHst.put("vldtRstYn", "N"); //?????????????????? cmpnVldtRsltHst.put("rmrk",
								 * "???????????? ???????????? ??????. ????????????.");
								 */
	                    	}
	                    	
	                    	result.add(cmpnVldtRsltHst);
	                    }
	                }
	            }
	            System.out.println("==========================================");
	            
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
			System.out.println("file ??? ?????? ?????? ");
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
        private String grdId = ""; //?????????ID??? ???????????? ????????????
        
	    private ArrayList<String> tagList  = new ArrayList<String>();
	    
	    public void setDocumentLocator(Locator loc){ 
	    	filename = loc.getSystemId();
	    	System.out.println("[??????] "+loc.getSystemId());   
	    }
	    // XML ????????? ????????? ??????????????? ??? ???????????? ???????????? ??????
	    public void startDocument() {
	        //System.out.println("Start Document");		    	
	    }
	     
	    // XML ????????? ?????? ??????????????? ??? ???????????? ???????????? ??????
	    public void endDocument() {
	        //System.out.println("End Document");
	    	 fileCmpn.put(filename, cmpnList); //?????????, ?????? ??? ??????????????? properties & value
	    	 cmpnList = new HashMap<String, Object>(); //cmpnList Map ?????????
	    }
	  
	    // ??????????????? ????????? ??????????????? ??? ???????????? ???????????? ??????
	    public void startElement(String uri, String localName, String qname, Attributes attr) {
	        elementName = qname;    //element?????? ?????? ????????? ?????? ??????.
	        //int attrCount=attr.getLength(); // ?????? ??????
	        //String attrName=attr.getQName(0); // ????????? ?????? ?????? ??????
	        //String attrValue=attr.getValue(attrName);
	       
	        Map<String, String> prptyList = new HashMap<String, String>();//???????????? ???????????? prptyList Map ?????????
	        
	        String attrName = "";
	        String attrValue = "";     	       
	        
	        // ?????? ???????????? : FDL / Form / Layouts / Layout	 / Formats/ Format / Objects / Dataset / ColumnInfo / Column 
	        //             Rows / Row / Col / Columns
	        if(!qname.equals("FDL")&&!qname.equals("Form")&&!qname.equals("Layouts")&&!qname.equals("Layout")&&
	           !qname.equals("Formats")&&!qname.equals("Format")&&!qname.equals("Objects")&&!qname.equals("Dataset")&&
	           !qname.equals("ColumnInfo")&&!qname.equals("Column")&&!qname.equals("Rows")&&!qname.equals("Row")&&
	           !qname.equals("Col")&&!qname.equals("Columns")){
		        int attrCount=attr.getLength(); // ?????? ??????
		        System.out.print("[????????????] " + qname+" : "); 
		        	for(int i=0; i<attrCount; i++){ // element ??? ?????? ?????? ?????? loop
		        		attrName=attr.getQName(i);
		        		attrValue=attr.getValue(attrName);
		        		/*
		        		if(attrName.equals("file")){
		        			if(attrValue.length() >= 9){
		        				String file_nm = attrValue.substring(attrValue.lastIndexOf(".")-6);
		        				tagList.add(file_nm); 
		                }*/
		        		if(!qname.equals("Grid")&&attrName.equals("id")) { //????????? id ??????
		        			qname = qname + attrValue; // element??? + id??? value(???:EditSSN1)
		        		}else if(qname.equals("Grid")&& attrName.equals("id")) {
		        			grdId = attrValue;
		        			System.out.print("grdId0"+" = "+grdId); 
		        		}else if(qname.equals("Cell") && attrName.equals("text")) { 
		        			//????????? Cell ????????? ?????? Cell??? ??????????????? ????????????????????? qname??? attach ???
		        			//?????? : <Cell text="bind:SSN" edittype="text" editinputtype="digit" editmaxlength="13"/>
		        			//?????? : qname = Cell + SSN
		        			qname = qname + attrValue.substring(attrValue.lastIndexOf(":")+1)+":"+grdId;
		        			System.out.print("grdId1"+" = "+grdId); 
		        		}
		        		
		            	System.out.print(attrName+" = "+attrValue+", "); 
		            	prptyList.put(attrName, attrValue); //properties & value
		            }		         
		        	System.out.println("");
		        	cmpnList.put(qname, prptyList); //????????? element ???????????? ??????????????? ???????????? Map ??? put
	         }
	          
	        //System.out.println("?????????=============" + attrName+"=="+attrValue);
	       
	        sBuffer.setLength(0);    // buffer ?????????
	    }
	  
	    // ??????????????? ?????? ??????????????? ??? ???????????? ???????????? ??????
	    public void endElement(String uri, String localName, String qname) {   
	        System.out.println("End element, Name: " + qname);
	        if(qname.equals("Script")) {
	        	Map<String, String> scriptCntn = new HashMap<String, String>();
	        	scriptCntn.put("script",stringScript);
	        	cmpnList.put("script", scriptCntn);
	        }
	    }
	  
	    // ??? element??? ??? (????????? ????????? ??? ??????????????? ????????? ??????)
	    public void characters(char[] ch, int start, int length) throws SAXException {
	        String strValue = "";
	  
	        // element??? ?????? ????????? ???????????? buffer??? ????????? ??? ????????? start?????? length?????? append??????.
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
	    /*
	    public ArrayList getTagList() {
	        return tagList;
	    }*/
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
