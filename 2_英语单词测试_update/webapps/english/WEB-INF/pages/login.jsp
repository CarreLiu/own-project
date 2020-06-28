<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="用户登录页面">
    <meta name="author" content="CarreLiu">

    <title>英语单词测试</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" type="text/css"></link>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrapValidator.min.css" type="text/css"></link>
	<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrapValidator.min.js"></script>
	<script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/english.css">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="${pageContext.request.contextPath}/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico">
	
    <script type="text/javascript">
		function setMarginTop() {	//根据屏幕大小设定上外边距
	    	let val;
	    	if (window.screen.height > 600)
	    		val = window.screen.height / 5 + "px";
	    	else
	    		val = "0px";
	    	$('#containers').css('marginTop', val);
	    }

        function notFoundUniversity() {
        	$('#universityId').attr('disabled', 'true');
        	$('#notFound').attr('type', 'hidden');
        	$('#university').attr('type', 'text');
        	$('#university').removeAttr('disabled');
        	$('#haveFound').attr('type', 'button');
        	
        	$('#frmRegist').data('bootstrapValidator').destroy();
    		$('#frmRegist').data('bootstrapValidator', null);
    		frmRegistValidator();
        	$('#frmRegist').bootstrapValidator('removeField', 'universityId');
        	$('#frmRegist').bootstrapValidator('addField', 'university',{
        		validators: {
					notEmpty: {
						message: '学校不能为空'
					}
				}
	        });
        	
        	let validator = $('#frmRegist').data("bootstrapValidator");
        	validator.validate();
        }

        function haveFoundUniversity() {
        	$('#universityId').removeAttr('disabled');
        	$('#notFound').attr('type', 'text');
        	$('#university').attr('type', 'hidden');
        	$('#university').attr('disabled', 'true');
        	$('#haveFound').attr('type', 'hidden');
        	
        	$('#frmRegist').data('bootstrapValidator').destroy();
    		$('#frmRegist').data('bootstrapValidator', null);
    		frmRegistValidator();
        	
    		let validator = $('#frmRegist').data("bootstrapValidator");
        	validator.validate();
        }
        
        function frmLoginValidator() {
        	//注册账号表单校验
			$('#frmLogin').bootstrapValidator({
	            feedbackIcons: {
	                valid: 'glyphicon glyphicon-ok',
	                invalid: 'glyphicon glyphicon-remove',
	                validating: 'glyphicon glyphicon-refresh'
	            },
	            fields:{
	                username: {
	                    validators: {
	                        notEmpty: {
	                            message: '用户名不能为空'
	                        }
	                    }
	                },
	                password: {
	                    validators: {
	                        notEmpty: {
	                            message: '密码不能为空'
	                        }          
	                    }
	                }
	            }
	        });
        }
        
        function frmRegistValidator() {
        	//注册账号表单校验
			$('#frmRegist').bootstrapValidator({
	            feedbackIcons: {
	                valid: 'glyphicon glyphicon-ok',
	                invalid: 'glyphicon glyphicon-remove',
	                validating: 'glyphicon glyphicon-refresh'
	            },
	            fields:{
	                username: {
	                    validators: {
	                        notEmpty: {
	                            message: '用户名不能为空'
	                        },
		                    stringLength: {
		                        min: 3,
		                        max: 10,
		                        message: '用户名长度必须3-10位'
		                    },
		                    regexp: {
		                        regexp: /^[a-zA-Z0-9_]+$/,
		                        message: '用户名只能包含数字、字母、下划线'
		                    },
	                        remote: {	//远程校验
	                        	type: 'post',
	                        	url: '${pageContext.request.contextPath}/user/findByUsername.action'
	                        }
	                    }
	                },
	                password: {
	                    validators: {
	                        notEmpty: {
	                            message: '密码不能为空'
	                        },
							different: {
								field: 'username',
								message: '密码不能和用户名相同'
							}          
	                    }
	                },
					repassword: {
						validators: {
							notEmpty: {
								message: '确认密码不能为空'
							},
							identical: {
								field: 'password',
								message: '两次输入的密码不一致'
							}
						}
					},
					name: {
						validators: {
							notEmpty: {
								message: '昵称不能为空'
							}
						}
					},
					email: {
						validators: {
							notEmpty: {
								message: '邮箱不能为空'
							},
							emailAddress: {
								message: '邮箱格式不正确'
							}
						}
					},
					universityId: {
						validators: {
							notEmpty: {
								message: '学校不能为空'
							}
						}
					},
					info: {
						validators: {
							notEmpty: {
								message: '个人签名不能为空'
							}
						}
					}
	            }
	        });
        }

    	//页面加载完成后调用
    	$(function() {
    		setMarginTop();
	    	window.addEventListener('orientationchange', setMarginTop);	//当屏幕旋转时触发
			
	    	//未登录非法访问action
	    	let notLoginMsg = '${notLoginMsg}';
	    	if (notLoginMsg != '') {
	    		layer.msg(notLoginMsg, {
	    			time:2000,
	    			skin:'errorMsg'
	    		});
	    	}
	    	
	    	//退出登录
	    	let logOutMsg = '${logOutMsg}';
	    	if (logOutMsg != '') {
	    		layer.msg(logOutMsg, {
	    			time:2000,
	    			skin:'errorMsg'
	    		});
	    	}
	    	
	    	//登录失败服务器端校验
            let loginFailMsg = '${loginFailMsg}';
            if (loginFailMsg != '') {
                layer.msg(loginFailMsg, {
                    time:2000,
                    skin:'errorMsg'
                });
            }
            
          	//注册服务器端校验
            let registSuccessMsg = '${registSuccessMsg}';
            let registFailMsg = '${registFailMsg}';
            if (registSuccessMsg != '') {
                layer.msg(registSuccessMsg, {
                    time:2000,
                    skin:'successMsg'
                });
            }
            if (registFailMsg != '') {
                layer.msg(registFailMsg, {
                    time:2000,
                    skin:'errorMsg'
                });
            }
	    	
	    	
	    	frmLoginValidator();
	    	frmRegistValidator();
	    	
			$('#resetBtn').on('click', function() {
	        	setTimeout(function() {	//否则会先执行下面的事件,再清空form表单
	        		$('#frmLogin').data('bootstrapValidator').destroy();
	        		$('#frmLogin').data('bootstrapValidator', null);
	        		frmLoginValidator();
	        		let validator = $('#frmLogin').data("bootstrapValidator");
	            	validator.validate();
	        	}, 10);
	        });
			
			$('#registResetBtn').on('click', function() {
	        	setTimeout(function() {	//否则会先执行下面的事件,再清空form表单
	        		$('#frmRegist').data('bootstrapValidator').destroy();
	        		$('#frmRegist').data('bootstrapValidator', null);
	        		frmRegistValidator();
	        		
	        		if ($('#university').attr('type')=='text') {
	        			$('#frmRegist').bootstrapValidator('removeField', 'universityId');
	                	$('#frmRegist').bootstrapValidator('addField', 'university',{
	                		validators: {
	        					notEmpty: {
	        						message: '学校不能为空'
	        					}
	        				}
	        	        });
	        		}
	        		
	        		let validator = $('#frmRegist').data("bootstrapValidator");
	            	validator.validate();
	        	}, 10);
	        });
    	});
    </script>
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"6504",secure:"13459"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body style="background: url(${pageContext.request.contextPath}/images/backimage.jpg);" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-1" data-genuitec-path="/english/WebRoot/WEB-INF/pages/login.jsp">
	<div class="container" id="containers" style="background-color: white; border: 1px solid;" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc1-1" data-genuitec-path="/english/WebRoot/WEB-INF/pages/login.jsp">
        <form class="form-horizontal" id="frmLogin"
        	action="${pageContext.request.contextPath}/user/login.action"
        	method="post">
            <div class="form-group" style="background-color: #337ab7;">
            	<div class="h3 col-md-4 col-md-offset-4 col-xs-4 col-xs-offset-3 col-sm-4 col-sm-offset-4" style="margin-bottom: 20px; color: white;">单&nbsp;词&nbsp;测&nbsp;试&nbsp;系&nbsp;统</div>
            </div>
            <div class="form-group"></div>
            <div class="form-group"></div>
            <div class="form-group form-group-lg">
				<label class="control-label col-md-3 col-md-offset-2 col-xs-3 col-xs-offset-2 col-sm-2 col-sm-offset-3 text-right">用户名：</label>            		
                <div class="col-md-4 col-xs-6 col-sm-4">
                    <input class="form-control" type="text" id="username" placeholder="请输入用户名" name="username" />
                </div>
            </div>
            <div class="form-group"></div>
            <div class="form-group form-group-lg">
                <label class="control-label col-md-3 col-md-offset-2 col-xs-3 col-xs-offset-2 col-sm-2 col-sm-offset-3 text-right">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
                <div class="col-md-4 col-xs-6 col-sm-4">
                    <input class="form-control" type="password" id="password" placeholder="请输入密码" name="password" />
                </div>
            </div>
            <div class="form-group"></div>
            <div class="form-group">
            	<div class="col-md-3 col-md-offset-2 col-xs-4 col-xs-offset-1 col-sm-2 col-sm-offset-3">
                    <button type="button" class="btn btn-link btn-block" data-toggle="modal" data-target="#registModal">注册账号</button>
                </div>
            	<div class="col-md-2 col-xs-3 col-sm-2">
            		<input type="submit" class="btn btn-primary btn-block" value="登录" />
            	</div>
                <div class="col-md-2 col-xs-3 col-sm-2">
                    <input id="resetBtn" type="reset" class="btn btn-primary btn-block" value="重置" />
                </div>
            </div>
            <div class="form-group"></div>
            <div class="form-group"></div>
        </form>
    </div>

    <!-- 注册账号模态框begin -->
	<div class="modal fade" id="registModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">注册用户</h4>
	      </div>
	      <div class="modal-body">
	      	<form id="frmRegist" class="form-horizontal"
	      		method="post"
	      		action="${pageContext.request.contextPath}/user/regist.action">
	      		<div class="form-group">
	      			<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">登录账户：</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<input class="form-control" type="text" name="username">
	      			</div>
	      		</div>
	      		<div class="form-group">
	      			<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">登录密码：</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<input class="form-control" type="password" name="password">
	      			</div>
	      		</div>
	      		<div class="form-group">
	      			<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">确认密码：</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<input class="form-control" type="password" name="repassword">
	      			</div>
	      		</div>
	      		<div class="form-group">
	      			<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<input class="form-control" type="text" name="name">
	      			</div>
	      		</div>
	      		<div class="form-group">
			    	<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</label>
			    	<div class="col-sm-5 col-xs-6">
				    	<div class="radio">
							<label>
								<input type="radio" value="1" name="gender" checked="checked"> 男
							</label>
							&nbsp;&nbsp;&nbsp;
							<label>
								<input type="radio" value="0" name="gender"> 女
							</label>
						</div>
					</div>
			    </div>
			    <div class="form-group">
	      			<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;箱：</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<input class="form-control" type="text" name="email">
	      			</div>
	      		</div>
	      		<div class="form-group">
			    	<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;校：</label>
			    	<div class="col-sm-5 col-xs-6">
			        	<select class="form-control" name="universityId" id="universityId">
			       			<option value="">-请选择-</option>
			       			<c:forEach items="${universityList}" var="university">
			       				<option value="${university.id}">${university.name}</option>
			       			</c:forEach>
			       		</select>
			    	</div>
			    	<div class="col-sm-3 col-sm-offset-0 col-xs-4 col-xs-offset-4">
			    		<input type="button" class="btn btn-link btn-block" id="notFound" onclick="notFoundUniversity()" value="没有找到">
			    	</div>
			    </div>
			    <div class="form-group">
			    	<div class="col-sm-5 col-sm-offset-4 col-xs-6 col-xs-offset-4">
			    		<input class="form-control" type="hidden" disabled="disabled" name="university" id="university">
			    	</div>
			    	<div class="col-sm-3 col-sm-offset-0 col-xs-4 col-xs-offset-4">
			    		<input type="hidden" class="btn btn-link btn-block" id="haveFound" onclick="haveFoundUniversity()" value="重新选择">
			    	</div>
			    </div>
			    <div class="form-group">
			    	<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">个人签名：</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<textarea class="form-control" rows="3" name="info"></textarea>
	      			</div>
			    </div>
	      		<div class="form-group">
			       <div class="col-sm-6 col-sm-offset-3 col-xs-8 col-xs-offset-2">
			       	 <div class="col-sm-6 col-xs-6">
				        <input type="submit" class="btn btn-primary btn-block" value="注册" />
			       	 </div>
			       	 <div class="col-sm-6 col-xs-6">
			       	 	<input id="registResetBtn" type="reset" class="btn btn-primary btn-block" value="重置" />
			       	 </div>
			       </div>
			    </div>
	      	</form>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
    <!-- 注册账号模态框end -->


	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${pageContext.request.contextPath}/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>

