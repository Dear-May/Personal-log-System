package com.yyy.controller;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.yyy.entity.Comment;
import com.yyy.entity.Daily;
import com.yyy.entity.Friend;
import com.yyy.entity.Like;
import com.yyy.entity.User;
import com.yyy.service.CommentService;
import com.yyy.service.DailyService;
import com.yyy.service.FriendService;
import com.yyy.service.LikeService;
import com.yyy.service.UserService;
import com.yyy.service.SecurityService;
import com.yyy.utils.MD5Util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.awt.image.BufferedImage;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	@Autowired
	private DailyService dailyService;
	@Autowired
	private FriendService friendService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private LikeService likeService;
	@Autowired
	private SecurityService securityService;
	@Autowired
    private DefaultKaptcha kaptcha;
	
	//生成验证码
	 @GetMapping("/captcha")
	    public void captcha(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	        // 生成验证码文本
	        String text = kaptcha.createText();
	        
	        // 将验证码文本存储到会话中
	        session.setAttribute("captcha", text);
	        
	        // 创建验证码图片并将其写入响应流
	        BufferedImage image = kaptcha.createImage(text);
	        try (OutputStream out = response.getOutputStream()) {
	            ImageIO.write(image, "JPEG", out);
	        }
	    }
	
	//用户登入
	@RequestMapping(value = "/userlogin")
	public ResponseEntity<String> login(String usercode,
						String password, 
						String captcha,
						Model model,
						HttpSession session,
						HttpServletRequest request,
						HttpServletResponse response) {
	    
		// 从会话中获取存储的验证码
		String storedCaptcha = (String) session.getAttribute("captcha");
	    if (captcha==null||!captcha.equals(storedCaptcha)) {
	    	 String errorMessage = "1";
	         return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorMessage);
	    }
	    
	    //通过MD5加密获得的密码，并直接通过用户名和密码进行数据库搜索
		String p = MD5Util.encrypt(password);
		User user = userService.findUser(usercode, p);
		
		//如果搜索到了这个账户，就说明账号密码都正确
		if(user != null){	
			String _token = securityService.generateToken();
			userService.updateToken(usercode, _token);
			
	        // 检查是否勾选了"记住我"
	        String rememberMe = request.getParameter("remberme");
	        if (rememberMe != null && rememberMe.equals("on")) {
	        	
	            // 将用户对象添加到Cookies
	        	final int COOKIE_TTL=86400;
	            Cookie codeCookie = new Cookie("USER_CODE",user.getUser_code()); //用户ID
	            codeCookie.setMaxAge(COOKIE_TTL);
	            codeCookie.setPath("/");
	            response.addCookie(codeCookie);
	            
	            Cookie pawCookie = new Cookie("USER_PAW",_token);
	            pawCookie.setMaxAge(COOKIE_TTL);
	            pawCookie.setPath("/");
	            response.addCookie(pawCookie);
	        }
	        
	        /*
	         * CST21030 (2023/7/2)：把这里的注释打好
	         */
			// 将用户对象添加到Session
			session.setAttribute("USER_SESSION", user);
			List<Daily> dailyList = dailyService.findDailyList(user.getUser_id());
			session.setAttribute("dailyCount",dailyList.size());
			List<Friend> friendList = friendService.findFriendList(user.getUser_id());
			for(int i=0;i<friendList.size();i++) {
				List<Daily> daily = dailyService.findFriendDaily(friendList.get(i).getFriend_id());
				dailyList.addAll(daily);
				}
		        Collections.sort(dailyList, new Comparator<Daily>(){
		            public int compare(Daily d1, Daily d2) {
		            	if(d1.getDaily_id() < d2.getDaily_id()){
		                    return 1;
		                }
		                if(d1.getDaily_id() == d2.getDaily_id()){
		                    return 0;
		                }
		                return -1;
		            }
		        });
		        for(int i=0;i<dailyList.size();i++) {
		            List<Comment> comments = commentService.findComments(dailyList.get(i).getDaily_id());
		            List<Like> likes=likeService.findLikes(dailyList.get(i).getDaily_id());	
		            dailyList.get(i).setComments(comments);
		            dailyList.get(i).setLikes(likes);
		        }
		        session.setAttribute("USER_SESSION", user);// 将用户对象添加到Session
		        
		        session.setAttribute("friendCount", friendList.size());
		        
		        String successMessage = "登录成功";
		        return ResponseEntity.ok(successMessage);
		        
		}
		    String errorMessage = "2";
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorMessage);
	}
	
	//用户消息展示
	@RequestMapping(value = "/user/list")
	public String list(Model model,HttpSession session){
		//导入自己的数据
		User user = (User) session.getAttribute("USER_SESSION");
		List<User> userList = new ArrayList<>();
		userList.add(user);
		
		model.addAttribute("userList", userList);
		
		//导入自己的帖子数据
		List<Daily> dailyList = dailyService.findDailyList(user.getUser_id());
		model.addAttribute("dailyCount", dailyList.size()); //之后删掉
		
		//导入好友的账号信息数据
		List<Friend> friendList = friendService.findFriendList(user.getUser_id());	  
		model.addAttribute("friendCount", friendList.size());
		
		return "user";
	}
	
	//修改密码(通过个人信息)
	@RequestMapping(value = "/changepasswordByUser")
	@ResponseBody
	public ResponseEntity<String> changePassword(HttpSession session, HttpServletRequest request,
	        @RequestParam("currentPassword") String currentPassword,
	        @RequestParam("newPassword") String newPassword,
	        @RequestParam("confirmPassword") String confirmPassword) {

		//正常提交的密码这里不应该为空
		if (null==currentPassword || null==confirmPassword || null==newPassword) {
			String errorMessage = "非法操作";
		    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new String(errorMessage.getBytes(StandardCharsets.UTF_8), StandardCharsets.UTF_8));
		}
		
		//用户直接发送空密码（后端限制）
		if ("".equals(currentPassword) || "".equals(confirmPassword) || "".equals(newPassword)) {
			String errorMessage = "您有密码未输入，请检查";
		    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new String(errorMessage.getBytes(StandardCharsets.UTF_8), StandardCharsets.UTF_8));
		}
		
		if (!confirmPassword.equals(newPassword)) {
			String errorMessage = "新密码和确认密码不匹配";
		    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new String(errorMessage.getBytes(StandardCharsets.UTF_8), StandardCharsets.UTF_8));
		}
		User user = (User) session.getAttribute("USER_SESSION");
		String p_old = MD5Util.encrypt(currentPassword);
		String p_new = MD5Util.encrypt(newPassword);		
		User _user = userService.findUser(user.getUser_code(), p_old);
		
		if (_user == null) {
		    String errorMessage = "当前密码输入错误";
		    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new String(errorMessage.getBytes(StandardCharsets.UTF_8), StandardCharsets.UTF_8));
		}else {
			userService.changeUserPassword(user.getUser_code(), p_new);
		    String successMessage = "密码修改成功";
		    return ResponseEntity.ok(new String(successMessage.getBytes(StandardCharsets.UTF_8), StandardCharsets.UTF_8));
		}
	}
	
	//修改昵称
	@RequestMapping(value = "/updateusername")
	@ResponseBody
	public ResponseEntity<String> changeusername(HttpSession session, @RequestParam("newNickname") String newNickname){
		User user = (User) session.getAttribute("USER_SESSION");
		userService.updateUserName(user.getUser_code(),newNickname);
		return ResponseEntity.ok(newNickname);
	}
	
	//退出登录
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session,HttpServletRequest request, HttpServletResponse response) {
	    
	    session.invalidate();// 清除Session   
	    
	    // 获取当前请求的所有Cookies
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            cookie.setMaxAge(0); // 将Cookie设置为失效
	            cookie.setPath("/"); // 设置cookie的路径，确保删除的是应用程序范围内的所有Cookie
	            response.addCookie(cookie); // 添加到响应中
	        }
	    }
	    
	    return "redirect:login";// 重定向到登录页面的跳转方法
	    
	}
	
	//向用户登陆页面跳转
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String toLogin() {
	    return "login";
	}
	
	//用户未输入后缀时，在此处进行再次跳转 	CST21030(2023/7/1)
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index() {
	    return "redirect:login";
	}
}
