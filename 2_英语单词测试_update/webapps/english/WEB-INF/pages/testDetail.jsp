<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="测试记录页面">
    <meta name="author" content="CarreLiu">

    <title>英语单词测试</title>

    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-table.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-table.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/english.css">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="${pageContext.request.contextPath}/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico">
	
	<script type="text/javascript">
	
	  	function initTable() {
			//先销毁表格  
			$('#cusTable').bootstrapTable('destroy');
			//初始化表格,动态从服务器加载数据  
			$("#cusTable").bootstrapTable({
				method : 'post',
				contentType : "application/x-www-form-urlencoded", //post请求必须要有！
				url : "${pageContext.request.contextPath}/test/findSingleTestByPage.action", //要请求数据的文件路径
				striped : true, //是否显示行间隔色
				pageNumber : 1, //初始化加载第一页，默认第一页
				pagination : true, //是否分页
				queryParamsType : 'limit', //查询参数组织方式
				queryParams : queryParams, //请求服务器时所传的参数
				sidePagination : 'server', //指定服务器端分页
				pageSize : 10, //单页记录数
				pageList : [ 5, 10, 15], //分页步进值
				showRefresh : false, //刷新按钮
				showColumns : false,
				clickToSelect : false, //是否启用点击选中行
				toolbarAlign : 'right', //工具栏对齐方式
				buttonsAlign : 'right', //按钮对齐方式
				undefinedText : "空", //当数据为 undefined 时显示的字符  
				columns : [
					{
						title : 'English',
						field : 'english',
						align : 'center'
					},
					{
						title : '音',
						field : 'english',
						align : 'center',
						formatter : function(value, row, index) {
							let id = row.id;
							let english = value;
							let result = '';
							result += '<span id="voiceBtn-' + id + '" onclick="playVoice(' + id + ',&quot;' + english + '&quot;)" ';
							result += 'class="glyphicon glyphicon-volume-down" aria-hidden="true" style="cursor: pointer;">';
							result += '<audio id="mp3Btn-' + id + '" onended="playEnd(' + id + ')"></audio></span>';
							return result;
						}
					},
					{
						title : '中文释义',
						field : 'chinese',
						align : 'left'
					},
					{
			          	title:'状态',
			          	field:'status',
			          	align:'center',
			          	formatter:function(value, row, index){
			          		let result = (row.isFavorite == 0 ? '未收藏':'已收藏');
			          		result += '&nbsp;' + (value == 0 ? '禁用':'启用');
			          		return result;
			          	}
			        },
					{
						title : '操作',
						field : 'id',
						align : 'center',
						formatter : actionFormatter
					}
				]
			});
		}
	  	
  		//操作栏的格式化
  		function actionFormatter(value, row, index) {
  			let id = value;
  			let object = row;
  			
  			let result = "";
  			if (object.isFavorite == 1) {
  				result += "<button type='button' class='btn btn-warning btn-xs' onclick='changeFavoriteStatus("+object.id+","+object.userId+","+object.isFavorite+")'>取消收藏</button>&nbsp;&nbsp;&nbsp;";
  			}
  			else {
  				result += "<button type='button' class='btn btn-success btn-xs' onclick='changeFavoriteStatus("+object.id+","+object.userId+","+object.isFavorite+")'>加入收藏</button>&nbsp;&nbsp;&nbsp;";
  			}
  			if (object.status == 1) {
  				result += "<button type='button' class='btn btn-warning btn-xs' onclick='changeStatus("+object.id+","+object.status+")'>禁用</button>";
  			}
  			else {
  				result += "<button type='button' class='btn btn-success btn-xs' onclick='changeStatus("+object.id+","+object.status+")'>启用</button>";
  			}
  			return result;
  		}
		
		//请求服务数据时所传参数
		function queryParams(params) {
			let id = $('#testId').val();
    		let wordsType = $('#wordsType').val();
			return {
				//页码  
				pageNo : (params.offset / params.limit) + 1,
				//页面大小
				pageSize : params.limit,
				id : id,
				wordsType : wordsType
			}
	    }
		
		//修改单词状态
   		function changeStatus(id, status) {
   			let flag;
			if(status == '1')
				flag = 0;
			else
				flag = 1;
			$.post('${pageContext.request.contextPath}/word/modifyWordStatus.action',
					{'id':id, 'status':flag},
					function(data) {
						$('#cusTable').bootstrapTable('refresh');
						if (data.status == 1) {
   	                        layer.msg(data.message, {
   	                            time:2000,
   	                            skin:'successMsg'
   	                        });
   	                    }
   	                    else {
   	                        layer.msg(data.message, {
   	                            time:2000,
   	                            skin:'errorMsg'
   	                        });
   	                    }
			}, 'json');
   		}
		
   		//修改单词收藏状态
   		function changeFavoriteStatus(id, userId, isFavorite) {
   			let flag;
			if(isFavorite == '1')
				flag = 0;
			else
				flag = 1;
			$.post('${pageContext.request.contextPath}/word/modifyWordFavoriteStatus.action',
					{'id':id, 'userId':userId, 'isFavorite':flag},
					function(data) {
						$('#cusTable').bootstrapTable('refresh');
						if (data.status == 1) {
   	                        layer.msg(data.message, {
   	                            time:2000,
   	                            skin:'successMsg'
   	                        });
   	                    }
   	                    else {
   	                        layer.msg(data.message, {
   	                            time:2000,
   	                            skin:'errorMsg'
   	                        });
   	                    }
			}, 'json');
   		}
		
		$(function() {
			layer.msg("若无记录，请刷新页面", {
                time:2000,
                skin:'errorMsg'
            });
			
			initTable();
			$('#wordsType').on('change', function() {
				initTable();
			});
		});
		
		  //开始播放
	      function playVoice(id, english) {
	      	let audio = $('#mp3Btn-'+id)[0];
			event.stopPropagation();	//防止冒泡
			if(audio.paused) {	//如果当前是暂停状态
				audio.src = 'http://dict.youdao.com/dictvoice?audio=' + english + '&type=1"';	//type=1为英式,2为美式
				let playPromise = audio.play();	//播放
				if (playPromise != undefined) {
					playPromise.then(function() {
						$('#voiceBtn-'+id).removeClass('glyphicon-volume-down');
						$('#voiceBtn-'+id).addClass('glyphicon-volume-up');
					}).catch(function(error) {
						alert('无网络');
					});
				}
				
			}
	      }
	      
	      //播放完毕
	      function playEnd(id) {
	      	$('#voiceBtn-'+id).removeClass('glyphicon-volume-up');
	      	$('#voiceBtn-'+id).addClass('glyphicon-volume-down');
	      }
      
    </script>
	
  <script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"6504",secure:"13459"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>

  <body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-2" data-genuitec-path="/english/WebRoot/WEB-INF/pages/testDetail.jsp">
	<% request.setAttribute("index", 2); %>
	<jsp:include page="top.jsp"/>
    <div class="container text-center" style="margin-top: 20px;" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-2" data-genuitec-path="/english/WebRoot/WEB-INF/pages/testDetail.jsp">
    	<div class="row">
    		<div class="col-sm-12">
    			<input type="hidden" value="${test.id}" id="testId" />
    			<label class="col-sm-2">测试号:&nbsp;${test.ownTestId}</label>
    			<label class="col-sm-2">测试时间:&nbsp;<fmt:formatDate value="${test.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></label>
    			<label class="col-sm-2">总题数:&nbsp;${test.totalWords}</label>
    			<label class="col-sm-2">正确率:&nbsp;<fmt:formatNumber type="number" value="${test.correctRate*100}" pattern="0.0"/>%</label>
    			<label class="col-sm-2">题目来源:&nbsp;${test.testType.name}</label>
    			<div class="form-group col-sm-2">
					<select class="form-control" id="wordsType">
	    				<option selected="selected" value="1">全部题目</option>
	    				<option value="2">错误题目</option>
	    				<option value="3">正确题目</option>
	    			</select>    			
    			</div>
    		</div>
    	</div>
    </div>
    
    <div class="container" style="margin-top: 50px;">
      <table id="cusTable">
      	<!--使用设置每一列的宽度-->
		<colgroup>
			<col style="width:15%;">
			<col style="width:5%;">
			<col style="width:45%;">
			<col style="width:15%;">
			<col style="width:20%;">
		</colgroup>
      </table>
    </div>


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${pageContext.request.contextPath}/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>

