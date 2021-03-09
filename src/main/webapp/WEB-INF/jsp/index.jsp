<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<t:genericpage>
    <jsp:attribute name="title">
      LG CNS - Data Standard
    </jsp:attribute>
    <jsp:attribute name="dependencyInHead">
		<link href="/static/jquery-ui-1.7.2/themes/base/jquery-ui.css" rel="stylesheet" />
		<link href="/static/jquery-ui-1.7.2/themes/base/ui.theme.css" rel="stylesheet" />
<!-- 	    <link href="resources/css/jquery-ui.structure.min.css" rel="stylesheet" /> -->
		<link href="/static/jqGrid-4.7.0/css/ui.jqgrid.css" rel="stylesheet" />
		<link href="/static/css/jqgrid.custom.css" rel="stylesheet" />

		<script src="/static/jquery-migrate-1.2.1.js"></script>
		<script src="/static/jquery-ui-1.7.2/ui/minified/jquery-ui.min.js"></script>
		<script src="/static/jqGrid-4.7.0/js/i18n/grid.locale-kr.js"></script>
		<script src="/static/jqGrid-4.7.0/js/minified/jquery.jqGrid.min.js"></script>
    </jsp:attribute>
    <jsp:attribute name="header">
      <jsp:include page="component/header.jsp" />
    </jsp:attribute>
    <jsp:attribute name="footer">
      <jsp:include page="component/footer.jsp" />
    </jsp:attribute>
    <jsp:attribute name="sidebar">
      <jsp:include page="component/sidebar.jsp" />
    </jsp:attribute>
    <jsp:body>
    
    
    
    
<ul class="nav nav-tabs" id="tab_dynamic_id">
</ul>

<div class="tab-content">
  <div id="tab_wordlist" class="tab-pane fade">
    <jsp:include page="page/wordlist.jsp" />
  </div>
  <div id="tab_domainlist" class="tab-pane fade">
    <jsp:include page="page/domainlist.jsp" />
  </div>
  <div id="tab_termlist" class="tab-pane fade">
    <jsp:include page="page/termlist.jsp" />
  </div>
  <div id="tab_wordsearch" class="tab-pane fade">
    <jsp:include page="page/wordsearch.jsp" />
  </div>
  <div id="tab_domainsearch" class="tab-pane fade">
    <jsp:include page="page/domainsearch.jsp" />
  </div>
  <div id="tab_termsearch" class="tab-pane fade">
    <jsp:include page="page/termsearch.jsp" />
  </div>
  <!-- 메뉴추가 by kimsy 20210128 -->
  <div id="tab_cmpnmst" class="tab-pane fade">
    <jsp:include page="page/CmpnMng.jsp" />
  </div>
  <!-- 메뉴추가 by kimsy 20210226 -->
  <div id="tab_uiinspect" class="tab-pane fade">
    <jsp:include page="page/UIInspectMng.jsp" />
  </div>
</div>
    
    
<script>
const aTabPageList = [
	{
		tabButton: 'tab_wordlist_button',
		tabPage: 'tab_wordlist',
		tabText: '단어 신청관리'
	},
	{
		tabButton: 'tab_domainlist_button',
		tabPage: 'tab_domainlist',
		tabText: '도메인 신청관리'
	},
	{
		tabButton: 'tab_termlist_button',
		tabPage: 'tab_termlist',
		tabText: '용어 신청관리'
	},
	{
		tabButton: 'tab_wordsearch_button',
		tabPage: 'tab_wordsearch',
		tabText: '단어 조회'
	},
	{
		tabButton: 'tab_domainsearch_button',
		tabPage: 'tab_domainsearch',
		tabText: '도메인 조회'
	},
	{
		tabButton: 'tab_termsearch_button',
		tabPage: 'tab_termsearch',
		tabText: '용어 조회'
	},
	//메뉴 추가 by kimsy 20210128
	{
		tabButton: 'tab_cmpnmst_button',
		tabPage: 'tab_cmpnmst',
		tabText: '컴포넌트 마스터'
	},
	//메뉴 추가 by kimsy 20210226
	{
		tabButton: 'tab_uiinspect_button',
		tabPage: 'tab_uiinspect',
		tabText: 'UI Inspection 수행 & 이력'
	},
];

const openTab = function (sTab) {
	const tab_parent = $('#tab_dynamic_id');
 	aTabPageList.forEach(function (item) {
	if (sTab === item.tabButton) {
		if($('#'+sTab).length == 0){
			$("<li id='"+sTab+"'' class='active'>"+
				"<a data-toggle='tab' href='#"+item.tabPage+"'>"+item.tabText+
					"<div class='tab_close_button_wrapper'>"+
						"<button id='"+item.tabPage+"_close' class='tab_close_button'>x</button>"+
					"</div>"+
				"</a>"+
			"</li>").appendTo(tab_parent);
		} else {
			const oElement = $('#' + item.tabButton);
			oElement.addClass("active");
		}
		const oElement2 = $('#' + item.tabPage);
		oElement2.addClass("in active");
	} else {
		const oElement = $('#' + item.tabButton);
		oElement.removeClass("active");
		const oElement2 = $('#' + item.tabPage);
		oElement2.removeClass("in active");
	}
	}); 
};

const appendSearchQueryParam = function (url, id) {
	const dateStart = $('#'+ id +'_datepicker_start').val();
	const dateEnd = $('#'+ id +'_datepicker_end').val();
	return url + jQuery.param({
					dateStart: dateStart, 
					dateEnd: dateEnd
				});
}

$('#tab_wordlist_open').click(function (e) {
	e.stopPropagation();
	e.preventDefault();
	$('#wordlist_jqgrid_table_wrapper').html(`
		<table id="wordlist_jqgrid_table">
		</table>
		<div id="wordlist_jqgrid_pager"></div>
	`);
	openTab('tab_wordlist_button');
	wordlist_jqGrid_url = appendSearchQueryParam('word/list?', 'wordlist_search');
	wordlist_construct_jqgrid();
});
$('#tab_domainlist_open').click(function (e) {
	e.stopPropagation();
	e.preventDefault();
	$('#domainlist_jqgrid_table_wrapper').html(`
		<table id="domainlist_jqgrid_table">
		</table>
		<div id="domainlist_jqgrid_pager"></div>
	`);
	openTab('tab_domainlist_button');
    domainlist_jqGrid_url = appendSearchQueryParam('domain/list?', 'domainlist_search');
	domainlist_construct_jqgrid();
});
$('#tab_termlist_open').click(function (e) {
	e.stopPropagation();
	e.preventDefault();
	$('#termlist_jqgrid_table_wrapper').html(`
			<table id="termlist_jqgrid_table">
			</table>
			<div id="termlist_jqgrid_pager"></div>
		`);
	openTab('tab_termlist_button');
	
    termlist_jqGrid_url = appendSearchQueryParam('term/list?', 'termlist_search');
	termlist_construct_jqgrid();
});
$('#tab_wordsearch_open').click(function (e) {
	e.stopPropagation();
	e.preventDefault();
	$('#wordsearch_jqgrid_table_wrapper').html(`
		<table id="wordsearch_jqgrid_table">
		</table>
		<div id="wordsearch_jqgrid_pager"></div>
	`);
	openTab('tab_wordsearch_button');
	wordsearch_jqGrid_url = appendSearchQueryParam('word/list_approved?', 'wordsearch_search');
	wordsearch_construct_jqgrid();
});
$('#tab_domainsearch_open').click(function (e) {
	e.stopPropagation();
	e.preventDefault();
	$('#domainsearch_jqgrid_table_wrapper').html(`
		<table id="domainsearch_jqgrid_table">
		</table>
		<div id="domainsearch_jqgrid_pager"></div>
	`);
	openTab('tab_domainsearch_button');
	domainsearch_jqGrid_url = appendSearchQueryParam('domain/list_approved?', 'domainsearch_search');
	domainsearch_construct_jqgrid();
});
$('#tab_termsearch_open').click(function (e) {
	e.stopPropagation();
	e.preventDefault();
	$('#termsearch_jqgrid_table_wrapper').html(`
		<table id="termsearch_jqgrid_table">
		</table>
		<div id="termsearch_jqgrid_pager"></div>
	`);
	openTab('tab_termsearch_button');
	termsearch_jqGrid_url = appendSearchQueryParam('term/list_approved?', 'termsearch_search');
	termsearch_construct_jqgrid();
});
// 메뉴 추가  by kimsy 20210128
$('#tab_cmpnmst_open').click(function (e) {
	e.stopPropagation();
	e.preventDefault();
	$('#ui_tool_jqgrid_table_wrapper').html(`
			<table id="ui_tool_jqgrid_table">
			</table>
			<div id="ui_tool_jqgrid_pager"></div>
	`);
	$('#cmpnmst_jqgrid_table_wrapper').html(`		
		<table id="cmpnmst_jqgrid_table">
		</table>	
		<div id="cmpnmst_jqgrid_pager"></div>
	`);	
	openTab('tab_cmpnmst_button');
	cmpnmst_jqGrid_url = appendSearchQueryParam('', '');
	ui_tool_jqgrid();
	cmpnmst_jqgrid();	
});
//메뉴 추가  by kimsy 20210226
$('#tab_uiinspect_open').click(function (e) {
	e.stopPropagation();
	e.preventDefault();
	$('#vldt_rslt_hst_jqgrid_table_wrapper').html(`
			<table id="vldt_rslt_hst_jqgrid_table">
			</table>
			<div id="vldt_rslt_hst_jqgrid_pager"></div>
	`);
	openTab('tab_uiinspect_button');
	uiinspect_jqGrid_url = appendSearchQueryParam('', '');
	vldt_rslt_hst_jqgrid();	
});

function activateClosestTab(elem){
	let nextOrPrev = null;
	const firstNext = elem.nextAll('li:visible').first();
	const firstPrev = elem.prevAll('li:visible').first();
	if(firstNext.length > 0) nextOrPrev = firstNext;
	else if(firstPrev.length > 0) nextOrPrev = firstPrev;
	if(nextOrPrev === null) return;
	const oElement = nextOrPrev;
	oElement.addClass("active");
	oElement.show();
	const oElement2 = $(nextOrPrev.children().attr('href'));
	oElement2.addClass("in active");
}

$(document).on('click', '#tab_wordlist_close', function (e) {
	e.stopPropagation();
	e.preventDefault();
	if($(this).parent().parent().parent().hasClass('active'))
		activateClosestTab($(this).parent().parent().parent());
	
	const oElement = $('#tab_wordlist_button');
	oElement.remove();
	//oElement.hide();
	const oElement2 = $('#tab_wordlist');
	oElement2.removeClass("in active");
	wordlist_onCloseTab();
});
$(document).on('click', '#tab_domainlist_close', function (e) {
	e.stopPropagation();
	e.preventDefault();
	if($(this).parent().parent().parent().hasClass('active'))
		activateClosestTab($(this).parent().parent().parent());
	
	const oElement = $('#tab_domainlist_button');
	oElement.remove();
	//oElement.hide();
	const oElement2 = $('#tab_domainlist');
	oElement2.removeClass("in active");
	domainlist_onCloseTab();
});
$(document).on('click', '#tab_termlist_close', function (e) {
	e.stopPropagation();
	e.preventDefault();
	if($(this).parent().parent().parent().hasClass('active'))
		activateClosestTab($(this).parent().parent().parent());
	
	const oElement = $('#tab_termlist_button');
	oElement.remove();
	//oElement.hide();
	const oElement2 = $('#tab_termlist');
	oElement2.removeClass("in active");
	termlist_onCloseTab();
});
$(document).on('click', '#tab_wordsearch_close', function (e) {
	e.stopPropagation();
	e.preventDefault();
	if($(this).parent().parent().parent().hasClass('active'))
		activateClosestTab($(this).parent().parent().parent());
	
	const oElement = $('#tab_wordsearch_button');
	oElement.remove();
	//oElement.hide();
	const oElement2 = $('#tab_wordsearch');
	oElement2.removeClass("in active");
	wordsearch_onCloseTab();
});
$(document).on('click', '#tab_domainsearch_close', function (e) {
	e.stopPropagation();
	e.preventDefault();
	if($(this).parent().parent().parent().hasClass('active'))
		activateClosestTab($(this).parent().parent().parent());
	
	const oElement = $('#tab_domainsearch_button');
	oElement.remove();
	//oElement.hide();
	const oElement2 = $('#tab_domainsearch');
	oElement2.removeClass("in active");
	domainsearch_onCloseTab();
});
$(document).on('click', '#tab_termsearch_close', function (e) {
	e.stopPropagation();
	e.preventDefault();
	if($(this).parent().parent().parent().hasClass('active'))
		activateClosestTab($(this).parent().parent().parent());
	
	const oElement = $('#tab_termsearch_button');
	oElement.remove();
	//oElement.hide();
	const oElement2 = $('#tab_termsearch');
	oElement2.removeClass("in active");
	termsearch_onCloseTab();
});
//메뉴 추가  by kimsy 20210128
$(document).on('click', '#tab_cmpnmst_close', function (e) {
	e.stopPropagation();
	e.preventDefault();
	if($(this).parent().parent().parent().hasClass('active'))
		activateClosestTab($(this).parent().parent().parent());
	
	const oElement = $('#tab_cmpnmst_button');
	oElement.remove();
	//oElement.hide();
	const oElement2 = $('#tab_cmpnmst');
	oElement2.removeClass("in active");
	cmpnmst_onCloseTab();
});
//메뉴 추가  by kimsy 20210226
$(document).on('click', '#tab_uiinspect_close', function (e) {
	e.stopPropagation();
	e.preventDefault();
	if($(this).parent().parent().parent().hasClass('active'))
		activateClosestTab($(this).parent().parent().parent());
	
	const oElement = $('#tab_uiinspect_button');
	oElement.remove();
	//oElement.hide();
	const oElement2 = $('#tab_uiinspect');
	oElement2.removeClass("in active");
	uiinspect_onCloseTab();
});
$(document).ready(function() {
	$('#termsearch_jqgrid_table_wrapper').html(`
		<table id="termsearch_jqgrid_table">
		</table>
		<div id="termsearch_jqgrid_pager"></div>
	`);
	openTab('tab_termsearch_button');
	termsearch_jqGrid_url = appendSearchQueryParam('term/list_approved?', 'termsearch_search');
	termsearch_construct_jqgrid();
	
	$.extend($.jgrid.defaults, {
	    ajaxRowOptions: {
	        beforeSend: function (jqXHR, settings) {
	        	const header = "${_csrf.headerName}", token = "${_csrf.token}";
	        	jqXHR.setRequestHeader(header, token);
	        }
	    }
	});
});
</script>
        
    </jsp:body>
</t:genericpage>


		