/*
SQLyog Professional v12.08 (64 bit)
MySQL - 5.5.29-log : Database - xapi
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `api_admin` */

DROP TABLE IF EXISTS `api_admin`;

CREATE TABLE `api_admin` (
  `a_a_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `a_a_name` varchar(18) NOT NULL COMMENT '管理员账户',
  `a_a_passwd` varchar(64) NOT NULL COMMENT '管理员密码',
  `a_a_time` time DEFAULT NULL COMMENT '登录时间',
  PRIMARY KEY (`a_a_name`),
  KEY `a_a_id` (`a_a_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `api_admin` */

insert  into `api_admin`(`a_a_id`,`a_a_name`,`a_a_passwd`,`a_a_time`) values (1,'admin','ba05b7be8feba6afd70a8785e7c10757',NULL);

/*Table structure for table `api_binding` */

DROP TABLE IF EXISTS `api_binding`;

CREATE TABLE `api_binding` (
  `a_b_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `a_b_api_id` int(10) NOT NULL COMMENT '接口id',
  `a_b_table` varchar(100) NOT NULL COMMENT '绑定表',
  `a_b_field` text NOT NULL COMMENT '绑定字段',
  `a_b_where` varchar(100) DEFAULT NULL COMMENT '查询条件',
  `a_b_sort` varchar(100) DEFAULT NULL COMMENT '排序',
  `a_b_sort_field` varchar(100) DEFAULT NULL COMMENT '排序字段',
  `a_b_val` varchar(100) DEFAULT NULL COMMENT '参数',
  `a_b_list` varchar(10) DEFAULT NULL COMMENT '数量',
  `a_b_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`a_b_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `api_binding` */

/*Table structure for table `api_info` */

DROP TABLE IF EXISTS `api_info`;

CREATE TABLE `api_info` (
  `a_l_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '接口id',
  `a_l_title` varchar(100) NOT NULL COMMENT '接口标题',
  `a_l_desc` varchar(255) DEFAULT NULL COMMENT '接口介绍',
  `a_l_alias` varchar(30) NOT NULL COMMENT '接口别名',
  `a_l_address` text NOT NULL COMMENT '接口地址',
  `a_l_format` varchar(10) NOT NULL COMMENT '返回格式',
  `a_l_mode` varchar(10) NOT NULL COMMENT '请求方式',
  `a_l_ask` longtext NOT NULL COMMENT '请求示例',
  `a_l_demo` longtext COMMENT '调用示例',
  `a_l_example` text COMMENT '返回示例',
  `a_l_data` varchar(64) DEFAULT NULL COMMENT '数据绑定',
  `a_l_show` int(10) NOT NULL DEFAULT '0' COMMENT '上架状态',
  `a_l_found_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  `a_l_count` int(10) NOT NULL DEFAULT '0' COMMENT '调用次数',
  `a_l_pay` int(10) NOT NULL DEFAULT '0' COMMENT '是否收费',
  PRIMARY KEY (`a_l_id`,`a_l_title`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `api_info` */

insert  into `api_info`(`a_l_id`,`a_l_title`,`a_l_desc`,`a_l_alias`,`a_l_address`,`a_l_format`,`a_l_mode`,`a_l_ask`,`a_l_demo`,`a_l_example`,`a_l_data`,`a_l_show`,`a_l_found_time`,`a_l_count`,`a_l_pay`) values (1,'二维码生成','快速将URL或者文字生成二维码','Qrcode','http://xapi.la/api/qrcode','JSON','GET','http://xapi.la/api/qrcode?frame=1&e=L&text=零艺客&size=200','暂无示例,站长交流群：708298599 进行交流','',NULL,1,'2020-05-10 23:06:45',0,0),(2,'ICP备案查询','快速查询域名备案信息','icp','http://xapi.la/api/icp','JSON','GET','http://xapi.la/api/icp?url=qq.com','','',NULL,1,'2020-05-10 23:41:56',1,0);

/*Table structure for table `api_order` */

DROP TABLE IF EXISTS `api_order`;

CREATE TABLE `api_order` (
  `o_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `o_u_id` int(10) NOT NULL COMMENT '用户ID',
  `o_l_id` int(10) NOT NULL COMMENT '接口id',
  `o_title` varchar(100) NOT NULL COMMENT '接口名',
  `o_pay_no` varchar(64) NOT NULL COMMENT '订单号',
  `o_type` varchar(10) NOT NULL DEFAULT '1' COMMENT '消费类型',
  `o_price` int(10) NOT NULL COMMENT '购买价格',
  `o_expire` bigint(11) NOT NULL DEFAULT '0' COMMENT '到期时间',
  `o_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '订单时间',
  PRIMARY KEY (`o_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `api_order` */

/*Table structure for table `api_owned` */

DROP TABLE IF EXISTS `api_owned`;

CREATE TABLE `api_owned` (
  `ow_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `ow_u_id` int(10) NOT NULL COMMENT '用户id',
  `ow_l_id` int(10) NOT NULL COMMENT '接口id',
  `ow_md5` varchar(32) NOT NULL COMMENT '密钥',
  `ow_ip` text COMMENT '白名单',
  `ow_count` int(10) NOT NULL DEFAULT '0' COMMENT '统计',
  `ow_start_time` bigint(11) NOT NULL DEFAULT '0' COMMENT '开始时间',
  `ow_end_time` bigint(11) NOT NULL DEFAULT '0' COMMENT '到期时间',
  `ow_found_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`ow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `api_owned` */

/*Table structure for table `api_parameter` */

DROP TABLE IF EXISTS `api_parameter`;

CREATE TABLE `api_parameter` (
  `a_p_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `a_p_api_id` int(10) NOT NULL COMMENT '接口id',
  `a_p_api_type` int(1) NOT NULL COMMENT '参数类型 0请求 1返回 2错误',
  `a_p_name` varchar(50) NOT NULL COMMENT '参数名称',
  `a_p_type` varchar(50) NOT NULL COMMENT '参数类型',
  `a_p_desc` varchar(100) NOT NULL COMMENT '参数说明',
  `a_p_crux` varchar(50) DEFAULT NULL COMMENT '是否关键',
  `a_p_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`a_p_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `api_parameter` */

/*Table structure for table `api_price` */

DROP TABLE IF EXISTS `api_price`;

CREATE TABLE `api_price` (
  `p_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `p_month` float NOT NULL DEFAULT '0' COMMENT '月费用',
  `p_season` float NOT NULL DEFAULT '0' COMMENT '季费用',
  `p_year` float NOT NULL DEFAULT '0' COMMENT '年费用',
  `p_l_id` int(10) NOT NULL COMMENT '接口id',
  PRIMARY KEY (`p_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `api_price` */

insert  into `api_price`(`p_id`,`p_month`,`p_season`,`p_year`,`p_l_id`) values (1,0,0,0,1),(2,0,0,0,2);

/*Table structure for table `api_user` */

DROP TABLE IF EXISTS `api_user`;

CREATE TABLE `api_user` (
  `a_u_id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `a_u_name` varchar(18) NOT NULL COMMENT '用户账户',
  `a_u_passwd` varchar(64) NOT NULL COMMENT '用户密码',
  `a_u_email` varchar(32) NOT NULL COMMENT '用户邮箱',
  `a_u_balance` float NOT NULL DEFAULT '0' COMMENT '用户余额',
  `a_u_found_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '注册时间',
  KEY `a_u_id` (`a_u_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `api_user` */

/*Table structure for table `api_whitelist` */

DROP TABLE IF EXISTS `api_whitelist`;

CREATE TABLE `api_whitelist` (
  `a_w_id` int(10) NOT NULL AUTO_INCREMENT,
  `w_ow_id` int(10) DEFAULT NULL,
  `w_u_id` int(10) DEFAULT NULL,
  `w_l_id` int(10) DEFAULT NULL,
  `w_ip` longtext,
  PRIMARY KEY (`a_w_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `api_whitelist` */

/*Table structure for table `codepay_order` */

DROP TABLE IF EXISTS `codepay_order`;

CREATE TABLE `codepay_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pay_id` varchar(50) NOT NULL COMMENT '用户ID或订单ID',
  `money` decimal(6,2) unsigned NOT NULL COMMENT '实际金额',
  `price` decimal(6,2) unsigned NOT NULL COMMENT '原价',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '支付方式',
  `pay_no` varchar(100) NOT NULL COMMENT '流水号',
  `param` varchar(200) DEFAULT NULL COMMENT '自定义参数',
  `pay_time` bigint(11) NOT NULL DEFAULT '0' COMMENT '付款时间',
  `pay_tag` varchar(100) NOT NULL DEFAULT '0' COMMENT '金额的备注',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '订单状态',
  `creat_time` bigint(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `up_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`pay_id`,`pay_time`,`money`,`type`,`pay_tag`),
  UNIQUE KEY `pay_no` (`pay_no`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用于区分是否已经处理';

/*Data for the table `codepay_order` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
