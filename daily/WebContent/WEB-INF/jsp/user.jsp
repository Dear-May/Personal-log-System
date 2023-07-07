<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="itheima" uri="http://itheima.com/common/"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="robots" content="noimageindex, noarchive">

<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/static/img/favicon.ico"
	type="image/x-icon">
<link rel="icon"
	href="${pageContext.request.contextPath}/static/img/favicon.ico"
	type="image/x-icon">
<title>日志</title>

<link href="<%=basePath%>static/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="<%=basePath%>static/vendor/css/style.css" rel="stylesheet" />
<link href="<%=basePath%>static/vendor/css/letter.css" rel="stylesheet" />
<link href="<%=basePath%>static/vendor/css/user.css" rel="stylesheet" />

<script src="<%=basePath%>static/vendor/css/popper.min.js"></script>
<script src="<%=basePath%>static/vendor/js/jquery-3.4.1.min.js"></script>
<script src="<%=basePath%>static/vendor/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript">
	    window.alert = function(str) {
	    const style = `
	    <style>
	    .alert-modal {
	    	position: fixed;
	        top: 50px;
	        left: 40%;
	        transform: translateX(-50%);
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        width: 300px;
	        padding: 12px;
	        background: #fff;
	        border-radius: 8px;
	        box-shadow: 0 1px 8px 0 #eee;
	        opacity: 0; /* 初始透明度为0 */
	        animation-name: fadeIn; /* 动画名称 */
	        animation-duration: 2s; /* 动画持续时间 */
	        animation-timing-function: ease-in-out; /* 动画缓动效果 */
	    }
	    	
	    /* 定义浮入动画效果 */
	    @keyframes fadeIn {
	    	0% {
	    		opacity: 0;
	    	    transform: translateY(-20px); /* 向上移动20像素 */
	    	}
	    	100% {
	    		opacity: 1;
	    	    transform: translateY(0); /* 移动到原始位置 */
	    	    }
	    	}

	    /* 定义浮出动画效果 */
	    @keyframes fadeOut {
	    	0% {
	    		opacity: 1;
	    	    transform: translateY(0); /* 移动到原始位置 */
	    	    }
	    	100% {
	    		opacity: 0;
	    	    transform: translateY(-20px); /* 向上移动20像素 */
	    	    }
	    	}
	    	
	    .alert-modal.active {
	    	top: 50px;
	        opacity: 1;
	    }
	    .alert-modal .circle {
	    	margin-right: 10px;
	        width: 20px;
	        height: 20px;
	        line-height: 20px;
	        text-align: center;
	        color: #fff;
	        background-color: #faad14;
	        border-radius: 50%;
	    }
	    .alert-modal img {
	    	margin-right: 10px;
	        width: 20px;
	        height: 20px;
	    }
	    .alert-modal .val {
	    	max-width: 200px;
	        white-space: pre-wrap;
	        word-break: break-all;
	        font-size: 14px;
	        }
	    </style>
	    `;

	    let head = document.getElementsByTagName('head')[0];
	    // 将自定义 alert 的样式插入 head 中
	    head.innerHTML += style;

	    let content = document.createElement("div");
	    let strHtml;
	    strHtml = "<div class=\"alert-modal fadeIn\" id=\"alertModal\">"; // 添加fadeIn类名
	    strHtml += "<div class=\"circle\">!</div>";
	    strHtml += "<div class=\"val\">"+ str +"</div>";
	    strHtml += "</div>";
	    content.innerHTML = strHtml;
	    document.body.appendChild(content);
	    // 关闭弹窗
	    setTimeout(function () {
	    	content.classList.remove('fadeIn'); // 移除fadeIn类名
	    	content.classList.add('fadeOut'); // 添加fadeOut类名
	    	setTimeout(function () {
	    		content.remove();
	    		}, 500)
	    	}, 2000); // 2秒后执行浮出动画效果
	    	}
	    
  		function searchcheck(){
		    var tag = $("#tag").val();
		    if(tag == ""){
		    	alert("请输入搜索内容！");
		        return false;
		    }
		    return true;
		}
	    
  		function mycheck(){
		    var currentPassword = $("#currentPassword").val();
		    var newPassword = $("#newPassword").val();
		    var confirmPassword = $("#confirmPassword").val();
		    if (currentPassword == newPassword){
		    	window.alert("新密码与当前密码相同，请重新修改");
		        return false;
		    }else if(newPassword != confirmPassword){
		    	window.alert("新密码与确认密码不一致，请重新修改");
		        return false;
		    }
		    return true;
		}
  		
	</script>

<style>
pre {
	white-space: pre-wrap; /* css-3 */
	white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
	white-space: -pre-wrap; /* Opera 4-6 */
	white-space: -o-pre-wrap; /* Opera 7 */
	word-wrap: break-word; /* Internet Explorer 5.5+ */
	font-family: "微软雅黑";
	font-size: 15px;
}
</style>
</head>

<body>
	<nav class="navbar navbar-expand-lg transparent-navbar">
		<a class="navbar-brand" href="#"> <img
			src="${pageContext.request.contextPath}/static/img/logo_home.png"
			alt="Logo" class="logo-img">
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarColor03" aria-controls="navbarColor03"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse m-auto" id="navbarColor03">
			<ul class="navbar-nav m-auto">
				<li class="nav-item active"><a class="nav-link"
					href="${pageContext.request.contextPath}/daily/list"><button
							class="btn btn-outline-success">
							&nbsp; <span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link" href="#"><button
							class="btn btn-outline-success active">
							&nbsp; <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link" href="#"><button
							class="btn btn-outline-success" type="button" id="comment1">
							&nbsp; <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath }/letter/list"><button
							class="btn btn-outline-success">
							&nbsp; <span class="glyphicon glyphicon-envelope"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath }/logout"><button
							class="btn btn-outline-success">
							&nbsp; <span class="glyphicon glyphicon-log-out"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
			</ul>
			<form class="form-inline m-auto"
				action="${pageContext.request.contextPath}/searchtext" method="post"
				onsubmit="return searchcheck()">
				<input class="form-control mr-sm-2" type="text" name="tag"
					placeholder="搜索一下" id="tag">
				<button class="btn btn-success" type="submit" data-toggle="modal"
					data-target="#search">搜索</button>
			</form>
		</div>
	</nav>

	<div class="commentPopup themeColor" id="commentPopup" tabindex='-1'
		style="background-color: rgba(240, 255, 255, 0.8);"></div>

	<div class="container">
		<div class="row">
			<div class="col-lg-4" style="margin-top: 7px">
				<div class="row">
					<div class="row m-auto bg"
						style="width:380px;height:110px;background: url('<%=basePath%>static/img/background.jpg')">
						<img class="headPicture"
							src="${pageContext.request.contextPath}/static/img/${USER_SESSION.daily_picture}" />
					</div>

					<div class="container-fluid bordeShadow">
						<div class="row" style="margin-top: 20px; margin-bottom: 20px">
							<div class="col-lg-4 m-auto hand" onclick="mylist()">
								<div class="row m-auto">
									<span>博客</span>
								</div>
								<span class="text-center">${dailyCount }</span>
							</div>

							<div class="col-lg-4 m-auto hand" onclick="dailyfriend()">
								<div class="row m-auto">好友</div>
								<span class="text-center">${friendCount}</span>
							</div>
							<div class="col-lg-4 m-auto hand">
								<div class="row m-auto">访问记录</div>
								<span class="text-center">3</span>
							</div>
						</div>
					</div>

				</div>
			</div>


			<div class="col-lg-8" style="margin-top: 7px;" id="basicinfo">
				<c:forEach items="${userList}" var="user">
					<div class="message themeColor rounded-top">
						<div id="basicinfotext">
							<p>基本信息</p>
						</div>
						<hr>
						<div class="avatar-container">
							<p>头像</p>
							<img class="middleHeadPicture"
								src="<%=basePath %>static/img/${user.daily_picture}" /><br>
							<button onclick="openModal()">修改头像</button>
						</div>

						<div class="modal-overlay" id="modalOverlay"
							style="display: none;">
							<div class="modal-content">
								<div class="modal-header">
									<h3>修改头像</h3>
									<span class="modal-close" onclick="closeModal()">&times;</span>
								</div>
								<div class="modal-body">
									<p>选择新的头像：</p>
									<div class="avatar-container">
										<div class="avatar" id="preview">
											<img src="<%=basePath %>static/img/${user.daily_picture}"
												alt="Current Avatar" />
										</div>
										<br>
										<button class="btn btn-outline-success active "
											onclick="triggerFileInput()">
											<span class="glyphicon glyphicon-circle-arrow-up"
												id="uploadIcon">上传图像</span>
										</button>
										<input type="file" id="mediaFileInput"
											accept="image/*, video/*" style="display: none;">
									</div>
								</div>
								<div class="modal-footer">
									<button onclick="uploadAvatar()">保存</button>
								</div>
							</div>
						</div>

						<hr>
						<div class="col-lg-11">
							<p>用户号：&nbsp;&nbsp;&nbsp;${user.user_code}</p>
							<hr>
							<div class="nickname-container">
								<p>
									昵称：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong id="nickname">${user.user_name}</strong>
									<button id="edit-nickname-button" class="edit-nickname-button"
										onclick="toggleNicknameEdit()">修改昵称</button>
								</p>
							</div>
							<div id="nickname-edit-container" class="nickname-edit-container"
								style="display: none">
								<input type="text" id="nickname-input" value="${user.user_name}">
								<button id="confirm-edit-button" onclick="confirmNicknameEdit()">确认修改</button>
								<button id="cancel-edit-button" onclick="cancelNicknameEdit()">取消修改</button>
							</div>

							<hr>
							<p>手机号：${user.tel.substring(0, 3)}***${user.tel.substring(user.tel.length() - 3)}</p>
						</div>
					</div>
				</c:forEach>

				<c:forEach items="${userList}" var="user">
					<div class="message themeColor rounded-top">
						<div id="basicinfotext">
							<p>账号安全</p>
						</div>
						<hr>
						<form id="changePasswordForm"
							action="${pageContext.request.contextPath}/changepasswordByUser"
							method="post" onsubmit="return mycheck()">
							<div class="form-group">
								<label for="currentPassword">当前密码</label> <input type="password"
									id="currentPassword" name="currentPassword"
									class="form-control" required>
							</div>
							<div class="form-group">
								<label for="newPassword">新密码</label> <input type="password"
									id="newPassword" name="newPassword" class="form-control"
									required>
							</div>
							<div class="form-group">
								<label for="confirmPassword">确认密码</label> <input type="password"
									id="confirmPassword" name="confirmPassword"
									class="form-control" required>
							</div>
							<div class="form-group">
								<button type="submit" class="btn btn-primary">确认修改</button>
							</div>
						</form>

					</div>
				</c:forEach>

			</div>

		</div>
	</div>


	<script>	
	 var selectedFile = null; // 用于保存用户选择的文件数据
	 
		$(document).ready(function() {
			$('#commentPopup').hide();
		});
		$('#comment1').focus(function() {
			$('#commentPopup').show();
			$('#commentPopup').focus();
		});
		$('#commentPopup').blur(function() {
			$.ajax({
				type : "get",
				url : "<%=basePath%>read",
	        	dataType:"json",
	        	success : function(data){
	        	        	$("#commentPopup").html("");
	        	        	$("#send_number").html("");
	        	        	$('#commentPopup').hide();
	        	        },
	        	        error : function(){
	        	        }
	        	    })
              });
              
		window.onload = function() {
        	  var noticePromise = getNotice();
        	  var likeMessagePromise = getLikeMessage();

        	  Promise.all([noticePromise, likeMessagePromise])
        	    .then(function(results) {
        	      var noticeData = results[0];
        	      var likeMessageData = results[1];

        	      notice(noticeData);
        	      likemessage(likeMessageData);
        	    })
        	    .catch(function(error) {
        	      console.error(error);
        	    });
        	};
        	
        	function getNotice() {
        		  return new Promise(function(resolve, reject) {
        		    $.ajax({
        		      type: "get",
        		      url: "<%=basePath%>notice",
        		      dataType: "json",
        		      success: function(data) {
        		        resolve(data);
        		      },
        		      error: function() {
        		        reject(new Error("Failed to get notice data."));
        		      }
        		    });
        		  });
        		}
        	
        function notice(data){
        	var i;
      	var html = "";
      	if(data.length!=0)
      		$("#send_number").html(data.length);
      	for(i=0;i<data.length;i++){
      		var msg = data[i].user_id;
      		html += `<div class=""><span class="text-info hand">`+data[i].user_name+`</span><span>&nbsp;&nbsp;请求添加好友&nbsp;&nbsp;</span><span href="#" class="text-info hand" onclick=agree(`+msg+`)>同意</span><span style="display:none">`+data[i].user_id+`</span></div>`;
      	}
      	$("#commentPopup").html(html);
        }
        
        function agree(friend_id){
      	  $.ajax({
      		  type : "post",
      		  url : "<%=basePath%>agree",
      		  dataType:"json",
      		  data: {"friend_id":friend_id},
      		  success : function(data){       			  
      		  },
      		  error : function(){
      			  
      		  }
      		  })
      		  }
        
        <!-- 点赞消息区功能 -->
        function getLikeMessage() {
        	  return new Promise(function(resolve, reject) {
        	    $.ajax({
        	      type: "get",
        	      url: "<%=basePath%>likemessage",
        	      dataType: "json",
        	      success: function(data) {
        	        resolve(data);
        	      },
        	      error: function() {
        	        reject(new Error("Failed to get like message data."));
        	      }
        	    });
        	  });
        	}
        
        function likemessage(data){
        	var i;
        	var html = $("#commentPopup").html() || "";
	        	if(data.length!=0)
	        		$("#send_number").html(data.length);
	        	for(i=0;i<data.length;i++){
	        		html += `<div class=""><span class="text-info hand">`+data[i]+`</span></div>`;
	        	}
	        	$("#commentPopup").html(html);
        }  	
		
        function dailyfriend(){
        	window.location.href = "<%=basePath %>dailyFriend";
        	}
              
        //修改头像
        function openModal() {
        	document.getElementById('modalOverlay').style.display = 'flex';
        	}

        function closeModal() {
        	document.getElementById('modalOverlay').style.display = 'none';
        	}
              
        //多媒体文件上传
        function triggerFileInput() {
        	document.getElementById('mediaFileInput').click();
        	}
		        
        // 监听文件选择框的change事件
        document.getElementById('mediaFileInput').addEventListener('change', handleFileSelect, false);

        function handleFileSelect(event) {
        	var file = event.target.files[0];
        	
        	// 根据文件类型和大小进行限制
        	if (file.type.startsWith('image/') && file.size > 5 * 1024 * 1024) {
        		window.alert('图片文件大小不能超过5MB');
        		return;
        		}
		        	  
        	selectedFile = file; // 保存用户选择的文件

        	// 创建文件预览图
        	var reader = new FileReader();
        	reader.onload = function(event) {
		        		  
        		var preview = document.getElementById('preview');
        		preview.innerHTML = '';
        		var img = document.createElement('img');
        		img.src = event.target.result;
        		img.style.width = '120px'; // 设置正方形的尺寸
        		img.style.height = '120px';
        		preview.appendChild(img);
		             
        	};

        	reader.readAsDataURL(file);
        	}
		        
        //修改头像
        function uploadAvatar(){
        	if (selectedFile) {
        		// 创建文件上传表单数据
        		var formData = new FormData();
        		formData.append('file', selectedFile);
        		
        		// 发送文件到后端
        		$.ajax({
        			type: 'post',
        			url: '<%=basePath%>user-avatar/upload',
        			data: formData,
        			processData: false,
        			contentType: false,
        			success: function(response) {
        				alert("头像修改成功");
        				var fileUrl = response;  // 获取fileUrl的值
        				console.log(fileUrl);
        				location.reload();
        				},
        				error: function(error) {
        					alert('文件上传失败');
        					}
        				});
        		} else {
        			window.alert("请上传图像！")
        			return
        			}
        	}
		        
        //修改昵称
        function toggleNicknameEdit() {
        	var nicknameElement = document.getElementById('nickname');
        	var nicknameEditContainer = document.getElementById('nickname-edit-container');
        	var nicknameInput = document.getElementById('nickname-input');
        	var nicknameButton = document.getElementById('edit-nickname-button');
        	var confirmEditButton = document.getElementById('confirm-edit-button');
        	var cancelEditButton = document.getElementById('cancel-edit-button');    


        	if (nicknameEditContainer.classList.contains('fade-out')) {
        		// 切换回显示模式
        		nicknameElement.style.display = 'inline';
        		nicknameButton.style.display = 'inline';
        		nicknameEditContainer.classList.remove('fade-out');		        		
        		} else {
        			// 切换到编辑模式
        			nicknameElement.style.display = 'none';
        			nicknameButton.style.display = 'none';
        			nicknameEditContainer.style.display = 'block';
        			nicknameInput.focus();
        			nicknameInput.select();
        			confirmEditButton.innerText = '确认修改';
        			cancelEditButton.innerText = '取消修改';     
        			}
        	}

        function confirmNicknameEdit() {
        	var nicknameElement = document.getElementById('nickname');
        	var nicknameInput = document.getElementById('nickname-input');
        	var confirmEditButton = document.getElementById('confirm-edit-button');
        	var cancelEditButton = document.getElementById('cancel-edit-button');
		        	
        	// 获取修改后的昵称
        	var newNickname = nicknameInput.value;
        	if (newNickname == ""){
        		window.alert("昵称不能为空！");
        		return
        		}
        	var pattern = /<[a-z][\s\S]*>/i;
        	var containsHtmlTag = pattern.test(newNickname);
        	if (containsHtmlTag) {
        		alert("文本包含HTML标签,不允许发送");
        		return
        		}
        	$.ajax({
        		type: 'post',
        		url: '<%=basePath%>updateusername',
        		data: { newNickname: newNickname },
        		success: function(response) {
        			alert("昵称修改成功");
        			var nicknameElement = document.getElementById('nickname');
        			var nicknameInput = document.getElementById('nickname-input');
        			var confirmEditButton = document.getElementById('confirm-edit-button');
        			var cancelEditButton = document.getElementById('cancel-edit-button');
		        			
        			// 更新页面上的昵称显示
        			nicknameElement.innerText = response;
        			
        			// 切换回显示模式
        			toggleNicknameEdit();
        			},
        			error: function(error) {
        				alert('昵称修改失败');
        				}
        			});
        	}

        function cancelNicknameEdit() {
        	var nicknameElement = document.getElementById('nickname');
        	var nicknameEditContainer = document.getElementById('nickname-edit-container');
        	var nicknameButton = document.getElementById('edit-nickname-button');
		        	
        	// 切换回显示模式
        	nicknameElement.style.display = 'inline';
        	nicknameButton.style.display = 'inline';
        	nicknameEditContainer.classList.add('fade-out');		        	
        	
        	setTimeout(function() {        	
        		nicknameEditContainer.style.display = 'none';
        		nicknameEditContainer.classList.remove('fade-out');
        		}, 300);
        	}
	            
        //修改密码提示
        $('#changePasswordForm').submit(function(event) {
        	event.preventDefault(); // 阻止表单的默认提交行为

        	// 获取表单数据
        	var currentPassword = $('#currentPassword').val();
        	var newPassword = $('#newPassword').val();
        	var confirmPassword = $('#confirmPassword').val();
        	
        	if  (currentPassword == newPassword){
        		window.alert("新密码与当前密码相同，请重新填写");
        		return
        	}else if (newPassword != confirmPassword ){
        		window.alert("新密码与确认密码不相同，请重新填写");
        		return
        	}

        	// 发送 AJAX 请求
        	$.ajax({
        		type: 'post',
        		url: '<%=basePath%>changepasswordByUser',
        		data: {
        			currentPassword: currentPassword,
        			newPassword: newPassword,
        			confirmPassword: confirmPassword
        			},
        			dataType: 'text',
        			success: function(response) {
        				// 处理成功响应
        				window.alert("密码修改成功");
        				setTimeout(function() {
        					login(); 
        					}, 2000);
        				},
        				error: function(xhr, status, error) {
        					// 处理错误响应
        					var errorMessage = xhr.responseText;
        					window.alert("当前密码不正确，请重新填写");
        					}
        				});
        	});
		        
        function login(){
        	window.location.href = "<%=basePath%>logout";
        	}
        // 获取当前时间
        var now = new Date();
        var hour = now.getHours();
			  
        // 根据时间设置不同的壁纸
        if (hour >= 6 && hour < 12) {
        	document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/morning_home_wallpaper.jpg')";
        	} else if (hour >= 12 && hour < 18) {
			        	document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/afternoon_home_wallpaper.jpg')";
			        	} else {
			        		document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/evening_home_wallpaper.jpg')";
			        		}
			    
        </script>
</body>
</html>