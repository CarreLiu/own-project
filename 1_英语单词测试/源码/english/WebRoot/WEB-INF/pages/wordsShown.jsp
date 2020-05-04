<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="词库单词页面">
    <meta name="author" content="CarreLiu">

    <title>英语单词测试</title>

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
		let flag = 0;	//判断是否修改了单词	
	  function frmSearchWordsValidator() {
		$('#frmSearchWords').bootstrapValidator({
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
                }
            }
        });
	  }
	  
	  function frmModifyWordValidator() {
		  $('#frmModifyWord').bootstrapValidator({
		  	feedbackIcons: {
	        	valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	english: {
	        		validators: {
	        			notEmpty: {
	        				message: '英语单词不能为空'
	        			},
                        regexp: {
                            regexp: /^[a-zA-Z0-9_-\s]+$/,
                            message: '请输入合法的英文单词'
                        },
                        remote: {	//远程校验,此处修改了源码,改为了同步方式
                        	type: 'post',
                        	url: '${pageContext.request.contextPath}/words/findByWordEnglish2.action',
                        	data: {
                        		primeEnglish: $('#primeEnglish').val()
                        	}
                        }
	        		}
	        	},
	        	chinese: {
	        		validators: {
	        			notEmpty: {
	        				message: '中文释义不能为空'
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
				url : "${pageContext.request.contextPath}/words/findWordsByPage.action", //要请求数据的文件路径
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
						title : '添加时间',
						field : 'createTime',
						align : 'center',
						formatter : function(value, row, index) {
							return dateFormat(value, 'yyyy-MM-dd hh:mm:ss');
						}
					},
					{
						title : '错误次数',
						field : 'errorTimes',
						align : 'center'
					},
					{
						title : '正确次数',
						field : 'correctTimes',
						align : 'center'
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
			result += "<a class='btn btn-success btn-xs' onclick='modifyWord(" + id + ")'>修改</a>";
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
    		let pageNo = (params.offset / params.limit) + 1;
    		$('#pageNo').val(pageNo);
			return {
				//页码  
				pageNo : pageNo,
				//页面大小
				pageSize : params.limit,
				allTime : allTime,
				beginDate : beginDate,
				endDate : endDate
			}
	    }
	  
      $(function() {
    	//ajax生成bootstrap表格
  		initTable();  
    	  
    	frmSearchWordsValidator();
        $('#frmSearchWords').on('change', function() {
        	//全部时间选项
        	if ($('#allTime').is(':checked') == true) {
				$('#frmSearchWords').bootstrapValidator('removeField', 'beginDate');
				$('#frmSearchWords').bootstrapValidator('removeField', 'endDate');
				$('#beginDate').prop('disabled', true);
				$('#endDate').prop('disabled', true);
        	}
        	else {
        		$('#beginDate').prop('disabled', false);
        		$('#endDate').prop('disabled', false);
        		$('#frmSearchWords').bootstrapValidator('addField', 'beginDate',{
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
        		$('#frmSearchWords').bootstrapValidator('addField', 'endDate',{
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
        	let validator = $('#frmSearchWords').data("bootstrapValidator");	//获取validator对象
        	validator.validate();	//手动触发验证
        	if (validator.isValid()) {	//通过验证
        		$('#searchBtn').prop('disabled', false);
        	}
        	else {
        		$('#searchBtn').prop('disabled', true);
        	}
        });
        
        $('#searchBtn').on('click', function() {
        	let validator = $('#frmSearchWords').data("bootstrapValidator");
        	validator.validate();
        	if (validator.isValid()) {
        		//ajax生成bootstrap表格
        		initTable();
        		
        		$('#frmSearchWords').data('bootstrapValidator').destroy();
        		$('#frmSearchWords').data('bootstrapValidator', null);
        		frmSearchWordsValidator();
        	}
        	else {
        		$('#searchBtn').prop('disabled', true);
        	}
        });
		
        $('#frmModifyWord').on('input propertychange', function() {
        	let validator = $('#frmModifyWord').data("bootstrapValidator");	//获取validator对象
        	validator.validate();	//手动触发验证
           	if (validator.isValid()) {	//通过验证
           		$('#modifyBtn').prop('disabled', false);
           	}
           	else {
           		$('#modifyBtn').prop('disabled', true);
           	}        		
        });
        
        $('#resetBtn').on('click', function() {
        	setTimeout(function() {	//否则会先执行下面的事件,再清空form表单
        		$('#frmModifyWord').data('bootstrapValidator').destroy();
        		$('#frmModifyWord').data('bootstrapValidator', null);
        		frmModifyWordValidator();
        		let validator = $('#frmModifyWord').data("bootstrapValidator");
            	validator.validate();
				$('#modifyBtn').prop('disabled', true);            	
        	}, 10);
        });
        
        $('#modifyBtn').on('click', function() {
        	let validator = $('#frmModifyWord').data("bootstrapValidator");
        	validator.validate();
       		if (validator.isValid()) {
           		let id = $('#id').val();
           		let english = $('#english').val();
           		let chinese = $('#chinese').val();
           		//ajax同步方式提交数据
   				$.ajaxSettings.async = false;
           		$.post('${pageContext.request.contextPath}/words/modifyWord.action',
           			{'id':id,'english':english,'chinese':chinese}, 'json');
           		$('#modifyWord').modal('hide');
           		$('#cusTable').bootstrapTable('refresh');
           	}
           	else {
           		$('#modifyBtn').prop('disabled', true);
           	}
        });
        
        
      });
      
      function modifyWord(id) {
    	  $('#modifyBtn').prop('disabled', false);
    	  frmModifyWordValidator();	//防止destroy不能被调用
    	  $('#frmModifyWord').data('bootstrapValidator').destroy();
  		  $('#frmModifyWord').data('bootstrapValidator', null);
    	  $.post('${pageContext.request.contextPath}/words/findWordById.action',
    		{'id':id},
    		function(word) {
    			$('#id').val(word.id);
    			$('#primeEnglish').val(word.english);
    			$('#english').val(word.english);
    			$('#chinese').val(word.chinese);
    	    	$('#modifyWord').modal('show');
    	    	frmModifyWordValidator();
    	  }, 'json');
    	  
    	  	$('#requestChinese').on('click', function() {
	    		let english = $('#english').val();
	    		if (english != "" && english != null) {
	    			//ajax同步方式提交数据
	   				$.ajaxSettings.async = false;
	    			$.post('${pageContext.request.contextPath}/allwords/findChinese.action',
	    	    			{'english': english},
	    	    			function(data) {
	    	    				if (data != "null")
	    	    					$('#chinese').val(data);
	    	    			}, 'text');
	    			$('#frmModifyWord').data('bootstrapValidator').destroy();
	        		$('#frmModifyWord').data('bootstrapValidator', null);
	        		frmModifyWordValidator();
	        		let validator = $('#frmModifyWord').data("bootstrapValidator");
	            	validator.validate();
	            	$('#modifyBtn').prop('disabled', false);
	    		}
	    	});
      }
      	
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
	
  </head>

  <body>
	<% request.setAttribute("index", 3); %>
	<jsp:include page="top.jsp"/>
    <div class="container text-center" style="margin-top: 20px;">
      <form class="form-inline" id="frmSearchWords" action="/action" method="post">
      	<input type="hidden" value="" id="pageNo">
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
          <input class="btn btn-success btn-block" id="searchBtn" type="button" value="查询单词" />
        </div>
      </form>
    </div>
    
    <div class="container" style="margin-top: 50px;">
      <table id="cusTable">
      
      </table>
    </div>
    
    <!-- 修改单词模态框begin -->
	<div class="modal fade" id="modifyWord" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">修改单词</h4>
	      </div>
	      <div class="modal-body">
	      	<form id="frmModifyWord" class="form-horizontal" method="post" action="">
	      		<input type="hidden" id="id">
	      		<input type="hidden" id="primeEnglish">
	      		<div class="form-group">
	      			<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">English:</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<input class="form-control" type="text" id="english" name="english">
	      			</div>
	      		</div>
	      		<div class="form-group">
	      			<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">中文释义:</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<input class="form-control" type="text" id="chinese" name="chinese">
	      			</div>
	      		</div>
	      		<div class="form-group">
			       <div class="col-sm-6 col-sm-offset-3 col-xs-8 col-xs-offset-2">
			       	 <div class="col-sm-6 col-xs-6">
				         <button type="reset" id="resetBtn" class="btn btn-primary btn-block">重&nbsp;&nbsp;置</button>
			       	 </div>
			       	 <div class="col-sm-6 col-xs-6">
			       	 	 <input type="button" id="requestChinese" class="btn btn-primary btn-block" value="获取中文">
			       	 </div>
			       </div>
			    </div>
			    <div class="form-group">
	      			<div class="col-sm-6 col-sm-offset-3 col-xs-8 col-xs-offset-2">
	      				<button type="button" id="modifyBtn" class="btn btn-primary btn-block">确&nbsp;&nbsp;认&nbsp;&nbsp;修&nbsp;&nbsp;改</button>
	      			</div>
	      		</div>
	      	</form>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
    <!-- 修改单词模态框end -->


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${pageContext.request.contextPath}/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>

