<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div style="display: flex; flex-direction: column;">
	<div class="content-section-wrapper">
		<div>
			<jsp:include page="../component/searchWord.jsp">
				<jsp:param name="idPrefix" value="wordsearch_search_" />
				<jsp:param name="bListScreen" value="false" />
			</jsp:include>
		</div>
	</div>
	<div class="content-section-wrapper content-jqgrid-table">
		<div>
			<div class="" id="wordsearch_jqgrid_table_wrapper">
			</div>
		</div>
	</div>
	<div class="content-section-wrapper">
		<div style="background-color: initial; border: none; text-align: right;">
			<button id="wordsearch_download_excel" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />다운로드</button>
			<button id="wordsearch_download_excel_all" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />전체 다운로드</button>
		</div>
	</div>
</div>
<div class="modal fade" id="word_excel_download_all" tabindex="-1" role="dialog" aria-labelledby="word_excel_download_all_label" aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="word_excel_download_all_label">다운로드 중입니다. 데이터가 많을 경우 오래 걸릴 수 있습니다.</h5>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" id ="word_excel_cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

const wordsearch_jqgrid_table = 'wordsearch_jqgrid_table';
const wordsearch_jqgrid_pager = 'wordsearch_jqgrid_pager';

const wordsearch_onCloseTab = function () {
	wordsearch_jqGrid_url = 'word/list_approved';
	$("#wordsearch_search_button_reset").click();
};

$("#wordsearch_download_excel").click(function () {
	$(this).blur();
	const myGrid = $('#' + wordsearch_jqgrid_table);
	const selectedRowId = myGrid.jqGrid('getDataIDs');
	const aSelectedRequestId = [];
	selectedRowId.forEach(function (item) {
		const cellValue = myGrid.jqGrid("getCell", item, "requestId");
		aSelectedRequestId.push(parseInt(cellValue, 10));
	});
	if (aSelectedRequestId.length > 0) {
		const xhr = new XMLHttpRequest();
		xhr.open('POST', '/word/download_excel', true);
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
		        let filename = "wordlist.xls";
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

$("#wordsearch_download_excel_all").click(function () {
		$(this).blur();
		$('#word_excel_download_all').modal('show');
  		const queryContent = $('#wordsearch_search_query_content').val();
  		const dateStart = $('#wordsearch_search_datepicker_start').val();
  		const dateEnd = $('#wordsearch_search_datepicker_end').val();
  		if (wordsearch_search_validate_dates() === false) {
      		alert('선택한 날짜가 유효하지 않습니다.');
      		return;
      	}
   		const oSearchPayload = {
  			dateStart: dateStart,
  			dateEnd: dateEnd,
			requester: $('#wordsearch_search_requester').val(),
   			queryContent: queryContent,
			};
   		const wordsearch_csvdownload_url = '/word/download_excel_all?' + jQuery.param(oSearchPayload);
		const xhr = new XMLHttpRequest();
		xhr.open('POST', wordsearch_csvdownload_url, true);
		xhr.responseType = 'blob';
		const header = "${_csrf.headerName}", token = "${_csrf.token}";
	    xhr.setRequestHeader(header, token);
		xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
		xhr.onload = function(e) {
		    if (this.status === 200) {
		    	$('#word_excel_download_all').modal('hide');
		        const blob = new Blob([this.response], {type: 'application/vnd.ms-excel'});
		        const downloadUrl = URL.createObjectURL(blob);
		        const a = document.createElement("a");
		        a.href = downloadUrl;
		        let filename = "wordlist.xls";
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
		    	$('#word_excel_download_all').modal('hide');
		        alert('Excel을 다운로드 할 수 없습니다.');
		    }
		};
		xhr.send(JSON.stringify({
		}));
		$("#word_excel_cancel").click(function (e) {
			xhr.abort();
		});
});

let wordsearch_jqGrid_url = 'word/list_approved';

const wordsearch_construct_jqgrid = function () {
	$("#" + wordsearch_jqgrid_table).jqGrid({
		url: wordsearch_jqGrid_url,
		datatype: "json",
		mtype: 'POST',
		loadBeforeSend: function (jqXHR) {
		    const header = "${_csrf.headerName}",
		        token = "${_csrf.token}";
		    jqXHR.setRequestHeader(header, token);
		},
		colNames: [
			'ID',
		    '상태 ID',
		    '상태',
		    '구분 ID',
		    '구분',
		    '검사 ID',
		    '검사',
		    '*표준단어',
		    '*영문약어',
		    '*영문명',
		    '유사어',
		    '분류어 여부 ID', // isClassified
		    '분류어 여부',
		    '출처',
		    '*정의',
		    '신청자',
		    '신청자 ID',
		    '신청일시',
		    '변경여부',
		],
		colModel: [
			{
		        name : 'requestId', // 'requestId'
		        index : 'requestId',
		        hidden: true,
			},
		    {
		        name : 'requestStatus', // 'Статус ID'
		        index : 'requestStatus',
		        hidden: true,
			},
			{
		        name : 'requestStatusText', // 'Статус'
		        index : 'requestStatusText',
		        width : 50,
		        align: "center",
			},
			{
		        name : 'registStatus', // 'Ангилал ID',
		        index : 'registStatus',
		        hidden: true,
			},
			{
		        name : 'registStatusText', // 'Ангилал',
		        index : 'registStatusText',
		        width : 40,
		        editable : false,
		        align: "center",
			},
			{
		        name : 'isNormal', // 'Шалгасан байдал ID'
		        index : 'isNormal',
		        hidden: true,
			},
			{
		        name : 'isNormalText', // 'Шалгасан байдал'
		        index : 'isNormalText',
		        width : 40,
		        editable : false,
		        align: "center",
			},
			{
		        name : 'standardWord', // '*Үндсэн нэршил'
		        index : 'standardWord',
		        width : 198,
		        editable : false,
			},
			{
		        name : 'abbrevationEng',
		        index : 'abbrevationEng',
		        width : 198,
		        editable : false,
			},
			{
		        name : 'standardWordEng',
		        index : 'standardWordEng',
		        width : 198,
		        editable : false,
			},
			{
		        name : 'synonyms',
		        index : 'synonyms',
		        width : 172,
		        editable : false,
			},
			{
		        name : 'isClassified',
		        index : 'isClassified',
		        hidden: true,
			},
			{
		        name : 'isClassifiedText',
		        index : 'isClassifiedText',
		        width : 50,
		        editable : false,
		        align: "center",
			},
			{
		        name : 'source',
		        index : 'source',
		        width : 156,
		        editable : false,
			},
			{
		        name : 'definition',
		        index : 'definition',
		        width : 298,
		        editable : false,
			},
			{
		        name : 'firstname',
		        index : 'firstname',
		        width : 120,
		        editable : false,
			},
			{
		        name : 'username',
		        index : 'username',
		        hidden: true,
			},
			{
		        name : 'createdDate',
		        index : 'createdDate',
		        width : 125,
		        editable : false,
		        align: "center",
			},
			{
		        name : 'isModified',
		        index : 'isModified',
		        width : 30,
		        editable : false,
		        align: "center",
			},
		],
		pager: '#' + wordsearch_jqgrid_pager,
		rowNum : 50,
		height: 'auto',
		rowList : [ 10, 50, 100 ],
		sortname : 'requestId',
		sortorder : 'desc',
		viewrecords : true,
		gridview: true,
		multiselect: false,
     	multiboxonly: false,
     	autowidth: true,
//      	shrinkToFit: true,
//      	forceFit: true,
         // caption : '',
		jsonReader: {
			repeatitems: false,
     	},
		loadError: function (jqXHR, textStatus, errorThrown) {
			if (jqXHR.status === 403) {
				window.location.reload();
			}
	    },
	});
	$("#" + wordsearch_jqgrid_table).jqGrid('navGrid', '#' + wordsearch_jqgrid_pager, {
	    edit : false,
	    add : false,
	    del : false,
	    search : false,
	});
};
</script>
