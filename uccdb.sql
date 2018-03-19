/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50715
Source Host           : 127.0.0.1:3306
Source Database       : uccdb

Target Server Type    : MYSQL
Target Server Version : 50715
File Encoding         : 65001

Date: 2018-03-15 09:51:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for callee_black_lists
-- ----------------------------
DROP TABLE IF EXISTS `callee_black_lists`;
CREATE TABLE `callee_black_lists` (
  `uuid` varchar(64) NOT NULL COMMENT '主键',
  `blacklists_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '黑名单ID',
  `prefix` varchar(64) DEFAULT NULL COMMENT '前缀匹配',
  `black_type` int(11) DEFAULT '0' COMMENT '屏蔽类型{如一对一呼叫，网关呼出，或者禁止所有呼出，默认为全部打开}',
  `gatesway_id` int(11) DEFAULT NULL COMMENT '所属网关',
  `describe` varchar(255) DEFAULT NULL COMMENT ' 描述',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`blacklists_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of callee_black_lists
-- ----------------------------

-- ----------------------------
-- Table structure for caller_black_lists
-- ----------------------------
DROP TABLE IF EXISTS `caller_black_lists`;
CREATE TABLE `caller_black_lists` (
  `uuid` varchar(64) NOT NULL COMMENT '主键',
  `blacklists_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '黑名单ID',
  `prefix` varchar(64) DEFAULT NULL COMMENT '匹配前缀',
  `black_type` int(11) DEFAULT '0' COMMENT '屏蔽类型{如一对一呼叫，网关呼出，或者禁止所有呼出，默认为全部打开}',
  `gatesway_id` int(11) DEFAULT NULL COMMENT '所属网关ID',
  `describe` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`blacklists_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of caller_black_lists
-- ----------------------------
INSERT INTO `caller_black_lists` VALUES ('38512ced235b11e88e78000c29b4fb81', '6', '55555001', '0', null, '', '2018-03-09 13:32:12', '2018-03-09 13:32:12', '10005');
INSERT INTO `caller_black_lists` VALUES ('9d192cd6236211e8875f000c29b4fb81', '7', '55555002', '1', null, '3', '2018-03-09 14:25:08', '2018-03-09 14:25:08', '10000');
INSERT INTO `caller_black_lists` VALUES ('9d1ab377236211e8875f000c29b4fb81', '8', '55555003', '2', null, '4', '2018-03-09 14:25:08', '2018-03-09 14:25:08', '10000');
INSERT INTO `caller_black_lists` VALUES ('9d1ab378236211e8875f000c29b4fb81', '9', '55555004', '3', null, '5', '2018-03-09 14:25:08', '2018-03-09 14:25:08', '10000');

-- ----------------------------
-- Table structure for call_failed_flow
-- ----------------------------
DROP TABLE IF EXISTS `call_failed_flow`;
CREATE TABLE `call_failed_flow` (
  `uuid` varchar(64) NOT NULL DEFAULT '' COMMENT '主键',
  `vlan_id` int(11) NOT NULL DEFAULT '0' COMMENT '虚拟区域划分',
  `call_failed_flow_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '处理流程ID',
  `failed_reason` varchar(255) DEFAULT NULL COMMENT '失败原因{NORMAL_TEMPORARY_FAILURE,USER_BUSY,NO_ANSWER,TIMEOUT,NO_ROUTE_DESTINATION}',
  `operat_type` varchar(32) DEFAULT NULL COMMENT '操作类型{transfer：转接;voicemail:留言}',
  `operat_data` varchar(128) DEFAULT NULL COMMENT '操作数据',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`call_failed_flow_id`,`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='呼叫失败';

-- ----------------------------
-- Records of call_failed_flow
-- ----------------------------
INSERT INTO `call_failed_flow` VALUES ('914924a221e411e8a78d000c29b4fb81', '10003', '1', 'RECOVERY_ON_TIMER_EXPIRE', 'transfer', '66666001', '2018-03-07 16:50:20', '2018-03-07 16:50:20');
INSERT INTO `call_failed_flow` VALUES ('3bea7a8621e511e8a78d000c29b4fb81', '10003', '2', 'NO_USER_RESPONSE,USER_BUSY', 'voicemail', '', '2018-03-07 16:55:07', '2018-03-07 17:03:24');
INSERT INTO `call_failed_flow` VALUES ('40b3262721e511e8a78d000c29b4fb81', '10003', '22', 'NO_ANSWER', 'voicemail', '', '2018-03-07 16:55:15', '2018-03-07 17:03:44');
INSERT INTO `call_failed_flow` VALUES ('3b757c29236e11e8875f000c29b4fb81', '10005', '26', 'RECOVERY_ON_TIMER_EXPIRE,NO_USER_RESPONSE,USER_BUSY,NO_ANSWER,USER_NOT_REGISTERED,NO_ROUTE_DESTINATION', 'voicemail', '', '2018-03-09 15:48:18', '2018-03-09 15:48:18');
INSERT INTO `call_failed_flow` VALUES ('97bc12fa236e11e8875f000c29b4fb81', '10005', '27', 'NO_USER_RESPONSE,USER_BUSY,USER_NOT_REGISTERED', 'transfer', '55555000', '2018-03-09 15:50:53', '2018-03-09 15:50:53');
INSERT INTO `call_failed_flow` VALUES ('014884c025b811e8875f000c29b4fb81', '10000', '28', 'CALL_CFU', 'transfer', '', '2018-03-12 13:41:26', '2018-03-12 13:41:26');

-- ----------------------------
-- Table structure for call_num_change
-- ----------------------------
DROP TABLE IF EXISTS `call_num_change`;
CREATE TABLE `call_num_change` (
  `uuid` char(255) NOT NULL COMMENT '主键',
  `change_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '变换序号',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `left_cut_len` int(11) DEFAULT '0' COMMENT '左起删除几位',
  `right_cut_len` int(11) DEFAULT '0' COMMENT '右起删除几位',
  `left_add_str` varchar(128) DEFAULT NULL COMMENT '左边添加值',
  `right_add_str` varchar(128) DEFAULT NULL COMMENT '右边添加值',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`change_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='主叫号码变换';

-- ----------------------------
-- Records of call_num_change
-- ----------------------------

-- ----------------------------
-- Table structure for cdrs
-- ----------------------------
DROP TABLE IF EXISTS `cdrs`;
CREATE TABLE `cdrs` (
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  `uuid` varchar(255) NOT NULL COMMENT 'bugID',
  `direction` varchar(16) DEFAULT NULL COMMENT '呼叫方向{呼入/呼出}',
  `call_id` varchar(255) DEFAULT NULL COMMENT '话务ID',
  `local_ip_v4` varchar(32) DEFAULT NULL COMMENT 'IP地址',
  `caller_id_number` varchar(255) DEFAULT NULL COMMENT '主叫号码',
  `context` varchar(32) DEFAULT NULL COMMENT '上下文',
  `destination_number` varchar(255) DEFAULT NULL COMMENT '被叫号码',
  `route` varchar(255) DEFAULT NULL COMMENT '路由',
  `route_ip` varchar(32) DEFAULT NULL COMMENT ' 路由IP',
  `start_stamp` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `answer_stamp` timestamp NULL DEFAULT NULL COMMENT '应答时间',
  `end_stamp` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `duration` int(11) DEFAULT NULL COMMENT '通话时长',
  `billsec` int(11) DEFAULT NULL COMMENT '计费时长',
  `hangup_cause` varchar(64) DEFAULT NULL COMMENT '挂断原因',
  `read_codec` varchar(64) DEFAULT NULL COMMENT '只读标志',
  `write_codec` varchar(64) DEFAULT NULL COMMENT '只写标志',
  PRIMARY KEY (`uuid`),
  KEY `vlan_id` (`vlan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cdrs
-- ----------------------------
INSERT INTO `cdrs` VALUES ('10003', '05909c9e-21e7-11e8-83cd-ad2673dd34f3', 'inbound', 'b37ea41de453b257', null, '66666003', null, '66666001', null, null, '2018-03-07 17:07:54', '0000-00-00 00:00:00', '2018-03-07 17:07:54', '0', '0', 'NO_ROUTE_DESTINATION', null, null);
INSERT INTO `cdrs` VALUES ('10003', '07b6d646-21e7-11e8-83d5-ad2673dd34f3', 'inbound', '4e353d1609292e24', null, '66666003', null, '66666001', null, null, '2018-03-07 17:07:58', '0000-00-00 00:00:00', '2018-03-07 17:07:58', '0', '0', 'NO_ROUTE_DESTINATION', null, null);
INSERT INTO `cdrs` VALUES ('0', '0a07bf6c-233d-11e8-8c23-ad2673dd34f3', 'inbound', '6bd550f1f7fb4c799ed666fde6eb39b7', null, '66666002', null, '5716666', null, null, '2018-03-09 09:56:10', '0000-00-00 00:00:00', '2018-03-09 09:56:10', '0', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('0', '0d3b265a-22a3-11e8-8a38-ad2673dd34f3', 'inbound', '367a34321244aa45', null, '66666001', null, '5716666', null, null, '2018-03-08 15:33:53', '0000-00-00 00:00:00', '2018-03-08 15:33:53', '0', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('10003', '0de53d64-2282-11e8-8929-ad2673dd34f3', 'inbound', '1237476894087b73', null, '66666003', null, '66666002', null, null, '2018-03-08 11:37:40', '2018-03-08 11:37:45', '2018-03-08 11:38:06', '26', '21', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '130a1adc-22a3-11e8-8a3f-ad2673dd34f3', 'inbound', '352394299b6bd50a', null, '66666001', null, '5716666', null, null, '2018-03-08 15:34:02', '2018-03-08 15:34:02', '2018-03-08 15:34:04', '2', '2', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '175183b2-21e7-11e8-83dd-ad2673dd34f3', 'inbound', 'ee4f0639c620de6c', null, '66666003', null, '66666001', null, null, '2018-03-07 17:08:24', '2018-03-07 17:08:29', '2018-03-07 17:08:32', '8', '3', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('0', '1b86ab1c-22a3-11e8-8a4a-ad2673dd34f3', 'inbound', 'da06ff59e317f157', null, '66666001', null, '5716666', null, null, '2018-03-08 15:34:17', '0000-00-00 00:00:00', '2018-03-08 15:34:17', '0', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('10003', '214cdc42-22a3-11e8-8a52-ad2673dd34f3', 'inbound', '3c754229dc22cb1d', null, '66666001', null, '5716666', null, null, '2018-03-08 15:34:26', '2018-03-08 15:34:26', '2018-03-08 15:34:30', '4', '4', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '21ad8386-227f-11e8-889d-ad2673dd34f3', 'inbound', 'c431137917224a15', null, '66666003', null, '66666002', null, null, '2018-03-08 11:16:45', '2018-03-08 11:16:55', '2018-03-08 11:17:00', '15', '5', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '2499c714-21e7-11e8-83f6-ad2673dd34f3', 'inbound', 'd27b0e02b7671a3f', null, '66666003', null, '66666002', null, null, '2018-03-07 17:08:47', '2018-03-07 17:09:17', '2018-03-07 17:09:51', '64', '34', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '293913bc-21ea-11e8-844e-ad2673dd34f3', 'inbound', '765e85336110d261', null, '66666003', null, '66666002', null, null, '2018-03-07 17:30:23', '0000-00-00 00:00:00', '2018-03-07 17:30:24', '1', '0', 'ORIGINATOR_CANCEL', null, null);
INSERT INTO `cdrs` VALUES ('0', '2bfb3c84-233d-11e8-8c2a-ad2673dd34f3', 'inbound', 'd0b3e52c4e1d477e8c9c796ab739187d', null, '66666002', null, '5716666', null, null, '2018-03-09 09:57:07', '0000-00-00 00:00:00', '2018-03-09 09:57:07', '0', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('10003', '2dda8590-21ea-11e8-8463-ad2673dd34f3', 'inbound', '2851a61e1040805f', null, '66666003', null, '66666002', null, null, '2018-03-07 17:30:31', '2018-03-07 17:31:01', '2018-03-07 17:31:09', '38', '8', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '30b9e066-2277-11e8-87ad-ad2673dd34f3', 'inbound', 'c542c10f4d78df22', null, '66666003', null, '66666001', null, null, '2018-03-08 10:19:54', '0000-00-00 00:00:00', '2018-03-08 10:19:59', '5', '0', 'ORIGINATOR_CANCEL', null, null);
INSERT INTO `cdrs` VALUES ('10003', '3981d48a-233d-11e8-8c31-ad2673dd34f3', 'inbound', '91c4f15a7d3048d1a3b8c90850286fac', null, '66666002', null, '5716666', null, null, '2018-03-09 09:57:29', '2018-03-09 09:57:29', '2018-03-09 09:57:32', '3', '3', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '457f03da-2373-11e8-8d04-ad2673dd34f3', 'inbound', 'dd75ba148d1d5168', null, '55555009', null, '5715555', null, null, '2018-03-09 16:24:22', '0000-00-00 00:00:00', '2018-03-09 16:24:22', '0', '0', 'NO_ROUTE_DESTINATION', null, null);
INSERT INTO `cdrs` VALUES ('10003', '4be4831c-227e-11e8-882c-ad2673dd34f3', 'inbound', '825ff760c718500e', null, '66666003', null, '66666001', null, null, '2018-03-08 11:10:46', '2018-03-08 11:10:46', '2018-03-08 11:11:14', '28', '28', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('0', '4d9ffff4-2663-11e8-9a78-ad2673dd34f3', 'inbound', '5939382eec5f3c58', null, '55555009', null, '55555001', null, null, '2018-03-13 10:07:38', '0000-00-00 00:00:00', '2018-03-13 10:07:38', '0', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('10003', '5434bc18-2282-11e8-8948-ad2673dd34f3', 'inbound', 'e16d5d753d4fb811', null, '66666003', null, '66666002', null, null, '2018-03-08 11:39:38', '2018-03-08 11:39:44', '2018-03-08 11:40:46', '68', '62', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('0', '5c353ab6-2663-11e8-9a87-ad2673dd34f3', 'inbound', '034ea5215a3dec0a', null, '55555009', null, '55555001', null, null, '2018-03-13 10:08:02', '0000-00-00 00:00:00', '2018-03-13 10:08:02', '0', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('10003', '5fdd171c-2373-11e8-8d0d-ad2673dd34f3', 'inbound', 'dd5696626953172b', null, '55555009', null, '5715555', null, null, '2018-03-09 16:25:07', '0000-00-00 00:00:00', '2018-03-09 16:25:07', '0', '0', 'NO_ROUTE_DESTINATION', null, null);
INSERT INTO `cdrs` VALUES ('10003', '667083a2-2373-11e8-8d15-ad2673dd34f3', 'inbound', 'e107c16b932cf447', null, '55555009', null, '55555000', null, null, '2018-03-09 16:25:18', '2018-03-09 16:25:18', '2018-03-09 16:25:36', '18', '18', 'USER_NOT_REGISTERED', null, null);
INSERT INTO `cdrs` VALUES ('10003', '667e3f2c-21ea-11e8-8483-ad2673dd34f3', 'inbound', '4d4d6d2683760523', null, '66666003', null, '66666002', null, null, '2018-03-07 17:32:06', '2018-03-07 17:32:24', '2018-03-07 17:32:26', '20', '2', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '668292ac-2663-11e8-9a8e-ad2673dd34f3', 'inbound', 'e6246660762a535a', null, '55555009', null, '55555001', null, null, '2018-03-13 10:08:19', '0000-00-00 00:00:00', '2018-03-13 10:09:19', '60', '0', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '699c5252-2280-11e8-88c2-ad2673dd34f3', 'inbound', '7119df10a06eea71', null, '66666003', null, '66666008', null, null, '2018-03-08 11:25:55', '2018-03-08 11:25:55', '2018-03-08 11:26:32', '37', '37', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('0', '6c65c416-2274-11e8-875b-ad2673dd34f3', 'inbound', 'd3338f552f494f75', null, '66666003', null, '5716666', null, null, '2018-03-08 10:00:06', '0000-00-00 00:00:00', '2018-03-08 10:00:06', '0', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('10003', '71bcb1a4-2274-11e8-8762-ad2673dd34f3', 'inbound', '9233d05b7b2a0f3c', null, '66666003', null, '5716666', null, null, '2018-03-08 10:00:15', '0000-00-00 00:00:00', '2018-03-08 10:00:27', '12', '0', 'ORIGINATOR_CANCEL', null, null);
INSERT INTO `cdrs` VALUES ('10003', '770fdfc8-227e-11e8-884b-ad2673dd34f3', 'inbound', 'e47ffe377776ff72', null, '66666003', null, '5716666', null, null, '2018-03-08 11:11:59', '2018-03-08 11:11:59', '2018-03-08 11:12:07', '8', '8', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '77823a3a-21ea-11e8-849c-ad2673dd34f3', 'inbound', '7f7b342fe105bb51', null, '66666003', null, '66666002', null, null, '2018-03-07 17:32:34', '2018-03-07 17:32:38', '2018-03-07 17:35:36', '182', '178', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '7b64c91c-2274-11e8-8778-ad2673dd34f3', 'inbound', 'fb239957fd5f8771', null, '66666003', null, '5716666', null, null, '2018-03-08 10:00:31', '2018-03-08 10:00:33', '2018-03-08 10:00:35', '4', '2', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '8b4f5de8-2278-11e8-87cb-ad2673dd34f3', 'inbound', '2556234328772b6b', null, '66666003', null, '5716666', null, null, '2018-03-08 10:29:36', '0000-00-00 00:00:00', '2018-03-08 10:29:37', '1', '0', 'ORIGINATOR_CANCEL', null, null);
INSERT INTO `cdrs` VALUES ('10003', '8f23fbc4-2663-11e8-9aa1-ad2673dd34f3', 'inbound', '6e59e108d16ee649', null, '55555009', null, '55555001', null, null, '2018-03-13 10:09:28', '2018-03-13 10:09:58', '2018-03-13 10:10:36', '68', '38', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '921dffc0-2373-11e8-8d2c-ad2673dd34f3', 'inbound', 'e14ca70c4c64a073', null, '55555009', null, '55555000', null, null, '2018-03-09 16:26:31', '2018-03-09 16:26:31', '2018-03-09 16:26:37', '6', '6', 'USER_NOT_REGISTERED', null, null);
INSERT INTO `cdrs` VALUES ('10003', '93988ad2-2279-11e8-87e3-ad2673dd34f3', 'inbound', 'b656ac7ccd7e7758', null, '66666003', null, '6666111', null, null, '2018-03-08 10:36:59', '0000-00-00 00:00:00', '2018-03-08 10:36:59', '0', '0', 'NO_ROUTE_DESTINATION', null, null);
INSERT INTO `cdrs` VALUES ('10003', '94d2b4b8-227e-11e8-8857-ad2673dd34f3', 'inbound', '9f2d0506cd112419', null, '66666003', null, '66666002', null, null, '2018-03-08 11:12:49', '2018-03-08 11:12:49', '2018-03-08 11:13:19', '30', '30', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('0', '95e3beea-2361-11e8-8cc9-ad2673dd34f3', 'inbound', 'e2279d258912b559', null, '55555009', null, '55555001', null, null, '2018-03-09 14:17:46', '0000-00-00 00:00:00', '2018-03-09 14:17:46', '0', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('10003', '969bcb40-2279-11e8-87eb-ad2673dd34f3', 'inbound', '5b018a796b7b4f62', null, '66666003', null, '6666777', null, null, '2018-03-08 10:37:04', '0000-00-00 00:00:00', '2018-03-08 10:37:05', '1', '0', 'ORIGINATOR_CANCEL', null, null);
INSERT INTO `cdrs` VALUES ('10003', '991410b0-2280-11e8-88e6-ad2673dd34f3', 'inbound', '5d787437232ae821', null, '66666003', null, '66666002', null, null, '2018-03-08 11:27:15', '2018-03-08 11:27:15', '2018-03-08 11:28:32', '77', '77', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', '99c5c0c8-2279-11e8-8800-ad2673dd34f3', 'inbound', '89372c5578048856', null, '66666003', null, '5716666', null, null, '2018-03-08 10:37:10', '2018-03-08 10:37:10', '2018-03-08 10:37:11', '1', '1', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('0', '9e4b241c-2373-11e8-8d46-ad2673dd34f3', 'inbound', '236e976f444c454d', null, '55555001', null, '771011', null, null, '2018-03-09 16:26:51', '0000-00-00 00:00:00', '2018-03-09 16:26:51', '0', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'a10eaf3e-2373-11e8-8d4d-ad2673dd34f3', 'inbound', '946298414d25b31a', null, '55555009', null, '55555000', null, null, '2018-03-09 16:26:56', '2018-03-09 16:26:56', '2018-03-09 16:27:25', '29', '29', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'b61622fe-227e-11e8-8878-ad2673dd34f3', 'inbound', 'd416e707ee172e57', null, '66666003', null, '66666002', null, null, '2018-03-08 11:13:45', '2018-03-08 11:13:45', '2018-03-08 11:14:45', '60', '60', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'bc61e16e-2276-11e8-879a-ad2673dd34f3', 'inbound', 'da2d720aed210b34', null, '66666003', null, '666', null, null, '2018-03-08 10:16:39', '0000-00-00 00:00:00', '2018-03-08 10:16:39', '0', '0', 'NO_ROUTE_DESTINATION', null, null);
INSERT INTO `cdrs` VALUES ('0', 'bff2e6a2-2276-11e8-87a2-ad2673dd34f3', 'inbound', 'e3221518ca4c997c', null, '66666003', null, '66666001', null, null, '2018-03-08 10:16:45', '0000-00-00 00:00:00', '2018-03-08 10:16:51', '6', '0', 'SERVICE_UNAVAILABLE', null, null);
INSERT INTO `cdrs` VALUES ('10005', 'c26bc216-2373-11e8-8d6d-ad2673dd34f3', 'inbound', 'bd0c8b7cab367169', null, '55555009', null, '57155555', null, null, '2018-03-09 16:27:52', '2018-03-09 16:27:52', '2018-03-09 16:28:00', '8', '8', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'c4730ccc-22a1-11e8-89f8-ad2673dd34f3', 'inbound', '8550de3d672c9b30', null, '66666001', null, '66666002', null, null, '2018-03-08 15:24:41', '0000-00-00 00:00:00', '2018-03-08 15:24:41', '0', '0', 'USER_NOT_REGISTERED', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'c8e8e574-22a1-11e8-8a08-ad2673dd34f3', 'inbound', '974e6372b96a0959', null, '66666001', null, '66666002', null, null, '2018-03-08 15:24:49', '0000-00-00 00:00:00', '2018-03-08 15:24:49', '0', '0', 'USER_NOT_REGISTERED', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'cd721a66-22a1-11e8-8a18-ad2673dd34f3', 'inbound', '2a3e3805c9369357', null, '66666001', null, '5716666', null, null, '2018-03-08 15:24:56', '2018-03-08 15:24:56', '2018-03-08 15:24:58', '2', '2', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'd54658e2-22a1-11e8-8a22-ad2673dd34f3', 'inbound', '0178655db8293431', null, '66666001', null, '5716666', null, null, '2018-03-08 15:25:09', '2018-03-08 15:25:09', '2018-03-08 15:25:11', '2', '2', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'ddcc9e0e-22a1-11e8-8a2c-ad2673dd34f3', 'inbound', '2355e0000a045325', null, '66666001', null, '5716666', null, null, '2018-03-08 15:25:24', '2018-03-08 15:25:24', '2018-03-08 15:25:26', '2', '2', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'e6300f06-21eb-11e8-84d4-ad2673dd34f3', 'inbound', '6e7dd25ca25d5439', null, '66666003', null, '5716666', null, null, '2018-03-07 17:42:49', '2018-03-07 17:42:49', '2018-03-07 17:43:03', '14', '14', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'e9266018-21e9-11e8-8420-ad2673dd34f3', 'inbound', 'fa16643aa13a8702', null, '66666003', null, '66666002', null, null, '2018-03-07 17:28:35', '2018-03-07 17:28:45', '2018-03-07 17:28:46', '11', '1', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'ea9a1fd8-21ea-11e8-84b5-ad2673dd34f3', 'inbound', '9a3f093dd630792c', null, '66666003', null, '66666002', null, null, '2018-03-07 17:35:47', '2018-03-07 17:35:56', '2018-03-07 17:36:03', '16', '7', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'eee93028-21eb-11e8-84df-ad2673dd34f3', 'inbound', '502d945f4573703b', null, '66666003', null, '66666002', null, null, '2018-03-07 17:43:04', '2018-03-07 17:43:04', '2018-03-07 17:43:57', '53', '53', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'efa59714-2663-11e8-9ac0-ad2673dd34f3', 'inbound', '4535531db73ab837', null, '55555009', null, '55555001', null, null, '2018-03-13 10:12:09', '0000-00-00 00:00:00', '2018-03-13 10:12:28', '19', '0', 'ORIGINATOR_CANCEL', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'f43e4440-235e-11e8-8cab-ad2673dd34f3', 'inbound', 'e5217c59c91dec15', null, '55555009', null, '55555001', null, null, '2018-03-09 13:58:56', '2018-03-09 13:58:59', '2018-03-09 13:59:03', '7', '4', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10005', 'f7f3f708-2591-11e8-96d0-ad2673dd34f3', 'inbound', '2572c357fe62524d', null, '55555009', null, '57155555', null, null, '2018-03-12 09:09:09', '2018-03-12 09:09:09', '2018-03-12 09:09:11', '2', '2', 'NORMAL_CLEARING', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'f8a0f1d4-21e9-11e8-8439-ad2673dd34f3', 'inbound', '7f113b1cbc0a360f', null, '66666003', null, '66666002', null, null, '2018-03-07 17:29:01', '0000-00-00 00:00:00', '2018-03-07 17:29:04', '3', '0', 'ORIGINATOR_CANCEL', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'fa64a8ba-21e6-11e8-83c5-ad2673dd34f3', 'inbound', '3057b425026ab07a', null, '66666003', null, '66666002', null, null, '2018-03-07 17:07:36', '0000-00-00 00:00:00', '2018-03-07 17:07:36', '0', '0', 'NO_ROUTE_DESTINATION', null, null);
INSERT INTO `cdrs` VALUES ('10003', 'fecbe522-2663-11e8-9ad5-ad2673dd34f3', 'inbound', 'ca3ca354952ecb0a', null, '55555009', null, '55555001', null, null, '2018-03-13 10:12:35', '2018-03-13 10:13:05', '2018-03-13 10:13:39', '64', '34', 'NORMAL_CLEARING', null, null);

-- ----------------------------
-- Table structure for extensions
-- ----------------------------
DROP TABLE IF EXISTS `extensions`;
CREATE TABLE `extensions` (
  `uuid` varchar(64) NOT NULL DEFAULT '' COMMENT '主键id',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  `ext_name` varchar(128) DEFAULT NULL COMMENT '分机名',
  `ext_nbr` varchar(128) NOT NULL COMMENT '分机号码',
  `password` varchar(128) DEFAULT NULL COMMENT '密码',
  `dnd_state` int(11) DEFAULT '1' COMMENT '免打扰配置{1为是，0为否，默认为否}',
  `did_number` varchar(128) DEFAULT NULL COMMENT '直拨号码',
  `domain` varchar(128) NOT NULL COMMENT '域名',
  `group_id` int(11) DEFAULT '-1' COMMENT '组ID',
  `enable_record` int(11) DEFAULT '0' COMMENT '是否录音{0不录音，1录音}',
  `call_failed_flow_id` int(11) DEFAULT '-1' COMMENT '呼叫失败的ID',
  `enable` int(11) NOT NULL DEFAULT '1' COMMENT '是否有效',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `ext_nbr_unique` (`ext_nbr`),
  KEY `did_number` (`did_number`) USING BTREE,
  KEY `ext_nbr` (`ext_nbr`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of extensions
-- ----------------------------
INSERT INTO `extensions` VALUES ('0c65f80f273111e8bbbf000c29b4fb81', '10007', '4001021', '4001021', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-14 10:40:24', '2018-03-14 10:40:24');
INSERT INTO `extensions` VALUES ('17e9fd2b234b11e8989d000c29b4fb81', '10005', '55555000', '55555000', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-13 15:07:15');
INSERT INTO `extensions` VALUES ('17e9fd2c234b11e8989d000c29b4fb81', '10005', '55555001', '55555001', '123456', '0', '5715557', '10.0.10.61', '-1', '0', '26', '1', '2018-03-09 11:36:46', '2018-03-14 16:43:44');
INSERT INTO `extensions` VALUES ('17e9fd2d234b11e8989d000c29b4fb81', '10005', 'qwg', '55555002', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-14 16:44:10');
INSERT INTO `extensions` VALUES ('17e9fd2e234b11e8989d000c29b4fb81', '10005', '55555003', '55555003', '123456', '0', '5715556', '10.0.10.61', '1001', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:47:17');
INSERT INTO `extensions` VALUES ('17e9fd2f234b11e8989d000c29b4fb81', '10005', '55555004', '55555004', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17e9fd30234b11e8989d000c29b4fb81', '10005', '55555005', '55555005', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17e9fd31234b11e8989d000c29b4fb81', '10005', '55555006', '55555006', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 15:23:31');
INSERT INTO `extensions` VALUES ('17e9fd32234b11e8989d000c29b4fb81', '10005', '55555007', '55555007', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17e9fd33234b11e8989d000c29b4fb81', '10005', '55555008', '55555008', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea2444234b11e8989d000c29b4fb81', '10005', '55555009', '55555009', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea2445234b11e8989d000c29b4fb81', '10005', '55555010', '55555010', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea2446234b11e8989d000c29b4fb81', '10005', '55555011', '55555011', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea2447234b11e8989d000c29b4fb81', '10005', '55555012', '55555012', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea2448234b11e8989d000c29b4fb81', '10005', '55555013', '55555013', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea2449234b11e8989d000c29b4fb81', '10005', '55555014', '55555014', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea244a234b11e8989d000c29b4fb81', '10005', '55555015', '55555015', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea244b234b11e8989d000c29b4fb81', '10005', '55555016', '55555016', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea244c234b11e8989d000c29b4fb81', '10005', '55555017', '55555017', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea244d234b11e8989d000c29b4fb81', '10005', '55555018', '55555018', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea244e234b11e8989d000c29b4fb81', '10005', '55555019', '55555019', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea244f234b11e8989d000c29b4fb81', '10005', '55555020', '55555020', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b60234b11e8989d000c29b4fb81', '10005', '55555021', '55555021', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b61234b11e8989d000c29b4fb81', '10005', '55555022', '55555022', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b62234b11e8989d000c29b4fb81', '10005', '55555023', '55555023', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b63234b11e8989d000c29b4fb81', '10005', '55555024', '55555024', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b64234b11e8989d000c29b4fb81', '10005', '55555025', '55555025', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b65234b11e8989d000c29b4fb81', '10005', '55555026', '55555026', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b66234b11e8989d000c29b4fb81', '10005', '55555027', '55555027', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b67234b11e8989d000c29b4fb81', '10005', '55555028', '55555028', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b68234b11e8989d000c29b4fb81', '10005', '55555029', '55555029', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b69234b11e8989d000c29b4fb81', '10005', '55555030', '55555030', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea4b6a234b11e8989d000c29b4fb81', '10005', '55555031', '55555031', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea727b234b11e8989d000c29b4fb81', '10005', '55555032', '55555032', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea727c234b11e8989d000c29b4fb81', '10005', '55555033', '55555033', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea727d234b11e8989d000c29b4fb81', '10005', '55555034', '55555034', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea727e234b11e8989d000c29b4fb81', '10005', '55555035', '55555035', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea727f234b11e8989d000c29b4fb81', '10005', '55555036', '55555036', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea7280234b11e8989d000c29b4fb81', '10005', '55555037', '55555037', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea7281234b11e8989d000c29b4fb81', '10005', '55555038', '55555038', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea7282234b11e8989d000c29b4fb81', '10005', '55555039', '55555039', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea9993234b11e8989d000c29b4fb81', '10005', '55555040', '55555040', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea9994234b11e8989d000c29b4fb81', '10005', '55555041', '55555041', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea9995234b11e8989d000c29b4fb81', '10005', '55555042', '55555042', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea9996234b11e8989d000c29b4fb81', '10005', '55555043', '55555043', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea9997234b11e8989d000c29b4fb81', '10005', '55555044', '55555044', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea9998234b11e8989d000c29b4fb81', '10005', '55555045', '55555045', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea9999234b11e8989d000c29b4fb81', '10005', '55555046', '55555046', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea999a234b11e8989d000c29b4fb81', '10005', '55555047', '55555047', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea999b234b11e8989d000c29b4fb81', '10005', '55555048', '55555048', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17ea999c234b11e8989d000c29b4fb81', '10005', '55555049', '55555049', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eac0ad234b11e8989d000c29b4fb81', '10005', '55555050', '55555050', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eac0ae234b11e8989d000c29b4fb81', '10005', '55555051', '55555051', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eac0af234b11e8989d000c29b4fb81', '10005', '55555052', '55555052', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eac0b0234b11e8989d000c29b4fb81', '10005', '55555053', '55555053', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eac0b1234b11e8989d000c29b4fb81', '10005', '55555054', '55555054', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eac0b2234b11e8989d000c29b4fb81', '10005', '55555055', '55555055', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eac0b3234b11e8989d000c29b4fb81', '10005', '55555056', '55555056', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eac0b4234b11e8989d000c29b4fb81', '10005', '55555057', '55555057', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eac0b5234b11e8989d000c29b4fb81', '10005', '55555058', '55555058', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7c6234b11e8989d000c29b4fb81', '10005', '55555059', '55555059', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7c7234b11e8989d000c29b4fb81', '10005', '55555060', '55555060', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7c8234b11e8989d000c29b4fb81', '10005', '55555061', '55555061', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7c9234b11e8989d000c29b4fb81', '10005', '55555062', '55555062', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7ca234b11e8989d000c29b4fb81', '10005', '55555063', '55555063', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7cb234b11e8989d000c29b4fb81', '10005', '55555064', '55555064', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7cc234b11e8989d000c29b4fb81', '10005', '55555065', '55555065', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7cd234b11e8989d000c29b4fb81', '10005', '55555066', '55555066', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7ce234b11e8989d000c29b4fb81', '10005', '55555067', '55555067', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7cf234b11e8989d000c29b4fb81', '10005', '55555068', '55555068', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eae7d0234b11e8989d000c29b4fb81', '10005', '55555069', '55555069', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb0ee1234b11e8989d000c29b4fb81', '10005', '55555070', '55555070', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb0ee2234b11e8989d000c29b4fb81', '10005', '55555071', '55555071', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb0ee3234b11e8989d000c29b4fb81', '10005', '55555072', '55555072', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb0ee4234b11e8989d000c29b4fb81', '10005', '55555073', '55555073', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb0ee5234b11e8989d000c29b4fb81', '10005', '55555074', '55555074', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb0ee6234b11e8989d000c29b4fb81', '10005', '55555075', '55555075', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb0ee7234b11e8989d000c29b4fb81', '10005', '55555076', '55555076', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb0ee8234b11e8989d000c29b4fb81', '10005', '55555077', '55555077', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb0ee9234b11e8989d000c29b4fb81', '10005', '55555078', '55555078', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb35fa234b11e8989d000c29b4fb81', '10005', '55555079', '55555079', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb35fb234b11e8989d000c29b4fb81', '10005', '55555080', '55555080', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb35fc234b11e8989d000c29b4fb81', '10005', '55555081', '55555081', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb35fd234b11e8989d000c29b4fb81', '10005', '55555082', '55555082', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb35fe234b11e8989d000c29b4fb81', '10005', '55555083', '55555083', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb35ff234b11e8989d000c29b4fb81', '10005', '55555084', '55555084', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb3600234b11e8989d000c29b4fb81', '10005', '55555085', '55555085', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb3601234b11e8989d000c29b4fb81', '10005', '55555086', '55555086', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb3602234b11e8989d000c29b4fb81', '10005', '55555087', '55555087', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb5d13234b11e8989d000c29b4fb81', '10005', '55555088', '55555088', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb5d14234b11e8989d000c29b4fb81', '10005', '55555089', '55555089', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb5d15234b11e8989d000c29b4fb81', '10005', '55555090', '55555090', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb5d16234b11e8989d000c29b4fb81', '10005', '55555091', '55555091', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb5d17234b11e8989d000c29b4fb81', '10005', '55555092', '55555092', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb5d18234b11e8989d000c29b4fb81', '10005', '55555093', '55555093', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb5d19234b11e8989d000c29b4fb81', '10005', '55555094', '55555094', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb5d1a234b11e8989d000c29b4fb81', '10005', '55555095', '55555095', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb5d1b234b11e8989d000c29b4fb81', '10005', '55555096', '55555096', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb842c234b11e8989d000c29b4fb81', '10005', '55555097', '55555097', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb842d234b11e8989d000c29b4fb81', '10005', '55555098', '55555098', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('17eb842e234b11e8989d000c29b4fb81', '10005', '55555099', '55555099', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-09 11:36:46', '2018-03-09 11:36:46');
INSERT INTO `extensions` VALUES ('286f3dd721e011e8a78d000c29b4fb81', '10003', '66666001', '66666001', '123456', '0', '6666777', '10.0.10.61', '-1', '0', '2', '1', '2018-03-07 16:18:46', '2018-03-08 16:17:24');
INSERT INTO `extensions` VALUES ('89872ca2236011e8875f000c29b4fb81', '10000', '99999001', '99999001', '1', '0', '', '1', '-1', '0', '-1', '1', '2018-03-09 14:10:16', '2018-03-09 14:10:39');
INSERT INTO `extensions` VALUES ('89872ca3236011e8875f000c29b4fb81', '10000', '99999002', '99999002', '1', '0', '', '1', '-1', '0', '-1', '1', '2018-03-09 14:10:16', '2018-03-09 14:10:44');
INSERT INTO `extensions` VALUES ('89872ca4236011e8875f000c29b4fb81', '10000', '99999003', '99999003', '1', '0', '', '1', '-1', '0', '-1', '1', '2018-03-09 14:10:16', '2018-03-09 14:10:50');
INSERT INTO `extensions` VALUES ('c652a2cf21e211e8a78d000c29b4fb81', '10003', '66666002', '66666002', '123456', '0', '', '10.0.10.61', '-1', '1', '22', '1', '2018-03-07 16:37:30', '2018-03-09 09:54:59');
INSERT INTO `extensions` VALUES ('c652a2d021e211e8a78d000c29b4fb81', '10003', '66666003', '66666003', '123456', '0', '', '10.0.10.61', '-1', '0', '2', '1', '2018-03-07 16:37:30', '2018-03-07 17:04:06');
INSERT INTO `extensions` VALUES ('c652a2d121e211e8a78d000c29b4fb81', '10003', '66666004', '66666004', '123456', '0', '', '10.0.10.61', '-1', '0', '22', '1', '2018-03-07 16:37:30', '2018-03-08 14:47:40');
INSERT INTO `extensions` VALUES ('c652a2d221e211e8a78d000c29b4fb81', '10003', '66666005', '66666005', '123456', '0', '', '10.0.10.61', '6', '0', '1', '1', '2018-03-07 16:37:30', '2018-03-08 14:50:26');
INSERT INTO `extensions` VALUES ('c652c9e321e211e8a78d000c29b4fb81', '10003', '66666006', '66666006', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9e421e211e8a78d000c29b4fb81', '10003', '66666007', '66666007', '123456', '0', '', '10.0.10.61', '5', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:42:24');
INSERT INTO `extensions` VALUES ('c652c9e521e211e8a78d000c29b4fb81', '10003', '66666008', '66666008', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9e621e211e8a78d000c29b4fb81', '10003', '66666009', '66666009', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9e721e211e8a78d000c29b4fb81', '10003', '66666010', '66666010', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9e821e211e8a78d000c29b4fb81', '10003', '66666011', '66666011', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9e921e211e8a78d000c29b4fb81', '10003', '66666012', '66666012', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9ea21e211e8a78d000c29b4fb81', '10003', '66666013', '66666013', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9eb21e211e8a78d000c29b4fb81', '10003', '66666014', '66666014', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9ec21e211e8a78d000c29b4fb81', '10003', '66666015', '66666015', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9ed21e211e8a78d000c29b4fb81', '10003', '66666016', '66666016', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652c9ee21e211e8a78d000c29b4fb81', '10003', '66666017', '66666017', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652f0ff21e211e8a78d000c29b4fb81', '10003', '66666018', '66666018', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652f10021e211e8a78d000c29b4fb81', '10003', '66666019', '66666019', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('c652f10121e211e8a78d000c29b4fb81', '10003', '66666020', '66666020', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-07 16:37:30', '2018-03-07 16:37:30');
INSERT INTO `extensions` VALUES ('e7965eed21c711e8aac3000c29b4fb81', '10001', '100011', '100011', '1', '0', '', '1', '-1', '0', '-1', '1', '2018-03-07 13:25:10', '2018-03-07 13:25:10');
INSERT INTO `extensions` VALUES ('f42a3ae3227b11e8a78d000c29b4fb81', '10000', '99999000', '99999000', '123456', '0', '', '10.0.10.61', '-1', '0', '-1', '1', '2018-03-08 10:54:00', '2018-03-08 10:54:00');
INSERT INTO `extensions` VALUES ('f4c9e125272e11e8bbbf000c29b4fb81', '10007', '40010001', '40010001', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:49:21');
INSERT INTO `extensions` VALUES ('f4c9e126272e11e8bbbf000c29b4fb81', '10007', '40010002', '40010002', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4c9e127272e11e8bbbf000c29b4fb81', '10007', '40010003', '40010003', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4c9e128272e11e8bbbf000c29b4fb81', '10007', '40010004', '40010004', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4c9e129272e11e8bbbf000c29b4fb81', '10007', '40010005', '40010005', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4c9e12a272e11e8bbbf000c29b4fb81', '10007', '40010006', '40010006', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4c9e12b272e11e8bbbf000c29b4fb81', '10007', '40010007', '40010007', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4c9e12c272e11e8bbbf000c29b4fb81', '10007', '40010008', '40010008', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4c9e12d272e11e8bbbf000c29b4fb81', '10007', '40010009', '40010009', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca083e272e11e8bbbf000c29b4fb81', '10007', '40010010', '40010010', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca083f272e11e8bbbf000c29b4fb81', '10007', '40010011', '40010011', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca0840272e11e8bbbf000c29b4fb81', '10007', '40010012', '40010012', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca0841272e11e8bbbf000c29b4fb81', '10007', '40010013', '40010013', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca0842272e11e8bbbf000c29b4fb81', '10007', '40010014', '40010014', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca0843272e11e8bbbf000c29b4fb81', '10007', '40010015', '40010015', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca0844272e11e8bbbf000c29b4fb81', '10007', '40010016', '40010016', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca0845272e11e8bbbf000c29b4fb81', '10007', '40010017', '40010017', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca0846272e11e8bbbf000c29b4fb81', '10007', '40010018', '40010018', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca0847272e11e8bbbf000c29b4fb81', '10007', '40010019', '40010019', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('f4ca0848272e11e8bbbf000c29b4fb81', '10007', '40010020', '40010020', '123456', '0', '', '10.0.10.61', '400001', '0', '-1', '1', '2018-03-14 10:25:26', '2018-03-14 10:25:26');
INSERT INTO `extensions` VALUES ('fd191d7e21c711e8aac3000c29b4fb81', '10001', '100012', '100012', '22', '0', '', '22', null, '0', '-1', '1', '2018-03-07 13:25:46', '2018-03-07 13:25:46');
INSERT INTO `extensions` VALUES ('fd191d7f21c711e8aac3000c29b4fb81', '10001', '100013', '100013', '22', '0', '', '22', null, '0', '-1', '1', '2018-03-07 13:25:46', '2018-03-07 13:25:46');

-- ----------------------------
-- Table structure for ext_groups
-- ----------------------------
DROP TABLE IF EXISTS `ext_groups`;
CREATE TABLE `ext_groups` (
  `uuid` varchar(64) NOT NULL COMMENT '主键',
  `vlan_id` int(11) DEFAULT NULL COMMENT '虚拟号ID',
  `group_id` int(11) DEFAULT NULL COMMENT '分机租ID',
  `ext_number` int(11) DEFAULT '0' COMMENT '分机数量',
  `ext_nbr` varchar(128) DEFAULT NULL COMMENT '分机号',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `rules` int(11) DEFAULT NULL COMMENT '呼叫规则',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `description` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ext_groups
-- ----------------------------
INSERT INTO `ext_groups` VALUES ('78d2fddf234c11e8989d000c29b4fb81', '10005', '1001', null, null, '100', '1', '2018-03-09 11:46:38', '2018-03-09 11:46:38', '');
INSERT INTO `ext_groups` VALUES ('7e0a1963272e11e8bbbf000c29b4fb81', '10007', '400001', null, null, null, '1', '2018-03-14 10:22:07', '2018-03-14 10:22:07', '');
INSERT INTO `ext_groups` VALUES ('84250e94272e11e8bbbf000c29b4fb81', '10007', '400002', null, null, null, '0', '2018-03-14 10:22:17', '2018-03-14 10:22:17', '');
INSERT INTO `ext_groups` VALUES ('8999343821e011e8a78d000c29b4fb81', '10003', '6', null, null, '100', '0', '2018-03-07 16:21:29', '2018-03-07 16:22:41', '');
INSERT INTO `ext_groups` VALUES ('c27fc59221de11e8a78d000c29b4fb81', '10003', '5', null, null, '100', '0', '2018-03-07 16:08:46', '2018-03-07 16:21:09', '');

-- ----------------------------
-- Table structure for fee_callcontrol
-- ----------------------------
DROP TABLE IF EXISTS `fee_callcontrol`;
CREATE TABLE `fee_callcontrol` (
  `uuid` varchar(32) NOT NULL COMMENT '主键',
  `vlan_id` int(11) DEFAULT NULL COMMENT ' 租户ID',
  `ext_Nbr` varchar(64) DEFAULT NULL COMMENT '分机号',
  `can_outcall` tinyint(4) DEFAULT '0' COMMENT '能否外呼{0:能够外呼，1:表示不能外呼}',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='控制能够外呼';

-- ----------------------------
-- Records of fee_callcontrol
-- ----------------------------
INSERT INTO `fee_callcontrol` VALUES ('d3c45b0722a111e8a588000c29b4fb81', '10003', '001', '1');

-- ----------------------------
-- Table structure for ivr_entry
-- ----------------------------
DROP TABLE IF EXISTS `ivr_entry`;
CREATE TABLE `ivr_entry` (
  `uuid` varchar(64) NOT NULL COMMENT '主键',
  `vlan_id` int(11) DEFAULT NULL COMMENT '虚拟区域划分',
  `ivr_menu_id` int(11) DEFAULT NULL COMMENT 'Ivrid号',
  `ivr_entry_id` int(11) NOT NULL COMMENT '子IVRid',
  `ivr_menu_name` varchar(128) DEFAULT NULL COMMENT 'IVR菜单名',
  `digits` varchar(255) DEFAULT NULL COMMENT '按键或者匹配条件',
  `operat_type` varchar(255) DEFAULT NULL COMMENT '操作类型{transfer:转接,playback:放音,hangup:挂机,ivr:转ivr}',
  `operat_data` varchar(255) DEFAULT NULL COMMENT '操作数据',
  `description` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`uuid`),
  KEY `ivr_menu_name` (`ivr_menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='子IVR菜单';

-- ----------------------------
-- Records of ivr_entry
-- ----------------------------
INSERT INTO `ivr_entry` VALUES ('1e9f2d8f272d11e8bbbf000c29b4fb81', '10001', null, '44', 'ipcc_ivr', '3', 'transfer', '40020000', '', '2018-03-14 10:12:17', '2018-03-14 10:12:17');
INSERT INTO `ivr_entry` VALUES ('3a2719f1272e11e8bbbf000c29b4fb81', '10007', null, '4', 'uipcc_ivr', '/^(400100[0-9][0-9])$/', 'transfer', '$1', '', '2018-03-14 10:20:13', '2018-03-14 10:20:13');
INSERT INTO `ivr_entry` VALUES ('50c49752272e11e8bbbf000c29b4fb81', '10007', null, '5', 'uipcc_ivr', '3', 'playback', '', '', '2018-03-14 10:20:51', '2018-03-14 10:20:51');
INSERT INTO `ivr_entry` VALUES ('7b4d08ac237211e8875f000c29b4fb81', '10005', null, '1', 'test_ivr', '0', 'transfer', '55555000', '', '2018-03-09 16:18:43', '2018-03-09 16:47:30');
INSERT INTO `ivr_entry` VALUES ('827c10fe21eb11e8a78d000c29b4fb81', '10003', null, '1', 'ipcc_ivr', '1', 'playback', '/usr/local/freeswitch/sounds/ivr/ivr-welcome_to_freeswitch.wav', '', '2018-03-07 17:40:02', '2018-03-09 16:47:42');
INSERT INTO `ivr_entry` VALUES ('8479d1bd237211e8875f000c29b4fb81', '10005', null, '2', 'test_ivr', '1', 'playback', '/usr/local/freeswitch/sounds/ivr/ivr-welcome_to_freeswitch.wav', '', '2018-03-09 16:18:59', '2018-03-09 16:26:27');
INSERT INTO `ivr_entry` VALUES ('90e221cf21eb11e8a78d000c29b4fb81', '10003', null, '2', 'ipcc_ivr', '0', 'transfer', '66666001', '', '2018-03-07 17:40:26', '2018-03-07 17:40:39');
INSERT INTO `ivr_entry` VALUES ('aadbe99021eb11e8a78d000c29b4fb81', '10003', null, '3', 'ipcc_ivr', '/^(666660[0-9][0-9])$/', 'transfer', '$1', '', '2018-03-07 17:41:10', '2018-03-07 17:41:10');
INSERT INTO `ivr_entry` VALUES ('de481e90272d11e8bbbf000c29b4fb81', '10007', null, '3', 'uipcc_ivr', '0', 'transfer', '4001000', '', '2018-03-14 10:17:39', '2018-03-14 10:17:48');
INSERT INTO `ivr_entry` VALUES ('f629849e237211e8875f000c29b4fb81', '10005', null, '3', 'test_ivr', '/^(555550[0-9][0-9])$/', 'transfer', '$1', '', '2018-03-09 16:22:09', '2018-03-09 16:22:09');

-- ----------------------------
-- Table structure for ivr_flow_menu
-- ----------------------------
DROP TABLE IF EXISTS `ivr_flow_menu`;
CREATE TABLE `ivr_flow_menu` (
  `uuid` varchar(64) DEFAULT NULL COMMENT '主键ID',
  `vlan_id` int(11) DEFAULT NULL COMMENT '虚拟区域划分',
  `ivr_menu_id` int(11) DEFAULT NULL COMMENT 'Ivrid号',
  `ivr_menu_name` varchar(128) NOT NULL COMMENT 'IVR菜单名',
  `first_sound` varchar(255) DEFAULT NULL COMMENT '初始播放的音频文件',
  `short_sound` varchar(255) DEFAULT NULL COMMENT '重复播放文件名',
  `invalid_sound` varchar(255) DEFAULT NULL COMMENT '错误播放文件名',
  `exit_sound` varchar(255) DEFAULT NULL COMMENT '退出音频',
  `timeout` int(11) DEFAULT '30000' COMMENT '超时时长',
  `max_failures` int(11) DEFAULT NULL COMMENT '最大失败次数',
  `max_timeouts` int(11) DEFAULT NULL COMMENT '重试超时时间',
  `dtmf_input_timeout` int(11) DEFAULT NULL COMMENT 'Dtmf输入超时时间',
  `dtmf_len` int(11) DEFAULT NULL COMMENT 'Dtmf收号长度',
  `ivr_entry_id` int(11) DEFAULT NULL COMMENT '子IVRid',
  `ivr_entry_name` varchar(128) DEFAULT NULL COMMENT '子ivr名称',
  `description` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_at` datetime DEFAULT NULL COMMENT '插入时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`ivr_menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='IVR菜单';

-- ----------------------------
-- Records of ivr_flow_menu
-- ----------------------------
INSERT INTO `ivr_flow_menu` VALUES ('3b3266ed21eb11e8a78d000c29b4fb81', '10003', '1', 'ipcc_ivr', '/usr/local/freeswitch/sounds/ivr/10086_main.wav', '/usr/local/freeswitch/sounds/ivr/ivr_short.wav', '/usr/local/freeswitch/sounds/ivr/ivr-that_was_an_invalid_entry.wav', '/usr/local/freeswitch/sounds/ivr/vm-goodbye.wav', '30000', '100', '5', '8000', '8', null, '', '', '2018-03-07 17:38:02', '2018-03-07 17:38:15');
INSERT INTO `ivr_flow_menu` VALUES ('4fd3940b237211e8875f000c29b4fb81', '10005', '5', 'test_ivr', '/usr/local/freeswitch/sounds/ivr/10086_main.wav', '/usr/local/freeswitch/sounds/ivr/ivr_short.wav', '/usr/local/freeswitch/sounds/ivr/ivr-that_was_an_invalid_entry.wav', '/usr/local/freeswitch/sounds/ivr/vm-goodbye.wav', '30000', '100', '5', '5000', '8', null, '', '', '2018-03-09 16:17:30', '2018-03-09 16:17:30');
INSERT INTO `ivr_flow_menu` VALUES ('7a83276e272c11e8bbbf000c29b4fb81', '10007', '2', 'uipcc_ivr', '/usr/local/freeswitch/sounds/ivr/10086_main.wav', '/usr/local/freeswitch/sounds/ivr/ivr_short.wav', '/usr/local/freeswitch/sounds/ivr/ivr-that_was_an_invalid_entry.wav', '/usr/local/freeswitch/sounds/ivr/vm-goodbye.wav', '30000', '100', '3', '5000', '4', null, '', '', '2018-03-14 10:07:42', '2018-03-14 10:07:42');

-- ----------------------------
-- Table structure for notworktime
-- ----------------------------
DROP TABLE IF EXISTS `notworktime`;
CREATE TABLE `notworktime` (
  `uuid` varchar(32) NOT NULL COMMENT '主键',
  `notworktime_id` int(11) DEFAULT NULL COMMENT '非工作时间ID{-1表示不启用}',
  `vlan_id` int(11) DEFAULT NULL COMMENT '虚拟区域划分',
  `schedule_uuid` varchar(32) DEFAULT NULL COMMENT '工作日设置ID',
  `date_stamp` varchar(32) DEFAULT NULL COMMENT '节假日日期',
  `start_stamp` varchar(32) DEFAULT NULL COMMENT '开始时间',
  `end_stamp` varchar(32) DEFAULT NULL COMMENT '结束时间',
  `datetime_start` datetime DEFAULT NULL COMMENT '开始时间',
  `datetime_end` datetime DEFAULT NULL COMMENT '结束时间',
  `operat_type` varchar(128) DEFAULT NULL COMMENT '操作类型{转接、放音、挂机等}',
  `operat_data` varchar(128) DEFAULT NULL COMMENT '操作数据',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='非工作时间';

-- ----------------------------
-- Records of notworktime
-- ----------------------------
INSERT INTO `notworktime` VALUES ('1da57a37235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-01', '08:30', '17:00', '2018-03-01 08:30:00', '2018-03-01 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1da6b2b8235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-02', '08:30', '17:00', '2018-03-02 08:30:00', '2018-03-02 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1da77609235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-05', '08:30', '17:00', '2018-03-05 08:30:00', '2018-03-05 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1da8124a235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-06', '08:30', '17:00', '2018-03-06 08:30:00', '2018-03-06 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1da8fcab235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-07', '08:30', '17:00', '2018-03-07 08:30:00', '2018-03-07 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1da9e70c235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-08', '08:30', '17:00', '2018-03-08 08:30:00', '2018-03-08 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1daad16d235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-09', '08:30', '17:00', '2018-03-09 08:30:00', '2018-03-09 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1dab6dae235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-12', '08:30', '17:00', '2018-03-12 08:30:00', '2018-03-12 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1dac30ff235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-13', '08:30', '17:00', '2018-03-13 08:30:00', '2018-03-13 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1daccd40235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-14', '08:30', '17:00', '2018-03-14 08:30:00', '2018-03-14 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1dad9091235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-15', '08:30', '17:00', '2018-03-15 08:30:00', '2018-03-15 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1dae2cd2235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-16', '08:30', '17:00', '2018-03-16 08:30:00', '2018-03-16 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1daec913235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-19', '08:30', '17:00', '2018-03-19 08:30:00', '2018-03-19 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1daf6554235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-20', '08:30', '17:00', '2018-03-20 08:30:00', '2018-03-20 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1db028a5235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-21', '08:30', '17:00', '2018-03-21 08:30:00', '2018-03-21 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1db0c4e6235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-22', '08:30', '17:00', '2018-03-22 08:30:00', '2018-03-22 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1db1fd67235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-23', '08:30', '17:00', '2018-03-23 08:30:00', '2018-03-23 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1db299a8235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-26', '08:30', '17:00', '2018-03-26 08:30:00', '2018-03-26 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1db35cf9235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-27', '08:30', '17:00', '2018-03-27 08:30:00', '2018-03-27 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1db3f93a235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-28', '08:30', '17:00', '2018-03-28 08:30:00', '2018-03-28 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1db4957b235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-29', '08:30', '17:00', '2018-03-29 08:30:00', '2018-03-29 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('1db531bc235b11e88e78000c29b4fb81', null, '10005', '1d9d3cd6235b11e88e78000c29b4fb81', '2018-03-30', '08:30', '17:00', '2018-03-30 08:30:00', '2018-03-30 17:00:00', '留言', null, '2018-03-09 13:31:28', '2018-03-09 13:31:28');
INSERT INTO `notworktime` VALUES ('764558a821ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-01', '08:30', '18:00', '2018-03-01 08:30:00', '2018-03-01 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('7645f4e921ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-02', '08:30', '18:00', '2018-03-02 08:30:00', '2018-03-02 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('7646912a21ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-05', '08:30', '18:00', '2018-03-05 08:30:00', '2018-03-05 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('7647065b21ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-06', '08:30', '18:00', '2018-03-06 08:30:00', '2018-03-06 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('76477b8c21ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-08', '08:30', '18:00', '2018-03-08 08:30:00', '2018-03-08 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764817cd21ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-09', '08:30', '18:00', '2018-03-09 08:30:00', '2018-03-09 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('7648b40e21ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-12', '08:30', '18:00', '2018-03-12 08:30:00', '2018-03-12 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('7649504f21ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-13', '08:30', '18:00', '2018-03-13 08:30:00', '2018-03-13 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('7649c58021ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-14', '08:30', '18:00', '2018-03-14 08:30:00', '2018-03-14 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764a61c121ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-15', '08:30', '18:00', '2018-03-15 08:30:00', '2018-03-15 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764b251221ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-16', '08:30', '18:00', '2018-03-16 08:30:00', '2018-03-16 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764b9a4321ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-19', '08:30', '18:00', '2018-03-19 08:30:00', '2018-03-19 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764c368421ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-20', '08:30', '18:00', '2018-03-20 08:30:00', '2018-03-20 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764cabb521ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-21', '08:30', '18:00', '2018-03-21 08:30:00', '2018-03-21 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764d20e621ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-22', '08:30', '18:00', '2018-03-22 08:30:00', '2018-03-22 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764d961721ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-23', '08:30', '18:00', '2018-03-23 08:30:00', '2018-03-23 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764e325821ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-26', '08:30', '18:00', '2018-03-26 08:30:00', '2018-03-26 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764ece9921ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-27', '08:30', '18:00', '2018-03-27 08:30:00', '2018-03-27 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('764f6ada21ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-28', '08:30', '18:00', '2018-03-28 08:30:00', '2018-03-28 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('7650071b21ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-29', '08:30', '18:00', '2018-03-29 08:30:00', '2018-03-29 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');
INSERT INTO `notworktime` VALUES ('76507c4c21ea11e8a78d000c29b4fb81', null, '10003', 'dc11ca2121e911e8a78d000c29b4fb81', '2018-03-30', '08:30', '18:00', '2018-03-30 08:30:00', '2018-03-30 18:00:00', '留言', null, '2018-03-07 17:32:32', '2018-03-07 17:32:32');

-- ----------------------------
-- Table structure for record_cdrs
-- ----------------------------
DROP TABLE IF EXISTS `record_cdrs`;
CREATE TABLE `record_cdrs` (
  `uuid` varchar(64) NOT NULL COMMENT '主键',
  `caller_id_number` varchar(128) DEFAULT NULL COMMENT '主叫号码',
  `destination_number` varchar(128) DEFAULT NULL COMMENT '被叫号码',
  `full_record_path` varchar(255) DEFAULT NULL COMMENT '录音文件路径',
  `event_time` datetime DEFAULT NULL COMMENT '时间',
  `type` int(255) DEFAULT '0' COMMENT '0：录音，1标识留言',
  `record_seconds` int(11) DEFAULT NULL COMMENT '录音时长',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='录音文件';

-- ----------------------------
-- Records of record_cdrs
-- ----------------------------
INSERT INTO `record_cdrs` VALUES ('2499c714-21e7-11e8-83f6-ad2673dd34f3', '66666003', '66666002', '/usr/local/freeswitch/storage/voicemail/default/10.0.10.61/66666002/msg_3a2518a4-21e7-11e8-8411-ad2673dd34f3.wav', '2018-03-07 17:09:42', '1', '10', null, null, '10003');
INSERT INTO `record_cdrs` VALUES ('c5041262-227e-11e8-8892-ad2673dd34f3', '66666003', '66666002', '/usr/local/freeswitch/record/ivr1111.wav', '2018-03-08 11:14:45', '0', '31', null, null, '10003');
INSERT INTO `record_cdrs` VALUES ('7a2601b8-2280-11e8-88da-ad2673dd34f3', '66666003', '66666008', '/usr/local/freeswitch/record/ivr1111.wav', '2018-03-08 11:26:32', '0', '6', null, null, '10003');
INSERT INTO `record_cdrs` VALUES ('991410b0-2280-11e8-88e6-ad2673dd34f3', '66666003', '66666008', '/usr/local/freeswitch/record/ivr1111.wav', '2018-03-08 11:28:23', '0', '19', null, null, '10003');
INSERT INTO `record_cdrs` VALUES ('c16302c4-2280-11e8-8919-ad2673dd34f3', '66666003', '66666002', '/usr/local/freeswitch/record/ivr1111.wav', '2018-03-08 11:28:32', '0', '5', null, null, '10003');
INSERT INTO `record_cdrs` VALUES ('0de53d64-2282-11e8-8929-ad2673dd34f3', '66666003', '66666002', '/usr/local/freeswitch/record/20180308113740_66666003_66666002.wav', '2018-03-08 11:38:06', '0', '21', null, null, '10003');
INSERT INTO `record_cdrs` VALUES ('8f23fbc4-2663-11e8-9aa1-ad2673dd34f3', '55555009', '55555001', '/usr/local/freeswitch/storage/voicemail/default/10.0.10.61/55555001/msg_a4ae7a82-2663-11e8-9abc-ad2673dd34f3.wav', '2018-03-13 10:10:28', '1', '15', null, null, '10003');
INSERT INTO `record_cdrs` VALUES ('fecbe522-2663-11e8-9ad5-ad2673dd34f3', '55555009', '55555001', '/usr/local/freeswitch/storage/voicemail/default/10.0.10.61/55555001/msg_14256a88-2664-11e8-9af2-ad2673dd34f3.wav', '2018-03-13 10:13:31', '1', '9', null, null, '10003');

-- ----------------------------
-- Table structure for record_conf
-- ----------------------------
DROP TABLE IF EXISTS `record_conf`;
CREATE TABLE `record_conf` (
  `uuid` varchar(32) NOT NULL COMMENT '主键',
  `vlan_id` int(11) DEFAULT NULL COMMENT '虚拟区域划分',
  `file_path` varchar(255) DEFAULT NULL COMMENT '录音文件路径',
  `file_format` varchar(16) DEFAULT NULL COMMENT '录音格式{wav，MP3}',
  `record_direction` int(11) DEFAULT NULL COMMENT '录音方向{0：被叫录音，1：主叫录音，2：双方都录}',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='录音配置表';

-- ----------------------------
-- Records of record_conf
-- ----------------------------
INSERT INTO `record_conf` VALUES ('0c0244a921e611e8a78d000c29b4fb81', '10003', '/home/media/records/', 'wav', null);

-- ----------------------------
-- Table structure for sysconfig
-- ----------------------------
DROP TABLE IF EXISTS `sysconfig`;
CREATE TABLE `sysconfig` (
  `uuid` varchar(64) NOT NULL,
  `vlan_id` int(11) NOT NULL DEFAULT '0',
  `switch_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务器ID',
  `config_key` varchar(128) NOT NULL DEFAULT '',
  `config_value` varchar(255) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='uss系统全局配置表';

-- ----------------------------
-- Records of sysconfig
-- ----------------------------
INSERT INTO `sysconfig` VALUES ('11', '0', '0', 'sip_reg_expires', '366');
INSERT INTO `sysconfig` VALUES ('22', '0', '0', 'ext_record_path', '/usr/local/freeswitch');
INSERT INTO `sysconfig` VALUES ('333', '0', '0', 'enable_blacklists', '1');

-- ----------------------------
-- Table structure for ucc_companyinfo
-- ----------------------------
DROP TABLE IF EXISTS `ucc_companyinfo`;
CREATE TABLE `ucc_companyinfo` (
  `uuid` varchar(32) NOT NULL,
  `companyId` int(11) NOT NULL AUTO_INCREMENT COMMENT '企业编号{范围为10000-99999，且不能重复}',
  `companyName` varchar(255) DEFAULT NULL COMMENT '企业名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `contactsName` varchar(128) DEFAULT NULL COMMENT '联系人',
  `ContactNumber` varchar(128) DEFAULT NULL COMMENT '联系人号码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮件地址',
  `status` char(2) DEFAULT '0' COMMENT '租户状态{0:启用;1:停用}',
  `create_at` datetime DEFAULT NULL COMMENT '注册日期',
  `balance` decimal(20,4) DEFAULT '0.0000' COMMENT '账户余额',
  `isTest` int(11) DEFAULT '0' COMMENT '是否是测试用户{0:正式用户;1:测试用户}',
  `update_at` datetime DEFAULT NULL COMMENT '更新日期',
  `address` varchar(255) DEFAULT NULL COMMENT '企业地址',
  `website` varchar(255) DEFAULT NULL COMMENT '企业官网',
  `license` varchar(255) DEFAULT NULL COMMENT '营业执照',
  `password` varchar(32) DEFAULT NULL COMMENT '租户初始化密码',
  `prefix` varchar(32) DEFAULT NULL COMMENT '租户前缀',
  `expiration_at` datetime DEFAULT NULL COMMENT '到期日期',
  `stop_at` datetime DEFAULT NULL COMMENT '停用日期',
  `username` varchar(128) DEFAULT NULL COMMENT '租户管理员登陆名',
  PRIMARY KEY (`companyId`)
) ENGINE=InnoDB AUTO_INCREMENT=10008 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ucc_companyinfo
-- ----------------------------
INSERT INTO `ucc_companyinfo` VALUES ('1', '10000', '远传技术中心', '默认租户', '余金龙', '15167177621', '1126280688@qq.com', '0', '2018-01-15 19:20:30', '10000.0000', '0', '2018-03-14 13:16:11', '钱塘江边', 'www.utry.cn', '', '', '99999', '2027-03-12 14:56:55', null, '');
INSERT INTO `ucc_companyinfo` VALUES ('4b74018221ae11e8b516000c29b4fb81', '10001', '中文', '22', 'qiweiguang', 'qiweiguang', '112', '0', '2018-03-07 10:21:50', '0.0000', '0', '2018-03-07 13:29:17', '22', '11', '', '', '10001', null, null, null);
INSERT INTO `ucc_companyinfo` VALUES ('76a9c64621cd11e8aac3000c29b4fb81', '10002', '远传信息11MMM', '高达发多少fx111', '方星fff443', 'gfafds', 'fx111@qq.com', '1', '2018-03-07 14:04:57', '0.0000', '0', '2018-03-07 14:33:31', '高达发多少fx111', 'fx111', '', '123456', 'fx111', null, '2018-03-07 14:40:59', null);
INSERT INTO `ucc_companyinfo` VALUES ('0156ecaf21d311e8aac3000c29b4fb81', '10003', '远方MMM111', '', '方星', 'fx123456', '', '0', '2018-03-07 14:44:37', '0.0000', '0', '2018-03-08 17:15:55', '', '', '', '', '66666', null, null, null);
INSERT INTO `ucc_companyinfo` VALUES ('eb45677d22b111e8989d000c29b4fb81', '10004', 'testt', '', 'testt', 'testt', '', '0', '2018-03-08 17:20:18', '0.0000', '0', '2018-03-08 17:20:49', '', '', '', '', 'testt', null, null, '');
INSERT INTO `ucc_companyinfo` VALUES ('b6f83fb5234811e8989d000c29b4fb81', '10005', 'test0309', '', '方星', 'fx456789', '', '0', '2018-03-09 11:19:44', '0.0000', '0', '2018-03-13 11:03:49', '', '', '', '123456', '55555', '2018-03-31 10:06:47', null, 'fx456789');
INSERT INTO `ucc_companyinfo` VALUES ('0081a564266c11e8bbbf000c29b4fb81', '10006', 'qwg1', '', 'qwg', '18888888888', '', '0', '2018-03-13 11:09:54', '0.0000', '0', '2018-03-13 11:09:54', '', '', '', '123456', '66665', '2018-03-30 11:13:22', null, 'qwg1');
INSERT INTO `ucc_companyinfo` VALUES ('b3a6de49272911e8bbbf000c29b4fb81', '10007', '租户010', '', '方星', '15157140210', '', '0', '2018-03-14 09:47:49', '0.0000', '0', '2018-03-14 09:47:49', '', '', '', '123456', '40010', '2018-03-31 09:50:53', null, 'fxx123456');

-- ----------------------------
-- Table structure for ucc_company_limit
-- ----------------------------
DROP TABLE IF EXISTS `ucc_company_limit`;
CREATE TABLE `ucc_company_limit` (
  `uuid` varchar(32) NOT NULL COMMENT '主键',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  `root_number` varchar(50) DEFAULT NULL COMMENT '总机',
  `ext_number` int(11) DEFAULT '0' COMMENT '分机个数',
  `record_number` int(11) DEFAULT '0' COMMENT '录音分机个数',
  `extg_number` int(11) DEFAULT '0' COMMENT '分机组个数',
  `ivr_state` smallint(6) DEFAULT '0' COMMENT 'IVR{0:开通,1:停用}',
  `external_number` varchar(255) DEFAULT NULL COMMENT '外显号码，多个号码之间逗号隔开',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ucc_company_limit
-- ----------------------------
INSERT INTO `ucc_company_limit` VALUES ('008723a8266c11e8bbbf000c29b4fb81', '2018-03-13 11:09:54', '2018-03-13 11:09:54', '10006', '0', '1', '1', '1', '0', '');
INSERT INTO `ucc_company_limit` VALUES ('01595db321d311e8aac3000c29b4fb81', '2018-03-07 14:44:37', '2018-03-08 17:15:55', '10003', '66666000', '25', '20', '2', '0', '6666777,666888,6666999');
INSERT INTO `ucc_company_limit` VALUES ('1', '2018-02-24 09:51:42', '2018-03-14 13:16:11', '10000', '1234567', '100', '50', '10', '0', '1234567');
INSERT INTO `ucc_company_limit` VALUES ('4b7b548621ae11e8b516000c29b4fb81', '2018-03-07 10:21:50', '2018-03-07 13:29:17', '10001', '100', '100', '100', '100', '0', '');
INSERT INTO `ucc_company_limit` VALUES ('76b007da21cd11e8aac3000c29b4fb81', '2018-03-07 14:04:57', '2018-03-07 14:33:31', '10002', '0', '10000', '1000', '20', '0', '');
INSERT INTO `ucc_company_limit` VALUES ('b3aa87cd272911e8bbbf000c29b4fb81', '2018-03-14 09:47:49', '2018-03-14 09:47:49', '10007', '0', '200', '50', '4', '0', '');
INSERT INTO `ucc_company_limit` VALUES ('b6fc5e69234811e8989d000c29b4fb81', '2018-03-09 11:19:44', '2018-03-13 11:03:49', '10005', '55555000', '100', '20', '3', '0', '5715556,5715557,5715558,5715559');
INSERT INTO `ucc_company_limit` VALUES ('eb4bd02122b111e8989d000c29b4fb81', '2018-03-08 17:20:18', '2018-03-08 17:20:49', '10004', '0', '10', '0', '0', '0', '17605888821');

-- ----------------------------
-- Table structure for ucc_extra_number
-- ----------------------------
DROP TABLE IF EXISTS `ucc_extra_number`;
CREATE TABLE `ucc_extra_number` (
  `uuid` varchar(32) NOT NULL COMMENT '主键',
  `extra_number` varchar(50) DEFAULT NULL COMMENT '外显示号码',
  `direction` varchar(10) DEFAULT NULL COMMENT '呼叫方向',
  `limit_id` varchar(32) DEFAULT NULL COMMENT '主表ID',
  `vlan_id` int(11) DEFAULT NULL COMMENT '租户ID',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `flag` smallint(6) DEFAULT '0' COMMENT '是否被使用{0：未被使用，1：使用中}',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ucc_extra_number
-- ----------------------------
INSERT INTO `ucc_extra_number` VALUES ('6b9a2aac227a11e8a78d000c29b4fb81', '666888', null, '0156ecaf21d311e8aac3000c29b4fb81', '10003', '2018-03-08 10:43:02', '2018-03-08 10:43:02', '0');
INSERT INTO `ucc_extra_number` VALUES ('72b355fe227a11e8a78d000c29b4fb81', '6666999', null, '0156ecaf21d311e8aac3000c29b4fb81', '10003', '2018-03-08 10:43:14', '2018-03-08 10:43:14', '0');
INSERT INTO `ucc_extra_number` VALUES ('b2502f51266211e8bbbf000c29b4fb81', '5715557', null, 'b6f83fb5234811e8989d000c29b4fb81', '10005', '2018-03-13 10:03:17', '2018-03-13 10:03:17', '1');
INSERT INTO `ucc_extra_number` VALUES ('b250f2a2266211e8bbbf000c29b4fb81', '5715558', null, 'b6f83fb5234811e8989d000c29b4fb81', '10005', '2018-03-13 10:03:17', '2018-03-13 10:03:17', '0');
INSERT INTO `ucc_extra_number` VALUES ('b25167d3266211e8bbbf000c29b4fb81', '5715559', null, 'b6f83fb5234811e8989d000c29b4fb81', '10005', '2018-03-13 10:03:17', '2018-03-13 10:03:17', '0');
INSERT INTO `ucc_extra_number` VALUES ('b6fd48ca234811e8989d000c29b4fb81', '5715556', null, 'b6fc5e69234811e8989d000c29b4fb81', '10005', '2018-03-09 11:19:44', '2018-03-09 11:19:44', '1');
INSERT INTO `ucc_extra_number` VALUES ('cf912570274611e8bbbf000c29b4fb81', '1234567', null, '1', '10000', '2018-03-14 13:16:11', '2018-03-14 13:16:11', '0');
INSERT INTO `ucc_extra_number` VALUES ('f141d2da227911e8a78d000c29b4fb81', '6666777', null, '0156ecaf21d311e8aac3000c29b4fb81', '10003', '2018-03-08 10:39:36', '2018-03-08 10:39:36', '1');
INSERT INTO `ucc_extra_number` VALUES ('f484f54222b111e8989d000c29b4fb81', '17605888821', null, 'eb45677d22b111e8989d000c29b4fb81', '10004', '2018-03-08 17:20:34', '2018-03-08 17:20:34', '0');

-- ----------------------------
-- Table structure for ucc_holiday
-- ----------------------------
DROP TABLE IF EXISTS `ucc_holiday`;
CREATE TABLE `ucc_holiday` (
  `uuid` varchar(32) NOT NULL COMMENT '主键',
  `year` varchar(4) DEFAULT NULL COMMENT '年份',
  `date` varchar(21) DEFAULT NULL COMMENT '日期',
  `name` varchar(10) DEFAULT NULL COMMENT '节假日名称',
  `create_at` datetime DEFAULT NULL COMMENT '插入时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节假日';

-- ----------------------------
-- Records of ucc_holiday
-- ----------------------------
INSERT INTO `ucc_holiday` VALUES ('06d687bc0d4411e8a58194de80e04dd2', '2018', '2018-04-08至2018-04-08', '补班', '2018-02-09 10:50:46', '2018-02-09 10:50:46');
INSERT INTO `ucc_holiday` VALUES ('1320965d0d4411e8a58194de80e04dd2', '2018', '2018-04-28至2018-04-28', '补班', '2018-02-09 10:51:06', '2018-02-09 10:51:06');
INSERT INTO `ucc_holiday` VALUES ('210960de0d4411e8a58194de80e04dd2', '2018', '2018-09-29至2018-09-30', '补班', '2018-02-09 10:51:30', '2018-02-09 10:51:30');
INSERT INTO `ucc_holiday` VALUES ('7d3a1b800d4311e8abff94de80e04dd2', '2018', '2018-01-01至2018-01-01', '元旦', '2018-02-09 10:46:55', '2018-02-09 10:46:55');
INSERT INTO `ucc_holiday` VALUES ('8eba3d910d4311e8abff94de80e04dd2', '2018', '2018-02-15至2018-02-21', '春节', '2018-02-09 10:47:24', '2018-02-09 10:47:24');
INSERT INTO `ucc_holiday` VALUES ('bae96d450d4311e8a58194de80e04dd2', '2018', '2018-04-05至2018-04-07', '清明', '2018-02-09 10:48:38', '2018-02-09 10:48:38');
INSERT INTO `ucc_holiday` VALUES ('c3d5f9060d4311e8a58194de80e04dd2', '2018', '2018-04-29至2018-05-01', '劳动节', '2018-02-09 10:48:53', '2018-02-09 10:48:53');
INSERT INTO `ucc_holiday` VALUES ('d20f54870d4311e8a58194de80e04dd2', '2018', '2018-06-16至2018-06-18', '端午', '2018-02-09 10:49:17', '2018-02-09 10:49:17');
INSERT INTO `ucc_holiday` VALUES ('dd232d180d4311e8a58194de80e04dd2', '2018', '2018-09-22至2018-09-24', '中秋', '2018-02-09 10:49:36', '2018-02-09 10:49:36');
INSERT INTO `ucc_holiday` VALUES ('e7820d890d4311e8a58194de80e04dd2', '2018', '2018-10-01至2018-10-07', '国庆', '2018-02-09 10:49:53', '2018-02-09 10:49:53');
INSERT INTO `ucc_holiday` VALUES ('f59606ba0d4311e8a58194de80e04dd2', '2018', '2018-02-11至2018-02-11', '补班', '2018-02-09 10:50:17', '2018-02-09 10:50:17');
INSERT INTO `ucc_holiday` VALUES ('fe70df3b0d4311e8a58194de80e04dd2', '2018', '2018-02-24至2018-02-24', '补班', '2018-02-09 10:50:32', '2018-02-09 10:50:32');

-- ----------------------------
-- Table structure for ucc_menuinfo
-- ----------------------------
DROP TABLE IF EXISTS `ucc_menuinfo`;
CREATE TABLE `ucc_menuinfo` (
  `uuid` char(32) NOT NULL COMMENT '菜单ID',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `menuText` text COMMENT '菜单正文',
  `descript` varchar(200) DEFAULT NULL COMMENT '菜单描述',
  `state` tinyint(4) DEFAULT '0' COMMENT '用来标志主菜单，只有主菜单为1其他均为0',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ucc_menuinfo
-- ----------------------------
INSERT INTO `ucc_menuinfo` VALUES ('1', '2018-02-27 16:07:20', '2018-01-22 11:45:41', '{\"id\":1,\"children\":[{\"id\":101,\"children\":[{\"id\":10101,\"children\":[{\"id\":1010101,\"children\":[],\"label\":\"分机管理\"},{\"id\":1010102,\"children\":[],\"label\":\"分机组管理\"}],\"label\":\"分机管理\"},{\"id\":10102,\"children\":[{\"id\":1010201,\"children\":[],\"label\":\"路由管理\"},{\"id\":1010202,\"children\":[],\"label\":\"网关管理\"},{\"id\":1010203,\"children\":[],\"label\":\"网关组管理\"}],\"label\":\"网关和路由管理\"},{\"id\":10103,\"children\":[{\"id\":1010301,\"children\":[],\"label\":\"号码变换\"}],\"label\":\"号码变换\"}],\"label\":\"分机管理\"},{\"id\":103,\"children\":[{\"id\":10304,\"children\":[{\"id\":1030401,\"children\":[],\"label\":\"录音配置\"},{\"id\":1030402,\"children\":[],\"label\":\"录音记录\"}],\"label\":\"录音管理\"},{\"children\":[{\"children\":[],\"id\":1030501,\"label\":\"呼叫失败\"},{\"children\":[],\"id\":1030502,\"label\":\"外呼限制管理\"}],\"id\":10305,\"label\":\"呼叫管理\"}],\"label\":\"话务管理\"},{\"id\":104,\"children\":[{\"id\":10401,\"children\":[{\"id\":1040102,\"children\":[],\"label\":\"用户管理\"},{\"id\":1040103,\"children\":[],\"label\":\"角色管理\"},{\"id\":1040104,\"children\":[],\"label\":\"菜单管理\"}],\"label\":\"用户相关管理\"},{\"id\":10402,\"children\":[{\"id\":1040201,\"children\":[],\"label\":\"系统参数配置\"},{\"id\":1040202,\"children\":[],\"label\":\"文件上传\"},{\"id\":1040203,\"children\":[],\"label\":\"节假日设置\"}],\"label\":\"系统参数管理\"},{\"children\":[{\"children\":[],\"id\":1040301,\"label\":\"工作日列表\"},{\"children\":[],\"id\":1040302,\"label\":\"工作日设置\"}],\"id\":10403,\"label\":\"工作时间\"},{\"children\":[{\"children\":[],\"id\":1040401,\"label\":\"IVR菜单管理\"},{\"children\":[],\"id\":1040402,\"label\":\"IVR子菜单管理\"}],\"id\":10404,\"label\":\"IVR管理\"},{\"children\":[{\"children\":[],\"id\":1040501,\"label\":\"主叫黑名单管理\"},{\"children\":[],\"id\":1040502,\"label\":\"被叫黑名单管理\"}],\"id\":10405,\"label\":\"黑名单\"},{\"children\":[{\"children\":[],\"id\":1040601,\"label\":\"分机密码修改\"},{\"children\":[],\"id\":1040602,\"label\":\"修改密码\"}],\"id\":10406,\"label\":\"密码修改\"}],\"label\":\"设置\"},{\"id\":105,\"children\":[{\"id\":10501,\"children\":[{\"id\":1050101,\"children\":[],\"label\":\"分机信息\"}],\"label\":\"账号详情\"}],\"label\":\"账号详情\"},{\"id\":106,\"children\":[{\"id\":10601,\"children\":[{\"id\":1060101,\"children\":[],\"label\":\"留言查询\"},{\"id\":1060102,\"children\":[],\"label\":\"通话记录\"}],\"label\":\"通话记录\"}],\"label\":\"通话记录\"},{\"children\":[{\"children\":[{\"children\":[],\"id\":1070101,\"label\":\"话务详情\"}],\"id\":10701,\"label\":\"运营报表\"}],\"id\":107,\"label\":\"运营报表\"},{\"children\":[{\"children\":[{\"children\":[],\"id\":1080101,\"label\":\"企业账户\"}],\"id\":10801,\"label\":\"企业账户\"}],\"id\":108,\"label\":\"企业账户\"},{\"children\":[{\"children\":[{\"children\":[],\"id\":1090101,\"label\":\"租户设置\"},{\"children\":[],\"id\":1090102,\"label\":\"租户开通\"}],\"id\":10901,\"label\":\"租户管理\"}],\"id\":109,\"label\":\"租户管理\"}],\"label\":\"根菜单\",\"parentid\":null}', '主菜单', '1', '10000');
INSERT INTO `ucc_menuinfo` VALUES ('32729b2b000811e8849394de80e04dd2', '2018-03-09 09:16:34', '2018-01-23 14:39:44', '1,101,103,104,106,109,10101,10102,10103,10304,10305,10401,10402,10403,10404,10405,10406,10601,10901,1010101,1010102,1010201,1010202,1010203,1010301,1030402,1030501,1040102,1040103,1040104,1040201,1040202,1040203,1040301,1040302,1040401,1040402,1040501,1040502,1040602,1060101,1060102,1090101,1090102', null, '0', '10000');
INSERT INTO `ucc_menuinfo` VALUES ('9ff153ff0c7511e89f0694de80e04dd2', '2018-02-27 16:15:31', '2018-02-08 10:13:17', '1,104,105,106,10406,10501,10601,1040601,1050101,1060101,1060102', null, '0', '10000');
INSERT INTO `ucc_menuinfo` VALUES ('f3c1c7511b9511e8a64a94de80e04dd2', '2018-02-27 16:12:29', '2018-02-27 16:12:29', '1,107,109,10701,10901,1070101,1090101,1090102', null, '0', '0');
INSERT INTO `ucc_menuinfo` VALUES ('f6974c1d059011e8893a94de80e04dd2', '2018-03-08 13:48:35', '2018-01-30 15:41:21', '1,101,104,106,108,10101,10403,10405,10406,10601,10801,1010101,1010102,1040301,1040302,1040501,1040502,1040602,1060102,1080101', null, '0', '10000');

-- ----------------------------
-- Table structure for ucc_role
-- ----------------------------
DROP TABLE IF EXISTS `ucc_role`;
CREATE TABLE `ucc_role` (
  `uuid` varchar(32) NOT NULL COMMENT '角色id',
  `name` varchar(50) DEFAULT NULL COMMENT '角色名',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `menuId` varchar(32) DEFAULT NULL COMMENT '菜单ID',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ucc_role
-- ----------------------------
INSERT INTO `ucc_role` VALUES ('1', '超级管理员', '拥有最高权限', '2018-02-27 16:07:41', '2018-01-15 19:23:12', '32729b2b000811e8849394de80e04dd2', '10000');
INSERT INTO `ucc_role` VALUES ('57c11a401b9511e8a64a94de80e04dd2', '运营管理员', '运营人员用', '2018-02-27 16:12:29', '2018-02-27 16:08:07', 'f3c1c7511b9511e8a64a94de80e04dd2', '10000');
INSERT INTO `ucc_role` VALUES ('90f4334e0c7511e89f0694de80e04dd2', '普通分机用户', '普通分机用户', '2018-02-08 10:13:17', '2018-02-08 10:12:52', '9ff153ff0c7511e89f0694de80e04dd2', '10000');
INSERT INTO `ucc_role` VALUES ('e166cc39059011e8893a94de80e04dd2', '租户管理员', '客户的管理员', '2018-02-08 10:12:43', '2018-01-30 15:40:45', 'f6974c1d059011e8893a94de80e04dd2', '10000');

-- ----------------------------
-- Table structure for ucc_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `ucc_role_menu`;
CREATE TABLE `ucc_role_menu` (
  `roleId` char(32) NOT NULL COMMENT '角色ID',
  `menuId` char(32) NOT NULL COMMENT '菜单ID',
  `uuid` varchar(32) NOT NULL COMMENT '主键',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ucc_role_menu
-- ----------------------------
INSERT INTO `ucc_role_menu` VALUES ('1', '32729b2b000811e8849394de80e04dd2', '1', '1');

-- ----------------------------
-- Table structure for ucc_schedule
-- ----------------------------
DROP TABLE IF EXISTS `ucc_schedule`;
CREATE TABLE `ucc_schedule` (
  `uuid` varchar(32) NOT NULL COMMENT '节假日ID',
  `vlan_id` int(11) DEFAULT NULL COMMENT '租户ID',
  `schedule_name` varchar(40) DEFAULT NULL COMMENT '节假日名称',
  `schedule_status` char(1) DEFAULT '0' COMMENT '是否启用节假日{0：启用，1不启用}',
  `time_message` varchar(450) DEFAULT NULL COMMENT '具体时间',
  `switch_content` varchar(255) DEFAULT NULL COMMENT '转接内容',
  `switch_phone` varchar(255) DEFAULT NULL COMMENT '转接电话',
  `switch_stype` varchar(255) DEFAULT NULL COMMENT '转接类型',
  `data_id` varchar(32) DEFAULT NULL COMMENT '数据ID',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `year` varchar(10) DEFAULT NULL COMMENT '年份',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ucc_schedule
-- ----------------------------
INSERT INTO `ucc_schedule` VALUES ('1d9d3cd6235b11e88e78000c29b4fb81', '10005', '', '0', '3 1,2,5,6,7,8,9,12,13,14,15,16,19,20,21,22,23,26,27,28,29,30 08:30 17:00', null, null, null, null, '', '2018-03-09 13:31:28', '2018-03-09 13:31:28', '2018');
INSERT INTO `ucc_schedule` VALUES ('dc11ca2121e911e8a78d000c29b4fb81', '10003', '', '0', '3 1,2,5,6,8,9,12,13,14,15,16,19,20,21,22,23,26,27,28,29,30 08:30 18:00', null, null, null, null, '', '2018-03-07 17:28:13', '2018-03-07 17:32:32', '2018');

-- ----------------------------
-- Table structure for ucc_systemconfig
-- ----------------------------
DROP TABLE IF EXISTS `ucc_systemconfig`;
CREATE TABLE `ucc_systemconfig` (
  `uuid` varchar(32) NOT NULL COMMENT '配置项ID',
  `confName` varchar(100) DEFAULT NULL COMMENT '配置项名称',
  `confValue` varchar(100) DEFAULT NULL COMMENT '配置项值',
  `confType` varchar(50) DEFAULT NULL COMMENT '配置项种类',
  `companyId` varchar(32) DEFAULT NULL COMMENT '租户ID,0:表示全局变量',
  `confCode` varchar(32) DEFAULT NULL COMMENT '配置项编号',
  `status` varchar(1) DEFAULT NULL COMMENT '是否启用{0：启用，1：停用}',
  `introduce` varchar(50) DEFAULT NULL COMMENT '简介',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ucc_systemconfig
-- ----------------------------
INSERT INTO `ucc_systemconfig` VALUES ('0c00a1e20efe11e88cce94de80e04dd2', '获取分机状态', 'http://127.0.0.1:8080/webgetdata/ext_state', 'url', '0', 'ext_state_url', '0', '获取分机状态', '2018-02-11 15:34:52', '2018-02-11 15:34:52', '0');
INSERT INTO `ucc_systemconfig` VALUES ('15693d2b065711e8904c94de80e04dd2', '其他类型文件存储路径', 'other', 'path', '0', 'other', '0', '其他类型文件存储路径', '2018-01-31 15:19:33', '2018-01-31 15:19:33', '0');
INSERT INTO `ucc_systemconfig` VALUES ('1e9ca19f064d11e89aa494de80e04dd2', 'IVR存储路径', 'ivr', 'path', '0', 'ivr', '0', 'IVR上传相对路径', '2018-01-31 14:08:13', '2018-01-31 14:08:13', '0');
INSERT INTO `ucc_systemconfig` VALUES ('a486f81e064c11e89aa494de80e04dd2', '文件上传全局路径', '/usr/local/freeswitch/sounds', 'path', '0', 'rootPath', '0', '文件上传全局路径', '2018-01-31 14:04:48', '2018-02-23 14:29:47', '0');
INSERT INTO `ucc_systemconfig` VALUES ('d4977558065611e8904c94de80e04dd2', '会议类型文件存储路径', 'meeting', 'path', '0', 'meeting', '0', '会议类型文件存储路径', '2018-01-31 15:17:44', '2018-01-31 15:17:44', '0');
INSERT INTO `ucc_systemconfig` VALUES ('dd720ae00a5011e898cd94de80e04dd2', '录音存过地址', 'records', 'path', '0', 'records', '0', '录音存过地址', '2018-02-05 16:45:06', '2018-02-23 14:29:27', '0');
INSERT INTO `ucc_systemconfig` VALUES ('edc90b19065611e8904c94de80e04dd2', '分机类型文件存储路径', 'extensions', 'path', '0', 'extensions', '0', '分机类型文件存储路径', '2018-01-31 15:18:26', '2018-02-23 14:29:20', '0');
INSERT INTO `ucc_systemconfig` VALUES ('ffa4939a065611e8904c94de80e04dd2', '语音留言类型配置路径', 'voicemail', 'path', '0', 'voicemail', '0', '语音留言类型配置路径', '2018-01-31 15:18:56', '2018-02-23 14:29:05', '0');

-- ----------------------------
-- Table structure for ucc_uploadfile
-- ----------------------------
DROP TABLE IF EXISTS `ucc_uploadfile`;
CREATE TABLE `ucc_uploadfile` (
  `uuid` varchar(32) NOT NULL COMMENT '主键',
  `vlan_id` int(11) DEFAULT NULL COMMENT '租户ID ',
  `filetype` varchar(255) DEFAULT NULL COMMENT '文件类型{IVR  会议  分机  语音留言}',
  `filepath` varchar(255) DEFAULT NULL COMMENT '文件绝对路径',
  `filename` varchar(255) DEFAULT NULL COMMENT '原始文件名称',
  `upload_user` varchar(255) DEFAULT NULL COMMENT '上传者ID',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注，必须保证唯一',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `uploadfile_remark` (`remark`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件上传';

-- ----------------------------
-- Records of ucc_uploadfile
-- ----------------------------
INSERT INTO `ucc_uploadfile` VALUES ('230e51d7186311e88840000c29b4fb81', '10000', 'meeting', '/usr/local/freeswitch/sounds/meeting/20180223143108_829vm1.wav', 'vm1.wav', '1', '2018-02-23 14:31:10', '2018-02-23 14:31:10', null);
INSERT INTO `ucc_uploadfile` VALUES ('98fe1934235d11e88e78000c29b4fb81', '10000', 'voicemessage', '/usr/local/freeswitch/sounds/other/20180309134912_745新增机构.jmx', '新增机构.jmx', '1', '2018-03-09 13:49:14', '2018-03-09 13:49:14', null);

-- ----------------------------
-- Table structure for ucc_user
-- ----------------------------
DROP TABLE IF EXISTS `ucc_user`;
CREATE TABLE `ucc_user` (
  `uuid` varchar(32) NOT NULL COMMENT '主键',
  `username` varchar(128) DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `user_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='后台管理用户表';

-- ----------------------------
-- Records of ucc_user
-- ----------------------------
INSERT INTO `ucc_user` VALUES ('00835315266c11e8bbbf000c29b4fb81', 'qwg1', 'E10ADC3949BA59ABBE56E057F20F883E', '2018-03-13 11:09:54', '2018-03-13 11:09:54', '10006');
INSERT INTO `ucc_user` VALUES ('0157d71021d311e8aac3000c29b4fb81', null, 'E10ADC3949BA59ABBE56E057F20F883E', '2018-03-07 14:44:37', '2018-03-07 14:44:37', '10003');
INSERT INTO `ucc_user` VALUES ('1', 'admin', 'E10ADC3949BA59ABBE56E057F20F883E', '2017-12-22 00:00:00', '2017-12-22 11:25:08', '10000');
INSERT INTO `ucc_user` VALUES ('2', 'extension', 'E10ADC3949BA59ABBE56E057F20F883E', '2018-02-23 10:37:01', '2018-02-23 10:36:57', '10000');
INSERT INTO `ucc_user` VALUES ('4b764b7321ae11e8b516000c29b4fb81', '中文', 'E10ADC3949BA59ABBE56E057F20F883E', '2018-03-07 10:21:50', '2018-03-07 10:21:50', '10001');
INSERT INTO `ucc_user` VALUES ('b3a864ea272911e8bbbf000c29b4fb81', 'fxx123456', 'E10ADC3949BA59ABBE56E057F20F883E', '2018-03-14 09:47:49', '2018-03-14 09:47:49', '10007');
INSERT INTO `ucc_user` VALUES ('b6f9ed66234811e8989d000c29b4fb81', 'fx456789', 'E10ADC3949BA59ABBE56E057F20F883E', '2018-03-09 11:19:44', '2018-03-09 11:19:44', '10005');
INSERT INTO `ucc_user` VALUES ('e3b913f21b9e11e8a64a94de80e04dd2', 'utry', 'E10ADC3949BA59ABBE56E057F20F883E', '2018-02-27 17:16:27', '2018-02-27 17:16:27', '10000');
INSERT INTO `ucc_user` VALUES ('eb47634e22b111e8989d000c29b4fb81', 'testt', '147538DA338B770B61E592AFC92B1EE6', '2018-03-08 17:20:18', '2018-03-08 17:20:18', '10004');

-- ----------------------------
-- Table structure for ucc_user_role
-- ----------------------------
DROP TABLE IF EXISTS `ucc_user_role`;
CREATE TABLE `ucc_user_role` (
  `user_id` varchar(32) NOT NULL COMMENT '用户id',
  `role_id` varchar(32) NOT NULL COMMENT '用户id对应的角色id',
  `uuid` varchar(32) NOT NULL,
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ucc_user_role
-- ----------------------------
INSERT INTO `ucc_user_role` VALUES ('00835315266c11e8bbbf000c29b4fb81', 'e166cc39059011e8893a94de80e04dd2', '0085eb27266c11e8bbbf000c29b4fb81', '10006');
INSERT INTO `ucc_user_role` VALUES ('0157d71021d311e8aac3000c29b4fb81', 'e166cc39059011e8893a94de80e04dd2', '0158735221d311e8aac3000c29b4fb81', '10003');
INSERT INTO `ucc_user_role` VALUES ('1', '1', '1', '0');
INSERT INTO `ucc_user_role` VALUES ('2', '90f4334e0c7511e89f0694de80e04dd2', '2', '0');
INSERT INTO `ucc_user_role` VALUES ('4b764b7321ae11e8b516000c29b4fb81', 'e166cc39059011e8893a94de80e04dd2', '4b78474521ae11e8b516000c29b4fb81', '10001');
INSERT INTO `ucc_user_role` VALUES ('b3a864ea272911e8bbbf000c29b4fb81', 'e166cc39059011e8893a94de80e04dd2', 'b3a9765c272911e8bbbf000c29b4fb81', '10007');
INSERT INTO `ucc_user_role` VALUES ('b6f9ed66234811e8989d000c29b4fb81', 'e166cc39059011e8893a94de80e04dd2', 'b6fb25e8234811e8989d000c29b4fb81', '10005');
INSERT INTO `ucc_user_role` VALUES ('e3b913f21b9e11e8a64a94de80e04dd2', '57c11a401b9511e8a64a94de80e04dd2', 'e3bb84f41b9e11e8a64a94de80e04dd2', '10000');
INSERT INTO `ucc_user_role` VALUES ('eb47634e22b111e8989d000c29b4fb81', 'e166cc39059011e8893a94de80e04dd2', 'eb4a709022b111e8989d000c29b4fb81', '10004');

-- ----------------------------
-- Table structure for voip_gateway
-- ----------------------------
DROP TABLE IF EXISTS `voip_gateway`;
CREATE TABLE `voip_gateway` (
  `uuid` varchar(64) NOT NULL COMMENT '主键ID',
  `gateway_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '网关ID',
  `gateway_name` varchar(128) DEFAULT NULL COMMENT '网关名称',
  `limit_type` int(11) DEFAULT '0' COMMENT '限定类型{0，不做任何限定，1：被叫黑名单启用}',
  `remote_addr` varchar(256) DEFAULT NULL COMMENT '网关IP',
  `remote_port` int(11) DEFAULT NULL COMMENT '远程服务器端口',
  `priority` int(11) DEFAULT '1' COMMENT '优先级',
  `status` int(11) DEFAULT '1' COMMENT '网关状态',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`gateway_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of voip_gateway
-- ----------------------------
INSERT INTO `voip_gateway` VALUES ('5589583921e211e8a78d000c29b4fb81', '3', '网关一', '0', 'http://10.0.10.61', '9085', '100', '1', '2018-03-07 16:34:21', '2018-03-07 16:47:10', '10003');

-- ----------------------------
-- Table structure for voip_gateway_group
-- ----------------------------
DROP TABLE IF EXISTS `voip_gateway_group`;
CREATE TABLE `voip_gateway_group` (
  `uuid` varchar(64) NOT NULL COMMENT '主键ID',
  `group_id` int(11) DEFAULT NULL COMMENT '网关组ID',
  `gateway_id` int(11) DEFAULT NULL COMMENT '网关ID',
  `gateway_name` varchar(255) DEFAULT NULL COMMENT '网关名称',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of voip_gateway_group
-- ----------------------------
INSERT INTO `voip_gateway_group` VALUES ('681e93ca21e211e8a78d000c29b4fb81', '1000', '3', '', '2018-03-07 16:34:52', '2018-03-07 16:34:52', '10003');
INSERT INTO `voip_gateway_group` VALUES ('6ec8d0ab21e211e8a78d000c29b4fb81', '200', null, '', '2018-03-07 16:35:03', '2018-03-07 16:35:03', '10003');

-- ----------------------------
-- Table structure for voip_routers
-- ----------------------------
DROP TABLE IF EXISTS `voip_routers`;
CREATE TABLE `voip_routers` (
  `uuid` varchar(64) NOT NULL COMMENT '主键ID',
  `route_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由自增ID',
  `route_name` varchar(128) DEFAULT NULL COMMENT '名称',
  `caller_prefix` varchar(128) DEFAULT NULL COMMENT '主叫前缀',
  `callee_prefix` varchar(128) DEFAULT '*' COMMENT '被叫前缀',
  `caller_suffix` varchar(128) DEFAULT NULL COMMENT '主叫后缀',
  `callee_suffix` varchar(128) DEFAULT NULL COMMENT '被叫后缀',
  `call_direction` int(11) NOT NULL DEFAULT '0' COMMENT '呼叫方向{0：本地，1：网关，2:IVR,3语音留言}',
  `direction_data` varchar(128) DEFAULT NULL COMMENT '方向数据',
  `gateway_group_id` int(11) DEFAULT NULL COMMENT '网关组ID{只有当呼叫目的是网关时才有效}',
  `caller_num_change_id` int(11) DEFAULT '-1' COMMENT '主叫变换规则',
  `callee_num_change_id` int(11) DEFAULT '-1' COMMENT '被叫变换规则',
  `notworktime_id` int(11) DEFAULT NULL COMMENT '非工作时间ID',
  `vm_number` varchar(128) DEFAULT NULL COMMENT '语音留言绑定的内线号码',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_at` datetime DEFAULT NULL COMMENT '更新时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  `vlan_id` int(11) DEFAULT '0' COMMENT '租户ID',
  `default_domain` varchar(128) DEFAULT NULL COMMENT '默认域',
  PRIMARY KEY (`route_id`),
  KEY `caller_prefix` (`caller_prefix`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of voip_routers
-- ----------------------------
INSERT INTO `voip_routers` VALUES ('159c801a21e711e8a78d000c29b4fb81', '16', '本地', '.*', '.*', '.*', '.*', '0', '', '-1', '-1', '-1', null, '', '', '2018-03-07 17:08:21', '2018-03-07 17:08:21', '10003', null);
INSERT INTO `voip_routers` VALUES ('ce2a9bd121eb11e8a78d000c29b4fb81', '17', 'ivr', '.*', '5716666', '.*', '.*', '2', 'ipcc_ivr', '-1', '-1', '-1', null, '', '', '2018-03-07 17:42:09', '2018-03-07 17:42:09', '10003', null);
INSERT INTO `voip_routers` VALUES ('2cec129f237311e8875f000c29b4fb81', '18', '接入码', '.*', '57155555', '.*', '.*', '2', 'test_ivr', '-1', '-1', '-1', null, '55555000', '', '2018-03-09 16:23:41', '2018-03-09 16:25:29', '10005', null);
INSERT INTO `voip_routers` VALUES ('3f66b88e273011e8bbbf000c29b4fb81', '19', '本地', '.*', '.*', '.*', '.*', '0', '', '-1', '-1', '-1', null, '', '', '2018-03-14 10:34:41', '2018-03-14 10:34:41', '10007', null);
