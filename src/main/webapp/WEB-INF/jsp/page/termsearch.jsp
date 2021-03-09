<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div style="display: flex; flex-direction: column;">
	<div class="content-section-wrapper">
		<div>
			<jsp:include page="../component/searchTerm.jsp">
				<jsp:param name="idPrefix" value="termsearch_search_" />
				<jsp:param name="bListScreen" value="false" />
			</jsp:include>
		</div>
	</div>
	<div class="content-section-wrapper content-jqgrid-table">
		<div>
			<div class="" id="termsearch_jqgrid_table_wrapper">
			</div>
		</div>
	</div>
	<div class="content-section-wrapper">
		<div style="background-color: initial; border: none; text-align: right;">
			<button id="termsearch_download_excel" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />다운로드</button>
			<button id="termsearch_download_excel_all" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />전체 다운로드</button>
		</div>
	</div>
</div>
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

<script type="text/javascript">

const termsearch_jqgrid_table = 'termsearch_jqgrid_table';
const termsearch_jqgrid_pager = 'termsearch_jqgrid_pager';

const termsearch_onCloseTab = function () {
	termsearch_jqGrid_url = 'term/list_approved';
	$("#termsearch_search_button_reset").click();
};

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

let termsearch_jqGrid_url = 'term/list_approved';

const termsearch_construct_jqgrid = function () {
	$("#" + termsearch_jqgrid_table).jqGrid({
		url: termsearch_jqGrid_url,
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
			'*용어',
			'단어분해',
			'영문명',
			'domain ID',
			'도메인',
			'도메인타입',
			'데이터 타입(길이)',
			'*정의',
			'신청자',
			'신청자 ID',
			'신청일시',
		],
		colModel : [
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
				name : 'term', // '*Нэр томьёо'
				index : 'term',
				width : 190,
				editable : false
			},
			{
				name : 'wordDecompositionKor', // 'үгийн задрал'
				index : 'wordDecompositionKor',
				width : 190,
				editable : false
			},
			{
				name : 'wordDecompositionEng', // 'Англи нэршил'
				index : 'wordDecompositionEng',
				width : 190,
				editable : false
			},
			{
				name : 'domainId', // 'domain ID'
				index : 'domainId',
				hidden: true,
			},
			{
				name : 'domainText', // 'domain'
				index : 'domainText',
				width : 159,
				editable : false
			},
			{
				name : 'domainTypeText', // 'Domainтөрөл'
				index : 'domainTypeText',
				width : 182,
				editable : false
			},
			{
				name : 'domainDataTypeLength', // 'дата төрөл(урт)'
				index : 'domainDataTypeLength',
				width : 125,
				editable : false
			},
			{
				name : 'definition', // '*Тодорхойлолт'
				index : 'definition',
				width : 284,
				editable : false
			},
			{
				name : 'firstname', // 'хүсэлт гаргагч'
				index : 'firstname',
				width : 100,
				editable : false
			},
			{
				name : 'username',
				index : 'username',
				hidden: true,
			},
			{
				name : 'createdDate', // 'Хүсэлт гаргасан огноо'
				index : 'createdDate',
				width : 125,
				editable : false,
				align: "center",
			},
		],
		pager: '#' + termsearch_jqgrid_pager,
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
	$("#" + termsearch_jqgrid_table).jqGrid('navGrid', '#' + termsearch_jqgrid_pager, {
	    edit : false,
	    add : false,
	    del : false,
	    search : false,
	});
};
</script>
