package com.yyy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.yyy.entity.Friend;
import com.yyy.entity.Message;
import com.yyy.entity.User;
import com.yyy.service.FriendService;
import com.yyy.service.MessageService;
import com.yyy.service.UserService;

@Controller
public class LetterController {
	
    @Autowired
    private FriendService friendService;
    @Autowired
    private UserService userService;
    @Autowired
    private MessageService messageService;
    
    //获取当前用户好友列表信息
    @RequestMapping("/letter/list")
    public String letter(Model model,HttpSession session) {
    	
    	User user = (User) session.getAttribute("USER_SESSION");
    	Integer owner_id = user.getUser_id();
    	List<Friend> friendList = friendService.findFriendList(owner_id);
    	
    	for(int i=0;i<friendList.size();i++) {
    		String username = userService.findUserName(friendList.get(i).getFriend_id());
    		String userpicture = userService.findUserPicture(friendList.get(i).getFriend_id());
    		friendList.get(i).setFriendName(username);
    		friendList.get(i).setFriendPicture(userpicture);
    		}
    	model.addAttribute("friendList",friendList);
    	return "letter";
    	
    	}
    
    //获取当前用户与指定好友之间的私信信息
    @RequestMapping("/letter/{sendto}/message")
    public String message(Model model,HttpSession session,@PathVariable Integer sendto){
    	
    	User user = (User) session.getAttribute("USER_SESSION");
    	Integer owner_id = user.getUser_id();
    	List<Friend> friendList = friendService.findFriendList(owner_id);
    	
    	for(int i=0;i<friendList.size();i++) {
    		String username = userService.findUserName(friendList.get(i).getFriend_id());
    		String userpicture = userService.findUserPicture(friendList.get(i).getFriend_id());
    		friendList.get(i).setFriendName(username);
    		friendList.get(i).setFriendPicture(userpicture);
    		}
    	String friendPicture = userService.findUserPicture(sendto);
    	model.addAttribute("friendPicture",friendPicture);
        model.addAttribute("friendList",friendList);
        List<Message> messages = messageService.findMessages(owner_id,sendto);
        model.addAttribute("messages",messages);
        model.addAttribute("sendto",sendto);
        return "letter";
        
        }
   
}
