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
						<div class='search_word_condition_label_wrapper'>수정일자</div>
						<div class='search_word_condition_value_wrapper'>
							<div style='display: flex; justify-content: space-between; max-width: 400px; font-size: 16px;'>
								<div class='input-group date'>
									<input type='text' class="form-control" id='datepicker_start' placeholder="시작일" autocomplete="off" value="${sWeekBefore}" />
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
								-
								<div class='input-group date'>
									<input type='text' class="form-control" id='datepicker_end' placeholder="만료일" autocomplete="off" value="${sToday}" />
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div style="flex: 1;">
					
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>UI TOOL</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="col-sm-8">
								<select id='uitool' class="form-control input-sm">
									<c:forEach items="${aUICdList}" var="oUItool">
										<option value='${oUItool.code}'>${oUItool.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div style="flex: 0.6;">
					<div style='display: flex; justify-content: center;'>
						<button class='btn btn-default search_button' id="button_reset">초기화</button>
						<button class='btn btn-default search_button' id="button_search">조회</button>
						<button class='btn btn-default search_button' id="button_save">저장</button>						
					</div>
				</div>
			</div>
		</div>
		
		<!-- 조회조건 영역 -->
	</div>
	<div class="content-section-wrapper content-jqgrid-table">
		<div>
			<table width ="100%" >
				<tr>
					<td>
					<div style="background-color: initial; border: none; text-align: right; padding-bottom:5px;">
						검사 Path <input type="text" id="vldtFilePath1" width="500px" name="vldtFilePath1"><button class='btn btn-default search_button' id="button_temp1">검사 수행</button>							
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div>
			<table width ="100%" >
				<tr>
					<td width ="47%">
						<div style="background-color: initial; border: none; text-align: right; padding-bottom:5px;">
							<button id="ui_tool_addRow" class="btn_excel_download">행추가</button>
							<button id="ui_tool_delRow" class="btn_excel_download">행삭제</button>
						</div>
						<div class="" id="ui_tool_jqgrid_table_wrapper">
						</div>
					</td>
					<td width ="6%"></td>
					<td width ="47%">	
						<div style="background-color: initial; border: none; text-align: right; padding-bottom:5px;">
							<button id="cmpnmst_addRow" class="btn_excel_download">행추가</button>
							<button id="cmpnmst_delRow" class="btn_excel_download">행삭제</button>
						</div>
						<div class="" id="cmpnmst_jqgrid_table_wrapper">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="content-section-wrapper">
	<!--  
		<div style="background-color: initial; border: none; text-align: right;">
			<button id="termsearch_download_excel" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />다운로드</button>
			<button id="termsearch_download_excel_all" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />전체 다운로드</button>
		</div>
	-->
	</div>
</div>
<!--  
<div class="modal fade" id="term_excel_download_all" tabindex="-1" role="dialog" aria-labelledby="term_excel_download_all_label" aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="term_excel_download_all_label">다운로드 중입니다. 데이터가 많을 경우 오래 걸릴 수 있습니다.</h5>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" id ="term_excel_cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
-->
<script type="text/javascript">

const cmpnmst_jqgrid_table = 'cmpnmst_jqgrid_table';
const ui_tool_jqgrid_table = 'ui_tool_jqgrid_table';
const cmpnmst_jqgrid_pager = 'cmpnmst_jqgrid_pager';
const ui_tool_jqgrid_pager = 'ui_tool_jqgrid_pager';

const cmpnmst_onCloseTab = function () {
	//cmpnmst_jqGrid_url = 'term/list_approved'; //controller 경로
	$("#cmpnmst_search_button_reset").click();
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
$("#button_reset").click(function () {

	const sWeekBefore = '${sWeekBefore}';
   	const sToday = '${sToday}';
   	$('#datepicker_start').val(sWeekBefore);
	$('#datepicker_end').val(sToday);

	//combo박스 초기화
	$("#uitool option:eq(0)").prop("selected", true);

	$(this).blur();
});

/*조회 버튼*/
$("#button_search").click(function () {
	const selected_uitool = $('#uitool option:selected').val(); 
	const dateStart = $('#datepicker_start').val();
	const dateEnd = $('#datepicker_end').val();

	if (validate_dates() === false) {
			alert('선택한 날짜가 유효하지 않습니다.');
			return;
	}

	const searchCnd = {
  			dateStart: dateStart,
  			dateEnd: dateEnd,
  			selected_uitool: selected_uitool
	};

	ui_tool_jqGrid_url = 'cmpnMng/UItoollist?' + jQuery.param(searchCnd);

	$('#ui_tool_jqgrid_table_wrapper').html(`
		<table id="ui_tool_jqgrid_table">
		</table>
		<div id="ui_tool_jqgrid_pager"></div>
	`);
	ui_tool_jqgrid();

	$(this).blur();
});

/*테스트 버튼*/
$("#button_temp1").click(function () {

	const filePath1 = {filePath: $('#vldtFilePath1').val()};
	/*
	const filePath = {
  			filePath: "D:\\2021년\\NGS\\NGS\\test"
  			//filePath: "D:\\2021년\\NGS\\NGS\\NNB"
  			//filePath: "D:\\2021년\\NGS\\NGS"
	};*/

	const xhr1 = new XMLHttpRequest();

	xhr1.onreadystatechange = function () {
        if (xhr1.readyState === xhr1.DONE) {
            if (xhr1.status === 200 || xhr1.status === 201) {
                console.log(xhr1.responseText);
                if(xhr1.responseText >= 0)
                    alert("검증결과가 정상적으로 수행되었습니다.");
                //else if(xhr.responseText == 0)
                //    alert("검증결과가 생성된 건이 없습니다.");
            } else {
                console.error(xhr1.responseText);
                alert("검증결과 생성 시, 오류발생으로 실패했습니다.");
            }
        }
    };
	
	xhr1.open('POST', '/cmpnMng/test');
	//xhr.responseType = 'blob';
	const header = "${_csrf.headerName}", token = "${_csrf.token}";
    xhr1.setRequestHeader(header, token);
	xhr1.setRequestHeader('Content-type', 'application/json; charset=utf-8');
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
	alert(JSON.stringify(filePath1));
	xhr1.send(JSON.stringify(filePath1));

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

$("#termsearch_download_excel_all").click(function () {
		$(this).blur();
		$('#term_excel_download_all').modal('show');
		const domainContent = $('#termsearch_search_domain_content').val();
			const queryContent = $('#termsearch_search_query_content').val();
			const dateStart = $('#termsearch_search_datepicker_start').val();
			const dateEnd = $('#termsearch_search_datepicker_end').val();
		if (termsearch_search_validate_dates() === false) {
	  		alert('선택한 날짜가 유효하지 않습니다.');
	  		return;
	  	}
		const oSearchPayload = {
			dateStart: dateStart,
			dateEnd: dateEnd,
			requester: $('#termsearch_search_requester').val(),
			domainContent: domainContent,
			queryContent: queryContent,
		};
		const termsearch_csvdownload_url = '/term/download_excel_all?' + jQuery.param(oSearchPayload);
		const xhr = new XMLHttpRequest();
		xhr.open('POST', termsearch_csvdownload_url, true);
		xhr.responseType = 'blob';
		const header = "${_csrf.headerName}", token = "${_csrf.token}";
	    xhr.setRequestHeader(header, token);
		xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
		xhr.onload = function(e) {
		    if (this.status === 200) {
		    	$('#term_excel_download_all').modal('hide');
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
		    	$('#term_excel_download_all').modal('hide');
		        alert('Excel을 다운로드 할 수 없습니다.');
		    }
		};
		xhr.send(JSON.stringify({
		}));
		$("#term_excel_cancel").click(function (e) {
			xhr.abort();
		});
});
*/

/////////////////////////////////////////////////////////////////
//그리드 처리 영역
////////////////////////////////////////////////////////////////
//UI tool 마스터 grid

//let 구문은 블록 유효 범위를 갖는 지역 변수를 선언하며, 선언과 동시에 임의의 값으로 초기화할 수도 있다.
let ui_tool_jqGrid_url = 'cmpnMng/UItoollist';

const ui_tool_jqgrid = function () {
	$("#" + ui_tool_jqgrid_table).jqGrid({
		url: ui_tool_jqGrid_url,
		datatype: "json",
		mtype: 'POST',
		loadBeforeSend: function (jqXHR) {
		    const header = "${_csrf.headerName}",
		        token = "${_csrf.token}";
		    jqXHR.setRequestHeader(header, token);
		},
		colNames: [	'UI 코드','UI tool', '사용여부', '최종수정일자', '최종수정자'],
		colModel : [
			{	name : 'uiCd',	    index : 'uiCd',      width : 45,  align: "center"   },
			{	name : 'uiNm',      index : 'uiNm',      width : 90,  editable : true,	align: "left"   },
			{	name : 'useYn',     index : 'useYn',     width : 40,  editable : false, align: "center" },
			{	name : 'lstMddt',   index : 'lstMddt',   width : 60,  editable : false, align: "center" },
			{	name : 'lstMdfrId', index : 'lstMdfrId', width : 40,  editable : false, align: "left"   },			
		],
		pager: '#' + ui_tool_jqgrid_pager,
		rowNum : 20,
		height: 'auto',
		rowList : [ 10, 50, 100 ],
		sortname : 'uiCd',
		sortorder : 'asc',
		viewrecords : true,
		gridview: true,
		multiselect: true,
     	multiboxonly: true,
     	autowidth: true,
//      	shrinkToFit: true,
//      	forceFit: true,
        caption : '◆ UI tool 종류',
		jsonReader: {
			repeatitems: false,
     	},
		loadError: function (jqXHR, textStatus, errorThrown) {
			if (jqXHR.status === 403) {
				window.location.reload();
			}
	    },	
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
	$("#" + ui_tool_jqgrid_table).jqGrid('navGrid', '#' + ui_tool_jqgrid_pager, {
	    edit : false,
	    add : false,
	    del : false,
	    search : false,
	});
};

//컴포넌트 마스터 grid
const cmpnmst_jqgrid = function () {
	$("#" + cmpnmst_jqgrid_table).jqGrid({
		url: cmpnmst_jqGrid_url,
		datatype: "json",
		mtype: 'POST',
		loadBeforeSend: function (jqXHR) {
		    const header = "${_csrf.headerName}",
		        token = "${_csrf.token}";
		    jqXHR.setRequestHeader(header, token);
		},
		colNames: [	'UI 코드','컴포넌트 코드', '컴포넌트 명', '사용여부', '최종수정일자', '최종수정자'],
		colModel : [
			{	name : 'uiCd',	    index : 'uiCd',      hidden: true   },
			{	name : 'cmpnCd',    index : 'cmpnCd',    width : 50,  align: "center"   },			
			{	name : 'cmpnNm',    index : 'cmpnNm',    width : 100, editable : true,  align: "left"   },			
			{	name : 'useYn',     index : 'useYn',     width : 40,  editable : false, align: "center" },
			{	name : 'lstMddt',   index : 'lstMddt',   width : 60,  editable : false, align: "center" },
			{	name : 'lstMdfrId', index : 'lstMdfrId', width : 40,  editable : false, align: "left"   },	
		],
		pager: '#' + cmpnmst_jqgrid_pager,
		rowNum : 20,
		height: 'auto',
		rowList : [ 10, 50, 100 ],
		sortname : 'cmpnCd',
		sortorder : 'asc',
		viewrecords : true,
		gridview: true,
		multiselect: true,
     	multiboxonly: true,
     	autowidth: true,
//      	shrinkToFit: true,
//      	forceFit: true,
        caption : '◆ UI tool 별 컴포넌트 종류',
		jsonReader: {
			repeatitems: false,
     	},
		loadError: function (jqXHR, textStatus, errorThrown) {
			if (jqXHR.status === 403) {
				window.location.reload();
			}
	    },
	    gridComplete: function(){ // 첫번째 row 강제 선택
	        var grid = $("#cmpnmst_jqgrid_table"),
	        ids = grid.jqGrid("getDataIDs");
	        if(ids && ids.length > 0){
	            grid.jqGrid("setSelection", ids[0]);
	        }
	    },
	    /*
	    beforeSelectRow: function (rowid, e) { //체크박스 체크시에만 체크되도록 함.(row 클릭시 체크 안되게 함) 
	        var $myGrid = $(this),
	            i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
	            cm = $myGrid.jqGrid('getGridParam', 'colModel');
	        return (cm[i].name === 'cb');
	    },	    
	    onCellSelect: function(rowid, iCol) { //선택한 row 색 변경
	       	var rid = $("#cmpnmst_jqgrid_table").jqGrid('getDataIDs');
	    	for(var i=0 ; i < rid.length; i++){
	    						
				if(rowid != rid[i])
					$("#cmpnmst_jqgrid_table").setRowData(rid[i], false, {background:"white"});

				else $("#cmpnmst_jqgrid_table").setRowData(rowid, false, {background:"#87CEFA"});
			}
	    },  */
	});
	$("#" + cmpnmst_jqgrid_table).jqGrid('navGrid', '#' + cmpnmst_jqgrid_pager, {
	    edit : false,
	    add : false,
	    del : false,
	    search : false,
	});
};

/////////////////////////////////////////////////////////////////
//부가기능 처리 영역
////////////////////////////////////////////////////////////////
const validate_dates = function () {
	let bResult = false;
	const dateStart = $('#datepicker_start').val();
	const dateEnd = $('#datepicker_end').val();
	
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

$("#datepicker_start").datepicker({ showAnim: "fadeIn", dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
$("#datepicker_end").datepicker({ showAnim: "fadeIn", dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
$("#datepicker_start").next().on('click', function(){
    $('#datepicker_start').focus();
});
$("#datepicker_end").next().on('click', function(){
    $('#datepicker_end').focus();
});

/*
$(document).ready(function() {
    $('#vldtFilePath').on('change', function() {
    	var filePath = document.getElementById('vldtFilePath').files[0].name;
    	var fReader = new FileReader();
    	fReader.readAsDataURL(document.getElementById('vldtFilePath').files[0]);
    	fReader.onloadend = function(event){
			alert("filePath = "+ event.target.result);
        }
    	//$('#filePath').text(filePath);
    	//alert(filePath);
        $('#filePath').text($(this).val());
    });
});
*/
/*
document.getElementById("vldtFilePath").addEventListener("change", function(event) {
	alert(request.getContextPath());
	  //let output = document.getElementById("txtPath");
	  //let files = event.target.result;
		
	  let files = event.target.files;
	alert(files);
	},false);
	*/
</script>
