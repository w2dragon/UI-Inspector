<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div style="display: flex; flex-direction: column;">
	<div class="content-section-wrapper">
		<div>
			<jsp:include page="../component/searchTerm.jsp">
				<jsp:param name="idPrefix" value="termlist_search_" />
				<jsp:param name="bListScreen" value="true" />
			</jsp:include>
		</div>
	</div>
	<div class="content-section-wrapper content-jqgrid-table">
		<div>
			<div class="grid-main-toolbar-buttons-wrapper"
				style="display: flex; flex-direction: row; justify-content: flex-end;">
				<sec:authorize access="hasRole('USER')">
					<button class="btn btn-default" id='termlist_new_record'>신규</button>
					<button class="btn btn-default" id='termlist_make_request'>신청등록</button>
					<button class="btn btn-default" id='termlist_cancel_request'>신청취소</button>
				</sec:authorize>
				<sec:authorize access="hasRole('ADMIN')">
					<button class="btn btn-default" id="termlist_approve">승인</button>
					<button class="btn btn-default" id="termlist_reject">부결</button>
				</sec:authorize>
			</div>
			<div class="" id="termlist_jqgrid_table_wrapper">
			</div>
		</div>
	</div>
	<div class="content-section-wrapper">
		<div>
			<div id="termlist_form_record_editing" class="content_form_record_editing" style="display: none;">
				<div style="display: flex; flex-direction: row;">
					<div style="flex: 1;">
						<input type='hidden' id='termlist_edit_id' name='termlist_edit_id' />
						<input type='hidden' id='termlist_edit_requestStatus' name='termlist_edit_requestStatus' />
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="termlist_edit_term"
								class="col-sm-2 control-label control-label-custom">*용어</label>
							<div class="col-sm-8">
								<input type='text' id='termlist_edit_term' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="termlist_edit_wordDecompositionKor"
								class="col-sm-2 control-label control-label-custom">단어분해</label>
							<div class="col-sm-8">
								<input type='text' id='termlist_edit_wordDecompositionKor' class="form-control input-sm" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="termlist_edit_wordDecompositionEng"
								class="col-sm-2 control-label control-label-custom">영문명</label>
							<div class="col-sm-8">
								<input type='text' id='termlist_edit_wordDecompositionEng' class="form-control input-sm" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="termlist_edit_domainId"
								class="col-sm-2 control-label control-label-custom">도메인</label>
							<div class="col-sm-8">
								<select name="" id="termlist_edit_domainId" class="form-control"></select>
							</div>
						</div>
					</div>
					<div style="flex: 1;">
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="termlist_edit_type"
								class="col-sm-2 control-label control-label-custom">도메인타입</label>
							<div class="col-sm-8">
								<input type='text' id='termlist_edit_type' class="form-control input-sm" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="termlist_edit_dataTypeLength"
								class="col-sm-2 control-label control-label-custom">데이터 타입(길이)</label>
							<div class="col-sm-8">
								<input type='text' id='termlist_edit_dataTypeLength' class="form-control input-sm" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="termlist_edit_definition"
								class="col-sm-2 control-label control-label-custom">*정의</label>
							<div class="col-sm-8">
								<input type='text' id='termlist_edit_definition' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="termlist_edit_username"
								class="col-sm-2 control-label control-label-custom">신청자</label>
							<div class="col-sm-8">
								<input type='text' id='termlist_edit_username' class="form-control input-sm" readonly="readonly" />
							</div>
						</div>
					</div>
					<div style="flex: 1; display: flex; flex-direction: column;">
						<div style="display: flex; flex-direction: column; justify-content: space-between; align-items: flex-end; width: 100%; height: 100%;">
							<div id='termlist_edit_rejection_reason_wrapper' style='width: 100%; flex: 1;'>
										<div style='display: flex; flex-direction: column; justify-content: space-between; height: 100%; width: 100%;'>
											<div class="form-group form-group-custom" style="margin-bottom: 20px;">
												<label class="col-sm-2"></label>
												<label for="termlist_edit_rejection_reason" class="col-sm-2 control-label control-label-custom">부결 사유</label>
												<div class="col-sm-8">
													<textarea id='termlist_edit_rejection_reason' name='termlist_edit_rejection_reason' class="form-control input-sm" rows="1" style="resize: none;">
													</textarea>
												</div>
											</div>
										</div>
									</div>
							<sec:authorize access="hasRole('USER')">
								<div style="align-items: flex-end; display: flex; flex: 1;">
									<button id='termlist_edit_save' class="btn btn-default search_button" type="button" style="margin-right: 15px;">저장</button>
									<button id='termlist_edit_cancel' class="btn btn-default search_button" type="button" style="margin-left: -12px; margin-right: 15px;">Clear</button>
								</div>
							</sec:authorize>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="termlist_confirm_request" tabindex="-1" role="dialog" aria-labelledby="termlist_confirm_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="termlist_confirm_request_label">선택하신 <span id='termlist_confirm_request_n'></span>건을 신청등록 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="termlist_confirm_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="termlist_rescind_request" tabindex="-1" role="dialog" aria-labelledby="termlist_rescind_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="termlist_rescind_request_label">선택하신 <span id='termlist_rescind_request_n'></span>건을 신청취소 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="termlist_rescind_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="termlist_approve_request" tabindex="-1" role="dialog" aria-labelledby="termlist_approve_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="termlist_approve_request_label">선택하신 <span id='termlist_approve_request_n'></span>건을 승인 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="termlist_approve_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="termlist_reject_request" tabindex="-1" role="dialog" aria-labelledby="termlist_reject_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="termlist_reject_request_label">선택하신 <span id='termlist_reject_request_n'></span>건을 부결 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="termlist_reject_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

const termlist_jqgrid_table = 'termlist_jqgrid_table';
const termlist_jqgrid_pager = 'termlist_jqgrid_pager';

let termlist_bNewRecord = false;

const termlist_onCloseTab = function () {
	termlist_bNewRecord = false;
	$('#termlist_form_record_editing').hide();
	$("#termlist_search_button_reset").click();
	termlist_jqGrid_url = 'term/list';
};

const termlist_toggleEnableFormData = function (bVal) {
	if (bVal === true) {
		$('#termlist_edit_save').show();
	} else {
		$('#termlist_edit_save').hide();
	}
	$('#termlist_edit_term').attr('readonly', !bVal);
	$('#termlist_edit_wordDecompositionKor').attr('readonly', true);
	$('#termlist_edit_wordDecompositionEng').attr('readonly', true);
	$('#termlist_edit_domainId').attr('disabled', !bVal);
	$('#termlist_edit_type').attr('readonly', true);
	$('#termlist_edit_dataTypeLength').attr('readonly', true);
	$('#termlist_edit_definition').attr('readonly', !bVal);
};
		
const termlist_setEditingFormData = function(data) {
	termlist_toggleEnableFormData(data.bEditable);
	$('#termlist_edit_id').val(data.id);
	$('#termlist_edit_term').val(data.term);
	$('#termlist_edit_wordDecompositionKor').val(data.wordDecompositionKor);
	$('#termlist_edit_wordDecompositionEng').val(data.wordDecompositionEng);
	$('#termlist_edit_domainId').val(data.domainId);
	$('#termlist_edit_type').val(data.type);
	$('#termlist_edit_dataTypeLength').val(data.dataTypeLength);
	$('#termlist_edit_definition').val(data.definition);
	$('#termlist_edit_username').val(data.firstname);
	$('#termlist_edit_requestStatus').val(data.requestStatus);
	if (data.requestStatus === '4') { // 4 - REJECTED
		$('#termlist_edit_rejection_reason').val(data.rejectionReason);
		$('#termlist_edit_rejection_reason').attr('readonly', true);
		$('#termlist_edit_rejection_reason_wrapper').show();
	} else {
		$('#termlist_edit_rejection_reason_wrapper').hide();
	}

	const aWord = data.wordDecompositionKor.split('_');
	if (aWord.length > 0) {
		const sLastWord = aWord[aWord.length - 1];
		getDomainList(sLastWord, data.domainId);
	} else {
		// clear domain fields
		$('#termlist_edit_domainId').val('');
		$('#termlist_edit_domainId').html('');
		$('#termlist_edit_type').val('');
		$('#termlist_edit_dataTypeLength').val('');
	}
	termlist_aFoundWord = [];
};

<sec:authorize access="hasRole('USER')">
$('#termlist_new_record').click(function() {
	$(this).blur();
	$("#" + termlist_jqgrid_table).jqGrid("resetSelection");
	if (termlist_bNewRecord === false) {
		var rejectionReason = $("#" + termlist_jqgrid_table).jqGrid('getColProp','rejectionReason');
		rejectionReason.editable = false;
		$("#" + termlist_jqgrid_table).jqGrid('addRow', {
			rowID : '-1',
			initdata : {},
			position : "first",
			useDefValues : false,
			useFormatter : false,
			addRowParams : {
				extraparam : {}
			}
		});
		termlist_bNewRecord = true;
	} else {
		// select previous existing new record which has ID equals -1
		$("#" + termlist_jqgrid_table).jqGrid("setSelection", -1);
	}
});

$('#termlist_make_request').click(function () {
	$(this).blur();
	const myGrid = $('#' + termlist_jqgrid_table);
	const selectedRowId = myGrid.jqGrid('getGridParam', 'selarrrow');
	const aSelectedRequestId = [];
	const aSelectedRequestStatus = [];
	const aSelectedIsNormal = [];
	selectedRowId.forEach(function (item) {
		const cellValue = myGrid.jqGrid("getCell", item, "requestId");
		aSelectedRequestId.push(parseInt(cellValue, 10));
		const cellValue2 = myGrid.jqGrid("getCell", item, "requestStatus");
		aSelectedRequestStatus.push(cellValue2);
		const cellValue3 = myGrid.jqGrid("getCell", item, "isNormal");
		aSelectedIsNormal.push(cellValue3);
	});
	const iAppropriateRecordCount = aSelectedRequestStatus.filter(function (item) {
		return ['1', '4'].includes(item); // 1 - draft, 4 - rejected
	}).length;
	const iAppropriateRecordCount2 = aSelectedIsNormal.filter(function (item) {
		return item === '1'; // 1 - normal
	}).length;
	if (selectedRowId.length === 0){
		alert('선택하신 용어가 없습니다.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 용어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount2) {
		alert('선택 용어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length === 0) {
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#termlist_confirm_request_n').html(aSelectedRequestId.length.toString());
		$('#termlist_confirm_request').modal('show');
		$("#termlist_confirm_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/term/make_request',
				contentType: "application/json; charset=utf-8",
				beforeSend: function (xhr) {
					const header = "${_csrf.headerName}", token = "${_csrf.token}";
					xhr.setRequestHeader(header, token);
				},
				data: JSON.stringify({
					aSelectedRequestId: aSelectedRequestId,
				}),
				statusCode: {
			        403: function (responseObject, textStatus, jqXHR) {
			        	window.location.reload();
			        },           
			    },
				success: function () {
					$('#' + termlist_jqgrid_table).trigger('reloadGrid');
					$('#termlist_form_record_editing').hide();
				},
			});
			$("#termlist_confirm_request_yes").off();
		});
	}
});

$('#termlist_cancel_request').click(function () {
	$(this).blur();
	const myGrid = $('#' + termlist_jqgrid_table);
	const selectedRowId = myGrid.jqGrid('getGridParam','selarrrow');
	const aSelectedRequestId = [];
	const aSelectedRequestStatus = [];
	selectedRowId.forEach(function (item) {
		const cellValue = myGrid.jqGrid("getCell", item, "requestId");
		aSelectedRequestId.push(parseInt(cellValue, 10));
		const cellValue2 = myGrid.jqGrid("getCell", item, "requestStatus");
		aSelectedRequestStatus.push(cellValue2);
	});
	const iAppropriateRecordCount = aSelectedRequestStatus.filter(function (item) {
		return ['1', '2', '4'].includes(item); // 1 - draft, 2 - waiting decision, 4 - rejected
	}).length;
	if (selectedRowId.length === 0){
		alert('선택하신 용어가 없습니다.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 용어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#termlist_rescind_request_n').html(aSelectedRequestId.length.toString());
		$('#termlist_rescind_request').modal('show');
		$("#termlist_rescind_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/term/cancel_request',
				contentType: "application/json; charset=utf-8",
				beforeSend: function (xhr) {
					const header = "${_csrf.headerName}", token = "${_csrf.token}";
					xhr.setRequestHeader(header, token);
				},
				data: JSON.stringify({
					aSelectedRequestId: aSelectedRequestId,
				}),
				statusCode: {
			        403: function (responseObject, textStatus, jqXHR) {
			        	window.location.reload();
			        },           
			    },
				success: function () {
					$('#' + termlist_jqgrid_table).trigger('reloadGrid');
					$('#termlist_form_record_editing').hide();
				},
			});
			$("#termlist_rescind_request_yes").off();
		});
	}
});
</sec:authorize>

<sec:authorize access="hasRole('ADMIN')">
$('#termlist_approve').click(function() {
	const myGrid = $('#' + termlist_jqgrid_table);
	const selectedRowId = myGrid.jqGrid('getGridParam','selarrrow');
	const aSelectedRequestId = [];
	const aSelectedRequestStatus = [];
	selectedRowId.forEach(function (item) {
		const cellValue = myGrid.jqGrid("getCell", item, "requestId");
		aSelectedRequestId.push(parseInt(cellValue, 10));
		const cellValue2 = myGrid.jqGrid("getCell", item, "requestStatus");
		aSelectedRequestStatus.push(cellValue2);
	});
	if (selectedRowId.length === 0){
		alert('선택하신 용어가 없습니다.');
		return;
	}
	const iAppropriateRecordCount = aSelectedRequestStatus.filter(function (item) {
		return ['2'].includes(item); // 2 - waiting decision
	}).length;
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 용어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#termlist_approve_request_n').html(aSelectedRequestId.length.toString());
		$('#termlist_approve_request').modal('show');
		$("#termlist_approve_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/term/approve_request',
				contentType: "application/json; charset=utf-8",
				beforeSend: function (xhr) {
					const header = "${_csrf.headerName}",
					token = "${_csrf.token}";
					xhr.setRequestHeader(header, token);
				},
				data: JSON.stringify({
					aSelectedRequestId: aSelectedRequestId,
				}),
				statusCode: {
			        403: function (responseObject, textStatus, jqXHR) {
			        	window.location.reload();
			        },           
			    },
				success: function () {
					$('#' + termlist_jqgrid_table).trigger('reloadGrid');
					$('#termlist_form_record_editing').hide();
				},
			});
			$("#termlist_approve_request_yes").off();
		});
	}
});

$('#termlist_reject').click(function() {
	$(this).blur();
	const myGrid = $('#' + termlist_jqgrid_table);
	const selectedRowId = myGrid.jqGrid('getGridParam','selarrrow');
	const aSelectedRequestId = [];
	const aSelectedRequestStatus = [];
	selectedRowId.forEach(function (item) {
		const cellValue = myGrid.jqGrid("getCell", item, "requestId");
		aSelectedRequestId.push(parseInt(cellValue, 10));
		const cellValue2 = myGrid.jqGrid("getCell", item, "requestStatus");
		aSelectedRequestStatus.push(cellValue2);
	});
	if (selectedRowId.length === 0){
		alert('선택하신 용어가 없습니다.');
		return;
	}
	const iAppropriateRecordCount = aSelectedRequestStatus.filter(function (item) {
		return ['2'].includes(item); // 2 - waiting decision
	}).length;
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 용어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#termlist_reject_request_n').html(aSelectedRequestId.length.toString());
		$('#termlist_reject_request').modal('show');
		$("#termlist_reject_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/term/reject_request',
				contentType: "application/json; charset=utf-8",
				beforeSend: function (xhr) {
					const header = "${_csrf.headerName}",
					token = "${_csrf.token}";
					xhr.setRequestHeader(header, token);
				},
				data: JSON.stringify({
					aSelectedRequestId: aSelectedRequestId,
				}),
				statusCode: {
			        403: function (responseObject, textStatus, jqXHR) {
			        	window.location.reload();
			        },           
			    },
				success: function () {
					$('#' + termlist_jqgrid_table).trigger('reloadGrid');
					$('#termlist_form_record_editing').hide();
				},
			});
			$("#termlist_reject_request_yes").off();
		});
	}
});

$('#termlist_edit_save_rejection_reason').click(function () {
	$(this).blur();
	const sReason = $('#termlist_edit_rejection_reason').val().trim();
	$.ajax({
		type: "POST",
		url: '/term/updateRejectionReason',
		beforeSend: function (xhr) {
            const header = "${_csrf.headerName}",
			token = "${_csrf.token}";
			xhr.setRequestHeader(header, token);
        },
		data: {
			requestId: $('#termlist_edit_id').val(),
			rejectionReason: sReason,
		},
		statusCode: {
	        403: function (responseObject, textStatus, jqXHR) {
	        	window.location.reload();
	        },           
	    },
		success: function (data) {
			$('#' + termlist_jqgrid_table).trigger('reloadGrid');
			// Clearing the form for editing record
			termlist_setEditingFormData({
				bEditable: false,
				id: '',
				term: '',
				wordDecompositionKor: '',
				wordDecompositionEng: '',
				domainId: '',
				type: '',
				dataTypeLength: '',
				definition: '',
				username: '',
				firstname: '',
				requestStatus: '1',
				rejectionReason: '',
			});
			$('#termlist_form_record_editing').hide();
		},
	});
});
</sec:authorize>

let termlist_aDomainlist = [];

function getDomainList(sWord, domainId) {
	termlist_aDomainlist = [];
	$("#termlist_edit_domainId").html('');
	if (sWord.trim().length === 0) {
		return;
	}
    $.ajax({
        type: "POST",
        url: "/term/findDomain",
        beforeSend: function (xhr) {
            const header = "${_csrf.headerName}", token = "${_csrf.token}";
            xhr.setRequestHeader(header, token);
        },
        data: JSON.stringify({
        	sWord: sWord,
		}),
        contentType: "application/json; charset=utf-8",
		statusCode: {
	        403: function (responseObject, textStatus, jqXHR) {
	        	window.location.reload();
	        },           
	    },
        success: function (data) {
        	termlist_aDomainlist = data;
            for (let i = 0; i < termlist_aDomainlist.length; i += 1) {
                $("#termlist_edit_domainId").append('<option value="' + termlist_aDomainlist[i].requestId+'">' + termlist_aDomainlist[i].domain + '</option>');
            }
            if (domainId === -1) {
            	if (termlist_aDomainlist.length === 1) {
                    $('#termlist_edit_domainId').val(termlist_aDomainlist[0].requestId);
                    $('#termlist_edit_type').val(termlist_aDomainlist[0].domain + '_' + termlist_aDomainlist[0].dataTypeText.substr(0, 1) + termlist_aDomainlist[0].dataLength);
    				$('#termlist_edit_dataTypeLength').val(termlist_aDomainlist[0].dataTypeText + "(" + termlist_aDomainlist[0].dataLength + ")");
                } else {
                	$('#termlist_edit_domainId').val('');
                	$('#termlist_edit_type').val('');
    				$('#termlist_edit_dataTypeLength').val('');
                }
            } else {
            	$('#termlist_edit_domainId').val(domainId.toString());
            	termlist_aDomainlist.forEach(function (item) {
	    			if (domainId.toString() === item.requestId.toString()) {
	    				$('#termlist_edit_type').val(item.domain + '_' + item.dataTypeText.substr(0, 1) + item.dataLength);
	    				$('#termlist_edit_dataTypeLength').val(item.dataTypeText + "(" + item.dataLength + ")");
	    			}
	    		});
            }
        }
    });
}

$('#termlist_edit_domainId').on('change', function() {
	const a = this.value;
	termlist_aDomainlist.forEach(function (item) {
		if (a === item.requestId.toString()) {
			$('#termlist_edit_type').val(item.domain + '_' + item.dataTypeText.substr(0, 1) + item.dataLength);
			$('#termlist_edit_dataTypeLength').val(item.dataTypeText + "(" + item.dataLength + ")");
		}
	});
});

let termlist_sLastValue = '';

$('#termlist_edit_term').keyup(function () {
	if (termlist_sLastValue !== $(this).val()) {
		termlist_sLastValue = $(this).val();
		termlist_search_word($(this).val());
	}
});
$('#termlist_edit_term').change(function () {
	if (termlist_sLastValue !== $(this).val()) {
		termlist_sLastValue = $(this).val();
		termlist_search_word($(this).val());
	}
});

let termlist_oAjaxRequest = -1;

let termlist_aFoundWord = [];

const termlist_render_found_words = function () {
	let sResult = '';
	let sResult2 = '';
	termlist_aFoundWord.forEach(function (item) {
		if (sResult.length > 0) {
			sResult += '_';
		}
		if (sResult2.length > 0) {
			sResult2 += '_';
		}
		sResult += item.standardWord;
		sResult2 += item.standardWordEng;
	});
	$('#termlist_edit_wordDecompositionKor').val(sResult);
	$('#termlist_edit_wordDecompositionEng').val(sResult2);
};

const termlist_search_word = function (sQuery) {
	//
	if (sQuery.trim().length > 0) {
		termlist_oAjaxRequest = $.ajax({
			type: "POST",
			url: 'term/search_word',
			contentType: "application/json; charset=utf-8",
			beforeSend: function (xhr) {
				if (termlist_oAjaxRequest !== -1 && termlist_oAjaxRequest.readyState < 4) {
					termlist_oAjaxRequest.abort();
                }
	            const header = "${_csrf.headerName}", token = "${_csrf.token}";
                xhr.setRequestHeader(header, token);
	        },
			data: JSON.stringify({
				sQuery: sQuery,
			}),
			statusCode: {
		        403: function (responseObject, textStatus, jqXHR) {
		        	window.location.reload();
		        },           
		    },
			success: function (data) {
				termlist_aFoundWord = [];
				data.forEach(function (item, index) {
					termlist_aFoundWord.push(item);
					/* if (index < 4) {
						termlist_aFoundWord.push(item);
					} */
					/* if (index === 3) {
						getDomainList(item.standardWord);
					} */
				});
				if (data.length > 0) {
					const oLastWord = data[data.length - 1];
					getDomainList(oLastWord.standardWord, -1);
				}
				termlist_render_found_words();
				/* let a = "";
				data.forEach(function (item) {
					a += item.standardWord;
				});
				if (a !== sQuery) {
					alert("Ангилах үгийг ахин шалгана уу."); // 4-10 alert
				} */
			},
		});
	} else {
		termlist_aFoundWord = [];
		termlist_render_found_words();
	}
};

$('#termlist_edit_save').click(function() {
	$(this).blur();
	const aWordAppropriate = $('#termlist_edit_wordDecompositionKor').val().split("_");
	if (aWordAppropriate.length === 0) {
		alert('등록된 단어가 없습니다. 확인하십시오.'); // 4-9 alert
		return;
	}
	/* if (aWordAppropriate.length < 3) {
		alert('용어가 정상적으로 등록되지 않았습니다.');
	} */
	const sUnion = aWordAppropriate.join('');
	
	if ($('#termlist_edit_term').val() !== sUnion) {
		alert('등록된 단어가 없습니다. 확인하십시오.'); // 4-9 alert
		return;
	}
	if (termlist_aFoundWord.length > 0) {
		const oLastWord = termlist_aFoundWord[termlist_aFoundWord.length - 1];
		if (oLastWord.isClassified !== '1') {
			alert('분류어 단어를 확인하십시오.'); // 4-10 alert
			return;
		}
	}
	
	termlist_bNewRecord = false;
	$.ajax({
		type: "POST",
		url: '/term/post',
		beforeSend: function (xhr) {
			const header = "${_csrf.headerName}", token = "${_csrf.token}";
			xhr.setRequestHeader(header, token);
		},
		data: {
			requestId: $('#termlist_edit_id').val(),
			term: $('#termlist_edit_term').val(),
			wordDecompositionKor: $('#termlist_edit_wordDecompositionKor').val(),
			wordDecompositionEng: $('#termlist_edit_wordDecompositionEng').val(),
			domainId: ($('#termlist_edit_domainId').val() !== null && $('#termlist_edit_domainId').val().length > 0) ? $('#termlist_edit_domainId').val() : -1,
			type: $('#termlist_edit_type').val(),
			dataTypeLength: $('#termlist_edit_dataTypeLength').val(),
			definition: $('#termlist_edit_definition').val(),
			requestStatus: $('#termlist_edit_requestStatus').val()
		},
		statusCode: {
	        403: function (responseObject, textStatus, jqXHR) {
	        	window.location.reload();
	        },           
	    },
		success: function (data) {
			if (data.result === 3) {
				alert('이미 등록된 용어입니다. 확인하십시오.');
				return;
			}
			if (data.entity !== undefined) {
				if (data.entity.isNormal === '2') {
					alert('필수 입력값이 정상적으로 등록되지 않았습니다.');
				}
			}
			$('#' + termlist_jqgrid_table).trigger('reloadGrid');
			termlist_setEditingFormData({
				bEditable: false,
				id: '',
				term: '',
				wordDecompositionKor: '',
				wordDecompositionEng: '',
				domainId: '',
				type: '',
				dataTypeLength: '',
				definition: '',
				username: '',
				firstname: '',
				requestStatus: '1',
				rejectionReason: '',
			});
			$('#termlist_form_record_editing').hide();
		},
	});
});

$('#termlist_edit_cancel').click(function () {
	$(this).blur();
	$("#" + termlist_jqgrid_table).jqGrid('delRowData', -1);
	termlist_setEditingFormData({
		bEditable: false,
		id: '',
		term: '',
		wordDecompositionKor: '',
		wordDecompositionEng: '',
		domainId: '',
		type: '',
		dataTypeLength: '',
		definition: '',
		username: '',
		firstname: '',
		requestStatus: '1',
		rejectionReason: '',
	});
	$("#" + termlist_jqgrid_table).jqGrid("resetSelection");
	$('#termlist_form_record_editing').hide();
	termlist_bNewRecord = false;
});

let termlist_jqGrid_url = 'term/list';

const termlist_construct_jqgrid = function() {
	const termGrid = $("#" + termlist_jqgrid_table).jqGrid({
		url: termlist_jqGrid_url,
		datatype: "json",
		mtype: 'POST',
		loadBeforeSend: function(jqXHR) {
			const header = "${_csrf.headerName}", token = "${_csrf.token}";
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
			'부결 사유',
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
				width : 155,
				editable : false
			},
			{
				name : 'wordDecompositionKor', // 'үгийн задрал'
				index : 'wordDecompositionKor',
				width : 155,
				editable : false
			},
			{
				name : 'wordDecompositionEng', // 'Англи нэршил'
				index : 'wordDecompositionEng',
				width : 155,
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
				width : 136,
				editable : false
			},
			{
				name : 'domainTypeText', // 'Domainтөрөл'
				index : 'domainTypeText',
				width : 155,
				editable : false
			},
			{
				name : 'domainDataTypeLength', // 'дата төрөл(урт)'
				index : 'domainDataTypeLength',
				width : 107,
				editable : false
			},
			{
				name : 'definition', // '*Тодорхойлолт'
				index : 'definition',
				width : 242,
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
			{
		        name : 'rejectionReason',
		        index : 'rejectionReason',
		        width : 190,
		        editable : true,
		        editoptions:{size:"20",maxlength:"50"}
			},
		],
		pager : '#' + termlist_jqgrid_pager,
		rowNum : 50,
		height : 'auto',
		rowList : [ 10, 50, 100 ],
		sortname : 'requestId',
		sortorder : 'desc',
		viewrecords : true,
		gridview : true,
		multiselect : true,
		multiboxonly : true,
		autowidth : true,
		// caption : 'Super Heroes',
		editurl: '/term/updateRejectionReason',
		jsonReader : {
			repeatitems : false,
		},
		ondblClickRow: function(id, ri, ci) {
           	<sec:authorize access="hasRole('ADMIN')">
           	const row = $(this).getRowData(id);
           	if(['2', '4'].includes(row.requestStatus)){
           	 var editparameters = {
	                  extraparam: { requestId: row.requestId },
	                  keys: true,
	                  successfunc: function(e){
	                	  const newValue = e.responseJSON.entity.rejectionReason;
	                	  $('#termlist_edit_rejection_reason').val(newValue);
	                	  return true;
	                  }
	            };
	            termGrid.jqGrid('editRow',id,editparameters);
           	}
			</sec:authorize>
        },
		onSelectRow : function(ids, status) {
			// console.log(ids);
			termGrid.restoreRow(ids);
			if (status === true) {
				if (ids === '-1') {
					//console.log('Editing new record...');
					termlist_setEditingFormData({
						bEditable: true,
						id : ids,
						term: '',
						wordDecompositionKor : '',
						wordDecompositionEng : '',
						domainId : '',
						type : '',
						dataTypeLength : '',
						definition : '',
						firstname: '${currentUser.firstname} (${currentUser.username})',
						requestStatus: '1',
						rejectionReason: '',
					});
					$('#termlist_form_record_editing').show();
					$('#termlist_edit_cancel').show();
				} else {
					const row = $(this).getRowData(ids);
					termlist_setEditingFormData({
						bEditable: <sec:authorize access="hasRole('USER')">['1', '4'].includes(row.requestStatus)</sec:authorize><sec:authorize access="hasRole('ADMIN')">false</sec:authorize>,
						id: row.requestId,
						term: row.term,
						wordDecompositionKor: row.wordDecompositionKor,
						wordDecompositionEng: row.wordDecompositionEng,
						domainId: row.domainId,
						type: row.type,
						dataTypeLength: row.dataTypeLength,
						definition: row.definition,
						firstname: row.firstname,
						requestStatus: row.requestStatus,
						rejectionReason: row.rejectionReason,
					});
					$('#termlist_form_record_editing').show();
					$('#termlist_edit_cancel').hide();
				}
			} else {
				$('#termlist_form_record_editing').hide();
			}
		},
		loadError: function (jqXHR, textStatus, errorThrown) {
			if (jqXHR.status === 403) {
				window.location.reload();
			}
	    },
	    loadComplete: function () {
	    	termlist_bNewRecord = false;
	    	$('#termlist_form_record_editing').hide();
		},
	});
	$("#" + termlist_jqgrid_table).jqGrid('navGrid', '#' + termlist_jqgrid_pager, {
		edit : false,
		add : false,
		del : false,
		search : false,
	});
};
</script>
