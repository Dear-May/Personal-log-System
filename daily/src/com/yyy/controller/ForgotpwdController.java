package com.yyy.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yyy.entity.Daily;
import com.yyy.entity.Friend;
import com.yyy.entity.User;
import com.yyy.service.DailyService;
import com.yyy.service.FriendService;
import com.yyy.service.UserService;
import com.yyy.utils.MD5Util;

@Controller
public class ForgotpwdController {

	@Autowired
    UserService userService;
    @Autowired
    DailyService dailyService;
    @Autowired
    FriendService friendService;
	
	@RequestMapping(value = "/validate", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> validate(@RequestParam("usercode") String usercode, @RequestParam("tel") String tel) {
	    // 进行校验逻辑，根据实际情况编写
		boolean isValid = validateUser(usercode, tel);

	    // 创建一个Map对象来存储校验结果
	    Map<String, Object> result = new HashMap<>();
	    result.put("valid", isValid);

	    return result;
	  }

	  // 校验逻辑，根据实际情况编写
	  private boolean validateUser(String usercode, String tel) {
		  User user=userService.findByUsercode(usercode);
		  if (user!=null) {
			  if (tel.equals(user.getTel())) {
				  return true;
			  }
		  }
		  return false;
	  }
	  
	  @RequestMapping("/chang/paw")
	  public ResponseEntity<String> register(Model model, HttpSession session, HttpServletRequest request, String usercodeValue, String password,String captcha) {
	    	
		    // 从会话中获取存储的验证码
		    String storedCaptcha = (String) request.getSession().getAttribute("captcha");
		    if ( captcha == null || !captcha.equals(storedCaptcha)) {
		    	 String errorMessage = "1";
		         return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorMessage);
		    }
	    	String p = MD5Util.encrypt(password);
	    	int rows = userService.changeUserPassword(usercodeValue,p);
	    	if(rows>0) {
	    		User user = userService.findUser(usercodeValue, p);
	    		session.setAttribute("USER_SESSION", user);
	    		List<Daily> dailyList = dailyService.findDailyList(user.getUser_id());
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
	    		model.addAttribute("dailyList",dailyList);
	    		session.setAttribute("USER_SESSION", user);	// 将用户对象添加到Session
		        String successMessage = "登录成功";
		        return ResponseEntity.ok(successMessage);
	    		}
	    	 String errorMessage = "验证码错误";
	         return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorMessage);
		}
	

	  @RequestMapping("/forgotpwd")
	  public String forgot() {
		  return "forgotpwd";
	  }
    
}
