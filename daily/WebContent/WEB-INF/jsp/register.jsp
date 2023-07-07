<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
<title>注册</title>

<link
	href="${pageContext.request.contextPath}/static/vendor/css/Style_register.css"
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

<script>	    
		function validatePhone(phone) {
		  	var reg = /^1[3-9]\d{9}$/;  // 匹配以 1 开头，第二位为 3~9 的 11 位数字
			return reg.test(phone);
		    }
</script>

</head>

<body>
	<div>
		<img class="logo" src="${pageContext.request.contextPath}/static/img/logo.png" />
		<form action="${pageContext.request.contextPath}/add/register" id="registerForm"
			method="post" class="parent">
			<p>
				<label for="usercode" class="label_input">&nbsp;账&nbsp;&nbsp;号:&nbsp;</label>
				<input type="text" id="usercode" placeholder="请输入账号(仅限数字)" name="usercode"
					class="custom-input" autocomplete="off"> <input
					type="hidden" id="usercodeValue" name="usercodeValue">
			</p>
			<input type="hidden" id="usercodeValue" name="usercodeValue">
			<button id="validateButton" class="val_btn">校验</button>
			
			<p>
				<label for="username" class="label_input">&nbsp;用户名:&nbsp;</label> <input
					type="text" id="username" placeholder="请输入用户名" name="username"
					class="custom-input" autocomplete="off" disabled>
			</p>
			
			<p>
				<label for="password" class="label_input">&nbsp;密&nbsp;&nbsp;码:&nbsp;</label>
				<input type="password" id="ps1" placeholder="请输入密码" name="password"
					class="custom-input" disabled>
			</p>
			
			<div class="strong">
				<p class="fl">
					<span class="hover">弱</span> <span class="">中</span> <span class="">强</span>
				</p>
			</div>
			<script>
			//获取密码输入框和密码强度提示框的元素
			var passwordInput = document.getElementById("ps1");
			var passwordStrengthElement = document.getElementById("passwordStrengthElement");
			var fl = document.getElementsByClassName("fl")[0];

			// 监听密码输入框的输入事件
			passwordInput.addEventListener("input", function() {
				var password = passwordInput.value;

				// 计算密码强度
				var strength = calculatePasswordStrength(password);

				// 根据密码强度级别设置 fl 元素的样式
				if (strength === 2) {
					  fl.className = "active";
					} else if (strength === 3) {
					  fl.className = "active1";
					} else {
					  fl.className = "";
					}
				});

			// 计算密码强度的函数
			function calculatePasswordStrength(password) {
				// 定义密码强度级别和对应的正则表达式
				var strengthLevels = [
					{ level: "弱", regex: /^(?=.*[a-z]).{0,5}$/ }, 
					{ level: "中", regex: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,10}$/ }, 
					{ level: "强", regex: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{11,}$/ },
					];
				// 根据正则表达式逐一匹配密码，确定密码的强度级别
				var strengthLevel = 0;
				for (var i = 0; i < strengthLevels.length; i++) {
					if (password.match(strengthLevels[i].regex)) {
						strengthLevel = i + 1;
						break;
						}
					}
				return strengthLevel;
				}
			</script>

			<p>
				<label for="inputPassword" class="label_input">确认密码:</label> <input
					type="password" id="ps2" placeholder="请再次输入密码" class="custom-input" disabled>
			</p>
			
			<p>
				<label for="tel" class="label_input">&nbsp;电话号:&nbsp;</label> <input
					type="text" id="tel" placeholder="请输入电话号码" name="tel"
					class="custom-input" autocomplete="off" disabled>
			</p>
			
			<p>
				<label for="captcha" class="label_input">验证码:</label> <input
					type="text" id="captcha" placeholder="请输入验证码" name="captcha"
					class="custom-input" autocomplete="off" style="width: 15ch;" disabled>
				<img id="captchaImage" src="${pageContext.request.contextPath}/captcha" alt="Captcha" style="border-radius: 10px;" title="点击图片刷新验证码">	
			</p>
			
			<button class="login_btn" type=submit>注册</button>

			<div>
				<p>
					<a onclick="login()">已有账号?返回登录</a>
				</p>
			</div>

		</form>
	</div>

	<script>
function login(){
	   window.location.href="<%=basePath %>login";
	   }
	   
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
	   $("#validateButton").click(function() {
		 event.preventDefault();
		 
	     var usercode = $("#usercode").val();
		 var numericRegex = /^[0-9]+$/;
		 if (!numericRegex.test(usercode)) {
		    	window.alert("账号只能为数字！");
		    	return false;
		    }  
	     var data = {
	       usercode: usercode
	     };

	     // 发送Ajax请求
	     $.ajax({
	       url: "<%=basePath %>valicode", 
	       type: "POST",
	       data: data,
	       success: function(response) {
	         if (response.valid) {
	        	 $("#usercode").prop("disabled", true);
	        	 $("#username").prop("disabled", false);
	        	 $("#tel").prop("disabled", false);
	        	 $("#ps1").prop("disabled", false);
	        	 $("#ps2").prop("disabled", false);
	        	 $("#captcha").prop("disabled", false);
	        	   var usercodeValue = $("#usercode").val();
	        	   // 将值存储在隐藏字段中
	        	   $("#usercodeValue").val(usercodeValue);
	        	   console.log(usercodeValue);
	         } else {
	        	 alert("该账号已存在，请重新填写");
	         }
	       },
	       error: function() {
	         alert("请求发送失败");
	       }
	     });
	   });
	 });
	 
$(document).ready(function() {
    $("#registerForm").submit(function(event) {
        event.preventDefault(); // 阻止表单默认提交行为
        
	    var usercode = $("#usercode").val();
	    var username = $("#username").val();
	    var ps1 = $("#ps1").val();
	    var ps2 = $("#ps2").val();
	    var tel = $("#tel").val();
	    var captcha = $("#captcha").val();
	    if(ps1!=ps2){
	    	window.alert("密码不一致!");
	        return false;
	    }else if (usercode=="" || username=="" || ps1=="" || ps2=="" || tel=="" || captcha==""){
	    	if (usercode==""){
		    	window.alert("ID不能为空！");
		        return false;
	    	}else if (username ==""){
		    	window.alert("用户名不能为空！");
		        return false;
	    	}else if(ps1=="" || ps2==""){
		    	window.alert("密码不能为空!");
		        return false;
	    	}else if (tel=="") {
		    	window.alert("电话号不能为空！");
		        return false;
		    }else if (captcha=="") {
		    	window.alert("验证码不能为空！");
		        return false;
		    }else if (calculatePasswordStrength(ps1)) {
	    	    window.alert("该密码太弱了，请使用更强的密码！");
	    	    return false;  	
	        }
	    }else if (!validatePhone(tel)) {
	    	  window.alert("电话号码格式不正确！");
	    	  return false;
	    }

        var formData = $(this).serialize(); // 获取表单数据

        $.ajax({
            type: 'POST',
            url: '<%=basePath %>add/register',
            data: formData,
            success: function(response) {
                // 登录成功，重定向到主页面或其他操作
                alert("注册成功");
                setTimeout(function() {
                	window.location.href = '<%=basePath %>login';
                }, 1000);
                
            },
            error: function(xhr, status, error) {
                // 处理登录失败响应
                var errorMessage = xhr.responseText;
                if (errorMessage == 1){
                alert("注册失败：验证码错误");
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
	 
</script>

	<script>
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