<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div style="display: flex; flex-direction: column;">
	<div class="content-section-wrapper">
		<div>
			<jsp:include page="../component/searchWord.jsp">
				<jsp:param name="idPrefix" value="wordlist_search_" />
				<jsp:param name="bListScreen" value="true" />
			</jsp:include>
		</div>
	</div>
	<div class="content-section-wrapper content-jqgrid-table">
		<div>
			<div class="grid-main-toolbar-buttons-wrapper" style="display: flex; flex-direction: row; justify-content: flex-end;">
				<sec:authorize access="hasRole('USER')">
					<button class="btn btn-default" id='wordlist_new_record'>신규</button>
					<button class="btn btn-default" id='wordlist_make_request'>신청등록</button>
					<button class="btn btn-default" id='wordlist_cancel_request'>신청취소</button>
				</sec:authorize>
				<sec:authorize access="hasRole('ADMIN')">
					<button class="btn btn-default" id='wordlist_approve'>승인</button>
					<button class="btn btn-default" id='wordlist_reject'>부결</button>
				</sec:authorize>
			</div>
			<div class="" id="wordlist_jqgrid_table_wrapper">
			</div>
		</div>
	</div>
	<div class="content-section-wrapper">
		<div>
			<div id="wordlist_form_record_editing" class="content_form_record_editing" style="display: none;">
				<div style="display: flex; flex-direction: row;">
					<div style="flex: 1;">
						<input type='hidden' id='wordlist_edit_id' name='edit_id' />
						<input type='hidden' id='wordlist_edit_requestStatus' name='edit_requestStatus' />
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="wordlist_edit_standardWord" class="col-sm-2 control-label control-label-custom">*표준단어</label>
							<div class="col-sm-8">
								<input type='text' id='wordlist_edit_standardWord' name='edit_standardWord' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="wordlist_edit_abbrevationEng" class="col-sm-2 control-label control-label-custom">*영문약어</label>
							<div class="col-sm-8">
								<input type='text' id='wordlist_edit_abbrevationEng' name='edit_abbrevationEng' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="wordlist_edit_standardWordEng" class="col-sm-2 control-label control-label-custom">*영문명</label>
							<div class="col-sm-8">
								<input type='text' id='wordlist_edit_standardWordEng' name='edit_standardWordEng' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="wordlist_edit_synonyms" class="col-sm-2 control-label control-label-custom">유사어</label>
							<div class="col-sm-8">
								<input type='text' id='wordlist_edit_synonyms' name='edit_synonyms' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
					</div>
					<div style="flex: 1;">
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="wordlist_edit_isClassified" class="col-sm-2 control-label control-label-custom">분류어 여부</label>
							<div class="col-sm-8">
								<select id='wordlist_edit_isClassified' class="form-control input-sm">
									<c:forEach items="${aCommonDictList6}" var="oDict">
										<option value='${oDict.grpCode}'>${oDict.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="wordlist_edit_source" class="col-sm-2 control-label control-label-custom">출처</label>
							<div class="col-sm-8">
								<input type='text' id='wordlist_edit_source' name='edit_source' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="wordlist_edit_definition" class="col-sm-2 control-label control-label-custom">*정의</label>
							<div class="col-sm-8">
								<input type='text' id='wordlist_edit_definition' name='edit_definition' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="wordlist_edit_username" class="col-sm-2 control-label control-label-custom">신청자</label>
							<div class="col-sm-8">
								<input type='text' id='wordlist_edit_username' name='edit_username' class="form-control input-sm" readonly="readonly"/>
							</div>
						</div>
					</div>
					<div style="flex: 1; display: flex; flex-direction: column;">
						<div style="display: flex; flex-direction: column; justify-content: space-between; align-items: flex-end; width: 100%; height: 100%;">
							<div id='wordlist_edit_rejection_reason_wrapper' style='width: 100%; flex: 1;'>
								<div style='display: flex; flex-direction: column; justify-content: space-between; height: 100%; width: 100%;'>
									<div class="form-group form-group-custom" style="margin-bottom: 20px;">
										<label class="col-sm-2"></label>
										<label for="wordlist_edit_rejection_reason" class="col-sm-2 control-label control-label-custom">부결 사유</label>
										<div class="col-sm-8">
											<textarea id='wordlist_edit_rejection_reason' name='wordlist_edit_rejection_reason' class="form-control input-sm" rows="1" style="resize: none;">
											</textarea>
										</div>
									</div>
								</div>
							</div>
							<sec:authorize access="hasRole('USER')">
								<div style="align-items: flex-end; display: flex; flex: 1;">
									<button id='wordlist_edit_save' class="btn btn-default search_button" type="button" style="margin-right: 15px;">저장</button>
									<button id='wordlist_edit_cancel' class="btn btn-default search_button" type="button" style="margin-left: -12px; margin-right: 15px;">Clear</button>
								</div>
							</sec:authorize>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="wordlist_confirm_request" tabindex="-1" role="dialog" aria-labelledby="wordlist_confirm_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="wordlist_confirm_request_label">선택하신  <span id='wordlist_confirm_request_n'></span>건을 신청등록 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="wordlist_confirm_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="wordlist_rescind_request" tabindex="-1" role="dialog" aria-labelledby="wordlist_rescind_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="wordlist_rescind_request_label">선택하신  <span id='wordlist_rescind_request_n'></span>건을 신청취소 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="wordlist_rescind_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="wordlist_approve_request" tabindex="-1" role="dialog" aria-labelledby="wordlist_approve_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="wordlist_approve_request_label">선택하신 <span id='wordlist_approve_request_n'></span>건을 승인 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="wordlist_approve_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="wordlist_reject_request" tabindex="-1" role="dialog" aria-labelledby="wordlist_reject_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="wordlist_reject_request_label">선택하신  <span id='wordlist_reject_request_n'></span>건을 부결 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="wordlist_reject_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">

const wordlist_jqgrid_table = 'wordlist_jqgrid_table';
const wordlist_jqgrid_pager = 'wordlist_jqgrid_pager';

let wordlist_bNewRecord = false;

const wordlist_onCloseTab = function () {
	wordlist_bNewRecord = false;
	$('#wordlist_form_record_editing').hide();
	$("#wordlist_search_button_reset").click();
	wordlist_jqGrid_url = 'word/list';
};

const wordlist_toggleEnableFormData = function (bVal) {
	if (bVal === true) {
		$('#wordlist_edit_save').show();
	} else {
		$('#wordlist_edit_save').hide();
	}
	$('#wordlist_edit_standardWord').attr('readonly', !bVal);
	$('#wordlist_edit_standardWordEng').attr('readonly', !bVal);
	$('#wordlist_edit_abbrevationEng').attr('readonly', !bVal);
	$('#wordlist_edit_synonyms').attr('readonly', !bVal);
	$('#wordlist_edit_isClassified').attr('disabled', !bVal);
	$('#wordlist_edit_source').attr('readonly', !bVal);
	$('#wordlist_edit_definition').attr('readonly', !bVal);
};

const wordlist_setEditingFormData = function (data) {
	wordlist_toggleEnableFormData(data.bEditable);
	$('#wordlist_edit_id').val(data.id);
	$('#wordlist_edit_standardWord').val(data.standardWord);
	$('#wordlist_edit_standardWordEng').val(data.standardWordEng);
	$('#wordlist_edit_abbrevationEng').val(data.abbrevationEng);
	$('#wordlist_edit_synonyms').val(data.synonyms);
	$('#wordlist_edit_isClassified').val(data.isClassified);
	$('#wordlist_edit_source').val(data.source);
	$('#wordlist_edit_definition').val(data.definition);
	$('#wordlist_edit_username').val(data.firstname);
	$('#wordlist_edit_requestStatus').val(data.requestStatus);
	if (data.requestStatus === '4') { // 4 - REJECTED
		$('#wordlist_edit_rejection_reason').val(data.rejectionReason);
		$('#wordlist_edit_rejection_reason').attr('readonly', true);
		$('#wordlist_edit_rejection_reason_wrapper').show();
	} else {
		$('#wordlist_edit_rejection_reason_wrapper').hide();
	}
};


<sec:authorize access="hasRole('USER')">
$('#wordlist_new_record').click(function () {
	$(this).blur();
	$("#" + wordlist_jqgrid_table).jqGrid("resetSelection");
	if (wordlist_bNewRecord === false) {
		var rejectionReason = $("#" + wordlist_jqgrid_table).jqGrid('getColProp','rejectionReason');
		rejectionReason.editable = false;
		$("#" + wordlist_jqgrid_table).jqGrid('addRow', {
		    rowID : '-1',
		    initdata : {},
		    position : "first",
		    useDefValues : false,
		    useFormatter : false,
		    addRowParams : {extraparam:{}}
		});
		wordlist_bNewRecord = true;
	} else {
		// select previous existing new record which has ID equals -1
		$("#" + wordlist_jqgrid_table).jqGrid("setSelection", -1);
	}
});

$('#wordlist_make_request').click(function () {
	$(this).blur();
	const myGrid = $('#' + wordlist_jqgrid_table);
	const selectedRowId = myGrid.jqGrid('getGridParam','selarrrow');
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
		alert('선택하신 단어가 없습니다.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 단어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount2) {
		alert('선택 단어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#wordlist_confirm_request_n').html(aSelectedRequestId.length.toString());
		$('#wordlist_confirm_request').modal('show');
		$("#wordlist_confirm_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/word/make_request',
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
					$('#' + wordlist_jqgrid_table).trigger('reloadGrid');
					$('#wordlist_form_record_editing').hide();
				},
			});
			$("#wordlist_confirm_request_yes").off();
		});
	}
});

$('#wordlist_cancel_request').click(function () {
	$(this).blur();
	const myGrid = $('#' + wordlist_jqgrid_table);
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
		alert('선택하신 단어가 없습니다.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 단어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#wordlist_rescind_request_n').html(aSelectedRequestId.length.toString());
		$('#wordlist_rescind_request').modal('show');
		$("#wordlist_rescind_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/word/cancel_request',
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
					$('#' + wordlist_jqgrid_table).trigger('reloadGrid');
					$('#wordlist_form_record_editing').hide();
				},
			});
			$("#wordlist_rescind_request_yes").off();
		});
	}
});
</sec:authorize>
<sec:authorize access="hasRole('ADMIN')">
$('#wordlist_approve').click(function () {
	$(this).blur();
	const myGrid = $('#' + wordlist_jqgrid_table);
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
		return ['2'].includes(item); // 2 - waiting decision
	}).length;
	if (selectedRowId.length === 0){
		alert('선택하신 단어가 없습니다.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 단어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#wordlist_approve_request_n').html(aSelectedRequestId.length.toString());
		$('#wordlist_approve_request').modal('show');
		$("#wordlist_approve_request_yes").click(function (e) {
		$.ajax({
			type: "POST",
			url: '/word/approve_request',
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
				$('#' + wordlist_jqgrid_table).trigger('reloadGrid');
				$('#wordlist_form_record_editing').hide();
			},
			});
			$("#wordlist_approve_request_yes").off();
		});
	}
});
$('#wordlist_reject').click(function () {
	$(this).blur();
	const myGrid = $('#' + wordlist_jqgrid_table);
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
		alert('선택하신 단어가 없습니다.');
		return;
	}
	const iAppropriateRecordCount = aSelectedRequestStatus.filter(function (item) {
		return ['2'].includes(item); // 2 - waiting decision
	}).length;
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 단어의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#wordlist_reject_request_n').html(aSelectedRequestId.length.toString());
		$('#wordlist_reject_request').modal('show');
		$("#wordlist_reject_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/word/reject_request',
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
					$('#' + wordlist_jqgrid_table).trigger('reloadGrid');
					$('#wordlist_form_record_editing').hide();
				},
			});
			$("#wordlist_reject_request_yes").off();
		});
	}
});


$('#wordlist_edit_save_rejection_reason').click(function () {
	$(this).blur();
	const sReason = $('#wordlist_edit_rejection_reason').val().trim();
	$.ajax({
		type: "POST",
		url: '/word/updateRejectionReason',
		beforeSend: function (xhr) {
            const header = "${_csrf.headerName}",
			token = "${_csrf.token}";
			xhr.setRequestHeader(header, token);
        },
		data: {
			requestId: $('#wordlist_edit_id').val(),
			rejectionReason: sReason,
		},
		statusCode: {
	        403: function (responseObject, textStatus, jqXHR) {
	        	window.location.reload();
	        },           
	    },
		success: function (data) {
			$('#' + wordlist_jqgrid_table).trigger('reloadGrid');
			// Clearing the form for editing record
			wordlist_setEditingFormData({
				bEditable: false,
				id: '',
				standardWord: '',
				standardWordEng: '',
				abbrevationEng: '',
				synonyms: '',
				isClassified: '',
				source: '',
				definition: '',
				username: '',
				firstname: '',
				requestStatus: '1',
				rejectionReason: '',
			});
			$('#wordlist_form_record_editing').hide();
		},
	});
});
</sec:authorize>



$('#wordlist_edit_save').click(function () {
	$(this).blur();
	const sStandardWord = $('#wordlist_edit_standardWord').val().trim();
	if (sStandardWord.length > 0) {
		const oStandardWordRegex = RegExp('^[가-힣]+$');
		let regexResult = oStandardWordRegex.test(sStandardWord);
		if (regexResult === false) {
			alert('*표준단어는 한글 입력만 가능합니다.');
			return;
		}
	}
	const sStandardWordEng = $('#wordlist_edit_standardWordEng').val().trim();
	if (sStandardWordEng.length > 0) {
		const oStandardWordEngRegex = RegExp('^[A-Za-z]+$');
		regexResult = oStandardWordEngRegex.test(sStandardWordEng);
		if (regexResult === false) {
			alert('*영문명은 영문 입력만 가능합니다.');
			return;
		}
	}
	const sAbbrevationEng = $('#wordlist_edit_abbrevationEng').val().trim();
	if (sAbbrevationEng.length > 0) {
		const oAbbrevationEngRegex = RegExp('^[A-Z]+$');
		regexResult = oAbbrevationEngRegex.test(sAbbrevationEng);
		if (regexResult === false) {
			alert('*영문약어는 영문 대문자 입력만 가능합니다.');
			return;
		}
	}
	wordlist_bNewRecord = false;
	$.ajax({
		type: "POST",
		url: '/word/post',
		beforeSend: function (xhr) {
            const header = "${_csrf.headerName}",
			token = "${_csrf.token}";
			xhr.setRequestHeader(header, token);
        },
		data: {
			requestId: $('#wordlist_edit_id').val(),
			standardWord: sStandardWord,
			standardWordEng: sStandardWordEng,
			abbrevationEng: sAbbrevationEng,
			synonyms: $('#wordlist_edit_synonyms').val(),
			isClassified: $('#wordlist_edit_isClassified').val(),
			source: $('#wordlist_edit_source').val(),
			definition: $('#wordlist_edit_definition').val(),
			requestStatus: $('#wordlist_edit_requestStatus').val()
		},
		statusCode: {
	        403: function (responseObject, textStatus, jqXHR) {
	        	window.location.reload();
	        },           
	    },
		success: function (data) {
			if (data.result === 3) {
				alert('이미 등록된 단어입니다. 확인하십시오.');
				return;
			}
			if (data.entity !== undefined) {
				if (data.entity.isNormal === '2') {
					alert('필수 입력값이 정상적으로 등록되지 않았습니다.');
				}
			}
			$('#' + wordlist_jqgrid_table).trigger('reloadGrid');
			// Clearing the form for editing record
			wordlist_setEditingFormData({
				bEditable: false,
				id: '',
				standardWord: '',
				standardWordEng: '',
				abbrevationEng: '',
				synonyms: '',
				isClassified: '',
				source: '',
				definition: '',
				username: '',
				firstname: '',
				requestStatus: '1',
				rejectionReason: '',
			});
			$('#wordlist_form_record_editing').hide();
		},
	});
});

$('#wordlist_edit_cancel').click(function () {
	$(this).blur();
	$("#" + wordlist_jqgrid_table).jqGrid('delRowData', -1);
	wordlist_setEditingFormData({
		bEditable: false,
		id: '',
		standardWord: '',
		standardWordEng: '',
		abbrevationEng: '',
		synonyms: '',
		isClassified: '',
		source: '',
		definition: '',
		username: '',
		firstname: '',
		requestStatus: '1',
		rejectionReason: '',
	});
	$("#" + wordlist_jqgrid_table).jqGrid("resetSelection");
	$('#wordlist_form_record_editing').hide();
	wordlist_bNewRecord = false;
});

let wordlist_jqGrid_url = 'word/list';

const wordlist_construct_jqgrid = function () {
	const wordGrid = $("#" + wordlist_jqgrid_table).jqGrid({
		url: wordlist_jqGrid_url,
		datatype: "json",
		mtype: 'POST',
		loadBeforeSend: function (jqXHR) {
		    const header = "${_csrf.headerName}", token = "${_csrf.token}";
		    jqXHR.setRequestHeader(header, token);
		},
		colNames: [
			'ID',
		    '상태 ID', // requestStatus
		    '상태',
		    '구분 ID', // registStatus
		    '구분',
		    '검사 ID', // isNormal
		    '검사',
		    '*표준 단어',
		    '*영문 약어',
		    '*영문명',
		    '유사어',
		    '분류어 여부 ID', // isClassified
		    '분류어 여부',
		    '출처',
		    '*정의',
		    '신청자',
		    '신청자 ID', // username
		    '신청일시',
		    '변경여부',
		    '부결 사유',
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
		        width : 161,
		        editable : false,
			},
			{
		        name : 'abbrevationEng',
		        index : 'abbrevationEng',
		        width : 161,
		        editable : false,
			},
			{
		        name : 'standardWordEng',
		        index : 'standardWordEng',
		        width : 161,
		        editable : false,
			},
			{
		        name : 'synonyms',
		        index : 'synonyms',
		        width : 141,
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
		        width : 130,
		        editable : false,
			},
			{
		        name : 'definition',
		        index : 'definition',
		        width : 255,
		        editable : false,
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
			{
		        name : 'rejectionReason',
		        index : 'rejectionReason',
		        width : 206,
		        editable : true,
		        editoptions:{size:"20",maxlength:"50"}
			},
		],
		pager: '#' + wordlist_jqgrid_pager,
		rowNum : 50,
		height: 'auto',
		rowList : [ 10, 50, 100 ],
		sortname : 'requestId',
		sortorder : 'desc',
		viewrecords : true,
		gridview: true,
		multiselect: true,
     	multiboxonly: true,
     	autowidth: true,
//      	shrinkToFit: true,
//      	forceFit: true,
         // caption : '',
        editurl: '/word/updateRejectionReason',
		jsonReader: {
			repeatitems: false,
     	},
     	ondblClickRow: function(id, ri, ci) {
           	<sec:authorize access="hasRole('ADMIN')">
           	const row = $(this).getRowData(id);
           	if(['2', '4'].includes(row.requestStatus)){
           	 var editparameters = {
	                  extraparam: { requestId: row.requestId },
	                  keys: true,
	                  successfunc: function(e){
	                	  const newValue = e.responseJSON.entity.rejectionReason
	                	  $('#wordlist_edit_rejection_reason').val(newValue);
	                	  return true;
	                  }
	            };
	            wordGrid.jqGrid('editRow',id,editparameters);
           	}
			</sec:authorize>
        },
		onSelectRow: function (ids, status, e) {
			/* if (e.target.nodeName !== 'INPUT') {
				$('#jqg_' + wordlist_jqgrid_table + '_' + ids).attr('checked', false);
			} */
			// console.log(e.target.nodeName);
			wordGrid.restoreRow(ids);
			if (status === true) {
				if (ids === '-1') {
					// console.log('Editing new record...');
					wordlist_setEditingFormData({
						bEditable: true,
						id: ids,
						standardWord: '',
						standardWordEng: '',
						abbrevationEng: '',
						synonyms: '',
						isClassified: '2', // 1 - Y, A - N
						source: '',
						definition: '',
						firstname: '${currentUser.firstname} (${currentUser.username})',
						requestStatus: '1',
						rejectionReason: '',
					});
					$('#wordlist_form_record_editing').show();
					$('#wordlist_edit_cancel').show();
				} else {
					const row = $(this).getRowData(ids);
					// console.log(row);
					wordlist_setEditingFormData({
						bEditable: <sec:authorize access="hasRole('USER')">['1', '4'].includes(row.requestStatus)</sec:authorize><sec:authorize access="hasRole('ADMIN')">false</sec:authorize>,
						id: row.requestId,
						standardWord: row.standardWord,
						standardWordEng: row.standardWordEng,
						abbrevationEng: row.abbrevationEng,
						synonyms: row.synonyms,
						isClassified: row.isClassified,
						source: row.source,
						definition: row.definition,
						firstname: row.firstname,
						requestStatus: row.requestStatus,
						rejectionReason: row.rejectionReason,
					});
					$('#wordlist_form_record_editing').show();
					$('#wordlist_edit_cancel').hide();
				}
			} else {
				$('#wordlist_form_record_editing').hide();
			}
		},
		loadError: function (jqXHR, textStatus, errorThrown) {
			if (jqXHR.status === 403) {
				window.location.reload();
			}
	    },
	    loadComplete: function () {
	    	wordlist_bNewRecord = false;
	    	$('#wordlist_form_record_editing').hide();
		},
	});
	$("#" + wordlist_jqgrid_table).jqGrid('navGrid', '#' + wordlist_jqgrid_pager, {
	    edit : false,
	    add : false,
	    del : false,
	    search : false,
	});
};
</script>
