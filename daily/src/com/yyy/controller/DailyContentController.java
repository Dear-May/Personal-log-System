package com.yyy.controller;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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


@Controller
public class DailyContentController {

	@Autowired
		private DailyService dailyService;
	@Autowired
		private UserService userService;
	@Autowired
		private FriendService friendService;
	@Autowired
		private CommentService commentService;
	@Autowired
		private LikeService likeService;
	@Autowired
		private MultimediaController Mu;

	//创建日志
	@RequestMapping("/daily/create")
		@ResponseBody
		public String dailyCreate(@RequestBody Daily daily, HttpSession session) {

		User user = (User)session.getAttribute("USER_SESSION");
		// 将当前用户id存储在公告对象中
		daily.setDaily_author(user.getUser_name());
		daily.setUser_id(user.getUser_id());
		daily.setDaily_picture(user.getDaily_picture());

		// 创建Date对象
		Date date = new Date();
		// 得到一个Timestamp格式的时间，存入mysql中的时间格式“yyyy/MM/dd HH:mm:ss”
		Timestamp timeStamp = new Timestamp(date.getTime());
		daily.setDaily_createtime(timeStamp);

		// 执行Service层中的创建方法，返回的是受影响的行数
		int rows = dailyService.createDaily(daily);
		dailyService.deleteDocument(user.getUser_id());
		if (rows > 0) {
			return "OK";
		}
		else {
			return "FAIL";
		}
	}

	//查询日志
	@RequestMapping(value = "/daily/list")
		public String list(Model model, HttpSession session) {

		User user = (User)session.getAttribute("USER_SESSION");

		//导入自己的帖子数据
		List<Daily> dailyList = dailyService.findDailyList(user.getUser_id());
		model.addAttribute("dailyCount", dailyList.size()); //之后删掉

		//导入好友的账号信息数据
		List<Friend> friendList = friendService.findFriendList(user.getUser_id());

		//导入好友的帖子数据
		for (int i = 0; i < friendList.size(); i++) {
			List<Daily> daily = dailyService.findFriendDaily(friendList.get(i).getFriend_id());
			dailyList.addAll(daily);
		}

		/*
		 * 用于对帖子进行排序，考虑删除
		 */
		Collections.sort(dailyList, new Comparator<Daily>() {
			//返回负数表示：p1 小于p2，返回0 表示：p1和p2相等，返回正数表示：p1大于p2
			public int compare(Daily d1, Daily d2) {
				//按照id序号进行升序排列
				if (d1.getDaily_id() < d2.getDaily_id()) {
					return 1;
				}
				if (d1.getDaily_id() == d2.getDaily_id()) {
					return 0;
				}
				return -1;
			}
		});

		/*
		 * 对每个帖子进行数据遍历
		 */
		for (int i = 0; i < dailyList.size(); i++) {
			List<Comment> comments = commentService.findComments(dailyList.get(i).getDaily_id());
			List<Like> likes = likeService.findLikes(dailyList.get(i).getDaily_id());
			dailyList.get(i).setComments(comments);
			dailyList.get(i).setLikes(likes);
		}
		model.addAttribute("dailyList", dailyList);
		model.addAttribute("friendCount", friendList.size());
		return "home";
	}

	//查询指定标签日志
	@RequestMapping(value = "/daily/searchtag/{tag}")
		public String list_tag(Model model, HttpSession session, @PathVariable String tag) {

		User user = (User)session.getAttribute("USER_SESSION");
		tag = "#"+tag+"#";

		//导入指定标签的帖子数据
		List<Daily> dailyList = dailyService.findDaily_tag(tag);
		model.addAttribute("dailyCount", dailyList.size()); //之后删掉	

		//导入好友的账号信息数据
		List<Friend> friendList = friendService.findFriendList(user.getUser_id());
		/*
		 * 用于对帖子进行排序，考虑删除
		 */
		Collections.sort(dailyList, new Comparator<Daily>() {
			//返回负数表示：p1 小于p2，返回0 表示：p1和p2相等，返回正数表示：p1大于p2
			public int compare(Daily d1, Daily d2) {
				//按照id序号进行升序排列
				if (d1.getDaily_id() < d2.getDaily_id()) {
					return 1;
				}
				if (d1.getDaily_id() == d2.getDaily_id()) {
					return 0;
				}
				return -1;
			}
		});

		/*
		 * 对每个帖子进行数据遍历
		 */
		for (int i = 0; i < dailyList.size(); i++) {
			List<Comment> comments = commentService.findComments(dailyList.get(i).getDaily_id());
			List<Like> likes = likeService.findLikes(dailyList.get(i).getDaily_id());
			dailyList.get(i).setComments(comments);
			dailyList.get(i).setLikes(likes);
		}
		model.addAttribute("dailyList", dailyList);
		model.addAttribute("friendCount", friendList.size());
		return "home";
	}

	//模糊查询	
    
    private static boolean checkOutsideTag(String text, String tag) {
        String pattern = "(?<!<[^>]*)" + Pattern.quote(tag) + "(?![^<]*>)";
        Pattern regex = Pattern.compile(pattern);
        Matcher matcher = regex.matcher(text);
        return matcher.find();
    }
	
	@RequestMapping(value = "/searchtext")
		public String list_text(Model model, HttpSession session, String tag) {

		User user = (User)session.getAttribute("USER_SESSION");

		//导入指定标签的帖子数据
		List<Daily> dailyList = dailyService.findDaily_tag(tag);
		List<User> userList = userService.findByUserName_tag(tag);
		ListIterator<Daily> iterator = dailyList.listIterator();
		while (iterator.hasNext()) {
		    Daily daily = iterator.next();
		    // 根据条件判断是否需要删除该元素
		    boolean containsOutsideTag = checkOutsideTag(daily.getDaily_details(), tag);
		    if (!containsOutsideTag) {
		        iterator.remove(); // 删除当前迭代器指向的元素
		    }
		}
		
		model.addAttribute("dailyCount", dailyList.size()); //之后删掉	
		model.addAttribute("userCount", userList.size());

		//导入好友的账号信息数据
		List<Friend> friendList = friendService.findFriendList(user.getUser_id());
		/*
		 * 用于对帖子进行排序，考虑删除
		 */
		Collections.sort(dailyList, new Comparator<Daily>() {
			//返回负数表示：p1 小于p2，返回0 表示：p1和p2相等，返回正数表示：p1大于p2
			public int compare(Daily d1, Daily d2) {
				//按照id序号进行升序排列
				if (d1.getDaily_id() < d2.getDaily_id()) {
					return 1;
				}
				if (d1.getDaily_id() == d2.getDaily_id()) {
					return 0;
				}
				return -1;
			}
		});

		/*
		 * 对每个帖子进行数据遍历
		 */
		for (int i = 0; i < dailyList.size(); i++) {
			List<Comment> comments = commentService.findComments(dailyList.get(i).getDaily_id());
			List<Like> likes = likeService.findLikes(dailyList.get(i).getDaily_id());
			dailyList.get(i).setComments(comments);
			dailyList.get(i).setLikes(likes);
		}
		model.addAttribute("dailyList", dailyList);
		model.addAttribute("userList", userList);
		model.addAttribute("friendCount", friendList.size());
		return "search";
	}

	//删除日志
	@RequestMapping("/daily/delete")
		@ResponseBody
		public String dailyDelete(Integer id) {

		int rows = dailyService.deleteDaily(id);
		if (rows > 0) {
			return "OK";
		}
		else {
			return "FAIL";
		}
	}

	//获取好友列表
	@RequestMapping("/notice")
		@ResponseBody
		public List<User> notice(HttpSession session) {

		User user = (User)session.getAttribute("USER_SESSION");
		List<Integer> requestList = friendService.findFriendRequest(user.getUser_id());
		List<User> userList = new ArrayList<User>();
		for (int i = 0; i < requestList.size(); i++) {
			User u = new User();
			u.setUser_name(userService.findUserName(requestList.get(i)));
			u.setUser_id(requestList.get(i));
			userList.add(u);
		}
		return userList;
	}

	//获取草稿
	@RequestMapping(value = "/getDraftContent", method = RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> getDraftContent(HttpSession session) {
		Map<String, Object> data = new HashMap<>();
		User user = (User)session.getAttribute("USER_SESSION");
		String text = dailyService.getDocument(user.getUser_id());
		data.put("content", text);
		return data;
	}

	//保存草稿
	@RequestMapping(value = "/saveDocument")
		@ResponseBody
		public ResponseEntity<String> saveDocument(HttpSession session, @RequestBody Map<String, Object> requestBody) {
		User user = (User)session.getAttribute("USER_SESSION");
		String content = (String)requestBody.get("content");
		dailyService.saveDocument(user.getUser_id(), content);

		String successMessage = "文档保存成功";
		return ResponseEntity.ok(successMessage);
	}

	//CST21045(2023/7/1)
	//获取点赞消息列表
	@RequestMapping("/likemessage")
		@ResponseBody
		public List<String> likemessage(HttpSession session) {

		User user = (User)session.getAttribute("USER_SESSION");
		List<String> messageList = likeService.findlikemessage_message(user.getUser_id());
		return messageList;
	}

	/*
	 * 标记添加好友的请求是否为已读状态
	 */
	@RequestMapping("/read")
		@ResponseBody
		public boolean read(HttpSession session) {

		User user = (User)session.getAttribute("USER_SESSION");
		List<Integer> requestList = friendService.findFriendRequest(user.getUser_id());
		List<Integer> messageList = likeService.findlikemessage_id(user.getUser_id());
		boolean friendRequestDeleted = false; //记录好友请求表删除状态
		boolean likedMessageDeleted = false; //记录点赞消息表删除状态
		if (requestList != null) {
			for (int i = 0; i < requestList.size(); i++) {
				friendService.deleteFriendRequest(requestList.get(i));
			}
			friendRequestDeleted = true;
		}
		//CST21045(2023/7/1)
		if (messageList != null) {
			for (int i = 0; i < messageList.size(); i++) {
				likeService.deletelikepost(messageList.get(i));
			}
			likedMessageDeleted = true;
		}
		return (likedMessageDeleted || friendRequestDeleted);
	}

	//添加评论
	@RequestMapping("/comment")
		@ResponseBody
		public Comment comment(HttpSession session, @Param("daily_id")String daily_id, @Param("com_detail")String com_detail) {

		User user = (User)session.getAttribute("USER_SESSION");
		Comment com = new Comment();
		Integer d = Integer.parseInt(daily_id);
		com.setDaily_id(d);
		com.setCom_detail(com_detail);
		com.setUser_id(user.getUser_id());
		com.setUser_name(user.getUser_name());
		int rows = commentService.addComment(com);
		if (rows > 0) {
			return com;
		}
		return null;
	}

	//删除日志
	@RequestMapping("daily/{daily_id}/delete")
		public String deleteDaily(Model model, HttpSession session, @PathVariable Integer daily_id) {

		User user = (User)session.getAttribute("USER_SESSION");
		if (user.getUser_id() == dailyService.findUser_id(daily_id)) {
			List<String> imgID = dailyService.findDailyimg(daily_id);
			// 检查返回结果
			if (imgID.get(0).equals("OK")) {
				// 存在<img>标签，可以使用imgInfo.get(1)获取图片的src属性值
				String imgSrc = imgID.get(1);
				boolean siy = Mu.deleteFile(imgSrc);  	//CST21030 (2023.7.5): 这里没用上，自己考虑下要不要删掉
			}
			dailyService.deleteDaily(daily_id);
			commentService.deleteComment(daily_id);
		}
		List<Daily> dailyList = dailyService.findDailyList(user.getUser_id());
		model.addAttribute("dailyCount", dailyList.size());
		List<Friend> friendList = friendService.findFriendList(user.getUser_id());

		for (int i = 0; i < friendList.size(); i++) {
			List<Daily> daily = dailyService.findFriendDaily(friendList.get(i).getFriend_id());
			dailyList.addAll(daily);
		}
		Collections.sort(dailyList, new Comparator<Daily>() {
			public int compare(Daily d1, Daily d2) {
				if (d1.getDaily_id() < d2.getDaily_id()) {
					return 1;
				}
				if (d1.getDaily_id() == d2.getDaily_id()) {
					return 0;
				}
				return -1;
			}
		});
		for (int i = 0; i < dailyList.size(); i++) {
			List<Comment> comments = commentService.findComments(dailyList.get(i).getDaily_id());
			dailyList.get(i).setComments(comments);
		}
		model.addAttribute("dailyList", dailyList);
		model.addAttribute("friendCount", friendList.size());
		return "redirect:/daily/list";
	}

	//删除日志下的评论
	@RequestMapping("daily/{daily_id}/comment/{id}/delete")
		public String deleteDailyComment(Model model, HttpSession session, @PathVariable Integer daily_id, @PathVariable Integer id) {

		User user = (User)session.getAttribute("USER_SESSION");
		boolean isAuthor = (user.getUser_id() == dailyService.findUser_id(daily_id));
		
		if (isAuthor) {
			commentService.deleteComment_one(id);
		}
		else {
			boolean isAuthor_Comment = (user.getUser_id() == commentService.findUser_id(id));
			if (isAuthor_Comment) {
				commentService.deleteComment_one(id);
			}
		}
		
		List<Daily> dailyList = dailyService.findDailyList(user.getUser_id());
		model.addAttribute("dailyCount", dailyList.size());
		List<Friend> friendList = friendService.findFriendList(user.getUser_id());

		for (int i = 0; i < friendList.size(); i++) {
			List<Daily> daily = dailyService.findFriendDaily(friendList.get(i).getFriend_id());
			dailyList.addAll(daily);
		}
		
		Collections.sort(dailyList, new Comparator<Daily>() {
			public int compare(Daily d1, Daily d2) {
				if (d1.getDaily_id() < d2.getDaily_id()) {
					return 1;
				}
				if (d1.getDaily_id() == d2.getDaily_id()) {
					return 0;
				}
				return -1;
			}
		});
		for (int i = 0; i < dailyList.size(); i++) {
			List<Comment> comments = commentService.findComments(dailyList.get(i).getDaily_id());
			dailyList.get(i).setComments(comments);
		}
		model.addAttribute("dailyList", dailyList);
		model.addAttribute("friendCount", friendList.size());
		return "redirect:/daily/list";
	}

	//更新日志内容
	@RequestMapping("daily/update")
		@ResponseBody
		public boolean updateDaily(HttpSession session, @Param("daily_id") String daily_id, @Param("daily_details") String daily_details) {

		Daily daily = new Daily();
		Integer d = Integer.parseInt(daily_id);
		daily.setDaily_id(d);
		daily.setDaily_details(daily_details);
		int rows = dailyService.updateDaily(daily);
		return rows > 0;
	}

	//增加点赞数
	@RequestMapping("daily/{daily_id}/{author_id}/updatelike")
		@ResponseBody
		public int updateLike(Model model, HttpSession session, @PathVariable("daily_id") int daily_id,
			@PathVariable("author_id") int author_id) {

		//增加点赞记录
		User user = (User)session.getAttribute("USER_SESSION");
		Like like = new Like();
		like.setDaily_id(daily_id);
		like.setAuthor_id(author_id);
		like.setUser_id(user.getUser_id());
		like.setUser_name(user.getUser_name());
		likeService.addLike(like);

		// 增加点赞数的逻辑
		dailyService.updateDaliylike(daily_id);

		// 获取更新后的点赞数
		int likeCount = dailyService.findDaliylike(daily_id);
		return likeCount;
	}

	//CST21045(2023/7/1)
	//发送点赞消息
	@RequestMapping("like/send-like-message")
		@ResponseBody
		public void sendLikeMessage(@RequestBody Map<String, Object> data) {
		int authorId = (int)data.get("author_id");
		String message = (String)data.get("message");
		likeService.addlikepost(authorId, message);
	}

	//减少点赞数
	@RequestMapping("daily/{daily_id}/{id}/deletelike")
		@ResponseBody
		public int deleteLike(Model model, HttpSession session, @PathVariable("daily_id") int daily_id,
			@PathVariable("id") int id) {

		//删除点赞记录
		likeService.deleteLike_one(id);
		// 增加点赞数的逻辑
		dailyService.deleteDailylike(daily_id);
		// 获取更新后的点赞数
		int likeCount = dailyService.findDaliylike(daily_id);
		return likeCount;
	}

}
