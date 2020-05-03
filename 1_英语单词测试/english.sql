/*
Navicat MySQL Data Transfer

Source Server         : CarreLiu
Source Server Version : 50728
Source Host           : localhost:3306
Source Database       : english

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2020-05-03 17:38:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tests`
-- ----------------------------
DROP TABLE IF EXISTS `tests`;
CREATE TABLE `tests` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `totalWords` int(10) NOT NULL,
  `correctRate` double(5,3) NOT NULL,
  `allWords` text NOT NULL,
  `errorWords` text,
  `correctWords` text,
  `testType` int(5) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tests
-- ----------------------------

-- ----------------------------
-- Table structure for `words`
-- ----------------------------
DROP TABLE IF EXISTS `words`;
CREATE TABLE `words` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `english` varchar(100) NOT NULL,
  `chinese` varchar(100) NOT NULL,
  `property` varchar(100) DEFAULT NULL,
  `createTime` datetime NOT NULL,
  `errorTimes` int(10) NOT NULL DEFAULT '0',
  `correctTimes` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of words
-- ----------------------------
INSERT INTO `words` VALUES ('1', 'console', '安慰', 'vt.&n.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('2', 'consist', '在于', 'vi.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('3', 'consistent', '前后一致的，连续的', 'adj.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('4', 'constant', '坚定的，永恒的；经常的', 'adj.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('5', 'constituent', '构成的，组成的；成分；选民', 'adj.&n.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('6', 'constitute', '组成；建立，制定(法律史)', 'v.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('7', 'constitution', '构成；体格；宪法', 'n.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('8', 'constrain', '强制，迫使；限制', 'vt.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('9', 'construct', '建造；创立，构思', 'v.&n.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('10', 'distinct', '有区别的，不同的；明显的；确切的', 'adj.', '2020-04-30 23:38:00', '0', '0');
INSERT INTO `words` VALUES ('11', 'distinction', '差别，区分；杰出，优秀，卓越；不同凡响，独特；优等评分', 'n.', '2020-04-30 23:41:11', '0', '0');
INSERT INTO `words` VALUES ('12', 'distinguish', '区别，辨别；使有特色，使有别于；使杰出', 'v.', '2020-04-30 23:42:14', '0', '0');
INSERT INTO `words` VALUES ('13', 'overlook', '俯瞰，眺望；看漏，忽略；宽容', 'vt.', '2020-04-30 23:42:46', '0', '0');
INSERT INTO `words` VALUES ('14', 'overseas', '外国的，海外的；在海外，在国外', 'adj.&adv.', '2020-04-30 23:43:07', '0', '0');
INSERT INTO `words` VALUES ('15', 'fruitful', '多产的，果实累累的；富有成效的', 'adj.', '2020-04-30 23:44:08', '0', '0');
INSERT INTO `words` VALUES ('16', 'frustrate', '挫败，阻挠，使灰心；使无效', 'vt.', '2020-04-30 23:45:12', '0', '0');
INSERT INTO `words` VALUES ('17', 'fulfill', '履行，实现，完成；(使)满意；起---作用', 'vt.', '2020-04-30 23:46:06', '0', '0');
INSERT INTO `words` VALUES ('18', 'function', '功能，作用；职务，职责；函数；(正式的)典礼，宴会；运行，起作用', 'n.&vi.', '2020-04-30 23:55:28', '0', '0');
INSERT INTO `words` VALUES ('19', 'fund', '资金，基金；储备，蕴藏；为---提供资金，资助', 'n.&v.', '2020-04-30 23:55:56', '0', '0');
INSERT INTO `words` VALUES ('20', 'fundamental', '基础的，基本的；根本的，主要的，十分重大的；基本原则，基本原理', 'adj.&n.', '2020-04-30 23:56:43', '0', '0');
INSERT INTO `words` VALUES ('21', 'anguish', '(精神的或肉体的)极度痛苦，苦恼；使痛苦，苦恼，悲痛；感到苦恼或(极度)悲痛', 'n.&v.', '2020-04-30 23:58:03', '0', '0');
INSERT INTO `words` VALUES ('22', 'annoy', '使恼怒，使生气；打扰，骚扰', 'vt.', '2020-05-01 00:19:37', '0', '0');
INSERT INTO `words` VALUES ('23', 'annual', '每年的，年度的，一年一次的；全年的；年报，年刊；一年生植物', 'adj.&n.', '2020-05-01 00:20:40', '0', '0');
INSERT INTO `words` VALUES ('24', 'monopoly', '垄断，专卖；独占，专利；垄断者(企业)，专利者', 'n.', '2020-05-01 00:22:43', '0', '0');
INSERT INTO `words` VALUES ('25', 'monotonous', '单调无聊的，毫无变化的', 'adj.', '2020-05-01 00:23:07', '0', '0');
INSERT INTO `words` VALUES ('26', 'mood', '心境，情绪，心情；氛围，气氛；语气', 'n.', '2020-05-01 00:23:34', '0', '0');
INSERT INTO `words` VALUES ('27', 'transmission', '播送，发射，传送，传染，传播', 'n.', '2020-05-01 00:24:52', '0', '0');
INSERT INTO `words` VALUES ('28', 'transmit', '传送，传递；播送，发射；传染，传播', 'v.', '2020-05-01 00:25:28', '0', '0');
INSERT INTO `words` VALUES ('29', 'transplant', '移植(器官等)；移种(植物等)；(使)移居，(使)迁移；(器官等的)移植；移植的器官，移植物', 'v.&n.', '2020-05-01 00:27:29', '0', '0');
INSERT INTO `words` VALUES ('30', 'transport', '运送，运输，搬动；运输，运送；运输系统，运载工具', 'vt.&n.', '2020-05-01 00:28:06', '0', '0');
INSERT INTO `words` VALUES ('31', 'stride', '阔步前进，大踏步走；大步，跨步，阔步；(快速的)进展，发展，进步', 'v.&n.', '2020-05-01 00:28:55', '0', '0');
INSERT INTO `words` VALUES ('32', 'strike', '打击，撞，撞击；突然袭击，进攻；给---以(深刻)印象，突然想到；罢工；偶然发现；打，击；罢工；意外威力，走运', 'v.&n.', '2020-05-01 00:41:21', '0', '0');
INSERT INTO `words` VALUES ('33', 'striking', '显著的，突出的，妩媚动人的，标致的', 'adj.', '2020-05-01 00:42:25', '0', '0');
INSERT INTO `words` VALUES ('34', 'string', '细绳，线，带；(一)串，一连串，一系列；串起；缚，扎，挂', 'n.&v.', '2020-05-01 00:44:52', '0', '0');
INSERT INTO `words` VALUES ('35', 'structure', '结构体，(尤指建筑物)；结构，构造；精心组织，周密安排，体系；系统安排，精心组织，使形成体系', 'n.', '2020-05-01 01:23:37', '0', '0');
INSERT INTO `words` VALUES ('36', 'stun', '使震惊，使晕倒，把---打晕；给(某人)以深刻印象，使深深感动；晕眩，打晕，惊倒', 'v.&n.', '2020-05-02 00:23:42', '0', '0');
