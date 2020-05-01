<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="单词测试页面">
    <meta name="author" content="CarreLiu">

    <title>测试记录</title>

    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrapValidator.min.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-table.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrapValidator.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="${pageContext.request.contextPath}/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico">
	
	<script type="text/javascript">
	
	  function frmSearchTestsValidator() {
		$('#frmSearchTests').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
                beginDate: {
                    validators: {
                        notEmpty: {
                            message: '开始时间不能为空'
                        },
                        callback: {
                            message: '开始时间不能大于结束时间',
                            callback: function(value, validator) {
                                let other = validator.getFieldElements('endDate').val();
                                if (other == '' || value == '')
                                    return true;
                                let start = new Date(value.replace(/-/g, '/'));
                                let end = new Date(other.replace(/-/g, '/'));
                                if (start <= end)
                                    return true;
                                return false;
                            }
                        }
                    }
                },
                endDate: {
                    validators: {
                        notEmpty: {
                            message: '结束时间不能为空'
                        },
                        callback: {
                            message: '结束时间不能小于开始时间',
                            callback: function(value, validator) {
                                let other = validator.getFieldElements('beginDate').val();
                                if (other == '' || value == '')
                                    return true;
                                let start = new Date(other.replace(/-/g, '/'));
                                let end = new Date(value.replace(/-/g, '/'));
                                if (start <= end)
                                    return true;
                                return false;
                            }
                        }              
                    }
                },
                testType: {
                	validators: {
                		notEmpty: {
                			message: '请选择题目类型'
                		}
                	}
                }
            }
        });
	  }
	  
	  	function initTable() {
			//先销毁表格  
			$('#cusTable').bootstrapTable('destroy');
			//初始化表格,动态从服务器加载数据  
			$("#cusTable").bootstrapTable({
				method : 'post',
				contentType : "application/x-www-form-urlencoded", //post请求必须要有！
				url : "${pageContext.request.contextPath}/tests/findTestsByPage.action", //要请求数据的文件路径
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
						title : '测试号',
						field : 'id',
						align : 'center'
					},
					{
						title : '测试时间',
						field : 'createTime',
						align : 'center',
						formatter : function(value, row, index) {
							return dateFormat(value, 'yyyy-MM-dd hh:mm:ss');
						}
					},
					{
						title : '总题数',
						field : 'totalWords',
						align : 'center'
					},
					{
						title : '正确率',
						field : 'correctRate',
						align : 'center',
						formatter : function(value, row, index) {
							return (value * 100).toFixed(1) + '%';
						}
					},
					{
						title : '题目类型',
						field : 'testType',
						align : 'center',
						formatter : function(value, row, index) {
							if (value == 0)
								return "全部题目";
							else if (value == 1)
								return "错误题目";
							else if (value == 2)
								return "正确题目";
							else
								return "类型错误";
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
			let result = "";
			result += "<a class='btn btn-success btn-xs' onclick='viewDetail(" + id + ")'>查看详情</a>&nbsp;&nbsp;&nbsp;";
			return result;
		}
		
		//请求服务数据时所传参数
		function queryParams(params) {
			let allTime = 0;	//0表示未选中,1表示选中
			if ($('#allTime').is(':checked') == true) {
				allTime = 1;
			}
			let beginDate = $('#beginDate').val();
    		let endDate = $('#endDate').val();
    		let testType = $('#testType').val();
			return {
				//页码  
				pageNo : (params.offset / params.limit) + 1,
				//页面大小
				pageSize : params.limit,
				allTime : allTime,
				beginDate : beginDate,
				endDate : endDate,
				testType : testType
			}
	    }
	  
      $(function() {
    	//ajax生成bootstrap表格
  		initTable();  
    	  
    	frmSearchTestsValidator();
        $('#frmSearchTests').on('change', function() {
        	//全部时间选项
        	if ($('#allTime').is(':checked') == true) {
				$('#frmSearchTests').bootstrapValidator('removeField', 'beginDate');
				$('#frmSearchTests').bootstrapValidator('removeField', 'endDate');
				$('#beginDate').prop('disabled', true);
				$('#endDate').prop('disabled', true);
        	}
        	else {
        		$('#beginDate').prop('disabled', false);
        		$('#endDate').prop('disabled', false);
        		$('#frmSearchTests').bootstrapValidator('addField', 'beginDate',{
        			validators: {
                        notEmpty: {
                            message: '开始时间不能为空'
                        },
                        callback: {
                            message: '开始时间不能大于结束时间',
                            callback: function(value, validator) {
                                let other = validator.getFieldElements('endDate').val();
                                if (other == '' || value == '')
                                    return true;
                                let start = new Date(value.replace(/-/g, '/'));
                                let end = new Date(other.replace(/-/g, '/'));
                                if (start <= end)
                                    return true;
                                return false;
                            }
                        }
                    }
		        });
        		$('#frmSearchTests').bootstrapValidator('addField', 'endDate',{
        			validators: {
                        notEmpty: {
                            message: '结束时间不能为空'
                        },
                        callback: {
                            message: '结束时间不能小于开始时间',
                            callback: function(value, validator) {
                                let other = validator.getFieldElements('beginDate').val();
                                if (other == '' || value == '')
                                    return true;
                                let start = new Date(other.replace(/-/g, '/'));
                                let end = new Date(value.replace(/-/g, '/'));
                                if (start <= end)
                                    return true;
                                return false;
                            }
                        }              
                    }
        		});
        	}
        	let validator = $('#frmSearchTests').data("bootstrapValidator");	//获取validator对象
        	validator.validate();	//手动触发验证
        	if (validator.isValid()) {	//通过验证
        		$('#searchBtn').prop('disabled', false);
        	}
        	else {
        		$('#searchBtn').prop('disabled', true);
        	}
        });
        
        $('#searchBtn').on('click', function() {
        	let validator = $('#frmSearchTests').data("bootstrapValidator");
        	validator.validate();
        	if (validator.isValid()) {
        		//ajax生成bootstrap表格
        		initTable();
        		
        		$('#frmSearchTests').data('bootstrapValidator').destroy();
        		$('#frmSearchTests').data('bootstrapValidator', null);
        		frmSearchTestsValidator();
        	}
        	else {
        		$('#searchBtn').prop('disabled', true);
        	}
        });
		
      });
      
      function viewDetail(id) {
    	  window.location = "${pageContext.request.contextPath}/tests/toTestDetail.action?id="+id;
      }
	    //时间戳格式化处理
	  	function dateFormat(date, format) {
	  		date = new Date(date);
	  		var map = {
	  			"M" : date.getMonth() + 1, //月份
	  			"d" : date.getDate(), //日
	  			"h" : date.getHours(), //小时
	  			"m" : date.getMinutes(), //分
	  			"s" : date.getSeconds(), //秒
	  			"q" : Math.floor((date.getMonth() + 3) / 3), //季度
	  			"S" : date.getMilliseconds() //毫秒
	  		};
	  		format = format.replace(/([yMdhmsqS])+/g, function(all, t) {
	  			var v = map[t];
	  			if (v !== undefined) {
	  				if (all.length > 1) {
	  					v = '0' + v;
	  					v = v.substr(v.length - 2);
	  				}
	  				return v;
	  			} else if (t === 'y') {
	  				return (date.getFullYear() + '').substr(4 - all.length);
	  			}
	  			return all;
	  		});
	  		return format;
	  	}
      
    </script>
	
  <script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"6504",secure:"13459"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>

  <body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc3-1" data-genuitec-path="/english/WebRoot/WEB-INF/pages/testShown.jsp">
	<% request.setAttribute("index", 2); %>
	<jsp:include page="top.jsp"/>
    <div class="container text-center" style="margin-top: 20px;" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc3-1" data-genuitec-path="/english/WebRoot/WEB-INF/pages/testShown.jsp">
      <form class="form-inline" id="frmSearchTests" action="/action" method="post">
        <div class="form-group">
        	<label style="font-size: 1.2em; font-weight: bold;">全部时间</label>
        	<input class="form-control" type="checkbox" checked="checked" style="margin-right: 25px;" name="allTime" id="allTime" />
        </div>
        <div class="form-group">
          <label style="font-size: 1.2em; margin-right: 10px;">开始时间:</label>
          <input class="form-control" type="date" disabled="disabled" style="margin-right: 25px;" name="beginDate" id="beginDate" />
        </div>
        <div class="form-group">
          <label style="font-size: 1.2em; margin-right: 10px;">结束时间:</label>
          <input class="form-control" type="date" disabled="disabled" style="margin-right: 25px;" name="endDate" id="endDate" />
        </div>
        <div class="form-group">
          <label style="font-size: 1.2em; margin-right: 10px;">记录类型:</label>
          <select class="form-control" style="margin-right: 25px;" name="testType" id="testType">
            <option value="">--请选择--</option>
            <option selected="selected" value="-1">全部记录</option>
            <option value="0">词库单词</option>
            <option value="1">错误单词</option>
            <option value="2">正确单词</option>
          </select>
        </div>
        <div class="form-group">
          <input class="btn btn-success btn-block" id="searchBtn" type="button" value="查询单词" />
        </div>
      </form>
    </div>
    
    <div class="container" style="margin-top: 50px;">
      <table id="cusTable">
      
      </table>
    </div>


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${pageContext.request.contextPath}/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>

