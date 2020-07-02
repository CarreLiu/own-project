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
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/english.css">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="${pageContext.request.contextPath}/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico">
	
	<script type="text/javascript">
	  function frmSearchWordsValidator() {
		$('#frmSearchWords').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
                status: {
                	validators: {
                		notEmpty: {
                			message: '请选择单词类型'
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
                        	url: '${pageContext.request.contextPath}/word/findByWordEnglish2.action',
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
				url : "${pageContext.request.contextPath}/word/findWordsByPage.action", //要请求数据的文件路径
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
							return dateFormat(value, 'yyyy-MM-dd');
						}
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
			if (typeof(value) == "object") {
				id = value.id;
				object = value;
			}
			
			let result = "";
			if (object.isFavorite == 1) {
				result += "<button type='button' class='btn btn-warning btn-xs' onclick='changeFavoriteStatus("+object.id+","+object.userId+","+object.isFavorite+")'>取消收藏</button>&nbsp;&nbsp;&nbsp;";
			}
			else {
				result += "<button type='button' class='btn btn-success btn-xs' onclick='changeFavoriteStatus("+object.id+","+object.userId+","+object.isFavorite+")'>加入收藏</button>&nbsp;&nbsp;&nbsp;";
			}
			if (object.status == 1) {
				result += "<button type='button' class='btn btn-warning btn-xs' onclick='changeStatus("+object.id+","+object.status+")'>禁用</button>&nbsp;&nbsp;&nbsp;";
			}
			else {
				result += "<button type='button' class='btn btn-success btn-xs' onclick='changeStatus("+object.id+","+object.status+")'>启用</button>&nbsp;&nbsp;&nbsp;";
			}
			result += "<a class='btn btn-info btn-xs' onclick='modifyWord(" + id + ")'>修改</a>";
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
    		let status = $('#status').val();
    		let pageNo = (params.offset / params.limit) + 1;
			return {
				//页码  
				pageNo : pageNo,
				//页面大小
				pageSize : params.limit,
				allTime : allTime,
				beginDate : beginDate,
				endDate : endDate,
				status : status
			}
	    }
		
		//查询收藏单词
		function initTableFavorite() {
			//先销毁表格  
			$('#cusTable').bootstrapTable('destroy');
			//初始化表格,动态从服务器加载数据  
			$("#cusTable").bootstrapTable({
				method : 'post',
				contentType : "application/x-www-form-urlencoded", //post请求必须要有！
				url : "${pageContext.request.contextPath}/favorite/findFavoritesByPage.action", //要请求数据的文件路径
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
						field : 'word',
						align : 'center',
						formatter : function(value, row, index) {
							return value.english;
						}
					},
					{
						title : '音',
						field : 'word',
						align : 'center',
						formatter : function(value, row, index) {
							let id = row.id;
							let english = value.english;
							let result = '';
							result += '<span id="voiceBtn-' + id + '" onclick="playVoice(' + id + ',&quot;' + english + '&quot;)" ';
							result += 'class="glyphicon glyphicon-volume-down" aria-hidden="true" style="cursor: pointer;">';
							result += '<audio id="mp3Btn-' + id + '" onended="playEnd(' + id + ')"></audio></span>';
							return result;
						}
					},
					{
						title : '中文释义',
						field : 'word',
						align : 'left',
						formatter : function(value, row, index) {
							return value.chinese;
						}
					},
					{
						title : '收藏时间',
						field : 'joinTime',
						align : 'center',
						formatter : function(value, row, index) {
							return dateFormat(value, 'yyyy-MM-dd');
						}
					},
					{
			          	title:'状态',
			          	field:'word',
			          	align:'center',
			          	formatter:function(value, row, index){
			          		let result = (value.isFavorite == 0 ? '未收藏':'已收藏');
			          		result += '&nbsp;' + (value.status == 0 ? '禁用':'启用');
			          		return result;
			          	}
			        },
					{
						title : '操作',
						field : 'word',
						align : 'center',
						formatter : actionFormatter
					}
				]
			});
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
    	//ajax生成bootstrap表格
  		initTable();  
    	  
    	frmSearchWordsValidator();
        $('#frmSearchWords').on('change', function() {
        	//全部时间选项
        	if ($('#allTime').is(':checked') == true) {
				$('#beginDate').attr('disabled', true);
				$('#endDate').attr('disabled', true);
        	}
        	else {
        		$('#beginDate').removeAttr('disabled');
        		$('#endDate').removeAttr('disabled');
        		$('#frmSearchWords').bootstrapValidator('addField', 'beginDate',{
        			verbose: false,
                    validators: {
                        notEmpty: {
                            message: '开始时间不能为空'
                        },
                        date: {
                        	message: '日期非法'
                        },
                        callback: {
                            message: '开始时间不能大于结束时间',
                            callback: function(value, validator) {
                            	let start = new Date(value.replace(/-/g, '/'));
                            	if (start > Date.now()) {
                                	validator.updateMessage('beginDate', 'callback', '时间不能大于今天');
                                	return false;
                                }
                                let other = validator.getFieldElements('endDate').val();
                                if (other == '')
                                    return true;
                                let end = new Date(other.replace(/-/g, '/'));
                                if (start > end) {
                                	validator.updateMessage('beginDate', 'callback', '开始时间不能大于结束时间');
                                    return false;
                                }
                                return true;
                            }
                        }
                    }
		        });
        		$('#frmSearchWords').bootstrapValidator('addField', 'endDate',{
        			verbose: false,
                    validators: {
                        notEmpty: {
                            message: '结束时间不能为空'
                        },
                        date: {
                        	message: '日期非法'
                        },
                        callback: {
                            message: '结束时间不能小于开始时间',
                            callback: function(value, validator) {
                            	let end = new Date(value.replace(/-/g, '/'));
                                if (end > Date.now()) {
                                	validator.updateMessage('endDate', 'callback', '时间不能大于今天');
                                	return false;
                                }
                                let other = validator.getFieldElements('beginDate').val();
                                if (other == '')
                                    return true;
                                let start = new Date(other.replace(/-/g, '/'));
                                if (start > end) {
                                	validator.updateMessage('endDate', 'callback', '结束时间不能小于开始时间');
                                    return false;
                                }
                                return true;
                            }
                        }              
                    }
        		});
        	}
        	let validator = $('#frmSearchWords').data("bootstrapValidator");	//获取validator对象
        	validator.validate();	//手动触发验证
        	if (validator.isValid()) {	//通过验证
        		$('#searchBtn').removeAttr('disabled');
        	}
        	else {
        		$('#searchBtn').attr('disabled', true);
        	}
        });
        
        $('#searchBtn').on('click', function() {
        	let validator = $('#frmSearchWords').data("bootstrapValidator");
        	validator.validate();
        	if (validator.isValid()) {
        		
        		if ($('#status').val() == 2) {
        			//ajax生成收藏单词的bootstrap表格
        			initTableFavorite();
        		}
        		else {
        			//ajax生成bootstrap表格
        			initTable();
        		}
        		
        		$('#frmSearchWords').data('bootstrapValidator').destroy();
        		$('#frmSearchWords').data('bootstrapValidator', null);
        		frmSearchWordsValidator();
        	}
        	else {
        		$('#searchBtn').attr('disabled', true);
        	}
        });
		
        $('#frmModifyWord').on('input propertychange', function() {
        	let validator = $('#frmModifyWord').data("bootstrapValidator");	//获取validator对象
        	validator.validate();	//手动触发验证
           	if (validator.isValid()) {	//通过验证
           		$('#modifyBtn').removeAttr('disabled');
           	}
           	else {
           		$('#modifyBtn').attr('disabled', true);
           	}        		
        });
        
        $('#requestChinese').on('click', function() {
    		let english = $('#english').val();
    		if (english != "" && english != null) {
    			//ajax同步方式提交数据
   				$.ajaxSettings.async = false;
    			$.post('${pageContext.request.contextPath}/allword/findChinese.action',
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
            	$('#modifyBtn').removeAttr('disabled');
    		}
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
           		$.post('${pageContext.request.contextPath}/word/modifyWord.action',
           			{'id':id,'english':english,'chinese':chinese},
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
					} ,'json');
           		$('#modifyWord').modal('hide');
           		$('#cusTable').bootstrapTable('refresh');
           	}
           	else {
           		$('#modifyBtn').attr('disabled', true);
           	}
        });
        
        
      });
      
      function modifyWord(id) {
    	  $('#modifyBtn').removeAttr('disabled');
    	  frmModifyWordValidator();	//防止destroy不能被调用
    	  $('#frmModifyWord').data('bootstrapValidator').destroy();
  		  $('#frmModifyWord').data('bootstrapValidator', null);
    	  $.post('${pageContext.request.contextPath}/word/findWordById.action',
    		{'id':id},
    		function(word) {
    			$('#id').val(word.id);
    			$('#primeEnglish').val(word.english);
    			$('#english').val(word.english);
    			$('#chinese').val(word.chinese);
    	    	$('#modifyWord').modal('show');
    	    	frmModifyWordValidator();
    	  }, 'json');
    	  
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
          <label style="font-size: 1.2em; margin-right: 10px;">单词类型:</label>
          <select class="form-control" style="margin-right: 25px;" name="status" id="status">
            <option value="">--请选择--</option>
            <option selected="selected" value="-1">全部单词</option>
            <option value="1">启用单词</option>
            <option value="0">禁用单词</option>
            <option value="2">收藏单词</option>
          </select>
        </div>
        <div class="form-group">
          <input class="btn btn-primary btn-block" id="searchBtn" type="button" value="查询单词" />
        </div>
      </form>
    </div>
    
    <div class="container" style="margin-top: 50px;">
      <table id="cusTable">
      	<!--使用设置每一列的宽度-->
		<colgroup>
			<col style="width:15%;">
			<col style="width:5%;">
			<col style="width:30%;">
			<col style="width:15%;">
			<col style="width:15%;">
			<col style="width:20%;">
		</colgroup>
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
				         <input type="button" id="requestChinese" class="btn btn-primary btn-block" value="获取中文">
			       	 </div>
			       	 <div class="col-sm-6 col-xs-6">
			       	 	 <button type="button" id="modifyBtn" class="btn btn-primary btn-block">确认修改</button>
			       	 </div>
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

