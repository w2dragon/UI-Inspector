<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div style="display: flex; flex-direction: column;">
	<div class="content-section-wrapper">
	    <!-- 조회조건 영역 -->	    
		<div class='search_word_fragment_wrapper' style="padding-top :15px; padding-bottom :10px;">
			<div style="display: flex; flex-direction: row;">
				<div style="flex: 1;">
								
					<div style="display: flex;">					
						<div class='search_word_condition_label_wrapper'>검사일자</div>
						<div class='search_word_condition_value_wrapper'>
							<div style='display: flex; justify-content: space-between; max-width: 400px; font-size: 16px;'>
								<div class='input-group date'>
									<input type='text' class="form-control" id='inspect_datepicker_start' placeholder="시작일" autocomplete="off" value="${sOneDayBefore}" />
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
								-
								<div class='input-group date'>
									<input type='text' class="form-control" id='inspect_datepicker_end' placeholder="만료일" autocomplete="off" value="${sToday}" />
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
							</div>
						</div>
					</div>
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>프로젝트</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="col-sm-8">
								<select id='prjt' class="form-control input-sm">
									<c:forEach items="${prjtCdList}" var="oPrjtList">
										<option value='${oPrjtList.code}'>${oPrjtList.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>UI TOOL</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="col-sm-8">
								<select id='vldt_uitool' class="form-control input-sm">
									<c:forEach items="${UICdList}" var="oUItool">
										<option value='${oUItool.code}'>${oUItool.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							검사결과
						</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="col-sm-8">
								<select id='search_vldtRstYn' class="form-control input-sm">	
								    <option value='' selected>--전체--</option>								
									<option value='N'>N</option>
									<option value='Y'>Y</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div style="flex: 1;">
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							차수
						</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="form-group">
								<input type="text" class="form-control" id="search_itrtSeq" placeholder="" autocomplete="off" />
							</div>
						</div>
					</div>
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							파일명
						</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="form-group">
								<input type="text" class="form-control" id="search_flId" placeholder="" autocomplete="off" />
							</div>
						</div>
					</div>					
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							검사대상용어코드
						</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="form-group">
								<input type="text" class="form-control" id="search_vldtSbjTermCd" placeholder="" autocomplete="off" />								
							</div>
						</div>
					</div>
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							검사대상용어명
						</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="form-group">								
								<input type="text" class="form-control" id="search_vldtSbjTermNm" placeholder="" autocomplete="off" />
							</div>
						</div>
					</div>
				</div>
				<div style="flex: 1;">
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							검사규칙코드
						</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="form-group">
								<input type="text" class="form-control" id="search_vldtRuleCd" placeholder="" autocomplete="off" />								
							</div>
						</div>
					</div>
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							검사규칙명
						</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="form-group">
								<input type="text" class="form-control" id="search_vldtRuleNm" placeholder="" autocomplete="off" />
							</div>
						</div>
					</div>
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							검사수행ID
						</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="form-group">
								<input type="text" class="form-control" id="search_frstCrtrId" placeholder="" autocomplete="off" />								
							</div>
						</div>
					</div>
				</div>
				<div style="flex: 0.6;">
					<div style='display: flex; justify-content: center;'>
						<button class='btn btn-default search_button' id="vldt_button_reset">초기화</button>
						<button class='btn btn-default search_button' id="vldt_button_search">조회</button>					
					</div>
				</div>
			</div>
		</div>
		
		<!-- 조회조건 영역 -->
	</div>	
		<div  style="flex: 1; display: flex; flex-direction: column;">
			<div style="display: flex; flex-direction: column; justify-content: space-between; align-items: flex-end; width: 100%; height: 100%;">
				<div id='inspect_path' style='width: 100%; flex: 1;'>
					<div style='display: flex; flex-direction: column;  height: 100%; width: 100%;'>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_definition" class="col-sm-4 control-label control-label-custom">검사 Path</label>
							<div class="col-sm-8">
								<input type='text' id='vldtFilePath' class="form-control input-sm" autocomplete="off" />							
							</div>
							<div class="col-sm-8">
								<button class='btn btn-default' id="button_inspect">검사 수행</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>					
		
	<div class="content-section-wrapper content-jqgrid-table">		
		<div>
			<table width ="100%" >
				<tr>
					<td>						
						<div class="" id="vldt_rslt_hst_jqgrid_table_wrapper">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="content-section-wrapper">
	  
		<div style="background-color: initial; border: none; text-align: right;">
		<!--<button id="termsearch_download_excel" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />다운로드</button>-->
			<button id="vldt_download_excel_all" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />전체 다운로드</button>
		</div>
	
	</div>
</div>
  
<div class="modal fade" id="mdVldt_excel_download_all" tabindex="-1" role="dialog" aria-labelledby="mdVldt_excel_download_all_label" aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="mdVldt_excel_download_all_label">다운로드 중입니다. 데이터가 많을 경우 오래 걸릴 수 있습니다.</h5>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" id ="vldt_excel_cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
-
<script type="text/javascript">

const vldt_rslt_hst_jqgrid_table = 'vldt_rslt_hst_jqgrid_table';
const vldt_rslt_hst_jqgrid_pager = 'vldt_rslt_hst_jqgrid_pager';


const uiinspect_onCloseTab = function () {
	//cmpnmst_jqGrid_url = 'term/list_approved'; //controller 경로
	$("#uiinspect_search_button_reset").click();
};

/*const domainlist_datatype_dict = [
	<c:forEach items="${UICdList}" var="oUItool">
		{
			id: '${oUItool.code}',
			value: '${oUItool.name}',
		},
	</c:forEach>
];*/
/////////////////////////////////////////////////////////////////
// 버튼 처리 영역
////////////////////////////////////////////////////////////////

/*초기화 버튼*/
$("#vldt_button_reset").click(function () {

	const sOneDayBefore = '${sOneDayBefore}';
   	const sToday = '${sToday}';
   	$('#inspect_datepicker_start').val(sOneDayBefore);
	$('#inspect_datepicker_end').val(sToday);

	//combo박스 초기화
	$("#prjt option:eq(1)").prop("selected", true);
	$("#vldt_uitool option:eq(1)").prop("selected", true);
	$("#search_vldtRstYn option:eq(0)").prop("selected", true);

	$(this).blur();
});

/*조회 버튼*/
$("#vldt_button_search").click(function () {
	const selected_prjtCd = $('#prjt option:selected').val();
	const selected_uitool = $('#vldt_uitool option:selected').val(); 
	const dateStart = $('#inspect_datepicker_start').val();
	const dateEnd = $('#inspect_datepicker_end').val();
	const search_vldtRstYn = $('#search_vldtRstYn').val(); 
	const search_itrtSeq = $('#search_itrtSeq').val(); 
	const search_flId = $('#search_flId').val(); 
	const search_vldtSbjTermCd = $('#search_vldtSbjTermCd').val(); 
	const search_vldtSbjTermNm =$('#search_vldtSbjTermNm').val(); 
	const search_vldtRuleCd = $('#search_vldtRuleCd').val(); 
	const search_vldtRuleNm = $('#search_vldtRuleNm').val(); 
	const search_frstCrtrId = $('#search_frstCrtrId').val(); 
	
	if (inspect_validate_dates() === false) {
			alert('선택한 날짜가 유효하지 않습니다.');
			return;
	}

	const searchCnd = {
  			dateStart: dateStart,
  			dateEnd: dateEnd,
  			selected_uitool: selected_uitool,
  			selected_prjtCd: selected_prjtCd,
  			search_vldtRstYn: search_vldtRstYn, 
	        search_itrtSeq: search_itrtSeq, 
	        search_flId: search_flId, 
	        search_vldtSbjTermCd: search_vldtSbjTermCd, 
	        search_vldtSbjTermNm:search_vldtSbjTermNm, 
	        search_vldtRuleCd: search_vldtRuleCd, 
	        search_vldtRuleNm: search_vldtRuleNm, 
	        search_frstCrtrId: search_frstCrtrId
	};

	vldt_rslt_hst_jqgrid_url = 'UIInspectMng/vldtrsltlist?' + jQuery.param(searchCnd);

	$('#vldt_rslt_hst_jqgrid_table_wrapper').html(`
			<table id="vldt_rslt_hst_jqgrid_table">
			</table>
			<div id="vldt_rslt_hst_jqgrid_pager"></div>
		`);
	vldt_rslt_hst_jqgrid();

	$(this).blur();
});

/*검사수행 버튼*/
$("#button_inspect").click(function () {

	const filePath = {filePath: $('#vldtFilePath').val()};
	/*
	const filePath = {
  			filePath: "D:\\2021년\\NGS\\NGS\\test"
  			//filePath: "D:\\2021년\\NGS\\NGS\\NNB"
  			//filePath: "D:\\2021년\\NGS\\NGS"
	};*/

	const xhr = new XMLHttpRequest();

	xhr.onreadystatechange = function () {
        if (xhr.readyState === xhr.DONE) {
            if (xhr.status === 200 || xhr.status === 201) {
                console.log(xhr.responseText);
                if(xhr.responseText >= 0)
                    alert("검증결과가 정상적으로 수행되었습니다.");
                //else if(xhr.responseText == 0)
                //    alert("검증결과가 생성된 건이 없습니다.");
            } else {
                console.error(xhr.responseText);
                alert("검증결과 생성 시, 오류발생으로 실패했습니다.");
            }
        }
        $("#vldt_button_search").trigger("click"); // 그리드 재조회
    };
	
	xhr.open('POST', '/UIInspectMng/inspect');
	//xhr.responseType = 'blob';
	const header = "${_csrf.headerName}", token = "${_csrf.token}";
    xhr.setRequestHeader(header, token);
	xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
	/* xhr.onload = function(e) {
	    if (this.status === 200) {
	         const blob = new Blob([this.response], {type: 'application/vnd.ms-excel'});
	        const downloadUrl = URL.createObjectURL(blob);
	        const a = document.createElement("a");
	        a.href = downloadUrl;
	        let filename = "domainlist.xls";
	        const disposition = xhr.getResponseHeader('Content-Disposition');
	        if (disposition && disposition.indexOf('attachment') !== -1) {
	            const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
	            const matches = filenameRegex.exec(disposition);
	            if (matches != null && matches[1]) { 
	           		filename = matches[1].replace(/['"]/g, '');
	            }
	        }
	        a.download = filename;
	        document.body.appendChild(a);
	        a.click();
	        window.URL.revokeObjectURL(downloadUrl); 
	    } else {
	        alert('서버접속 불가..');
	    }
	}; */
	//alert(JSON.stringify(filePath));
	xhr.send(JSON.stringify(filePath));

	$(this).blur();	
});
/*
$("#termsearch_download_excel").click(function () {
	$(this).blur();
	const myGrid = $('#' + termsearch_jqgrid_table);
	const selectedRowId = myGrid.jqGrid('getDataIDs');
	const aSelectedRequestId = [];
	selectedRowId.forEach(function (item) {
		const cellValue = myGrid.jqGrid("getCell", item, "requestId");
		aSelectedRequestId.push(parseInt(cellValue, 10));
	});
	if (aSelectedRequestId.length > 0) {
		const xhr = new XMLHttpRequest();
		xhr.open('POST', '/term/download_excel', true);
		xhr.responseType = 'blob';
		const header = "${_csrf.headerName}", token = "${_csrf.token}";
	    xhr.setRequestHeader(header, token);
		xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
		xhr.onload = function(e) {
		    if (this.status === 200) {
		        const blob = new Blob([this.response], {type: 'application/vnd.ms-excel'});
		        const downloadUrl = URL.createObjectURL(blob);
		        const a = document.createElement("a");
		        a.href = downloadUrl;
		        let filename = "termlist.xls";
		        const disposition = xhr.getResponseHeader('Content-Disposition');
		        if (disposition && disposition.indexOf('attachment') !== -1) {
		            const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
		            const matches = filenameRegex.exec(disposition);
		            if (matches != null && matches[1]) { 
		           		filename = matches[1].replace(/['"]/g, '');
		            }
		        }
		        a.download = filename;
		        document.body.appendChild(a);
		        a.click();
		        window.URL.revokeObjectURL(downloadUrl);
		    } else {
		        alert('Excel을 다운로드 할 수 없습니다.');
		    }
		};
		xhr.send(JSON.stringify({
			aSelectedRequestId: aSelectedRequestId,
		}));
	}
});
*/
$("#vldt_download_excel_all").click(function () {
		$(this).blur();
		$('#mdVldt_excel_download_all').modal('show');

		const selected_prjtCd = $('#prjt option:selected').val();
		const selected_uitool = $('#vldt_uitool option:selected').val(); 
		const dateStart = $('#inspect_datepicker_start').val();
		const dateEnd = $('#inspect_datepicker_end').val();
		const search_vldtRstYn = $('#search_vldtRstYn').val(); 
		const search_itrtSeq = $('#search_itrtSeq').val(); 
		const search_flId = $('#search_flId').val(); 
		const search_vldtSbjTermCd = $('#search_vldtSbjTermCd').val(); 
		const search_vldtSbjTermNm =$('#search_vldtSbjTermNm').val(); 
		const search_vldtRuleCd = $('#search_vldtRuleCd').val(); 
		const search_vldtRuleNm = $('#search_vldtRuleNm').val(); 
		const search_frstCrtrId = $('#search_frstCrtrId').val(); 
		
		if (inspect_validate_dates() === false) {
				alert('선택한 날짜가 유효하지 않습니다.');
				return;
		}

		const searchCnd = {
	  			dateStart: dateStart,
	  			dateEnd: dateEnd,
	  			selected_uitool: selected_uitool,
	  			selected_prjtCd: selected_prjtCd,
	  			search_vldtRstYn: search_vldtRstYn, 
		        search_itrtSeq: search_itrtSeq, 
		        search_flId: search_flId, 
		        search_vldtSbjTermCd: search_vldtSbjTermCd, 
		        search_vldtSbjTermNm:search_vldtSbjTermNm, 
		        search_vldtRuleCd: search_vldtRuleCd, 
		        search_vldtRuleNm: search_vldtRuleNm, 
		        search_frstCrtrId: search_frstCrtrId
		};

		const vldt_rslt_hst_csvdownload_url = 'UIInspectMng/download_excel_all?' + jQuery.param(searchCnd);

		const xhr = new XMLHttpRequest();
		xhr.open('POST', vldt_rslt_hst_csvdownload_url, true);
		xhr.responseType = 'blob';
		const header = "${_csrf.headerName}", token = "${_csrf.token}";
	    xhr.setRequestHeader(header, token);
		xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
		xhr.onload = function(e) {
		    if (this.status === 200) {
		    	$('#mdVldt_excel_download_all').modal('hide');
		        const blob = new Blob([this.response], {type: 'application/vnd.ms-excel'});
		        const downloadUrl = URL.createObjectURL(blob);
		        const a = document.createElement("a");
		        a.href = downloadUrl;
		        //let filename = "termlist.xls";
		        const disposition = xhr.getResponseHeader('Content-Disposition');
		        if (disposition && disposition.indexOf('attachment') !== -1) {
		            const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
		            const matches = filenameRegex.exec(disposition);
		            if (matches != null && matches[1]) { 
		           		filename = matches[1].replace(/['"]/g, '');
		            }
		        }
		        a.download = filename;
		        document.body.appendChild(a);
		        a.click();
		        window.URL.revokeObjectURL(downloadUrl);
		    } else {
		    	$('#mdVldt_excel_download_all').modal('hide');
		        alert('Excel을 다운로드 할 수 없습니다.');
		    }
		};
		xhr.send(JSON.stringify({
		}));
		$("#term_excel_cancel").click(function (e) {
			xhr.abort();
		});
});

/////////////////////////////////////////////////////////////////
//그리드 처리 영역
////////////////////////////////////////////////////////////////

const init_prjtCd = $('#prjt option:selected').val();
const init_uitool = $('#vldt_uitool option:selected').val(); 
const init_dateStart = $('#inspect_datepicker_start').val();
const init_dateEnd = $('#inspect_datepicker_end').val();

const searchCnd = {		
		dateStart: init_dateStart,
		dateEnd: init_dateEnd,
		selected_uitool: init_uitool,
		selected_prjtCd: init_prjtCd,
};

//let 구문은 블록 유효 범위를 갖는 지역 변수를 선언하며, 선언과 동시에 임의의 값으로 초기화할 수도 있다.
let vldt_rslt_hst_jqgrid_url = 'UIInspectMng/vldtrsltlist?' + jQuery.param(searchCnd);

const vldt_rslt_hst_jqgrid = function () {
	$("#" + vldt_rslt_hst_jqgrid_table).jqGrid({
		url: vldt_rslt_hst_jqgrid_url,
		datatype: "json",
		mtype: 'POST',
		loadBeforeSend: function (jqXHR) {
		    const header = "${_csrf.headerName}",
		        token = "${_csrf.token}";
		    jqXHR.setRequestHeader(header, token);
		},
		colNames: [	'프로젝트 코드', '프로젝트명', 'UI 코드', 'UI 명', '컴포넌트 코드', '컴포넌트명', '검사대상용어코드', '검사대상용어명',
			        '검사규칙코드', '검사규칙명', '디폴트값', '검사일자', '차수', '파일명', '프로그램컴포넌트ID', '검사대상프로퍼티', '검사대상프로퍼티값',
			        '프로그램프로퍼티값', '검사대상스크립트', '프로그램 내 스크립트 존재여부', '검사결과', '비고', '검사수행일시', '검사수행ID'],
		colModel : [
			{	name : 'prjtCd',	    index : 'prjtCd',        width : 45,  align: "center", hidden : true, },
			{	name : 'prjtNm',        index : 'prjtNm',        width : 50,  align: "left"   },
			{	name : 'uiCd',	        index : 'uiCd',          width : 35,  align: "center", hidden : true, },
			{	name : 'uiNm',          index : 'uiNm',          width : 40,  align: "left"   },
			{	name : 'cmpnCd',	    index : 'cmpnCd',        width : 35,  align: "center", hidden : true, },
			{	name : 'cmpnNm',        index : 'cmpnNm',        width : 40,  align: "left"   },
			{	name : 'vldtSbjTermCd',	index : 'vldtSbjTermCd', width : 45,  align: "left"   },
			{	name : 'vldtSbjTermNm', index : 'vldtSbjTermNm', width : 60,  align: "left"   },
			{	name : 'vldtRuleCd',	index : 'vldtRuleCd',    width : 55,  align: "left"   },
			{	name : 'vldtRuleNm',    index : 'vldtRuleNm',    width : 60,  align: "left"   },
			{	name : 'dfltVl',	    index : 'dfltVl',        width : 35,  align: "left"   },
			{	name : 'vldtDt',        index : 'vldtDt',        width : 50,  align: "left"   },
			{	name : 'itrtSeq',	    index : 'itrtSeq',       width : 25,  align: "right"  },
			{	name : 'flId',          index : 'flId',          width : 130, align: "left"   },
			{	name : 'prgmCmpnId',	index : 'prgmCmpnId',    width : 55,  align: "left"   },
			{	name : 'prpty',         index : 'prpty',         width : 50,  align: "left"   },
			{	name : 'prptyVl',	    index : 'prptyVl',       width : 35,  align: "left"   },
			{	name : 'prgmVl',        index : 'prgmVl',        width : 40,  align: "left"   },
			{	name : 'vldtScrpCntn',  index : 'vldtScrpCntn',  width : 120, align: "left"   },
			{	name : 'scrpExstYn',    index : 'scrpExstYn',    width : 45,  align: "center" },
			{	name : 'vldtRstYn',     index : 'vldtRstYn',     width : 20,  align: "center" },
			{	name : 'rmrk',          index : 'rmrk',          width : 120, align: "left"   },
			{	name : 'frstCrdt',      index : 'frstCrdt',      width : 80,  align: "center" },
			{	name : 'frstCrtrId',    index : 'frstCrtrId',    width : 40,  align: "left"   },			
		],
		pager: '#' + vldt_rslt_hst_jqgrid_pager,
		rowNum : 50,
		height: 'auto',
		rowList : [ 10, 50, 100 ],
		sortname : 'vldtDt, itrtSeq',
		sortorder : 'desc',
		viewrecords : true,
		gridview: true,
		multiselect: false,
     	multiboxonly: true,
     	autowidth: true,
//      	shrinkToFit: true,
//      	forceFit: true,
        caption : '◆ UI Validation 검사이력',
		jsonReader: {
			repeatitems: false,
     	},
		loadError: function (jqXHR, textStatus, errorThrown) {
			if (jqXHR.status === 403) {
				window.location.reload();
			}
	    },	
		/*
	    gridComplete: function(){ // 첫번째 row 강제 선택
	        var grid = $("#ui_tool_jqgrid_table"),
	        ids = grid.jqGrid("getDataIDs");
	        if(ids && ids.length > 0){
	            grid.jqGrid("setSelection", ids[0]);
	        }
	    },
	    onSelectRow: function (rowid, status, e){
	    	var rowData = jQuery("#ui_tool_jqgrid_table").getRowData(rowid);
	    	//alert(rowData.uiCd);
	    	//var uiCd = rowData.uiCd;
	    	const searchCnd = {
	    			uiCd: rowData.uiCd
	    	};
	    	    	
	    	cmpnmst_jqGrid_url = 'cmpnMng/cmpnlist?' + jQuery.param(searchCnd);

	    	$('#cmpnmst_jqgrid_table_wrapper').html(`		
				<table id="cmpnmst_jqgrid_table">
						</table>	
				<div id="cmpnmst_jqgrid_pager"></div>
			`);
	    	cmpnmst_jqgrid();
		},
	    /*   
	    beforeSelectRow: function (rowid, e) { //체크박스 체크시에만 체크되도록 함.(row 클릭시 체크 안되게 함) 
	        var $myGrid = $(this),
	            i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
	            cm = $myGrid.jqGrid('getGridParam', 'colModel');
	        return (cm[i].name === 'cb');
	    },	    
	    onCellSelect: function(rowid, iCol) { //선택한 row 색 변경
	       	var rid = $("#ui_tool_jqgrid_table").jqGrid('getDataIDs');
	    	for(var i=0 ; i < rid.length; i++){
	    						
				if(rowid != rid[i])
					$("#ui_tool_jqgrid_table").setRowData(rid[i], false, {background:"white"});

				else $("#ui_tool_jqgrid_table").setRowData(rowid, false, {background:"#87CEFA"});
			}
	    },*/
	});
	$("#" + vldt_rslt_hst_jqgrid_table).jqGrid('navGrid', '#' + vldt_rslt_hst_jqgrid_pager, {
	    edit : false,
	    add : false,
	    del : false,
	    search : false,
	});
};

/////////////////////////////////////////////////////////////////
//부가기능 처리 영역
////////////////////////////////////////////////////////////////

const inspect_validate_dates = function () {
	let bResult = false;
	const dateStart = $('#inspect_datepicker_start').val();
	const dateEnd = $('#inspect_datepicker_end').val();
	
	let bParsedStart = null;
	let bParsedEnd = null;
	let oDateStart = null;
	let oDateEnd = null;
	
	if (dateStart.trim().length > 0) {
		try {
 			oDateStart = new Date(dateStart);
 			bParsedStart = true;
 		} catch (err) {
 			bParsedStart = false;
     	}
	}
	if (dateEnd.trim().length > 0) {
		try {
			oDateEnd = new Date(dateEnd);
			bParsedEnd = true;
 		} catch (err) {
 			bParsedEnd = false;
     	}
	}
	if (bParsedStart === false || bParsedEnd === false) {
		bResult = false;
   	} else {
   		if (bParsedStart === true && bParsedEnd === true) {
   			if (oDateStart <= oDateEnd) {
   				bResult = true;
       		} else {
           		bResult = false;
           	}
   		} else {
   			bResult = true;
       	}
    }
   	return bResult;
};

$("#inspect_datepicker_start").datepicker({ showAnim: "fadeIn", dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
$("#inspect_datepicker_end").datepicker({ showAnim: "fadeIn", dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
$("#inspect_datepicker_start").next().on('click', function(){
    $('#inspect_datepicker_start').focus();
});
$("#inspect_datepicker_end").next().on('click', function(){
    $('#inspect_datepicker_end').focus();
});
</script>
