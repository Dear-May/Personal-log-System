package com.yyy.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yyy.entity.Comment;
import com.yyy.entity.Daily;
import com.yyy.entity.Friend;
import com.yyy.entity.User;
import com.yyy.service.CommentService;
import com.yyy.service.DailyService;
import com.yyy.service.FriendService;
import com.yyy.service.UserService;

@Controller
public class DailyFriendController {
    	
    @Autowired
    public FriendService friendService;
    @Autowired
    public UserService userService;
    @Autowired
    public DailyService dailyService;
    @Autowired
    private CommentService commentService;
    
    //获取当前用户的好友列表和发表的文章列表
    @RequestMapping("/dailyFriend")
    public String dailyFriend(Model model,HttpSession session) {
    	
        	User user = (User) session.getAttribute("USER_SESSION");
        	Integer owner_id = user.getUser_id();
        	List<Daily> dailyList = dailyService.findDailyList(user.getUser_id());
        	List<Friend> friendList = friendService.findFriendList(owner_id);
        	
        	for(int i=0;i<friendList.size();i++) {
        	    String username = userService.findUserName(friendList.get(i).getFriend_id());
        	    String userpicture = userService.findUserPicture(friendList.get(i).getFriend_id());
        	    friendList.get(i).setFriendName(username);
        	    friendList.get(i).setFriendPicture(userpicture);
        	}
        	model.addAttribute("friendList",friendList);
        	model.addAttribute("dailyCount", dailyList.size());
        	model.addAttribute("friendCount",friendList.size());
        	return "friends";
        	
    }
    
    //获取当前用户和指定好友的文章列表
    @RequestMapping("/dailyFriend/{friend_id}/list")
    public String friendList(Model model,HttpSession session,@PathVariable Integer friend_id) {
    	
    	User user = (User) session.getAttribute("USER_SESSION");
    	Integer owner_id = user.getUser_id();
    	List<Daily> mydailyList = dailyService.findDailyList(user.getUser_id());
    	List<Daily> dailyList = dailyService.findFriendDaily(friend_id);
    	List<Friend> friendList = friendService.findFriendList(owner_id);
    	model.addAttribute("dailyList", dailyList);
    	model.addAttribute("dailyCount", mydailyList.size());
    	model.addAttribute("friendCount",friendList.size());
    	return "friendList";
    	
    }
    
    //获取当前用户自己发布的文章列表和评论列表
    @RequestMapping("mylist")
    public String myList(Model model,HttpSession session) {
    	
    	User user = (User) session.getAttribute("USER_SESSION");
    	List<Daily> mydailyList = dailyService.findDailyList(user.getUser_id());
    	List<Friend> friendList = friendService.findFriendList(user.getUser_id());
    	for(int i=0;i<mydailyList.size();i++) {
    		List<Comment> comments = commentService.findComments(mydailyList.get(i).getDaily_id());
            mydailyList.get(i).setComments(comments);
        }
    	model.addAttribute("myList", mydailyList);
    	model.addAttribute("dailyCount", mydailyList.size());
    	model.addAttribute("friendCount",friendList.size());
    	return "friendList";
    	
    }
    
    //删除当前用户自己发布的指定文章及其相关评论
    @RequestMapping("mylist/{daily_id}/delete")
    public String deleteDaily(Model model,HttpSession session,@PathVariable Integer daily_id) {
    	
    	dailyService.deleteDaily(daily_id);
    	commentService.deleteComment(daily_id);
    	User user = (User) session.getAttribute("USER_SESSION");
    	List<Daily> mydailyList = dailyService.findDailyList(user.getUser_id());
    	List<Friend> friendList = friendService.findFriendList(user.getUser_id());
    	for(int i=0;i<mydailyList.size();i++) {
            List<Comment> comments = commentService.findComments(mydailyList.get(i).getDaily_id());
            mydailyList.get(i).setComments(comments);
        }
    	model.addAttribute("myList", mydailyList);
    	model.addAttribute("dailyCount", mydailyList.size());
    	model.addAttribute("friendCount",friendList.size());
    	return "friendList";
    	}
    
    }