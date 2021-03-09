<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div style="display: flex; flex-direction: column;">
	<div class="content-section-wrapper">
		<div>
			<jsp:include page="../component/searchDomain.jsp">
				<jsp:param name="idPrefix" value="domainsearch_search_" />
				<jsp:param name="bListScreen" value="false" />
			</jsp:include>
		</div>
	</div>
	<div class="content-section-wrapper content-jqgrid-table">
		<div>
			<div class="" id="domainsearch_jqgrid_table_wrapper">
			</div>
		</div>
	</div>
	<div class="content-section-wrapper">
		<div style="background-color: initial; border: none; text-align: right;">
			<button id="domainsearch_download_excel" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />다운로드</button>
			<button id="domainsearch_download_excel_all" class="btn_excel_download"><img src="/static/img/xls.png" style="height: 20px; margin-right: 10px;" />전체 다운로드</button>
		</div>
	</div>
</div>
<div class="modal fade" id="domain_excel_download_all" tabindex="-1" role="dialog" aria-labelledby="domain_excel_download_all_label" aria-hidden="true"  data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="domain_excel_download_all_label">다운로드 중입니다. 데이터가 많을 경우 오래 걸릴 수 있습니다.</h5>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" id ="domain_excel_cancel" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

const domainsearch_jqgrid_table = 'domainsearch_jqgrid_table';
const domainsearch_jqgrid_pager = 'domainsearch_jqgrid_pager';

const domainsearch_onCloseTab = function () {
	domainsearch_jqGrid_url = 'domain/list_approved';
	$("#domainsearch_search_button_reset").click();
};

$("#domainsearch_download_excel").click(function () {
	$(this).blur();
	const myGrid = $('#' + domainsearch_jqgrid_table);
	const selectedRowId = myGrid.jqGrid('getDataIDs');
	const aSelectedRequestId = [];
	selectedRowId.forEach(function (item) {
		const cellValue = myGrid.jqGrid("getCell", item, "requestId");
		aSelectedRequestId.push(parseInt(cellValue, 10));
	});
	if (aSelectedRequestId.length > 0) {
		const xhr = new XMLHttpRequest();
		xhr.open('POST', '/domain/download_excel', true);
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
		        alert('Excel을 다운로드 할 수 없습니다.');
		    }
		};
		xhr.send(JSON.stringify({
			aSelectedRequestId: aSelectedRequestId,
		}));
	}
});

$("#domainsearch_download_excel_all").click(function () {
		$(this).blur();
		$('#domain_excel_download_all').modal('show');
		const queryContent = $('#domainsearch_search_query_content').val();
		const dateStart = $('#domainsearch_search_datepicker_start').val();
		const dateEnd = $('#domainsearch_search_datepicker_end').val();
		if (domainsearch_search_validate_dates() === false) {
	  		alert('선택한 날짜가 유효하지 않습니다.');
	  		return;
  		}
		const oSearchPayload = {
			dateStart: dateStart,
			dateEnd: dateEnd,
   			requester: $('#domainsearch_search_requester').val(),
			queryContent: queryContent,
		};
		const domainsearch_csvdownload_url = '/domain/download_excel_all?' + jQuery.param(oSearchPayload);
		const xhr = new XMLHttpRequest();
		xhr.open('POST', domainsearch_csvdownload_url, true);
		xhr.responseType = 'blob';
		const header = "${_csrf.headerName}", token = "${_csrf.token}";
	    xhr.setRequestHeader(header, token);
		xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
		xhr.onload = function(e) {
		    if (this.status === 200) {
		    	$('#domain_excel_download_all').modal('hide');
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
		    	$('#domain_excel_download_all').modal('hide');
		        alert('Excel을 다운로드 할 수 없습니다.');
		    }
		};
		xhr.send(JSON.stringify({
		}));
		$("#domain_excel_cancel").click(function (e) {
			xhr.abort();
		});
});

let domainsearch_jqGrid_url = 'domain/list_approved';

const domainsearch_construct_jqgrid = function () {
	$("#" + domainsearch_jqgrid_table).jqGrid({
		url: domainsearch_jqGrid_url,
		datatype: "json",
		mtype: 'POST',
		loadBeforeSend: function (jqXHR) {
		    const header = "${_csrf.headerName}",
		        token = "${_csrf.token}";
		    jqXHR.setRequestHeader(header, token);
		},
		colNames : [
			'ID',
			'상태 ID',
			'상태',
			'구분 ID',
			'구분 ',
			'검사 ID',
			'검사',
			'도메인타입',
			'*도메인',
			'*유형 ID',
			'*유형',
			'단어조합',
			'영문명',
			'*데이터타입 ID',
			'*데이터타입',
			'*데이터길이',
			'데이터타입(길이)',
			'정의',
			'신청자',
			'신청자 ID',
			'신청일시',
			'단어 №1',
			'단어 №2',
		],
		colModel : [
			{
				name : 'requestId', // 'requestId'
				index : 'requestId',
				hidden : true,
			},
			{
				name : 'requestStatus', // 'Статус ID'
				index : 'requestStatus',
				hidden : true,
			},
			
			{
				name : 'requestStatusText', // 'Статус'
				index : 'requestStatusText',
				width : 50,
				align: "center",
			},
			{
				name : 'registStatus', // 'Ангилал',
				index : 'registStatus',
				hidden : true ,
			},
			
			{
				name : 'registStatusText', // 'Ангилал',
				index : 'registStatusText',
				width : 40,
				editable : false,
				align: "center",
			},
			{
				name : 'isNormal', // 'Шалгасан байдал ID ' 
				index : 'isNormal',
				hidden : true,
			},
			{
				name : 'isNormalText', // 'Шалгасан байдал'
				index : 'isNormalText',
				width : 40,
				editable : false,
				align: "center",
			},
			{
				name : 'domainType', //Domain type
				index : 'domainType',
				width : 172,
				editable : false
			},
			{
				name : 'domain', //Domain
				index : 'domain',
				width : 172,
				editable : false
			},
			{
				name : 'type', //Type ID
				index : 'type',
				hidden : true,
			},
			{
				name : 'typeText', //Type
				index : 'typeText',
				width : 48,
				editable : false,
				align: "center",
			},
			{
				name : 'wordUnionKor', // үгийн зохицол
				index : 'wordUnionKor',
				width : 194,
				editable : false
			},
			{
				name : 'wordUnionEng', // англи нэршил 
				index : 'wordUnionEng',
				width : 194,
				editable : false
			},
			{
				name : 'dataType', // data type ID
				index : 'dataType',
				hidden: true,
			},
			{
				name : 'dataTypeText', // data type
				index : 'dataTypeText',
				width : 70,
				editable : false
			},
			{
				name : 'dataLength', //дата урт
				index : 'dataLength',
				width : 56,
				editable : false,
				align: "right",
			},
			{
				name : 'dataTypeLength', // data type length
				index : 'dataTypeLength',
				width : 129,
				editable : false
			},
			{
				name : 'definition', // тодорхойлолт 
				index : 'definition',
				width : 285,
				editable : false
			},
			{
			       name : 'firstname',
			       index : 'firstname',
			       width : 100,
			       editable : false,
			},
			{
			       name : 'username',
			       index : 'username',
			       hidden: true,
			},
			{
				name : 'createdDate', // хүсэлт гаргасан огноо,
				index : 'createdDate',
				width : 125,
				editable : false,
				align: "center",
			},
			{
				name: 'word1Id',
				index: 'word1Id',
				hidden: true,
			},
			{
				name: 'word2Id',
				index: 'word2Id',
				hidden: true,
			},
		],
		pager: '#' + domainsearch_jqgrid_pager,
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
	$("#" + domainsearch_jqgrid_table).jqGrid('navGrid', '#' + domainsearch_jqgrid_pager, {
	    edit : false,
	    add : false,
	    del : false,
	    search : false,
	});
};
</script>
