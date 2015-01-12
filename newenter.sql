/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : newenter

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2015-01-12 22:43:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `wy587_assets`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_assets`;
CREATE TABLE `wy587_assets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set parent.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `level` int(10) unsigned NOT NULL COMMENT 'The cached level in the nested tree.',
  `name` varchar(50) NOT NULL COMMENT 'The unique name for the asset.\n',
  `title` varchar(100) NOT NULL COMMENT 'The descriptive title for the asset.',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_asset_name` (`name`),
  KEY `idx_lft_rgt` (`lft`,`rgt`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_assets
-- ----------------------------
INSERT INTO `wy587_assets` VALUES ('1', '0', '0', '123', '0', 'root.1', 'Root Asset', '{\"core.login.site\":{\"6\":1,\"2\":1},\"core.login.admin\":{\"6\":1},\"core.login.offline\":{\"6\":1},\"core.admin\":{\"8\":1},\"core.manage\":{\"7\":1},\"core.create\":{\"6\":1,\"3\":1},\"core.delete\":{\"6\":1},\"core.edit\":{\"6\":1,\"4\":1},\"core.edit.state\":{\"6\":1,\"5\":1},\"core.edit.own\":{\"6\":1,\"3\":1}}');
INSERT INTO `wy587_assets` VALUES ('2', '1', '1', '2', '1', 'com_admin', 'com_admin', '{}');
INSERT INTO `wy587_assets` VALUES ('3', '1', '3', '6', '1', 'com_banners', 'com_banners', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('4', '1', '7', '8', '1', 'com_cache', 'com_cache', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}');
INSERT INTO `wy587_assets` VALUES ('5', '1', '9', '10', '1', 'com_checkin', 'com_checkin', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}');
INSERT INTO `wy587_assets` VALUES ('6', '1', '11', '12', '1', 'com_config', 'com_config', '{}');
INSERT INTO `wy587_assets` VALUES ('7', '1', '13', '16', '1', 'com_contact', 'com_contact', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}');
INSERT INTO `wy587_assets` VALUES ('8', '1', '17', '20', '1', 'com_content', 'com_content', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.delete\":[],\"core.edit\":{\"4\":1},\"core.edit.state\":{\"5\":1},\"core.edit.own\":[]}');
INSERT INTO `wy587_assets` VALUES ('9', '1', '21', '22', '1', 'com_cpanel', 'com_cpanel', '{}');
INSERT INTO `wy587_assets` VALUES ('10', '1', '23', '24', '1', 'com_installer', 'com_installer', '{\"core.admin\":[],\"core.manage\":{\"7\":0},\"core.delete\":{\"7\":0},\"core.edit.state\":{\"7\":0}}');
INSERT INTO `wy587_assets` VALUES ('11', '1', '25', '26', '1', 'com_languages', 'com_languages', '{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('12', '1', '27', '28', '1', 'com_login', 'com_login', '{}');
INSERT INTO `wy587_assets` VALUES ('13', '1', '29', '30', '1', 'com_mailto', 'com_mailto', '{}');
INSERT INTO `wy587_assets` VALUES ('14', '1', '31', '32', '1', 'com_massmail', 'com_massmail', '{}');
INSERT INTO `wy587_assets` VALUES ('15', '1', '33', '34', '1', 'com_media', 'com_media', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.delete\":{\"5\":1}}');
INSERT INTO `wy587_assets` VALUES ('16', '1', '35', '36', '1', 'com_menus', 'com_menus', '{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('17', '1', '37', '38', '1', 'com_messages', 'com_messages', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"7\":1}}');
INSERT INTO `wy587_assets` VALUES ('18', '1', '39', '84', '1', 'com_modules', 'com_modules', '{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('19', '1', '85', '88', '1', 'com_newsfeeds', 'com_newsfeeds', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}');
INSERT INTO `wy587_assets` VALUES ('20', '1', '89', '90', '1', 'com_plugins', 'com_plugins', '{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('21', '1', '91', '92', '1', 'com_redirect', 'com_redirect', '{\"core.admin\":{\"7\":1},\"core.manage\":[]}');
INSERT INTO `wy587_assets` VALUES ('22', '1', '93', '94', '1', 'com_search', 'com_search', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}');
INSERT INTO `wy587_assets` VALUES ('23', '1', '95', '96', '1', 'com_templates', 'com_templates', '{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('24', '1', '97', '100', '1', 'com_users', 'com_users', '{\"core.admin\":{\"7\":1},\"core.manage\":[],\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('25', '1', '101', '104', '1', 'com_weblinks', 'com_weblinks', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1},\"core.create\":{\"3\":1},\"core.delete\":[],\"core.edit\":{\"4\":1},\"core.edit.state\":{\"5\":1},\"core.edit.own\":[]}');
INSERT INTO `wy587_assets` VALUES ('26', '1', '105', '106', '1', 'com_wrapper', 'com_wrapper', '{}');
INSERT INTO `wy587_assets` VALUES ('27', '8', '18', '19', '2', 'com_content.category.2', 'Uncategorised', '{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}');
INSERT INTO `wy587_assets` VALUES ('28', '3', '4', '5', '2', 'com_banners.category.3', 'Uncategorised', '{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('29', '7', '14', '15', '2', 'com_contact.category.4', 'Uncategorised', '{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}');
INSERT INTO `wy587_assets` VALUES ('30', '19', '86', '87', '2', 'com_newsfeeds.category.5', 'Uncategorised', '{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}');
INSERT INTO `wy587_assets` VALUES ('31', '25', '102', '103', '2', 'com_weblinks.category.6', 'Uncategorised', '{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[],\"core.edit.own\":[]}');
INSERT INTO `wy587_assets` VALUES ('32', '24', '98', '99', '1', 'com_users.category.7', 'Uncategorised', '{\"core.create\":[],\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('33', '1', '107', '108', '1', 'com_finder', 'com_finder', '{\"core.admin\":{\"7\":1},\"core.manage\":{\"6\":1}}');
INSERT INTO `wy587_assets` VALUES ('34', '1', '109', '110', '1', 'com_joomlaupdate', 'com_joomlaupdate', '{\"core.admin\":[],\"core.manage\":[],\"core.delete\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('35', '1', '111', '112', '1', 'com_tags', 'com_tags', '{\"core.admin\":[],\"core.manage\":[],\"core.manage\":[],\"core.delete\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('36', '1', '113', '114', '1', 'com_contenthistory', 'com_contenthistory', '{}');
INSERT INTO `wy587_assets` VALUES ('37', '1', '115', '116', '1', 'com_ajax', 'com_ajax', '{}');
INSERT INTO `wy587_assets` VALUES ('38', '1', '117', '118', '1', 'com_postinstall', 'com_postinstall', '{}');
INSERT INTO `wy587_assets` VALUES ('39', '18', '40', '41', '2', 'com_modules.module.1', 'Main Menu', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('40', '18', '42', '43', '2', 'com_modules.module.2', 'Login', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('41', '18', '44', '45', '2', 'com_modules.module.3', 'Popular Articles', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('42', '18', '46', '47', '2', 'com_modules.module.4', 'Recently Added Articles', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('43', '18', '48', '49', '2', 'com_modules.module.8', 'Toolbar', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('44', '18', '50', '51', '2', 'com_modules.module.9', 'Quick Icons', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('45', '18', '52', '53', '2', 'com_modules.module.10', 'Logged-in Users', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('46', '18', '54', '55', '2', 'com_modules.module.12', 'Admin Menu', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('47', '18', '56', '57', '2', 'com_modules.module.13', 'Admin Submenu', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('48', '18', '58', '59', '2', 'com_modules.module.14', 'User Status', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('49', '18', '60', '61', '2', 'com_modules.module.15', 'Title', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('50', '18', '62', '63', '2', 'com_modules.module.16', 'Login Form', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('51', '18', '64', '65', '2', 'com_modules.module.17', 'Breadcrumbs', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('52', '18', '66', '67', '2', 'com_modules.module.79', 'Multilanguage status', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('53', '18', '68', '69', '2', 'com_modules.module.86', 'Joomla Version', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('54', '1', '119', '120', '1', 'com_virtuemart', 'virtuemart', '{}');
INSERT INTO `wy587_assets` VALUES ('55', '1', '121', '122', '1', 'com_virtuemart_allinone', 'virtuemart_allinone', '{}');
INSERT INTO `wy587_assets` VALUES ('56', '18', '70', '71', '2', 'com_modules.module.87', 'VM - Administrator Module', '');
INSERT INTO `wy587_assets` VALUES ('57', '18', '72', '73', '2', 'com_modules.module.88', 'VM - Currencies Selector', '');
INSERT INTO `wy587_assets` VALUES ('58', '18', '74', '75', '2', 'com_modules.module.89', 'VM - Featured products', '');
INSERT INTO `wy587_assets` VALUES ('59', '18', '76', '77', '2', 'com_modules.module.90', 'VM - Search in Shop', '');
INSERT INTO `wy587_assets` VALUES ('60', '18', '78', '79', '2', 'com_modules.module.91', 'VM - Manufacturer', '');
INSERT INTO `wy587_assets` VALUES ('61', '18', '80', '81', '2', 'com_modules.module.92', 'VM - Shopping cart', '{\"core.delete\":[],\"core.edit\":[],\"core.edit.state\":[]}');
INSERT INTO `wy587_assets` VALUES ('62', '18', '82', '83', '2', 'com_modules.module.93', 'VM - Category', '');

-- ----------------------------
-- Table structure for `wy587_associations`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_associations`;
CREATE TABLE `wy587_associations` (
  `id` int(11) NOT NULL COMMENT 'A reference to the associated item.',
  `context` varchar(50) NOT NULL COMMENT 'The context of the associated item.',
  `key` char(32) NOT NULL COMMENT 'The key for the association computed from an md5 on associated ids.',
  PRIMARY KEY (`context`,`id`),
  KEY `idx_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_associations
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_banners`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_banners`;
CREATE TABLE `wy587_banners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `imptotal` int(11) NOT NULL DEFAULT '0',
  `impmade` int(11) NOT NULL DEFAULT '0',
  `clicks` int(11) NOT NULL DEFAULT '0',
  `clickurl` varchar(200) NOT NULL DEFAULT '',
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `custombannercode` varchar(2048) NOT NULL,
  `sticky` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `params` text NOT NULL,
  `own_prefix` tinyint(1) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reset` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `language` char(7) NOT NULL DEFAULT '',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_state` (`state`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`),
  KEY `idx_banner_catid` (`catid`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_banners
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_banner_clients`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_banner_clients`;
CREATE TABLE `wy587_banner_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `contact` varchar(255) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `extrainfo` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `metakey` text NOT NULL,
  `own_prefix` tinyint(4) NOT NULL DEFAULT '0',
  `metakey_prefix` varchar(255) NOT NULL DEFAULT '',
  `purchase_type` tinyint(4) NOT NULL DEFAULT '-1',
  `track_clicks` tinyint(4) NOT NULL DEFAULT '-1',
  `track_impressions` tinyint(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`),
  KEY `idx_own_prefix` (`own_prefix`),
  KEY `idx_metakey_prefix` (`metakey_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_banner_clients
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_banner_tracks`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_banner_tracks`;
CREATE TABLE `wy587_banner_tracks` (
  `track_date` datetime NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`track_date`,`track_type`,`banner_id`),
  KEY `idx_track_date` (`track_date`),
  KEY `idx_track_type` (`track_type`),
  KEY `idx_banner_id` (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_banner_tracks
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_categories`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_categories`;
CREATE TABLE `wy587_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '',
  `extension` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `metadesc` varchar(1024) NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `cat_idx` (`extension`,`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_categories
-- ----------------------------
INSERT INTO `wy587_categories` VALUES ('1', '0', '0', '0', '13', '0', '', 'system', 'ROOT', 'root', '', '', '1', '0', '0000-00-00 00:00:00', '1', '{}', '', '', '{}', '42', '2011-01-01 00:00:01', '0', '0000-00-00 00:00:00', '0', '*', '1');
INSERT INTO `wy587_categories` VALUES ('2', '27', '1', '1', '2', '1', 'uncategorised', 'com_content', 'Uncategorised', 'uncategorised', '', '', '1', '0', '0000-00-00 00:00:00', '1', '{\"category_layout\":\"\",\"image\":\"\"}', '', '', '{\"author\":\"\",\"robots\":\"\"}', '42', '2011-01-01 00:00:01', '0', '0000-00-00 00:00:00', '0', '*', '1');
INSERT INTO `wy587_categories` VALUES ('3', '28', '1', '3', '4', '1', 'uncategorised', 'com_banners', 'Uncategorised', 'uncategorised', '', '', '1', '0', '0000-00-00 00:00:00', '1', '{\"category_layout\":\"\",\"image\":\"\"}', '', '', '{\"author\":\"\",\"robots\":\"\"}', '42', '2011-01-01 00:00:01', '0', '0000-00-00 00:00:00', '0', '*', '1');
INSERT INTO `wy587_categories` VALUES ('4', '29', '1', '5', '6', '1', 'uncategorised', 'com_contact', 'Uncategorised', 'uncategorised', '', '', '1', '0', '0000-00-00 00:00:00', '1', '{\"category_layout\":\"\",\"image\":\"\"}', '', '', '{\"author\":\"\",\"robots\":\"\"}', '42', '2011-01-01 00:00:01', '0', '0000-00-00 00:00:00', '0', '*', '1');
INSERT INTO `wy587_categories` VALUES ('5', '30', '1', '7', '8', '1', 'uncategorised', 'com_newsfeeds', 'Uncategorised', 'uncategorised', '', '', '1', '0', '0000-00-00 00:00:00', '1', '{\"category_layout\":\"\",\"image\":\"\"}', '', '', '{\"author\":\"\",\"robots\":\"\"}', '42', '2011-01-01 00:00:01', '0', '0000-00-00 00:00:00', '0', '*', '1');
INSERT INTO `wy587_categories` VALUES ('6', '31', '1', '9', '10', '1', 'uncategorised', 'com_weblinks', 'Uncategorised', 'uncategorised', '', '', '1', '0', '0000-00-00 00:00:00', '1', '{\"category_layout\":\"\",\"image\":\"\"}', '', '', '{\"author\":\"\",\"robots\":\"\"}', '42', '2011-01-01 00:00:01', '0', '0000-00-00 00:00:00', '0', '*', '1');
INSERT INTO `wy587_categories` VALUES ('7', '32', '1', '11', '12', '1', 'uncategorised', 'com_users', 'Uncategorised', 'uncategorised', '', '', '1', '0', '0000-00-00 00:00:00', '1', '{\"category_layout\":\"\",\"image\":\"\"}', '', '', '{\"author\":\"\",\"robots\":\"\"}', '42', '2011-01-01 00:00:01', '0', '0000-00-00 00:00:00', '0', '*', '1');

-- ----------------------------
-- Table structure for `wy587_contact_details`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_contact_details`;
CREATE TABLE `wy587_contact_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `con_position` varchar(255) DEFAULT NULL,
  `address` text,
  `suburb` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postcode` varchar(100) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `misc` mediumtext,
  `image` varchar(255) DEFAULT NULL,
  `email_to` varchar(255) DEFAULT NULL,
  `default_con` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `catid` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `mobile` varchar(255) NOT NULL DEFAULT '',
  `webpage` varchar(255) NOT NULL DEFAULT '',
  `sortname1` varchar(255) NOT NULL,
  `sortname2` varchar(255) NOT NULL,
  `sortname3` varchar(255) NOT NULL,
  `language` char(7) NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_contact_details
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_content`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_content`;
CREATE TABLE `wy587_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `title` varchar(255) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `introtext` mediumtext NOT NULL,
  `fulltext` mediumtext NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `attribs` varchar(5120) NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if article is featured.',
  `language` char(7) NOT NULL COMMENT 'The language code for the article.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_content
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_contentitem_tag_map`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_contentitem_tag_map`;
CREATE TABLE `wy587_contentitem_tag_map` (
  `type_alias` varchar(255) NOT NULL DEFAULT '',
  `core_content_id` int(10) unsigned NOT NULL COMMENT 'PK from the core content table',
  `content_item_id` int(11) NOT NULL COMMENT 'PK from the content type table',
  `tag_id` int(10) unsigned NOT NULL COMMENT 'PK from the tag table',
  `tag_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of most recent save for this tag-item',
  `type_id` mediumint(8) NOT NULL COMMENT 'PK from the content_type table',
  UNIQUE KEY `uc_ItemnameTagid` (`type_id`,`content_item_id`,`tag_id`),
  KEY `idx_tag_type` (`tag_id`,`type_id`),
  KEY `idx_date_id` (`tag_date`,`tag_id`),
  KEY `idx_tag` (`tag_id`),
  KEY `idx_type` (`type_id`),
  KEY `idx_core_content_id` (`core_content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps items from content tables to tags';

-- ----------------------------
-- Records of wy587_contentitem_tag_map
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_content_frontpage`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_content_frontpage`;
CREATE TABLE `wy587_content_frontpage` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_content_frontpage
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_content_rating`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_content_rating`;
CREATE TABLE `wy587_content_rating` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `rating_sum` int(10) unsigned NOT NULL DEFAULT '0',
  `rating_count` int(10) unsigned NOT NULL DEFAULT '0',
  `lastip` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_content_rating
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_content_types`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_content_types`;
CREATE TABLE `wy587_content_types` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_title` varchar(255) NOT NULL DEFAULT '',
  `type_alias` varchar(255) NOT NULL DEFAULT '',
  `table` varchar(255) NOT NULL DEFAULT '',
  `rules` text NOT NULL,
  `field_mappings` text NOT NULL,
  `router` varchar(255) NOT NULL DEFAULT '',
  `content_history_options` varchar(5120) DEFAULT NULL COMMENT 'JSON string for com_contenthistory options',
  PRIMARY KEY (`type_id`),
  KEY `idx_alias` (`type_alias`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_content_types
-- ----------------------------
INSERT INTO `wy587_content_types` VALUES ('1', 'Article', 'com_content.article', '{\"special\":{\"dbtable\":\"#__content\",\"key\":\"id\",\"type\":\"Content\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"state\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"introtext\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"attribs\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"urls\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"asset_id\"}, \"special\":{\"fulltext\":\"fulltext\"}}', 'ContentHelperRoute::getArticleRoute', '{\"formFile\":\"administrator\\/components\\/com_content\\/models\\/forms\\/article.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\"],\"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"],\"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}');
INSERT INTO `wy587_content_types` VALUES ('2', 'Weblink', 'com_weblinks.weblink', '{\"special\":{\"dbtable\":\"#__weblinks\",\"key\":\"id\",\"type\":\"Weblink\",\"prefix\":\"WeblinksTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"state\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"urls\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"null\"}, \"special\":{}}', 'WeblinksHelperRoute::getWeblinkRoute', '{\"formFile\":\"administrator\\/components\\/com_weblinks\\/models\\/forms\\/weblink.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"featured\",\"images\"], \"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\"], \"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"], \"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}');
INSERT INTO `wy587_content_types` VALUES ('3', 'Contact', 'com_contact.contact', '{\"special\":{\"dbtable\":\"#__contact_details\",\"key\":\"id\",\"type\":\"Contact\",\"prefix\":\"ContactTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"address\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"image\", \"core_urls\":\"webpage\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"null\"}, \"special\":{\"con_position\":\"con_position\",\"suburb\":\"suburb\",\"state\":\"state\",\"country\":\"country\",\"postcode\":\"postcode\",\"telephone\":\"telephone\",\"fax\":\"fax\",\"misc\":\"misc\",\"email_to\":\"email_to\",\"default_con\":\"default_con\",\"user_id\":\"user_id\",\"mobile\":\"mobile\",\"sortname1\":\"sortname1\",\"sortname2\":\"sortname2\",\"sortname3\":\"sortname3\"}}', 'ContactHelperRoute::getContactRoute', '{\"formFile\":\"administrator\\/components\\/com_contact\\/models\\/forms\\/contact.xml\",\"hideFields\":[\"default_con\",\"checked_out\",\"checked_out_time\",\"version\",\"xreference\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\"],\"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"], \"displayLookup\":[ {\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ] }');
INSERT INTO `wy587_content_types` VALUES ('4', 'Newsfeed', 'com_newsfeeds.newsfeed', '{\"special\":{\"dbtable\":\"#__newsfeeds\",\"key\":\"id\",\"type\":\"Newsfeed\",\"prefix\":\"NewsfeedsTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"link\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"xreference\", \"asset_id\":\"null\"}, \"special\":{\"numarticles\":\"numarticles\",\"cache_time\":\"cache_time\",\"rtl\":\"rtl\"}}', 'NewsfeedsHelperRoute::getNewsfeedRoute', '{\"formFile\":\"administrator\\/components\\/com_newsfeeds\\/models\\/forms\\/newsfeed.xml\",\"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\"],\"convertToInt\":[\"publish_up\", \"publish_down\", \"featured\", \"ordering\"],\"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}');
INSERT INTO `wy587_content_types` VALUES ('5', 'User', 'com_users.user', '{\"special\":{\"dbtable\":\"#__users\",\"key\":\"id\",\"type\":\"User\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"null\",\"core_alias\":\"username\",\"core_created_time\":\"registerdate\",\"core_modified_time\":\"lastvisitDate\",\"core_body\":\"null\", \"core_hits\":\"null\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"access\":\"null\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"null\", \"core_language\":\"null\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"null\", \"core_ordering\":\"null\", \"core_metakey\":\"null\", \"core_metadesc\":\"null\", \"core_catid\":\"null\", \"core_xreference\":\"null\", \"asset_id\":\"null\"}, \"special\":{}}', 'UsersHelperRoute::getUserRoute', '');
INSERT INTO `wy587_content_types` VALUES ('6', 'Article Category', 'com_content.category', '{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}', 'ContentHelperRoute::getCategoryRoute', '{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}');
INSERT INTO `wy587_content_types` VALUES ('7', 'Contact Category', 'com_contact.category', '{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}', 'ContactHelperRoute::getCategoryRoute', '{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}');
INSERT INTO `wy587_content_types` VALUES ('8', 'Newsfeeds Category', 'com_newsfeeds.category', '{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}', 'NewsfeedsHelperRoute::getCategoryRoute', '{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}');
INSERT INTO `wy587_content_types` VALUES ('9', 'Weblinks Category', 'com_weblinks.category', '{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}', 'WeblinksHelperRoute::getCategoryRoute', '{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}');
INSERT INTO `wy587_content_types` VALUES ('10', 'Tag', 'com_tags.tag', '{\"special\":{\"dbtable\":\"#__tags\",\"key\":\"tag_id\",\"type\":\"Tag\",\"prefix\":\"TagsTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"featured\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"urls\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"null\", \"core_xreference\":\"null\", \"asset_id\":\"null\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\"}}', 'TagsHelperRoute::getTagRoute', '{\"formFile\":\"administrator\\/components\\/com_tags\\/models\\/forms\\/tag.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\",\"version\", \"lft\", \"rgt\", \"level\", \"path\", \"urls\", \"publish_up\", \"publish_down\"],\"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"],\"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}, {\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}]}');
INSERT INTO `wy587_content_types` VALUES ('11', 'Banner', 'com_banners.banner', '{\"special\":{\"dbtable\":\"#__banners\",\"key\":\"id\",\"type\":\"Banner\",\"prefix\":\"BannersTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"name\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created\",\"core_modified_time\":\"modified\",\"core_body\":\"description\", \"core_hits\":\"null\",\"core_publish_up\":\"publish_up\",\"core_publish_down\":\"publish_down\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"images\", \"core_urls\":\"link\", \"core_version\":\"version\", \"core_ordering\":\"ordering\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"catid\", \"core_xreference\":\"null\", \"asset_id\":\"null\"}, \"special\":{\"imptotal\":\"imptotal\", \"impmade\":\"impmade\", \"clicks\":\"clicks\", \"clickurl\":\"clickurl\", \"custombannercode\":\"custombannercode\", \"cid\":\"cid\", \"purchase_type\":\"purchase_type\", \"track_impressions\":\"track_impressions\", \"track_clicks\":\"track_clicks\"}}', '', '{\"formFile\":\"administrator\\/components\\/com_banners\\/models\\/forms\\/banner.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\",\"version\", \"reset\"],\"ignoreChanges\":[\"modified_by\", \"modified\", \"checked_out\", \"checked_out_time\", \"version\", \"imptotal\", \"impmade\", \"reset\"], \"convertToInt\":[\"publish_up\", \"publish_down\", \"ordering\"], \"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}, {\"sourceColumn\":\"cid\",\"targetTable\":\"#__banner_clients\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"created_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"modified_by\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"} ]}');
INSERT INTO `wy587_content_types` VALUES ('12', 'Banners Category', 'com_banners.category', '{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\": {\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}', '', '{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"asset_id\",\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"], \"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}');
INSERT INTO `wy587_content_types` VALUES ('13', 'Banner Client', 'com_banners.client', '{\"special\":{\"dbtable\":\"#__banner_clients\",\"key\":\"id\",\"type\":\"Client\",\"prefix\":\"BannersTable\"}}', '', '', '', '{\"formFile\":\"administrator\\/components\\/com_banners\\/models\\/forms\\/client.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\"], \"ignoreChanges\":[\"checked_out\", \"checked_out_time\"], \"convertToInt\":[], \"displayLookup\":[]}');
INSERT INTO `wy587_content_types` VALUES ('14', 'User Notes', 'com_users.note', '{\"special\":{\"dbtable\":\"#__user_notes\",\"key\":\"id\",\"type\":\"Note\",\"prefix\":\"UsersTable\"}}', '', '', '', '{\"formFile\":\"administrator\\/components\\/com_users\\/models\\/forms\\/note.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\", \"publish_up\", \"publish_down\"],\"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\"], \"convertToInt\":[\"publish_up\", \"publish_down\"],\"displayLookup\":[{\"sourceColumn\":\"catid\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}, {\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}]}');
INSERT INTO `wy587_content_types` VALUES ('15', 'User Notes Category', 'com_users.category', '{\"special\":{\"dbtable\":\"#__categories\",\"key\":\"id\",\"type\":\"Category\",\"prefix\":\"JTable\",\"config\":\"array()\"},\"common\":{\"dbtable\":\"#__ucm_content\",\"key\":\"ucm_id\",\"type\":\"Corecontent\",\"prefix\":\"JTable\",\"config\":\"array()\"}}', '', '{\"common\":{\"core_content_item_id\":\"id\",\"core_title\":\"title\",\"core_state\":\"published\",\"core_alias\":\"alias\",\"core_created_time\":\"created_time\",\"core_modified_time\":\"modified_time\",\"core_body\":\"description\", \"core_hits\":\"hits\",\"core_publish_up\":\"null\",\"core_publish_down\":\"null\",\"core_access\":\"access\", \"core_params\":\"params\", \"core_featured\":\"null\", \"core_metadata\":\"metadata\", \"core_language\":\"language\", \"core_images\":\"null\", \"core_urls\":\"null\", \"core_version\":\"version\", \"core_ordering\":\"null\", \"core_metakey\":\"metakey\", \"core_metadesc\":\"metadesc\", \"core_catid\":\"parent_id\", \"core_xreference\":\"null\", \"asset_id\":\"asset_id\"}, \"special\":{\"parent_id\":\"parent_id\",\"lft\":\"lft\",\"rgt\":\"rgt\",\"level\":\"level\",\"path\":\"path\",\"extension\":\"extension\",\"note\":\"note\"}}', '', '{\"formFile\":\"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml\", \"hideFields\":[\"checked_out\",\"checked_out_time\",\"version\",\"lft\",\"rgt\",\"level\",\"path\",\"extension\"], \"ignoreChanges\":[\"modified_user_id\", \"modified_time\", \"checked_out\", \"checked_out_time\", \"version\", \"hits\", \"path\"], \"convertToInt\":[\"publish_up\", \"publish_down\"], \"displayLookup\":[{\"sourceColumn\":\"created_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"}, {\"sourceColumn\":\"access\",\"targetTable\":\"#__viewlevels\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"},{\"sourceColumn\":\"modified_user_id\",\"targetTable\":\"#__users\",\"targetColumn\":\"id\",\"displayColumn\":\"name\"},{\"sourceColumn\":\"parent_id\",\"targetTable\":\"#__categories\",\"targetColumn\":\"id\",\"displayColumn\":\"title\"}]}');

-- ----------------------------
-- Table structure for `wy587_core_log_searches`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_core_log_searches`;
CREATE TABLE `wy587_core_log_searches` (
  `search_term` varchar(128) NOT NULL DEFAULT '',
  `hits` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_core_log_searches
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_extensions`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_extensions`;
CREATE TABLE `wy587_extensions` (
  `extension_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` varchar(20) NOT NULL,
  `element` varchar(100) NOT NULL,
  `folder` varchar(100) NOT NULL,
  `client_id` tinyint(3) NOT NULL,
  `enabled` tinyint(3) NOT NULL DEFAULT '1',
  `access` int(10) unsigned NOT NULL DEFAULT '1',
  `protected` tinyint(3) NOT NULL DEFAULT '0',
  `manifest_cache` text NOT NULL,
  `params` text NOT NULL,
  `custom_data` text NOT NULL,
  `system_data` text NOT NULL,
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) DEFAULT '0',
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`extension_id`),
  KEY `element_clientid` (`element`,`client_id`),
  KEY `element_folder_clientid` (`element`,`folder`,`client_id`),
  KEY `extension` (`type`,`element`,`folder`,`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10030 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_extensions
-- ----------------------------
INSERT INTO `wy587_extensions` VALUES ('1', 'com_mailto', 'component', 'com_mailto', '', '0', '1', '1', '1', '{\"name\":\"com_mailto\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MAILTO_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('2', 'com_wrapper', 'component', 'com_wrapper', '', '0', '1', '1', '1', '{\"name\":\"com_wrapper\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_WRAPPER_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('3', 'com_admin', 'component', 'com_admin', '', '1', '1', '1', '1', '{\"name\":\"com_admin\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_ADMIN_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('4', 'com_banners', 'component', 'com_banners', '', '1', '1', '1', '0', '{\"name\":\"com_banners\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_BANNERS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"purchase_type\":\"3\",\"track_impressions\":\"0\",\"track_clicks\":\"0\",\"metakey_prefix\":\"\",\"save_history\":\"1\",\"history_limit\":10}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('5', 'com_cache', 'component', 'com_cache', '', '1', '1', '1', '1', '{\"name\":\"com_cache\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CACHE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('6', 'com_categories', 'component', 'com_categories', '', '1', '1', '1', '1', '{\"name\":\"com_categories\",\"type\":\"component\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('7', 'com_checkin', 'component', 'com_checkin', '', '1', '1', '1', '1', '{\"name\":\"com_checkin\",\"type\":\"component\",\"creationDate\":\"Unknown\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2008 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CHECKIN_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('8', 'com_contact', 'component', 'com_contact', '', '1', '1', '1', '0', '{\"name\":\"com_contact\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CONTACT_XML_DESCRIPTION\",\"group\":\"\"}', '{\"show_contact_category\":\"hide\",\"save_history\":\"1\",\"history_limit\":10,\"show_contact_list\":\"0\",\"presentation_style\":\"sliders\",\"show_name\":\"1\",\"show_position\":\"1\",\"show_email\":\"0\",\"show_street_address\":\"1\",\"show_suburb\":\"1\",\"show_state\":\"1\",\"show_postcode\":\"1\",\"show_country\":\"1\",\"show_telephone\":\"1\",\"show_mobile\":\"1\",\"show_fax\":\"1\",\"show_webpage\":\"1\",\"show_misc\":\"1\",\"show_image\":\"1\",\"image\":\"\",\"allow_vcard\":\"0\",\"show_articles\":\"0\",\"show_profile\":\"0\",\"show_links\":\"0\",\"linka_name\":\"\",\"linkb_name\":\"\",\"linkc_name\":\"\",\"linkd_name\":\"\",\"linke_name\":\"\",\"contact_icons\":\"0\",\"icon_address\":\"\",\"icon_email\":\"\",\"icon_telephone\":\"\",\"icon_mobile\":\"\",\"icon_fax\":\"\",\"icon_misc\":\"\",\"show_headings\":\"1\",\"show_position_headings\":\"1\",\"show_email_headings\":\"0\",\"show_telephone_headings\":\"1\",\"show_mobile_headings\":\"0\",\"show_fax_headings\":\"0\",\"allow_vcard_headings\":\"0\",\"show_suburb_headings\":\"1\",\"show_state_headings\":\"1\",\"show_country_headings\":\"1\",\"show_email_form\":\"1\",\"show_email_copy\":\"1\",\"banned_email\":\"\",\"banned_subject\":\"\",\"banned_text\":\"\",\"validate_session\":\"1\",\"custom_reply\":\"0\",\"redirect\":\"\",\"show_category_crumb\":\"0\",\"metakey\":\"\",\"metadesc\":\"\",\"robots\":\"\",\"author\":\"\",\"rights\":\"\",\"xreference\":\"\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('9', 'com_cpanel', 'component', 'com_cpanel', '', '1', '1', '1', '1', '{\"name\":\"com_cpanel\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CPANEL_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10', 'com_installer', 'component', 'com_installer', '', '1', '1', '1', '1', '{\"name\":\"com_installer\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_INSTALLER_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('11', 'com_languages', 'component', 'com_languages', '', '1', '1', '1', '1', '{\"name\":\"com_languages\",\"type\":\"component\",\"creationDate\":\"2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\"}', '{\"administrator\":\"ru-RU\",\"site\":\"ru-RU\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('12', 'com_login', 'component', 'com_login', '', '1', '1', '1', '1', '{\"name\":\"com_login\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('13', 'com_media', 'component', 'com_media', '', '1', '1', '0', '1', '{\"name\":\"com_media\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MEDIA_XML_DESCRIPTION\",\"group\":\"\"}', '{\"upload_extensions\":\"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS\",\"upload_maxsize\":\"10\",\"file_path\":\"images\",\"image_path\":\"images\",\"restrict_uploads\":\"1\",\"allowed_media_usergroup\":\"3\",\"check_mime\":\"1\",\"image_extensions\":\"bmp,gif,jpg,png\",\"ignore_extensions\":\"\",\"upload_mime\":\"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip\",\"upload_mime_illegal\":\"text\\/html\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('14', 'com_menus', 'component', 'com_menus', '', '1', '1', '1', '1', '{\"name\":\"com_menus\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MENUS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('15', 'com_messages', 'component', 'com_messages', '', '1', '1', '1', '1', '{\"name\":\"com_messages\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MESSAGES_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('16', 'com_modules', 'component', 'com_modules', '', '1', '1', '1', '1', '{\"name\":\"com_modules\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MODULES_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('17', 'com_newsfeeds', 'component', 'com_newsfeeds', '', '1', '1', '1', '0', '{\"name\":\"com_newsfeeds\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"newsfeed_layout\":\"_:default\",\"save_history\":\"1\",\"history_limit\":5,\"show_feed_image\":\"1\",\"show_feed_description\":\"1\",\"show_item_description\":\"1\",\"feed_character_count\":\"0\",\"feed_display_order\":\"des\",\"float_first\":\"right\",\"float_second\":\"right\",\"show_tags\":\"1\",\"category_layout\":\"_:default\",\"show_category_title\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"0\",\"show_subcat_desc\":\"1\",\"show_cat_items\":\"1\",\"show_cat_tags\":\"1\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"0\",\"show_subcat_desc_cat\":\"1\",\"show_cat_items_cat\":\"1\",\"filter_field\":\"1\",\"show_pagination_limit\":\"1\",\"show_headings\":\"1\",\"show_articles\":\"0\",\"show_link\":\"1\",\"show_pagination\":\"1\",\"show_pagination_results\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('18', 'com_plugins', 'component', 'com_plugins', '', '1', '1', '1', '1', '{\"name\":\"com_plugins\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_PLUGINS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('19', 'com_search', 'component', 'com_search', '', '1', '1', '1', '0', '{\"name\":\"com_search\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_SEARCH_XML_DESCRIPTION\",\"group\":\"\"}', '{\"enabled\":\"0\",\"show_date\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('20', 'com_templates', 'component', 'com_templates', '', '1', '1', '1', '1', '{\"name\":\"com_templates\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_TEMPLATES_XML_DESCRIPTION\",\"group\":\"\"}', '{\"template_positions_display\":\"0\",\"upload_limit\":\"2\",\"image_formats\":\"gif,bmp,jpg,jpeg,png\",\"source_formats\":\"txt,less,ini,xml,js,php,css\",\"font_formats\":\"woff,ttf,otf\",\"compressed_formats\":\"zip\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('21', 'com_weblinks', 'component', 'com_weblinks', '', '1', '1', '1', '0', '{\"name\":\"com_weblinks\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\n\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"target\":\"0\",\"save_history\":\"1\",\"history_limit\":5,\"count_clicks\":\"1\",\"icons\":1,\"link_icons\":\"\",\"float_first\":\"right\",\"float_second\":\"right\",\"show_tags\":\"1\",\"category_layout\":\"_:default\",\"show_category_title\":\"1\",\"show_description\":\"1\",\"show_description_image\":\"1\",\"maxLevel\":\"-1\",\"show_empty_categories\":\"0\",\"show_subcat_desc\":\"1\",\"show_cat_num_links\":\"1\",\"show_cat_tags\":\"1\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"0\",\"show_subcat_desc_cat\":\"1\",\"show_cat_num_links_cat\":\"1\",\"filter_field\":\"1\",\"show_pagination_limit\":\"1\",\"show_headings\":\"0\",\"show_link_description\":\"1\",\"show_link_hits\":\"1\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"show_feed_link\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('22', 'com_content', 'component', 'com_content', '', '1', '1', '0', '1', '{\"name\":\"com_content\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CONTENT_XML_DESCRIPTION\",\"group\":\"\"}', '{\"article_layout\":\"_:default\",\"show_title\":\"1\",\"link_titles\":\"1\",\"show_intro\":\"1\",\"show_category\":\"1\",\"link_category\":\"1\",\"show_parent_category\":\"0\",\"link_parent_category\":\"0\",\"show_author\":\"1\",\"link_author\":\"0\",\"show_create_date\":\"0\",\"show_modify_date\":\"0\",\"show_publish_date\":\"1\",\"show_item_navigation\":\"1\",\"show_vote\":\"0\",\"show_readmore\":\"1\",\"show_readmore_title\":\"1\",\"readmore_limit\":\"100\",\"show_icons\":\"1\",\"show_print_icon\":\"1\",\"show_email_icon\":\"1\",\"show_hits\":\"1\",\"show_noauth\":\"0\",\"show_publishing_options\":\"1\",\"show_article_options\":\"1\",\"save_history\":\"1\",\"history_limit\":10,\"show_urls_images_frontend\":\"0\",\"show_urls_images_backend\":\"1\",\"targeta\":0,\"targetb\":0,\"targetc\":0,\"float_intro\":\"left\",\"float_fulltext\":\"left\",\"category_layout\":\"_:blog\",\"show_category_title\":\"0\",\"show_description\":\"0\",\"show_description_image\":\"0\",\"maxLevel\":\"1\",\"show_empty_categories\":\"0\",\"show_no_articles\":\"1\",\"show_subcat_desc\":\"1\",\"show_cat_num_articles\":\"0\",\"show_base_description\":\"1\",\"maxLevelcat\":\"-1\",\"show_empty_categories_cat\":\"0\",\"show_subcat_desc_cat\":\"1\",\"show_cat_num_articles_cat\":\"1\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"4\",\"num_columns\":\"2\",\"num_links\":\"4\",\"multi_column_order\":\"0\",\"show_subcategory_content\":\"0\",\"show_pagination_limit\":\"1\",\"filter_field\":\"hide\",\"show_headings\":\"1\",\"list_show_date\":\"0\",\"date_format\":\"\",\"list_show_hits\":\"1\",\"list_show_author\":\"1\",\"orderby_pri\":\"order\",\"orderby_sec\":\"rdate\",\"order_date\":\"published\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"show_feed_link\":\"1\",\"feed_summary\":\"0\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('23', 'com_config', 'component', 'com_config', '', '1', '1', '0', '1', '{\"name\":\"com_config\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_CONFIG_XML_DESCRIPTION\",\"group\":\"\"}', '{\"filters\":{\"1\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"6\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"7\":{\"filter_type\":\"NONE\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"2\":{\"filter_type\":\"NH\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"3\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"4\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"5\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"10\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"12\":{\"filter_type\":\"BL\",\"filter_tags\":\"\",\"filter_attributes\":\"\"},\"8\":{\"filter_type\":\"NONE\",\"filter_tags\":\"\",\"filter_attributes\":\"\"}}}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('24', 'com_redirect', 'component', 'com_redirect', '', '1', '1', '0', '1', '{\"name\":\"com_redirect\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_REDIRECT_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('25', 'com_users', 'component', 'com_users', '', '1', '1', '0', '1', '{\"name\":\"com_users\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_USERS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"allowUserRegistration\":\"1\",\"new_usertype\":\"2\",\"guest_usergroup\":\"9\",\"sendpassword\":\"1\",\"useractivation\":\"1\",\"mail_to_admin\":\"0\",\"captcha\":\"\",\"frontend_userparams\":\"1\",\"site_language\":\"0\",\"change_login_name\":\"0\",\"reset_count\":\"10\",\"reset_time\":\"1\",\"minimum_length\":\"4\",\"minimum_integers\":\"0\",\"minimum_symbols\":\"0\",\"minimum_uppercase\":\"0\",\"save_history\":\"1\",\"history_limit\":5,\"mailSubjectPrefix\":\"\",\"mailBodySuffix\":\"\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('27', 'com_finder', 'component', 'com_finder', '', '1', '1', '0', '0', '{\"name\":\"com_finder\",\"type\":\"component\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_FINDER_XML_DESCRIPTION\",\"group\":\"\"}', '{\"show_description\":\"1\",\"description_length\":255,\"allow_empty_query\":\"0\",\"show_url\":\"1\",\"show_advanced\":\"1\",\"expand_advanced\":\"0\",\"show_date_filters\":\"0\",\"highlight_terms\":\"1\",\"opensearch_name\":\"\",\"opensearch_description\":\"\",\"batch_size\":\"50\",\"memory_table_limit\":30000,\"title_multiplier\":\"1.7\",\"text_multiplier\":\"0.7\",\"meta_multiplier\":\"1.2\",\"path_multiplier\":\"2.0\",\"misc_multiplier\":\"0.3\",\"stemmer\":\"snowball\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('28', 'com_joomlaupdate', 'component', 'com_joomlaupdate', '', '1', '1', '0', '1', '{\"name\":\"com_joomlaupdate\",\"type\":\"component\",\"creationDate\":\"February 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('29', 'com_tags', 'component', 'com_tags', '', '1', '1', '1', '1', '{\"name\":\"com_tags\",\"type\":\"component\",\"creationDate\":\"December 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.1.0\",\"description\":\"COM_TAGS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"tag_layout\":\"_:default\",\"save_history\":\"1\",\"history_limit\":5,\"show_tag_title\":\"0\",\"tag_list_show_tag_image\":\"0\",\"tag_list_show_tag_description\":\"0\",\"tag_list_image\":\"\",\"show_tag_num_items\":\"0\",\"tag_list_orderby\":\"title\",\"tag_list_orderby_direction\":\"ASC\",\"show_headings\":\"0\",\"tag_list_show_date\":\"0\",\"tag_list_show_item_image\":\"0\",\"tag_list_show_item_description\":\"0\",\"tag_list_item_maximum_characters\":0,\"return_any_or_all\":\"1\",\"include_children\":\"0\",\"maximum\":200,\"tag_list_language_filter\":\"all\",\"tags_layout\":\"_:default\",\"all_tags_orderby\":\"title\",\"all_tags_orderby_direction\":\"ASC\",\"all_tags_show_tag_image\":\"0\",\"all_tags_show_tag_descripion\":\"0\",\"all_tags_tag_maximum_characters\":20,\"all_tags_show_tag_hits\":\"0\",\"filter_field\":\"1\",\"show_pagination_limit\":\"1\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"tag_field_ajax_mode\":\"1\",\"show_feed_link\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('30', 'com_contenthistory', 'component', 'com_contenthistory', '', '1', '1', '1', '0', '{\"name\":\"com_contenthistory\",\"type\":\"component\",\"creationDate\":\"May 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"COM_CONTENTHISTORY_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('31', 'com_ajax', 'component', 'com_ajax', '', '1', '1', '1', '0', '{\"name\":\"com_ajax\",\"type\":\"component\",\"creationDate\":\"August 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"COM_AJAX_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('32', 'com_postinstall', 'component', 'com_postinstall', '', '1', '1', '1', '1', '{\"name\":\"com_postinstall\",\"type\":\"component\",\"creationDate\":\"September 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"COM_POSTINSTALL_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('100', 'PHPMailer', 'library', 'phpmailer', '', '0', '1', '1', '1', '{\"name\":\"PHPMailer\",\"type\":\"library\",\"creationDate\":\"2001\",\"author\":\"PHPMailer\",\"copyright\":\"(c) 2001-2003, Brent R. Matzelle, (c) 2004-2009, Andy Prevost. All Rights Reserved., (c) 2010-2013, Jim Jagielski. All Rights Reserved.\",\"authorEmail\":\"jimjag@gmail.com\",\"authorUrl\":\"https:\\/\\/github.com\\/PHPMailer\\/PHPMailer\",\"version\":\"5.2.6\",\"description\":\"LIB_PHPMAILER_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('101', 'SimplePie', 'library', 'simplepie', '', '0', '1', '1', '1', '{\"name\":\"SimplePie\",\"type\":\"library\",\"creationDate\":\"2004\",\"author\":\"SimplePie\",\"copyright\":\"Copyright (c) 2004-2009, Ryan Parman and Geoffrey Sneddon\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/simplepie.org\\/\",\"version\":\"1.2\",\"description\":\"LIB_SIMPLEPIE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('102', 'phputf8', 'library', 'phputf8', '', '0', '1', '1', '1', '{\"name\":\"phputf8\",\"type\":\"library\",\"creationDate\":\"2006\",\"author\":\"Harry Fuecks\",\"copyright\":\"Copyright various authors\",\"authorEmail\":\"hfuecks@gmail.com\",\"authorUrl\":\"http:\\/\\/sourceforge.net\\/projects\\/phputf8\",\"version\":\"0.5\",\"description\":\"LIB_PHPUTF8_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('103', 'Joomla! Platform', 'library', 'joomla', '', '0', '1', '1', '1', '{\"name\":\"Joomla! Platform\",\"type\":\"library\",\"creationDate\":\"2008\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"http:\\/\\/www.joomla.org\",\"version\":\"13.1\",\"description\":\"LIB_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}', '{\"mediaversion\":\"0be85fd26dd3962fc3d6db7b6456741d\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('104', 'IDNA Convert', 'library', 'idna_convert', '', '0', '1', '1', '1', '{\"name\":\"IDNA Convert\",\"type\":\"library\",\"creationDate\":\"2004\",\"author\":\"phlyLabs\",\"copyright\":\"2004-2011 phlyLabs Berlin, http:\\/\\/phlylabs.de\",\"authorEmail\":\"phlymail@phlylabs.de\",\"authorUrl\":\"http:\\/\\/phlylabs.de\",\"version\":\"0.8.0\",\"description\":\"LIB_IDNA_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('105', 'FOF', 'library', 'fof', '', '0', '1', '1', '1', '{\"name\":\"FOF\",\"type\":\"library\",\"creationDate\":\"2014-03-09 12:54:48\",\"author\":\"Nicholas K. Dionysopoulos \\/ Akeeba Ltd\",\"copyright\":\"(C)2011-2014 Nicholas K. Dionysopoulos\",\"authorEmail\":\"nicholas@akeebabackup.com\",\"authorUrl\":\"https:\\/\\/www.akeebabackup.com\",\"version\":\"2.2.1\",\"description\":\"LIB_FOF_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('106', 'PHPass', 'library', 'phpass', '', '0', '1', '1', '1', '{\"name\":\"PHPass\",\"type\":\"library\",\"creationDate\":\"2004-2006\",\"author\":\"Solar Designer\",\"copyright\":\"\",\"authorEmail\":\"solar@openwall.com\",\"authorUrl\":\"http:\\/\\/www.openwall.com\\/phpass\\/\",\"version\":\"0.3\",\"description\":\"LIB_PHPASS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('200', 'mod_articles_archive', 'module', 'mod_articles_archive', '', '0', '1', '1', '0', '{\"name\":\"mod_articles_archive\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_ARCHIVE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('201', 'mod_articles_latest', 'module', 'mod_articles_latest', '', '0', '1', '1', '0', '{\"name\":\"mod_articles_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LATEST_NEWS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('202', 'mod_articles_popular', 'module', 'mod_articles_popular', '', '0', '1', '1', '0', '{\"name\":\"mod_articles_popular\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('203', 'mod_banners', 'module', 'mod_banners', '', '0', '1', '1', '0', '{\"name\":\"mod_banners\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_BANNERS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('204', 'mod_breadcrumbs', 'module', 'mod_breadcrumbs', '', '0', '1', '1', '1', '{\"name\":\"mod_breadcrumbs\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_BREADCRUMBS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('205', 'mod_custom', 'module', 'mod_custom', '', '0', '1', '1', '1', '{\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('206', 'mod_feed', 'module', 'mod_feed', '', '0', '1', '1', '0', '{\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('207', 'mod_footer', 'module', 'mod_footer', '', '0', '1', '1', '0', '{\"name\":\"mod_footer\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FOOTER_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('208', 'mod_login', 'module', 'mod_login', '', '0', '1', '1', '1', '{\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('209', 'mod_menu', 'module', 'mod_menu', '', '0', '1', '1', '1', '{\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('210', 'mod_articles_news', 'module', 'mod_articles_news', '', '0', '1', '1', '0', '{\"name\":\"mod_articles_news\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_NEWS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('211', 'mod_random_image', 'module', 'mod_random_image', '', '0', '1', '1', '0', '{\"name\":\"mod_random_image\",\"type\":\"module\",\"creationDate\":\"July 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_RANDOM_IMAGE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('212', 'mod_related_items', 'module', 'mod_related_items', '', '0', '1', '1', '0', '{\"name\":\"mod_related_items\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_RELATED_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('213', 'mod_search', 'module', 'mod_search', '', '0', '1', '1', '0', '{\"name\":\"mod_search\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_SEARCH_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('214', 'mod_stats', 'module', 'mod_stats', '', '0', '1', '1', '0', '{\"name\":\"mod_stats\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_STATS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('215', 'mod_syndicate', 'module', 'mod_syndicate', '', '0', '1', '1', '1', '{\"name\":\"mod_syndicate\",\"type\":\"module\",\"creationDate\":\"May 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_SYNDICATE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('216', 'mod_users_latest', 'module', 'mod_users_latest', '', '0', '1', '1', '0', '{\"name\":\"mod_users_latest\",\"type\":\"module\",\"creationDate\":\"December 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_USERS_LATEST_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('217', 'mod_weblinks', 'module', 'mod_weblinks', '', '0', '1', '1', '0', '{\"name\":\"mod_weblinks\",\"type\":\"module\",\"creationDate\":\"July 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('218', 'mod_whosonline', 'module', 'mod_whosonline', '', '0', '1', '1', '0', '{\"name\":\"mod_whosonline\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_WHOSONLINE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('219', 'mod_wrapper', 'module', 'mod_wrapper', '', '0', '1', '1', '0', '{\"name\":\"mod_wrapper\",\"type\":\"module\",\"creationDate\":\"October 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_WRAPPER_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('220', 'mod_articles_category', 'module', 'mod_articles_category', '', '0', '1', '1', '0', '{\"name\":\"mod_articles_category\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_CATEGORY_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('221', 'mod_articles_categories', 'module', 'mod_articles_categories', '', '0', '1', '1', '0', '{\"name\":\"mod_articles_categories\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_ARTICLES_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('222', 'mod_languages', 'module', 'mod_languages', '', '0', '1', '1', '1', '{\"name\":\"mod_languages\",\"type\":\"module\",\"creationDate\":\"February 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LANGUAGES_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('223', 'mod_finder', 'module', 'mod_finder', '', '0', '1', '0', '0', '{\"name\":\"mod_finder\",\"type\":\"module\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FINDER_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('300', 'mod_custom', 'module', 'mod_custom', '', '1', '1', '1', '1', '{\"name\":\"mod_custom\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_CUSTOM_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('301', 'mod_feed', 'module', 'mod_feed', '', '1', '1', '1', '0', '{\"name\":\"mod_feed\",\"type\":\"module\",\"creationDate\":\"July 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_FEED_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('302', 'mod_latest', 'module', 'mod_latest', '', '1', '1', '1', '0', '{\"name\":\"mod_latest\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LATEST_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('303', 'mod_logged', 'module', 'mod_logged', '', '1', '1', '1', '0', '{\"name\":\"mod_logged\",\"type\":\"module\",\"creationDate\":\"January 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LOGGED_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('304', 'mod_login', 'module', 'mod_login', '', '1', '1', '1', '1', '{\"name\":\"mod_login\",\"type\":\"module\",\"creationDate\":\"March 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_LOGIN_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('305', 'mod_menu', 'module', 'mod_menu', '', '1', '1', '1', '0', '{\"name\":\"mod_menu\",\"type\":\"module\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_MENU_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('307', 'mod_popular', 'module', 'mod_popular', '', '1', '1', '1', '0', '{\"name\":\"mod_popular\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_POPULAR_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('308', 'mod_quickicon', 'module', 'mod_quickicon', '', '1', '1', '1', '1', '{\"name\":\"mod_quickicon\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_QUICKICON_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('309', 'mod_status', 'module', 'mod_status', '', '1', '1', '1', '0', '{\"name\":\"mod_status\",\"type\":\"module\",\"creationDate\":\"Feb 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_STATUS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('310', 'mod_submenu', 'module', 'mod_submenu', '', '1', '1', '1', '0', '{\"name\":\"mod_submenu\",\"type\":\"module\",\"creationDate\":\"Feb 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_SUBMENU_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('311', 'mod_title', 'module', 'mod_title', '', '1', '1', '1', '0', '{\"name\":\"mod_title\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_TITLE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('312', 'mod_toolbar', 'module', 'mod_toolbar', '', '1', '1', '1', '1', '{\"name\":\"mod_toolbar\",\"type\":\"module\",\"creationDate\":\"Nov 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_TOOLBAR_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('313', 'mod_multilangstatus', 'module', 'mod_multilangstatus', '', '1', '1', '1', '0', '{\"name\":\"mod_multilangstatus\",\"type\":\"module\",\"creationDate\":\"September 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_MULTILANGSTATUS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"cache\":\"0\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('314', 'mod_version', 'module', 'mod_version', '', '1', '1', '1', '0', '{\"name\":\"mod_version\",\"type\":\"module\",\"creationDate\":\"January 2012\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_VERSION_XML_DESCRIPTION\",\"group\":\"\"}', '{\"format\":\"short\",\"product\":\"1\",\"cache\":\"0\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('315', 'mod_stats_admin', 'module', 'mod_stats_admin', '', '1', '1', '1', '0', '{\"name\":\"mod_stats_admin\",\"type\":\"module\",\"creationDate\":\"July 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"MOD_STATS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"serverinfo\":\"0\",\"siteinfo\":\"0\",\"counter\":\"0\",\"increase\":\"0\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"static\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('316', 'mod_tags_popular', 'module', 'mod_tags_popular', '', '0', '1', '1', '0', '{\"name\":\"mod_tags_popular\",\"type\":\"module\",\"creationDate\":\"January 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.1.0\",\"description\":\"MOD_TAGS_POPULAR_XML_DESCRIPTION\",\"group\":\"\"}', '{\"maximum\":\"5\",\"timeframe\":\"alltime\",\"owncache\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('317', 'mod_tags_similar', 'module', 'mod_tags_similar', '', '0', '1', '1', '0', '{\"name\":\"mod_tags_similar\",\"type\":\"module\",\"creationDate\":\"January 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.1.0\",\"description\":\"MOD_TAGS_SIMILAR_XML_DESCRIPTION\",\"group\":\"\"}', '{\"maximum\":\"5\",\"matchtype\":\"any\",\"owncache\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('400', 'plg_authentication_gmail', 'plugin', 'gmail', 'authentication', '0', '0', '1', '0', '{\"name\":\"plg_authentication_gmail\",\"type\":\"plugin\",\"creationDate\":\"February 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_GMAIL_XML_DESCRIPTION\",\"group\":\"\"}', '{\"applysuffix\":\"0\",\"suffix\":\"\",\"verifypeer\":\"1\",\"user_blacklist\":\"\"}', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('401', 'plg_authentication_joomla', 'plugin', 'joomla', 'authentication', '0', '1', '1', '1', '{\"name\":\"plg_authentication_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_AUTH_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('402', 'plg_authentication_ldap', 'plugin', 'ldap', 'authentication', '0', '0', '1', '0', '{\"name\":\"plg_authentication_ldap\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_LDAP_XML_DESCRIPTION\",\"group\":\"\"}', '{\"host\":\"\",\"port\":\"389\",\"use_ldapV3\":\"0\",\"negotiate_tls\":\"0\",\"no_referrals\":\"0\",\"auth_method\":\"bind\",\"base_dn\":\"\",\"search_string\":\"\",\"users_dn\":\"\",\"username\":\"admin\",\"password\":\"bobby7\",\"ldap_fullname\":\"fullName\",\"ldap_email\":\"mail\",\"ldap_uid\":\"uid\"}', '', '', '0', '0000-00-00 00:00:00', '3', '0');
INSERT INTO `wy587_extensions` VALUES ('403', 'plg_content_contact', 'plugin', 'contact', 'content', '0', '1', '1', '0', '{\"name\":\"plg_content_contact\",\"type\":\"plugin\",\"creationDate\":\"January 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.2\",\"description\":\"PLG_CONTENT_CONTACT_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('404', 'plg_content_emailcloak', 'plugin', 'emailcloak', 'content', '0', '1', '1', '0', '{\"name\":\"plg_content_emailcloak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_EMAILCLOAK_XML_DESCRIPTION\",\"group\":\"\"}', '{\"mode\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('406', 'plg_content_loadmodule', 'plugin', 'loadmodule', 'content', '0', '1', '1', '0', '{\"name\":\"plg_content_loadmodule\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_LOADMODULE_XML_DESCRIPTION\",\"group\":\"\"}', '{\"style\":\"xhtml\"}', '', '', '0', '2011-09-18 15:22:50', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('407', 'plg_content_pagebreak', 'plugin', 'pagebreak', 'content', '0', '1', '1', '0', '{\"name\":\"plg_content_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\"}', '{\"title\":\"1\",\"multipage_toc\":\"1\",\"showall\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '4', '0');
INSERT INTO `wy587_extensions` VALUES ('408', 'plg_content_pagenavigation', 'plugin', 'pagenavigation', 'content', '0', '1', '1', '0', '{\"name\":\"plg_content_pagenavigation\",\"type\":\"plugin\",\"creationDate\":\"January 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_PAGENAVIGATION_XML_DESCRIPTION\",\"group\":\"\"}', '{\"position\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('409', 'plg_content_vote', 'plugin', 'vote', 'content', '0', '1', '1', '0', '{\"name\":\"plg_content_vote\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_VOTE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '6', '0');
INSERT INTO `wy587_extensions` VALUES ('410', 'plg_editors_codemirror', 'plugin', 'codemirror', 'editors', '0', '1', '1', '1', '{\"name\":\"plg_editors_codemirror\",\"type\":\"plugin\",\"creationDate\":\"28 March 2011\",\"author\":\"Marijn Haverbeke\",\"copyright\":\"\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"\",\"version\":\"3.15\",\"description\":\"PLG_CODEMIRROR_XML_DESCRIPTION\",\"group\":\"\"}', '{\"lineNumbers\":\"1\",\"lineWrapping\":\"1\",\"matchTags\":\"1\",\"matchBrackets\":\"1\",\"marker-gutter\":\"1\",\"autoCloseTags\":\"1\",\"autoCloseBrackets\":\"1\",\"autoFocus\":\"1\",\"theme\":\"default\",\"tabmode\":\"indent\"}', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('411', 'plg_editors_none', 'plugin', 'none', 'editors', '0', '1', '1', '1', '{\"name\":\"plg_editors_none\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Unknown\",\"copyright\":\"\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"\",\"version\":\"3.0.0\",\"description\":\"PLG_NONE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '2', '0');
INSERT INTO `wy587_extensions` VALUES ('412', 'plg_editors_tinymce', 'plugin', 'tinymce', 'editors', '0', '1', '1', '0', '{\"name\":\"plg_editors_tinymce\",\"type\":\"plugin\",\"creationDate\":\"2005-2014\",\"author\":\"Moxiecode Systems AB\",\"copyright\":\"Moxiecode Systems AB\",\"authorEmail\":\"N\\/A\",\"authorUrl\":\"tinymce.moxiecode.com\",\"version\":\"4.1.2\",\"description\":\"PLG_TINY_XML_DESCRIPTION\",\"group\":\"\"}', '{\"mode\":\"1\",\"skin\":\"0\",\"mobile\":\"0\",\"entity_encoding\":\"raw\",\"lang_mode\":\"1\",\"text_direction\":\"ltr\",\"content_css\":\"1\",\"content_css_custom\":\"\",\"relative_urls\":\"1\",\"newlines\":\"0\",\"invalid_elements\":\"script,applet,iframe\",\"extended_elements\":\"\",\"html_height\":\"550\",\"html_width\":\"750\",\"resizing\":\"1\",\"element_path\":\"1\",\"fonts\":\"1\",\"paste\":\"1\",\"searchreplace\":\"1\",\"insertdate\":\"1\",\"colors\":\"1\",\"table\":\"1\",\"smilies\":\"1\",\"hr\":\"1\",\"link\":\"1\",\"media\":\"1\",\"print\":\"1\",\"directionality\":\"1\",\"fullscreen\":\"1\",\"alignment\":\"1\",\"visualchars\":\"1\",\"visualblocks\":\"1\",\"nonbreaking\":\"1\",\"template\":\"1\",\"blockquote\":\"1\",\"wordcount\":\"1\",\"advlist\":\"1\",\"autosave\":\"1\",\"contextmenu\":\"1\",\"inlinepopups\":\"1\",\"custom_plugin\":\"\",\"custom_button\":\"\"}', '', '', '0', '0000-00-00 00:00:00', '3', '0');
INSERT INTO `wy587_extensions` VALUES ('413', 'plg_editors-xtd_article', 'plugin', 'article', 'editors-xtd', '0', '1', '1', '1', '{\"name\":\"plg_editors-xtd_article\",\"type\":\"plugin\",\"creationDate\":\"October 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_ARTICLE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('414', 'plg_editors-xtd_image', 'plugin', 'image', 'editors-xtd', '0', '1', '1', '0', '{\"name\":\"plg_editors-xtd_image\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_IMAGE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '2', '0');
INSERT INTO `wy587_extensions` VALUES ('415', 'plg_editors-xtd_pagebreak', 'plugin', 'pagebreak', 'editors-xtd', '0', '1', '1', '0', '{\"name\":\"plg_editors-xtd_pagebreak\",\"type\":\"plugin\",\"creationDate\":\"August 2004\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_EDITORSXTD_PAGEBREAK_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '3', '0');
INSERT INTO `wy587_extensions` VALUES ('416', 'plg_editors-xtd_readmore', 'plugin', 'readmore', 'editors-xtd', '0', '1', '1', '0', '{\"name\":\"plg_editors-xtd_readmore\",\"type\":\"plugin\",\"creationDate\":\"March 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_READMORE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '4', '0');
INSERT INTO `wy587_extensions` VALUES ('417', 'plg_search_categories', 'plugin', 'categories', 'search', '0', '1', '1', '0', '{\"name\":\"plg_search_categories\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}', '{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('418', 'plg_search_contacts', 'plugin', 'contacts', 'search', '0', '1', '1', '0', '{\"name\":\"plg_search_contacts\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_CONTACTS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('419', 'plg_search_content', 'plugin', 'content', 'search', '0', '1', '1', '0', '{\"name\":\"plg_search_content\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_CONTENT_XML_DESCRIPTION\",\"group\":\"\"}', '{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('420', 'plg_search_newsfeeds', 'plugin', 'newsfeeds', 'search', '0', '1', '1', '0', '{\"name\":\"plg_search_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('421', 'plg_search_weblinks', 'plugin', 'weblinks', 'search', '0', '1', '1', '0', '{\"name\":\"plg_search_weblinks\",\"type\":\"plugin\",\"creationDate\":\"November 2005\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"search_limit\":\"50\",\"search_content\":\"1\",\"search_archived\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('422', 'plg_system_languagefilter', 'plugin', 'languagefilter', 'system', '0', '0', '1', '1', '{\"name\":\"plg_system_languagefilter\",\"type\":\"plugin\",\"creationDate\":\"July 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_LANGUAGEFILTER_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('423', 'plg_system_p3p', 'plugin', 'p3p', 'system', '0', '1', '1', '0', '{\"name\":\"plg_system_p3p\",\"type\":\"plugin\",\"creationDate\":\"September 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_P3P_XML_DESCRIPTION\",\"group\":\"\"}', '{\"headers\":\"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM\"}', '', '', '0', '0000-00-00 00:00:00', '2', '0');
INSERT INTO `wy587_extensions` VALUES ('424', 'plg_system_cache', 'plugin', 'cache', 'system', '0', '0', '1', '1', '{\"name\":\"plg_system_cache\",\"type\":\"plugin\",\"creationDate\":\"February 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CACHE_XML_DESCRIPTION\",\"group\":\"\"}', '{\"browsercache\":\"0\",\"cachetime\":\"15\"}', '', '', '0', '0000-00-00 00:00:00', '9', '0');
INSERT INTO `wy587_extensions` VALUES ('425', 'plg_system_debug', 'plugin', 'debug', 'system', '0', '1', '1', '0', '{\"name\":\"plg_system_debug\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_DEBUG_XML_DESCRIPTION\",\"group\":\"\"}', '{\"profile\":\"1\",\"queries\":\"1\",\"memory\":\"1\",\"language_files\":\"1\",\"language_strings\":\"1\",\"strip-first\":\"1\",\"strip-prefix\":\"\",\"strip-suffix\":\"\"}', '', '', '0', '0000-00-00 00:00:00', '4', '0');
INSERT INTO `wy587_extensions` VALUES ('426', 'plg_system_log', 'plugin', 'log', 'system', '0', '1', '1', '1', '{\"name\":\"plg_system_log\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_LOG_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('427', 'plg_system_redirect', 'plugin', 'redirect', 'system', '0', '0', '1', '1', '{\"name\":\"plg_system_redirect\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_REDIRECT_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '6', '0');
INSERT INTO `wy587_extensions` VALUES ('428', 'plg_system_remember', 'plugin', 'remember', 'system', '0', '1', '1', '1', '{\"name\":\"plg_system_remember\",\"type\":\"plugin\",\"creationDate\":\"April 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_REMEMBER_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '7', '0');
INSERT INTO `wy587_extensions` VALUES ('429', 'plg_system_sef', 'plugin', 'sef', 'system', '0', '1', '1', '0', '{\"name\":\"plg_system_sef\",\"type\":\"plugin\",\"creationDate\":\"December 2007\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEF_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '8', '0');
INSERT INTO `wy587_extensions` VALUES ('430', 'plg_system_logout', 'plugin', 'logout', 'system', '0', '1', '1', '1', '{\"name\":\"plg_system_logout\",\"type\":\"plugin\",\"creationDate\":\"April 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_LOGOUT_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '3', '0');
INSERT INTO `wy587_extensions` VALUES ('431', 'plg_user_contactcreator', 'plugin', 'contactcreator', 'user', '0', '0', '1', '0', '{\"name\":\"plg_user_contactcreator\",\"type\":\"plugin\",\"creationDate\":\"August 2009\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTACTCREATOR_XML_DESCRIPTION\",\"group\":\"\"}', '{\"autowebpage\":\"\",\"category\":\"34\",\"autopublish\":\"0\"}', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('432', 'plg_user_joomla', 'plugin', 'joomla', 'user', '0', '1', '1', '0', '{\"name\":\"plg_user_joomla\",\"type\":\"plugin\",\"creationDate\":\"December 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2009 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_USER_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}', '{\"strong_passwords\":\"1\",\"autoregister\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '2', '0');
INSERT INTO `wy587_extensions` VALUES ('433', 'plg_user_profile', 'plugin', 'profile', 'user', '0', '0', '1', '0', '{\"name\":\"plg_user_profile\",\"type\":\"plugin\",\"creationDate\":\"January 2008\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_USER_PROFILE_XML_DESCRIPTION\",\"group\":\"\"}', '{\"register-require_address1\":\"1\",\"register-require_address2\":\"1\",\"register-require_city\":\"1\",\"register-require_region\":\"1\",\"register-require_country\":\"1\",\"register-require_postal_code\":\"1\",\"register-require_phone\":\"1\",\"register-require_website\":\"1\",\"register-require_favoritebook\":\"1\",\"register-require_aboutme\":\"1\",\"register-require_tos\":\"1\",\"register-require_dob\":\"1\",\"profile-require_address1\":\"1\",\"profile-require_address2\":\"1\",\"profile-require_city\":\"1\",\"profile-require_region\":\"1\",\"profile-require_country\":\"1\",\"profile-require_postal_code\":\"1\",\"profile-require_phone\":\"1\",\"profile-require_website\":\"1\",\"profile-require_favoritebook\":\"1\",\"profile-require_aboutme\":\"1\",\"profile-require_tos\":\"1\",\"profile-require_dob\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('434', 'plg_extension_joomla', 'plugin', 'joomla', 'extension', '0', '1', '1', '1', '{\"name\":\"plg_extension_joomla\",\"type\":\"plugin\",\"creationDate\":\"May 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_EXTENSION_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('435', 'plg_content_joomla', 'plugin', 'joomla', 'content', '0', '1', '1', '0', '{\"name\":\"plg_content_joomla\",\"type\":\"plugin\",\"creationDate\":\"November 2010\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('436', 'plg_system_languagecode', 'plugin', 'languagecode', 'system', '0', '0', '1', '0', '{\"name\":\"plg_system_languagecode\",\"type\":\"plugin\",\"creationDate\":\"November 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_LANGUAGECODE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '10', '0');
INSERT INTO `wy587_extensions` VALUES ('437', 'plg_quickicon_joomlaupdate', 'plugin', 'joomlaupdate', 'quickicon', '0', '1', '1', '1', '{\"name\":\"plg_quickicon_joomlaupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_QUICKICON_JOOMLAUPDATE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('438', 'plg_quickicon_extensionupdate', 'plugin', 'extensionupdate', 'quickicon', '0', '1', '1', '1', '{\"name\":\"plg_quickicon_extensionupdate\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_QUICKICON_EXTENSIONUPDATE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('439', 'plg_captcha_recaptcha', 'plugin', 'recaptcha', 'captcha', '0', '0', '1', '0', '{\"name\":\"plg_captcha_recaptcha\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CAPTCHA_RECAPTCHA_XML_DESCRIPTION\",\"group\":\"\"}', '{\"public_key\":\"\",\"private_key\":\"\",\"theme\":\"clean\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('440', 'plg_system_highlight', 'plugin', 'highlight', 'system', '0', '1', '1', '0', '{\"name\":\"plg_system_highlight\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SYSTEM_HIGHLIGHT_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '7', '0');
INSERT INTO `wy587_extensions` VALUES ('441', 'plg_content_finder', 'plugin', 'finder', 'content', '0', '0', '1', '0', '{\"name\":\"plg_content_finder\",\"type\":\"plugin\",\"creationDate\":\"December 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_CONTENT_FINDER_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('442', 'plg_finder_categories', 'plugin', 'categories', 'finder', '0', '1', '1', '0', '{\"name\":\"plg_finder_categories\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_CATEGORIES_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('443', 'plg_finder_contacts', 'plugin', 'contacts', 'finder', '0', '1', '1', '0', '{\"name\":\"plg_finder_contacts\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_CONTACTS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '2', '0');
INSERT INTO `wy587_extensions` VALUES ('444', 'plg_finder_content', 'plugin', 'content', 'finder', '0', '1', '1', '0', '{\"name\":\"plg_finder_content\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_CONTENT_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '3', '0');
INSERT INTO `wy587_extensions` VALUES ('445', 'plg_finder_newsfeeds', 'plugin', 'newsfeeds', 'finder', '0', '1', '1', '0', '{\"name\":\"plg_finder_newsfeeds\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_NEWSFEEDS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '4', '0');
INSERT INTO `wy587_extensions` VALUES ('446', 'plg_finder_weblinks', 'plugin', 'weblinks', 'finder', '0', '1', '1', '0', '{\"name\":\"plg_finder_weblinks\",\"type\":\"plugin\",\"creationDate\":\"August 2011\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_WEBLINKS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('447', 'plg_finder_tags', 'plugin', 'tags', 'finder', '0', '1', '1', '0', '{\"name\":\"plg_finder_tags\",\"type\":\"plugin\",\"creationDate\":\"February 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_FINDER_TAGS_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('448', 'plg_twofactorauth_totp', 'plugin', 'totp', 'twofactorauth', '0', '0', '1', '0', '{\"name\":\"plg_twofactorauth_totp\",\"type\":\"plugin\",\"creationDate\":\"August 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"PLG_TWOFACTORAUTH_TOTP_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('449', 'plg_authentication_cookie', 'plugin', 'cookie', 'authentication', '0', '1', '1', '0', '{\"name\":\"plg_authentication_cookie\",\"type\":\"plugin\",\"creationDate\":\"July 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_AUTH_COOKIE_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('450', 'plg_twofactorauth_yubikey', 'plugin', 'yubikey', 'twofactorauth', '0', '0', '1', '0', '{\"name\":\"plg_twofactorauth_yubikey\",\"type\":\"plugin\",\"creationDate\":\"September 2013\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.2.0\",\"description\":\"PLG_TWOFACTORAUTH_YUBIKEY_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('451', 'plg_search_tags', 'plugin', 'tags', 'search', '0', '1', '1', '0', '{\"name\":\"plg_search_tags\",\"type\":\"plugin\",\"creationDate\":\"March 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_TAGS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"search_limit\":\"50\",\"show_tagged_items\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('503', 'beez3', 'template', 'beez3', '', '0', '1', '1', '0', '{\"name\":\"beez3\",\"type\":\"template\",\"creationDate\":\"25 November 2009\",\"author\":\"Angie Radtke\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"a.radtke@derauftritt.de\",\"authorUrl\":\"http:\\/\\/www.der-auftritt.de\",\"version\":\"3.1.0\",\"description\":\"TPL_BEEZ3_XML_DESCRIPTION\",\"group\":\"\"}', '{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"sitetitle\":\"\",\"sitedescription\":\"\",\"navposition\":\"center\",\"templatecolor\":\"nature\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('504', 'hathor', 'template', 'hathor', '', '1', '1', '1', '0', '{\"name\":\"hathor\",\"type\":\"template\",\"creationDate\":\"May 2010\",\"author\":\"Andrea Tarr\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"hathor@tarrconsulting.com\",\"authorUrl\":\"http:\\/\\/www.tarrconsulting.com\",\"version\":\"3.0.0\",\"description\":\"TPL_HATHOR_XML_DESCRIPTION\",\"group\":\"\"}', '{\"showSiteName\":\"0\",\"colourChoice\":\"0\",\"boldText\":\"0\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('506', 'protostar', 'template', 'protostar', '', '0', '1', '1', '0', '{\"name\":\"protostar\",\"type\":\"template\",\"creationDate\":\"4\\/30\\/2012\",\"author\":\"Kyle Ledbetter\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"\",\"version\":\"1.0\",\"description\":\"TPL_PROTOSTAR_XML_DESCRIPTION\",\"group\":\"\"}', '{\"templateColor\":\"\",\"logoFile\":\"\",\"googleFont\":\"1\",\"googleFontName\":\"Open+Sans\",\"fluidContainer\":\"0\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('507', 'isis', 'template', 'isis', '', '1', '1', '1', '0', '{\"name\":\"isis\",\"type\":\"template\",\"creationDate\":\"3\\/30\\/2012\",\"author\":\"Kyle Ledbetter\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters, Inc. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"\",\"version\":\"1.0\",\"description\":\"TPL_ISIS_XML_DESCRIPTION\",\"group\":\"\"}', '{\"templateColor\":\"\",\"logoFile\":\"\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('600', 'English (United Kingdom)', 'language', 'en-GB', '', '0', '1', '1', '1', '{\"name\":\"English (United Kingdom)\",\"type\":\"language\",\"creationDate\":\"2013-03-07\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.3.1\",\"description\":\"en-GB site language\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('601', 'English (United Kingdom)', 'language', 'en-GB', '', '1', '1', '1', '1', '{\"name\":\"English (United Kingdom)\",\"type\":\"language\",\"creationDate\":\"2013-03-07\",\"author\":\"Joomla! Project\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved.\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.3.1\",\"description\":\"en-GB administrator language\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('700', 'files_joomla', 'file', 'joomla', '', '0', '1', '1', '1', '{\"name\":\"files_joomla\",\"type\":\"file\",\"creationDate\":\"September 2014\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2014 Open Source Matters. All rights reserved\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.3.6\",\"description\":\"FILES_JOOMLA_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10000', 'Russian', 'language', 'ru-RU', '', '0', '1', '0', '0', '{\"name\":\"Russian\",\"type\":\"language\",\"creationDate\":\"2014-12-15\",\"author\":\"Russian Translation Team\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved\",\"authorEmail\":\"smart@joomlaportal.ru\",\"authorUrl\":\"www.joomlaportal.ru\",\"version\":\"3.3.6.2\",\"description\":\"Russian language pack (site) for Joomla! 3.3\",\"group\":\"\"}', '{}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10001', 'Russian', 'language', 'ru-RU', '', '1', '1', '0', '0', '{\"name\":\"Russian\",\"type\":\"language\",\"creationDate\":\"2014-12-15\",\"author\":\"Russian Translation Team\",\"copyright\":\"Copyright (C) 2005 - 2014 Open Source Matters. All rights reserved\",\"authorEmail\":\"smart@joomlaportal.ru\",\"authorUrl\":\"www.joomlaportal.ru\",\"version\":\"3.3.6.2\",\"description\":\"Russian language pack (administrator) for Joomla! 3.3\",\"group\":\"\"}', '{}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10002', 'ru-RU', 'package', 'pkg_ru-RU', '', '0', '1', '1', '0', '{\"name\":\"Russian Language Pack\",\"type\":\"package\",\"creationDate\":\"Unknown\",\"author\":\"Unknown\",\"copyright\":\"\",\"authorEmail\":\"\",\"authorUrl\":\"\",\"version\":\"3.3.6.2\",\"description\":\"Joomla 3.3 Russian Language Package\",\"group\":\"\"}', '{}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10003', 'virtuemart', 'component', 'com_virtuemart', '', '1', '1', '0', '0', '{\"name\":\"VIRTUEMART\",\"type\":\"component\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"max|at|virtuemart.net\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"\",\"group\":\"\"}', '{}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10004', 'virtuemart_allinone', 'component', 'com_virtuemart_allinone', '', '1', '1', '0', '0', '{\"name\":\"VirtueMart_allinone\",\"type\":\"component\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2013 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"\",\"group\":\"\"}', '{}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10005', 'VM Payment - Standard', 'plugin', 'standard', 'vmpayment', '0', '1', '1', '0', '{\"name\":\"Standard\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"Standard payment plugin\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('10006', 'VM Payment - Klarna', 'plugin', 'klarna', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"Klarna\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"Klarna VirtueMart Payment Plugin\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '1', '0');
INSERT INTO `wy587_extensions` VALUES ('10007', 'VM Payment - KlarnaCheckout', 'plugin', 'klarnacheckout', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"Klarna Checkout\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('10008', 'VM Payment - Sofort Banking/Überweisung', 'plugin', 'sofort', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"Sofort\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"<a href=\\\"http:\\/www.sofort.com\\\" target=\\\"_blank\\\">Sofort<\\/a> is a popular\\n\\tpayment provider and available in many countries. \\n    \",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '2', '0');
INSERT INTO `wy587_extensions` VALUES ('10009', 'VM Payment - PayPal', 'plugin', 'paypal', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"PayPal\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"PayPal\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '3', '0');
INSERT INTO `wy587_extensions` VALUES ('10010', 'VM Payment - Heidelpay', 'plugin', 'heidelpay', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"Heidelpay\",\"type\":\"plugin\",\"creationDate\":\"12-Sep-2012\",\"author\":\"Heidelberger Payment GmbH\",\"copyright\":\"Copyright Heidelberger Payment GmbH\",\"authorEmail\":\"info@heidelpay.de\",\"authorUrl\":\"http:\\/\\/www.heidelpay.de\",\"version\":\"3.0.0\",\"description\":\"\\n        <h2>Virtuemart Plugin von:<\\/h2><p><a href=\\\"http:\\/\\/www.Heidelpay.de\\\" target=\\\"_blank\\\"><img src=\\\"http:\\/\\/www.heidelpay.de\\/gfx\\/logo.gif\\\" style=\\\"margin-right:20px;\\\"\\/><\\/a><\\/p> \",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('10011', 'VM Payment - Paybox', 'plugin', 'paybox', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"VM Payment - Paybox\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"<a href=\\\"http:\\/\\/paybox.com\\\" target=\\\"_blank\\\">Paybox<\\/a> \\n    \",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('10012', 'VM Payment - Realex HPP & API', 'plugin', 'realex_hpp_api', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"realex_hpp_api\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"Realex HPP and API\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('10013', 'VM UserField - Realex HPP & API', 'plugin', 'realex_hpp_api', 'vmuserfield', '0', '0', '1', '0', '{\"name\":\"Realex_hpp_api\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"Card storage plugin for Realex\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10014', 'VM Payment - Skrill', 'plugin', 'skrill', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"Skrill\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"Skrill Holdings Limited\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.skrill.com\",\"version\":\"3.0.0\",\"description\":\"<a href=\\\"http:\\/\\/www.skrill.com\\\" target=\\\"_blank\\\">skrill<\\/a> is a popular\\n\\tpayment provider authorised by the Financial Services Authority of the United Kingdom (FSA). \\n    \",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('10015', 'VM Payment - Authorize.net', 'plugin', 'authorizenet', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"Authorize.net AIM\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"Authorize.net AIM\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('10016', 'VM Payment - Sofort iDeal', 'plugin', 'sofort_ideal', 'vmpayment', '0', '0', '1', '0', '{\"name\":\"Sofort Ideal\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"<a href=\\\"http:\\/www.sofort.com\\\" target=\\\"_blank\\\">Sofort<\\/a> is a popular\\n\\tpayment provider and available in many countries. \\n    \",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '2', '0');
INSERT INTO `wy587_extensions` VALUES ('10017', 'VM Shipment - By weight, ZIP and countries', 'plugin', 'weight_countries', 'vmshipment', '0', '1', '1', '0', '{\"name\":\"By weight, ZIP and countries\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"VMSHIPMENT_WEIGHT_COUNTRIES_PLUGIN_DESC\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10018', 'VM Custom - Customer text input', 'plugin', 'textinput', 'vmcustom', '0', '1', '1', '0', '{\"name\":\"VMCustom - textinput\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"text input plugin for product\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10019', 'VM Custom - Product specification', 'plugin', 'specification', 'vmcustom', '0', '1', '1', '0', '{\"name\":\"plgvm_specification\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"VMCustom - specification; text input plugin for product\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10020', 'VM Calculation - Avalara Tax', 'plugin', 'avalara', 'vmcalculation', '0', '0', '1', '0', '{\"name\":\"plgvm_avalara\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"Max Milbers\",\"copyright\":\"Copyright (C) 2013 iStraxx UG (haftungsbeschr\\u00e4nkt). All rights reserved\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"VM - Calculation Avalara Tax; On demand tax calculation for whole U.S.A.\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10021', 'VirtueMart Product', 'plugin', 'virtuemart', 'search', '0', '1', '1', '0', '{\"name\":\"Search - VirtueMart\",\"type\":\"plugin\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"PLG_SEARCH_VIRTUEMART_XML_DESCRIPTION\",\"group\":\"\"}', '{\"search_limit\":50,\"enable_product_description_search\":\"1\",\"enable_product_short_description_search\":\"1\",\"enable_customfields\":\"1\",\"customfields\":\"\",\"subtitledisplay\":\"1\"}', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10022', 'mod_vmmenu', 'module', 'mod_vmmenu', '', '1', '1', '3', '0', '{\"name\":\"VirtueMart Administrator Menu\",\"type\":\"module\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2013 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"max|at|virtuemart.net\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"MOD_VMMENU_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('10023', 'mod_virtuemart_currencies', 'module', 'mod_virtuemart_currencies', '', '0', '1', '1', '0', '{\"name\":\"mod_virtuemart_currencies\",\"type\":\"module\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"MOD_VIRTUEMART_CURRENCIES_DESC\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '5', '0');
INSERT INTO `wy587_extensions` VALUES ('10024', 'mod_virtuemart_product', 'module', 'mod_virtuemart_product', '', '0', '1', '1', '0', '{\"name\":\"mod_virtuemart_product\",\"type\":\"module\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"MOD_VIRTUEMART_PRODUCT_DESC\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '3', '0');
INSERT INTO `wy587_extensions` VALUES ('10025', 'mod_virtuemart_search', 'module', 'mod_virtuemart_search', '', '0', '1', '1', '0', '{\"name\":\"mod_virtuemart_search\",\"type\":\"module\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"MOD_VIRTUEMART_SEARCH_DESC\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '2', '0');
INSERT INTO `wy587_extensions` VALUES ('10026', 'mod_virtuemart_manufacturer', 'module', 'mod_virtuemart_manufacturer', '', '0', '1', '1', '0', '{\"name\":\"mod_virtuemart_manufacturer\",\"type\":\"module\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"MOD_VIRTUEMART_MANUFACTURER_DESC\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '8', '0');
INSERT INTO `wy587_extensions` VALUES ('10027', 'mod_virtuemart_cart', 'module', 'mod_virtuemart_cart', '', '0', '1', '1', '0', '{\"name\":\"mod_virtuemart_cart\",\"type\":\"module\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"MOD_VIRTUEMART_CART_DESC\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');
INSERT INTO `wy587_extensions` VALUES ('10028', 'mod_virtuemart_category', 'module', 'mod_virtuemart_category', '', '0', '1', '1', '0', '{\"name\":\"mod_virtuemart_category\",\"type\":\"module\",\"creationDate\":\"November 18 2014\",\"author\":\"The VirtueMart Development Team\",\"copyright\":\"Copyright (C) 2004-2014 Virtuemart Team. All rights reserved.\",\"authorEmail\":\"\",\"authorUrl\":\"http:\\/\\/www.virtuemart.net\",\"version\":\"3.0.0\",\"description\":\"MOD_VIRTUEMART_CATEGORY_DESC\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '4', '0');
INSERT INTO `wy587_extensions` VALUES ('10029', 'com_virtuemart - ru-RU', 'file', 'com_virtuemart-ru-RU', '', '0', '1', '0', '0', '{\"name\":\"com_virtuemart - ru-RU\",\"type\":\"file\",\"creationDate\":\"28.12.2014\",\"author\":\"VirtueMart language team\",\"copyright\":\"\\u00a9 2008-2014 - compojoom-com. All rights reserved!\",\"authorEmail\":\"max@virtuemart.net\",\"authorUrl\":\"https:\\/\\/virtuemart.net\",\"version\":\"2014-12-28-07-46-37\",\"description\":\"\\n        This package was auto generated with CTransifex(https:\\/\\/compojoom.com). We\'ve grabbed the latest language files for our extension from transifex.com.\\n        Special thanks to our translation team at (https:\\/\\/www.transifex.com\\/projects\\/p\\/virtuemart\\/) for helping with this VirtueMart translation!\\n    \",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0');

-- ----------------------------
-- Table structure for `wy587_finder_filters`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_filters`;
CREATE TABLE `wy587_finder_filters` (
  `filter_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL,
  `created_by_alias` varchar(255) NOT NULL,
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `map_count` int(10) unsigned NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `params` mediumtext,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_filters
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links`;
CREATE TABLE `wy587_finder_links` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `route` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `indexdate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `md5sum` varchar(32) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `state` int(5) DEFAULT '1',
  `access` int(5) DEFAULT '0',
  `language` varchar(8) NOT NULL,
  `publish_start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `list_price` double unsigned NOT NULL DEFAULT '0',
  `sale_price` double unsigned NOT NULL DEFAULT '0',
  `type_id` int(11) NOT NULL,
  `object` mediumblob NOT NULL,
  PRIMARY KEY (`link_id`),
  KEY `idx_type` (`type_id`),
  KEY `idx_title` (`title`),
  KEY `idx_md5` (`md5sum`),
  KEY `idx_url` (`url`(75)),
  KEY `idx_published_list` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`list_price`),
  KEY `idx_published_sale` (`published`,`state`,`access`,`publish_start_date`,`publish_end_date`,`sale_price`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms0`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms0`;
CREATE TABLE `wy587_finder_links_terms0` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms0
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms1`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms1`;
CREATE TABLE `wy587_finder_links_terms1` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms1
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms2`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms2`;
CREATE TABLE `wy587_finder_links_terms2` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms2
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms3`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms3`;
CREATE TABLE `wy587_finder_links_terms3` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms3
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms4`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms4`;
CREATE TABLE `wy587_finder_links_terms4` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms4
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms5`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms5`;
CREATE TABLE `wy587_finder_links_terms5` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms5
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms6`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms6`;
CREATE TABLE `wy587_finder_links_terms6` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms6
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms7`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms7`;
CREATE TABLE `wy587_finder_links_terms7` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms7
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms8`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms8`;
CREATE TABLE `wy587_finder_links_terms8` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms8
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_terms9`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_terms9`;
CREATE TABLE `wy587_finder_links_terms9` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_terms9
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_termsa`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_termsa`;
CREATE TABLE `wy587_finder_links_termsa` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_termsa
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_termsb`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_termsb`;
CREATE TABLE `wy587_finder_links_termsb` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_termsb
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_termsc`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_termsc`;
CREATE TABLE `wy587_finder_links_termsc` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_termsc
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_termsd`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_termsd`;
CREATE TABLE `wy587_finder_links_termsd` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_termsd
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_termse`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_termse`;
CREATE TABLE `wy587_finder_links_termse` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_termse
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_links_termsf`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_links_termsf`;
CREATE TABLE `wy587_finder_links_termsf` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_links_termsf
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_taxonomy`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_taxonomy`;
CREATE TABLE `wy587_finder_taxonomy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `state` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `access` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `state` (`state`),
  KEY `ordering` (`ordering`),
  KEY `access` (`access`),
  KEY `idx_parent_published` (`parent_id`,`state`,`access`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_taxonomy
-- ----------------------------
INSERT INTO `wy587_finder_taxonomy` VALUES ('1', '0', 'ROOT', '0', '0', '0');

-- ----------------------------
-- Table structure for `wy587_finder_taxonomy_map`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_taxonomy_map`;
CREATE TABLE `wy587_finder_taxonomy_map` (
  `link_id` int(10) unsigned NOT NULL,
  `node_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`node_id`),
  KEY `link_id` (`link_id`),
  KEY `node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_taxonomy_map
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_terms`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_terms`;
CREATE TABLE `wy587_finder_terms` (
  `term_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '0',
  `soundex` varchar(75) NOT NULL,
  `links` int(10) NOT NULL DEFAULT '0',
  `language` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`term_id`),
  UNIQUE KEY `idx_term` (`term`),
  KEY `idx_term_phrase` (`term`,`phrase`),
  KEY `idx_stem_phrase` (`stem`,`phrase`),
  KEY `idx_soundex_phrase` (`soundex`,`phrase`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_terms
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_terms_common`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_terms_common`;
CREATE TABLE `wy587_finder_terms_common` (
  `term` varchar(75) NOT NULL,
  `language` varchar(3) NOT NULL,
  KEY `idx_word_lang` (`term`,`language`),
  KEY `idx_lang` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_terms_common
-- ----------------------------
INSERT INTO `wy587_finder_terms_common` VALUES ('a', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('about', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('after', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('ago', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('all', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('am', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('an', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('and', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('ani', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('any', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('are', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('aren\'t', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('as', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('at', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('be', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('but', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('by', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('for', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('from', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('get', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('go', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('how', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('if', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('in', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('into', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('is', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('isn\'t', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('it', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('its', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('me', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('more', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('most', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('must', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('my', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('new', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('no', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('none', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('not', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('noth', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('nothing', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('of', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('off', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('often', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('old', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('on', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('onc', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('once', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('onli', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('only', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('or', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('other', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('our', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('ours', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('out', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('over', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('page', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('she', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('should', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('small', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('so', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('some', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('than', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('thank', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('that', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('the', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('their', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('theirs', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('them', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('then', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('there', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('these', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('they', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('this', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('those', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('thus', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('time', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('times', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('to', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('too', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('true', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('under', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('until', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('up', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('upon', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('use', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('user', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('users', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('veri', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('version', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('very', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('via', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('want', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('was', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('way', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('were', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('what', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('when', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('where', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('whi', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('which', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('who', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('whom', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('whose', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('why', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('wide', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('will', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('with', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('within', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('without', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('would', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('yes', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('yet', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('you', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('your', 'en');
INSERT INTO `wy587_finder_terms_common` VALUES ('yours', 'en');

-- ----------------------------
-- Table structure for `wy587_finder_tokens`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_tokens`;
CREATE TABLE `wy587_finder_tokens` (
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `weight` float unsigned NOT NULL DEFAULT '1',
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `language` char(3) NOT NULL DEFAULT '',
  KEY `idx_word` (`term`),
  KEY `idx_context` (`context`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_tokens_aggregate`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_tokens_aggregate`;
CREATE TABLE `wy587_finder_tokens_aggregate` (
  `term_id` int(10) unsigned NOT NULL,
  `map_suffix` char(1) NOT NULL,
  `term` varchar(75) NOT NULL,
  `stem` varchar(75) NOT NULL,
  `common` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `phrase` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `term_weight` float unsigned NOT NULL,
  `context` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `context_weight` float unsigned NOT NULL,
  `total_weight` float unsigned NOT NULL,
  `language` char(3) NOT NULL DEFAULT '',
  KEY `token` (`term`),
  KEY `keyword_id` (`term_id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_tokens_aggregate
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_finder_types`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_finder_types`;
CREATE TABLE `wy587_finder_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `mime` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_finder_types
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_languages`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_languages`;
CREATE TABLE `wy587_languages` (
  `lang_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang_code` char(7) NOT NULL,
  `title` varchar(50) NOT NULL,
  `title_native` varchar(50) NOT NULL,
  `sef` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `description` varchar(512) NOT NULL,
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `sitename` varchar(1024) NOT NULL DEFAULT '',
  `published` int(11) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`lang_id`),
  UNIQUE KEY `idx_sef` (`sef`),
  UNIQUE KEY `idx_image` (`image`),
  UNIQUE KEY `idx_langcode` (`lang_code`),
  KEY `idx_access` (`access`),
  KEY `idx_ordering` (`ordering`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_languages
-- ----------------------------
INSERT INTO `wy587_languages` VALUES ('1', 'en-GB', 'English (UK)', 'English (UK)', 'en', 'en', '', '', '', '', '1', '1', '1');
INSERT INTO `wy587_languages` VALUES ('2', 'ru-RU', 'Русский', 'Ru', 'ru', 'ru', '', '', '', '', '1', '1', '0');

-- ----------------------------
-- Table structure for `wy587_menu`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_menu`;
CREATE TABLE `wy587_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL COMMENT 'The type of menu this item belongs to. FK to #__menu_types.menutype',
  `title` varchar(255) NOT NULL COMMENT 'The display title of the menu item.',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The SEF alias of the menu item.',
  `note` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(1024) NOT NULL COMMENT 'The computed path of the menu item based on the alias field.',
  `link` varchar(1024) NOT NULL COMMENT 'The actually link the menu item refers to.',
  `type` varchar(16) NOT NULL COMMENT 'The type of link: Component, URL, Alias, Separator',
  `published` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The published state of the menu link.',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'The parent menu item in the menu tree.',
  `level` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The relative level in the tree.',
  `component_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__extensions.id',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to #__users.id',
  `checked_out_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'The time the menu item was checked out.',
  `browserNav` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The click behaviour of the link.',
  `access` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The access level required to view the menu item.',
  `img` varchar(255) NOT NULL COMMENT 'The image of the menu item.',
  `template_style_id` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL COMMENT 'JSON encoded data for the menu item.',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `home` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicates if this menu item is the home or default page.',
  `language` char(7) NOT NULL DEFAULT '',
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_client_id_parent_id_alias_language` (`client_id`,`parent_id`,`alias`,`language`),
  KEY `idx_componentid` (`component_id`,`menutype`,`published`,`access`),
  KEY `idx_menutype` (`menutype`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_path` (`path`(255)),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_menu
-- ----------------------------
INSERT INTO `wy587_menu` VALUES ('1', '', 'Menu_Item_Root', 'root', '', '', '', '', '1', '0', '0', '0', '0', '0000-00-00 00:00:00', '0', '0', '', '0', '', '0', '77', '0', '*', '0');
INSERT INTO `wy587_menu` VALUES ('2', 'menu', 'com_banners', 'Banners', '', 'Banners', 'index.php?option=com_banners', 'component', '0', '1', '1', '4', '0', '0000-00-00 00:00:00', '0', '0', 'class:banners', '0', '', '1', '10', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('3', 'menu', 'com_banners', 'Banners', '', 'Banners/Banners', 'index.php?option=com_banners', 'component', '0', '2', '2', '4', '0', '0000-00-00 00:00:00', '0', '0', 'class:banners', '0', '', '2', '3', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('4', 'menu', 'com_banners_categories', 'Categories', '', 'Banners/Categories', 'index.php?option=com_categories&extension=com_banners', 'component', '0', '2', '2', '6', '0', '0000-00-00 00:00:00', '0', '0', 'class:banners-cat', '0', '', '4', '5', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('5', 'menu', 'com_banners_clients', 'Clients', '', 'Banners/Clients', 'index.php?option=com_banners&view=clients', 'component', '0', '2', '2', '4', '0', '0000-00-00 00:00:00', '0', '0', 'class:banners-clients', '0', '', '6', '7', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('6', 'menu', 'com_banners_tracks', 'Tracks', '', 'Banners/Tracks', 'index.php?option=com_banners&view=tracks', 'component', '0', '2', '2', '4', '0', '0000-00-00 00:00:00', '0', '0', 'class:banners-tracks', '0', '', '8', '9', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('7', 'menu', 'com_contact', 'Contacts', '', 'Contacts', 'index.php?option=com_contact', 'component', '0', '1', '1', '8', '0', '0000-00-00 00:00:00', '0', '0', 'class:contact', '0', '', '11', '16', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('8', 'menu', 'com_contact', 'Contacts', '', 'Contacts/Contacts', 'index.php?option=com_contact', 'component', '0', '7', '2', '8', '0', '0000-00-00 00:00:00', '0', '0', 'class:contact', '0', '', '12', '13', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('9', 'menu', 'com_contact_categories', 'Categories', '', 'Contacts/Categories', 'index.php?option=com_categories&extension=com_contact', 'component', '0', '7', '2', '6', '0', '0000-00-00 00:00:00', '0', '0', 'class:contact-cat', '0', '', '14', '15', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('10', 'menu', 'com_messages', 'Messaging', '', 'Messaging', 'index.php?option=com_messages', 'component', '0', '1', '1', '15', '0', '0000-00-00 00:00:00', '0', '0', 'class:messages', '0', '', '17', '22', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('11', 'menu', 'com_messages_add', 'New Private Message', '', 'Messaging/New Private Message', 'index.php?option=com_messages&task=message.add', 'component', '0', '10', '2', '15', '0', '0000-00-00 00:00:00', '0', '0', 'class:messages-add', '0', '', '18', '19', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('12', 'menu', 'com_messages_read', 'Read Private Message', '', 'Messaging/Read Private Message', 'index.php?option=com_messages', 'component', '0', '10', '2', '15', '0', '0000-00-00 00:00:00', '0', '0', 'class:messages-read', '0', '', '20', '21', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('13', 'menu', 'com_newsfeeds', 'News Feeds', '', 'News Feeds', 'index.php?option=com_newsfeeds', 'component', '0', '1', '1', '17', '0', '0000-00-00 00:00:00', '0', '0', 'class:newsfeeds', '0', '', '23', '28', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('14', 'menu', 'com_newsfeeds_feeds', 'Feeds', '', 'News Feeds/Feeds', 'index.php?option=com_newsfeeds', 'component', '0', '13', '2', '17', '0', '0000-00-00 00:00:00', '0', '0', 'class:newsfeeds', '0', '', '24', '25', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('15', 'menu', 'com_newsfeeds_categories', 'Categories', '', 'News Feeds/Categories', 'index.php?option=com_categories&extension=com_newsfeeds', 'component', '0', '13', '2', '6', '0', '0000-00-00 00:00:00', '0', '0', 'class:newsfeeds-cat', '0', '', '26', '27', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('16', 'menu', 'com_redirect', 'Redirect', '', 'Redirect', 'index.php?option=com_redirect', 'component', '0', '1', '1', '24', '0', '0000-00-00 00:00:00', '0', '0', 'class:redirect', '0', '', '29', '30', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('17', 'menu', 'com_search', 'Basic Search', '', 'Basic Search', 'index.php?option=com_search', 'component', '0', '1', '1', '19', '0', '0000-00-00 00:00:00', '0', '0', 'class:search', '0', '', '31', '32', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('18', 'menu', 'com_weblinks', 'Weblinks', '', 'Weblinks', 'index.php?option=com_weblinks', 'component', '0', '1', '1', '21', '0', '0000-00-00 00:00:00', '0', '0', 'class:weblinks', '0', '', '33', '38', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('19', 'menu', 'com_weblinks_links', 'Links', '', 'Weblinks/Links', 'index.php?option=com_weblinks', 'component', '0', '18', '2', '21', '0', '0000-00-00 00:00:00', '0', '0', 'class:weblinks', '0', '', '34', '35', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('20', 'menu', 'com_weblinks_categories', 'Categories', '', 'Weblinks/Categories', 'index.php?option=com_categories&extension=com_weblinks', 'component', '0', '18', '2', '6', '0', '0000-00-00 00:00:00', '0', '0', 'class:weblinks-cat', '0', '', '36', '37', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('21', 'menu', 'com_finder', 'Smart Search', '', 'Smart Search', 'index.php?option=com_finder', 'component', '0', '1', '1', '27', '0', '0000-00-00 00:00:00', '0', '0', 'class:finder', '0', '', '39', '40', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('22', 'menu', 'com_joomlaupdate', 'Joomla! Update', '', 'Joomla! Update', 'index.php?option=com_joomlaupdate', 'component', '1', '1', '1', '28', '0', '0000-00-00 00:00:00', '0', '0', 'class:joomlaupdate', '0', '', '41', '42', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('23', 'main', 'com_tags', 'Tags', '', 'Tags', 'index.php?option=com_tags', 'component', '0', '1', '1', '29', '0', '0000-00-00 00:00:00', '0', '1', 'class:tags', '0', '', '43', '44', '0', '', '1');
INSERT INTO `wy587_menu` VALUES ('24', 'main', 'com_postinstall', 'Post-installation messages', '', 'Post-installation messages', 'index.php?option=com_postinstall', 'component', '0', '1', '1', '32', '0', '0000-00-00 00:00:00', '0', '1', 'class:postinstall', '0', '', '45', '46', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('101', 'mainmenu', 'Home', 'home', '', 'home', 'index.php?option=com_content&view=featured', 'component', '1', '1', '1', '22', '0', '0000-00-00 00:00:00', '0', '1', '', '0', '{\"featured_categories\":[\"\"],\"layout_type\":\"blog\",\"num_leading_articles\":\"1\",\"num_intro_articles\":\"3\",\"num_columns\":\"3\",\"num_links\":\"0\",\"multi_column_order\":\"1\",\"orderby_pri\":\"\",\"orderby_sec\":\"front\",\"order_date\":\"\",\"show_pagination\":\"2\",\"show_pagination_results\":\"1\",\"show_title\":\"\",\"link_titles\":\"\",\"show_intro\":\"\",\"info_block_position\":\"\",\"show_category\":\"\",\"link_category\":\"\",\"show_parent_category\":\"\",\"link_parent_category\":\"\",\"show_author\":\"\",\"link_author\":\"\",\"show_create_date\":\"\",\"show_modify_date\":\"\",\"show_publish_date\":\"\",\"show_item_navigation\":\"\",\"show_vote\":\"\",\"show_readmore\":\"\",\"show_readmore_title\":\"\",\"show_icons\":\"\",\"show_print_icon\":\"\",\"show_email_icon\":\"\",\"show_hits\":\"\",\"show_noauth\":\"\",\"show_feed_link\":\"1\",\"feed_summary\":\"\",\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":1,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}', '47', '48', '1', '*', '0');
INSERT INTO `wy587_menu` VALUES ('102', 'main', 'COM_VIRTUEMART', 'com-virtuemart', '', 'com-virtuemart', 'index.php?option=com_virtuemart', 'component', '0', '1', '1', '10003', '0', '0000-00-00 00:00:00', '0', '1', '../components/com_virtuemart/assets/images/vmgeneral/menu_icon.png', '0', '', '49', '72', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('103', 'main', 'COM_VIRTUEMART_MENU_CATEGORIES', 'com-virtuemart-menu-categories', '', 'com-virtuemart/com-virtuemart-menu-categories', 'index.php?option=com_virtuemart&view=category', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-categories.png', '0', '', '50', '51', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('104', 'main', 'COM_VIRTUEMART_MENU_PRODUCTS', 'com-virtuemart-menu-products', '', 'com-virtuemart/com-virtuemart-menu-products', 'index.php?option=com_virtuemart&view=product', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-products.png', '0', '', '52', '53', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('105', 'main', 'COM_VIRTUEMART_MENU_ORDERS', 'com-virtuemart-menu-orders', '', 'com-virtuemart/com-virtuemart-menu-orders', 'index.php?option=com_virtuemart&view=orders', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-orders.png', '0', '', '54', '55', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('106', 'main', 'COM_VIRTUEMART_MENU_REPORT', 'com-virtuemart-menu-report', '', 'com-virtuemart/com-virtuemart-menu-report', 'index.php?option=com_virtuemart&view=report', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-report.png', '0', '', '56', '57', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('107', 'main', 'COM_VIRTUEMART_MENU_USERS', 'com-virtuemart-menu-users', '', 'com-virtuemart/com-virtuemart-menu-users', 'index.php?option=com_virtuemart&view=user', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-shoppers.png', '0', '', '58', '59', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('108', 'main', 'COM_VIRTUEMART_MENU_MANUFACTURERS', 'com-virtuemart-menu-manufacturers', '', 'com-virtuemart/com-virtuemart-menu-manufacturers', 'index.php?option=com_virtuemart&view=manufacturer', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-manufacturers.png', '0', '', '60', '61', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('109', 'main', 'COM_VIRTUEMART_MENU_STORE', 'com-virtuemart-menu-store', '', 'com-virtuemart/com-virtuemart-menu-store', 'index.php?option=com_virtuemart&view=user&task=editshop', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-shop.png', '0', '', '62', '63', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('110', 'main', 'COM_VIRTUEMART_MENU_MEDIAFILES', 'com-virtuemart-menu-mediafiles', '', 'com-virtuemart/com-virtuemart-menu-mediafiles', 'index.php?option=com_virtuemart&view=media', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-media.png', '0', '', '64', '65', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('111', 'main', 'COM_VIRTUEMART_MENU_SHIPMENTMETHODS', 'com-virtuemart-menu-shipmentmethods', '', 'com-virtuemart/com-virtuemart-menu-shipmentmethods', 'index.php?option=com_virtuemart&view=shipmentmethod', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-shipmentmethods.png', '0', '', '66', '67', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('112', 'main', 'COM_VIRTUEMART_MENU_PAYMENTMETHODS', 'com-virtuemart-menu-paymentmethods', '', 'com-virtuemart/com-virtuemart-menu-paymentmethods', 'index.php?option=com_virtuemart&view=paymentmethod', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-paymentmethods.png', '0', '', '68', '69', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('113', 'main', 'COM_VIRTUEMART_MENU_CONFIGURATION', 'com-virtuemart-menu-configuration', '', 'com-virtuemart/com-virtuemart-menu-configuration', 'index.php?option=com_virtuemart&view=config', 'component', '0', '102', '2', '10003', '0', '0000-00-00 00:00:00', '0', '1', 'components/com_virtuemart/assets/images/icon_16/menu-icon16-config.png', '0', '', '70', '71', '0', '*', '1');
INSERT INTO `wy587_menu` VALUES ('114', 'main', 'VirtueMart AIO', 'virtuemart-aio', '', 'virtuemart-aio', 'index.php?option=com_virtuemart_allinone', 'component', '0', '1', '1', '10004', '0', '0000-00-00 00:00:00', '0', '1', 'class:component', '0', '', '73', '74', '0', '', '1');
INSERT INTO `wy587_menu` VALUES ('115', 'mainmenu', 'Магазин', 'magazin', '', 'magazin', 'index.php?option=com_virtuemart&view=virtuemart&productsublayout=0', 'component', '1', '1', '1', '10003', '0', '0000-00-00 00:00:00', '0', '1', '', '0', '{\"menu-anchor_title\":\"\",\"menu-anchor_css\":\"\",\"menu_image\":\"\",\"menu_text\":1,\"page_title\":\"\",\"show_page_heading\":0,\"page_heading\":\"\",\"pageclass_sfx\":\"\",\"menu-meta_description\":\"\",\"menu-meta_keywords\":\"\",\"robots\":\"\",\"secure\":0}', '75', '76', '0', '*', '0');

-- ----------------------------
-- Table structure for `wy587_menu_types`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_menu_types`;
CREATE TABLE `wy587_menu_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL,
  `title` varchar(48) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_menutype` (`menutype`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_menu_types
-- ----------------------------
INSERT INTO `wy587_menu_types` VALUES ('1', 'mainmenu', 'Main Menu', 'The main menu for the site');

-- ----------------------------
-- Table structure for `wy587_messages`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_messages`;
CREATE TABLE `wy587_messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id_from` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id_to` int(10) unsigned NOT NULL DEFAULT '0',
  `folder_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `priority` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `useridto_state` (`user_id_to`,`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_messages
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_messages_cfg`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_messages_cfg`;
CREATE TABLE `wy587_messages_cfg` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cfg_name` varchar(100) NOT NULL DEFAULT '',
  `cfg_value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_messages_cfg
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_modules`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_modules`;
CREATE TABLE `wy587_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FK to the #__assets table.',
  `title` varchar(100) NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `content` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  `position` varchar(50) NOT NULL DEFAULT '',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `module` varchar(50) DEFAULT NULL,
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `showtitle` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `client_id` tinyint(4) NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `published` (`published`,`access`),
  KEY `newsfeeds` (`module`,`published`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_modules
-- ----------------------------
INSERT INTO `wy587_modules` VALUES ('1', '39', 'Main Menu', '', '', '1', 'position-7', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_menu', '1', '1', '{\"menutype\":\"mainmenu\",\"startLevel\":\"0\",\"endLevel\":\"0\",\"showAllChildren\":\"0\",\"tag_id\":\"\",\"class_sfx\":\"\",\"window_open\":\"\",\"layout\":\"\",\"moduleclass_sfx\":\"_menu\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}', '0', '*');
INSERT INTO `wy587_modules` VALUES ('2', '40', 'Login', '', '', '1', 'login', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_login', '1', '1', '', '1', '*');
INSERT INTO `wy587_modules` VALUES ('3', '41', 'Popular Articles', '', '', '3', 'cpanel', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_popular', '3', '1', '{\"count\":\"5\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"automatic_title\":\"1\"}', '1', '*');
INSERT INTO `wy587_modules` VALUES ('4', '42', 'Recently Added Articles', '', '', '4', 'cpanel', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_latest', '3', '1', '{\"count\":\"5\",\"ordering\":\"c_dsc\",\"catid\":\"\",\"user_id\":\"0\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"automatic_title\":\"1\"}', '1', '*');
INSERT INTO `wy587_modules` VALUES ('8', '43', 'Toolbar', '', '', '1', 'toolbar', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_toolbar', '3', '1', '', '1', '*');
INSERT INTO `wy587_modules` VALUES ('9', '44', 'Quick Icons', '', '', '1', 'icon', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_quickicon', '3', '1', '', '1', '*');
INSERT INTO `wy587_modules` VALUES ('10', '45', 'Logged-in Users', '', '', '2', 'cpanel', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_logged', '3', '1', '{\"count\":\"5\",\"name\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\",\"automatic_title\":\"1\"}', '1', '*');
INSERT INTO `wy587_modules` VALUES ('12', '46', 'Admin Menu', '', '', '1', 'menu', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_menu', '3', '1', '{\"layout\":\"\",\"moduleclass_sfx\":\"\",\"shownew\":\"1\",\"showhelp\":\"1\",\"cache\":\"0\"}', '1', '*');
INSERT INTO `wy587_modules` VALUES ('13', '47', 'Admin Submenu', '', '', '1', 'submenu', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_submenu', '3', '1', '', '1', '*');
INSERT INTO `wy587_modules` VALUES ('14', '48', 'User Status', '', '', '2', 'status', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_status', '3', '1', '', '1', '*');
INSERT INTO `wy587_modules` VALUES ('15', '49', 'Title', '', '', '1', 'title', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_title', '3', '1', '', '1', '*');
INSERT INTO `wy587_modules` VALUES ('16', '50', 'Login Form', '', '', '7', 'position-7', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_login', '1', '1', '{\"greeting\":\"1\",\"name\":\"0\"}', '0', '*');
INSERT INTO `wy587_modules` VALUES ('17', '51', 'Breadcrumbs', '', '', '1', 'position-2', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_breadcrumbs', '1', '1', '{\"moduleclass_sfx\":\"\",\"showHome\":\"1\",\"homeText\":\"\",\"showComponent\":\"1\",\"separator\":\"\",\"cache\":\"1\",\"cache_time\":\"900\",\"cachemode\":\"itemid\"}', '0', '*');
INSERT INTO `wy587_modules` VALUES ('79', '52', 'Multilanguage status', '', '', '1', 'status', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', 'mod_multilangstatus', '3', '1', '{\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}', '1', '*');
INSERT INTO `wy587_modules` VALUES ('86', '53', 'Joomla Version', '', '', '1', 'footer', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_version', '3', '1', '{\"format\":\"short\",\"product\":\"1\",\"layout\":\"_:default\",\"moduleclass_sfx\":\"\",\"cache\":\"0\"}', '1', '*');
INSERT INTO `wy587_modules` VALUES ('87', '56', 'VM - Administrator Module', '', '', '5', 'menu', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_vmmenu', '3', '1', '', '1', '*');
INSERT INTO `wy587_modules` VALUES ('88', '57', 'VM - Currencies Selector', '', '', '5', 'position-4', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_virtuemart_currencies', '1', '1', '', '0', '*');
INSERT INTO `wy587_modules` VALUES ('89', '58', 'VM - Featured products', '', '', '3', 'position-4', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_virtuemart_product', '1', '1', '', '0', '*');
INSERT INTO `wy587_modules` VALUES ('90', '59', 'VM - Search in Shop', '', '', '2', 'position-4', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_virtuemart_search', '1', '1', '', '0', '*');
INSERT INTO `wy587_modules` VALUES ('91', '60', 'VM - Manufacturer', '', '', '8', 'position-4', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_virtuemart_manufacturer', '1', '1', '', '0', '*');
INSERT INTO `wy587_modules` VALUES ('92', '61', 'VM - Shopping cart', '', '', '1', 'position-7', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_virtuemart_cart', '1', '1', '{\"moduleclass_sfx\":\"\",\"show_price\":\"1\",\"show_product_list\":\"1\",\"module_tag\":\"div\",\"bootstrap_size\":\"0\",\"header_tag\":\"h3\",\"header_class\":\"\",\"style\":\"0\"}', '0', '*');
INSERT INTO `wy587_modules` VALUES ('93', '62', 'VM - Category', '', '', '4', 'position-4', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '1', 'mod_virtuemart_category', '1', '1', '', '0', '*');

-- ----------------------------
-- Table structure for `wy587_modules_menu`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_modules_menu`;
CREATE TABLE `wy587_modules_menu` (
  `moduleid` int(11) NOT NULL DEFAULT '0',
  `menuid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`moduleid`,`menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_modules_menu
-- ----------------------------
INSERT INTO `wy587_modules_menu` VALUES ('1', '0');
INSERT INTO `wy587_modules_menu` VALUES ('2', '0');
INSERT INTO `wy587_modules_menu` VALUES ('3', '0');
INSERT INTO `wy587_modules_menu` VALUES ('4', '0');
INSERT INTO `wy587_modules_menu` VALUES ('6', '0');
INSERT INTO `wy587_modules_menu` VALUES ('7', '0');
INSERT INTO `wy587_modules_menu` VALUES ('8', '0');
INSERT INTO `wy587_modules_menu` VALUES ('9', '0');
INSERT INTO `wy587_modules_menu` VALUES ('10', '0');
INSERT INTO `wy587_modules_menu` VALUES ('12', '0');
INSERT INTO `wy587_modules_menu` VALUES ('13', '0');
INSERT INTO `wy587_modules_menu` VALUES ('14', '0');
INSERT INTO `wy587_modules_menu` VALUES ('15', '0');
INSERT INTO `wy587_modules_menu` VALUES ('16', '0');
INSERT INTO `wy587_modules_menu` VALUES ('17', '0');
INSERT INTO `wy587_modules_menu` VALUES ('79', '0');
INSERT INTO `wy587_modules_menu` VALUES ('86', '0');
INSERT INTO `wy587_modules_menu` VALUES ('87', '0');
INSERT INTO `wy587_modules_menu` VALUES ('88', '0');
INSERT INTO `wy587_modules_menu` VALUES ('89', '0');
INSERT INTO `wy587_modules_menu` VALUES ('90', '0');
INSERT INTO `wy587_modules_menu` VALUES ('91', '0');
INSERT INTO `wy587_modules_menu` VALUES ('92', '0');
INSERT INTO `wy587_modules_menu` VALUES ('93', '0');

-- ----------------------------
-- Table structure for `wy587_newsfeeds`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_newsfeeds`;
CREATE TABLE `wy587_newsfeeds` (
  `catid` int(11) NOT NULL DEFAULT '0',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `link` varchar(200) NOT NULL DEFAULT '',
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `numarticles` int(10) unsigned NOT NULL DEFAULT '1',
  `cache_time` int(10) unsigned NOT NULL DEFAULT '3600',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rtl` tinyint(4) NOT NULL DEFAULT '0',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `description` text NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `images` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`published`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_newsfeeds
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_overrider`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_overrider`;
CREATE TABLE `wy587_overrider` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `constant` varchar(255) NOT NULL,
  `string` text NOT NULL,
  `file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_overrider
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_postinstall_messages`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_postinstall_messages`;
CREATE TABLE `wy587_postinstall_messages` (
  `postinstall_message_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `extension_id` bigint(20) NOT NULL DEFAULT '700' COMMENT 'FK to #__extensions',
  `title_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'Lang key for the title',
  `description_key` varchar(255) NOT NULL DEFAULT '' COMMENT 'Lang key for description',
  `action_key` varchar(255) NOT NULL DEFAULT '',
  `language_extension` varchar(255) NOT NULL DEFAULT 'com_postinstall' COMMENT 'Extension holding lang keys',
  `language_client_id` tinyint(3) NOT NULL DEFAULT '1',
  `type` varchar(10) NOT NULL DEFAULT 'link' COMMENT 'Message type - message, link, action',
  `action_file` varchar(255) DEFAULT '' COMMENT 'RAD URI to the PHP file containing action method',
  `action` varchar(255) DEFAULT '' COMMENT 'Action method name or URL',
  `condition_file` varchar(255) DEFAULT NULL COMMENT 'RAD URI to file holding display condition method',
  `condition_method` varchar(255) DEFAULT NULL COMMENT 'Display condition method, must return boolean',
  `version_introduced` varchar(50) NOT NULL DEFAULT '3.2.0' COMMENT 'Version when this message was introduced',
  `enabled` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`postinstall_message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_postinstall_messages
-- ----------------------------
INSERT INTO `wy587_postinstall_messages` VALUES ('1', '700', 'PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_TITLE', 'PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_BODY', 'PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_ACTION', 'plg_twofactorauth_totp', '1', 'action', 'site://plugins/twofactorauth/totp/postinstall/actions.php', 'twofactorauth_postinstall_action', 'site://plugins/twofactorauth/totp/postinstall/actions.php', 'twofactorauth_postinstall_condition', '3.2.0', '0');
INSERT INTO `wy587_postinstall_messages` VALUES ('2', '700', 'COM_CPANEL_MSG_EACCELERATOR_TITLE', 'COM_CPANEL_MSG_EACCELERATOR_BODY', 'COM_CPANEL_MSG_EACCELERATOR_BUTTON', 'com_cpanel', '1', 'action', 'admin://components/com_admin/postinstall/eaccelerator.php', 'admin_postinstall_eaccelerator_action', 'admin://components/com_admin/postinstall/eaccelerator.php', 'admin_postinstall_eaccelerator_condition', '3.2.0', '1');
INSERT INTO `wy587_postinstall_messages` VALUES ('3', '700', 'COM_CPANEL_WELCOME_BEGINNERS_TITLE', 'COM_CPANEL_WELCOME_BEGINNERS_MESSAGE', '', 'com_cpanel', '1', 'message', '', '', '', '', '3.2.0', '0');
INSERT INTO `wy587_postinstall_messages` VALUES ('4', '700', 'COM_CPANEL_MSG_PHPVERSION_TITLE', 'COM_CPANEL_MSG_PHPVERSION_BODY', '', 'com_cpanel', '1', 'message', '', '', 'admin://components/com_admin/postinstall/phpversion.php', 'admin_postinstall_phpversion_condition', '3.2.2', '1');

-- ----------------------------
-- Table structure for `wy587_redirect_links`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_redirect_links`;
CREATE TABLE `wy587_redirect_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(255) NOT NULL,
  `new_url` varchar(255) NOT NULL,
  `referer` varchar(150) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(4) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_link_old` (`old_url`),
  KEY `idx_link_modifed` (`modified_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_redirect_links
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_schemas`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_schemas`;
CREATE TABLE `wy587_schemas` (
  `extension_id` int(11) NOT NULL,
  `version_id` varchar(20) NOT NULL,
  PRIMARY KEY (`extension_id`,`version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_schemas
-- ----------------------------
INSERT INTO `wy587_schemas` VALUES ('700', '3.3.6-2014-09-30');

-- ----------------------------
-- Table structure for `wy587_session`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_session`;
CREATE TABLE `wy587_session` (
  `session_id` varchar(200) NOT NULL DEFAULT '',
  `client_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `guest` tinyint(4) unsigned DEFAULT '1',
  `time` varchar(14) DEFAULT '',
  `data` mediumtext,
  `userid` int(11) DEFAULT '0',
  `username` varchar(150) DEFAULT '',
  PRIMARY KEY (`session_id`),
  KEY `userid` (`userid`),
  KEY `time` (`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_session
-- ----------------------------
INSERT INTO `wy587_session` VALUES ('ilfkpouh8f0p1p0bhn9nh8lt75', '0', '1', '1421080355', '__default|a:8:{s:15:\"session.counter\";i:7;s:19:\"session.timer.start\";i:1421075709;s:18:\"session.timer.last\";i:1421079510;s:17:\"session.timer.now\";i:1421080352;s:22:\"session.client.browser\";s:72:\"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0\";s:8:\"registry\";O:24:\"Joomla\\Registry\\Registry\":1:{s:7:\"\\0\\0\\0data\";O:8:\"stdClass\":0:{}}s:4:\"user\";O:5:\"JUser\":25:{s:9:\"\\0\\0\\0isRoot\";b:0;s:2:\"id\";i:0;s:4:\"name\";N;s:8:\"username\";N;s:5:\"email\";N;s:8:\"password\";N;s:14:\"password_clear\";s:0:\"\";s:5:\"block\";N;s:9:\"sendEmail\";i:0;s:12:\"registerDate\";N;s:13:\"lastvisitDate\";N;s:10:\"activation\";N;s:6:\"params\";N;s:6:\"groups\";a:1:{i:0;s:1:\"9\";}s:5:\"guest\";i:1;s:13:\"lastResetTime\";N;s:10:\"resetCount\";N;s:12:\"requireReset\";N;s:10:\"\\0\\0\\0_params\";O:24:\"Joomla\\Registry\\Registry\":1:{s:7:\"\\0\\0\\0data\";O:8:\"stdClass\":0:{}}s:14:\"\\0\\0\\0_authGroups\";a:2:{i:0;i:1;i:1;i:9;}s:14:\"\\0\\0\\0_authLevels\";a:3:{i:0;i:1;i:1;i:1;i:2;i:5;}s:15:\"\\0\\0\\0_authActions\";N;s:12:\"\\0\\0\\0_errorMsg\";N;s:10:\"\\0\\0\\0_errors\";a:0:{}s:3:\"aid\";i:0;}s:13:\"session.token\";s:32:\"319c8c7b1f54ee1508e84d16c46201be\";}', '0', '');
INSERT INTO `wy587_session` VALUES ('toi1vh34nipn79af8ea93s8527', '1', '0', '1421076398', '__default|a:8:{s:15:\"session.counter\";i:10;s:19:\"session.timer.start\";i:1421076013;s:18:\"session.timer.last\";i:1421076390;s:17:\"session.timer.now\";i:1421076397;s:22:\"session.client.browser\";s:72:\"Mozilla/5.0 (Windows NT 6.3; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0\";s:8:\"registry\";O:24:\"Joomla\\Registry\\Registry\":1:{s:7:\"\\0\\0\\0data\";O:8:\"stdClass\":3:{s:11:\"application\";O:8:\"stdClass\":1:{s:4:\"lang\";s:0:\"\";}s:13:\"com_installer\";O:8:\"stdClass\":2:{s:7:\"message\";s:0:\"\";s:17:\"extension_message\";s:0:\"\";}s:14:\"com_virtuemart\";O:8:\"stdClass\":2:{s:7:\"product\";O:8:\"stdClass\":1:{s:16:\"filter_order_Dir\";s:4:\"DESC\";}s:5:\"media\";O:8:\"stdClass\":1:{s:16:\"filter_order_Dir\";s:4:\"DESC\";}}}}s:4:\"user\";O:5:\"JUser\":27:{s:9:\"\\0\\0\\0isRoot\";b:1;s:2:\"id\";s:3:\"436\";s:4:\"name\";s:10:\"Super User\";s:8:\"username\";s:5:\"admin\";s:5:\"email\";s:19:\"fenix-10@rambler.ru\";s:8:\"password\";s:60:\"$2y$10$b9Dyr1TFeJWU1RuMI/L/C.3oYaWBxEJXMRsrdcYbx3jqLdVweT0vC\";s:14:\"password_clear\";s:0:\"\";s:5:\"block\";s:1:\"0\";s:9:\"sendEmail\";s:1:\"1\";s:12:\"registerDate\";s:19:\"2014-12-31 05:03:27\";s:13:\"lastvisitDate\";s:19:\"2014-12-31 05:15:43\";s:10:\"activation\";s:1:\"0\";s:6:\"params\";s:0:\"\";s:6:\"groups\";a:1:{i:8;s:1:\"8\";}s:5:\"guest\";i:0;s:13:\"lastResetTime\";s:19:\"0000-00-00 00:00:00\";s:10:\"resetCount\";s:1:\"0\";s:12:\"requireReset\";s:1:\"0\";s:10:\"\\0\\0\\0_params\";O:24:\"Joomla\\Registry\\Registry\":1:{s:7:\"\\0\\0\\0data\";O:8:\"stdClass\":0:{}}s:14:\"\\0\\0\\0_authGroups\";a:2:{i:0;i:1;i:1;i:8;}s:14:\"\\0\\0\\0_authLevels\";a:5:{i:0;i:1;i:1;i:1;i:2;i:2;i:3;i:3;i:4;i:6;}s:15:\"\\0\\0\\0_authActions\";N;s:12:\"\\0\\0\\0_errorMsg\";N;s:10:\"\\0\\0\\0_errors\";a:0:{}s:3:\"aid\";i:0;s:6:\"otpKey\";s:0:\"\";s:4:\"otep\";s:0:\"\";}s:13:\"session.token\";s:32:\"7e449d1f090a18afeee75b2ae25804fd\";}', '436', 'admin');

-- ----------------------------
-- Table structure for `wy587_tags`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_tags`;
CREATE TABLE `wy587_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lft` int(11) NOT NULL DEFAULT '0',
  `rgt` int(11) NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `note` varchar(255) NOT NULL DEFAULT '',
  `description` mediumtext NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access` int(10) unsigned NOT NULL DEFAULT '0',
  `params` text NOT NULL,
  `metadesc` varchar(1024) NOT NULL COMMENT 'The meta description for the page.',
  `metakey` varchar(1024) NOT NULL COMMENT 'The meta keywords for the page.',
  `metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `images` text NOT NULL,
  `urls` text NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `language` char(7) NOT NULL,
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tag_idx` (`published`,`access`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_path` (`path`),
  KEY `idx_left_right` (`lft`,`rgt`),
  KEY `idx_alias` (`alias`),
  KEY `idx_language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_tags
-- ----------------------------
INSERT INTO `wy587_tags` VALUES ('1', '0', '0', '1', '0', '', 'ROOT', 'root', '', '', '1', '0', '0000-00-00 00:00:00', '1', '', '', '', '', '0', '2011-01-01 00:00:01', '', '0', '0000-00-00 00:00:00', '', '', '0', '*', '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for `wy587_template_styles`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_template_styles`;
CREATE TABLE `wy587_template_styles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) NOT NULL DEFAULT '',
  `client_id` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `home` char(7) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template` (`template`),
  KEY `idx_home` (`home`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_template_styles
-- ----------------------------
INSERT INTO `wy587_template_styles` VALUES ('4', 'beez3', '0', '0', 'Beez3 - Default', '{\"wrapperSmall\":\"53\",\"wrapperLarge\":\"72\",\"logo\":\"images\\/joomla_black.gif\",\"sitetitle\":\"Joomla!\",\"sitedescription\":\"Open Source Content Management\",\"navposition\":\"left\",\"templatecolor\":\"personal\",\"html5\":\"0\"}');
INSERT INTO `wy587_template_styles` VALUES ('5', 'hathor', '1', '0', 'Hathor - Default', '{\"showSiteName\":\"0\",\"colourChoice\":\"\",\"boldText\":\"0\"}');
INSERT INTO `wy587_template_styles` VALUES ('7', 'protostar', '0', '1', 'protostar - Default', '{\"templateColor\":\"\",\"logoFile\":\"\",\"googleFont\":\"1\",\"googleFontName\":\"Open+Sans\",\"fluidContainer\":\"0\"}');
INSERT INTO `wy587_template_styles` VALUES ('8', 'isis', '1', '1', 'isis - Default', '{\"templateColor\":\"\",\"logoFile\":\"\"}');

-- ----------------------------
-- Table structure for `wy587_ucm_base`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_ucm_base`;
CREATE TABLE `wy587_ucm_base` (
  `ucm_id` int(10) unsigned NOT NULL,
  `ucm_item_id` int(10) NOT NULL,
  `ucm_type_id` int(11) NOT NULL,
  `ucm_language_id` int(11) NOT NULL,
  PRIMARY KEY (`ucm_id`),
  KEY `idx_ucm_item_id` (`ucm_item_id`),
  KEY `idx_ucm_type_id` (`ucm_type_id`),
  KEY `idx_ucm_language_id` (`ucm_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_ucm_base
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_ucm_content`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_ucm_content`;
CREATE TABLE `wy587_ucm_content` (
  `core_content_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `core_type_alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'FK to the content types table',
  `core_title` varchar(255) NOT NULL,
  `core_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `core_body` mediumtext NOT NULL,
  `core_state` tinyint(1) NOT NULL DEFAULT '0',
  `core_checked_out_time` varchar(255) NOT NULL DEFAULT '',
  `core_checked_out_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `core_access` int(10) unsigned NOT NULL DEFAULT '0',
  `core_params` text NOT NULL,
  `core_featured` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `core_metadata` varchar(2048) NOT NULL COMMENT 'JSON encoded metadata properties.',
  `core_created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `core_created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `core_created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `core_modified_user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Most recent user that modified',
  `core_modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `core_language` char(7) NOT NULL,
  `core_publish_up` datetime NOT NULL,
  `core_publish_down` datetime NOT NULL,
  `core_content_item_id` int(10) unsigned DEFAULT NULL COMMENT 'ID from the individual type table',
  `asset_id` int(10) unsigned DEFAULT NULL COMMENT 'FK to the #__assets table.',
  `core_images` text NOT NULL,
  `core_urls` text NOT NULL,
  `core_hits` int(10) unsigned NOT NULL DEFAULT '0',
  `core_version` int(10) unsigned NOT NULL DEFAULT '1',
  `core_ordering` int(11) NOT NULL DEFAULT '0',
  `core_metakey` text NOT NULL,
  `core_metadesc` text NOT NULL,
  `core_catid` int(10) unsigned NOT NULL DEFAULT '0',
  `core_xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `core_type_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`core_content_id`),
  KEY `tag_idx` (`core_state`,`core_access`),
  KEY `idx_access` (`core_access`),
  KEY `idx_alias` (`core_alias`),
  KEY `idx_language` (`core_language`),
  KEY `idx_title` (`core_title`),
  KEY `idx_modified_time` (`core_modified_time`),
  KEY `idx_created_time` (`core_created_time`),
  KEY `idx_content_type` (`core_type_alias`),
  KEY `idx_core_modified_user_id` (`core_modified_user_id`),
  KEY `idx_core_checked_out_user_id` (`core_checked_out_user_id`),
  KEY `idx_core_created_user_id` (`core_created_user_id`),
  KEY `idx_core_type_id` (`core_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains core content data in name spaced fields';

-- ----------------------------
-- Records of wy587_ucm_content
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_ucm_history`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_ucm_history`;
CREATE TABLE `wy587_ucm_history` (
  `version_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ucm_item_id` int(10) unsigned NOT NULL,
  `ucm_type_id` int(10) unsigned NOT NULL,
  `version_note` varchar(255) NOT NULL DEFAULT '' COMMENT 'Optional version name',
  `save_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `editor_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `character_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of characters in this version.',
  `sha1_hash` varchar(50) NOT NULL DEFAULT '' COMMENT 'SHA1 hash of the version_data column.',
  `version_data` mediumtext NOT NULL COMMENT 'json-encoded string of version data',
  `keep_forever` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=auto delete; 1=keep',
  PRIMARY KEY (`version_id`),
  KEY `idx_ucm_item_id` (`ucm_type_id`,`ucm_item_id`),
  KEY `idx_save_date` (`save_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_ucm_history
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_updates`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_updates`;
CREATE TABLE `wy587_updates` (
  `update_id` int(11) NOT NULL AUTO_INCREMENT,
  `update_site_id` int(11) DEFAULT '0',
  `extension_id` int(11) DEFAULT '0',
  `name` varchar(100) DEFAULT '',
  `description` text NOT NULL,
  `element` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `folder` varchar(20) DEFAULT '',
  `client_id` tinyint(3) DEFAULT '0',
  `version` varchar(32) DEFAULT '',
  `data` text NOT NULL,
  `detailsurl` text NOT NULL,
  `infourl` text NOT NULL,
  `extra_query` varchar(1000) DEFAULT '',
  PRIMARY KEY (`update_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='Available Updates';

-- ----------------------------
-- Records of wy587_updates
-- ----------------------------
INSERT INTO `wy587_updates` VALUES ('1', '3', '0', 'Malay', '', 'pkg_ms-MY', 'package', '', '0', '3.3.1.1', '', 'http://update.joomla.org/language/details3/ms-MY_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('2', '3', '0', 'Romanian', '', 'pkg_ro-RO', 'package', '', '0', '3.3.3.1', '', 'http://update.joomla.org/language/details3/ro-RO_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('3', '3', '0', 'Flemish', '', 'pkg_nl-BE', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/nl-BE_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('4', '3', '0', 'Chinese Traditional', '', 'pkg_zh-TW', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/zh-TW_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('5', '3', '0', 'French', '', 'pkg_fr-FR', 'package', '', '0', '3.3.6.2', '', 'http://update.joomla.org/language/details3/fr-FR_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('6', '3', '0', 'Galician', '', 'pkg_gl-ES', 'package', '', '0', '3.3.1.2', '', 'http://update.joomla.org/language/details3/gl-ES_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('7', '3', '0', 'German', '', 'pkg_de-DE', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/de-DE_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('8', '3', '0', 'Greek', '', 'pkg_el-GR', 'package', '', '0', '3.3.3.1', '', 'http://update.joomla.org/language/details3/el-GR_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('9', '3', '0', 'Japanese', '', 'pkg_ja-JP', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/ja-JP_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('10', '3', '0', 'Hebrew', '', 'pkg_he-IL', 'package', '', '0', '3.1.1.1', '', 'http://update.joomla.org/language/details3/he-IL_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('11', '3', '0', 'EnglishAU', '', 'pkg_en-AU', 'package', '', '0', '3.3.1.1', '', 'http://update.joomla.org/language/details3/en-AU_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('12', '3', '0', 'EnglishUS', '', 'pkg_en-US', 'package', '', '0', '3.3.1.1', '', 'http://update.joomla.org/language/details3/en-US_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('13', '3', '0', 'Hungarian', '', 'pkg_hu-HU', 'package', '', '0', '3.3.3.1', '', 'http://update.joomla.org/language/details3/hu-HU_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('14', '3', '0', 'Afrikaans', '', 'pkg_af-ZA', 'package', '', '0', '3.2.0.2', '', 'http://update.joomla.org/language/details3/af-ZA_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('15', '3', '0', 'Arabic Unitag', '', 'pkg_ar-AA', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/ar-AA_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('16', '3', '0', 'Belarusian', '', 'pkg_be-BY', 'package', '', '0', '3.2.1.1', '', 'http://update.joomla.org/language/details3/be-BY_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('17', '3', '0', 'Bulgarian', '', 'pkg_bg-BG', 'package', '', '0', '3.3.0.1', '', 'http://update.joomla.org/language/details3/bg-BG_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('18', '3', '0', 'Catalan', '', 'pkg_ca-ES', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/ca-ES_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('19', '3', '0', 'Chinese Simplified', '', 'pkg_zh-CN', 'package', '', '0', '3.3.1.1', '', 'http://update.joomla.org/language/details3/zh-CN_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('20', '3', '0', 'Croatian', '', 'pkg_hr-HR', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/hr-HR_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('21', '3', '0', 'Czech', '', 'pkg_cs-CZ', 'package', '', '0', '3.3.6.2', '', 'http://update.joomla.org/language/details3/cs-CZ_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('22', '3', '0', 'Danish', '', 'pkg_da-DK', 'package', '', '0', '3.3.6.3', '', 'http://update.joomla.org/language/details3/da-DK_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('23', '3', '0', 'Dutch', '', 'pkg_nl-NL', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/nl-NL_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('24', '3', '0', 'Estonian', '', 'pkg_et-EE', 'package', '', '0', '3.3.4.1', '', 'http://update.joomla.org/language/details3/et-EE_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('25', '3', '0', 'Italian', '', 'pkg_it-IT', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/it-IT_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('26', '3', '0', 'Korean', '', 'pkg_ko-KR', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/ko-KR_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('27', '3', '0', 'Latvian', '', 'pkg_lv-LV', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/lv-LV_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('28', '3', '0', 'Macedonian', '', 'pkg_mk-MK', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/mk-MK_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('29', '3', '0', 'Norwegian Bokmal', '', 'pkg_nb-NO', 'package', '', '0', '3.2.2.1', '', 'http://update.joomla.org/language/details3/nb-NO_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('30', '3', '0', 'Persian', '', 'pkg_fa-IR', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/fa-IR_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('31', '3', '0', 'Polish', '', 'pkg_pl-PL', 'package', '', '0', '3.3.4.1', '', 'http://update.joomla.org/language/details3/pl-PL_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('32', '3', '0', 'Portuguese', '', 'pkg_pt-PT', 'package', '', '0', '3.3.3.1', '', 'http://update.joomla.org/language/details3/pt-PT_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('33', '3', '0', 'Slovak', '', 'pkg_sk-SK', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/sk-SK_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('34', '3', '0', 'Swedish', '', 'pkg_sv-SE', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/sv-SE_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('35', '3', '0', 'Syriac', '', 'pkg_sy-IQ', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/sy-IQ_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('36', '3', '0', 'Tamil', '', 'pkg_ta-IN', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/ta-IN_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('37', '3', '0', 'Thai', '', 'pkg_th-TH', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/th-TH_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('38', '3', '0', 'Turkish', '', 'pkg_tr-TR', 'package', '', '0', '3.3.5.1', '', 'http://update.joomla.org/language/details3/tr-TR_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('39', '3', '0', 'Ukrainian', '', 'pkg_uk-UA', 'package', '', '0', '3.3.3.15', '', 'http://update.joomla.org/language/details3/uk-UA_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('40', '3', '0', 'Uyghur', '', 'pkg_ug-CN', 'package', '', '0', '3.3.0.1', '', 'http://update.joomla.org/language/details3/ug-CN_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('41', '3', '0', 'Albanian', '', 'pkg_sq-AL', 'package', '', '0', '3.1.1.1', '', 'http://update.joomla.org/language/details3/sq-AL_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('42', '3', '0', 'Portuguese Brazil', '', 'pkg_pt-BR', 'package', '', '0', '3.0.2.1', '', 'http://update.joomla.org/language/details3/pt-BR_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('43', '3', '0', 'Serbian Latin', '', 'pkg_sr-YU', 'package', '', '0', '3.3.4.1', '', 'http://update.joomla.org/language/details3/sr-YU_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('44', '3', '0', 'Spanish', '', 'pkg_es-ES', 'package', '', '0', '3.3.4.1', '', 'http://update.joomla.org/language/details3/es-ES_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('45', '3', '0', 'Bosnian', '', 'pkg_bs-BA', 'package', '', '0', '3.3.3.1', '', 'http://update.joomla.org/language/details3/bs-BA_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('46', '3', '0', 'Serbian Cyrillic', '', 'pkg_sr-RS', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/sr-RS_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('47', '3', '0', 'Vietnamese', '', 'pkg_vi-VN', 'package', '', '0', '3.2.1.1', '', 'http://update.joomla.org/language/details3/vi-VN_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('48', '3', '0', 'Bahasa Indonesia', '', 'pkg_id-ID', 'package', '', '0', '3.3.0.2', '', 'http://update.joomla.org/language/details3/id-ID_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('49', '3', '0', 'Finnish', '', 'pkg_fi-FI', 'package', '', '0', '3.3.4.1', '', 'http://update.joomla.org/language/details3/fi-FI_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('50', '3', '0', 'Swahili', '', 'pkg_sw-KE', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/sw-KE_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('51', '3', '0', 'Montenegrin', '', 'pkg_srp-ME', 'package', '', '0', '3.3.1.1', '', 'http://update.joomla.org/language/details3/srp-ME_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('52', '3', '0', 'EnglishCA', '', 'pkg_en-CA', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/en-CA_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('53', '3', '0', 'FrenchCA', '', 'pkg_fr-CA', 'package', '', '0', '3.3.6.1', '', 'http://update.joomla.org/language/details3/fr-CA_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('54', '3', '0', 'Welsh', '', 'pkg_cy-GB', 'package', '', '0', '3.3.0.1', '', 'http://update.joomla.org/language/details3/cy-GB_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('55', '3', '0', 'Sinhala', '', 'pkg_si-LK', 'package', '', '0', '3.3.1.1', '', 'http://update.joomla.org/language/details3/si-LK_details.xml', '', '');
INSERT INTO `wy587_updates` VALUES ('56', '5', '10003', 'VirtueMart', 'VirtueMart Component', 'com_virtuemart', 'component', '', '1', '3.0.2', '', 'http://virtuemart.net/releases/vm3/virtuemart_update.xml', 'http://virtuemart.net/news/latest-news/466-klik-pay-is-included-in-virtuemart-2-6-14-and-virtuemart-3-0-2', '');
INSERT INTO `wy587_updates` VALUES ('57', '30', '10004', 'VirtueMart AIO', 'VirtueMart AIO Component', 'com_virtuemart_allinone', 'component', '', '1', '3.0.2', '', 'http://virtuemart.net/releases/vm3/virtuemart_aio_update.xml', 'http://virtuemart.net/news/latest-news/466-klik-pay-is-included-in-virtuemart-2-6-14-and-virtuemart-3-0-2', '');

-- ----------------------------
-- Table structure for `wy587_update_sites`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_update_sites`;
CREATE TABLE `wy587_update_sites` (
  `update_site_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `location` text NOT NULL,
  `enabled` int(11) DEFAULT '0',
  `last_check_timestamp` bigint(20) DEFAULT '0',
  `extra_query` varchar(1000) DEFAULT '',
  PRIMARY KEY (`update_site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Update Sites';

-- ----------------------------
-- Records of wy587_update_sites
-- ----------------------------
INSERT INTO `wy587_update_sites` VALUES ('1', 'Joomla! Core', 'collection', 'http://update.joomla.org/core/list.xml', '1', '1421076039', '');
INSERT INTO `wy587_update_sites` VALUES ('2', 'Joomla! Extension Directory', 'collection', 'http://update.joomla.org/jed/list.xml', '1', '1421076039', '');
INSERT INTO `wy587_update_sites` VALUES ('3', 'Accredited Joomla! Translations', 'collection', 'http://update.joomla.org/language/translationlist_3.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('4', 'Joomla! Update Component Update Site', 'extension', 'http://update.joomla.org/core/extensions/com_joomlaupdate.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('5', 'VirtueMart3 Update Site', 'extension', 'http://virtuemart.net/releases/vm3/virtuemart_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('6', 'VirtueMart plg_vmpayment_standard Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_standard_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('7', 'VirtueMart plg_vmpayment_klarna Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_klarna_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('8', 'VirtueMart plg_vmpayment_klarnacheckout Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_klarnacheckout_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('9', 'VirtueMart plg_vmpayment_sofort Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_sofort_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('10', 'VirtueMart plg_vmpayment_paypal Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_paypal_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('11', 'VirtueMart plg_vmpayment_heidelpay Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_heidelpay_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('12', 'VirtueMart plg_vmpayment_paybox Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_paybox_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('13', 'VirtueMart plg_vmpayment_realex_hpp_api Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_realex_hpp_api_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('14', 'VirtueMart plg_vmuserfield_realex_hpp_api Update Site', 'extension', '\n            http://virtuemart.net/releases/vm3/plg_vmuserfield_realex_hpp_api_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('15', 'VirtueMart3 plg_vmpayment_skrill Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_skrill_update.xml', '0', '0', '');
INSERT INTO `wy587_update_sites` VALUES ('16', 'VirtueMart plg_vmpayment_authorizenet Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_authorisenet_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('17', 'VirtueMart plg_vmpayment_sofort_ideal Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmpayment_sofort_ideal_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('18', 'VirtueMart3 plg_vmshipment_weight_countries Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmshipment_weight_countries_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('19', 'VirtueMart3 plg_vmcustom_textinput Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmcustom_textinput_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('20', 'VirtueMart3 plg_vmcustom_specification Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmcustom_specification_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('21', 'VirtueMart3 plg_vmcalculation_avalara Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_vmcalculation_avalara_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('22', 'VirtueMart3 plg_search_virtuemart Update Site', 'extension', 'http://virtuemart.net/releases/vm3/plg_search_virtuemart_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('23', 'VirtueMart3 MOD_VMENU Update Site', 'extension', 'http://virtuemart.net/releases/vm3/mod_vmmenu_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('24', 'VirtueMart3 mod_virtuemart_currencies Update Site', 'extension', 'http://virtuemart.net/releases/vm3/mod_virtuemart_currencies_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('25', 'VirtueMart3 mod_virtuemart_product Update Site', 'extension', 'http://virtuemart.net/releases/vm3/mod_virtuemart_product_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('26', 'VirtueMart3 mod_virtuemart_search Update Site', 'extension', 'http://virtuemart.net/releases/vm3/mod_virtuemart_search_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('27', 'VirtueMart3 mod_virtuemart_manufacturer Update Site', 'extension', 'http://virtuemart.net/releases/vm3/mod_virtuemart_manufacturer_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('28', 'VirtueMart3 mod_virtuemart_cart Update Site', 'extension', 'http://virtuemart.net/releases/vm3/mod_virtuemart_cart_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('29', 'VirtueMart3 mod_virtuemart_category Update Site', 'extension', 'http://virtuemart.net/releases/vm3/mod_virtuemart_category_update.xml', '1', '1421076038', '');
INSERT INTO `wy587_update_sites` VALUES ('30', 'VirtueMart3 AIO Update Site', 'extension', 'http://virtuemart.net/releases/vm3/virtuemart_aio_update.xml', '1', '1421076038', '');

-- ----------------------------
-- Table structure for `wy587_update_sites_extensions`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_update_sites_extensions`;
CREATE TABLE `wy587_update_sites_extensions` (
  `update_site_id` int(11) NOT NULL DEFAULT '0',
  `extension_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`update_site_id`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Links extensions to update sites';

-- ----------------------------
-- Records of wy587_update_sites_extensions
-- ----------------------------
INSERT INTO `wy587_update_sites_extensions` VALUES ('1', '700');
INSERT INTO `wy587_update_sites_extensions` VALUES ('2', '700');
INSERT INTO `wy587_update_sites_extensions` VALUES ('3', '600');
INSERT INTO `wy587_update_sites_extensions` VALUES ('3', '10002');
INSERT INTO `wy587_update_sites_extensions` VALUES ('4', '28');
INSERT INTO `wy587_update_sites_extensions` VALUES ('5', '10003');
INSERT INTO `wy587_update_sites_extensions` VALUES ('6', '10005');
INSERT INTO `wy587_update_sites_extensions` VALUES ('7', '10006');
INSERT INTO `wy587_update_sites_extensions` VALUES ('8', '10007');
INSERT INTO `wy587_update_sites_extensions` VALUES ('9', '10008');
INSERT INTO `wy587_update_sites_extensions` VALUES ('10', '10009');
INSERT INTO `wy587_update_sites_extensions` VALUES ('11', '10010');
INSERT INTO `wy587_update_sites_extensions` VALUES ('12', '10011');
INSERT INTO `wy587_update_sites_extensions` VALUES ('13', '10012');
INSERT INTO `wy587_update_sites_extensions` VALUES ('14', '10013');
INSERT INTO `wy587_update_sites_extensions` VALUES ('15', '10014');
INSERT INTO `wy587_update_sites_extensions` VALUES ('16', '10015');
INSERT INTO `wy587_update_sites_extensions` VALUES ('17', '10016');
INSERT INTO `wy587_update_sites_extensions` VALUES ('18', '10017');
INSERT INTO `wy587_update_sites_extensions` VALUES ('19', '10018');
INSERT INTO `wy587_update_sites_extensions` VALUES ('20', '10019');
INSERT INTO `wy587_update_sites_extensions` VALUES ('21', '10020');
INSERT INTO `wy587_update_sites_extensions` VALUES ('22', '10021');
INSERT INTO `wy587_update_sites_extensions` VALUES ('23', '10022');
INSERT INTO `wy587_update_sites_extensions` VALUES ('24', '10023');
INSERT INTO `wy587_update_sites_extensions` VALUES ('25', '10024');
INSERT INTO `wy587_update_sites_extensions` VALUES ('26', '10025');
INSERT INTO `wy587_update_sites_extensions` VALUES ('27', '10026');
INSERT INTO `wy587_update_sites_extensions` VALUES ('28', '10027');
INSERT INTO `wy587_update_sites_extensions` VALUES ('29', '10028');
INSERT INTO `wy587_update_sites_extensions` VALUES ('30', '10004');

-- ----------------------------
-- Table structure for `wy587_usergroups`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_usergroups`;
CREATE TABLE `wy587_usergroups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Adjacency List Reference Id',
  `lft` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set lft.',
  `rgt` int(11) NOT NULL DEFAULT '0' COMMENT 'Nested set rgt.',
  `title` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_usergroup_parent_title_lookup` (`parent_id`,`title`),
  KEY `idx_usergroup_title_lookup` (`title`),
  KEY `idx_usergroup_adjacency_lookup` (`parent_id`),
  KEY `idx_usergroup_nested_set_lookup` (`lft`,`rgt`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_usergroups
-- ----------------------------
INSERT INTO `wy587_usergroups` VALUES ('1', '0', '1', '18', 'Public');
INSERT INTO `wy587_usergroups` VALUES ('2', '1', '8', '15', 'Registered');
INSERT INTO `wy587_usergroups` VALUES ('3', '2', '9', '14', 'Author');
INSERT INTO `wy587_usergroups` VALUES ('4', '3', '10', '13', 'Editor');
INSERT INTO `wy587_usergroups` VALUES ('5', '4', '11', '12', 'Publisher');
INSERT INTO `wy587_usergroups` VALUES ('6', '1', '4', '7', 'Manager');
INSERT INTO `wy587_usergroups` VALUES ('7', '6', '5', '6', 'Administrator');
INSERT INTO `wy587_usergroups` VALUES ('8', '1', '16', '17', 'Super Users');
INSERT INTO `wy587_usergroups` VALUES ('9', '1', '2', '3', 'Guest');

-- ----------------------------
-- Table structure for `wy587_users`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_users`;
CREATE TABLE `wy587_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(150) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `block` tinyint(4) NOT NULL DEFAULT '0',
  `sendEmail` tinyint(4) DEFAULT '0',
  `registerDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastvisitDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activation` varchar(100) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `lastResetTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Date of last password reset',
  `resetCount` int(11) NOT NULL DEFAULT '0' COMMENT 'Count of password resets since lastResetTime',
  `otpKey` varchar(1000) NOT NULL DEFAULT '' COMMENT 'Two factor authentication encrypted keys',
  `otep` varchar(1000) NOT NULL DEFAULT '' COMMENT 'One time emergency passwords',
  `requireReset` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Require user to reset password on next login',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`),
  KEY `idx_block` (`block`),
  KEY `username` (`username`),
  KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_users
-- ----------------------------
INSERT INTO `wy587_users` VALUES ('436', 'Super User', 'admin', 'fenix-10@rambler.ru', '$2y$10$b9Dyr1TFeJWU1RuMI/L/C.3oYaWBxEJXMRsrdcYbx3jqLdVweT0vC', '0', '1', '2014-12-31 05:03:27', '2015-01-12 15:20:33', '0', '', '0000-00-00 00:00:00', '0', '', '', '0');

-- ----------------------------
-- Table structure for `wy587_user_keys`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_user_keys`;
CREATE TABLE `wy587_user_keys` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `series` varchar(255) NOT NULL,
  `invalid` tinyint(4) NOT NULL,
  `time` varchar(200) NOT NULL,
  `uastring` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `series` (`series`),
  UNIQUE KEY `series_2` (`series`),
  UNIQUE KEY `series_3` (`series`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_user_keys
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_user_notes`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_user_notes`;
CREATE TABLE `wy587_user_notes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `catid` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `state` tinyint(3) NOT NULL DEFAULT '0',
  `checked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `created_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_user_id` int(10) unsigned NOT NULL,
  `modified_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `review_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_category_id` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_user_notes
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_user_profiles`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_user_profiles`;
CREATE TABLE `wy587_user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) NOT NULL,
  `profile_value` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Simple user profile storage table';

-- ----------------------------
-- Records of wy587_user_profiles
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_user_usergroup_map`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_user_usergroup_map`;
CREATE TABLE `wy587_user_usergroup_map` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_user_usergroup_map
-- ----------------------------
INSERT INTO `wy587_user_usergroup_map` VALUES ('436', '8');

-- ----------------------------
-- Table structure for `wy587_viewlevels`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_viewlevels`;
CREATE TABLE `wy587_viewlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `title` varchar(100) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_viewlevels
-- ----------------------------
INSERT INTO `wy587_viewlevels` VALUES ('1', 'Public', '0', '[1]');
INSERT INTO `wy587_viewlevels` VALUES ('2', 'Registered', '1', '[6,2,8]');
INSERT INTO `wy587_viewlevels` VALUES ('3', 'Special', '2', '[6,3,8]');
INSERT INTO `wy587_viewlevels` VALUES ('5', 'Guest', '0', '[9]');
INSERT INTO `wy587_viewlevels` VALUES ('6', 'Super Users', '0', '[8]');

-- ----------------------------
-- Table structure for `wy587_virtuemart_adminmenuentries`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_adminmenuentries`;
CREATE TABLE `wy587_virtuemart_adminmenuentries` (
  `id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` tinyint(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ID of the VM Module, this Item is assigned to',
  `parent_id` tinyint(11) unsigned NOT NULL DEFAULT '0',
  `name` char(64) NOT NULL DEFAULT '0',
  `link` char(64) NOT NULL DEFAULT '0',
  `depends` char(64) NOT NULL DEFAULT '' COMMENT 'Names of the Parameters, this Item depends on',
  `icon_class` char(96) DEFAULT NULL,
  `ordering` int(2) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `tooltip` char(128) DEFAULT NULL,
  `view` char(32) DEFAULT NULL,
  `task` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module_id` (`module_id`),
  KEY `published` (`published`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='Administration Menu Items';

-- ----------------------------
-- Records of wy587_virtuemart_adminmenuentries
-- ----------------------------
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('1', '1', '0', 'COM_VIRTUEMART_CATEGORY_S', '', '', 'vmicon vmicon-16-folder_camera', '1', '1', '', 'category', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('2', '1', '0', 'COM_VIRTUEMART_PRODUCT_S', '', '', 'vmicon vmicon-16-camera', '2', '1', '', 'product', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('3', '1', '0', 'COM_VIRTUEMART_PRODUCT_CUSTOM_FIELD_S', '', '', 'vmicon vmicon-16-document_move', '5', '1', '', 'custom', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('4', '1', '0', 'COM_VIRTUEMART_PRODUCT_INVENTORY', '', '', 'vmicon vmicon-16-price_watch', '7', '1', '', 'inventory', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('5', '1', '0', 'COM_VIRTUEMART_CALC_S', '', '', 'vmicon vmicon-16-calculator', '8', '1', '', 'calc', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('6', '1', '0', 'COM_VIRTUEMART_REVIEW_RATE_S', '', '', 'vmicon vmicon-16-comments', '9', '1', '', 'ratings', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('7', '2', '0', 'COM_VIRTUEMART_ORDER_S', '', '', 'vmicon vmicon-16-page_white_stack', '1', '1', '', 'orders', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('8', '2', '0', 'COM_VIRTUEMART_COUPON_S', '', '', 'vmicon vmicon-16-shopping', '10', '1', '', 'coupon', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('9', '2', '0', 'COM_VIRTUEMART_REPORT', '', '', 'vmicon vmicon-16-chart_bar', '3', '1', '', 'report', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('10', '2', '0', 'COM_VIRTUEMART_USER_S', '', '', 'vmicon vmicon-16-user', '4', '1', '', 'user', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('11', '2', '0', 'COM_VIRTUEMART_SHOPPERGROUP_S', '', '', 'vmicon vmicon-16-user-group', '5', '1', '', 'shoppergroup', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('12', '3', '0', 'COM_VIRTUEMART_MANUFACTURER_S', '', '', 'vmicon vmicon-16-wrench_orange', '1', '1', '', 'manufacturer', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('13', '3', '0', 'COM_VIRTUEMART_MANUFACTURER_CATEGORY_S', '', '', 'vmicon vmicon-16-folder_wrench', '2', '1', '', 'manufacturercategories', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('14', '4', '0', 'COM_VIRTUEMART_STORE', '', '', 'vmicon vmicon-16-reseller_account_template', '1', '1', '', 'user', 'editshop');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('15', '4', '0', 'COM_VIRTUEMART_MEDIA_S', '', '', 'vmicon vmicon-16-pictures', '2', '1', '', 'media', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('16', '4', '0', 'COM_VIRTUEMART_SHIPMENTMETHOD_S', '', '', 'vmicon vmicon-16-lorry', '3', '1', '', 'shipmentmethod', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('17', '4', '0', 'COM_VIRTUEMART_PAYMENTMETHOD_S', '', '', 'vmicon vmicon-16-creditcards', '4', '1', '', 'paymentmethod', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('18', '5', '0', 'COM_VIRTUEMART_CONFIGURATION', '', '', 'vmicon vmicon-16-config', '1', '1', '', 'config', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('19', '5', '0', 'COM_VIRTUEMART_USERFIELD_S', '', '', 'vmicon vmicon-16-participation_rate', '2', '1', '', 'userfields', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('20', '5', '0', 'COM_VIRTUEMART_ORDERSTATUS_S', '', '', 'vmicon vmicon-16-document_editing', '3', '1', '', 'orderstatus', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('21', '5', '0', 'COM_VIRTUEMART_CURRENCY_S', '', '', 'vmicon vmicon-16-coins', '5', '1', '', 'currency', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('22', '5', '0', 'COM_VIRTUEMART_COUNTRY_S', '', '', 'vmicon vmicon-16-globe', '6', '1', '', 'country', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('23', '11', '0', 'COM_VIRTUEMART_MIGRATION_UPDATE', '', '', 'vmicon vmicon-16-installer_box', '0', '1', '', 'updatesmigration', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('24', '11', '0', 'COM_VIRTUEMART_ABOUT', '', '', 'vmicon vmicon-16-info', '10', '1', '', 'about', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('25', '11', '0', 'COM_VIRTUEMART_HELP_TOPICS', 'http://docs.virtuemart.net/', '', 'vmicon vmicon-16-help', '5', '1', '', '', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('26', '11', '0', 'COM_VIRTUEMART_COMMUNITY_FORUM', 'http://forum.virtuemart.net/', '', 'vmicon vmicon-16-reseller_programm', '7', '1', '', '', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('27', '11', '0', 'COM_VIRTUEMART_STATISTIC_SUMMARY', '', '', 'vmicon vmicon-16-info', '1', '1', '', 'virtuemart', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('28', '11', '0', 'COM_VIRTUEMART_LOG', '', '', 'vmicon vmicon-16-info', '2', '1', '', 'log', '');
INSERT INTO `wy587_virtuemart_adminmenuentries` VALUES ('29', '11', '0', 'COM_VIRTUEMART_SUPPORT', '', '', 'vmicon vmicon-16-help', '3', '1', '', 'support', '');

-- ----------------------------
-- Table structure for `wy587_virtuemart_calcs`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_calcs`;
CREATE TABLE `wy587_virtuemart_calcs` (
  `virtuemart_calc_id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Belongs to vendor',
  `calc_jplugin_id` int(11) NOT NULL DEFAULT '0',
  `calc_name` char(64) NOT NULL DEFAULT '' COMMENT 'Name of the rule',
  `calc_descr` char(128) NOT NULL DEFAULT '' COMMENT 'Description',
  `calc_kind` char(16) NOT NULL DEFAULT '' COMMENT 'Discount/Tax/Margin/Commission',
  `calc_value_mathop` char(8) NOT NULL DEFAULT '' COMMENT 'the mathematical operation like (+,-,+%,-%)',
  `calc_value` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'The Amount',
  `calc_currency` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Currency of the Rule',
  `calc_shopper_published` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Visible for Shoppers',
  `calc_vendor_published` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Visible for Vendors',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Startdate if nothing is set = permanent',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Enddate if nothing is set = permanent',
  `for_override` tinyint(1) NOT NULL DEFAULT '0',
  `calc_params` varchar(18000) NOT NULL DEFAULT '',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_calc_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `published` (`published`),
  KEY `calc_kind` (`calc_kind`),
  KEY `shared` (`shared`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_calcs
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_calc_categories`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_calc_categories`;
CREATE TABLE `wy587_virtuemart_calc_categories` (
  `id` mediumint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_calc_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_category_id` mediumint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_calc_id` (`virtuemart_calc_id`,`virtuemart_category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_calc_categories
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_calc_countries`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_calc_countries`;
CREATE TABLE `wy587_virtuemart_calc_countries` (
  `id` mediumint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_calc_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_country_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_calc_id` (`virtuemart_calc_id`,`virtuemart_country_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_calc_countries
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_calc_manufacturers`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_calc_manufacturers`;
CREATE TABLE `wy587_virtuemart_calc_manufacturers` (
  `id` mediumint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_calc_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_manufacturer_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_calc_id` (`virtuemart_calc_id`,`virtuemart_manufacturer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_calc_manufacturers
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_calc_shoppergroups`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_calc_shoppergroups`;
CREATE TABLE `wy587_virtuemart_calc_shoppergroups` (
  `id` mediumint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_calc_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_shoppergroup_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_calc_id` (`virtuemart_calc_id`,`virtuemart_shoppergroup_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_calc_shoppergroups
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_calc_states`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_calc_states`;
CREATE TABLE `wy587_virtuemart_calc_states` (
  `id` mediumint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_calc_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_state_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_calc_id` (`virtuemart_calc_id`,`virtuemart_state_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_calc_states
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_carts`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_carts`;
CREATE TABLE `wy587_virtuemart_carts` (
  `virtuemart_cart_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_user_id` int(11) unsigned NOT NULL,
  `virtuemart_vendor_id` int(11) unsigned NOT NULL,
  `cartData` varbinary(50000) DEFAULT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_cart_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `virtuemart_user_id` (`virtuemart_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Used to store the cart';

-- ----------------------------
-- Records of wy587_virtuemart_carts
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_categories`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_categories`;
CREATE TABLE `wy587_virtuemart_categories` (
  `virtuemart_category_id` mediumint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Belongs to vendor',
  `category_template` char(128) DEFAULT NULL,
  `category_layout` char(64) DEFAULT NULL,
  `category_product_layout` char(64) DEFAULT NULL,
  `products_per_row` tinyint(2) DEFAULT NULL,
  `limit_list_step` char(32) DEFAULT NULL,
  `limit_list_initial` smallint(1) unsigned DEFAULT NULL,
  `hits` int(1) unsigned NOT NULL DEFAULT '0',
  `metarobot` char(40) NOT NULL DEFAULT '',
  `metaauthor` char(64) NOT NULL DEFAULT '',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_category_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `published` (`published`),
  KEY `shared` (`shared`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Product Categories are stored here';

-- ----------------------------
-- Records of wy587_virtuemart_categories
-- ----------------------------
INSERT INTO `wy587_virtuemart_categories` VALUES ('1', '1', '0', '0', '0', '0', '0', '0', '0', '', '', '0', '0', '1', '2014-12-31 05:37:59', '436', '2014-12-31 05:37:59', '436', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_categories_ru_ru`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_categories_ru_ru`;
CREATE TABLE `wy587_virtuemart_categories_ru_ru` (
  `virtuemart_category_id` int(1) unsigned NOT NULL,
  `category_name` char(180) NOT NULL DEFAULT '',
  `category_description` varchar(19000) NOT NULL DEFAULT '',
  `metadesc` varchar(400) NOT NULL DEFAULT '',
  `metakey` varchar(400) NOT NULL DEFAULT '',
  `customtitle` char(255) NOT NULL DEFAULT '',
  `slug` char(192) NOT NULL DEFAULT '',
  PRIMARY KEY (`virtuemart_category_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_categories_ru_ru
-- ----------------------------
INSERT INTO `wy587_virtuemart_categories_ru_ru` VALUES ('1', 'телефоны', '', '', '', '', 'телефоны');

-- ----------------------------
-- Table structure for `wy587_virtuemart_category_categories`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_category_categories`;
CREATE TABLE `wy587_virtuemart_category_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_parent_id` int(1) unsigned NOT NULL DEFAULT '0',
  `category_child_id` int(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_parent_id` (`category_parent_id`,`category_child_id`),
  KEY `category_child_id` (`category_child_id`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Category child-parent relation list';

-- ----------------------------
-- Records of wy587_virtuemart_category_categories
-- ----------------------------
INSERT INTO `wy587_virtuemart_category_categories` VALUES ('1', '0', '1', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_category_medias`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_category_medias`;
CREATE TABLE `wy587_virtuemart_category_medias` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_category_id` mediumint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_media_id` int(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_category_id` (`virtuemart_category_id`,`virtuemart_media_id`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_category_medias
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_configs`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_configs`;
CREATE TABLE `wy587_virtuemart_configs` (
  `virtuemart_config_id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `config` text,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_config_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Holds configuration settings';

-- ----------------------------
-- Records of wy587_virtuemart_configs
-- ----------------------------
INSERT INTO `wy587_virtuemart_configs` VALUES ('1', 'shop_is_offline=s:1:\"0\";|offline_message=czo3MzoiT3VyIFNob3AgaXMgY3VycmVudGx5IGRvd24gZm9yIG1haW50ZW5hbmNlLiBQbGVhc2UgY2hlY2sgYmFjayBhZ2FpbiBzb29uLiI7|use_as_catalog=s:1:\"0\";|currency_converter_module=s:14:\"convertECB.php\";|order_mail_html=s:1:\"1\";|useSSL=s:1:\"0\";|useVendorEmail=s:1:\"0\";|dangeroustools=s:1:\"0\";|debug_enable=s:4:\"none\";|dev=s:4:\"none\";|google_jquery=s:1:\"0\";|multix=s:4:\"none\";|usefancy=s:1:\"1\";|jchosen=s:1:\"1\";|enableEnglish=s:1:\"1\";|pdf_button_enable=s:1:\"1\";|show_emailfriend=s:1:\"0\";|show_printicon=s:1:\"1\";|show_out_of_stock_products=s:1:\"1\";|ask_captcha=s:1:\"1\";|coupons_enable=s:1:\"1\";|show_uncat_child_products=s:1:\"0\";|coupons_default_expire=s:3:\"1,M\";|weight_unit_default=s:2:\"KG\";|lwh_unit_default=s:1:\"M\";|list_limit=s:2:\"30\";|showReviewFor=s:3:\"all\";|reviewMode=s:6:\"bought\";|showRatingFor=s:3:\"all\";|ratingMode=s:6:\"bought\";|reviews_autopublish=s:1:\"1\";|reviews_minimum_comment_length=s:1:\"0\";|reviews_maximum_comment_length=s:4:\"2000\";|product_navigation=s:1:\"1\";|display_stock=s:1:\"1\";|vmtemplate=s:7:\"default\";|categorytemplate=s:7:\"default\";|showCategory=s:1:\"1\";|categorylayout=s:1:\"0\";|categories_per_row=s:1:\"3\";|productlayout=s:1:\"0\";|products_per_row=s:1:\"3\";|llimit_init_FE=s:2:\"24\";|vmlayout=s:1:\"0\";|show_store_desc=s:1:\"1\";|show_categories=s:1:\"1\";|homepage_categories_per_row=s:1:\"3\";|homepage_products_per_row=s:1:\"3\";|show_featured=s:1:\"1\";|featured_products_rows=s:1:\"1\";|show_topTen=s:1:\"1\";|topTen_products_rows=s:1:\"1\";|show_recent=s:1:\"1\";|recent_products_rows=s:1:\"1\";|show_latest=s:1:\"1\";|latest_products_rows=s:1:\"1\";|assets_general_path=s:33:\"components/com_virtuemart/assets/\";|media_category_path=s:35:\"images/stories/virtuemart/category/\";|media_product_path=s:34:\"images/stories/virtuemart/product/\";|media_manufacturer_path=s:39:\"images/stories/virtuemart/manufacturer/\";|media_vendor_path=s:33:\"images/stories/virtuemart/vendor/\";|forSale_path_thumb=s:42:\"images/stories/virtuemart/forSale/resized/\";|img_resize_enable=s:1:\"1\";|img_width=s:1:\"0\";|img_height=s:2:\"90\";|no_image_set=s:11:\"noimage.gif\";|no_image_found=s:11:\"warning.png\";|browse_orderby_field=s:11:\"pc.ordering\";|browse_cat_orderby_field=s:10:\"c.ordering\";|browse_orderby_fields=a:5:{i:0;s:12:\"product_name\";i:1;s:15:\"`p`.product_sku\";i:2;s:13:\"category_name\";i:3;s:7:\"mf_name\";i:4;s:11:\"pc.ordering\";}|browse_search_fields=a:7:{i:0;s:12:\"product_name\";i:1;s:15:\"`p`.product_sku\";i:2;s:14:\"product_s_desc\";i:3;s:12:\"product_desc\";i:4;s:13:\"category_name\";i:5;s:20:\"category_description\";i:6;s:7:\"mf_name\";}|askprice=s:1:\"1\";|roundindig=s:1:\"1\";|show_prices=s:1:\"1\";|price_show_packaging_pricelabel=s:1:\"0\";|show_tax=s:1:\"1\";|basePrice=s:1:\"0\";|basePriceText=s:1:\"1\";|basePriceRounding=s:2:\"-1\";|variantModification=s:1:\"0\";|variantModificationText=s:1:\"1\";|variantModificationRounding=s:2:\"-1\";|basePriceVariant=s:1:\"1\";|basePriceVariantText=s:1:\"1\";|basePriceVariantRounding=s:2:\"-1\";|basePriceWithTax=s:1:\"0\";|basePriceWithTaxText=s:1:\"1\";|basePriceWithTaxRounding=s:2:\"-1\";|discountedPriceWithoutTax=s:1:\"1\";|discountedPriceWithoutTaxText=s:1:\"1\";|discountedPriceWithoutTaxRounding=s:2:\"-1\";|salesPriceWithDiscount=s:1:\"0\";|salesPriceWithDiscountText=s:1:\"1\";|salesPriceWithDiscountRounding=s:2:\"-1\";|salesPrice=s:1:\"1\";|salesPriceText=s:1:\"1\";|salesPriceRounding=s:2:\"-1\";|priceWithoutTax=s:1:\"1\";|priceWithoutTaxText=s:1:\"1\";|priceWithoutTaxRounding=s:2:\"-1\";|discountAmount=s:1:\"1\";|discountAmountText=s:1:\"1\";|discountAmountRounding=s:2:\"-1\";|taxAmount=s:1:\"1\";|taxAmountText=s:1:\"1\";|taxAmountRounding=s:2:\"-1\";|unitPrice=s:1:\"1\";|unitPriceText=s:1:\"1\";|unitPriceRounding=s:2:\"-1\";|addtocart_popup=s:1:\"1\";|check_stock=s:1:\"0\";|automatic_payment=s:1:\"1\";|automatic_shipment=s:1:\"1\";|agree_to_tos_onorder=s:1:\"0\";|oncheckout_opc=s:1:\"1\";|oncheckout_show_legal_info=s:1:\"1\";|oncheckout_show_register=s:1:\"1\";|oncheckout_show_steps=s:1:\"0\";|oncheckout_show_register_text=s:47:\"COM_VIRTUEMART_ONCHECKOUT_DEFAULT_TEXT_REGISTER\";|inv_os=a:1:{i:0;s:1:\"C\";}|email_os_s=a:5:{i:0;s:1:\"U\";i:1;s:1:\"C\";i:2;s:1:\"X\";i:3;s:1:\"R\";i:4;s:1:\"S\";}|email_os_v=a:4:{i:0;s:1:\"U\";i:1;s:1:\"C\";i:2;s:1:\"X\";i:3;s:1:\"R\";}|seo_disabled=s:1:\"0\";|seo_translate=s:1:\"0\";|seo_use_id=s:1:\"0\";|enable_content_plugin=s:1:\"0\";|reg_captcha=s:1:\"0\";|active_languages=a:1:{i:0;s:5:\"ru-RU\";}|multixcart=s:1:\"0\";|pdf_icon=s:1:\"0\";|recommend_unauth=s:1:\"0\";|ask_question=s:1:\"0\";|asks_minimum_comment_length=s:2:\"50\";|asks_maximum_comment_length=s:4:\"2000\";|show_pcustoms=s:1:\"1\";|handle_404=s:1:\"1\";|cp_rm=a:1:{i:0;s:1:\"C\";}|latest_products_days=s:1:\"7\";|latest_products_orderBy=s:10:\"created_on\";|lstockmail=s:1:\"0\";|stockhandle=s:4:\"none\";|rised_availability=s:0:\"\";|image=s:0:\"\";|rr_os=a:1:{i:0;s:1:\"C\";}|show_manufacturers=s:1:\"1\";|productsublayout=s:1:\"0\";|manufacturer_per_row=s:1:\"3\";|mediaLimit=s:2:\"20\";|llimit_init_BE=s:2:\"30\";|pagseq=s:0:\"\";|pagseq_1=s:0:\"\";|pagseq_2=s:0:\"\";|pagseq_3=s:0:\"\";|pagseq_4=s:0:\"\";|pagseq_5=s:0:\"\";|feed_cat_published=s:1:\"0\";|feed_cat_show_images=s:1:\"0\";|feed_cat_show_prices=s:1:\"0\";|feed_cat_show_description=s:1:\"0\";|feed_cat_description_type=s:14:\"product_s_desc\";|feed_cat_max_text_length=s:3:\"500\";|forSale_path=s:0:\"\";|add_img_main=s:1:\"0\";|feed_latest_published=s:1:\"0\";|feed_latest_nb=s:1:\"5\";|feed_topten_published=s:1:\"0\";|feed_topten_nb=s:1:\"5\";|feed_featured_published=s:1:\"0\";|feed_featured_nb=s:1:\"5\";|feed_home_show_images=s:1:\"1\";|feed_home_show_prices=s:1:\"1\";|feed_home_show_description=s:1:\"0\";|feed_home_description_type=s:14:\"product_s_desc\";|feed_home_max_text_length=s:3:\"500\";|css=s:1:\"1\";|jquery=s:1:\"1\";|jprice=s:1:\"1\";|jsite=s:1:\"1\";|rappenrundung=s:1:\"0\";|cVarswT=s:1:\"1\";|popup_rel=s:1:\"1\";|oncheckout_only_registered=s:1:\"0\";|oncheckout_show_images=s:1:\"0\";|vmlang_js=s:1:\"0\";|oncheckout_change_shopper=s:1:\"1\";|del_date_type=s:1:\"m\";|attach=s:0:\"\";|attach_os=a:4:{i:0;s:1:\"U\";i:1;s:1:\"C\";i:2;s:1:\"X\";i:3;s:1:\"R\";}|prd_brws_orderby_dir=s:3:\"ASC\";|cat_brws_orderby_dir=s:3:\"ASC\";|seo_sufix=s:7:\"-detail\";|task=s:5:\"apply\";|option=s:14:\"com_virtuemart\";|view=s:6:\"config\";|9b65cc9a80217800f6b97f1b501a4240=s:1:\"1\";', '0000-00-00 00:00:00', '0', '2014-12-31 05:20:53', '436', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_countries`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_countries`;
CREATE TABLE `wy587_virtuemart_countries` (
  `virtuemart_country_id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_worldzone_id` tinyint(11) NOT NULL DEFAULT '1',
  `country_name` char(64) DEFAULT NULL,
  `country_3_code` char(3) DEFAULT NULL,
  `country_2_code` char(2) DEFAULT NULL,
  `ordering` int(2) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_country_id`),
  KEY `country_3_code` (`country_3_code`),
  KEY `country_2_code` (`country_2_code`),
  KEY `ordering` (`ordering`),
  KEY `published` (`published`)
) ENGINE=MyISAM AUTO_INCREMENT=249 DEFAULT CHARSET=utf8 COMMENT='Country records';

-- ----------------------------
-- Records of wy587_virtuemart_countries
-- ----------------------------
INSERT INTO `wy587_virtuemart_countries` VALUES ('1', '1', 'Afghanistan', 'AFG', 'AF', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('2', '1', 'Albania', 'ALB', 'AL', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('3', '1', 'Algeria', 'DZA', 'DZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('4', '1', 'American Samoa', 'ASM', 'AS', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('5', '1', 'Andorra', 'AND', 'AD', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('6', '1', 'Angola', 'AGO', 'AO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('7', '1', 'Anguilla', 'AIA', 'AI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('8', '1', 'Antarctica', 'ATA', 'AQ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('9', '1', 'Antigua and Barbuda', 'ATG', 'AG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('10', '1', 'Argentina', 'ARG', 'AR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('11', '1', 'Armenia', 'ARM', 'AM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('12', '1', 'Aruba', 'ABW', 'AW', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('13', '1', 'Australia', 'AUS', 'AU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('14', '1', 'Austria', 'AUT', 'AT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('15', '1', 'Azerbaijan', 'AZE', 'AZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('16', '1', 'Bahamas', 'BHS', 'BS', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('17', '1', 'Bahrain', 'BHR', 'BH', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('18', '1', 'Bangladesh', 'BGD', 'BD', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('19', '1', 'Barbados', 'BRB', 'BB', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('20', '1', 'Belarus', 'BLR', 'BY', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('21', '1', 'Belgium', 'BEL', 'BE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('22', '1', 'Belize', 'BLZ', 'BZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('23', '1', 'Benin', 'BEN', 'BJ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('24', '1', 'Bermuda', 'BMU', 'BM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('25', '1', 'Bhutan', 'BTN', 'BT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('26', '1', 'Bolivia', 'BOL', 'BO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('27', '1', 'Bosnia and Herzegowina', 'BIH', 'BA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('28', '1', 'Botswana', 'BWA', 'BW', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('29', '1', 'Bouvet Island', 'BVT', 'BV', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('30', '1', 'Brazil', 'BRA', 'BR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('31', '1', 'British Indian Ocean Territory', 'IOT', 'IO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('32', '1', 'Brunei Darussalam', 'BRN', 'BN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('33', '1', 'Bulgaria', 'BGR', 'BG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('34', '1', 'Burkina Faso', 'BFA', 'BF', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('35', '1', 'Burundi', 'BDI', 'BI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('36', '1', 'Cambodia', 'KHM', 'KH', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('37', '1', 'Cameroon', 'CMR', 'CM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('38', '1', 'Canada', 'CAN', 'CA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('39', '1', 'Cape Verde', 'CPV', 'CV', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('40', '1', 'Cayman Islands', 'CYM', 'KY', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('41', '1', 'Central African Republic', 'CAF', 'CF', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('42', '1', 'Chad', 'TCD', 'TD', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('43', '1', 'Chile', 'CHL', 'CL', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('44', '1', 'China', 'CHN', 'CN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('45', '1', 'Christmas Island', 'CXR', 'CX', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('46', '1', 'Cocos (Keeling) Islands', 'CCK', 'CC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('47', '1', 'Colombia', 'COL', 'CO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('48', '1', 'Comoros', 'COM', 'KM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('49', '1', 'Congo', 'COG', 'CG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('50', '1', 'Cook Islands', 'COK', 'CK', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('51', '1', 'Costa Rica', 'CRI', 'CR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('52', '1', 'Cote D\'Ivoire', 'CIV', 'CI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('53', '1', 'Croatia', 'HRV', 'HR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('54', '1', 'Cuba', 'CUB', 'CU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('55', '1', 'Cyprus', 'CYP', 'CY', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('56', '1', 'Czech Republic', 'CZE', 'CZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('57', '1', 'Denmark', 'DNK', 'DK', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('58', '1', 'Djibouti', 'DJI', 'DJ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('59', '1', 'Dominica', 'DMA', 'DM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('60', '1', 'Dominican Republic', 'DOM', 'DO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('61', '1', 'East Timor', 'TMP', 'TP', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('62', '1', 'Ecuador', 'ECU', 'EC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('63', '1', 'Egypt', 'EGY', 'EG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('64', '1', 'El Salvador', 'SLV', 'SV', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('65', '1', 'Equatorial Guinea', 'GNQ', 'GQ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('66', '1', 'Eritrea', 'ERI', 'ER', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('67', '1', 'Estonia', 'EST', 'EE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('68', '1', 'Ethiopia', 'ETH', 'ET', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('69', '1', 'Falkland Islands (Malvinas)', 'FLK', 'FK', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('70', '1', 'Faroe Islands', 'FRO', 'FO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('71', '1', 'Fiji', 'FJI', 'FJ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('72', '1', 'Finland', 'FIN', 'FI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('73', '1', 'France', 'FRA', 'FR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('75', '1', 'French Guiana', 'GUF', 'GF', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('76', '1', 'French Polynesia', 'PYF', 'PF', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('77', '1', 'French Southern Territories', 'ATF', 'TF', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('78', '1', 'Gabon', 'GAB', 'GA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('79', '1', 'Gambia', 'GMB', 'GM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('80', '1', 'Georgia', 'GEO', 'GE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('81', '1', 'Germany', 'DEU', 'DE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('82', '1', 'Ghana', 'GHA', 'GH', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('83', '1', 'Gibraltar', 'GIB', 'GI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('84', '1', 'Greece', 'GRC', 'GR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('85', '1', 'Greenland', 'GRL', 'GL', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('86', '1', 'Grenada', 'GRD', 'GD', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('87', '1', 'Guadeloupe', 'GLP', 'GP', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('88', '1', 'Guam', 'GUM', 'GU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('89', '1', 'Guatemala', 'GTM', 'GT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('90', '1', 'Guinea', 'GIN', 'GN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('91', '1', 'Guinea-bissau', 'GNB', 'GW', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('92', '1', 'Guyana', 'GUY', 'GY', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('93', '1', 'Haiti', 'HTI', 'HT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('94', '1', 'Heard and Mc Donald Islands', 'HMD', 'HM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('95', '1', 'Honduras', 'HND', 'HN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('96', '1', 'Hong Kong', 'HKG', 'HK', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('97', '1', 'Hungary', 'HUN', 'HU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('98', '1', 'Iceland', 'ISL', 'IS', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('99', '1', 'India', 'IND', 'IN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('100', '1', 'Indonesia', 'IDN', 'ID', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('101', '1', 'Iran (Islamic Republic of)', 'IRN', 'IR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('102', '1', 'Iraq', 'IRQ', 'IQ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('103', '1', 'Ireland', 'IRL', 'IE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('104', '1', 'Israel', 'ISR', 'IL', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('105', '1', 'Italy', 'ITA', 'IT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('106', '1', 'Jamaica', 'JAM', 'JM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('107', '1', 'Japan', 'JPN', 'JP', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('108', '1', 'Jordan', 'JOR', 'JO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('109', '1', 'Kazakhstan', 'KAZ', 'KZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('110', '1', 'Kenya', 'KEN', 'KE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('111', '1', 'Kiribati', 'KIR', 'KI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('112', '1', 'Korea, Democratic People\'s Republic of', 'PRK', 'KP', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('113', '1', 'Korea, Republic of', 'KOR', 'KR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('114', '1', 'Kuwait', 'KWT', 'KW', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('115', '1', 'Kyrgyzstan', 'KGZ', 'KG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('116', '1', 'Lao People\'s Democratic Republic', 'LAO', 'LA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('117', '1', 'Latvia', 'LVA', 'LV', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('118', '1', 'Lebanon', 'LBN', 'LB', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('119', '1', 'Lesotho', 'LSO', 'LS', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('120', '1', 'Liberia', 'LBR', 'LR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('121', '1', 'Libya', 'LBY', 'LY', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('122', '1', 'Liechtenstein', 'LIE', 'LI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('123', '1', 'Lithuania', 'LTU', 'LT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('124', '1', 'Luxembourg', 'LUX', 'LU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('125', '1', 'Macau', 'MAC', 'MO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('126', '1', 'Macedonia, The Former Yugoslav Republic of', 'MKD', 'MK', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('127', '1', 'Madagascar', 'MDG', 'MG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('128', '1', 'Malawi', 'MWI', 'MW', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('129', '1', 'Malaysia', 'MYS', 'MY', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('130', '1', 'Maldives', 'MDV', 'MV', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('131', '1', 'Mali', 'MLI', 'ML', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('132', '1', 'Malta', 'MLT', 'MT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('133', '1', 'Marshall Islands', 'MHL', 'MH', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('134', '1', 'Martinique', 'MTQ', 'MQ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('135', '1', 'Mauritania', 'MRT', 'MR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('136', '1', 'Mauritius', 'MUS', 'MU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('137', '1', 'Mayotte', 'MYT', 'YT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('138', '1', 'Mexico', 'MEX', 'MX', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('139', '1', 'Micronesia, Federated States of', 'FSM', 'FM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('140', '1', 'Moldova, Republic of', 'MDA', 'MD', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('141', '1', 'Monaco', 'MCO', 'MC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('142', '1', 'Mongolia', 'MNG', 'MN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('143', '1', 'Montserrat', 'MSR', 'MS', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('144', '1', 'Morocco', 'MAR', 'MA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('145', '1', 'Mozambique', 'MOZ', 'MZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('146', '1', 'Myanmar', 'MMR', 'MM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('147', '1', 'Namibia', 'NAM', 'NA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('148', '1', 'Nauru', 'NRU', 'NR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('149', '1', 'Nepal', 'NPL', 'NP', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('150', '1', 'Netherlands', 'NLD', 'NL', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('151', '1', 'Netherlands Antilles', 'ANT', 'AN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('152', '1', 'New Caledonia', 'NCL', 'NC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('153', '1', 'New Zealand', 'NZL', 'NZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('154', '1', 'Nicaragua', 'NIC', 'NI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('155', '1', 'Niger', 'NER', 'NE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('156', '1', 'Nigeria', 'NGA', 'NG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('157', '1', 'Niue', 'NIU', 'NU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('158', '1', 'Norfolk Island', 'NFK', 'NF', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('159', '1', 'Northern Mariana Islands', 'MNP', 'MP', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('160', '1', 'Norway', 'NOR', 'NO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('161', '1', 'Oman', 'OMN', 'OM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('162', '1', 'Pakistan', 'PAK', 'PK', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('163', '1', 'Palau', 'PLW', 'PW', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('164', '1', 'Panama', 'PAN', 'PA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('165', '1', 'Papua New Guinea', 'PNG', 'PG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('166', '1', 'Paraguay', 'PRY', 'PY', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('167', '1', 'Peru', 'PER', 'PE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('168', '1', 'Philippines', 'PHL', 'PH', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('169', '1', 'Pitcairn', 'PCN', 'PN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('170', '1', 'Poland', 'POL', 'PL', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('171', '1', 'Portugal', 'PRT', 'PT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('172', '1', 'Puerto Rico', 'PRI', 'PR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('173', '1', 'Qatar', 'QAT', 'QA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('174', '1', 'Reunion', 'REU', 'RE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('175', '1', 'Romania', 'ROM', 'RO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('176', '1', 'Russian Federation', 'RUS', 'RU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('177', '1', 'Rwanda', 'RWA', 'RW', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('178', '1', 'Saint Kitts and Nevis', 'KNA', 'KN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('179', '1', 'Saint Lucia', 'LCA', 'LC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('180', '1', 'Saint Vincent and the Grenadines', 'VCT', 'VC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('181', '1', 'Samoa', 'WSM', 'WS', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('182', '1', 'San Marino', 'SMR', 'SM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('183', '1', 'Sao Tome and Principe', 'STP', 'ST', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('184', '1', 'Saudi Arabia', 'SAU', 'SA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('185', '1', 'Senegal', 'SEN', 'SN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('186', '1', 'Seychelles', 'SYC', 'SC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('187', '1', 'Sierra Leone', 'SLE', 'SL', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('188', '1', 'Singapore', 'SGP', 'SG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('189', '1', 'Slovakia', 'SVK', 'SK', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('190', '1', 'Slovenia', 'SVN', 'SI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('191', '1', 'Solomon Islands', 'SLB', 'SB', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('192', '1', 'Somalia', 'SOM', 'SO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('193', '1', 'South Africa', 'ZAF', 'ZA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('194', '1', 'South Georgia and the South Sandwich Islands', 'SGS', 'GS', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('195', '1', 'Spain', 'ESP', 'ES', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('196', '1', 'Sri Lanka', 'LKA', 'LK', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('197', '1', 'St. Helena', 'SHN', 'SH', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('198', '1', 'St. Pierre and Miquelon', 'SPM', 'PM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('199', '1', 'Sudan', 'SDN', 'SD', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('200', '1', 'Suriname', 'SUR', 'SR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('201', '1', 'Svalbard and Jan Mayen Islands', 'SJM', 'SJ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('202', '1', 'Swaziland', 'SWZ', 'SZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('203', '1', 'Sweden', 'SWE', 'SE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('204', '1', 'Switzerland', 'CHE', 'CH', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('205', '1', 'Syrian Arab Republic', 'SYR', 'SY', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('206', '1', 'Taiwan', 'TWN', 'TW', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('207', '1', 'Tajikistan', 'TJK', 'TJ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('208', '1', 'Tanzania, United Republic of', 'TZA', 'TZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('209', '1', 'Thailand', 'THA', 'TH', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('210', '1', 'Togo', 'TGO', 'TG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('211', '1', 'Tokelau', 'TKL', 'TK', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('212', '1', 'Tonga', 'TON', 'TO', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('213', '1', 'Trinidad and Tobago', 'TTO', 'TT', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('214', '1', 'Tunisia', 'TUN', 'TN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('215', '1', 'Turkey', 'TUR', 'TR', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('216', '1', 'Turkmenistan', 'TKM', 'TM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('217', '1', 'Turks and Caicos Islands', 'TCA', 'TC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('218', '1', 'Tuvalu', 'TUV', 'TV', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('219', '1', 'Uganda', 'UGA', 'UG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('220', '1', 'Ukraine', 'UKR', 'UA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('221', '1', 'United Arab Emirates', 'ARE', 'AE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('222', '1', 'United Kingdom', 'GBR', 'GB', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('223', '1', 'United States', 'USA', 'US', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('224', '1', 'United States Minor Outlying Islands', 'UMI', 'UM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('225', '1', 'Uruguay', 'URY', 'UY', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('226', '1', 'Uzbekistan', 'UZB', 'UZ', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('227', '1', 'Vanuatu', 'VUT', 'VU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('228', '1', 'Vatican City State (Holy See)', 'VAT', 'VA', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('229', '1', 'Venezuela', 'VEN', 'VE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('230', '1', 'Viet Nam', 'VNM', 'VN', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('231', '1', 'Virgin Islands (British)', 'VGB', 'VG', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('232', '1', 'Virgin Islands (U.S.)', 'VIR', 'VI', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('233', '1', 'Wallis and Futuna Islands', 'WLF', 'WF', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('234', '1', 'Western Sahara', 'ESH', 'EH', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('235', '1', 'Yemen', 'YEM', 'YE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('237', '1', 'The Democratic Republic of Congo', 'DRC', 'DC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('238', '1', 'Zambia', 'ZMB', 'ZM', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('239', '1', 'Zimbabwe', 'ZWE', 'ZW', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('240', '1', 'East Timor', 'XET', 'XE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('241', '1', 'Jersey', 'JEY', 'JE', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('242', '1', 'St. Barthelemy', 'XSB', 'XB', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('243', '1', 'St. Eustatius', 'XSE', 'XU', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('244', '1', 'Canary Islands', 'XCA', 'XC', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('245', '1', 'Serbia', 'SRB', 'RS', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('246', '1', 'Sint Maarten (French Antilles)', 'MAF', 'MF', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('247', '1', 'Sint Maarten (Netherlands Antilles)', 'SXM', 'SX', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_countries` VALUES ('248', '1', 'Palestinian Territory, occupied', 'PSE', 'PS', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_coupons`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_coupons`;
CREATE TABLE `wy587_virtuemart_coupons` (
  `virtuemart_coupon_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_code` char(32) NOT NULL DEFAULT '',
  `percent_or_total` enum('percent','total') NOT NULL DEFAULT 'percent',
  `coupon_type` enum('gift','permanent') NOT NULL DEFAULT 'gift',
  `coupon_value` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `coupon_start_date` datetime DEFAULT NULL,
  `coupon_expiry_date` datetime DEFAULT NULL,
  `coupon_value_valid` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `coupon_used` varchar(200) NOT NULL DEFAULT '',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_coupon_id`),
  KEY `coupon_code` (`coupon_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Used to store coupon codes';

-- ----------------------------
-- Records of wy587_virtuemart_coupons
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_currencies`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_currencies`;
CREATE TABLE `wy587_virtuemart_currencies` (
  `virtuemart_currency_id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '1',
  `currency_name` char(64) DEFAULT NULL,
  `currency_code_2` char(2) DEFAULT NULL,
  `currency_code_3` char(3) DEFAULT NULL,
  `currency_numeric_code` int(4) DEFAULT NULL,
  `currency_exchange_rate` decimal(10,5) DEFAULT NULL,
  `currency_symbol` char(4) DEFAULT NULL,
  `currency_decimal_place` char(4) DEFAULT NULL,
  `currency_decimal_symbol` char(4) DEFAULT NULL,
  `currency_thousands` char(4) DEFAULT NULL,
  `currency_positive_style` char(64) DEFAULT NULL,
  `currency_negative_style` char(64) DEFAULT NULL,
  `ordering` int(2) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '1',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_currency_id`),
  KEY `ordering` (`ordering`),
  KEY `published` (`published`),
  KEY `shared` (`shared`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `currency_code_3` (`currency_code_3`),
  KEY `currency_numeric_code` (`currency_numeric_code`)
) ENGINE=MyISAM AUTO_INCREMENT=202 DEFAULT CHARSET=utf8 COMMENT='Used to store currencies';

-- ----------------------------
-- Records of wy587_virtuemart_currencies
-- ----------------------------
INSERT INTO `wy587_virtuemart_currencies` VALUES ('2', '1', 'United Arab Emirates dirham', '', 'AED', '784', '0.00000', 'د.إ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('4', '1', 'Albanian lek', '', 'ALL', '8', '0.00000', 'Lek', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('5', '1', 'Netherlands Antillean gulden', '', 'ANG', '532', '0.00000', 'ƒ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('7', '1', 'Argentine peso', '', 'ARS', '32', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('9', '1', 'Australian dollar', '', 'AUD', '36', '0.00000', '$', '2', '.', '', '{symbol} {number}', '{sign}{symbol} {number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('10', '1', 'Aruban florin', '', 'AWG', '533', '0.00000', 'ƒ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('11', '1', 'Barbadian dollar', '', 'BBD', '52', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('12', '1', 'Bangladeshi taka', '', 'BDT', '50', '0.00000', '৳', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('15', '1', 'Bahraini dinar', '', 'BHD', '48', '0.00000', 'ب.د', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('16', '1', 'Burundian franc', '', 'BIF', '108', '0.00000', 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('17', '1', 'Bermudian dollar', '', 'BMD', '60', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('18', '1', 'Brunei dollar', '', 'BND', '96', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('19', '1', 'Bolivian boliviano', '', 'BOB', '68', '0.00000', '$b', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('20', '1', 'Brazilian real', '', 'BRL', '986', '0.00000', 'R$', '2', ',', '.', '{symbol} {number}', '{symbol} {sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('21', '1', 'Bahamian dollar', '', 'BSD', '44', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('22', '1', 'Bhutanese ngultrum', '', 'BTN', '64', '0.00000', 'BTN', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('24', '1', 'Botswana pula', '', 'BWP', '72', '0.00000', 'P', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('25', '1', 'Belize dollar', '', 'BZD', '84', '0.00000', 'BZ$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('26', '1', 'Canadian dollar', '', 'CAD', '124', '0.00000', '$', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('27', '1', 'Swiss franc', '', 'CHF', '756', '0.00000', 'CHF', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('28', '1', 'Unidad de Fomento', '', 'CLF', '990', '0.00000', 'CLF', '0', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('29', '1', 'Chilean peso', '', 'CLP', '152', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('30', '1', 'Chinese renminbi yuan', '', 'CNY', '156', '0.00000', '元', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('31', '1', 'Colombian peso', '', 'COP', '170', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('32', '1', 'Costa Rican colón', '', 'CRC', '188', '0.00000', '₡', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('33', '1', 'Czech koruna', '', 'CZK', '203', '0.00000', 'Kč', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('34', '1', 'Cuban peso', '', 'CUP', '192', '0.00000', '₱', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('35', '1', 'Cape Verdean escudo', '', 'CVE', '132', '0.00000', '$', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('40', '1', 'Danish krone', '', 'DKK', '208', '0.00000', 'kr', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('41', '1', 'Dominican peso', '', 'DOP', '214', '0.00000', 'RD$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('42', '1', 'Algerian dinar', '', 'DZD', '12', '0.00000', 'د.ج', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('44', '1', 'Egyptian pound', '', 'EGP', '818', '0.00000', '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('46', '1', 'Ethiopian birr', '', 'ETB', '230', '0.00000', 'ETB', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('47', '1', 'Euro', '', 'EUR', '978', '0.00000', '€', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('49', '1', 'Fijian dollar', '', 'FJD', '242', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('50', '1', 'Falkland pound', '', 'FKP', '238', '0.00000', '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('52', '1', 'British pound', '', 'GBP', '826', '0.00000', '£', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('54', '1', 'Gibraltar pound', '', 'GIP', '292', '0.00000', '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('55', '1', 'Gambian dalasi', '', 'GMD', '270', '0.00000', 'D', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('56', '1', 'Guinean franc', '', 'GNF', '324', '0.00000', 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('58', '1', 'Guatemalan quetzal', '', 'GTQ', '320', '0.00000', 'Q', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('60', '1', 'Guyanese dollar', '', 'GYD', '328', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('61', '1', 'Hong Kong dollar', '', 'HKD', '344', '0.00000', '元', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('62', '1', 'Honduran lempira', '', 'HNL', '340', '0.00000', 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('63', '1', 'Haitian gourde', '', 'HTG', '332', '0.00000', 'G', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('64', '1', 'Hungarian forint', '', 'HUF', '348', '0.00000', 'Ft', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('65', '1', 'Indonesian rupiah', '', 'IDR', '360', '0.00000', 'Rp', '0', '', '', '{symbol}{number}', '{symbol}{sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('67', '1', 'Israeli new sheqel', '', 'ILS', '376', '0.00000', '₪', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('68', '1', 'Indian rupee', '', 'INR', '356', '0.00000', '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('69', '1', 'Iraqi dinar', '', 'IQD', '368', '0.00000', 'ع.د', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('70', '1', 'Iranian rial', '', 'IRR', '364', '0.00000', '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number}{symb0l}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('73', '1', 'Jamaican dollar', '', 'JMD', '388', '0.00000', 'J$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('74', '1', 'Jordanian dinar', '', 'JOD', '400', '0.00000', 'د.ا', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('75', '1', 'Japanese yen', '', 'JPY', '392', '0.00000', '¥', '0', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('76', '1', 'Kenyan shilling', '', 'KES', '404', '0.00000', 'Sh', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('77', '1', 'Cambodian riel', '', 'KHR', '116', '0.00000', '៛', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('78', '1', 'Comorian franc', '', 'KMF', '174', '0.00000', 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('79', '1', 'North Korean won', '', 'KPW', '408', '0.00000', '₩', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('80', '1', 'South Korean won', '', 'KRW', '410', '0.00000', '₩', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('81', '1', 'Kuwaiti dinar', '', 'KWD', '414', '0.00000', 'د.ك', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('82', '1', 'Cayman Islands dollar', '', 'KYD', '136', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('83', '1', 'Lao kip', '', 'LAK', '418', '0.00000', '₭', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('84', '1', 'Lebanese pound', '', 'LBP', '422', '0.00000', '£', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('85', '1', 'Sri Lankan rupee', '', 'LKR', '144', '0.00000', '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('86', '1', 'Liberian dollar', '', 'LRD', '430', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('87', '1', 'Lesotho loti', '', 'LSL', '426', '0.00000', 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('89', '1', 'Libyan dinar', '', 'LYD', '434', '0.00000', 'ل.د', '3', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('90', '1', 'Moroccan dirham', '', 'MAD', '504', '0.00000', 'د.م.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('92', '1', 'Mongolian tögrög', '', 'MNT', '496', '0.00000', '₮', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('93', '1', 'Macanese pataca', '', 'MOP', '446', '0.00000', 'P', '1', ',', '', '{symbol}{number}', '{symbol}{sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('94', '1', 'Mauritanian ouguiya', '', 'MRO', '478', '0.00000', 'UM', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('96', '1', 'Mauritian rupee', '', 'MUR', '480', '0.00000', '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('97', '1', 'Maldivian rufiyaa', '', 'MVR', '462', '0.00000', 'ރ.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('98', '1', 'Malawian kwacha', '', 'MWK', '454', '0.00000', 'MK', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('100', '1', 'Malaysian ringgit', '', 'MYR', '458', '0.00000', 'RM', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('102', '1', 'Nigerian naira', '', 'NGN', '566', '0.00000', '₦', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('105', '1', 'Norwegian krone', '', 'NOK', '578', '0.00000', 'kr', '2', ',', '', '{symbol}{number}', '{symbol}{sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('106', '1', 'Nepalese rupee', '', 'NPR', '524', '0.00000', '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('107', '1', 'New Zealand dollar', '', 'NZD', '554', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{symbol}{sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('108', '1', 'Omani rial', '', 'OMR', '512', '0.00000', '﷼', '3', '.', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('109', '1', 'Panamanian balboa', '', 'PAB', '590', '0.00000', 'B/.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('110', '1', 'Peruvian nuevo sol', '', 'PEN', '604', '0.00000', 'S/.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('111', '1', 'Papua New Guinean kina', '', 'PGK', '598', '0.00000', 'K', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('112', '1', 'Philippine peso', '', 'PHP', '608', '0.00000', '₱', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('113', '1', 'Pakistani rupee', '', 'PKR', '586', '0.00000', '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('114', '1', 'Polish Złoty', '', 'PLN', '985', '0.00000', 'zł', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('116', '1', 'Paraguayan guaraní', '', 'PYG', '600', '0.00000', '₲', '0', '', '.', '{symbol} {number}', '{symbol} {sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('117', '1', 'Qatari riyal', '', 'QAR', '634', '0.00000', '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('118', '1', 'Romanian leu', '', 'RON', '946', '0.00000', 'lei', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('119', '1', 'Rwandan franc', '', 'RWF', '646', '0.00000', 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('120', '1', 'Saudi riyal', '', 'SAR', '682', '0.00000', '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('121', '1', 'Solomon Islands dollar', '', 'SBD', '90', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('122', '1', 'Seychellois rupee', '', 'SCR', '690', '0.00000', '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('124', '1', 'Swedish krona', '', 'SEK', '752', '0.00000', 'kr', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('125', '1', 'Singapore dollar', '', 'SGD', '702', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('126', '1', 'Saint Helenian pound', '', 'SHP', '654', '0.00000', '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('127', '1', 'Sierra Leonean leone', '', 'SLL', '694', '0.00000', 'Le', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('128', '1', 'Somali shilling', '', 'SOS', '706', '0.00000', 'S', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('130', '1', 'São Tomé and Príncipe dobra', '', 'STD', '678', '0.00000', 'Db', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('131', '1', 'Russian ruble', '', 'RUB', '643', '0.00000', 'руб', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('132', '1', 'Salvadoran colón', '', 'SVC', '222', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('133', '1', 'Syrian pound', '', 'SYP', '760', '0.00000', '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('134', '1', 'Swazi lilangeni', '', 'SZL', '748', '0.00000', 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('135', '1', 'Thai baht', '', 'THB', '764', '0.00000', '฿', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('136', '1', 'Tunisian dinar', '', 'TND', '788', '0.00000', 'د.ت', '3', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('137', '1', 'Tongan paʻanga', '', 'TOP', '776', '0.00000', 'T$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('139', '1', 'Turkish new lira', '', 'TRY', '949', '0.00000', 'YTL', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('140', '1', 'Trinidad and Tobago dollar', '', 'TTD', '780', '0.00000', 'TT$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('141', '1', 'New Taiwan dollar', '', 'TWD', '901', '0.00000', 'NT$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('142', '1', 'Tanzanian shilling', '', 'TZS', '834', '0.00000', 'Sh', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('144', '1', 'United States dollar', '', 'USD', '840', '0.00000', '$', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('147', '1', 'Vietnamese Dong', '', 'VND', '704', '0.00000', '₫', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('148', '1', 'Vanuatu vatu', '', 'VUV', '548', '0.00000', 'Vt', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('149', '1', 'Samoan tala', '', 'WST', '882', '0.00000', 'T', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('151', '1', 'Yemeni rial', '', 'YER', '886', '0.00000', '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('152', '1', 'Serbian dinar', '', 'RSD', '941', '0.00000', 'Дин.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('153', '1', 'South African rand', '', 'ZAR', '710', '0.00000', 'R', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('154', '1', 'Zambian kwacha', '', 'ZMK', '894', '0.00000', 'ZK', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('156', '1', 'Zimbabwean dollar', '', 'ZWD', '932', '0.00000', 'Z$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('158', '1', 'Armenian dram', '', 'AMD', '51', '0.00000', 'դր.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('159', '1', 'Myanmar kyat', '', 'MMK', '104', '0.00000', 'K', '2', ',', '', '{number} {symbol}', '{symbol} {sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('160', '1', 'Croatian kuna', '', 'HRK', '191', '0.00000', 'kn', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('161', '1', 'Eritrean nakfa', '', 'ERN', '232', '0.00000', 'Nfk', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('162', '1', 'Djiboutian franc', '', 'DJF', '262', '0.00000', 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('163', '1', 'Icelandic króna', '', 'ISK', '352', '0.00000', 'kr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('164', '1', 'Kazakhstani tenge', '', 'KZT', '398', '0.00000', 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('165', '1', 'Kyrgyzstani som', '', 'KGS', '417', '0.00000', 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('166', '1', 'Latvian lats', '', 'LVL', '428', '0.00000', 'Ls', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('167', '1', 'Lithuanian litas', '', 'LTL', '440', '0.00000', 'Lt', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('168', '1', 'Mexican peso', '', 'MXN', '484', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('169', '1', 'Moldovan leu', '', 'MDL', '498', '0.00000', 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('170', '1', 'Namibian dollar', '', 'NAD', '516', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('171', '1', 'Nicaraguan córdoba', '', 'NIO', '558', '0.00000', 'C$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('172', '1', 'Ugandan shilling', '', 'UGX', '800', '0.00000', 'Sh', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('173', '1', 'Macedonian denar', '', 'MKD', '807', '0.00000', 'ден', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('174', '1', 'Uruguayan peso', '', 'UYU', '858', '0.00000', '$', '0', '', '', '{symbol}number}', '{symbol}{sign}{number}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('175', '1', 'Uzbekistani som', '', 'UZS', '860', '0.00000', 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('176', '1', 'Azerbaijani manat', '', 'AZN', '934', '0.00000', 'ман', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('177', '1', 'Ghanaian cedi', '', 'GHS', '936', '0.00000', '₵', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('178', '1', 'Venezuelan bolívar', '', 'VEF', '937', '0.00000', 'Bs', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('179', '1', 'Sudanese pound', '', 'SDG', '938', '0.00000', '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('180', '1', 'Uruguay Peso', '', 'UYI', '940', '0.00000', 'UYI', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('181', '1', 'Mozambican metical', '', 'MZN', '943', '0.00000', 'MT', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('182', '1', 'WIR Euro', '', 'CHE', '947', '0.00000', '€', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('183', '1', 'WIR Franc', '', 'CHW', '948', '0.00000', 'CHW', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('184', '1', 'Central African CFA franc', '', 'XAF', '950', '0.00000', 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('185', '1', 'East Caribbean dollar', '', 'XCD', '951', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('186', '1', 'West African CFA franc', '', 'XOF', '952', '0.00000', 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('187', '1', 'CFP franc', '', 'XPF', '953', '0.00000', 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('188', '1', 'Surinamese dollar', '', 'SRD', '968', '0.00000', '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('189', '1', 'Malagasy ariary', '', 'MGA', '969', '0.00000', 'MGA', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('190', '1', 'Unidad de Valor Real', '', 'COU', '970', '0.00000', 'COU', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('191', '1', 'Afghan afghani', '', 'AFN', '971', '0.00000', '؋', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('192', '1', 'Tajikistani somoni', '', 'TJS', '972', '0.00000', 'ЅМ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('193', '1', 'Angolan kwanza', '', 'AOA', '973', '0.00000', 'Kz', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('194', '1', 'Belarusian ruble', '', 'BYR', '974', '0.00000', 'p.', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('195', '1', 'Bulgarian lev', '', 'BGN', '975', '0.00000', 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('196', '1', 'Congolese franc', '', 'CDF', '976', '0.00000', 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('197', '1', 'Bosnia and Herzegovina convert', '', 'BAM', '977', '0.00000', 'KM', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('198', '1', 'Mexican Unid', '', 'MXV', '979', '0.00000', 'MXV', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('199', '1', 'Ukrainian hryvnia', '', 'UAH', '980', '0.00000', '₴', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('200', '1', 'Georgian lari', '', 'GEL', '981', '0.00000', 'ლ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_currencies` VALUES ('201', '1', 'Mvdol', '', 'BOV', '984', '0.00000', 'BOV', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_customs`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_customs`;
CREATE TABLE `wy587_virtuemart_customs` (
  `virtuemart_custom_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `custom_parent_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_vendor_id` smallint(1) NOT NULL DEFAULT '1',
  `custom_jplugin_id` int(11) NOT NULL DEFAULT '0',
  `custom_element` char(50) NOT NULL DEFAULT '',
  `admin_only` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1:Display in admin only',
  `custom_title` char(255) NOT NULL DEFAULT '' COMMENT 'field title',
  `show_title` tinyint(1) NOT NULL DEFAULT '1',
  `custom_tip` char(255) NOT NULL DEFAULT '' COMMENT 'tip',
  `custom_value` varchar(2000) DEFAULT NULL COMMENT 'default value',
  `custom_desc` char(255) DEFAULT NULL COMMENT 'description or unit',
  `field_type` char(2) NOT NULL DEFAULT '0' COMMENT 'S:string,I:int,P:parent, B:bool,D:date,T:time,H:hidden',
  `is_list` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'list of values',
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1:hidden',
  `is_cart_attribute` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Add attributes to cart',
  `is_input` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Add input to cart',
  `layout_pos` char(24) DEFAULT NULL COMMENT 'Layout Position',
  `custom_params` varchar(17000) NOT NULL DEFAULT '',
  `shared` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'valid for all vendors?',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_custom_id`),
  KEY `custom_parent_id` (`custom_parent_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `custom_element` (`custom_element`),
  KEY `field_type` (`field_type`),
  KEY `is_cart_attribute` (`is_cart_attribute`),
  KEY `is_input` (`is_input`),
  KEY `shared` (`shared`),
  KEY `published` (`published`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='custom fields definition';

-- ----------------------------
-- Records of wy587_virtuemart_customs
-- ----------------------------
INSERT INTO `wy587_virtuemart_customs` VALUES ('1', '0', '0', '0', '0', '0', 'COM_VIRTUEMART_RELATED_PRODUCTS', '1', 'COM_VIRTUEMART_RELATED_PRODUCTS_TIP', 'related_products', 'COM_VIRTUEMART_RELATED_PRODUCTS_DESC', 'R', '0', '0', '0', '0', 'related_products', 'wPrice=\"1\"|wImage=\"1\"|wDescr=\"1\"|', '0', '1', '0000-00-00 00:00:00', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_customs` VALUES ('2', '0', '0', '0', '0', '0', 'COM_VIRTUEMART_RELATED_CATEGORIES', '1', 'COM_VIRTUEMART_RELATED_CATEGORIES_TIP', 'related_categories', 'COM_VIRTUEMART_RELATED_CATEGORIES_DESC', 'Z', '0', '0', '0', '0', 'related_categories', 'wImage=\"1\"|wDescr=\"1\"|', '0', '1', '0000-00-00 00:00:00', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_invoices`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_invoices`;
CREATE TABLE `wy587_virtuemart_invoices` (
  `virtuemart_invoice_id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '1',
  `virtuemart_order_id` int(1) unsigned DEFAULT NULL,
  `invoice_number` char(64) DEFAULT NULL,
  `order_status` char(2) DEFAULT NULL,
  `xhtml` text,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_invoice_id`),
  UNIQUE KEY `invoice_number` (`invoice_number`,`virtuemart_vendor_id`),
  KEY `virtuemart_order_id` (`virtuemart_order_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='custom fields definition';

-- ----------------------------
-- Records of wy587_virtuemart_invoices
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_manufacturercategories`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_manufacturercategories`;
CREATE TABLE `wy587_virtuemart_manufacturercategories` (
  `virtuemart_manufacturercategories_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_manufacturercategories_id`),
  KEY `published` (`published`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Manufacturers are assigned to these categories';

-- ----------------------------
-- Records of wy587_virtuemart_manufacturercategories
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_manufacturercategories_ru_ru`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_manufacturercategories_ru_ru`;
CREATE TABLE `wy587_virtuemart_manufacturercategories_ru_ru` (
  `virtuemart_manufacturercategories_id` int(1) unsigned NOT NULL,
  `mf_category_name` char(180) NOT NULL DEFAULT '',
  `mf_category_desc` varchar(19000) NOT NULL DEFAULT '',
  `slug` char(192) NOT NULL DEFAULT '',
  PRIMARY KEY (`virtuemart_manufacturercategories_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_manufacturercategories_ru_ru
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_manufacturers`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_manufacturers`;
CREATE TABLE `wy587_virtuemart_manufacturers` (
  `virtuemart_manufacturer_id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_manufacturercategories_id` int(11) DEFAULT NULL,
  `hits` int(11) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_manufacturer_id`),
  UNIQUE KEY `virtuemart_manufacturercategories_id` (`virtuemart_manufacturer_id`,`virtuemart_manufacturercategories_id`),
  KEY `published` (`published`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Manufacturers are those who deliver products';

-- ----------------------------
-- Records of wy587_virtuemart_manufacturers
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_manufacturers_ru_ru`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_manufacturers_ru_ru`;
CREATE TABLE `wy587_virtuemart_manufacturers_ru_ru` (
  `virtuemart_manufacturer_id` int(1) unsigned NOT NULL,
  `mf_name` char(180) NOT NULL DEFAULT '',
  `mf_email` char(255) NOT NULL DEFAULT '',
  `mf_desc` varchar(19000) NOT NULL DEFAULT '',
  `mf_url` char(255) NOT NULL DEFAULT '',
  `slug` char(192) NOT NULL DEFAULT '',
  PRIMARY KEY (`virtuemart_manufacturer_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_manufacturers_ru_ru
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_manufacturer_medias`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_manufacturer_medias`;
CREATE TABLE `wy587_virtuemart_manufacturer_medias` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_manufacturer_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_media_id` int(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_manufacturer_id` (`virtuemart_manufacturer_id`,`virtuemart_media_id`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_manufacturer_medias
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_medias`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_medias`;
CREATE TABLE `wy587_virtuemart_medias` (
  `virtuemart_media_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) NOT NULL DEFAULT '1',
  `file_title` char(126) NOT NULL DEFAULT '',
  `file_description` char(254) NOT NULL DEFAULT '',
  `file_meta` char(254) NOT NULL DEFAULT '',
  `file_mimetype` char(64) NOT NULL DEFAULT '',
  `file_type` char(32) NOT NULL DEFAULT '',
  `file_url` varchar(900) NOT NULL DEFAULT '',
  `file_url_thumb` varchar(900) NOT NULL DEFAULT '',
  `file_is_product_image` tinyint(1) NOT NULL DEFAULT '0',
  `file_is_downloadable` tinyint(1) NOT NULL DEFAULT '0',
  `file_is_forSale` tinyint(1) NOT NULL DEFAULT '0',
  `file_params` varchar(17000) NOT NULL DEFAULT '',
  `file_lang` varchar(500) NOT NULL DEFAULT '',
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_media_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `published` (`published`),
  KEY `shared` (`shared`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Additional Images and Files which are assigned to products';

-- ----------------------------
-- Records of wy587_virtuemart_medias
-- ----------------------------
INSERT INTO `wy587_virtuemart_medias` VALUES ('1', '1', 'image8.png', '', '', 'image/png', 'product', 'images/stories/virtuemart/product/image8.png', '', '0', '0', '0', '', '', '0', '1', '2014-12-31 05:40:26', '436', '2014-12-31 05:40:26', '436', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_migration_oldtonew_ids`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_migration_oldtonew_ids`;
CREATE TABLE `wy587_virtuemart_migration_oldtonew_ids` (
  `id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `cats` longblob,
  `catsxref` blob,
  `manus` longblob,
  `mfcats` blob,
  `shoppergroups` longblob,
  `products` longblob,
  `products_start` int(1) DEFAULT NULL,
  `orderstates` blob,
  `orders` longblob,
  `attributes` longblob,
  `relatedproducts` longblob,
  `orders_start` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='xref table for vm1 ids to vm2 ids';

-- ----------------------------
-- Records of wy587_virtuemart_migration_oldtonew_ids
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_modules`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_modules`;
CREATE TABLE `wy587_virtuemart_modules` (
  `module_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `module_name` char(255) DEFAULT NULL,
  `module_description` varchar(21000) DEFAULT NULL,
  `module_perms` char(255) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `is_admin` enum('0','1') NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`module_id`),
  KEY `module_name` (`module_name`),
  KEY `ordering` (`ordering`),
  KEY `published` (`published`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='VirtueMart Core Modules, not: Joomla modules';

-- ----------------------------
-- Records of wy587_virtuemart_modules
-- ----------------------------
INSERT INTO `wy587_virtuemart_modules` VALUES ('1', 'product', 'Here you can administer your online catalog of products.  Categories , Products (view=product), Attributes, Product Types, Product Files (view=media), Inventory, Calculation Rules, Customer Reviews  ', 'storeadmin,admin', '1', '', '1');
INSERT INTO `wy587_virtuemart_modules` VALUES ('2', 'order', 'View Order and Update Order Status:    Orders , Coupons , Revenue Report ,Shopper , Shopper Groups ', 'admin,storeadmin', '1', '', '2');
INSERT INTO `wy587_virtuemart_modules` VALUES ('3', 'manufacturer', 'Manage the manufacturers of products in your store.', 'storeadmin,admin', '1', '', '3');
INSERT INTO `wy587_virtuemart_modules` VALUES ('4', 'store', 'Store Configuration: Store Information, Payment Methods , Shipment, Shipment Rates', 'storeadmin,admin', '1', '', '4');
INSERT INTO `wy587_virtuemart_modules` VALUES ('5', 'configuration', 'Configuration: shop configuration , currencies (view=currency), Credit Card List, Countries, userfields, order status  ', 'admin,storeadmin', '1', '0', '5');
INSERT INTO `wy587_virtuemart_modules` VALUES ('6', 'msgs', 'This module is unprotected an used for displaying system messages to users.  We need to have an area that does not require authorization when things go wrong.', 'none', '0', '', '99');
INSERT INTO `wy587_virtuemart_modules` VALUES ('7', 'shop', 'This is the Washupito store module.  This is the demo store included with the VirtueMart distribution.', 'none', '1', '', '99');
INSERT INTO `wy587_virtuemart_modules` VALUES ('8', 'store', 'Store Configuration: Store Information, Payment Methods , Shipment, Shipment Rates', 'storeadmin,admin', '1', '', '4');
INSERT INTO `wy587_virtuemart_modules` VALUES ('9', 'account', 'This module allows shoppers to update their account information and view previously placed orders.', 'shopper,storeadmin,admin,demo', '1', '', '99');
INSERT INTO `wy587_virtuemart_modules` VALUES ('10', 'checkout', '', 'none', '0', '', '99');
INSERT INTO `wy587_virtuemart_modules` VALUES ('11', 'tools', 'Tools', 'admin', '1', '0', '8');
INSERT INTO `wy587_virtuemart_modules` VALUES ('13', 'zone', 'This is the zone-shipment module. Here you can manage your shipment costs according to Zones.', 'admin,storeadmin', '0', '', '11');

-- ----------------------------
-- Table structure for `wy587_virtuemart_orders`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_orders`;
CREATE TABLE `wy587_virtuemart_orders` (
  `virtuemart_order_id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_user_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `order_number` char(64) DEFAULT NULL,
  `customer_number` char(32) DEFAULT NULL,
  `order_pass` char(8) DEFAULT NULL,
  `order_total` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_salesPrice` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_billTaxAmount` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_billTax` varchar(400) DEFAULT NULL,
  `order_billDiscountAmount` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_discountAmount` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_subtotal` decimal(15,5) DEFAULT NULL,
  `order_tax` decimal(10,5) DEFAULT NULL,
  `order_shipment` decimal(10,2) DEFAULT NULL,
  `order_shipment_tax` decimal(10,5) DEFAULT NULL,
  `order_payment` decimal(10,2) DEFAULT NULL,
  `order_payment_tax` decimal(10,5) DEFAULT NULL,
  `coupon_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `coupon_code` char(32) DEFAULT NULL,
  `order_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `order_currency` smallint(1) DEFAULT NULL,
  `order_status` char(1) DEFAULT NULL,
  `user_currency_id` smallint(1) DEFAULT NULL,
  `user_currency_rate` decimal(10,5) NOT NULL DEFAULT '1.00000',
  `virtuemart_paymentmethod_id` mediumint(1) unsigned DEFAULT NULL,
  `virtuemart_shipmentmethod_id` mediumint(1) unsigned DEFAULT NULL,
  `delivery_date` varchar(200) DEFAULT NULL,
  `order_language` char(7) DEFAULT NULL,
  `ip_address` char(15) NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_order_id`),
  KEY `virtuemart_user_id` (`virtuemart_user_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `order_number` (`order_number`),
  KEY `virtuemart_paymentmethod_id` (`virtuemart_paymentmethod_id`),
  KEY `virtuemart_shipmentmethod_id` (`virtuemart_shipmentmethod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Used to store all orders';

-- ----------------------------
-- Records of wy587_virtuemart_orders
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_orderstates`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_orderstates`;
CREATE TABLE `wy587_virtuemart_orderstates` (
  `virtuemart_orderstate_id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(11) NOT NULL DEFAULT '1',
  `order_status_code` char(1) NOT NULL DEFAULT '',
  `order_status_name` char(64) DEFAULT NULL,
  `order_status_description` varchar(20000) DEFAULT NULL,
  `order_stock_handle` char(1) NOT NULL DEFAULT 'A',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_orderstate_id`),
  KEY `ordering` (`ordering`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `published` (`published`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='All available order statuses';

-- ----------------------------
-- Records of wy587_virtuemart_orderstates
-- ----------------------------
INSERT INTO `wy587_virtuemart_orderstates` VALUES ('1', '1', 'P', 'COM_VIRTUEMART_ORDER_STATUS_PENDING', '', 'R', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_orderstates` VALUES ('2', '1', 'U', 'COM_VIRTUEMART_ORDER_STATUS_CONFIRMED_BY_SHOPPER', '', 'R', '2', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_orderstates` VALUES ('3', '1', 'C', 'COM_VIRTUEMART_ORDER_STATUS_CONFIRMED', '', 'R', '3', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_orderstates` VALUES ('4', '1', 'X', 'COM_VIRTUEMART_ORDER_STATUS_CANCELLED', '', 'A', '4', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_orderstates` VALUES ('5', '1', 'R', 'COM_VIRTUEMART_ORDER_STATUS_REFUNDED', '', 'A', '5', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_orderstates` VALUES ('6', '1', 'S', 'COM_VIRTUEMART_ORDER_STATUS_SHIPPED', '', 'O', '6', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_order_calc_rules`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_order_calc_rules`;
CREATE TABLE `wy587_virtuemart_order_calc_rules` (
  `virtuemart_order_calc_rule_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_calc_id` int(11) DEFAULT NULL,
  `virtuemart_order_id` int(11) DEFAULT NULL,
  `virtuemart_vendor_id` smallint(11) NOT NULL DEFAULT '1',
  `virtuemart_order_item_id` int(11) DEFAULT NULL,
  `calc_rule_name` char(64) NOT NULL DEFAULT '' COMMENT 'Name of the rule',
  `calc_kind` char(16) NOT NULL DEFAULT '' COMMENT 'Discount/Tax/Margin/Commission',
  `calc_mathop` char(16) NOT NULL DEFAULT '' COMMENT 'Discount/Tax/Margin/Commission',
  `calc_amount` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `calc_result` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `calc_value` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `calc_currency` smallint(1) DEFAULT NULL,
  `calc_params` varchar(18000) NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_order_calc_rule_id`),
  KEY `virtuemart_calc_id` (`virtuemart_calc_id`),
  KEY `virtuemart_order_id` (`virtuemart_order_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all calculation rules which are part of an order';

-- ----------------------------
-- Records of wy587_virtuemart_order_calc_rules
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_order_histories`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_order_histories`;
CREATE TABLE `wy587_virtuemart_order_histories` (
  `virtuemart_order_history_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_order_id` int(1) unsigned NOT NULL DEFAULT '0',
  `order_status_code` char(1) NOT NULL DEFAULT '0',
  `customer_notified` tinyint(1) NOT NULL DEFAULT '0',
  `comments` varchar(21000) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_order_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all actions and changes that occur to an order';

-- ----------------------------
-- Records of wy587_virtuemart_order_histories
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_order_items`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_order_items`;
CREATE TABLE `wy587_virtuemart_order_items` (
  `virtuemart_order_item_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_order_id` int(11) DEFAULT NULL,
  `virtuemart_vendor_id` smallint(11) NOT NULL DEFAULT '1',
  `virtuemart_product_id` int(11) DEFAULT NULL,
  `order_item_sku` char(64) NOT NULL DEFAULT '',
  `order_item_name` varchar(4096) NOT NULL DEFAULT '',
  `product_quantity` int(11) DEFAULT NULL,
  `product_item_price` decimal(15,5) DEFAULT NULL,
  `product_priceWithoutTax` decimal(15,5) DEFAULT NULL,
  `product_tax` decimal(15,5) DEFAULT NULL,
  `product_basePriceWithTax` decimal(15,5) DEFAULT NULL,
  `product_discountedPriceWithoutTax` decimal(15,5) DEFAULT NULL,
  `product_final_price` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `product_subtotal_discount` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `product_subtotal_with_tax` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_item_currency` int(11) DEFAULT NULL,
  `order_status` char(1) DEFAULT NULL,
  `product_attribute` text,
  `delivery_date` varchar(200) DEFAULT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_order_item_id`),
  KEY `virtuemart_product_id` (`virtuemart_product_id`),
  KEY `virtuemart_order_id` (`virtuemart_order_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `order_status` (`order_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all items (products) which are part of an order';

-- ----------------------------
-- Records of wy587_virtuemart_order_items
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_order_userinfos`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_order_userinfos`;
CREATE TABLE `wy587_virtuemart_order_userinfos` (
  `virtuemart_order_userinfo_id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_order_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_user_id` int(1) unsigned NOT NULL DEFAULT '0',
  `address_type` char(2) DEFAULT NULL,
  `address_type_name` char(32) DEFAULT NULL,
  `company` char(64) DEFAULT NULL,
  `title` char(32) DEFAULT NULL,
  `last_name` char(48) DEFAULT NULL,
  `first_name` char(48) DEFAULT NULL,
  `middle_name` char(48) DEFAULT NULL,
  `phone_1` char(32) DEFAULT NULL,
  `phone_2` char(32) DEFAULT NULL,
  `fax` char(32) DEFAULT NULL,
  `address_1` char(64) NOT NULL DEFAULT '',
  `address_2` char(64) DEFAULT NULL,
  `city` char(64) NOT NULL DEFAULT '',
  `virtuemart_state_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_country_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `zip` char(16) NOT NULL DEFAULT '',
  `email` char(128) DEFAULT NULL,
  `agreed` tinyint(1) NOT NULL DEFAULT '0',
  `tos` tinyint(1) NOT NULL DEFAULT '0',
  `customer_note` varchar(2500) NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_order_userinfo_id`),
  KEY `virtuemart_order_id` (`virtuemart_order_id`),
  KEY `virtuemart_user_id` (`virtuemart_user_id`),
  KEY `address_type` (`address_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the BillTo and ShipTo Information at order time';

-- ----------------------------
-- Records of wy587_virtuemart_order_userinfos
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_paymentmethods`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_paymentmethods`;
CREATE TABLE `wy587_virtuemart_paymentmethods` (
  `virtuemart_paymentmethod_id` mediumint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(11) NOT NULL DEFAULT '1',
  `payment_jplugin_id` int(11) NOT NULL DEFAULT '0',
  `payment_element` char(50) NOT NULL DEFAULT '',
  `payment_params` varchar(19000) NOT NULL DEFAULT '',
  `shared` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'valide for all vendors?',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_paymentmethod_id`),
  KEY `payment_jplugin_id` (`payment_jplugin_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `payment_element` (`payment_element`,`virtuemart_vendor_id`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='The payment methods of your store';

-- ----------------------------
-- Records of wy587_virtuemart_paymentmethods
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_paymentmethods_ru_ru`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_paymentmethods_ru_ru`;
CREATE TABLE `wy587_virtuemart_paymentmethods_ru_ru` (
  `virtuemart_paymentmethod_id` int(1) unsigned NOT NULL,
  `payment_name` char(180) NOT NULL DEFAULT '',
  `payment_desc` varchar(19000) NOT NULL DEFAULT '',
  `slug` char(192) NOT NULL DEFAULT '',
  PRIMARY KEY (`virtuemart_paymentmethod_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_paymentmethods_ru_ru
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_paymentmethod_shoppergroups`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_paymentmethod_shoppergroups`;
CREATE TABLE `wy587_virtuemart_paymentmethod_shoppergroups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_paymentmethod_id` mediumint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_shoppergroup_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_paymentmethod_id` (`virtuemart_paymentmethod_id`,`virtuemart_shoppergroup_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='xref table for paymentmethods to shoppergroup';

-- ----------------------------
-- Records of wy587_virtuemart_paymentmethod_shoppergroups
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_products`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_products`;
CREATE TABLE `wy587_virtuemart_products` (
  `virtuemart_product_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '1',
  `product_parent_id` int(1) unsigned NOT NULL DEFAULT '0',
  `product_sku` char(64) DEFAULT NULL,
  `product_gtin` char(64) DEFAULT NULL,
  `product_mpn` char(64) DEFAULT NULL,
  `product_weight` decimal(10,4) DEFAULT NULL,
  `product_weight_uom` char(7) DEFAULT NULL,
  `product_length` decimal(10,4) DEFAULT NULL,
  `product_width` decimal(10,4) DEFAULT NULL,
  `product_height` decimal(10,4) DEFAULT NULL,
  `product_lwh_uom` char(7) DEFAULT NULL,
  `product_url` char(255) DEFAULT NULL,
  `product_in_stock` int(1) NOT NULL DEFAULT '0',
  `product_ordered` int(1) NOT NULL DEFAULT '0',
  `low_stock_notification` int(1) unsigned NOT NULL DEFAULT '0',
  `product_available_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `product_availability` char(32) DEFAULT NULL,
  `product_special` tinyint(1) DEFAULT NULL,
  `product_sales` int(1) unsigned NOT NULL DEFAULT '0',
  `product_unit` varchar(8) DEFAULT NULL,
  `product_packaging` decimal(8,4) unsigned DEFAULT NULL,
  `product_params` varchar(2000) NOT NULL DEFAULT '',
  `hits` int(11) unsigned DEFAULT NULL,
  `intnotes` varchar(18000) DEFAULT NULL,
  `metarobot` varchar(400) DEFAULT NULL,
  `metaauthor` varchar(400) DEFAULT NULL,
  `layout` char(16) DEFAULT NULL,
  `published` tinyint(1) DEFAULT NULL,
  `pordering` mediumint(2) unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_product_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `product_parent_id` (`product_parent_id`),
  KEY `product_special` (`product_special`),
  KEY `published` (`published`),
  KEY `pordering` (`pordering`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='All products are stored here.';

-- ----------------------------
-- Records of wy587_virtuemart_products
-- ----------------------------
INSERT INTO `wy587_virtuemart_products` VALUES ('1', '1', '0', '000001', '', '', null, 'KG', null, null, null, 'M', '', '2', '0', '0', '2014-12-31 00:00:00', '', '0', '0', 'KG', null, 'min_order_level=\"\"|max_order_level=\"\"|step_order_level=\"\"|product_box=\"\"|', null, '', '', '', '0', '1', '0', '2014-12-31 05:40:26', '436', '2014-12-31 05:40:26', '436', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_products_ru_ru`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_products_ru_ru`;
CREATE TABLE `wy587_virtuemart_products_ru_ru` (
  `virtuemart_product_id` int(1) unsigned NOT NULL,
  `product_s_desc` varchar(2000) NOT NULL DEFAULT '',
  `product_desc` varchar(18400) NOT NULL DEFAULT '',
  `product_name` char(180) NOT NULL DEFAULT '',
  `metadesc` varchar(400) NOT NULL DEFAULT '',
  `metakey` varchar(400) NOT NULL DEFAULT '',
  `customtitle` char(255) NOT NULL DEFAULT '',
  `slug` char(192) NOT NULL DEFAULT '',
  PRIMARY KEY (`virtuemart_product_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_products_ru_ru
-- ----------------------------
INSERT INTO `wy587_virtuemart_products_ru_ru` VALUES ('1', 'qwerty', '<p>qwerty full</p>', 'нокиа', '', '', '', 'нокиа');

-- ----------------------------
-- Table structure for `wy587_virtuemart_product_categories`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_product_categories`;
CREATE TABLE `wy587_virtuemart_product_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_product_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_category_id` mediumint(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_product_id` (`virtuemart_product_id`,`virtuemart_category_id`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Maps Products to Categories';

-- ----------------------------
-- Records of wy587_virtuemart_product_categories
-- ----------------------------
INSERT INTO `wy587_virtuemart_product_categories` VALUES ('1', '1', '1', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_product_customfields`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_product_customfields`;
CREATE TABLE `wy587_virtuemart_product_customfields` (
  `virtuemart_customfield_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'field id',
  `virtuemart_product_id` int(11) NOT NULL DEFAULT '0',
  `virtuemart_custom_id` int(11) NOT NULL DEFAULT '1' COMMENT 'custom group id',
  `customfield_value` varchar(2500) DEFAULT NULL COMMENT 'field value',
  `customfield_price` decimal(15,6) DEFAULT NULL COMMENT 'price',
  `disabler` int(1) unsigned NOT NULL DEFAULT '0',
  `override` int(1) unsigned NOT NULL DEFAULT '0',
  `customfield_params` varchar(17000) NOT NULL DEFAULT '' COMMENT 'Param for Plugins',
  `product_sku` char(64) DEFAULT NULL,
  `product_gtin` char(64) DEFAULT NULL,
  `product_mpn` char(64) DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(1) unsigned NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(1) unsigned NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_customfield_id`),
  KEY `virtuemart_product_id` (`virtuemart_product_id`),
  KEY `virtuemart_custom_id` (`virtuemart_custom_id`),
  KEY `published` (`published`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='custom fields';

-- ----------------------------
-- Records of wy587_virtuemart_product_customfields
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_product_manufacturers`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_product_manufacturers`;
CREATE TABLE `wy587_virtuemart_product_manufacturers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_product_id` int(11) DEFAULT NULL,
  `virtuemart_manufacturer_id` smallint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_product_id` (`virtuemart_product_id`,`virtuemart_manufacturer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Maps a product to a manufacturer';

-- ----------------------------
-- Records of wy587_virtuemart_product_manufacturers
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_product_medias`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_product_medias`;
CREATE TABLE `wy587_virtuemart_product_medias` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_product_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_media_id` int(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_product_id` (`virtuemart_product_id`,`virtuemart_media_id`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_product_medias
-- ----------------------------
INSERT INTO `wy587_virtuemart_product_medias` VALUES ('1', '1', '1', '1');

-- ----------------------------
-- Table structure for `wy587_virtuemart_product_prices`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_product_prices`;
CREATE TABLE `wy587_virtuemart_product_prices` (
  `virtuemart_product_price_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_product_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_shoppergroup_id` int(11) DEFAULT NULL,
  `product_price` decimal(15,6) DEFAULT NULL,
  `override` tinyint(1) DEFAULT NULL,
  `product_override_price` decimal(15,5) DEFAULT NULL,
  `product_tax_id` int(11) DEFAULT NULL,
  `product_discount_id` int(11) DEFAULT NULL,
  `product_currency` smallint(1) DEFAULT NULL,
  `product_price_publish_up` datetime DEFAULT NULL,
  `product_price_publish_down` datetime DEFAULT NULL,
  `price_quantity_start` int(11) unsigned DEFAULT NULL,
  `price_quantity_end` int(11) unsigned DEFAULT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_product_price_id`),
  KEY `virtuemart_product_id` (`virtuemart_product_id`),
  KEY `virtuemart_shoppergroup_id` (`virtuemart_shoppergroup_id`),
  KEY `product_price_publish_up` (`product_price_publish_up`),
  KEY `product_price_publish_down` (`product_price_publish_down`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Holds price records for a product';

-- ----------------------------
-- Records of wy587_virtuemart_product_prices
-- ----------------------------
INSERT INTO `wy587_virtuemart_product_prices` VALUES ('1', '1', '0', '1000.000000', '0', '0.00000', '-1', '0', '144', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0', '0', '2014-12-31 05:40:26', '436', '2014-12-31 05:40:26', '436', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_product_shoppergroups`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_product_shoppergroups`;
CREATE TABLE `wy587_virtuemart_product_shoppergroups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_product_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_shoppergroup_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_product_id` (`virtuemart_product_id`,`virtuemart_shoppergroup_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Maps Products to Categories';

-- ----------------------------
-- Records of wy587_virtuemart_product_shoppergroups
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_ratings`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_ratings`;
CREATE TABLE `wy587_virtuemart_ratings` (
  `virtuemart_rating_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_product_id` int(1) unsigned NOT NULL DEFAULT '0',
  `rates` int(11) NOT NULL DEFAULT '0',
  `ratingcount` int(1) unsigned NOT NULL DEFAULT '0',
  `rating` decimal(10,1) NOT NULL DEFAULT '0.0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_rating_id`),
  UNIQUE KEY `virtuemart_product_id` (`virtuemart_product_id`,`virtuemart_rating_id`),
  KEY `published` (`published`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all ratings for a product';

-- ----------------------------
-- Records of wy587_virtuemart_ratings
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_rating_reviews`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_rating_reviews`;
CREATE TABLE `wy587_virtuemart_rating_reviews` (
  `virtuemart_rating_review_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_product_id` int(1) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(18000) DEFAULT NULL,
  `review_ok` tinyint(1) NOT NULL DEFAULT '0',
  `review_rates` int(1) unsigned NOT NULL DEFAULT '0',
  `review_ratingcount` int(1) unsigned NOT NULL DEFAULT '0',
  `review_rating` decimal(10,2) NOT NULL DEFAULT '0.00',
  `review_editable` tinyint(1) NOT NULL DEFAULT '1',
  `lastip` char(50) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_rating_review_id`),
  UNIQUE KEY `virtuemart_product_id` (`virtuemart_product_id`,`created_by`),
  KEY `published` (`published`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_rating_reviews
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_rating_votes`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_rating_votes`;
CREATE TABLE `wy587_virtuemart_rating_votes` (
  `virtuemart_rating_vote_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_product_id` int(1) unsigned NOT NULL DEFAULT '0',
  `vote` int(11) NOT NULL DEFAULT '0',
  `lastip` char(50) NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_rating_vote_id`),
  UNIQUE KEY `virtuemart_product_id` (`virtuemart_product_id`,`created_by`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all ratings for a product';

-- ----------------------------
-- Records of wy587_virtuemart_rating_votes
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_shipmentmethods`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_shipmentmethods`;
CREATE TABLE `wy587_virtuemart_shipmentmethods` (
  `virtuemart_shipmentmethod_id` mediumint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(11) NOT NULL DEFAULT '1',
  `shipment_jplugin_id` int(11) NOT NULL DEFAULT '0',
  `shipment_element` char(50) NOT NULL DEFAULT '',
  `shipment_params` varchar(19000) NOT NULL DEFAULT '',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_shipmentmethod_id`),
  KEY `shipment_jplugin_id` (`shipment_jplugin_id`),
  KEY `shipment_element` (`shipment_element`,`virtuemart_vendor_id`),
  KEY `ordering` (`ordering`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Shipment created from the shipment plugins';

-- ----------------------------
-- Records of wy587_virtuemart_shipmentmethods
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_shipmentmethods_ru_ru`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_shipmentmethods_ru_ru`;
CREATE TABLE `wy587_virtuemart_shipmentmethods_ru_ru` (
  `virtuemart_shipmentmethod_id` int(1) unsigned NOT NULL,
  `shipment_name` char(180) NOT NULL DEFAULT '',
  `shipment_desc` varchar(19000) NOT NULL DEFAULT '',
  `slug` char(192) NOT NULL DEFAULT '',
  PRIMARY KEY (`virtuemart_shipmentmethod_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_shipmentmethods_ru_ru
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_shipmentmethod_shoppergroups`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_shipmentmethod_shoppergroups`;
CREATE TABLE `wy587_virtuemart_shipmentmethod_shoppergroups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_shipmentmethod_id` mediumint(1) unsigned DEFAULT NULL,
  `virtuemart_shoppergroup_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_shipmentmethod_id` (`virtuemart_shipmentmethod_id`,`virtuemart_shoppergroup_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='xref table for shipment to shoppergroup';

-- ----------------------------
-- Records of wy587_virtuemart_shipmentmethod_shoppergroups
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_shoppergroups`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_shoppergroups`;
CREATE TABLE `wy587_virtuemart_shoppergroups` (
  `virtuemart_shoppergroup_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(11) NOT NULL DEFAULT '1',
  `shopper_group_name` char(128) DEFAULT NULL,
  `shopper_group_desc` char(255) DEFAULT NULL,
  `custom_price_display` tinyint(1) NOT NULL DEFAULT '0',
  `price_display` blob NOT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `sgrp_additional` tinyint(1) NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_shoppergroup_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `shopper_group_name` (`shopper_group_name`),
  KEY `ordering` (`ordering`),
  KEY `shared` (`shared`),
  KEY `published` (`published`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Shopper Groups that users can be assigned to';

-- ----------------------------
-- Records of wy587_virtuemart_shoppergroups
-- ----------------------------
INSERT INTO `wy587_virtuemart_shoppergroups` VALUES ('2', '1', 'COM_VIRTUEMART_SHOPPERGROUP_DEFAULT', 'COM_VIRTUEMART_SHOPPERGROUP_DEFAULT_TIP', '0', '', '1', '0', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_shoppergroups` VALUES ('1', '1', 'COM_VIRTUEMART_SHOPPERGROUP_GUEST', 'COM_VIRTUEMART_SHOPPERGROUP_GUEST_TIP', '0', '', '2', '0', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_states`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_states`;
CREATE TABLE `wy587_virtuemart_states` (
  `virtuemart_state_id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '1',
  `virtuemart_country_id` smallint(1) unsigned NOT NULL DEFAULT '1',
  `virtuemart_worldzone_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `state_name` char(64) DEFAULT NULL,
  `state_3_code` char(3) DEFAULT NULL,
  `state_2_code` char(2) DEFAULT NULL,
  `ordering` int(2) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_state_id`),
  UNIQUE KEY `state_3_code` (`virtuemart_vendor_id`,`virtuemart_country_id`,`state_3_code`),
  UNIQUE KEY `state_2_code` (`virtuemart_vendor_id`,`virtuemart_country_id`,`state_2_code`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `virtuemart_country_id` (`virtuemart_country_id`),
  KEY `ordering` (`ordering`),
  KEY `shared` (`shared`),
  KEY `published` (`published`)
) ENGINE=MyISAM AUTO_INCREMENT=730 DEFAULT CHARSET=utf8 COMMENT='States that are assigned to a country';

-- ----------------------------
-- Records of wy587_virtuemart_states
-- ----------------------------
INSERT INTO `wy587_virtuemart_states` VALUES ('1', '1', '223', '0', 'Alabama', 'ALA', 'AL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('2', '1', '223', '0', 'Alaska', 'ALK', 'AK', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('3', '1', '223', '0', 'Arizona', 'ARZ', 'AZ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('4', '1', '223', '0', 'Arkansas', 'ARK', 'AR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('5', '1', '223', '0', 'California', 'CAL', 'CA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('6', '1', '223', '0', 'Colorado', 'COL', 'CO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('7', '1', '223', '0', 'Connecticut', 'CCT', 'CT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('8', '1', '223', '0', 'Delaware', 'DEL', 'DE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('9', '1', '223', '0', 'District Of Columbia', 'DOC', 'DC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('10', '1', '223', '0', 'Florida', 'FLO', 'FL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('11', '1', '223', '0', 'Georgia', 'GEA', 'GA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('12', '1', '223', '0', 'Hawaii', 'HWI', 'HI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('13', '1', '223', '0', 'Idaho', 'IDA', 'ID', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('14', '1', '223', '0', 'Illinois', 'ILL', 'IL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('15', '1', '223', '0', 'Indiana', 'IND', 'IN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('16', '1', '223', '0', 'Iowa', 'IOA', 'IA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('17', '1', '223', '0', 'Kansas', 'KAS', 'KS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('18', '1', '223', '0', 'Kentucky', 'KTY', 'KY', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('19', '1', '223', '0', 'Louisiana', 'LOA', 'LA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('20', '1', '223', '0', 'Maine', 'MAI', 'ME', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('21', '1', '223', '0', 'Maryland', 'MLD', 'MD', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('22', '1', '223', '0', 'Massachusetts', 'MSA', 'MA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('23', '1', '223', '0', 'Michigan', 'MIC', 'MI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('24', '1', '223', '0', 'Minnesota', 'MIN', 'MN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('25', '1', '223', '0', 'Mississippi', 'MIS', 'MS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('26', '1', '223', '0', 'Missouri', 'MIO', 'MO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('27', '1', '223', '0', 'Montana', 'MOT', 'MT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('28', '1', '223', '0', 'Nebraska', 'NEB', 'NE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('29', '1', '223', '0', 'Nevada', 'NEV', 'NV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('30', '1', '223', '0', 'New Hampshire', 'NEH', 'NH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('31', '1', '223', '0', 'New Jersey', 'NEJ', 'NJ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('32', '1', '223', '0', 'New Mexico', 'NEM', 'NM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('33', '1', '223', '0', 'New York', 'NEY', 'NY', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('34', '1', '223', '0', 'North Carolina', 'NOC', 'NC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('35', '1', '223', '0', 'North Dakota', 'NOD', 'ND', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('36', '1', '223', '0', 'Ohio', 'OHI', 'OH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('37', '1', '223', '0', 'Oklahoma', 'OKL', 'OK', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('38', '1', '223', '0', 'Oregon', 'ORN', 'OR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('39', '1', '223', '0', 'Pennsylvania', 'PEA', 'PA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('40', '1', '223', '0', 'Rhode Island', 'RHI', 'RI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('41', '1', '223', '0', 'South Carolina', 'SOC', 'SC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('42', '1', '223', '0', 'South Dakota', 'SOD', 'SD', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('43', '1', '223', '0', 'Tennessee', 'TEN', 'TN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('44', '1', '223', '0', 'Texas', 'TXS', 'TX', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('45', '1', '223', '0', 'Utah', 'UTA', 'UT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('46', '1', '223', '0', 'Vermont', 'VMT', 'VT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('47', '1', '223', '0', 'Virginia', 'VIA', 'VA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('48', '1', '223', '0', 'Washington', 'WAS', 'WA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('49', '1', '223', '0', 'West Virginia', 'WEV', 'WV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('50', '1', '223', '0', 'Wisconsin', 'WIS', 'WI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('51', '1', '223', '0', 'Wyoming', 'WYO', 'WY', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('52', '1', '38', '0', 'Alberta', 'ALB', 'AB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('53', '1', '38', '0', 'British Columbia', 'BRC', 'BC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('54', '1', '38', '0', 'Manitoba', 'MAB', 'MB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('55', '1', '38', '0', 'New Brunswick', 'NEB', 'NB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('56', '1', '38', '0', 'Newfoundland and Labrador', 'NFL', 'NL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('57', '1', '38', '0', 'Northwest Territories', 'NWT', 'NT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('58', '1', '38', '0', 'Nova Scotia', 'NOS', 'NS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('59', '1', '38', '0', 'Nunavut', 'NUT', 'NU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('60', '1', '38', '0', 'Ontario', 'ONT', 'ON', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('61', '1', '38', '0', 'Prince Edward Island', 'PEI', 'PE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('62', '1', '38', '0', 'Quebec', 'QEC', 'QC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('63', '1', '38', '0', 'Saskatchewan', 'SAK', 'SK', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('64', '1', '38', '0', 'Yukon', 'YUT', 'YT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('65', '1', '222', '0', 'England', 'ENG', 'EN', '0', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('66', '1', '222', '0', 'Northern Ireland', 'NOI', 'NI', '0', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('67', '1', '222', '0', 'Scotland', 'SCO', 'SD', '0', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('68', '1', '222', '0', 'Wales', 'WLS', 'WS', '0', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('69', '1', '13', '0', 'Australian Capital Territory', 'ACT', 'AC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('70', '1', '13', '0', 'New South Wales', 'NSW', 'NS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('71', '1', '13', '0', 'Northern Territory', 'NOT', 'NT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('72', '1', '13', '0', 'Queensland', 'QLD', 'QL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('73', '1', '13', '0', 'South Australia', 'SOA', 'SA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('74', '1', '13', '0', 'Tasmania', 'TAS', 'TS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('75', '1', '13', '0', 'Victoria', 'VIC', 'VI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('76', '1', '13', '0', 'Western Australia', 'WEA', 'WA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('77', '1', '138', '0', 'Aguascalientes', 'AGS', 'AG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('78', '1', '138', '0', 'Baja California Norte', 'BCN', 'BN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('79', '1', '138', '0', 'Baja California Sur', 'BCS', 'BS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('80', '1', '138', '0', 'Campeche', 'CAM', 'CA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('81', '1', '138', '0', 'Chiapas', 'CHI', 'CS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('82', '1', '138', '0', 'Chihuahua', 'CHA', 'CH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('83', '1', '138', '0', 'Coahuila', 'COA', 'CO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('84', '1', '138', '0', 'Colima', 'COL', 'CM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('85', '1', '138', '0', 'Distrito Federal', 'DFM', 'DF', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('86', '1', '138', '0', 'Durango', 'DGO', 'DO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('87', '1', '138', '0', 'Guanajuato', 'GTO', 'GO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('88', '1', '138', '0', 'Guerrero', 'GRO', 'GU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('89', '1', '138', '0', 'Hidalgo', 'HGO', 'HI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('90', '1', '138', '0', 'Jalisco', 'JAL', 'JA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('91', '1', '138', '0', 'M', 'EDM', 'EM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('92', '1', '138', '0', 'Michoac', 'MCN', 'MI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('93', '1', '138', '0', 'Morelos', 'MOR', 'MO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('94', '1', '138', '0', 'Nayarit', 'NAY', 'NY', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('95', '1', '138', '0', 'Nuevo Le', 'NUL', 'NL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('96', '1', '138', '0', 'Oaxaca', 'OAX', 'OA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('97', '1', '138', '0', 'Puebla', 'PUE', 'PU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('98', '1', '138', '0', 'Quer', 'QRO', 'QU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('99', '1', '138', '0', 'Quintana Roo', 'QUR', 'QR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('100', '1', '138', '0', 'San Luis Potos', 'SLP', 'SP', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('101', '1', '138', '0', 'Sinaloa', 'SIN', 'SI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('102', '1', '138', '0', 'Sonora', 'SON', 'SO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('103', '1', '138', '0', 'Tabasco', 'TAB', 'TA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('104', '1', '138', '0', 'Tamaulipas', 'TAM', 'TM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('105', '1', '138', '0', 'Tlaxcala', 'TLX', 'TX', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('106', '1', '138', '0', 'Veracruz', 'VER', 'VZ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('107', '1', '138', '0', 'Yucat', 'YUC', 'YU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('108', '1', '138', '0', 'Zacatecas', 'ZAC', 'ZA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('109', '1', '30', '0', 'Acre', 'ACR', 'AC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('110', '1', '30', '0', 'Alagoas', 'ALG', 'AL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('111', '1', '30', '0', 'Amapá', 'AMP', 'AP', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('112', '1', '30', '0', 'Amazonas', 'AMZ', 'AM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('113', '1', '30', '0', 'Bahía', 'BAH', 'BA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('114', '1', '30', '0', 'Ceará', 'CEA', 'CE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('115', '1', '30', '0', 'Distrito Federal', 'DFB', 'DF', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('116', '1', '30', '0', 'Espírito Santo', 'ESS', 'ES', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('117', '1', '30', '0', 'Goiás', 'GOI', 'GO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('118', '1', '30', '0', 'Maranhão', 'MAR', 'MA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('119', '1', '30', '0', 'Mato Grosso', 'MAT', 'MT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('120', '1', '30', '0', 'Mato Grosso do Sul', 'MGS', 'MS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('121', '1', '30', '0', 'Minas Gerais', 'MIG', 'MG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('122', '1', '30', '0', 'Paraná', 'PAR', 'PR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('123', '1', '30', '0', 'Paraíba', 'PRB', 'PB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('124', '1', '30', '0', 'Pará', 'PAB', 'PA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('125', '1', '30', '0', 'Pernambuco', 'PER', 'PE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('126', '1', '30', '0', 'Piauí', 'PIA', 'PI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('127', '1', '30', '0', 'Rio Grande do Norte', 'RGN', 'RN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('128', '1', '30', '0', 'Rio Grande do Sul', 'RGS', 'RS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('129', '1', '30', '0', 'Rio de Janeiro', 'RDJ', 'RJ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('130', '1', '30', '0', 'Rondônia', 'RON', 'RO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('131', '1', '30', '0', 'Roraima', 'ROR', 'RR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('132', '1', '30', '0', 'Santa Catarina', 'SAC', 'SC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('133', '1', '30', '0', 'Sergipe', 'SER', 'SE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('134', '1', '30', '0', 'São Paulo', 'SAP', 'SP', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('135', '1', '30', '0', 'Tocantins', 'TOC', 'TO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('136', '1', '44', '0', 'Anhui', 'ANH', '34', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('137', '1', '44', '0', 'Beijing', 'BEI', '11', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('138', '1', '44', '0', 'Chongqing', 'CHO', '50', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('139', '1', '44', '0', 'Fujian', 'FUJ', '35', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('140', '1', '44', '0', 'Gansu', 'GAN', '62', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('141', '1', '44', '0', 'Guangdong', 'GUA', '44', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('142', '1', '44', '0', 'Guangxi Zhuang', 'GUZ', '45', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('143', '1', '44', '0', 'Guizhou', 'GUI', '52', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('144', '1', '44', '0', 'Hainan', 'HAI', '46', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('145', '1', '44', '0', 'Hebei', 'HEB', '13', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('146', '1', '44', '0', 'Heilongjiang', 'HEI', '23', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('147', '1', '44', '0', 'Henan', 'HEN', '41', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('148', '1', '44', '0', 'Hubei', 'HUB', '42', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('149', '1', '44', '0', 'Hunan', 'HUN', '43', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('150', '1', '44', '0', 'Jiangsu', 'JIA', '32', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('151', '1', '44', '0', 'Jiangxi', 'JIX', '36', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('152', '1', '44', '0', 'Jilin', 'JIL', '22', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('153', '1', '44', '0', 'Liaoning', 'LIA', '21', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('154', '1', '44', '0', 'Nei Mongol', 'NML', '15', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('155', '1', '44', '0', 'Ningxia Hui', 'NIH', '64', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('156', '1', '44', '0', 'Qinghai', 'QIN', '63', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('157', '1', '44', '0', 'Shandong', 'SNG', '37', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('158', '1', '44', '0', 'Shanghai', 'SHH', '31', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('159', '1', '44', '0', 'Shaanxi', 'SHX', '61', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('160', '1', '44', '0', 'Sichuan', 'SIC', '51', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('161', '1', '44', '0', 'Tianjin', 'TIA', '12', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('162', '1', '44', '0', 'Xinjiang Uygur', 'XIU', '65', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('163', '1', '44', '0', 'Xizang', 'XIZ', '54', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('164', '1', '44', '0', 'Yunnan', 'YUN', '53', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('165', '1', '44', '0', 'Zhejiang', 'ZHE', '33', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('166', '1', '104', '0', 'Israel', 'ISL', 'IL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('167', '1', '104', '0', 'Gaza Strip', 'GZS', 'GZ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('168', '1', '104', '0', 'West Bank', 'WBK', 'WB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('169', '1', '151', '0', 'St. Maarten', 'STM', 'SM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('170', '1', '151', '0', 'Bonaire', 'BNR', 'BN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('171', '1', '151', '0', 'Curacao', 'CUR', 'CR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('172', '1', '175', '0', 'Alba', 'ABA', 'AB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('173', '1', '175', '0', 'Arad', 'ARD', 'AR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('174', '1', '175', '0', 'Arges', 'ARG', 'AG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('175', '1', '175', '0', 'Bacau', 'BAC', 'BC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('176', '1', '175', '0', 'Bihor', 'BIH', 'BH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('177', '1', '175', '0', 'Bistrita-Nasaud', 'BIS', 'BN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('178', '1', '175', '0', 'Botosani', 'BOT', 'BT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('179', '1', '175', '0', 'Braila', 'BRL', 'BR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('180', '1', '175', '0', 'Brasov', 'BRA', 'BV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('181', '1', '175', '0', 'Bucuresti', 'BUC', 'B', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('182', '1', '175', '0', 'Buzau', 'BUZ', 'BZ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('183', '1', '175', '0', 'Calarasi', 'CAL', 'CL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('184', '1', '175', '0', 'Caras Severin', 'CRS', 'CS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('185', '1', '175', '0', 'Cluj', 'CLJ', 'CJ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('186', '1', '175', '0', 'Constanta', 'CST', 'CT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('187', '1', '175', '0', 'Covasna', 'COV', 'CV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('188', '1', '175', '0', 'Dambovita', 'DAM', 'DB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('189', '1', '175', '0', 'Dolj', 'DLJ', 'DJ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('190', '1', '175', '0', 'Galati', 'GAL', 'GL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('191', '1', '175', '0', 'Giurgiu', 'GIU', 'GR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('192', '1', '175', '0', 'Gorj', 'GOR', 'GJ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('193', '1', '175', '0', 'Hargita', 'HRG', 'HR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('194', '1', '175', '0', 'Hunedoara', 'HUN', 'HD', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('195', '1', '175', '0', 'Ialomita', 'IAL', 'IL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('196', '1', '175', '0', 'Iasi', 'IAS', 'IS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('197', '1', '175', '0', 'Ilfov', 'ILF', 'IF', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('198', '1', '175', '0', 'Maramures', 'MAR', 'MM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('199', '1', '175', '0', 'Mehedinti', 'MEH', 'MH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('200', '1', '175', '0', 'Mures', 'MUR', 'MS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('201', '1', '175', '0', 'Neamt', 'NEM', 'NT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('202', '1', '175', '0', 'Olt', 'OLT', 'OT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('203', '1', '175', '0', 'Prahova', 'PRA', 'PH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('204', '1', '175', '0', 'Salaj', 'SAL', 'SJ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('205', '1', '175', '0', 'Satu Mare', 'SAT', 'SM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('206', '1', '175', '0', 'Sibiu', 'SIB', 'SB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('207', '1', '175', '0', 'Suceava', 'SUC', 'SV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('208', '1', '175', '0', 'Teleorman', 'TEL', 'TR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('209', '1', '175', '0', 'Timis', 'TIM', 'TM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('210', '1', '175', '0', 'Tulcea', 'TUL', 'TL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('211', '1', '175', '0', 'Valcea', 'VAL', 'VL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('212', '1', '175', '0', 'Vaslui', 'VAS', 'VS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('213', '1', '175', '0', 'Vrancea', 'VRA', 'VN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('214', '1', '105', '0', 'Agrigento', 'AGR', 'AG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('215', '1', '105', '0', 'Alessandria', 'ALE', 'AL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('216', '1', '105', '0', 'Ancona', 'ANC', 'AN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('217', '1', '105', '0', 'Aosta', 'AOS', 'AO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('218', '1', '105', '0', 'Arezzo', 'ARE', 'AR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('219', '1', '105', '0', 'Ascoli Piceno', 'API', 'AP', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('220', '1', '105', '0', 'Asti', 'AST', 'AT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('221', '1', '105', '0', 'Avellino', 'AVE', 'AV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('222', '1', '105', '0', 'Bari', 'BAR', 'BA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('223', '1', '105', '0', 'Belluno', 'BEL', 'BL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('224', '1', '105', '0', 'Benevento', 'BEN', 'BN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('225', '1', '105', '0', 'Bergamo', 'BEG', 'BG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('226', '1', '105', '0', 'Biella', 'BIE', 'BI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('227', '1', '105', '0', 'Bologna', 'BOL', 'BO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('228', '1', '105', '0', 'Bolzano', 'BOZ', 'BZ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('229', '1', '105', '0', 'Brescia', 'BRE', 'BS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('230', '1', '105', '0', 'Brindisi', 'BRI', 'BR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('231', '1', '105', '0', 'Cagliari', 'CAG', 'CA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('232', '1', '105', '0', 'Caltanissetta', 'CAL', 'CL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('233', '1', '105', '0', 'Campobasso', 'CBO', 'CB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('234', '1', '105', '0', 'Carbonia-Iglesias', 'CAR', 'CI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('235', '1', '105', '0', 'Caserta', 'CAS', 'CE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('236', '1', '105', '0', 'Catania', 'CAT', 'CT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('237', '1', '105', '0', 'Catanzaro', 'CTZ', 'CZ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('238', '1', '105', '0', 'Chieti', 'CHI', 'CH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('239', '1', '105', '0', 'Como', 'COM', 'CO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('240', '1', '105', '0', 'Cosenza', 'COS', 'CS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('241', '1', '105', '0', 'Cremona', 'CRE', 'CR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('242', '1', '105', '0', 'Crotone', 'CRO', 'KR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('243', '1', '105', '0', 'Cuneo', 'CUN', 'CN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('244', '1', '105', '0', 'Enna', 'ENN', 'EN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('245', '1', '105', '0', 'Ferrara', 'FER', 'FE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('246', '1', '105', '0', 'Firenze', 'FIR', 'FI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('247', '1', '105', '0', 'Foggia', 'FOG', 'FG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('248', '1', '105', '0', 'Forli-Cesena', 'FOC', 'FC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('249', '1', '105', '0', 'Frosinone', 'FRO', 'FR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('250', '1', '105', '0', 'Genova', 'GEN', 'GE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('251', '1', '105', '0', 'Gorizia', 'GOR', 'GO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('252', '1', '105', '0', 'Grosseto', 'GRO', 'GR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('253', '1', '105', '0', 'Imperia', 'IMP', 'IM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('254', '1', '105', '0', 'Isernia', 'ISE', 'IS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('255', '1', '105', '0', 'L\'Aquila', 'AQU', 'AQ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('256', '1', '105', '0', 'La Spezia', 'LAS', 'SP', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('257', '1', '105', '0', 'Latina', 'LAT', 'LT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('258', '1', '105', '0', 'Lecce', 'LEC', 'LE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('259', '1', '105', '0', 'Lecco', 'LCC', 'LC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('260', '1', '105', '0', 'Livorno', 'LIV', 'LI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('261', '1', '105', '0', 'Lodi', 'LOD', 'LO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('262', '1', '105', '0', 'Lucca', 'LUC', 'LU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('263', '1', '105', '0', 'Macerata', 'MAC', 'MC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('264', '1', '105', '0', 'Mantova', 'MAN', 'MN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('265', '1', '105', '0', 'Massa-Carrara', 'MAS', 'MS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('266', '1', '105', '0', 'Matera', 'MAA', 'MT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('267', '1', '105', '0', 'Medio Campidano', 'MED', 'VS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('268', '1', '105', '0', 'Messina', 'MES', 'ME', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('269', '1', '105', '0', 'Milano', 'MIL', 'MI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('270', '1', '105', '0', 'Modena', 'MOD', 'MO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('271', '1', '105', '0', 'Napoli', 'NAP', 'NA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('272', '1', '105', '0', 'Novara', 'NOV', 'NO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('273', '1', '105', '0', 'Nuoro', 'NUR', 'NU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('274', '1', '105', '0', 'Ogliastra', 'OGL', 'OG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('275', '1', '105', '0', 'Olbia-Tempio', 'OLB', 'OT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('276', '1', '105', '0', 'Oristano', 'ORI', 'OR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('277', '1', '105', '0', 'Padova', 'PDA', 'PD', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('278', '1', '105', '0', 'Palermo', 'PAL', 'PA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('279', '1', '105', '0', 'Parma', 'PAA', 'PR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('280', '1', '105', '0', 'Pavia', 'PAV', 'PV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('281', '1', '105', '0', 'Perugia', 'PER', 'PG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('282', '1', '105', '0', 'Pesaro e Urbino', 'PES', 'PU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('283', '1', '105', '0', 'Pescara', 'PSC', 'PE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('284', '1', '105', '0', 'Piacenza', 'PIA', 'PC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('285', '1', '105', '0', 'Pisa', 'PIS', 'PI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('286', '1', '105', '0', 'Pistoia', 'PIT', 'PT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('287', '1', '105', '0', 'Pordenone', 'POR', 'PN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('288', '1', '105', '0', 'Potenza', 'PTZ', 'PZ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('289', '1', '105', '0', 'Prato', 'PRA', 'PO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('290', '1', '105', '0', 'Ragusa', 'RAG', 'RG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('291', '1', '105', '0', 'Ravenna', 'RAV', 'RA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('292', '1', '105', '0', 'Reggio Calabria', 'REG', 'RC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('293', '1', '105', '0', 'Reggio Emilia', 'REE', 'RE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('294', '1', '105', '0', 'Rieti', 'RIE', 'RI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('295', '1', '105', '0', 'Rimini', 'RIM', 'RN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('296', '1', '105', '0', 'Roma', 'ROM', 'RM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('297', '1', '105', '0', 'Rovigo', 'ROV', 'RO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('298', '1', '105', '0', 'Salerno', 'SAL', 'SA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('299', '1', '105', '0', 'Sassari', 'SAS', 'SS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('300', '1', '105', '0', 'Savona', 'SAV', 'SV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('301', '1', '105', '0', 'Siena', 'SIE', 'SI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('302', '1', '105', '0', 'Siracusa', 'SIR', 'SR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('303', '1', '105', '0', 'Sondrio', 'SOO', 'SO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('304', '1', '105', '0', 'Taranto', 'TAR', 'TA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('305', '1', '105', '0', 'Teramo', 'TER', 'TE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('306', '1', '105', '0', 'Terni', 'TRN', 'TR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('307', '1', '105', '0', 'Torino', 'TOR', 'TO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('308', '1', '105', '0', 'Trapani', 'TRA', 'TP', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('309', '1', '105', '0', 'Trento', 'TRE', 'TN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('310', '1', '105', '0', 'Treviso', 'TRV', 'TV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('311', '1', '105', '0', 'Trieste', 'TRI', 'TS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('312', '1', '105', '0', 'Udine', 'UDI', 'UD', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('313', '1', '105', '0', 'Varese', 'VAR', 'VA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('314', '1', '105', '0', 'Venezia', 'VEN', 'VE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('315', '1', '105', '0', 'Verbano Cusio Ossola', 'VCO', 'VB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('316', '1', '105', '0', 'Vercelli', 'VER', 'VC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('317', '1', '105', '0', 'Verona', 'VRN', 'VR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('318', '1', '105', '0', 'Vibo Valenzia', 'VIV', 'VV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('319', '1', '105', '0', 'Vicenza', 'VII', 'VI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('320', '1', '105', '0', 'Viterbo', 'VIT', 'VT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('321', '1', '195', '0', 'A Coru', 'ACO', '15', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('322', '1', '195', '0', 'Alava', 'ALA', '01', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('323', '1', '195', '0', 'Albacete', 'ALB', '02', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('324', '1', '195', '0', 'Alicante', 'ALI', '03', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('325', '1', '195', '0', 'Almeria', 'ALM', '04', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('326', '1', '195', '0', 'Asturias', 'AST', '33', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('327', '1', '195', '0', 'Avila', 'AVI', '05', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('328', '1', '195', '0', 'Badajoz', 'BAD', '06', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('329', '1', '195', '0', 'Baleares', 'BAL', '07', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('330', '1', '195', '0', 'Barcelona', 'BAR', '08', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('331', '1', '195', '0', 'Burgos', 'BUR', '09', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('332', '1', '195', '0', 'Caceres', 'CAC', '10', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('333', '1', '195', '0', 'Cadiz', 'CAD', '11', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('334', '1', '195', '0', 'Cantabria', 'CAN', '39', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('335', '1', '195', '0', 'Castellon', 'CAS', '12', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('336', '1', '195', '0', 'Ceuta', 'CEU', '51', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('337', '1', '195', '0', 'Ciudad Real', 'CIU', '13', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('338', '1', '195', '0', 'Cordoba', 'COR', '14', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('339', '1', '195', '0', 'Cuenca', 'CUE', '16', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('340', '1', '195', '0', 'Girona', 'GIR', '17', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('341', '1', '195', '0', 'Granada', 'GRA', '18', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('342', '1', '195', '0', 'Guadalajara', 'GUA', '19', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('343', '1', '195', '0', 'Guipuzcoa', 'GUI', '20', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('344', '1', '195', '0', 'Huelva', 'HUL', '21', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('345', '1', '195', '0', 'Huesca', 'HUS', '22', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('346', '1', '195', '0', 'Jaen', 'JAE', '23', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('347', '1', '195', '0', 'La Rioja', 'LRI', '26', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('348', '1', '195', '0', 'Las Palmas', 'LPA', '35', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('349', '1', '195', '0', 'Leon', 'LEO', '24', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('350', '1', '195', '0', 'Lleida', 'LLE', '25', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('351', '1', '195', '0', 'Lugo', 'LUG', '27', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('352', '1', '195', '0', 'Madrid', 'MAD', '28', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('353', '1', '195', '0', 'Malaga', 'MAL', '29', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('354', '1', '195', '0', 'Melilla', 'MEL', '52', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('355', '1', '195', '0', 'Murcia', 'MUR', '30', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('356', '1', '195', '0', 'Navarra', 'NAV', '31', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('357', '1', '195', '0', 'Ourense', 'OUR', '32', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('358', '1', '195', '0', 'Palencia', 'PAL', '34', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('359', '1', '195', '0', 'Pontevedra', 'PON', '36', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('360', '1', '195', '0', 'Salamanca', 'SAL', '37', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('361', '1', '195', '0', 'Santa Cruz de Tenerife', 'SCT', '38', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('362', '1', '195', '0', 'Segovia', 'SEG', '40', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('363', '1', '195', '0', 'Sevilla', 'SEV', '41', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('364', '1', '195', '0', 'Soria', 'SOR', '42', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('365', '1', '195', '0', 'Tarragona', 'TAR', '43', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('366', '1', '195', '0', 'Teruel', 'TER', '44', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('367', '1', '195', '0', 'Toledo', 'TOL', '45', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('368', '1', '195', '0', 'Valencia', 'VAL', '46', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('369', '1', '195', '0', 'Valladolid', 'VLL', '47', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('370', '1', '195', '0', 'Vizcaya', 'VIZ', '48', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('371', '1', '195', '0', 'Zamora', 'ZAM', '49', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('372', '1', '195', '0', 'Zaragoza', 'ZAR', '50', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('373', '1', '10', '0', 'Buenos Aires', 'BAS', 'BA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('374', '1', '10', '0', 'Ciudad Autonoma De Buenos Aires', 'CBA', 'CB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('375', '1', '10', '0', 'Catamarca', 'CAT', 'CA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('376', '1', '10', '0', 'Chaco', 'CHO', 'CH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('377', '1', '10', '0', 'Chubut', 'CTT', 'CT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('378', '1', '10', '0', 'Cordoba', 'COD', 'CO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('379', '1', '10', '0', 'Corrientes', 'CRI', 'CR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('380', '1', '10', '0', 'Entre Rios', 'ERS', 'ER', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('381', '1', '10', '0', 'Formosa', 'FRM', 'FR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('382', '1', '10', '0', 'Jujuy', 'JUJ', 'JU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('383', '1', '10', '0', 'La Pampa', 'LPM', 'LP', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('384', '1', '10', '0', 'La Rioja', 'LRI', 'LR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('385', '1', '10', '0', 'Mendoza', 'MED', 'ME', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('386', '1', '10', '0', 'Misiones', 'MIS', 'MI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('387', '1', '10', '0', 'Neuquen', 'NQU', 'NQ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('388', '1', '10', '0', 'Rio Negro', 'RNG', 'RN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('389', '1', '10', '0', 'Salta', 'SAL', 'SA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('390', '1', '10', '0', 'San Juan', 'SJN', 'SJ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('391', '1', '10', '0', 'San Luis', 'SLU', 'SL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('392', '1', '10', '0', 'Santa Cruz', 'SCZ', 'SC', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('393', '1', '10', '0', 'Santa Fe', 'SFE', 'SF', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('394', '1', '10', '0', 'Santiago Del Estero', 'SEN', 'SE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('395', '1', '10', '0', 'Tierra Del Fuego', 'TFE', 'TF', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('396', '1', '10', '0', 'Tucuman', 'TUC', 'TU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('397', '1', '11', '0', 'Aragatsotn', 'ARG', 'AG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('398', '1', '11', '0', 'Ararat', 'ARR', 'AR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('399', '1', '11', '0', 'Armavir', 'ARM', 'AV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('400', '1', '11', '0', 'Gegharkunik', 'GEG', 'GR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('401', '1', '11', '0', 'Kotayk', 'KOT', 'KT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('402', '1', '11', '0', 'Lori', 'LOR', 'LO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('403', '1', '11', '0', 'Shirak', 'SHI', 'SH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('404', '1', '11', '0', 'Syunik', 'SYU', 'SU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('405', '1', '11', '0', 'Tavush', 'TAV', 'TV', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('406', '1', '11', '0', 'Vayots-Dzor', 'VAD', 'VD', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('407', '1', '11', '0', 'Yerevan', 'YER', 'ER', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('408', '1', '99', '0', 'Andaman & Nicobar Islands', 'ANI', 'AI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('409', '1', '99', '0', 'Andhra Pradesh', 'AND', 'AN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('410', '1', '99', '0', 'Arunachal Pradesh', 'ARU', 'AR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('411', '1', '99', '0', 'Assam', 'ASS', 'AS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('412', '1', '99', '0', 'Bihar', 'BIH', 'BI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('413', '1', '99', '0', 'Chandigarh', 'CHA', 'CA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('414', '1', '99', '0', 'Chhatisgarh', 'CHH', 'CH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('415', '1', '99', '0', 'Dadra & Nagar Haveli', 'DAD', 'DD', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('416', '1', '99', '0', 'Daman & Diu', 'DAM', 'DA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('417', '1', '99', '0', 'Delhi', 'DEL', 'DE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('418', '1', '99', '0', 'Goa', 'GOA', 'GO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('419', '1', '99', '0', 'Gujarat', 'GUJ', 'GU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('420', '1', '99', '0', 'Haryana', 'HAR', 'HA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('421', '1', '99', '0', 'Himachal Pradesh', 'HIM', 'HI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('422', '1', '99', '0', 'Jammu & Kashmir', 'JAM', 'JA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('423', '1', '99', '0', 'Jharkhand', 'JHA', 'JH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('424', '1', '99', '0', 'Karnataka', 'KAR', 'KA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('425', '1', '99', '0', 'Kerala', 'KER', 'KE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('426', '1', '99', '0', 'Lakshadweep', 'LAK', 'LA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('427', '1', '99', '0', 'Madhya Pradesh', 'MAD', 'MD', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('428', '1', '99', '0', 'Maharashtra', 'MAH', 'MH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('429', '1', '99', '0', 'Manipur', 'MAN', 'MN', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('430', '1', '99', '0', 'Meghalaya', 'MEG', 'ME', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('431', '1', '99', '0', 'Mizoram', 'MIZ', 'MI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('432', '1', '99', '0', 'Nagaland', 'NAG', 'NA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('433', '1', '99', '0', 'Orissa', 'ORI', 'OR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('434', '1', '99', '0', 'Pondicherry', 'PON', 'PO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('435', '1', '99', '0', 'Punjab', 'PUN', 'PU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('436', '1', '99', '0', 'Rajasthan', 'RAJ', 'RA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('437', '1', '99', '0', 'Sikkim', 'SIK', 'SI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('438', '1', '99', '0', 'Tamil Nadu', 'TAM', 'TA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('439', '1', '99', '0', 'Tripura', 'TRI', 'TR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('440', '1', '99', '0', 'Uttaranchal', 'UAR', 'UA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('441', '1', '99', '0', 'Uttar Pradesh', 'UTT', 'UT', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('442', '1', '99', '0', 'West Bengal', 'WES', 'WE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('443', '1', '101', '0', 'Ahmadi va Kohkiluyeh', 'BOK', 'BO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('444', '1', '101', '0', 'Ardabil', 'ARD', 'AR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('445', '1', '101', '0', 'Azarbayjan-e Gharbi', 'AZG', 'AG', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('446', '1', '101', '0', 'Azarbayjan-e Sharqi', 'AZS', 'AS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('447', '1', '101', '0', 'Bushehr', 'BUS', 'BU', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('448', '1', '101', '0', 'Chaharmahal va Bakhtiari', 'CMB', 'CM', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('449', '1', '101', '0', 'Esfahan', 'ESF', 'ES', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('450', '1', '101', '0', 'Fars', 'FAR', 'FA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('451', '1', '101', '0', 'Gilan', 'GIL', 'GI', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('452', '1', '101', '0', 'Gorgan', 'GOR', 'GO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('453', '1', '101', '0', 'Hamadan', 'HAM', 'HA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('454', '1', '101', '0', 'Hormozgan', 'HOR', 'HO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('455', '1', '101', '0', 'Ilam', 'ILA', 'IL', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('456', '1', '101', '0', 'Kerman', 'KER', 'KE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('457', '1', '101', '0', 'Kermanshah', 'BAK', 'BA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('458', '1', '101', '0', 'Khorasan-e Junoubi', 'KHJ', 'KJ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('459', '1', '101', '0', 'Khorasan-e Razavi', 'KHR', 'KR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('460', '1', '101', '0', 'Khorasan-e Shomali', 'KHS', 'KS', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('461', '1', '101', '0', 'Khuzestan', 'KHU', 'KH', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('462', '1', '101', '0', 'Kordestan', 'KOR', 'KO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('463', '1', '101', '0', 'Lorestan', 'LOR', 'LO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('464', '1', '101', '0', 'Markazi', 'MAR', 'MR', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('465', '1', '101', '0', 'Mazandaran', 'MAZ', 'MZ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('466', '1', '101', '0', 'Qazvin', 'QAS', 'QA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('467', '1', '101', '0', 'Qom', 'QOM', 'QO', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('468', '1', '101', '0', 'Semnan', 'SEM', 'SE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('469', '1', '101', '0', 'Sistan va Baluchestan', 'SBA', 'SB', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('470', '1', '101', '0', 'Tehran', 'TEH', 'TE', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('471', '1', '101', '0', 'Yazd', 'YAZ', 'YA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('472', '1', '101', '0', 'Zanjan', 'ZAN', 'ZA', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('535', '1', '84', '0', 'ΛΕΥΚΑΔΑΣ', 'ΛΕΥ', 'ΛΕ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('532', '1', '84', '0', 'ΛΑΡΙΣΑΣ', 'ΛΑΡ', 'ΛΡ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('504', '1', '84', '0', 'ΑΡΚΑΔΙΑΣ', 'ΑΡΚ', 'ΑΚ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('503', '1', '84', '0', 'ΑΡΓΟΛΙΔΑΣ', 'ΑΡΓ', 'ΑΡ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('533', '1', '84', '0', 'ΛΑΣΙΘΙΟΥ', 'ΛΑΣ', 'ΛΑ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('534', '1', '84', '0', 'ΛΕΣΒΟΥ', 'ΛΕΣ', 'ΛΣ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('530', '1', '84', '0', 'ΚΥΚΛΑΔΩΝ', 'ΚΥΚ', 'ΚΥ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('553', '1', '84', '0', 'ΑΙΤΩΛΟΑΚΑΡΝΑΝΙΑΣ', 'ΑΙΤ', 'ΑΙ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('529', '1', '84', '0', 'ΚΟΡΙΝΘΙΑΣ', 'ΚΟΡ', 'ΚΟ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('531', '1', '84', '0', 'ΛΑΚΩΝΙΑΣ', 'ΛΑΚ', 'ΛK', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('517', '1', '84', '0', 'ΗΜΑΘΙΑΣ', 'ΗΜΑ', 'ΗΜ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('518', '1', '84', '0', 'ΗΡΑΚΛΕΙΟΥ', 'ΗΡΑ', 'ΗΡ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('519', '1', '84', '0', 'ΘΕΣΠΡΩΤΙΑΣ', 'ΘΕΠ', 'ΘΠ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('520', '1', '84', '0', 'ΘΕΣΣΑΛΟΝΙΚΗΣ', 'ΘΕΣ', 'ΘΕ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('521', '1', '84', '0', 'ΙΩΑΝΝΙΝΩΝ', 'ΙΩΑ', 'ΙΩ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('522', '1', '84', '0', 'ΚΑΒΑΛΑΣ', 'ΚΑΒ', 'ΚΒ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('523', '1', '84', '0', 'ΚΑΡΔΙΤΣΑΣ', 'ΚΑΡ', 'ΚΡ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('524', '1', '84', '0', 'ΚΑΣΤΟΡΙΑΣ', 'ΚΑΣ', 'ΚΣ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('525', '1', '84', '0', 'ΚΕΡΚΥΡΑΣ', 'ΚΕΡ', 'ΚΕ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('526', '1', '84', '0', 'ΚΕΦΑΛΛΗΝΙΑΣ', 'ΚΕΦ', 'ΚΦ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('527', '1', '84', '0', 'ΚΙΛΚΙΣ', 'ΚΙΛ', 'ΚΙ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('528', '1', '84', '0', 'ΚΟΖΑΝΗΣ', 'ΚΟΖ', 'ΚZ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('507', '1', '84', '0', 'ΑΧΑΪΑΣ', 'ΑΧΑ', 'ΑΧ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('508', '1', '84', '0', 'ΒΟΙΩΤΙΑΣ', 'ΒΟΙ', 'ΒΟ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('509', '1', '84', '0', 'ΓΡΕΒΕΝΩΝ', 'ΓΡΕ', 'ΓΡ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('510', '1', '84', '0', 'ΔΡΑΜΑΣ', 'ΔΡΑ', 'ΔΡ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('511', '1', '84', '0', 'ΔΩΔΕΚΑΝΗΣΟΥ', 'ΔΩΔ', 'ΔΩ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('512', '1', '84', '0', 'ΕΒΡΟΥ', 'ΕΒΡ', 'ΕΒ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('513', '1', '84', '0', 'ΕΥΒΟΙΑΣ', 'ΕΥΒ', 'ΕΥ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('514', '1', '84', '0', 'ΕΥΡΥΤΑΝΙΑΣ', 'ΕΥΡ', 'ΕΡ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('515', '1', '84', '0', 'ΖΑΚΥΝΘΟΥ', 'ΖΑΚ', 'ΖΑ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('516', '1', '84', '0', 'ΗΛΕΙΑΣ', 'ΗΛΕ', 'ΗΛ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('505', '1', '84', '0', 'ΑΡΤΑΣ', 'ΑΡΤ', 'ΑΑ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('506', '1', '84', '0', 'ΑΤΤΙΚΗΣ', 'ΑΤΤ', 'ΑΤ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('536', '1', '84', '0', 'ΜΑΓΝΗΣΙΑΣ', 'ΜΑΓ', 'ΜΑ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('537', '1', '84', '0', 'ΜΕΣΣΗΝΙΑΣ', 'ΜΕΣ', 'ΜΕ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('538', '1', '84', '0', 'ΞΑΝΘΗΣ', 'ΞΑΝ', 'ΞΑ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('539', '1', '84', '0', 'ΠΕΛΛΗΣ', 'ΠΕΛ', 'ΠΕ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('540', '1', '84', '0', 'ΠΙΕΡΙΑΣ', 'ΠΙΕ', 'ΠΙ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('541', '1', '84', '0', 'ΠΡΕΒΕΖΑΣ', 'ΠΡΕ', 'ΠΡ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('542', '1', '84', '0', 'ΡΕΘΥΜΝΗΣ', 'ΡΕΘ', 'ΡΕ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('543', '1', '84', '0', 'ΡΟΔΟΠΗΣ', 'ΡΟΔ', 'ΡΟ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('544', '1', '84', '0', 'ΣΑΜΟΥ', 'ΣΑΜ', 'ΣΑ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('545', '1', '84', '0', 'ΣΕΡΡΩΝ', 'ΣΕΡ', 'ΣΕ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('546', '1', '84', '0', 'ΤΡΙΚΑΛΩΝ', 'ΤΡΙ', 'ΤΡ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('547', '1', '84', '0', 'ΦΘΙΩΤΙΔΑΣ', 'ΦΘΙ', 'ΦΘ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('548', '1', '84', '0', 'ΦΛΩΡΙΝΑΣ', 'ΦΛΩ', 'ΦΛ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('549', '1', '84', '0', 'ΦΩΚΙΔΑΣ', 'ΦΩΚ', 'ΦΩ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('550', '1', '84', '0', 'ΧΑΛΚΙΔΙΚΗΣ', 'ΧΑΛ', 'ΧΑ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('551', '1', '84', '0', 'ΧΑΝΙΩΝ', 'ΧΑΝ', 'ΧΝ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('552', '1', '84', '0', 'ΧΙΟΥ', 'ΧΙΟ', 'ΧΙ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('569', '1', '81', '0', 'Schleswig-Holstein', 'SHO', 'SH', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('554', '1', '81', '0', 'Freie und Hansestadt Hamburg', 'HAM', 'HH', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('555', '1', '81', '0', 'Niedersachsen', 'NIS', 'NI', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('556', '1', '81', '0', 'Freie Hansestadt Bremen', 'HBR', 'HB', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('557', '1', '81', '0', 'Nordrhein-Westfalen', 'NRW', 'NW', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('558', '1', '81', '0', 'Hessen', 'HES', 'HE', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('559', '1', '81', '0', 'Rheinland-Pfalz', 'RLP', 'RP', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('560', '1', '81', '0', 'Baden-Württemberg', 'BWÜ', 'BW', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('561', '1', '81', '0', 'Freistaat Bayern', 'BAV', 'BY', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('562', '1', '81', '0', 'Saarland', 'SLA', 'SL', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('563', '1', '81', '0', 'Berlin', 'BER', 'BE', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('564', '1', '81', '0', 'Brandenburg', 'BRB', 'BB', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('565', '1', '81', '0', 'Mecklenburg-Vorpommern', 'MVO', 'MV', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('566', '1', '81', '0', 'Freistaat Sachsen', 'SAC', 'SN', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('567', '1', '81', '0', 'Sachsen-Anhalt', 'SAA', 'ST', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('568', '1', '81', '0', 'Freistaat Thüringen', 'THÜ', 'TH', '0', '1', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('570', '1', '176', '0', 'Адыгея Республика', 'AD', '01', '1', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('571', '1', '176', '0', 'Алтай Республика', 'AL', '04', '2', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('572', '1', '176', '0', 'Алтайский край', 'ALT', '22', '3', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('573', '1', '176', '0', 'Амурская область', 'AMU', '28', '4', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('574', '1', '176', '0', 'Архангельская область', 'ARK', '29', '5', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('575', '1', '176', '0', 'Астраханская область', 'AST', '30', '6', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('576', '1', '176', '0', 'Башкортостан Республика', 'BA', '02', '7', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('577', '1', '176', '0', 'Белгородская область', 'BEL', '31', '8', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('578', '1', '176', '0', 'Брянская область', 'BRY', '32', '9', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('579', '1', '176', '0', 'Бурятия Республика', 'BU', '03', '10', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('580', '1', '176', '0', 'Владимирская область', 'VLA', '33', '11', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('581', '1', '176', '0', 'Волгоградская область', 'VGG', '34', '12', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('582', '1', '176', '0', 'Вологодская область', 'VLG', '35', '13', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('583', '1', '176', '0', 'Воронежская область', 'VOR', '36', '14', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('584', '1', '176', '0', 'Дагестан Республика', 'DA', '05', '15', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('585', '1', '176', '0', 'Еврейская автономная область', 'YEV', '79', '16', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('586', '1', '176', '0', 'Забайкальский край', 'ZAB', '75', '17', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('587', '1', '176', '0', 'Ивановская область', 'IVA', '37', '18', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('588', '1', '176', '0', 'Ингушетия Республика', 'IN', '06', '19', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('589', '1', '176', '0', 'Иркутская область', 'IRK', '38', '20', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('590', '1', '176', '0', 'Кабардино-Балкарская Республика', 'KB', '07', '21', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('591', '1', '176', '0', 'Калининградская область', 'KGD', '39', '22', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('592', '1', '176', '0', 'Калмыкия Республика', 'KL', '08', '23', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('593', '1', '176', '0', 'Калужская область', 'KLU', '40', '24', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('594', '1', '176', '0', 'Камчатский край', 'KAM', '41', '25', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('595', '1', '176', '0', 'Карачаево-Черкесская Республика', 'KC', '09', '26', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('596', '1', '176', '0', 'Карелия Республика', 'KR', '10', '27', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('597', '1', '176', '0', 'Кемеровская область', 'KEM', '42', '28', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('598', '1', '176', '0', 'Кировская область', 'KIR', '43', '29', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('599', '1', '176', '0', 'Коми Республика', 'KO', '11', '30', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('600', '1', '176', '0', 'Костромская область', 'KOS', '44', '31', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('601', '1', '176', '0', 'Краснодарский край', 'KDA', '23', '32', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('602', '1', '176', '0', 'Красноярский край', 'KIA', '24', '33', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('603', '1', '176', '0', 'Курганская область', 'KGN', '45', '34', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('604', '1', '176', '0', 'Курская область', 'KRS', '46', '35', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('605', '1', '176', '0', 'Ленинградская область', 'LEN', '47', '36', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('606', '1', '176', '0', 'Липецкая область', 'LIP', '48', '37', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('607', '1', '176', '0', 'Магаданская область', 'MAG', '49', '38', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('608', '1', '176', '0', 'Марий Эл Республика', 'ME', '12', '39', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('609', '1', '176', '0', 'Мордовия Республика', 'MO', '13', '40', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('610', '1', '176', '0', 'Москва', 'MOW', '77', '41', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('611', '1', '176', '0', 'Московская область', 'MOS', '50', '42', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('612', '1', '176', '0', 'Мурманская область', 'MUR', '51', '43', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('613', '1', '176', '0', 'Ненецкий автономный округ', 'NEN', '83', '44', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('614', '1', '176', '0', 'Нижегородская область', 'NIZ', '52', '45', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('615', '1', '176', '0', 'Новгородская область', 'NGR', '53', '46', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('616', '1', '176', '0', 'Новосибирская область', 'NVS', '54', '47', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('617', '1', '176', '0', 'Омская область', 'OMS', '55', '48', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('618', '1', '176', '0', 'Оренбургская область', 'ORE', '56', '49', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('619', '1', '176', '0', 'Орловская область', 'ORL', '57', '50', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('620', '1', '176', '0', 'Пензенская область', 'PNZ', '58', '51', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('621', '1', '176', '0', 'Пермский край', 'PER', '59', '52', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('622', '1', '176', '0', 'Приморский край', 'PRI', '25', '53', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('623', '1', '176', '0', 'Псковская область', 'PSK', '60', '54', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('624', '1', '176', '0', 'Ростовская область', 'ROS', '61', '55', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('625', '1', '176', '0', 'Рязанская область', 'RYA', '62', '56', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('626', '1', '176', '0', 'Самарская область', 'SAM', '63', '57', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('627', '1', '176', '0', 'Санкт-Петербург', 'SPE', '78', '58', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('628', '1', '176', '0', 'Саратовская область', 'SAR', '64', '59', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('629', '1', '176', '0', 'Саха (Якутия) Республика', 'SA', '14', '60', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('630', '1', '176', '0', 'Сахалинская область', 'SAK', '65', '61', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('631', '1', '176', '0', 'Свердловская область', 'SVE', '66', '62', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('632', '1', '176', '0', 'Северная Осетия-Алания Республика', 'SE', '15', '63', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('633', '1', '176', '0', 'Смоленская область', 'SMO', '67', '64', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('634', '1', '176', '0', 'Ставропольский край', 'STA', '26', '65', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('635', '1', '176', '0', 'Тамбовская область', 'TAM', '68', '66', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('636', '1', '176', '0', 'Татарстан Республика', 'TA', '16', '67', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('637', '1', '176', '0', 'Тверская область', 'TVE', '69', '68', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('638', '1', '176', '0', 'Томская область', 'TOM', '70', '69', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('639', '1', '176', '0', 'Тульская область', 'TUL', '71', '70', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('640', '1', '176', '0', 'Тыва Республика', 'TY', '17', '71', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('641', '1', '176', '0', 'Тюменская область', 'TYU', '72', '72', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('642', '1', '176', '0', 'Удмуртская Республика', 'UD', '18', '73', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('643', '1', '176', '0', 'Ульяновская область', 'ULY', '73', '74', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('644', '1', '176', '0', 'Хакасия Республика', 'KK', '19', '75', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('645', '1', '176', '0', 'Челябинская область', 'CHE', '74', '76', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('646', '1', '176', '0', 'Чеченская Республика', 'CE', '20', '77', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('647', '1', '176', '0', 'Чувашская Республика', 'CU', '21', '78', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('648', '1', '176', '0', 'Чукотский автономный округ', 'CHU', '87', '79', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('649', '1', '176', '0', 'Хабаровский край', 'KHA', '27', '80', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('650', '1', '176', '0', 'Ханты-Мансийский автономный округ', 'KHM', '86', '81', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('651', '1', '176', '0', 'Ямало-Ненецкий автономный округ', 'YAN', '89', '82', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('652', '1', '176', '0', 'Ярославская область', 'YAR', '76', '83', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('653', '1', '209', '0', 'กระบี่', 'กบ', 'กบ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('654', '1', '209', '0', 'กรุงเทพมหานคร', 'กทม', 'กท', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('655', '1', '209', '0', 'กาญจนบุรี', 'กจ', 'กจ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('656', '1', '209', '0', 'กาฬสินธุ์', 'กส', 'กส', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('657', '1', '209', '0', 'กำแพงเพชร', 'กพ', 'กพ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('658', '1', '209', '0', 'ขอนแก่น', 'ขก', 'ขก', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('659', '1', '209', '0', 'จันทบุรี', 'จบ', 'จบ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('660', '1', '209', '0', 'ฉะเชิงเทรา', 'ฉช', 'ฉช', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('661', '1', '209', '0', 'ชลบุรี', 'ชบ', 'ชบ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('662', '1', '209', '0', 'ชัยนาท', 'ชน', 'ชน', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('663', '1', '209', '0', 'ชัยภูมิ', 'ชย', 'ชย', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('664', '1', '209', '0', 'ชุมพร', 'ชพ', 'ชพ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('665', '1', '209', '0', 'เชียงราย', 'ชร', 'ชร', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('666', '1', '209', '0', 'เชียงใหม่', 'ชม', 'ชม', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('667', '1', '209', '0', 'ตรัง', 'ตง', 'ตง', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('668', '1', '209', '0', 'ตราด', 'ตร', 'ตร', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('669', '1', '209', '0', 'ตาก', 'ตก', 'ตก', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('670', '1', '209', '0', 'นครนายก', 'นย', 'นย', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('671', '1', '209', '0', 'นครปฐม', 'นฐ', 'นฐ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('672', '1', '209', '0', 'นครพนม', 'นพ', 'นพ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('673', '1', '209', '0', 'นครราชสีมา', 'นม', 'นม', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('674', '1', '209', '0', 'นครศรีธรรมราช', 'นศ', 'นศ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('675', '1', '209', '0', 'นครสวรรค์', 'นว', 'นว', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('676', '1', '209', '0', 'นนทบุรี', 'นบ', 'นบ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('677', '1', '209', '0', 'นราธิวาส', 'นธ', 'นธ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('678', '1', '209', '0', 'น่าน', 'นน', 'นน', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('679', '1', '209', '0', 'บุรีรัมย์', 'บร', 'บร', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('680', '1', '209', '0', 'บึงกาฬ', 'บก', 'บก', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('681', '1', '209', '0', 'ปทุมธานี', 'ปท', 'ปท', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('682', '1', '209', '0', 'ประจวบคีรีขันธ์', 'ปข', 'ปข', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('683', '1', '209', '0', 'ปราจีนบุรี', 'ปจ', 'ปจ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('684', '1', '209', '0', 'ปัตตานี', 'ปน', 'ปน', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('685', '1', '209', '0', 'พระนครศรีอยุธยา', 'อย', 'อย', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('686', '1', '209', '0', 'พังงา', 'พง', 'พง', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('687', '1', '209', '0', 'พัทลุง', 'พท', 'พท', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('688', '1', '209', '0', 'พิจิตร', 'พจ', 'พจ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('689', '1', '209', '0', 'พิษณุโลก', 'พล', 'พล', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('690', '1', '209', '0', 'เพชรบุรี', 'พบ', 'พบ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('691', '1', '209', '0', 'เพชรบูรณ์', 'พช', 'พช', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('692', '1', '209', '0', 'แพร่', 'พร', 'พร', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('693', '1', '209', '0', 'พะเยา', 'พย', 'พย', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('694', '1', '209', '0', 'ภูเก็ต', 'ภก', 'ภก', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('695', '1', '209', '0', 'มหาสารคาม', 'มค', 'มค', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('696', '1', '209', '0', 'แม่ฮ่องสอน', 'มส', 'มส', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('697', '1', '209', '0', 'มุกดาหาร', 'มห', 'มห', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('698', '1', '209', '0', 'ยะลา', 'ยล', 'ยล', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('699', '1', '209', '0', 'ยโสธร', 'ยส', 'ยส', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('700', '1', '209', '0', 'ร้อยเอ็ด', 'รอ', 'รอ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('701', '1', '209', '0', 'ระนอง', 'รน', 'รน', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('702', '1', '209', '0', 'ระยอง', 'รย', 'รย', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('703', '1', '209', '0', 'ราชบุรี', 'รบ', 'รบ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('704', '1', '209', '0', 'ลพบุรี', 'ลบ', 'ลบ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('705', '1', '209', '0', 'ลำปาง', 'ลป', 'ลป', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('706', '1', '209', '0', 'ลำพูน', 'ลพ', 'ลพ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('707', '1', '209', '0', 'เลย', 'ลย', 'ลย', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('708', '1', '209', '0', 'ศรีสะเกษ', 'ศก', 'ศก', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('709', '1', '209', '0', 'สกลนคร', 'สน', 'สน', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('710', '1', '209', '0', 'สงขลา', 'สข', 'สข', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('711', '1', '209', '0', 'สตูล', 'สต', 'สต', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('712', '1', '209', '0', 'สมุทรปราการ', 'สป', 'สป', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('713', '1', '209', '0', 'สมุทรสงคราม', 'สส', 'สส', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('714', '1', '209', '0', 'สมุทรสาคร', 'สค', 'สค', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('715', '1', '209', '0', 'สระบุรี', 'สบ', 'สบ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('716', '1', '209', '0', 'สระแก้ว', 'สก', 'สก', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('717', '1', '209', '0', 'สิงห์บุรี', 'สห', 'สห', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('718', '1', '209', '0', 'สุโขทัย', 'สท', 'สท', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('719', '1', '209', '0', 'สุพรรณบุรี', 'สพ', 'สพ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('720', '1', '209', '0', 'สุราษฎร์ธานี', 'สฎ', 'สฎ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('721', '1', '209', '0', 'สุรินทร์', 'สร', 'สร', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('722', '1', '209', '0', 'หนองคาย', 'นค', 'นค', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('723', '1', '209', '0', 'หนองบัวลำภู', 'นภ', 'นภ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('724', '1', '209', '0', 'อ่างทอง', 'อท', 'อท', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('725', '1', '209', '0', 'อุดรธานี', 'อด', 'อด', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('726', '1', '209', '0', 'อุตรดิตถ์', 'อต', 'อต', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('727', '1', '209', '0', 'อุทัยธานี', 'อน', 'อน', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('728', '1', '209', '0', 'อุบลราชธานี', 'อบ', 'อบ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_states` VALUES ('729', '1', '209', '0', 'อำนาจเจริญ', 'อจ', 'อจ', '0', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_userfields`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_userfields`;
CREATE TABLE `wy587_virtuemart_userfields` (
  `virtuemart_userfield_id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '1',
  `userfield_jplugin_id` int(11) NOT NULL DEFAULT '0',
  `name` char(255) NOT NULL DEFAULT '',
  `title` char(255) NOT NULL DEFAULT '',
  `description` mediumtext,
  `type` char(70) NOT NULL DEFAULT '',
  `maxlength` int(11) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `cols` int(11) DEFAULT NULL,
  `rows` int(11) DEFAULT NULL,
  `value` char(255) DEFAULT NULL,
  `default` char(255) DEFAULT NULL,
  `registration` tinyint(1) NOT NULL DEFAULT '0',
  `shipment` tinyint(1) NOT NULL DEFAULT '0',
  `account` tinyint(1) NOT NULL DEFAULT '1',
  `cart` tinyint(1) NOT NULL DEFAULT '0',
  `readonly` tinyint(1) NOT NULL DEFAULT '0',
  `calculated` tinyint(1) NOT NULL DEFAULT '0',
  `sys` tinyint(4) NOT NULL DEFAULT '0',
  `userfield_params` varchar(17000) NOT NULL DEFAULT '',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_userfield_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `ordering` (`ordering`),
  KEY `shared` (`shared`),
  KEY `published` (`published`),
  KEY `account` (`account`),
  KEY `shipment` (`shipment`),
  KEY `cart` (`cart`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='Holds the fields for the user information';

-- ----------------------------
-- Records of wy587_virtuemart_userfields
-- ----------------------------
INSERT INTO `wy587_virtuemart_userfields` VALUES ('5', '0', '0', 'email', 'COM_VIRTUEMART_REGISTER_EMAIL', '', 'emailaddress', '100', '30', '1', null, null, null, null, '1', '0', '1', '0', '0', '0', '1', '', '4', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('6', '0', '0', 'name', 'COM_VIRTUEMART_USER_DISPLAYED_NAME', '', 'text', '25', '30', '1', '0', '0', '', null, '1', '0', '1', '0', '0', '0', '1', '', '8', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('7', '0', '0', 'username', 'COM_VIRTUEMART_USERNAME', '', 'text', '25', '30', '1', '0', '0', '', null, '1', '0', '1', '0', '0', '0', '1', '', '6', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('8', '0', '0', 'password', 'COM_VIRTUEMART_SHOPPER_FORM_PASSWORD_1', '', 'password', '25', '30', '1', null, null, null, null, '1', '0', '1', '0', '0', '0', '1', '', '10', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('9', '0', '0', 'password2', 'COM_VIRTUEMART_SHOPPER_FORM_PASSWORD_2', '', 'password', '25', '30', '1', null, null, null, null, '1', '0', '1', '0', '0', '0', '1', '', '12', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('15', '0', '0', 'agreed', 'COM_VIRTUEMART_I_AGREE_TO_TOS', '', 'checkbox', null, null, '0', null, null, null, null, '0', '0', '0', '0', '0', '0', '1', '', '13', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('16', '0', '0', 'tos', 'COM_VIRTUEMART_STORE_FORM_TOS', '', 'custom', null, null, '1', null, null, null, null, '0', '0', '0', '1', '0', '0', '1', '', '14', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('17', '0', '0', 'customer_note', 'COM_VIRTUEMART_CNOTES_CART', '', 'textarea', '2500', null, '0', '60', '1', null, null, '0', '0', '0', '1', '0', '0', '1', '', '13', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('20', '0', '0', 'address_type_name', 'COM_VIRTUEMART_USER_FORM_ADDRESS_LABEL', '', 'text', '32', '30', '1', null, null, null, 'Shipment', '0', '1', '0', '0', '0', '0', '1', '', '16', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('21', '0', '0', 'delimiter_billto', 'COM_VIRTUEMART_USER_FORM_BILLTO_LBL', '', 'delimiter', '25', '30', '0', null, null, null, null, '1', '0', '1', '0', '0', '0', '0', '', '18', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('22', '0', '0', 'company', 'COM_VIRTUEMART_SHOPPER_FORM_COMPANY_NAME', '', 'text', '64', '30', '0', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '20', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('23', '0', '0', 'title', 'COM_VIRTUEMART_SHOPPER_FORM_TITLE', '', 'select', '0', '210', '0', null, null, null, null, '1', '0', '1', '0', '0', '0', '1', '', '22', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('24', '0', '0', 'first_name', 'COM_VIRTUEMART_SHOPPER_FORM_FIRST_NAME', '', 'text', '32', '30', '1', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '24', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('25', '0', '0', 'middle_name', 'COM_VIRTUEMART_SHOPPER_FORM_MIDDLE_NAME', '', 'text', '32', '30', '0', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '26', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('26', '0', '0', 'last_name', 'COM_VIRTUEMART_SHOPPER_FORM_LAST_NAME', '', 'text', '32', '30', '1', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '28', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('27', '0', '0', 'address_1', 'COM_VIRTUEMART_SHOPPER_FORM_ADDRESS_1', '', 'text', '64', '30', '1', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '30', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('28', '0', '0', 'address_2', 'COM_VIRTUEMART_SHOPPER_FORM_ADDRESS_2', '', 'text', '64', '30', '0', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '32', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('29', '0', '0', 'zip', 'COM_VIRTUEMART_SHOPPER_FORM_ZIP', '', 'text', '32', '30', '1', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '34', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('35', '0', '0', 'city', 'COM_VIRTUEMART_SHOPPER_FORM_CITY', '', 'text', '32', '30', '1', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '36', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('36', '0', '0', 'virtuemart_country_id', 'COM_VIRTUEMART_SHOPPER_FORM_COUNTRY', '', 'select', '0', '210', '1', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '38', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('37', '0', '0', 'virtuemart_state_id', 'COM_VIRTUEMART_SHOPPER_FORM_STATE', '', 'select', '0', '210', '1', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '40', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('38', '0', '0', 'phone_1', 'COM_VIRTUEMART_SHOPPER_FORM_PHONE', '', 'text', '32', '30', '0', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '42', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('39', '0', '0', 'phone_2', 'COM_VIRTUEMART_SHOPPER_FORM_PHONE2', '', 'text', '32', '30', '0', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '44', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('40', '0', '0', 'fax', 'COM_VIRTUEMART_SHOPPER_FORM_FAX', '', 'text', '32', '30', '0', null, null, null, null, '1', '1', '1', '0', '0', '0', '1', '', '46', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('41', '0', '0', 'delimiter_sendregistration', 'COM_VIRTUEMART_BUTTON_SEND_REG', '', 'delimiter', '25', '30', '0', null, null, null, null, '0', '0', '0', '0', '0', '0', '0', '', '2', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('42', '0', '0', 'delimiter_userinfo', 'COM_VIRTUEMART_ORDER_PRINT_CUST_INFO_LBL', '', 'delimiter', null, null, '0', null, null, null, null, '1', '0', '1', '0', '0', '0', '0', '', '14', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('50', '0', '0', 'tax_exemption_number', 'COM_VIRTUEMART_SHOPPER_FORM_TAXEXEMPTION_NBR', 'Vendors can set here a tax exemption number for a shopper. This field is only changeable by administrators.', 'text', '10', '0', '0', '0', '0', null, null, '0', '0', '1', '1', '0', '0', '0', '', '48', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfields` VALUES ('51', '0', '0', 'tax_usage_type', 'COM_VIRTUEMART_SHOPPER_FORM_TAX_USAGE', 'Federal, national, educational, public, or similar often get a special tax. This field is only writable by administrators.', 'select', '0', '0', '0', '0', '0', null, null, '0', '0', '1', '1', '0', '0', '0', '', '50', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_userfield_values`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_userfield_values`;
CREATE TABLE `wy587_virtuemart_userfield_values` (
  `virtuemart_userfield_value_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_userfield_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `fieldtitle` char(255) NOT NULL DEFAULT '',
  `fieldvalue` char(255) NOT NULL DEFAULT '',
  `sys` tinyint(4) NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_userfield_value_id`),
  KEY `virtuemart_userfield_id` (`virtuemart_userfield_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='Holds the different values for dropdown and radio lists';

-- ----------------------------
-- Records of wy587_virtuemart_userfield_values
-- ----------------------------
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('1', '23', 'COM_VIRTUEMART_SHOPPER_TITLE_MR', 'Mr', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('2', '23', 'COM_VIRTUEMART_SHOPPER_TITLE_MRS', 'Mrs', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('3', '51', 'None', '', '0', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('4', '51', 'Non-resident (Canada)', 'R', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('5', '51', 'Federal government (United States)', 'A', '0', '1', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('6', '51', 'State government (United States)', 'B', '0', '2', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('7', '51', 'Tribe / Status Indian / Indian Band (both)', 'C', '0', '3', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('8', '51', 'Foreign diplomat (both)', 'D', '0', '4', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('9', '51', 'Charitable or benevolent org (both)', 'E', '0', '5', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('10', '51', 'Religious or educational org (both)', 'F', '0', '6', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('11', '51', 'Resale (both)', 'G', '0', '7', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('12', '51', 'Commercial agricultural production (both)', 'H', '0', '8', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('13', '51', 'Industrial production / manufacturer (both)', 'I', '0', '9', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('14', '51', 'Direct pay permit (United States)', 'J', '0', '10', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('15', '51', 'Direct mail (United States)', 'K', '0', '11', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('16', '51', 'Other (both)', 'L', '0', '12', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('17', '51', 'Local government (United States)', 'N', '0', '13', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('18', '51', 'Commercial aquaculture (Canada)', 'P', '0', '14', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');
INSERT INTO `wy587_virtuemart_userfield_values` VALUES ('19', '51', 'Commercial Fishery (Canada)', 'Q', '0', '15', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_userinfos`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_userinfos`;
CREATE TABLE `wy587_virtuemart_userinfos` (
  `virtuemart_userinfo_id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_user_id` int(1) unsigned NOT NULL DEFAULT '0',
  `address_type` char(2) NOT NULL DEFAULT '',
  `address_type_name` char(32) NOT NULL DEFAULT '',
  `name` char(64) DEFAULT NULL,
  `company` char(64) DEFAULT NULL,
  `title` char(32) DEFAULT NULL,
  `last_name` char(48) DEFAULT NULL,
  `first_name` char(48) DEFAULT NULL,
  `middle_name` char(48) DEFAULT NULL,
  `phone_1` char(32) DEFAULT NULL,
  `phone_2` char(32) DEFAULT NULL,
  `fax` char(32) DEFAULT NULL,
  `address_1` char(64) NOT NULL DEFAULT '',
  `address_2` char(64) DEFAULT NULL,
  `city` char(64) NOT NULL DEFAULT '',
  `virtuemart_state_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_country_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `zip` char(32) NOT NULL DEFAULT '',
  `agreed` tinyint(1) NOT NULL DEFAULT '0',
  `tos` tinyint(1) NOT NULL DEFAULT '0',
  `customer_note` varchar(2500) NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_userinfo_id`),
  KEY `virtuemart_user_id` (`virtuemart_userinfo_id`,`virtuemart_user_id`),
  KEY `address_type` (`address_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customer Information, BT = BillTo and ST = ShipTo';

-- ----------------------------
-- Records of wy587_virtuemart_userinfos
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_vendors`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_vendors`;
CREATE TABLE `wy587_virtuemart_vendors` (
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_name` char(64) DEFAULT NULL,
  `vendor_currency` int(11) DEFAULT NULL,
  `vendor_accepted_currencies` varchar(1536) NOT NULL DEFAULT '',
  `vendor_params` varchar(17000) NOT NULL DEFAULT '',
  `metarobot` char(20) DEFAULT NULL,
  `metaauthor` char(64) DEFAULT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_vendor_id`),
  KEY `vendor_name` (`vendor_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Vendors manage their products in your store';

-- ----------------------------
-- Records of wy587_virtuemart_vendors
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_vendors_ru_ru`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_vendors_ru_ru`;
CREATE TABLE `wy587_virtuemart_vendors_ru_ru` (
  `virtuemart_vendor_id` int(1) unsigned NOT NULL,
  `vendor_store_desc` text NOT NULL,
  `vendor_terms_of_service` text NOT NULL,
  `vendor_legal_info` text NOT NULL,
  `vendor_letter_css` text NOT NULL,
  `vendor_letter_header_html` varchar(8000) NOT NULL DEFAULT '<h1>{vm:vendorname}</h1><p>{vm:vendoraddress}</p>',
  `vendor_letter_footer_html` varchar(8000) NOT NULL DEFAULT '<p>{vm:vendorlegalinfo}<br />Page {vm:pagenum}/{vm:pagecount}</p>',
  `vendor_store_name` char(180) NOT NULL DEFAULT '',
  `vendor_phone` char(26) NOT NULL DEFAULT '',
  `vendor_url` char(255) NOT NULL DEFAULT '',
  `metadesc` varchar(400) NOT NULL DEFAULT '',
  `metakey` varchar(400) NOT NULL DEFAULT '',
  `customtitle` char(255) NOT NULL DEFAULT '',
  `vendor_invoice_free1` char(255) NOT NULL DEFAULT '',
  `vendor_invoice_free2` char(255) NOT NULL DEFAULT '',
  `vendor_mail_free1` char(255) NOT NULL DEFAULT '',
  `vendor_mail_free2` char(255) NOT NULL DEFAULT '',
  `vendor_mail_css` char(255) NOT NULL DEFAULT '',
  `slug` char(192) NOT NULL DEFAULT '',
  PRIMARY KEY (`virtuemart_vendor_id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_vendors_ru_ru
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_vendor_medias`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_vendor_medias`;
CREATE TABLE `wy587_virtuemart_vendor_medias` (
  `id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_media_id` int(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`,`virtuemart_media_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_virtuemart_vendor_medias
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_vmusers`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_vmusers`;
CREATE TABLE `wy587_virtuemart_vmusers` (
  `virtuemart_user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `user_is_vendor` tinyint(1) NOT NULL DEFAULT '0',
  `customer_number` char(32) DEFAULT NULL,
  `virtuemart_paymentmethod_id` mediumint(1) unsigned DEFAULT NULL,
  `virtuemart_shipmentmethod_id` mediumint(1) unsigned DEFAULT NULL,
  `agreed` tinyint(1) NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_user_id`),
  UNIQUE KEY `virtuemart_user_id` (`virtuemart_user_id`,`virtuemart_vendor_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `user_is_vendor` (`user_is_vendor`)
) ENGINE=InnoDB AUTO_INCREMENT=437 DEFAULT CHARSET=utf8 COMMENT='Holds the unique user data';

-- ----------------------------
-- Records of wy587_virtuemart_vmusers
-- ----------------------------
INSERT INTO `wy587_virtuemart_vmusers` VALUES ('436', '1', '1', null, null, null, '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0', '0000-00-00 00:00:00', '0');

-- ----------------------------
-- Table structure for `wy587_virtuemart_vmuser_shoppergroups`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_vmuser_shoppergroups`;
CREATE TABLE `wy587_virtuemart_vmuser_shoppergroups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_user_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_shoppergroup_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `virtuemart_user_id` (`virtuemart_user_id`,`virtuemart_shoppergroup_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='xref table for users to shopper group';

-- ----------------------------
-- Records of wy587_virtuemart_vmuser_shoppergroups
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_waitingusers`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_waitingusers`;
CREATE TABLE `wy587_virtuemart_waitingusers` (
  `virtuemart_waitinguser_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_product_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_user_id` int(1) unsigned NOT NULL DEFAULT '0',
  `notify_email` char(150) NOT NULL DEFAULT '',
  `notified` tinyint(1) NOT NULL DEFAULT '0',
  `notify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ordering` int(2) NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_waitinguser_id`),
  KEY `virtuemart_product_id` (`virtuemart_product_id`),
  KEY `notify_email` (`notify_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores notifications, users waiting f. products out of stock';

-- ----------------------------
-- Records of wy587_virtuemart_waitingusers
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_virtuemart_worldzones`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_virtuemart_worldzones`;
CREATE TABLE `wy587_virtuemart_worldzones` (
  `virtuemart_worldzone_id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) DEFAULT NULL,
  `zone_name` char(255) DEFAULT NULL,
  `zone_cost` decimal(10,2) DEFAULT NULL,
  `zone_limit` decimal(10,2) DEFAULT NULL,
  `zone_description` varchar(18000) DEFAULT NULL,
  `zone_tax_rate` int(1) unsigned NOT NULL DEFAULT '0',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_worldzone_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='The Zones managed by the Zone Shipment Module';

-- ----------------------------
-- Records of wy587_virtuemart_worldzones
-- ----------------------------

-- ----------------------------
-- Table structure for `wy587_weblinks`
-- ----------------------------
DROP TABLE IF EXISTS `wy587_weblinks`;
CREATE TABLE `wy587_weblinks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `catid` int(11) NOT NULL DEFAULT '0',
  `title` varchar(250) NOT NULL DEFAULT '',
  `alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `url` varchar(250) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `hits` int(11) NOT NULL DEFAULT '0',
  `state` tinyint(1) NOT NULL DEFAULT '0',
  `checked_out` int(11) NOT NULL DEFAULT '0',
  `checked_out_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `access` int(11) NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  `language` char(7) NOT NULL DEFAULT '',
  `created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(10) unsigned NOT NULL DEFAULT '0',
  `created_by_alias` varchar(255) NOT NULL DEFAULT '',
  `modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(10) unsigned NOT NULL DEFAULT '0',
  `metakey` text NOT NULL,
  `metadesc` text NOT NULL,
  `metadata` text NOT NULL,
  `featured` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Set if link is featured.',
  `xreference` varchar(50) NOT NULL COMMENT 'A reference to enable linkages to external data sets.',
  `publish_up` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `publish_down` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `version` int(10) unsigned NOT NULL DEFAULT '1',
  `images` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_access` (`access`),
  KEY `idx_checkout` (`checked_out`),
  KEY `idx_state` (`state`),
  KEY `idx_catid` (`catid`),
  KEY `idx_createdby` (`created_by`),
  KEY `idx_featured_catid` (`featured`,`catid`),
  KEY `idx_language` (`language`),
  KEY `idx_xreference` (`xreference`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wy587_weblinks
-- ----------------------------
