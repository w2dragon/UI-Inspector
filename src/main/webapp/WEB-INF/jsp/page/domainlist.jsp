<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div style="display: flex; flex-direction: column;">
	<div class="content-section-wrapper">
		<div>
			<jsp:include page="../component/searchDomain.jsp">
				<jsp:param name="idPrefix" value="domainlist_search_" />
				<jsp:param name="bListScreen" value="true" />
			</jsp:include>
		</div>
	</div>
	<div class="content-section-wrapper content-jqgrid-table">
		<div>
			<div class="grid-main-toolbar-buttons-wrapper" style="display: flex; flex-direction: row; justify-content: flex-end;">
				<sec:authorize access="hasRole('USER')">
					<button class="btn btn-default" id='domainlist_new_record'>신규</button>
					<button class="btn btn-default" id='domainlist_make_request'>신청등록</button>
					<button class="btn btn-default" id='domainlist_cancel_request'>신청취소</button>
				</sec:authorize>
				<sec:authorize access="hasRole('ADMIN')">
					<button class="btn btn-default" id='domainlist_approve'>승인</button>
					<button class="btn btn-default" id='domainlist_reject'>부결</button>
				</sec:authorize>
			</div>
			<div class="" id="domainlist_jqgrid_table_wrapper">
			</div>
		</div>
	</div>
	<div class="content-section-wrapper">
		<div>
			<div id="domainlist_form_record_editing" class="content_form_record_editing" style="display: none;">
				<div style="display: flex; flex-direction: row;">
					<div style="flex: 1;">
						<input type='hidden' id='domainlist_edit_id' name='domainlist_edit_id' />
						<input type='hidden' id='domainlist_edit_requestStatus' name='domainlist_edit_requestStatus' />
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_domain_class" class="col-sm-2 control-label control-label-custom">도메인 타입</label>
							<div class="col-sm-8">
								<input type='text' id='domainlist_edit_domain_class' class="form-control input-sm" readonly="readonly" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_domain" class="col-sm-2 control-label control-label-custom">*도메인</label>
							<div class="col-sm-8">
								<input type='text' id='domainlist_edit_domain' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_type" class="col-sm-2 control-label control-label-custom">*유형</label>
							<div class="col-sm-8">
								<select id='domainlist_edit_type' class="form-control input-sm">
									<c:forEach items="${aCommonDictList4}" var="oDict">
										<option value='${oDict.grpCode}'>${oDict.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_word_appropriateness" class="col-sm-2 control-label control-label-custom">단어조합</label>
							<div class="col-sm-8">
								<input type='text' id='domainlist_edit_word_appropriateness' class="form-control input-sm" readonly="readonly" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_word_appropriateness_eng" class="col-sm-2 control-label control-label-custom">영문명</label>
							<div class="col-sm-8">
								<input type='text' id='domainlist_edit_word_appropriateness_eng' class="form-control input-sm" readonly="readonly" />
							</div>
						</div>
					</div>
					<div style="flex: 1;">
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_data_type" class="col-sm-2 control-label control-label-custom">*데이터 타입</label>
							<div class="col-sm-8">
								<select id='domainlist_edit_data_type' class="form-control input-sm">
									<c:forEach items="${aCommonDictList5}" var="oDict">
										<option value='${oDict.grpCode}'>${oDict.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_data_length" id="domainlist_edit_data_length_label" class="col-sm-2 control-label control-label-custom">*데이터 길이</label>
							<div class="col-sm-8">
								<input type='number' id='domainlist_edit_data_length' class="form-control input-sm" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_data_type_length" class="col-sm-2 control-label control-label-custom">*데이터 타입(길이)</label>
							<div class="col-sm-8">
								<input type='text' id='domainlist_edit_data_type_length' name='domainlist_data_type_length' class="form-control input-sm" readonly="readonly" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_definition" class="col-sm-2 control-label control-label-custom">*정의</label>
							<div class="col-sm-8">
								<input type='text' id='domainlist_edit_definition' class="form-control input-sm" autocomplete="off" />
							</div>
						</div>
						<div class="form-group form-group-custom">
							<label class="col-sm-2"></label>
							<label for="domainlist_edit_username" class="col-sm-2 control-label control-label-custom">신청자</label>
							<div class="col-sm-8">
								<input type='text' id='domainlist_edit_username' name='edit_username' class="form-control input-sm" readonly="readonly"/>
							</div>
						</div>
						<input type='hidden' id='domainlist_edit_word1_id' name='domainlist_edit_word1_id' />
						<input type='hidden' id='domainlist_edit_word2_id' name='domainlist_edit_word2_id' />
					</div>
					<div style="flex: 1; display: flex; flex-direction: column;">
						<div style="display: flex; flex-direction: column; justify-content: space-between; align-items: flex-end; width: 100%; height: 100%;">
							<div id='domainlist_edit_rejection_reason_wrapper' style='width: 100%; flex: 1;'>
									<div style='display: flex; flex-direction: column; justify-content: space-between; height: 100%; width: 100%;'>
										<div class="form-group form-group-custom" style="margin-bottom: 20px;">
											<label class="col-sm-2"></label>
											<label for="domainlist_edit_rejection_reason" class="col-sm-2 control-label control-label-custom">부결 사유</label>
											<div class="col-sm-8">
												<textarea id='domainlist_edit_rejection_reason' name='domainlist_edit_rejection_reason' class="form-control input-sm" rows="1" style="resize: none;">
												</textarea>
											</div>
										</div>
									</div>
								</div>
							<sec:authorize access="hasRole('USER')">
								<div style="align-items: flex-end; display: flex; flex: 1;">
									<button id='domainlist_edit_save' class="btn btn-default search_button" type="button" style="margin-right: 15px;">저장</button>
									<button id='domainlist_edit_cancel' class="btn btn-default search_button" type="button" style="margin-left: -12px; margin-right: 15px;">Clear</button>
								</div>
							</sec:authorize>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="domainlist_confirm_request" tabindex="-1" role="dialog" aria-labelledby="domainlist_confirm_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="domainlist_confirm_request_label">선택하신 <span id='domainlist_confirm_request_n'></span>건을 신청등록 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="domainlist_confirm_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="domainlist_rescind_request" tabindex="-1" role="dialog" aria-labelledby="domainlist_rescind_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="domainlist_rescind_request_label">선택하신 <span id='domainlist_rescind_request_n'></span>건을 신청취소 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="domainlist_rescind_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="domainlist_approve_request" tabindex="-1" role="dialog" aria-labelledby="domainlist_approve_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="domainlist_approve_request_label">선택하신 <span id='domainlist_approve_request_n'></span>건을 승인 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="domainlist_approve_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="domainlist_reject_request" tabindex="-1" role="dialog" aria-labelledby="domainlist_reject_request_label" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="domainlist_reject_request_label">선택하신 <span id='domainlist_reject_request_n'></span>건을 부결 하시겠습니까?</h5>
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 					<span aria-hidden="true">&times;</span> -->
<!-- 				</button> -->
			</div>
<!--       <div class="modal-body"> -->
<!--         Сонгосон n-г бүртгэл хийх үү? -->
<!--       </div> -->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="domainlist_reject_request_yes" data-dismiss="modal">예</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">아니오</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
const domainlist_jqgrid_table = 'domainlist_jqgrid_table';
const domainlist_jqgrid_pager = 'domainlist_jqgrid_pager';

const domainlist_datatype_dict = [
	<c:forEach items="${aCommonDictList5}" var="oDict">
		{
			id: '${oDict.grpCode}',
			value: '${oDict.name}',
		},
	</c:forEach>
];

let domainlist_bNewRecord = false;

const domainlist_onCloseTab = function () {
	domainlist_bNewRecord = false;
	$('#domainlist_form_record_editing').hide();
	$("#domainlist_search_button_reset").click();
	domainlist_jqGrid_url = 'domain/list';
};

const domainlist_toggleEnableFormData = function(dVal) {
	if (dVal === true) {
		domainlist_render_datatype_length();
		$('#domainlist_edit_save').show();
	} else {
		$('#domainlist_edit_save').hide();
	}
	$('#domainlist_edit_domain').attr('readonly', !dVal);
	$('#domainlist_edit_type').attr('disabled', !dVal);
	$('#domainlist_edit_data_type').attr('disabled', !dVal);
	$('#domainlist_edit_data_length').attr('readonly', !dVal);
	$('#domainlist_edit_definition').attr('readonly', !dVal);

};

const domainlist_setEditingFormData = function(data) {
	domainlist_toggleEnableFormData(data.bEditable);
	$('#domainlist_edit_id').val(data.id);
	$('#domainlist_edit_domain_class').val(data.domainClass);
	$('#domainlist_edit_domain').val(data.domain);
	$('#domainlist_edit_type').val(data.type); 
	$('#domainlist_edit_word_appropriateness').val(data.wordUnionKor);
	$('#domainlist_edit_word_appropriateness_eng').val(data.wordUnionEng);
	$('#domainlist_edit_data_type').val(data.dataType);
	$('#domainlist_edit_data_length').val(data.dataLength);
	$('#domainlist_edit_data_type_length').val(data.dataTypeLength);
	$('#domainlist_edit_definition').val(data.definition);
	$('#domainlist_edit_username').val(data.firstname);
	$('#domainlist_edit_word1_id').val(data.word1id);
	$('#domainlist_edit_word2_id').val(data.word2id);
	$('#domainlist_edit_requestStatus').val(data.requestStatus);
	if (data.requestStatus === '4') { // 4 - REJECTED
		$('#domainlist_edit_rejection_reason').val(data.rejectionReason);
		$('#domainlist_edit_rejection_reason').attr('readonly', true);
		$('#domainlist_edit_rejection_reason_wrapper').show();
	} else {
		$('#domainlist_edit_rejection_reason_wrapper').hide();
	}
	if (data.dataType === '2') { // 2-DATE. If DataType is DATE then DataTypeLength is "optional" 
		let sDataLengthLabel = $('#domainlist_edit_data_length_label').text();
		if (sDataLengthLabel.includes('*') === true) {
			$('#domainlist_edit_data_length_label').text(sDataLengthLabel.replace('*', ''));
		}
	} else {
		let sDataLengthLabel = $('#domainlist_edit_data_length_label').text();
		if (sDataLengthLabel.includes('*') === false) {
			$('#domainlist_edit_data_length_label').text('*' + sDataLengthLabel);
		}
	}
}

let domainlist_sLastValue = '';

$('#domainlist_edit_domain').keyup(function () {
	if (domainlist_sLastValue !== $(this).val()) {
		domainlist_sLastValue = $(this).val();
		domainlist_search_word($(this).val());
		domainlist_render_domain_class();
	}
});
$('#domainlist_edit_domain').change(function () {
	if (domainlist_sLastValue !== $(this).val()) {
		domainlist_sLastValue = $(this).val();
		domainlist_search_word($(this).val());
		domainlist_render_domain_class();
	}
});

let domainlist_aFoundWord = [];

let domainlist_oAjaxRequest = -1;

const domainlist_search_word = function (sQuery) {
	if (sQuery.trim().length > 0) {
		domainlist_oAjaxRequest = $.ajax({
			type: "POST",
			url: '/domain/search_word',
			contentType: "application/json; charset=utf-8",
			beforeSend: function (xhr) {
				if (domainlist_oAjaxRequest !== -1 && domainlist_oAjaxRequest.readyState < 4) {
					domainlist_oAjaxRequest.abort();
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
				domainlist_aFoundWord = [];
				data.forEach(function (item, index) {
					if (index < 2 || true) {
						domainlist_aFoundWord.push(item);
						if (index === 0) {
							$('#domainlist_edit_word1_id').val(item.requestId);
						}
						if (index === 1) {
							$('#domainlist_edit_word2_id').val(item.requestId);
						}
					}
				});
				domainlist_render_found_words();
			},
		});
	} else {
		domainlist_aFoundWord = [];
		domainlist_render_found_words();
		$('#domainlist_edit_word1_id').val('');
		$('#domainlist_edit_word2_id').val('');
	}
};

const domainlist_render_found_words = function () {
	let sResult = '';
	let sResult2 = '';
	domainlist_aFoundWord.forEach(function (item) {
		if (sResult.length > 0) {
			sResult += '_';
		}
		if (sResult2.length > 0) {
			sResult2 += '_';
		}
		sResult += item.standardWord;
		sResult2 += item.standardWordEng;
	});
	$('#domainlist_edit_word_appropriateness').val(sResult);
	$('#domainlist_edit_word_appropriateness_eng').val(sResult2);
};

$('#domainlist_edit_data_length').keyup(function () {
	domainlist_render_datatype_length();
});
$('#domainlist_edit_data_length').change(function () {
	domainlist_render_datatype_length();
});

$('#domainlist_edit_data_type').change(function () {
	domainlist_render_datatype_length();
});

const domainlist_render_datatype_length = function () {
	let sSelectedDataTypeId = '';
	let sDataTypeLengthValue = '';
	let sDataTypeLengthValue2 = '';
	for (let i = 0; i < domainlist_datatype_dict.length; i += 1) {
		if (domainlist_datatype_dict[i].id === $('#domainlist_edit_data_type').val()) {
			sSelectedDataTypeId = domainlist_datatype_dict[i].id;
			sDataTypeLengthValue = domainlist_datatype_dict[i].value;
			sDataTypeLengthValue2 = sDataTypeLengthValue.substr(0, 1);
			break;
		}
	}
	if (sDataTypeLengthValue.length > 0) {
		const sDataLength = $('#domainlist_edit_data_length').val();
		if (sDataLength.length > 0) {
			sDataTypeLengthValue += '(' + sDataLength + ')';
			sDataTypeLengthValue2 += sDataLength;
		}
		$('#domainlist_edit_data_type_length').val(sDataTypeLengthValue);
		$('#domainlist_edit_domain_class').val($('#domainlist_edit_domain').val() + '_' + sDataTypeLengthValue2);
		if (sSelectedDataTypeId === '2') { // 2-DATE. If DataType is DATE then DataTypeLength is "optional" 
			let sDataLengthLabel = $('#domainlist_edit_data_length_label').text();
			if (sDataLengthLabel.includes('*') === true) {
				$('#domainlist_edit_data_length_label').text(sDataLengthLabel.replace('*', ''));
			}
		} else {
			let sDataLengthLabel = $('#domainlist_edit_data_length_label').text();
			if (sDataLengthLabel.includes('*') === false) {
				$('#domainlist_edit_data_length_label').text('*' + sDataLengthLabel);
			}
		}
	} else {
		$('#domainlist_edit_data_type_length').val('');
		$('#domainlist_edit_domain_class').val($('#domainlist_edit_domain').val());
	}
};

const domainlist_render_domain_class = function () {
	const sTemp = $('#domainlist_edit_data_type_length').val().trim();
	if (sTemp.length > 0) {
		$('#domainlist_edit_domain_class').val($('#domainlist_edit_domain').val() + '_' + sTemp);
	} else {
		$('#domainlist_edit_domain_class').val($('#domainlist_edit_domain').val());
	}
};


<sec:authorize access="hasRole('USER')">
$('#domainlist_new_record').click(function() {
	$(this).blur();
	$("#" + domainlist_jqgrid_table).jqGrid("resetSelection");
	if (domainlist_bNewRecord === false) {
		var rejectionReason = $("#" + domainlist_jqgrid_table).jqGrid('getColProp','rejectionReason');
		rejectionReason.editable = false;
		$("#" + domainlist_jqgrid_table).jqGrid('addRow', {
			rowID : "-1",
			initdata : {},
			position : "first",
			useDefValues : false,
			useFormatter : false,
			addRowParams : {
				extraparam : {}
			}
		});
		domainlist_bNewRecord = true;
	} else {
		// select previous existing new record which has ID equals -1
		$("#" + domainlist_jqgrid_table).jqGrid("setSelection", -1);
	}
});

$('#domainlist_make_request').click(function () {
	$(this).blur();
	const myGrid = $('#' + domainlist_jqgrid_table);
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
		alert('선택하신 도메인이 없습니다.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 도메인의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount2) {
		alert('선택 도메인의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#domainlist_confirm_request_n').html(aSelectedRequestId.length.toString());
		$('#domainlist_confirm_request').modal('show');
		$("#domainlist_confirm_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/domain/make_request',
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
					$('#' + domainlist_jqgrid_table).trigger('reloadGrid');
					$('#domainlist_form_record_editing').hide();
				},
			});
			$("#domainlist_confirm_request_yes").off();
		});
	}
});
$('#domainlist_cancel_request').click(function() {
	$(this).blur();
	const myGrid = $('#' + domainlist_jqgrid_table);
	const selectedRowId = myGrid.jqGrid('getGridParam', 'selarrrow');
	const aSelectedRequestId = [];
	const aSelectedRequestStatus = [];
	selectedRowId.forEach(function(item) {
		const cellValue = myGrid.jqGrid("getCell", item, "requestId");
		aSelectedRequestId.push(parseInt(cellValue, 10));
		const cellValue2 = myGrid.jqGrid("getCell", item, "requestStatus");
		aSelectedRequestStatus.push(cellValue2);
	});
	const iAppropriateRecordCount = aSelectedRequestStatus.filter(function (item) {
		return ['1', '2', '4'].includes(item); // 1 - draft, 2 - waiting decision, 4 - rejected
	}).length;
	if (selectedRowId.length === 0){
		alert('선택하신 도메인이 없습니다.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 도메인의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#domainlist_rescind_request_n').html(aSelectedRequestId.length.toString());
		$('#domainlist_rescind_request').modal('show');
		$("#domainlist_rescind_request_yes").click(function (e) {
			$.ajax({
				type : "POST",
				url : '/domain/cancel_request',
				contentType : "application/json ; charset = utf-8",
				beforeSend : function(xhr) {
					const header = "${_csrf.headerName}", token = "${_csrf.token}";
					xhr.setRequestHeader(header, token);
				},
				data : JSON.stringify({
					aSelectedRequestId : aSelectedRequestId,
				}),
				statusCode: {
			        403: function (responseObject, textStatus, jqXHR) {
			        	window.location.reload();
			        },           
			    },
				success : function() {
					$('#' + domainlist_jqgrid_table).trigger('reloadGrid');
					$('#domainlist_form_record_editing').hide();
				},
			});
			$("#domainlist_rescind_request_yes").off();
		});
	}
});
</sec:authorize>
<sec:authorize access="hasRole('ADMIN')">
$('#domainlist_approve').click(function () {
	$(this).blur();
	const myGrid = $('#' + domainlist_jqgrid_table);
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
		alert('선택하신 도메인이 없습니다.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 도메인의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#domainlist_approve_request_n').html(aSelectedRequestId.length.toString());
		$('#domainlist_approve_request').modal('show');
		$("#domainlist_approve_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/domain/approve_request',
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
					$('#' + domainlist_jqgrid_table).trigger('reloadGrid');
					$('#domainlist_form_record_editing').hide();
				},
			});
			$("#domainlist_approve_request_yes").off();
		});
	}
});
$('#domainlist_reject').click(function () {
	$(this).blur();
	const myGrid = $('#' + domainlist_jqgrid_table);
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
		alert('선택하신 도메인이 없습니다.');
		return;
	}
	if (aSelectedRequestId.length !== iAppropriateRecordCount) {
		alert('선택 도메인의 상태가 유효하지 않습니다. 확인하십시오.');
		return;
	}
	if (aSelectedRequestId.length > 0) {
		$('#domainlist_reject_request_n').html(aSelectedRequestId.length.toString());
		$('#domainlist_reject_request').modal('show');
		$("#domainlist_reject_request_yes").click(function (e) {
			$.ajax({
				type: "POST",
				url: '/domain/reject_request',
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
					$('#' + domainlist_jqgrid_table).trigger('reloadGrid');
					$('#domainlist_form_record_editing').hide();
				},
			});
			$("#domainlist_reject_request_yes").off();
		});
	}
});

$('#domainlist_edit_save_rejection_reason').click(function () {
	$(this).blur();
	const sReason = $('#domainlist_edit_rejection_reason').val().trim();
	$.ajax({
		type: "POST",
		url: '/domain/updateRejectionReason',
		beforeSend: function (xhr) {
            const header = "${_csrf.headerName}",
			token = "${_csrf.token}";
			xhr.setRequestHeader(header, token);
        },
		data: {
			requestId: $('#domainlist_edit_id').val(),
			rejectionReason: sReason,
		},
		statusCode: {
	        403: function (responseObject, textStatus, jqXHR) {
	        	window.location.reload();
	        },           
	    },
		success: function (data) {
			$('#' + domainlist_jqgrid_table).trigger('reloadGrid');
			// Clearing the form for editing record
			domainlist_setEditingFormData({
				bEditable: false,
				id: '',
				domainClass: '',
				domain: '',
				type: '',
				wordUnionKor: '',
				wordUnionEng: '',
				dataType: '',
				dataLength: '',
				dataTypeLength: '',
				definition: '',
				username: '',
				firstname: '',
				word1id: -1,
				word2id: -1,
				requestStatus: '1',
				rejectionReason: '',
			});
			$('#domainlist_form_record_editing').hide();
		},
	});
});
</sec:authorize>


$('#domainlist_edit_save').click(function() {
	$(this).blur();
	const aWordAppropriate = $('#domainlist_edit_word_appropriateness').val().split("_");
	if (aWordAppropriate.length === 0) {
		alert('등록된 단어가 없습니다. 확인하십시오.'); // 4-9 alert
		return;
	}
	/* if (aWordAppropriate.length === 1) {
		alert('도메인이 정상적으로 등록되지 않았습니다.'); // 4-9 alert
	} */
	const sUnion = aWordAppropriate.join('');
	if ($('#domainlist_edit_domain').val() !== sUnion) {
		alert('등록된 단어가 없습니다. 확인하십시오.'); // 4-9 alert
		return;
	}
	/* if ($('#domainlist_edit_type').val() === null) {
		alert('유형을 선택해주세요.');
		return;
	}
	if ($('#domainlist_edit_data_type').val() === null) {
		alert('데이터타입을 선택해주세요.');
		return;
	} */
	const sDataType = $('#domainlist_edit_data_type').val();
	let sDataLength = $('#domainlist_edit_data_length').val();
	if (sDataType === '2') { // 2-DATE
		if (sDataLength.includes('.') === true) {
			alert('데이터길이 번호 입력만 가능합니다.');
			return;
		}
	} else {
		if (sDataType !== '4') { // 4-NUMBER
			if (sDataLength.includes('.') === true) {
				alert('데이터길이 번호 입력만 가능합니다.');
				return;
			}
		}
		// sDataLength = sDataLength.length > 0 ? sDataLength : 0;
	}
	domainlist_bNewRecord = false;
	$.ajax({
		type: "POST",
		url: '/domain/post',
		beforeSend: function (xhr) {
			const header = "${_csrf.headerName}", token = "${_csrf.token}";
			xhr.setRequestHeader(header, token);
        },
		data: {
			requestId: $('#domainlist_edit_id').val(),
			domain: $('#domainlist_edit_domain').val(),
			type: $('#domainlist_edit_type').val(),
			wordUnionKor: $('#domainlist_edit_word_appropriateness').val(),
			wordUnionEng: $('#domainlist_edit_word_appropriateness_eng').val(),
			dataType: sDataType,
			dataLength: sDataLength,
			definition: $('#domainlist_edit_definition').val(),
			word1Id: $('#domainlist_edit_word1_id').val(),
			word2Id: $('#domainlist_edit_word2_id').val(),
			requestStatus: $('#domainlist_edit_requestStatus').val()
		},
		statusCode: {
	        403: function (responseObject, textStatus, jqXHR) {
	        	window.location.reload();
	        },           
	    },
		success: function (data) {
			if (data.result === 3) {
				alert('이미 등록된 도메인입니다. 확인하십시오.');			
				return;
			}
			if (data.entity !== undefined) {
				if (data.entity.isNormal === '2') {
					alert('필수 입력값이 정상적으로 등록되지 않았습니다.');
				}
			}
			$('#' + domainlist_jqgrid_table).trigger('reloadGrid');
			domainlist_setEditingFormData({
				bEditable: false,
				id: '',
				domainClass: '',
				domain: '',
				type: '',
				wordUnionKor: '',
				wordUnionEng: '',
				dataType: '',
				dataLength: '',
				dataTypeLength: '',
				definition: '',
				username: '',
				firstname: '',
				word1id: -1,
				word2id: -1,
				requestStatus: '1',
				rejectionReason: '',
			});
			$('#domainlist_form_record_editing').hide();
		},
	});
});

$('#domainlist_edit_cancel').click(function () {
	$(this).blur();
	$("#" + domainlist_jqgrid_table).jqGrid('delRowData', -1);
	domainlist_setEditingFormData({
		bEditable: false,
		id: '',
		domainClass: '',
		domain: '',
		type: '',
		wordUnionKor: '',
		wordUnionEng: '',
		dataType: '',
		dataLength: '',
		dataTypeLength: '',
		definition: '',
		username: '',
		firstname: '',
		word1id: -1,
		word2id: -1,
		requestStatus: '1',
		rejectionReason: '',
	});
	$("#" + domainlist_jqgrid_table).jqGrid("resetSelection");
	$('#domainlist_form_record_editing').hide();
	domainlist_bNewRecord = false;
});

let domainlist_jqGrid_url = 'domain/list';

const domainlist_construct_jqgrid = function () {
	const domainGrid = $("#" + domainlist_jqgrid_table).jqGrid({
		url : domainlist_jqGrid_url,
		datatype : "json",
		mtype : 'POST',
		loadBeforeSend : function(jqXHR) {
			const header = "${_csrf.headerName}", token = "${_csrf.token}";
			jqXHR.setRequestHeader(
					header, token);
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
			'*정의',
			'신청자',
			'신청자 ID',
			'신청일시',
			'단어 №1',
			'단어 №2',
			'부결 사유',
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
				width : 150,
				editable : false
			},
			{
				name : 'domain', //Domain
				index : 'domain',
				width : 150,
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
				width : 47,
				editable : false,
				align: "center",
			},
			{
				name : 'wordUnionKor', // үгийн зохицол
				index : 'wordUnionKor',
				width : 168,
				editable : false
			},
			{
				name : 'wordUnionEng', // англи нэршил 
				index : 'wordUnionEng',
				width : 168,
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
				width : 112,
				editable : false
			},
			{
				name : 'definition', // тодорхойлолт 
				index : 'definition',
				width : 234,
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
			{
		        name : 'rejectionReason',
		        index : 'rejectionReason',
		        width : 140,
		        editable : true,
		        editoptions:{size:"20",maxlength:"50"}
			},
		],
		pager : '#' + domainlist_jqgrid_pager,
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
		// caption : '',
		editurl: '/domain/updateRejectionReason',
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
	                	  $('#domainlist_edit_rejection_reason').val(newValue);
	                	  return true;
	                  }
	            };
	            domainGrid.jqGrid('editRow',id,editparameters);
           	}
			</sec:authorize>
        },
		onSelectRow : function(ids, status) {
			// console.log(ids);
			domainGrid.restoreRow(ids);
			if (status === true) {
				if (ids === '-1') {
					domainlist_setEditingFormData({
						bEditable : true,
						id: ids,
						domainClass: '',
						domain : '',
						type : '',
						wordUnionKor : '',
						wordUnionEng : '',
						dataType : '',
						dataLength : '',
						dataTypeLength: '',
						definition : '',
						username: '',
						firstname: '${currentUser.firstname} (${currentUser.username})',
						word1id: -1,
						word2id: -1,
						requestStatus: '1',
						rejectionReason: '',
					});
					$('#domainlist_form_record_editing').show();
					$('#domainlist_edit_cancel').show();
				} else {
					const row = $(this).getRowData(ids);
					domainlist_setEditingFormData({
						bEditable: <sec:authorize access="hasRole('USER')">['1', '4'].includes(row.requestStatus)</sec:authorize><sec:authorize access="hasRole('ADMIN')">false</sec:authorize>,
						id: row.requestId,
						domainClass: row.dataTypeText.length > 0 ? row.domain + '_' + row.dataTypeText.substr(0, 1) + row.dataLength : row.domain,
						domain: row.domain,
						type: row.type,
						wordUnionKor: row.wordUnionKor,
						wordUnionEng: row.wordUnionEng,
						dataType: row.dataType,
						dataLength: row.dataLength,
						dataTypeLength: row.dataTypeText.length > 0 ? ((row.dataLength !== null && row.dataLength.trim().length > 0) ? row.dataTypeText + '(' + row.dataLength + ')' : row.dataTypeText) : '',
						definition: row.definition,
						firstname: row.firstname,
						word1id: row.word1Id,
						word2id: row.word2Id,
						requestStatus: row.requestStatus,
						rejectionReason: row.rejectionReason,
					});
					$('#domainlist_form_record_editing').show();
					$('#domainlist_edit_cancel').hide();
				}
			} else {
				$('#domainlist_form_record_editing').hide();
			}
		},
		loadError: function (jqXHR, textStatus, errorThrown) {
			if (jqXHR.status === 403) {
				window.location.reload();
			}
	    },
	    loadComplete: function () {
	    	domainlist_bNewRecord = false;
	    	$('#domainlist_form_record_editing').hide();
		},
	});
	jQuery("#" + domainlist_jqgrid_table).jqGrid('navGrid', '#' + domainlist_jqgrid_pager, {
		edit : false,
		add : false,
		del : false,
		search : false,
	});
};
</script>