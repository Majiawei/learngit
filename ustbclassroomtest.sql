/*
Navicat MySQL Data Transfer

Source Server         : 123
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : ustbclassroomtest

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2017-05-23 14:47:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `admin_name` varchar(20) NOT NULL,
  `admin_no` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员账号',
  `phone_num` int(11) unsigned NOT NULL,
  `mail` varchar(20) NOT NULL,
  `head_pic` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`admin_no`),
  UNIQUE KEY `admin_no` (`admin_no`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------

-- ----------------------------
-- Table structure for classroom
-- ----------------------------
DROP TABLE IF EXISTS `classroom`;
CREATE TABLE `classroom` (
  `type` int(2) unsigned NOT NULL,
  `class_no` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `capacity` int(3) NOT NULL,
  `location` varchar(20) NOT NULL,
  `state` int(1) unsigned NOT NULL,
  `class_pic` varchar(30) NOT NULL,
  PRIMARY KEY (`class_no`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classroom
-- ----------------------------

-- ----------------------------
-- Table structure for comment_table
-- ----------------------------
DROP TABLE IF EXISTS `comment_table`;
CREATE TABLE `comment_table` (
  `comment_no` int(10) NOT NULL,
  `class_no` int(5) unsigned NOT NULL,
  `content` text NOT NULL,
  `reviewer` int(8) unsigned NOT NULL COMMENT '评论人id',
  PRIMARY KEY (`comment_no`),
  KEY `class_no` (`class_no`),
  KEY `reviewer` (`reviewer`),
  CONSTRAINT `comment_table_ibfk_1` FOREIGN KEY (`class_no`) REFERENCES `classroom` (`class_no`) ON UPDATE CASCADE,
  CONSTRAINT `comment_table_ibfk_2` FOREIGN KEY (`reviewer`) REFERENCES `student` (`stu_no`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment_table
-- ----------------------------

-- ----------------------------
-- Table structure for log_table
-- ----------------------------
DROP TABLE IF EXISTS `log_table`;
CREATE TABLE `log_table` (
  `log_no` int(20) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `type` int(2) NOT NULL COMMENT '操作类型',
  `time` datetime NOT NULL COMMENT '操作时间',
  `user_id` int(8) unsigned NOT NULL COMMENT '操作用户号',
  `user_type` int(1) NOT NULL COMMENT '用户类型',
  `feedback` text NOT NULL COMMENT '反馈内容',
  PRIMARY KEY (`log_no`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `log_table_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `student` (`stu_no`) ON UPDATE CASCADE,
  CONSTRAINT `log_table_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `teacher` (`tea_no`) ON UPDATE CASCADE,
  CONSTRAINT `log_table_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `admin` (`admin_no`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_table
-- ----------------------------

-- ----------------------------
-- Table structure for notice_table
-- ----------------------------
DROP TABLE IF EXISTS `notice_table`;
CREATE TABLE `notice_table` (
  `notice_no` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `notice_title` varchar(20) NOT NULL,
  `notice_content` text NOT NULL,
  `notice_time` datetime NOT NULL,
  `publisher` int(8) unsigned NOT NULL COMMENT '发布人',
  PRIMARY KEY (`notice_no`),
  KEY `publisher` (`publisher`) USING HASH,
  CONSTRAINT `notice_table_ibfk_1` FOREIGN KEY (`publisher`) REFERENCES `admin` (`admin_no`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notice_table
-- ----------------------------

-- ----------------------------
-- Table structure for record_table
-- ----------------------------
DROP TABLE IF EXISTS `record_table`;
CREATE TABLE `record_table` (
  `record_no` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '预约号',
  `class_no` int(5) unsigned NOT NULL,
  `class_type` int(2) unsigned NOT NULL,
  `timestart` datetime NOT NULL COMMENT '起始时间',
  `timeend` datetime NOT NULL COMMENT '终止时间',
  `user_no` int(8) unsigned NOT NULL,
  `reason` text COMMENT '申请原因',
  `examine_no` int(8) unsigned NOT NULL COMMENT '审核人账号',
  `examine_result` int(1) unsigned zerofill NOT NULL COMMENT '审核结果',
  PRIMARY KEY (`record_no`),
  KEY `class_no` (`class_no`),
  KEY `class_type` (`class_type`),
  KEY `user_no` (`user_no`),
  KEY `examine_no` (`examine_no`),
  CONSTRAINT `record_table_ibfk_1` FOREIGN KEY (`class_no`) REFERENCES `classroom` (`class_no`) ON UPDATE CASCADE,
  CONSTRAINT `record_table_ibfk_2` FOREIGN KEY (`class_type`) REFERENCES `classroom` (`type`) ON UPDATE CASCADE,
  CONSTRAINT `record_table_ibfk_3` FOREIGN KEY (`user_no`) REFERENCES `student` (`stu_no`) ON UPDATE CASCADE,
  CONSTRAINT `record_table_ibfk_4` FOREIGN KEY (`user_no`) REFERENCES `teacher` (`tea_no`) ON UPDATE CASCADE,
  CONSTRAINT `record_table_ibfk_5` FOREIGN KEY (`examine_no`) REFERENCES `admin` (`admin_no`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of record_table
-- ----------------------------

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `stu_name` varchar(20) NOT NULL COMMENT '学生姓名',
  `stu_no` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '学号',
  `class` varchar(20) NOT NULL COMMENT '班级',
  `grade` varchar(20) NOT NULL COMMENT '年级',
  `mail` varchar(20) NOT NULL COMMENT '邮箱',
  `phone_num` int(11) unsigned NOT NULL COMMENT '电话号码',
  `head_pic` varchar(30) NOT NULL COMMENT '头像图片url',
  `password` varchar(30) NOT NULL COMMENT '密码',
  PRIMARY KEY (`stu_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `tea_name` varchar(20) NOT NULL COMMENT '姓名',
  `tea_no` int(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '教职工号',
  `title` varchar(20) NOT NULL COMMENT '职称',
  `college` varchar(20) NOT NULL COMMENT '所属学院',
  `phone_num` int(11) unsigned NOT NULL,
  `mail` varchar(20) NOT NULL,
  `head_pic` varchar(30) DEFAULT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`tea_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
