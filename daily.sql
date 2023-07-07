/*
Navicat MySQL Data Transfer

Source Server         : CST21045
Source Server Version : 50505
Source Host           : 192.168.200.1:3306
Source Database       : daily

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2023-07-06 16:52:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for addfriend
-- ----------------------------
DROP TABLE IF EXISTS `addfriend`;
CREATE TABLE `addfriend` (
  `from_id` int(11) NOT NULL,
  `to_id` int(11) DEFAULT NULL,
  `agree` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of addfriend
-- ----------------------------

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_id` int(11) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `com_detail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES ('24', '49', 'May', '1', '哈哈哈');
INSERT INTO `comments` VALUES ('25', '49', 'May', '1', '说得很好');
INSERT INTO `comments` VALUES ('28', '1', '月月', '11', '牛啊');
INSERT INTO `comments` VALUES ('36', '3', '胡言乱语', '2', '555好热');
INSERT INTO `comments` VALUES ('43', '63', 'May', '1', '6');
INSERT INTO `comments` VALUES ('51', '6', 'May', '1', 'sb');

-- ----------------------------
-- Table structure for draft
-- ----------------------------
DROP TABLE IF EXISTS `draft`;
CREATE TABLE `draft` (
  `author_id` int(11) NOT NULL,
  `draft` text DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of draft
-- ----------------------------
INSERT INTO `draft` VALUES ('1', null);
INSERT INTO `draft` VALUES ('2', null);
INSERT INTO `draft` VALUES ('3', null);
INSERT INTO `draft` VALUES ('4', null);
INSERT INTO `draft` VALUES ('5', null);
INSERT INTO `draft` VALUES ('6', null);
INSERT INTO `draft` VALUES ('7', null);
INSERT INTO `draft` VALUES ('8', null);
INSERT INTO `draft` VALUES ('9', null);
INSERT INTO `draft` VALUES ('10', null);
INSERT INTO `draft` VALUES ('11', null);
INSERT INTO `draft` VALUES ('12', null);

-- ----------------------------
-- Table structure for friends
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `owner_id` int(11) NOT NULL,
  `friend_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of friends
-- ----------------------------
INSERT INTO `friends` VALUES ('1', '2');
INSERT INTO `friends` VALUES ('1', '4');
INSERT INTO `friends` VALUES ('1', '5');
INSERT INTO `friends` VALUES ('1', '6');
INSERT INTO `friends` VALUES ('1', '7');
INSERT INTO `friends` VALUES ('1', '8');
INSERT INTO `friends` VALUES ('2', '1');
INSERT INTO `friends` VALUES ('1', '3');
INSERT INTO `friends` VALUES ('4', '1');
INSERT INTO `friends` VALUES ('5', '1');
INSERT INTO `friends` VALUES ('6', '1');
INSERT INTO `friends` VALUES ('7', '1');
INSERT INTO `friends` VALUES ('8', '1');
INSERT INTO `friends` VALUES ('3', '1');
INSERT INTO `friends` VALUES ('11', '1');
INSERT INTO `friends` VALUES ('3', '2');
INSERT INTO `friends` VALUES ('2', '3');
INSERT INTO `friends` VALUES ('12', '1');
INSERT INTO `friends` VALUES ('1', '12');

-- ----------------------------
-- Table structure for like_message
-- ----------------------------
DROP TABLE IF EXISTS `like_message`;
CREATE TABLE `like_message` (
  `author_id` int(11) NOT NULL,
  `message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of like_message
-- ----------------------------
INSERT INTO `like_message` VALUES ('15', '用户<a href=\"http://localhost:8080/daily/dailyFriend/1/list\">May</a> 点赞了您的 6666...');
INSERT INTO `like_message` VALUES ('7', '用户<a href=\"http://localhost:8080/daily/dailyFriend/1/list\">May</a> 点赞了您的 很喜欢星铁玩家的一句...');
INSERT INTO `like_message` VALUES ('2', '用户<a href=\"http://localhost:8080/daily/dailyFriend/1/list\">May</a> 点赞了您的 Java Web好难...');

-- ----------------------------
-- Table structure for liketable
-- ----------------------------
DROP TABLE IF EXISTS `liketable`;
CREATE TABLE `liketable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of liketable
-- ----------------------------
INSERT INTO `liketable` VALUES ('58', '64', '1', '2', '胡言乱语');
INSERT INTO `liketable` VALUES ('59', '2', '2', '2', '胡言乱语');
INSERT INTO `liketable` VALUES ('79', '63', '1', '1', 'May');
INSERT INTO `liketable` VALUES ('97', '64', '1', '1', 'May');
INSERT INTO `liketable` VALUES ('129', '136', '1', '1', 'May');

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `sender` int(11) DEFAULT NULL,
  `receiver` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `sendto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of messages
-- ----------------------------
INSERT INTO `messages` VALUES ('2', '1', '2', '今天一起吃午饭吗', '2019-06-24 20:46:53', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '今天一起吃午饭吗', '2019-06-24 20:46:53', '2');
INSERT INTO `messages` VALUES ('1', '2', '1', '好的，什么时候？', '2019-06-24 20:47:34', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '好的，什么时候？', '2019-06-24 20:47:34', '1');
INSERT INTO `messages` VALUES ('2', '1', '2', '大概11点30可以吗？', '2019-06-24 20:49:46', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '大概11点30可以吗？', '2019-06-24 20:49:46', '2');
INSERT INTO `messages` VALUES ('1', '2', '1', '可以', '2019-06-24 20:50:22', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '可以', '2019-06-24 20:50:22', '1');
INSERT INTO `messages` VALUES ('1', '2', '1', '我们今天去黄焖鸡吧，好久没吃了。', '2019-06-24 20:50:52', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '我们今天去黄焖鸡吧，好久没吃了。', '2019-06-24 20:50:52', '1');
INSERT INTO `messages` VALUES ('2', '1', '2', '嗯，行。', '2019-06-24 20:52:06', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '嗯，行。', '2019-06-24 20:52:06', '2');
INSERT INTO `messages` VALUES ('2', '1', '2', '我到了，你来了吗？', '2019-06-24 20:52:18', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '我到了，你来了吗？', '2019-06-24 20:52:18', '2');
INSERT INTO `messages` VALUES ('2', '1', '2', '人呢？？？', '2019-06-24 20:52:27', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '人呢？？？', '2019-06-24 20:52:27', '2');
INSERT INTO `messages` VALUES ('2', '1', '2', '。。。。。', '2019-06-24 20:52:38', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '。。。。。', '2019-06-24 20:52:38', '2');
INSERT INTO `messages` VALUES ('2', '1', '2', '我先点了', '2019-06-24 20:52:49', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '我先点了', '2019-06-24 20:52:49', '2');
INSERT INTO `messages` VALUES ('2', '1', '2', '你还不来吗？电话也不 接，我都吃完了。', '2019-06-24 20:53:06', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '你还不来吗？电话也不 接，我都吃完了。', '2019-06-24 20:53:06', '2');
INSERT INTO `messages` VALUES ('1', '2', '1', '啊啊啊啊，抱歉，忽然有些事情', '2019-06-24 20:53:45', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '啊啊啊啊，抱歉，忽然有些事情', '2019-06-24 20:53:45', '1');
INSERT INTO `messages` VALUES ('1', '2', '1', '下次再一起吃吧', '2019-06-24 20:53:56', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '下次再一起吃吧', '2019-06-24 20:53:56', '1');
INSERT INTO `messages` VALUES ('2', '1', '2', '嗯，行', '2019-06-24 20:54:24', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '嗯，行', '2019-06-24 20:54:24', '2');
INSERT INTO `messages` VALUES ('2', '1', '2', '我先看书了', '2019-06-24 20:54:32', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '我先看书了', '2019-06-24 20:54:32', '2');
INSERT INTO `messages` VALUES ('1', '2', '1', '好的', '2019-06-24 20:54:54', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '好的', '2019-06-24 20:54:54', '1');
INSERT INTO `messages` VALUES ('1', '2', '1', 'suibian', '2019-06-25 10:57:15', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', 'suibian', '2019-06-25 10:57:15', '1');
INSERT INTO `messages` VALUES ('11', '1', '11', '您好！', '2023-05-21 14:50:47', '1');
INSERT INTO `messages` VALUES ('11', '1', '1', '您好！', '2023-05-21 14:50:47', '11');
INSERT INTO `messages` VALUES ('2', '1', '2', '在干嘛呢', '2023-05-21 20:51:36', '1');
INSERT INTO `messages` VALUES ('2', '1', '1', '在干嘛呢', '2023-05-21 20:51:36', '2');
INSERT INTO `messages` VALUES ('1', '2', '1', '我在吃饭', '2023-05-21 20:51:59', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '我在吃饭', '2023-05-21 20:51:59', '1');
INSERT INTO `messages` VALUES ('3', '2', '3', '你好', '2023-05-21 20:53:31', '2');
INSERT INTO `messages` VALUES ('3', '2', '2', '你好', '2023-05-21 20:53:31', '3');
INSERT INTO `messages` VALUES ('12', '1', '12', '您好', '2023-05-25 10:53:56', '1');
INSERT INTO `messages` VALUES ('12', '1', '1', '您好', '2023-05-25 10:53:56', '12');
INSERT INTO `messages` VALUES ('1', '12', '1', 'nianhao', '2023-05-25 11:31:46', '12');
INSERT INTO `messages` VALUES ('1', '12', '12', 'nianhao', '2023-05-25 11:31:46', '1');
INSERT INTO `messages` VALUES ('1', '2', '1', '55555555555', '2023-05-28 14:11:24', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '55555555555', '2023-05-28 14:11:24', '1');
INSERT INTO `messages` VALUES ('1', '2', '1', '在干嘛', '2023-05-28 14:11:40', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '在干嘛', '2023-05-28 14:11:40', '1');
INSERT INTO `messages` VALUES ('3', '1', '3', 'test', '2023-05-28 14:13:05', '1');
INSERT INTO `messages` VALUES ('3', '1', '1', 'test', '2023-05-28 14:13:05', '3');
INSERT INTO `messages` VALUES ('1', '12', '1', 'test', '2023-05-28 14:15:11', '12');
INSERT INTO `messages` VALUES ('1', '12', '12', 'test', '2023-05-28 14:15:11', '1');
INSERT INTO `messages` VALUES ('1', '12', '1', '你好', '2023-05-29 20:49:34', '12');
INSERT INTO `messages` VALUES ('1', '12', '12', '你好', '2023-05-29 20:49:34', '1');
INSERT INTO `messages` VALUES ('1', '12', '1', '1', '2023-06-01 17:54:34', '12');
INSERT INTO `messages` VALUES ('1', '12', '12', '1', '2023-06-01 17:54:34', '1');
INSERT INTO `messages` VALUES ('1', '2', '1', '', '2023-07-05 10:34:16', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '', '2023-07-05 10:34:16', '1');
INSERT INTO `messages` VALUES ('1', '2', '1', '66666', '2023-07-06 08:25:56', '2');
INSERT INTO `messages` VALUES ('1', '2', '2', '66666', '2023-07-06 08:25:56', '1');

-- ----------------------------
-- Table structure for rizhi
-- ----------------------------
DROP TABLE IF EXISTS `rizhi`;
CREATE TABLE `rizhi` (
  `daily_id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_author` varchar(255) DEFAULT NULL,
  `daily_details` text DEFAULT NULL,
  `daily_createtime` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `daily_picture` varchar(255) DEFAULT NULL,
  `privacy` varchar(11) DEFAULT NULL,
  `likeCount` int(11) DEFAULT 0,
  PRIMARY KEY (`daily_id`) USING BTREE,
  KEY `daily_picture_auto_update` (`daily_picture`),
  CONSTRAINT `daily_picture_auto_update` FOREIGN KEY (`daily_picture`) REFERENCES `user` (`daily_picture`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rizhi
-- ----------------------------
INSERT INTO `rizhi` VALUES ('1', 'May', '今天也去写数据库了\n', '2023-05-12 20:17:11', '1', '68b8fb0e-4fb2-4a1d-a800-830ea773278d.jpg', '0', '0');
INSERT INTO `rizhi` VALUES ('2', '胡言乱语', '本皇女既已收到了你赠予的无上至宝，便也有东西要给你。\r\n我之眷属，奥兹！将祝圣之人引至我座前！\r\n流落世间的旅者啊，我在此解除「断罪之眼」的封印，在漆黑夜幕与亘古月光的见证下，赐予你幽夜羽翼的庇护！\r\n今后便许你常伴吾之左右，与本皇女一同见证三千宇宙命运的尽头吧！', '2023-05-13 00:00:00', '2', 'user2.jpg', '1', '1');
INSERT INTO `rizhi` VALUES ('3', '逍遥居士', '夏天到了 大家注意用电安全\r\n别像我一样 差点被烤熟', '2023-05-14 20:27:11', '3', 'user3.jpg', '0', '0');
INSERT INTO `rizhi` VALUES ('6', '宏桑', '这是一张50年前的照片。\r\n\r\n基辛格百岁诞辰，很多人表示祝贺，中国新任驻美大使谢峰专程前往带去中国老朋友的祝福。\r\n基辛格在接受经济学人采访的时候，谈到一段台湾问题，他回忆说，中美会谈，别的事儿，主席都让我去与总理谈。\r\n\r\n谈到台湾时，他非常明确：‘他们（台湾）是一批反革命分子……我们可以暂时不要台湾，再过一百年再去管它。’我们总有一天会解决这件事情，但距离很远。”\r\n\r\n基辛格先生认为，尼克松和毛泽东之间就台湾问题达成的谅解本来是以百年为期，但只过了五十年，就被特朗普推翻了。特朗普想在贸易问题上迫使中国让步，来夸大自己的强硬形象。\r\n基辛格认为，拜登政府在政策上延续了特朗普的做法，只不过措辞更强调自由主义。\r\n\r\n基辛格转述的毛主席说，100年解决台湾问题，您怎么看？台湾问题要等100年吗？就台湾问题达成谅解，真个百年为期吗？联系上下文语境，毛主席的本意是什么？\r\n\r\n基辛格过生日，很多人都说了热情的话，对基辛格这个中国人民的老朋友给予充分的肯定。\r\n\r\n肯定是必要的，基辛格的理性思考正是今天很多美国政客和学者所缺乏的，但基辛格是美国人是美国犹太人，他的认识有死角，他对中国的认识也有盲区。', '2023-05-14 20:57:20', '6', 'user6.jpg', '0', '0');
INSERT INTO `rizhi` VALUES ('7', '寂寂若离', '很喜欢星铁玩家的一句话：啊？', '2023-05-15 20:59:02', '7', 'user7.jpg', '0', '0');
INSERT INTO `rizhi` VALUES ('8', 'weteartre', '电视上没有播出过的一集柯南！柯哀亲了早有先例！黑鸡和叶水下初吻！\r\n《名侦探柯南特别篇》第20卷中的一个案件《海底遗迹与失踪之谜》！本期视频中用到的所有图片均为手拍！\r\n如果大家觉得这期视频还不错的话，欢迎【长按点赞按钮】一键三连收藏本期节目！\r\n原创不易，感谢支持！', '2023-05-15 21:07:35', '8', 'user8.jpg', '0', '0');
INSERT INTO `rizhi` VALUES ('9', 'tert34564ert', '在中文互联网环境中，巴基斯坦是巴铁，但是目前的巴基斯坦问题很严重，经济，安全和农业问题非常严重，面临国家破产的危险。我们希望从阻碍巴基斯坦发展的一些问题入手，给大家客观分析巴基斯坦目前的问题。也告诉大家，巴基斯坦的混乱，如何影响到中国的国际战略布局。希望可以通过这个节目，让观众们可以理解，在对外交往中，我们如何接受复杂性，如何拥抱复杂性。', '2023-05-16 08:42:45', '9', 'user9.jpg', '0', '0');
INSERT INTO `rizhi` VALUES ('49', '胡言乱语', 'Java Web好难啊', '2023-05-16 20:13:19', '2', 'user2.jpg', '0', '0');
INSERT INTO `rizhi` VALUES ('52', '我在天南海北', '666', '2023-05-20 15:20:55', '11', 'head.png', '0', '0');
INSERT INTO `rizhi` VALUES ('53', '我在天南海北', '6666', '2023-05-20 20:52:56', '15', 'head.png', '0', '0');
INSERT INTO `rizhi` VALUES ('63', 'May', 'CST21045', '2023-06-05 15:42:20', '1', '68b8fb0e-4fb2-4a1d-a800-830ea773278d.jpg', '0', '2');
INSERT INTO `rizhi` VALUES ('64', 'May', '5347\n', '2023-06-27 16:02:45', '1', '68b8fb0e-4fb2-4a1d-a800-830ea773278d.jpg', '0', '2');
INSERT INTO `rizhi` VALUES ('110', 'May', 'May', '2023-07-03 15:14:42', '1', '68b8fb0e-4fb2-4a1d-a800-830ea773278d.jpg', '0', '0');
INSERT INTO `rizhi` VALUES ('143', 'May', '<a href=\"http://localhost:8080/daily/daily/searchtag/666\">#666#</a>热热热热热', '2023-07-06 14:32:45', '1', '68b8fb0e-4fb2-4a1d-a800-830ea773278d.jpg', '0', '0');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `user_code` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `user_pswd` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `daily_picture` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `profile` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `token` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `daily_picture` (`daily_picture`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'May', '001', '202cb962ac59075b964b07152d234b70', '68b8fb0e-4fb2-4a1d-a800-830ea773278d.jpg', null, '13000000000', 'lgw4HAQPrvNSj44chnlzjqXPz7BpQrEtEhvr1yLhWjJi249J6F6B2WF5oPvAOuLj');
INSERT INTO `user` VALUES ('2', '胡言乱语', '002', '202cb962ac59075b964b07152d234b70', 'user2.jpg', null, '13000000001', '6qqSh5O6UDCjamjwvQwNGAzxYuV7VfXDBqfhOA8pBFjVugwfcW0hGAaOwUgDcmbu');
INSERT INTO `user` VALUES ('3', '逍遥居士', '003', '202cb962ac59075b964b07152d234b70', 'user3.jpg', null, '13000000002', null);
INSERT INTO `user` VALUES ('4', '清霜白月', '004', '202cb962ac59075b964b07152d234b70', 'user4.jpg', null, '13000000003', null);
INSERT INTO `user` VALUES ('5', '韩东然', '005', '202cb962ac59075b964b07152d234b70', 'user5.jpg', null, '13000000003', null);
INSERT INTO `user` VALUES ('6', '宏桑', '006', '202cb962ac59075b964b07152d234b70', 'user6.jpg', null, '13000000004', 'gh330AV6cVYx429AyFdI9gVrsOi44mQgLC01NYOufWFbi8zw84xzNYxml2Yy2ymW');
INSERT INTO `user` VALUES ('7', '寂寂若离', '007', '202cb962ac59075b964b07152d234b70', 'user7.jpg', null, '13000000005', null);
INSERT INTO `user` VALUES ('8', 'weteartre', '008', '202cb962ac59075b964b07152d234b70', 'user8.jpg', null, '13000000006', null);
INSERT INTO `user` VALUES ('9', '月', '009', '202cb962ac59075b964b07152d234b70', 'user9.jpg', null, '13000000007', null);
INSERT INTO `user` VALUES ('10', '我在天南海北', '033', '202cb962ac59075b964b07152d234b70', 'head.png', null, '13000000008', null);
INSERT INTO `user` VALUES ('11', '月月', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'head.png', null, '13000000009', null);
INSERT INTO `user` VALUES ('12', '嘉庚', '010', '202cb962ac59075b964b07152d234b70', 'head.png', null, '13000000010', null);
