package com.yyy.controller;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yyy.entity.Friend;
import com.yyy.entity.User;
import com.yyy.service.FriendService;
import com.yyy.service.UserService;


@Controller
public class FriendController {

	@Autowired
	private FriendService friendService;
	@Autowired
	private UserService userService;
	
	//查询好友
	@RequestMapping(value = "/friend/list")
	public String list(Model model,HttpSession session){
		
		List<Friend> friendList = (List<Friend>) session.getAttribute("friendList");
		List<String> userNameList = null;
		List<String> userPictureList = null;
		
		for(int i=0;i<friendList.size();i++) {
		    String username = userService.findUserName(friendList.get(i).getOwner_id());
		    String userpicture = userService.findUserName(friendList.get(i).getOwner_id());
		    userNameList.add(username);
		    userPictureList.add(userpicture);
		}
		model.addAttribute("userNameList",userNameList);
		model.addAttribute("userPictureList",userPictureList);
		return "letter";
	        
	}

	//添加好友
	@RequestMapping("/friend/add")
	@ResponseBody
	public String friendAdd(Integer id) {
		
		int rows = friendService.addUser(id);
		if(rows > 0){			
			return "OK";
			}else{
				return "FAIL";			
				}
		
		} 
	    
	//查询好友    
	@RequestMapping("/search")
	@ResponseBody
	public User searchFriend( String friend_id,Model model,HttpSession session) {
	    
	    Integer f = Integer.parseInt(friend_id);
	    String searchUserName = userService.findUserName(f);
	    String searchUserPicture = userService.findUserPicture(f);
	    
	    User user = new User();
	    user.setUser_name(searchUserName);
	    user.setDaily_picture(searchUserPicture);
	    
	    return user;
	    
	}
	
	//向指定用户发送添加好友请求
	@RequestMapping("/addFriend/{to_id}")
	@ResponseBody
	public String addFriendRequest(@PathVariable String to_id,Model model,HttpSession session) {
	    User user = (User)session.getAttribute("USER_SESSION");
	    Integer t = Integer.parseInt(to_id);
	    int rows = friendService.addFriendRequest(user.getUser_id(), t);
	    if(rows>0) {
	    	return "TRUE";
	    }
	    return "FALSE";
	    
	}
	
	//接受好友请求
	@RequestMapping("/agree")
	@ResponseBody
	public String agree(String friend_id,HttpSession session) {
	    
	    Integer f = Integer.parseInt(friend_id);
	    User user = (User) session.getAttribute("USER_SESSION");
	    int rows1 = friendService.addFriend(user.getUser_id(),f);
	    int rows2 = friendService.addFriend(f,user.getUser_id());
	    if(rows1>0&&rows2>0) {
	    	return "TRUE";
	    }
	    return "FALSE";
	    
	}
}
