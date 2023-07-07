<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
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
<title>登录</title>

<link
	href="${pageContext.request.contextPath}/static/vendor/css/Style_login.css"
	rel="stylesheet">

<script
	src="${pageContext.request.contextPath}/static/vendor/js/jquery-3.4.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/static/vendor/bootstrap/js/bootstrap.min.js"></script>

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
	</script>
</head>

<body>
	<div>
		<img class="logo" src="${pageContext.request.contextPath}/static/img/logo.png" />
		<div id="errorMessage" class="alert alert-danger" style="display: none;"></div>
		<form action="${pageContext.request.contextPath}/userlogin" method="post" id="loginForm"
			 class="parent">
			<p>
				<label for="usercode" class="label_input">账 号:</label> <input
					type="text" id="usercode" placeholder="请输入账号" name="usercode"
					class="custom-input">
			</p>

			<p>
				<label for="password" class="label_input">密 码:</label> <input
					type="password" id="password" placeholder="请输入密码" name="password"
					class="custom-input">
			</p>
			
			<p>
				<label for="captcha" class="label_input">验证码:</label> <input
					type="text" id="captcha" placeholder="请输入验证码" name="captcha"
					class="custom-input" autocomplete="off" style="width: 15ch;">
				<img id="captchaImage" src="${pageContext.request.contextPath}/captcha" alt="Captcha" style="border-radius: 10px;" title="点击图片刷新验证码">	
			</p>

			<div class="remeberme">
				<input type="checkbox" name="remberme" id="remberme" checked>
				<label for="remberme">记住我</label>
			</div>
			
			<button class="login_btn" type="submit">登录</button>

			<div class="flex-container">
				<p class="text-right">
					<a onclick="forgotpwd()">忘记密码</a>
				</p>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<p class="text-primary">
					<a onclick="register()">注册新用户</a>
				</p>
			</div>

		</form>
	</div>

	<script>
      function register(){
    	  window.location.href = "<%=basePath%>register";
    	  }
      
      function forgotpwd(){
    	  window.location.href = "<%=basePath%>forgotpwd";
    	  }
</script>

	<script>
	
	$(document).ready(function() {
	    // 获取验证码图片元素
	    var captchaImage = document.getElementById("captchaImage");
	    
	    // 给验证码图片添加鼠标悬停事件监听器
	    captchaImage.addEventListener("mouseover", function() {
	        captchaImage.title = "点击图片刷新验证码";
	    });
	    
	    // 给验证码图片添加鼠标离开事件监听器
	    captchaImage.addEventListener("mouseout", function() {
	        captchaImage.title = "";
	    });
	});

	
	$(document).ready(function() {
	    // 获取验证码图片元素
	    var captchaImage = document.getElementById("captchaImage");
	    
	    // 给验证码图片添加点击事件监听器
	    captchaImage.addEventListener("click", function() {
	        // 修改图片的src属性，添加一个时间戳参数来刷新图片
	        var timestamp = new Date().getTime();
	        captchaImage.src = '<%=basePath %>captcha?' + timestamp;
	    });
	});
	
	$(document).ready(function() {
	    $("#loginForm").submit(function(event) {
	        event.preventDefault(); // 阻止表单默认提交行为
		    var usercode = $("#usercode").val();
		    var password = $("#password").val();
		    var captcha = $("#captcha").val();
		    if(usercode==""){
		    	window.alert("用户名不能为空！");
		        return false;
		    } else if (password=="") {
		    	window.alert("密码不能为空！");
		        return false;
		    }else if (captcha=="") {
		    	window.alert("验证码不能为空！");
		        return false;
		    }
	        
	        var formData = $(this).serialize(); // 获取表单数据

	        $.ajax({
	            type: 'POST',
	            url: '<%=basePath %>userlogin',
	            data: formData,
	            success: function(response) {
	                // 登录成功，重定向到主页面或其他操作
	                alert("登录成功");
                    setTimeout(function() {
                    	window.location.href = '<%=basePath %>daily/list';
                    }, 1000);
	                
	            },
	            error: function(xhr, status, error) {
	                // 处理登录失败响应
	                var errorMessage = xhr.responseText;
	                if (errorMessage == 1){
	                alert("登录失败：验证码错误");
                    setTimeout(function() {
                    	location.reload();
                    }, 1500);
	                }else if (errorMessage == 2){
	                	alert("登录失败：用户名或密码错误");
	                } 
	            }
	        });
	    });
	});
	
    // 获取当前时间
    var now = new Date();
    var hour = now.getHours();
  
    // 根据时间设置不同的壁纸
    if (hour >= 6 && hour < 12) {
        document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/morning_wallpaper.jpg')";
    } else if (hour >= 12 && hour < 18) {
        document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/afternoon_wallpaper.jpg')";
    } else {
        document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/evening_wallpaper.jpg')";
    }
</script>

</body>
</html>
