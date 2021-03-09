<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class='search_word_fragment_wrapper'>
	<%-- <div style="display: flex;">
		<div class='search_word_used_condition_label_wrapper'>
			도메인 조회 조건:
		</div>
		<div class='search_word_used_condition_value_wrapper' id="${param.idPrefix}used_condition">
		</div>
	</div> --%>
	<div style="display: flex; flex-direction: row;">
		<div style="flex: 1;">
			<div style="display: flex;">
				<div class='search_word_condition_label_wrapper'>
					신청 기간
				</div>
				<div class='search_word_condition_value_wrapper'>
					<div style='display: flex; justify-content: space-between; max-width: 400px; font-size: 16px;'>
						<div class='input-group date'>
							<input type='text' class="form-control" id='${param.idPrefix}datepicker_start' placeholder="시작일" autocomplete="off" value="${sWeekBefore}" />
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
						-
						<div class='input-group date'>
							<input type='text' class="form-control" id='${param.idPrefix}datepicker_end' placeholder="만료일" autocomplete="off" value="${sToday}" />
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				</div>
			</div>
			<c:choose>
				<c:when test="${param.bListScreen == 'true'}">
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							상태
						</div>
						<div class='search_word_condition_value_wrapper'>
							<div style='display: flex; justify-content: space-between; align-items: flex-end; max-width: 400px;'>
							<sec:authorize access="hasRole('USER')">
								<div class="checkbox">
									<label>
										<input type="checkbox" id="${param.idPrefix}checkbox_1"> 신청대기
									</label>
								</div>
							</sec:authorize>
								<div class="checkbox">
									<label>
										<input type="checkbox" id="${param.idPrefix}checkbox_2"> 신청등록
									</label>
								</div>
								<div class="checkbox">
									<label>
										<input type="checkbox" id="${param.idPrefix}checkbox_3"> 승인
									</label>
								</div>
								<div class="checkbox">
									<label>
										<input type="checkbox" id="${param.idPrefix}checkbox_4"> 부결
									</label>
								</div>
							<sec:authorize access="hasRole('USER')">
								<div class="checkbox">
									<label>
										<input type="checkbox" id="${param.idPrefix}checkbox_5"> 신청취소
									</label>
								</div>
							</sec:authorize>
							</div>
						</div>
					</div>
				</c:when>
			</c:choose>
		</div>
		<div style="flex: 1;">
			<c:choose>
				<c:when test="${param.bListScreen == 'true'}">
					<sec:authorize access="hasRole('ADMIN')">
						<div style="display: flex;">
							<div class='search_word_condition_label_wrapper'>
								신청자
							</div>
							<div class='search_word_condition_value_wrapper less_width'>
								<div class="form-group">
									<input type="text" class="form-control" id="${param.idPrefix}requester" placeholder="신청자" autocomplete="off" />
								</div>
							</div>
						</div>
					</sec:authorize>
					<sec:authorize access="hasRole('USER')">
						<div style="display: flex;">
							<div class='search_word_condition_label_wrapper'>
								신청자
							</div>
							<div class='search_word_condition_value_wrapper less_width'>
								<div class="form-group">
									<input type="text" class="form-control" placeholder="신청자" readonly="readonly" value="${currentUser.firstname} (${currentUser.username})" />
								</div>
							</div>
						</div>
					</sec:authorize>
				</c:when>
				<c:when test="${param.bListScreen == 'false'}">
					<div style="display: flex;">
						<div class='search_word_condition_label_wrapper'>
							신청자
						</div>
						<div class='search_word_condition_value_wrapper less_width'>
							<div class="form-group">
								<input type="text" class="form-control" id="${param.idPrefix}requester" placeholder="신청자" autocomplete="off" />
							</div>
						</div>
					</div>
				</c:when>
			</c:choose>
			<div style="display: flex;">
				<div class='search_word_condition_label_wrapper'>
					도메인명
				</div>
				<div class='search_word_condition_value_wrapper less_width'>
					<div class="form-group">
						<input type="text" class="form-control" id="${param.idPrefix}query_content" placeholder="" autocomplete="off" />
					</div>
				</div>
			</div>
		</div>
		<div style="flex: 0.6;">
<%-- 			<c:choose> --%>
<%-- 				<c:when test="${param.bListScreen == 'true'}"> --%>
<!-- 					<div style="display: flex;"> -->
<!-- 						<div class='search_word_condition_label_wrapper'> -->
<!-- 							Rejection reason: -->
<!-- 						</div> -->
<!-- 						<div class='search_word_condition_value_wrapper'> -->
<!-- 							<div class="form-group"> -->
<%-- 								<input type="text" class="form-control" id="${param.idPrefix}rejection_reason" placeholder="rejection reason" autocomplete="off" /> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<%-- 				</c:when> --%>
<%-- 			</c:choose> --%>
			<div style='display: flex; justify-content: center;'>
				<button class='btn btn-default search_button' id="${param.idPrefix}button">조회</button>
				<button class='btn btn-default search_button' id="${param.idPrefix}button_reset">Clear</button>
			</div>
		</div>
	</div>
</div>

	<script type="text/javascript">
		const ${param.idPrefix}validate_dates = function () {
			let bResult = false;
			const dateStart = $('#${param.idPrefix}datepicker_start').val();
      		const dateEnd = $('#${param.idPrefix}datepicker_end').val();
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
            $(function () {
            	$("#${param.idPrefix}button").click(function () {
               		const aCheckboxList = [];
               		if ($('#${param.idPrefix}checkbox_1').prop("checked")) {
               			aCheckboxList.push(1);
              		}
               		if ($('#${param.idPrefix}checkbox_2').prop("checked")) {
               			aCheckboxList.push(2);
              		}
               		if ($('#${param.idPrefix}checkbox_3').prop("checked")) {
               			aCheckboxList.push(3);
              		}
               		if ($('#${param.idPrefix}checkbox_4').prop("checked")) {
               			aCheckboxList.push(4);
              		}
               		if ($('#${param.idPrefix}checkbox_5').prop("checked")) {
               			aCheckboxList.push(5);
              		}
              		const queryContent = $('#${param.idPrefix}query_content').val();
              		const dateStart = $('#${param.idPrefix}datepicker_start').val();
              		const dateEnd = $('#${param.idPrefix}datepicker_end').val();
              		if (${param.idPrefix}validate_dates() === false) {
                  		alert('선택한 날짜가 유효하지 않습니다.');
                  		return;
                  	}
               		const oSearchPayload = {
              			dateStart: dateStart,
              			dateEnd: dateEnd,
              			aRequestStatus: aCheckboxList,
	               		<c:choose>
	               			<c:when test="${param.bListScreen == 'true'}">
	              				<sec:authorize access="hasRole('ADMIN')">
	               					requester: $('#${param.idPrefix}requester').val(),
		            			</sec:authorize>
	              				rejectionReason: $('#${param.idPrefix}rejection_reason').val(),
	              			</c:when>
	              			<c:when test="${param.bListScreen == 'false'}">	
	               					requester: $('#${param.idPrefix}requester').val(),
              				</c:when>
						</c:choose>
              			queryContent: queryContent,
           			};
/*            			let sCondition = '';
           			if (queryContent.trim().length > 0) {
           				sCondition += '도메인: "' + queryContent + '"';
          			}
          			if (dateStart.trim().length > 0) {
              			if (sCondition.length > 0) {
                 			sCondition += ', ';
                  		}
          				sCondition += '시작 날짜: "' + dateStart + '"';
           			}
          			if (dateEnd.trim().length > 0) {
              			if (sCondition.length > 0) {
                 			sCondition += ', ';
                  		}
          				sCondition += '종료 날짜: "' + dateEnd + '"';
           			}
           			$('#${param.idPrefix}used_condition').html(sCondition); */
           			// console.log(jQuery.param(oSearchPayload));
           			<c:choose>
           				<c:when test="${param.bListScreen == 'true'}">
		           			domainlist_jqGrid_url = 'domain/list?' + jQuery.param(oSearchPayload);
		           			$('#domainlist_jqgrid_table_wrapper').html(`
		     					<table id="domainlist_jqgrid_table">
		     					</table>
		     					<div id="domainlist_jqgrid_pager"></div>
		     				`);
		     				domainlist_construct_jqgrid();
	     				</c:when>
           				<c:when test="${param.bListScreen == 'false'}">
		           			domainsearch_jqGrid_url = 'domain/list_approved?' + jQuery.param(oSearchPayload);
		           			$('#domainsearch_jqgrid_table_wrapper').html(`
		     					<table id="domainsearch_jqgrid_table">
		     					</table>
		     					<div id="domainsearch_jqgrid_pager"></div>
		     				`);
		     				domainsearch_construct_jqgrid();
	     				</c:when>
	     			</c:choose>
	     			$(this).blur();
               	});

            	$("#${param.idPrefix}datepicker_start").datepicker({ showAnim: "fadeIn", dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
            	$("#${param.idPrefix}datepicker_end").datepicker({ showAnim: "fadeIn", dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true });
            	$("#${param.idPrefix}datepicker_start").next().on('click', function(){
                    $('#${param.idPrefix}datepicker_start').focus();
            	})
            	$("#${param.idPrefix}datepicker_end").next().on('click', function(){
                    $('#${param.idPrefix}datepicker_end').focus();
            	})

            	$("#${param.idPrefix}button_reset").click(function () {
                   	// Reset button
                   	const sWeekBefore = '${sWeekBefore}';
                   	const sToday = '${sToday}';
                   	$('#${param.idPrefix}datepicker_start').val(sWeekBefore);
            		$('#${param.idPrefix}datepicker_end').val(sToday);
            		for (let i = 1; i < 6; i += 1) {
            			$('#${param.idPrefix}checkbox_' + i).prop('checked', false);
                	}
            		$('#${param.idPrefix}query_content').val('');
            		$('#${param.idPrefix}requester').val('');
            		$(this).blur();
               	});
            });
        </script>