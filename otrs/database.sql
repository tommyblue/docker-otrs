# ************************************************************
# Sequel Pro SQL dump
# Version 4096
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.5.37-MariaDB)
# Database: otrs
# Generation Time: 2014-06-13 09:51:37 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table acl
# ------------------------------------------------------------

DROP TABLE IF EXISTS `acl`;

CREATE TABLE `acl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `stop_after_match` smallint(6) DEFAULT NULL,
  `config_match` longblob,
  `config_change` longblob,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_name` (`name`),
  KEY `FK_acl_create_by_id` (`create_by`),
  KEY `FK_acl_change_by_id` (`change_by`),
  KEY `FK_acl_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_acl_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_acl_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_acl_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table acl_sync
# ------------------------------------------------------------

DROP TABLE IF EXISTS `acl_sync`;

CREATE TABLE `acl_sync` (
  `acl_id` varchar(200) NOT NULL,
  `sync_state` varchar(30) NOT NULL,
  `create_time` datetime NOT NULL,
  `change_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table article
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint(20) NOT NULL,
  `article_type_id` smallint(6) NOT NULL,
  `article_sender_type_id` smallint(6) NOT NULL,
  `a_from` text,
  `a_reply_to` text,
  `a_to` text,
  `a_cc` text,
  `a_subject` text,
  `a_message_id` text,
  `a_message_id_md5` varchar(32) DEFAULT NULL,
  `a_in_reply_to` text,
  `a_references` text,
  `a_content_type` varchar(250) DEFAULT NULL,
  `a_body` mediumtext NOT NULL,
  `incoming_time` int(11) NOT NULL,
  `content_path` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_article_sender_type_id` (`article_sender_type_id`),
  KEY `article_article_type_id` (`article_type_id`),
  KEY `article_message_id_md5` (`a_message_id_md5`),
  KEY `article_ticket_id` (`ticket_id`),
  KEY `FK_article_create_by_id` (`create_by`),
  KEY `FK_article_change_by_id` (`change_by`),
  KEY `FK_article_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_article_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_article_article_sender_type_id_id` FOREIGN KEY (`article_sender_type_id`) REFERENCES `article_sender_type` (`id`),
  CONSTRAINT `FK_article_article_type_id_id` FOREIGN KEY (`article_type_id`) REFERENCES `article_type` (`id`),
  CONSTRAINT `FK_article_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_article_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_article_ticket_id_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;

INSERT INTO `article` (`id`, `ticket_id`, `article_type_id`, `article_sender_type_id`, `a_from`, `a_reply_to`, `a_to`, `a_cc`, `a_subject`, `a_message_id`, `a_message_id_md5`, `a_in_reply_to`, `a_references`, `a_content_type`, `a_body`, `incoming_time`, `content_path`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,1,1,3,'OTRS Feedback <feedback@otrs.org>',NULL,'Your OTRS System <otrs@localhost>',NULL,'Welcome to OTRS!','<007@localhost>',NULL,NULL,NULL,NULL,'Welcome!\n\nThank you for installing OTRS.\n\nYou will find updates and patches at http://www.otrs.com/open-source/.\nOnline documentation is available at http://doc.otrs.org/.\nYou can also use our mailing lists http://lists.otrs.org/\nor our forums at http://forums.otrs.org/\n\nRegards,\n\nThe OTRS Project\n',1280750400,'2010/08/02',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table article_attachment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article_attachment`;

CREATE TABLE `article_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) NOT NULL,
  `filename` varchar(250) DEFAULT NULL,
  `content_size` varchar(30) DEFAULT NULL,
  `content_type` text,
  `content_id` varchar(250) DEFAULT NULL,
  `content_alternative` varchar(50) DEFAULT NULL,
  `content` longblob NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_attachment_article_id` (`article_id`),
  KEY `FK_article_attachment_create_by_id` (`create_by`),
  KEY `FK_article_attachment_change_by_id` (`change_by`),
  CONSTRAINT `FK_article_attachment_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_article_attachment_article_id_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`),
  CONSTRAINT `FK_article_attachment_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table article_flag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article_flag`;

CREATE TABLE `article_flag` (
  `article_id` bigint(20) NOT NULL,
  `article_key` varchar(50) NOT NULL,
  `article_value` varchar(50) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  KEY `article_flag_article_id` (`article_id`),
  KEY `article_flag_article_id_create_by` (`article_id`,`create_by`),
  KEY `FK_article_flag_create_by_id` (`create_by`),
  CONSTRAINT `FK_article_flag_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_article_flag_article_id_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table article_plain
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article_plain`;

CREATE TABLE `article_plain` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `article_id` bigint(20) NOT NULL,
  `body` longblob NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_plain_article_id` (`article_id`),
  KEY `FK_article_plain_create_by_id` (`create_by`),
  KEY `FK_article_plain_change_by_id` (`change_by`),
  CONSTRAINT `FK_article_plain_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_article_plain_article_id_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`),
  CONSTRAINT `FK_article_plain_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `article_plain` WRITE;
/*!40000 ALTER TABLE `article_plain` DISABLE KEYS */;

INSERT INTO `article_plain` (`id`, `article_id`, `body`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,1,X'46726F6D3A204F54525320466565646261636B203C666565646261636B406F7472732E6F72673E0A546F3A20596F7572204F5452532053797374656D203C6F747273406C6F63616C686F73743E0A5375626A6563743A2057656C636F6D6520746F204F545253210A0A57656C636F6D65210A0A5468616E6B20796F7520666F7220696E7374616C6C696E67204F5452532E0A0A596F752077696C6C2066696E64207570646174657320616E64207061746368657320617420687474703A2F2F7777772E6F7472732E636F6D2F6F70656E2D736F757263652F2E0A4F6E6C696E6520646F63756D656E746174696F6E20697320617661696C61626C6520617420687474703A2F2F646F632E6F7472732E6F72672F2E0A596F752063616E20616C736F20757365206F7572206D61696C696E67206C6973747320687474703A2F2F6C697374732E6F7472732E6F72672F0A6F72206F757220666F72756D7320617420687474703A2F2F666F72756D732E6F7472732E6F72672F0A0A526567617264732C0A0A546865204F5452532050726F6A6563740A','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `article_plain` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table article_search
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article_search`;

CREATE TABLE `article_search` (
  `id` bigint(20) NOT NULL,
  `ticket_id` bigint(20) NOT NULL,
  `article_type_id` smallint(6) NOT NULL,
  `article_sender_type_id` smallint(6) NOT NULL,
  `a_from` text,
  `a_to` text,
  `a_cc` text,
  `a_subject` text,
  `a_body` mediumtext NOT NULL,
  `incoming_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article_search_article_sender_type_id` (`article_sender_type_id`),
  KEY `article_search_article_type_id` (`article_type_id`),
  KEY `article_search_ticket_id` (`ticket_id`),
  CONSTRAINT `FK_article_search_ticket_id_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  CONSTRAINT `FK_article_search_article_sender_type_id_id` FOREIGN KEY (`article_sender_type_id`) REFERENCES `article_sender_type` (`id`),
  CONSTRAINT `FK_article_search_article_type_id_id` FOREIGN KEY (`article_type_id`) REFERENCES `article_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table article_sender_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article_sender_type`;

CREATE TABLE `article_sender_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_sender_type_name` (`name`),
  KEY `FK_article_sender_type_create_by_id` (`create_by`),
  KEY `FK_article_sender_type_change_by_id` (`change_by`),
  KEY `FK_article_sender_type_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_article_sender_type_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_article_sender_type_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_article_sender_type_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `article_sender_type` WRITE;
/*!40000 ALTER TABLE `article_sender_type` DISABLE KEYS */;

INSERT INTO `article_sender_type` (`id`, `name`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'agent',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'system',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'customer',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `article_sender_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table article_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article_type`;

CREATE TABLE `article_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_type_name` (`name`),
  KEY `FK_article_type_create_by_id` (`create_by`),
  KEY `FK_article_type_change_by_id` (`change_by`),
  KEY `FK_article_type_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_article_type_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_article_type_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_article_type_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `article_type` WRITE;
/*!40000 ALTER TABLE `article_type` DISABLE KEYS */;

INSERT INTO `article_type` (`id`, `name`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'email-external',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'email-internal',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'email-notification-ext',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,'email-notification-int',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(5,'phone',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(6,'fax',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(7,'sms',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(8,'webrequest',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(9,'note-internal',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(10,'note-external',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(11,'note-report',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `article_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auto_response
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auto_response`;

CREATE TABLE `auto_response` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `text0` text,
  `text1` text,
  `text2` text,
  `type_id` smallint(6) NOT NULL,
  `system_address_id` smallint(6) NOT NULL,
  `charset` varchar(80) NOT NULL,
  `content_type` varchar(250) DEFAULT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auto_response_name` (`name`),
  KEY `FK_auto_response_type_id_id` (`type_id`),
  KEY `FK_auto_response_system_address_id_id` (`system_address_id`),
  KEY `FK_auto_response_create_by_id` (`create_by`),
  KEY `FK_auto_response_change_by_id` (`change_by`),
  KEY `FK_auto_response_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_auto_response_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_auto_response_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_auto_response_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_auto_response_system_address_id_id` FOREIGN KEY (`system_address_id`) REFERENCES `system_address` (`id`),
  CONSTRAINT `FK_auto_response_type_id_id` FOREIGN KEY (`type_id`) REFERENCES `auto_response_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `auto_response` WRITE;
/*!40000 ALTER TABLE `auto_response` DISABLE KEYS */;

INSERT INTO `auto_response` (`id`, `name`, `text0`, `text1`, `text2`, `type_id`, `system_address_id`, `charset`, `content_type`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'default reply (after new ticket has been created)','This is a demo text which is send to every inquiry.\nIt could contain something like:\n\nThanks for your email. A new ticket has been created.\n\nYou wrote:\n<OTRS_CUSTOMER_EMAIL[6]>\n\nYour email will be answered by a human ASAP\n\nHave fun with OTRS! :-)\n\nYour OTRS Team\n','RE: <OTRS_CUSTOMER_SUBJECT[24]>',NULL,1,1,'utf-8','text/plain','',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'default reject (after follow up and rejected of a closed ticket)','Your previous ticket is closed.\n\n-- Your follow up has been rejected. --\n\nPlease create a new ticket.\n\nYour OTRS Team\n','Your email has been rejected! (RE: <OTRS_CUSTOMER_SUBJECT[24]>)',NULL,2,1,'utf-8','text/plain','',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'default follow up (after a ticket follow up has been added)','Thanks for your follow up email\n\nYou wrote:\n<OTRS_CUSTOMER_EMAIL[6]>\n\nYour email will be answered by a human ASAP.\n\nHave fun with OTRS!\n\nYour OTRS Team\n','RE: <OTRS_CUSTOMER_SUBJECT[24]>',NULL,3,1,'utf-8','text/plain','',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,'default reject/new ticket created (after closed follow up with new ticket creation)','Your previous ticket is closed.\n\n-- A new ticket has been created for you. --\n\nYou wrote:\n<OTRS_CUSTOMER_EMAIL[6]>\n\nYour email will be answered by a human ASAP.\n\nHave fun with OTRS!\n\nYour OTRS Team\n','New ticket has been created! (RE: <OTRS_CUSTOMER_SUBJECT[24]>)',NULL,4,1,'utf-8','text/plain','',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `auto_response` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table auto_response_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `auto_response_type`;

CREATE TABLE `auto_response_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auto_response_type_name` (`name`),
  KEY `FK_auto_response_type_create_by_id` (`create_by`),
  KEY `FK_auto_response_type_change_by_id` (`change_by`),
  KEY `FK_auto_response_type_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_auto_response_type_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_auto_response_type_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_auto_response_type_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `auto_response_type` WRITE;
/*!40000 ALTER TABLE `auto_response_type` DISABLE KEYS */;

INSERT INTO `auto_response_type` (`id`, `name`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'auto reply','Auto reply which will be sent out after a new ticket has been created.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'auto reject','Auto reject which will be sent out after a follow up has been rejected (in case queue follow up option is \"reject\").',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'auto follow up','Auto follow up is sent out after a follow up has been received for a ticket (in case queue follow up option is \"possible\").',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,'auto reply/new ticket','Auto reply/new ticket which will be sent out after a follow up has been rejected and a new ticket has been created (in case queue follow up option is \"new ticket\").',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(5,'auto remove','Auto remove will be sent out after a customer removed the request.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `auto_response_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table customer_company
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_company`;

CREATE TABLE `customer_company` (
  `customer_id` varchar(150) NOT NULL,
  `name` varchar(200) NOT NULL,
  `street` varchar(200) DEFAULT NULL,
  `zip` varchar(200) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `country` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_company_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table customer_preferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_preferences`;

CREATE TABLE `customer_preferences` (
  `user_id` varchar(250) NOT NULL,
  `preferences_key` varchar(150) NOT NULL,
  `preferences_value` varchar(250) DEFAULT NULL,
  KEY `customer_preferences_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table customer_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customer_user`;

CREATE TABLE `customer_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(200) NOT NULL,
  `email` varchar(150) NOT NULL,
  `customer_id` varchar(150) NOT NULL,
  `pw` varchar(64) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `phone` varchar(150) DEFAULT NULL,
  `fax` varchar(150) DEFAULT NULL,
  `mobile` varchar(150) DEFAULT NULL,
  `street` varchar(150) DEFAULT NULL,
  `zip` varchar(200) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `country` varchar(200) DEFAULT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_user_login` (`login`),
  KEY `FK_customer_user_create_by_id` (`create_by`),
  KEY `FK_customer_user_change_by_id` (`change_by`),
  KEY `FK_customer_user_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_customer_user_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_customer_user_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_customer_user_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table dynamic_field
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dynamic_field`;

CREATE TABLE `dynamic_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `internal_field` smallint(6) NOT NULL DEFAULT '0',
  `name` varchar(200) NOT NULL,
  `label` varchar(200) NOT NULL,
  `field_order` int(11) NOT NULL,
  `field_type` varchar(200) NOT NULL,
  `object_type` varchar(200) NOT NULL,
  `config` longblob,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dynamic_field_name` (`name`),
  KEY `FK_dynamic_field_create_by_id` (`create_by`),
  KEY `FK_dynamic_field_change_by_id` (`change_by`),
  KEY `FK_dynamic_field_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_dynamic_field_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_dynamic_field_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_dynamic_field_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `dynamic_field` WRITE;
/*!40000 ALTER TABLE `dynamic_field` DISABLE KEYS */;

INSERT INTO `dynamic_field` (`id`, `internal_field`, `name`, `label`, `field_order`, `field_type`, `object_type`, `config`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,1,'ProcessManagementProcessID','ProcessManagementProcessID',1,'Text','Ticket',X'2D2D2D0A44656661756C7456616C75653A2027270A',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,1,'ProcessManagementActivityID','ProcessManagementActivityID',1,'Text','Ticket',X'2D2D2D0A44656661756C7456616C75653A2027270A',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `dynamic_field` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table dynamic_field_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `dynamic_field_value`;

CREATE TABLE `dynamic_field_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_id` int(11) NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `value_text` text,
  `value_date` datetime DEFAULT NULL,
  `value_int` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dynamic_field_value_field_values` (`object_id`),
  KEY `dynamic_field_value_search_date` (`field_id`,`value_date`),
  KEY `dynamic_field_value_search_int` (`field_id`,`value_int`),
  CONSTRAINT `FK_dynamic_field_value_field_id_id` FOREIGN KEY (`field_id`) REFERENCES `dynamic_field` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table follow_up_possible
# ------------------------------------------------------------

DROP TABLE IF EXISTS `follow_up_possible`;

CREATE TABLE `follow_up_possible` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `follow_up_possible_name` (`name`),
  KEY `FK_follow_up_possible_create_by_id` (`create_by`),
  KEY `FK_follow_up_possible_change_by_id` (`change_by`),
  KEY `FK_follow_up_possible_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_follow_up_possible_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_follow_up_possible_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_follow_up_possible_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `follow_up_possible` WRITE;
/*!40000 ALTER TABLE `follow_up_possible` DISABLE KEYS */;

INSERT INTO `follow_up_possible` (`id`, `name`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'possible','Follow ups after closed(+|-) possible. Ticket will be reopen.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'reject','Follow ups after closed(+|-) not possible. No new ticket will be created.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'new ticket','Follow ups after closed(+|-) not possible. A new ticket will be created..',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `follow_up_possible` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table generic_agent_jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `generic_agent_jobs`;

CREATE TABLE `generic_agent_jobs` (
  `job_name` varchar(200) NOT NULL,
  `job_key` varchar(200) NOT NULL,
  `job_value` varchar(200) DEFAULT NULL,
  KEY `generic_agent_jobs_job_name` (`job_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table gi_debugger_entry
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gi_debugger_entry`;

CREATE TABLE `gi_debugger_entry` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `communication_id` varchar(32) NOT NULL,
  `communication_type` varchar(50) NOT NULL,
  `remote_ip` varchar(50) DEFAULT NULL,
  `webservice_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gi_debugger_entry_communication_id` (`communication_id`),
  KEY `gi_debugger_entry_create_time` (`create_time`),
  KEY `FK_gi_debugger_entry_webservice_id_id` (`webservice_id`),
  CONSTRAINT `FK_gi_debugger_entry_webservice_id_id` FOREIGN KEY (`webservice_id`) REFERENCES `gi_webservice_config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table gi_debugger_entry_content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gi_debugger_entry_content`;

CREATE TABLE `gi_debugger_entry_content` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gi_debugger_entry_id` bigint(20) NOT NULL,
  `debug_level` varchar(50) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `content` longblob,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gi_debugger_entry_content_create_time` (`create_time`),
  KEY `gi_debugger_entry_content_debug_level` (`debug_level`),
  KEY `FK_gi_debugger_entry_content_gi_debugger_entry_id_id` (`gi_debugger_entry_id`),
  CONSTRAINT `FK_gi_debugger_entry_content_gi_debugger_entry_id_id` FOREIGN KEY (`gi_debugger_entry_id`) REFERENCES `gi_debugger_entry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table gi_object_lock_state
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gi_object_lock_state`;

CREATE TABLE `gi_object_lock_state` (
  `webservice_id` int(11) NOT NULL,
  `object_type` varchar(30) NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `lock_state` varchar(30) NOT NULL,
  `lock_state_counter` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `change_time` datetime NOT NULL,
  UNIQUE KEY `gi_object_lock_state_list` (`webservice_id`,`object_type`,`object_id`),
  KEY `object_lock_state_list_state` (`webservice_id`,`object_type`,`object_id`,`lock_state`),
  CONSTRAINT `FK_gi_object_lock_state_webservice_id_id` FOREIGN KEY (`webservice_id`) REFERENCES `gi_webservice_config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table gi_webservice_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gi_webservice_config`;

CREATE TABLE `gi_webservice_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `config` longblob NOT NULL,
  `config_md5` varchar(32) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gi_webservice_config_config_md5` (`config_md5`),
  UNIQUE KEY `gi_webservice_config_name` (`name`),
  KEY `FK_gi_webservice_config_create_by_id` (`create_by`),
  KEY `FK_gi_webservice_config_change_by_id` (`change_by`),
  KEY `FK_gi_webservice_config_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_gi_webservice_config_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_gi_webservice_config_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_gi_webservice_config_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table gi_webservice_config_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gi_webservice_config_history`;

CREATE TABLE `gi_webservice_config_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `config_id` int(11) NOT NULL,
  `config` longblob NOT NULL,
  `config_md5` varchar(32) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gi_webservice_config_history_config_md5` (`config_md5`),
  KEY `FK_gi_webservice_config_history_config_id_id` (`config_id`),
  KEY `FK_gi_webservice_config_history_create_by_id` (`create_by`),
  KEY `FK_gi_webservice_config_history_change_by_id` (`change_by`),
  CONSTRAINT `FK_gi_webservice_config_history_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_gi_webservice_config_history_config_id_id` FOREIGN KEY (`config_id`) REFERENCES `gi_webservice_config` (`id`),
  CONSTRAINT `FK_gi_webservice_config_history_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table group_customer_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `group_customer_user`;

CREATE TABLE `group_customer_user` (
  `user_id` varchar(100) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_key` varchar(20) NOT NULL,
  `permission_value` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  KEY `group_customer_user_group_id` (`group_id`),
  KEY `group_customer_user_user_id` (`user_id`),
  KEY `FK_group_customer_user_create_by_id` (`create_by`),
  KEY `FK_group_customer_user_change_by_id` (`change_by`),
  CONSTRAINT `FK_group_customer_user_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_group_customer_user_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_group_customer_user_group_id_id` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table group_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `group_role`;

CREATE TABLE `group_role` (
  `role_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_key` varchar(20) NOT NULL,
  `permission_value` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  KEY `group_role_group_id` (`group_id`),
  KEY `group_role_role_id` (`role_id`),
  KEY `FK_group_role_create_by_id` (`create_by`),
  KEY `FK_group_role_change_by_id` (`change_by`),
  CONSTRAINT `FK_group_role_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_group_role_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_group_role_group_id_id` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `FK_group_role_role_id_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table group_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `group_user`;

CREATE TABLE `group_user` (
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_key` varchar(20) NOT NULL,
  `permission_value` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  KEY `group_user_group_id` (`group_id`),
  KEY `group_user_user_id` (`user_id`),
  KEY `FK_group_user_create_by_id` (`create_by`),
  KEY `FK_group_user_change_by_id` (`change_by`),
  CONSTRAINT `FK_group_user_user_id_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_group_user_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_group_user_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_group_user_group_id_id` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `group_user` WRITE;
/*!40000 ALTER TABLE `group_user` DISABLE KEYS */;

INSERT INTO `group_user` (`user_id`, `group_id`, `permission_key`, `permission_value`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,1,'rw',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(1,2,'rw',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(1,3,'rw',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `group_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groups`;

CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `groups_name` (`name`),
  KEY `FK_groups_create_by_id` (`create_by`),
  KEY `FK_groups_change_by_id` (`change_by`),
  KEY `FK_groups_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_groups_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_groups_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_groups_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;

INSERT INTO `groups` (`id`, `name`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'users','Group for default access.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'admin','Group of all administrators.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'stats','Group for statistics access.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table link_object
# ------------------------------------------------------------

DROP TABLE IF EXISTS `link_object`;

CREATE TABLE `link_object` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_object_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table link_relation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `link_relation`;

CREATE TABLE `link_relation` (
  `source_object_id` smallint(6) NOT NULL,
  `source_key` varchar(50) NOT NULL,
  `target_object_id` smallint(6) NOT NULL,
  `target_key` varchar(50) NOT NULL,
  `type_id` smallint(6) NOT NULL,
  `state_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  UNIQUE KEY `link_relation_view` (`source_object_id`,`source_key`,`target_object_id`,`target_key`,`type_id`),
  KEY `FK_link_relation_target_object_id_id` (`target_object_id`),
  KEY `FK_link_relation_state_id_id` (`state_id`),
  KEY `FK_link_relation_type_id_id` (`type_id`),
  KEY `FK_link_relation_create_by_id` (`create_by`),
  CONSTRAINT `FK_link_relation_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_link_relation_source_object_id_id` FOREIGN KEY (`source_object_id`) REFERENCES `link_object` (`id`),
  CONSTRAINT `FK_link_relation_state_id_id` FOREIGN KEY (`state_id`) REFERENCES `link_state` (`id`),
  CONSTRAINT `FK_link_relation_target_object_id_id` FOREIGN KEY (`target_object_id`) REFERENCES `link_object` (`id`),
  CONSTRAINT `FK_link_relation_type_id_id` FOREIGN KEY (`type_id`) REFERENCES `link_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table link_state
# ------------------------------------------------------------

DROP TABLE IF EXISTS `link_state`;

CREATE TABLE `link_state` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_state_name` (`name`),
  KEY `FK_link_state_create_by_id` (`create_by`),
  KEY `FK_link_state_change_by_id` (`change_by`),
  KEY `FK_link_state_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_link_state_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_link_state_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_link_state_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `link_state` WRITE;
/*!40000 ALTER TABLE `link_state` DISABLE KEYS */;

INSERT INTO `link_state` (`id`, `name`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'Valid',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'Temporary',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `link_state` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table link_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `link_type`;

CREATE TABLE `link_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_type_name` (`name`),
  KEY `FK_link_type_create_by_id` (`create_by`),
  KEY `FK_link_type_change_by_id` (`change_by`),
  KEY `FK_link_type_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_link_type_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_link_type_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_link_type_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `link_type` WRITE;
/*!40000 ALTER TABLE `link_type` DISABLE KEYS */;

INSERT INTO `link_type` (`id`, `name`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'Normal',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'ParentChild',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `link_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table mail_account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mail_account`;

CREATE TABLE `mail_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(200) NOT NULL,
  `pw` varchar(200) NOT NULL,
  `host` varchar(200) NOT NULL,
  `account_type` varchar(20) NOT NULL,
  `queue_id` int(11) NOT NULL,
  `trusted` smallint(6) NOT NULL,
  `imap_folder` varchar(250) DEFAULT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_mail_account_create_by_id` (`create_by`),
  KEY `FK_mail_account_change_by_id` (`change_by`),
  KEY `FK_mail_account_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_mail_account_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_mail_account_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_mail_account_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notification_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notification_event`;

CREATE TABLE `notification_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `text` text NOT NULL,
  `content_type` varchar(250) NOT NULL,
  `charset` varchar(100) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notification_event_name` (`name`),
  KEY `FK_notification_event_create_by_id` (`create_by`),
  KEY `FK_notification_event_change_by_id` (`change_by`),
  KEY `FK_notification_event_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_notification_event_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_notification_event_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_notification_event_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notification_event_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notification_event_item`;

CREATE TABLE `notification_event_item` (
  `notification_id` int(11) NOT NULL,
  `event_key` varchar(200) NOT NULL,
  `event_value` varchar(200) NOT NULL,
  KEY `notification_event_item_event_key` (`event_key`),
  KEY `notification_event_item_event_value` (`event_value`),
  KEY `notification_event_item_notification_id` (`notification_id`),
  CONSTRAINT `FK_notification_event_item_notification_id_id` FOREIGN KEY (`notification_id`) REFERENCES `notification_event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notifications`;

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_type` varchar(200) NOT NULL,
  `notification_charset` varchar(60) NOT NULL,
  `notification_language` varchar(60) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `text` text NOT NULL,
  `content_type` varchar(250) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_notifications_create_by_id` (`create_by`),
  KEY `FK_notifications_change_by_id` (`change_by`),
  CONSTRAINT `FK_notifications_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_notifications_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;

INSERT INTO `notifications` (`id`, `notification_type`, `notification_charset`, `notification_language`, `subject`, `text`, `content_type`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'Agent::NewTicket','utf-8','en','New ticket notification! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_UserFirstname>,\n\nThere is a new ticket in <OTRS_TICKET_Queue>!\n\n<OTRS_CUSTOMER_FROM> wrote:\n\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'Agent::FollowUp','utf-8','en','You\'ve got a follow up! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_UserFirstname>,\n\nYou\'ve got a follow up!\n\n<OTRS_CUSTOMER_FROM> wrote:\n\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'Agent::LockTimeout','utf-8','en','Lock Timeout! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_UserFirstname>,\n\nThe lock timeout period on [<OTRS_TICKET_TicketNumber>] has been reached, it is now unlocked.\n\n<OTRS_CUSTOMER_FROM> wrote:\n\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,'Agent::OwnerUpdate','utf-8','en','Ticket owner assigned to you! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_UserFirstname>,\n\nTicket [<OTRS_TICKET_TicketNumber>] is assigned to you by <OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname>.\n\nComment:\n\n<OTRS_COMMENT>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(5,'Agent::ResponsibleUpdate','utf-8','en','Ticket assigned to you! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_RESPONSIBLE_UserFirstname>,\n\nTicket [<OTRS_TICKET_TicketNumber>] is assigned to you by <OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname>.\n\nComment:\n\n<OTRS_COMMENT>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(6,'Agent::AddNote','utf-8','en','New note! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_UserFirstname>,\n\n<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> added a new note to ticket [<OTRS_TICKET_TicketNumber>].\n\nNote:\n<OTRS_CUSTOMER_BODY>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(7,'Agent::Move','utf-8','en','Moved ticket in <OTRS_CUSTOMER_QUEUE> queue! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_UserFirstname>,\n\n<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> moved a ticket [<OTRS_TICKET_TicketNumber>] into <OTRS_CUSTOMER_QUEUE>.\n\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(8,'Agent::PendingReminder','utf-8','en','Ticket reminder has reached! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_UserFirstname>,\n\nThe ticket [<OTRS_TICKET_TicketNumber>] has reached its reminder time!\n\n<OTRS_CUSTOMER_FROM>\n\nwrote:\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\nPlease have a look at:\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(9,'Agent::Escalation','utf-8','en','Ticket Escalation! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_UserFirstname>,\n\nThe ticket [<OTRS_TICKET_TicketNumber>] is escalated!\n\nEscalated at:    <OTRS_TICKET_EscalationDestinationDate>\nEscalated since: <OTRS_TICKET_EscalationDestinationIn>\n\n<OTRS_CUSTOMER_FROM>\n\nwrote:\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\nPlease have a look at:\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(10,'Agent::EscalationNotifyBefore','utf-8','en','Ticket Escalation Warning! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hi <OTRS_UserFirstname>,\n\nThe ticket [<OTRS_TICKET_TicketNumber>] will escalate!\n\nEscalation at: <OTRS_TICKET_EscalationDestinationDate>\nEscalation in: <OTRS_TICKET_EscalationDestinationIn>\n\n<OTRS_CUSTOMER_FROM>\n\nwrote:\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\nPlease have a look at:\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nYour OTRS Notification Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(11,'Agent::NewTicket','utf-8','de','Neues Ticket! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n\nes ist ein neues Ticket in <OTRS_TICKET_Queue>!\n\n<OTRS_CUSTOMER_FROM> schrieb:\n\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(12,'Agent::FollowUp','utf-8','de','Nachfrage! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n\nSie haben eine Nachfrage bekommen!\n\n<OTRS_CUSTOMER_FROM> schrieb:\n\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(13,'Agent::LockTimeout','utf-8','de','Lock Timeout! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n\nAufhebung der Sperre auf Dein gesperrtes Ticket [<OTRS_TICKET_TicketNumber>].\n\n<OTRS_CUSTOMER_FROM> schrieb:\n\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(14,'Agent::OwnerUpdate','utf-8','de','Ticket Besitz uebertragen an Sie! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n\nDer Besitz des Tickets [<OTRS_TICKET_TicketNumber>] wurde an Sie von <OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> uebertragen.\n\nKommentar:\n\n<OTRS_COMMENT>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(15,'Agent::ResponsibleUpdate','utf-8','de','Ticket Verantwortung uebertragen an Sie! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_RESPONSIBLE_UserFirstname> <OTRS_RESPONSIBLE_UserLastname>,\n\nDie Verantwortung des Tickets [<OTRS_TICKET_TicketNumber>] wurde an Sie von <OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> uebertragen.\n\nKommentar:\n\n<OTRS_COMMENT>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(16,'Agent::AddNote','utf-8','de','Neue Notiz! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n\n<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> fuegte eine Notiz an Ticket [<OTRS_TICKET_TicketNumber>].\n\nNotiz:\n<OTRS_CUSTOMER_BODY>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(17,'Agent::Move','utf-8','de','Ticket verschoben in \"<OTRS_CUSTOMER_QUEUE>\" Queue! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n\n<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> verschob Ticket [<OTRS_TICKET_TicketNumber>] nach \"<OTRS_CUSTOMER_QUEUE>\".\n\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(18,'Agent::PendingReminder','utf-8','de','Ticket Erinnerung erreicht! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n\ndas Ticket [<OTRS_TICKET_TicketNumber>] hat die Erinnerungszeit erreicht!\n\n<OTRS_CUSTOMER_FROM>\n\nschrieb:\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\nBitte um weitere Bearbeitung:\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(19,'Agent::Escalation','utf-8','de','Ticket Eskalation! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n\ndas Ticket [<OTRS_TICKET_TicketNumber>] ist eskaliert!\n\nEskaliert am:   <OTRS_TICKET_EscalationDestinationDate>\nEskaliert seit: <OTRS_TICKET_EscalationDestinationIn>\n\n<OTRS_CUSTOMER_FROM>\n\nschrieb:\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\nBitte um Bearbeitung:\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(20,'Agent::EscalationNotifyBefore','utf-8','de','Ticket Eskalations-Warnung! (<OTRS_CUSTOMER_SUBJECT[24]>)','Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n\ndas Ticket [<OTRS_TICKET_TicketNumber>] wird bald eskalieren!\n\nEskalation um: <OTRS_TICKET_EscalationDestinationDate>\nEskalation in: <OTRS_TICKET_EscalationDestinationIn>\n\n<OTRS_CUSTOMER_FROM>\n\nschrieb:\n<snip>\n<OTRS_CUSTOMER_EMAIL[30]>\n<snip>\n\nBitte um Bearbeitung:\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n\nIhr OTRS Benachrichtigungs-Master','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(21,'Agent::NewTicket','utf-8','nl','Nieuw ticket (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_UserFirstname>,\n\nEr is een nieuw ticket aangemaakt in <OTRS_TICKET_Queue>!\n\n<OTRS_CUSTOMER_FROM> schreef:\n\n<OTRS_CUSTOMER_EMAIL[30]>\n(eerste 30 regels zijn weergegeven)\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(22,'Agent::FollowUp','utf-8','nl','Reactie ontvangen (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_UserFirstname>,\n\nEr is een reactie ontvangen op onderstaand ticket.\n\n<OTRS_CUSTOMER_FROM> schreef:\n\n<OTRS_CUSTOMER_EMAIL[30]>\n(eerste 30 regels zijn weergegeven)\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(23,'Agent::LockTimeout','utf-8','nl','Ticket ontgrendeld (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_UserFirstname>,\n\nDe bewerkingstijd van ticket [<OTRS_TICKET_TicketNumber>] is overschreden, het ticket is nu ontgrendeld.\n\n<OTRS_CUSTOMER_FROM> schreef:\n\n<OTRS_CUSTOMER_EMAIL[30]>\n(eerste 30 regels zijn weergegeven)\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(24,'Agent::OwnerUpdate','utf-8','nl','Ticket toegewezen (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_UserFirstname>,\n\nTicket [<OTRS_TICKET_TicketNumber>] is aan jou toegewezen door <OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname>.\n\nOpmerking:\n\n<OTRS_COMMENT>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(25,'Agent::ResponsibleUpdate','utf-8','nl','Verantwoordelijkheid bijgewerkt (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_RESPONSIBLE_UserFirstname>,\n\n<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> heeft je geregistreerd als verantwoordelijke voor ticket [<OTRS_TICKET_TicketNumber>].\n\nOpmerking:\n\n<OTRS_COMMENT>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(26,'Agent::AddNote','utf-8','nl','Nieuwe notitie (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_UserFirstname>,\n\n<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> heeft een nieuwe notitie toegevoegd aan [<OTRS_TICKET_TicketNumber>].\n\nNotitie:\n<OTRS_CUSTOMER_BODY>\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(27,'Agent::Move','utf-8','nl','Ticket verplaatst naar <OTRS_CUSTOMER_QUEUE> (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_UserFirstname>,\n\n<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> heeft [<OTRS_TICKET_TicketNumber>] verplaatst naar <OTRS_CUSTOMER_QUEUE>.\n\n<OTRS_CUSTOMER_EMAIL[30]>\n(eerste 30 regels zijn weergegeven)\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(28,'Agent::PendingReminder','utf-8','nl','Herinnering (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_UserFirstname>,\n\nHet herinnermoment voor ticket [<OTRS_TICKET_TicketNumber>] is bereikt.\n\n<OTRS_CUSTOMER_FROM> schreef:\n\n<OTRS_CUSTOMER_EMAIL[30]>\n(eerste 30 regels zijn weergegeven)\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(29,'Agent::Escalation','utf-8','nl','Escalatie (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_UserFirstname>,\n\nHet ticket [<OTRS_TICKET_TicketNumber>] is geëscaleerd!\n\nGeëscaleerd op:    <OTRS_TICKET_EscalationDestinationDate>\nGeëscaleerd sinds: <OTRS_TICKET_EscalationDestinationIn>\n\n<OTRS_CUSTOMER_FROM> schreef:\n\n<OTRS_CUSTOMER_EMAIL[30]>\n(eerste 30 regels zijn weergegeven)\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(30,'Agent::EscalationNotifyBefore','utf-8','nl','Ticket gaat escaleren (<OTRS_CUSTOMER_SUBJECT[24]>)','Beste <OTRS_UserFirstname>,\n\nHet ticket [<OTRS_TICKET_TicketNumber>] gaat escaleren!\n\nEscalatie op:   <OTRS_TICKET_EscalationDestinationDate>\nEscalatie over: <OTRS_TICKET_EscalationDestinationIn>\n\n<OTRS_CUSTOMER_FROM> schreef:\n\n<OTRS_CUSTOMER_EMAIL[30]>\n(eerste 30 regels zijn weergegeven)\n\n<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n','text/plain','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table package_repository
# ------------------------------------------------------------

DROP TABLE IF EXISTS `package_repository`;

CREATE TABLE `package_repository` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `version` varchar(250) NOT NULL,
  `vendor` varchar(250) NOT NULL,
  `install_status` varchar(250) NOT NULL,
  `filename` varchar(250) DEFAULT NULL,
  `content_size` varchar(30) DEFAULT NULL,
  `content_type` varchar(250) DEFAULT NULL,
  `content` longblob NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_package_repository_create_by_id` (`create_by`),
  KEY `FK_package_repository_change_by_id` (`change_by`),
  CONSTRAINT `FK_package_repository_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_package_repository_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table personal_queues
# ------------------------------------------------------------

DROP TABLE IF EXISTS `personal_queues`;

CREATE TABLE `personal_queues` (
  `user_id` int(11) NOT NULL,
  `queue_id` int(11) NOT NULL,
  KEY `personal_queues_queue_id` (`queue_id`),
  KEY `personal_queues_user_id` (`user_id`),
  CONSTRAINT `FK_personal_queues_user_id_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_personal_queues_queue_id_id` FOREIGN KEY (`queue_id`) REFERENCES `queue` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pm_activity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pm_activity`;

CREATE TABLE `pm_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `config` longblob NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pm_activity_entity_id` (`entity_id`),
  KEY `FK_pm_activity_create_by_id` (`create_by`),
  KEY `FK_pm_activity_change_by_id` (`change_by`),
  CONSTRAINT `FK_pm_activity_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_pm_activity_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pm_activity_dialog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pm_activity_dialog`;

CREATE TABLE `pm_activity_dialog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `config` longblob NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pm_activity_dialog_entity_id` (`entity_id`),
  KEY `FK_pm_activity_dialog_create_by_id` (`create_by`),
  KEY `FK_pm_activity_dialog_change_by_id` (`change_by`),
  CONSTRAINT `FK_pm_activity_dialog_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_pm_activity_dialog_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pm_entity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pm_entity`;

CREATE TABLE `pm_entity` (
  `entity_type` varchar(50) NOT NULL,
  `entity_counter` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pm_entity_sync
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pm_entity_sync`;

CREATE TABLE `pm_entity_sync` (
  `entity_type` varchar(30) NOT NULL,
  `entity_id` varchar(50) NOT NULL,
  `sync_state` varchar(30) NOT NULL,
  `create_time` datetime NOT NULL,
  `change_time` datetime NOT NULL,
  UNIQUE KEY `pm_entity_sync_list` (`entity_type`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pm_process
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pm_process`;

CREATE TABLE `pm_process` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `state_entity_id` varchar(50) NOT NULL,
  `layout` longblob NOT NULL,
  `config` longblob NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pm_process_entity_id` (`entity_id`),
  KEY `FK_pm_process_create_by_id` (`create_by`),
  KEY `FK_pm_process_change_by_id` (`change_by`),
  CONSTRAINT `FK_pm_process_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_pm_process_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pm_transition
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pm_transition`;

CREATE TABLE `pm_transition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `config` longblob NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pm_transition_entity_id` (`entity_id`),
  KEY `FK_pm_transition_create_by_id` (`create_by`),
  KEY `FK_pm_transition_change_by_id` (`change_by`),
  CONSTRAINT `FK_pm_transition_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_pm_transition_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table pm_transition_action
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pm_transition_action`;

CREATE TABLE `pm_transition_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `config` longblob NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pm_transition_action_entity_id` (`entity_id`),
  KEY `FK_pm_transition_action_create_by_id` (`create_by`),
  KEY `FK_pm_transition_action_change_by_id` (`change_by`),
  CONSTRAINT `FK_pm_transition_action_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_pm_transition_action_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table postmaster_filter
# ------------------------------------------------------------

DROP TABLE IF EXISTS `postmaster_filter`;

CREATE TABLE `postmaster_filter` (
  `f_name` varchar(200) NOT NULL,
  `f_stop` smallint(6) DEFAULT NULL,
  `f_type` varchar(20) NOT NULL,
  `f_key` varchar(200) NOT NULL,
  `f_value` varchar(200) NOT NULL,
  `f_not` smallint(6) DEFAULT NULL,
  KEY `postmaster_filter_f_name` (`f_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table process_id
# ------------------------------------------------------------

DROP TABLE IF EXISTS `process_id`;

CREATE TABLE `process_id` (
  `process_name` varchar(200) NOT NULL,
  `process_id` varchar(200) NOT NULL,
  `process_host` varchar(200) NOT NULL,
  `process_create` int(11) NOT NULL,
  `process_change` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table queue
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue`;

CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `group_id` int(11) NOT NULL,
  `unlock_timeout` int(11) DEFAULT NULL,
  `first_response_time` int(11) DEFAULT NULL,
  `first_response_notify` smallint(6) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `update_notify` smallint(6) DEFAULT NULL,
  `solution_time` int(11) DEFAULT NULL,
  `solution_notify` smallint(6) DEFAULT NULL,
  `system_address_id` smallint(6) NOT NULL,
  `calendar_name` varchar(100) DEFAULT NULL,
  `default_sign_key` varchar(100) DEFAULT NULL,
  `salutation_id` smallint(6) NOT NULL,
  `signature_id` smallint(6) NOT NULL,
  `follow_up_id` smallint(6) NOT NULL,
  `follow_up_lock` smallint(6) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `queue_name` (`name`),
  KEY `queue_group_id` (`group_id`),
  KEY `FK_queue_follow_up_id_id` (`follow_up_id`),
  KEY `FK_queue_salutation_id_id` (`salutation_id`),
  KEY `FK_queue_signature_id_id` (`signature_id`),
  KEY `FK_queue_system_address_id_id` (`system_address_id`),
  KEY `FK_queue_create_by_id` (`create_by`),
  KEY `FK_queue_change_by_id` (`change_by`),
  KEY `FK_queue_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_queue_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_queue_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_queue_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_queue_follow_up_id_id` FOREIGN KEY (`follow_up_id`) REFERENCES `follow_up_possible` (`id`),
  CONSTRAINT `FK_queue_group_id_id` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `FK_queue_salutation_id_id` FOREIGN KEY (`salutation_id`) REFERENCES `salutation` (`id`),
  CONSTRAINT `FK_queue_signature_id_id` FOREIGN KEY (`signature_id`) REFERENCES `signature` (`id`),
  CONSTRAINT `FK_queue_system_address_id_id` FOREIGN KEY (`system_address_id`) REFERENCES `system_address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;

INSERT INTO `queue` (`id`, `name`, `group_id`, `unlock_timeout`, `first_response_time`, `first_response_notify`, `update_time`, `update_notify`, `solution_time`, `solution_notify`, `system_address_id`, `calendar_name`, `default_sign_key`, `salutation_id`, `signature_id`, `follow_up_id`, `follow_up_lock`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'Postmaster',1,0,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,1,1,1,'Postmaster queue.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'Raw',1,0,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,1,1,1,'All default incoming tickets.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'Junk',1,0,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,1,1,1,'All junk tickets.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,'Misc',1,0,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,1,1,1,'All misc tickets.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue_auto_response
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue_auto_response`;

CREATE TABLE `queue_auto_response` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `queue_id` int(11) NOT NULL,
  `auto_response_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_queue_auto_response_auto_response_id_id` (`auto_response_id`),
  KEY `FK_queue_auto_response_queue_id_id` (`queue_id`),
  KEY `FK_queue_auto_response_create_by_id` (`create_by`),
  KEY `FK_queue_auto_response_change_by_id` (`change_by`),
  CONSTRAINT `FK_queue_auto_response_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_queue_auto_response_auto_response_id_id` FOREIGN KEY (`auto_response_id`) REFERENCES `auto_response` (`id`),
  CONSTRAINT `FK_queue_auto_response_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_queue_auto_response_queue_id_id` FOREIGN KEY (`queue_id`) REFERENCES `queue` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table queue_preferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue_preferences`;

CREATE TABLE `queue_preferences` (
  `queue_id` int(11) NOT NULL,
  `preferences_key` varchar(150) NOT NULL,
  `preferences_value` varchar(250) DEFAULT NULL,
  KEY `queue_preferences_queue_id` (`queue_id`),
  CONSTRAINT `FK_queue_preferences_queue_id_id` FOREIGN KEY (`queue_id`) REFERENCES `queue` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table queue_standard_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue_standard_template`;

CREATE TABLE `queue_standard_template` (
  `queue_id` int(11) NOT NULL,
  `standard_template_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  KEY `FK_queue_standard_template_queue_id_id` (`queue_id`),
  KEY `FK_queue_standard_template_standard_template_id_id` (`standard_template_id`),
  KEY `FK_queue_standard_template_create_by_id` (`create_by`),
  KEY `FK_queue_standard_template_change_by_id` (`change_by`),
  CONSTRAINT `FK_queue_standard_template_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_queue_standard_template_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_queue_standard_template_queue_id_id` FOREIGN KEY (`queue_id`) REFERENCES `queue` (`id`),
  CONSTRAINT `FK_queue_standard_template_standard_template_id_id` FOREIGN KEY (`standard_template_id`) REFERENCES `standard_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `queue_standard_template` WRITE;
/*!40000 ALTER TABLE `queue_standard_template` DISABLE KEYS */;

INSERT INTO `queue_standard_template` (`queue_id`, `standard_template_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `queue_standard_template` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table role_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `role_user`;

CREATE TABLE `role_user` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  KEY `role_user_role_id` (`role_id`),
  KEY `role_user_user_id` (`user_id`),
  KEY `FK_role_user_create_by_id` (`create_by`),
  KEY `FK_role_user_change_by_id` (`change_by`),
  CONSTRAINT `FK_role_user_user_id_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_role_user_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_role_user_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table roles
# ------------------------------------------------------------

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name` (`name`),
  KEY `FK_roles_create_by_id` (`create_by`),
  KEY `FK_roles_change_by_id` (`change_by`),
  KEY `FK_roles_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_roles_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_roles_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_roles_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table salutation
# ------------------------------------------------------------

DROP TABLE IF EXISTS `salutation`;

CREATE TABLE `salutation` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `text` text NOT NULL,
  `content_type` varchar(250) DEFAULT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `salutation_name` (`name`),
  KEY `FK_salutation_create_by_id` (`create_by`),
  KEY `FK_salutation_change_by_id` (`change_by`),
  KEY `FK_salutation_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_salutation_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_salutation_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_salutation_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `salutation` WRITE;
/*!40000 ALTER TABLE `salutation` DISABLE KEYS */;

INSERT INTO `salutation` (`id`, `name`, `text`, `content_type`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'system standard salutation (en)','Dear <OTRS_CUSTOMER_REALNAME>,\n\nThank you for your request.\n\n','text/plain; charset=utf-8','Standard Salutation.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `salutation` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table scheduler_task_list
# ------------------------------------------------------------

DROP TABLE IF EXISTS `scheduler_task_list`;

CREATE TABLE `scheduler_task_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task_data` text NOT NULL,
  `task_data_md5` varchar(32) NOT NULL,
  `task_type` varchar(200) NOT NULL,
  `due_time` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `scheduler_task_list_task_data_md5` (`task_data_md5`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table search_profile
# ------------------------------------------------------------

DROP TABLE IF EXISTS `search_profile`;

CREATE TABLE `search_profile` (
  `login` varchar(200) NOT NULL,
  `profile_name` varchar(200) NOT NULL,
  `profile_type` varchar(30) NOT NULL,
  `profile_key` varchar(200) NOT NULL,
  `profile_value` varchar(200) DEFAULT NULL,
  KEY `search_profile_login` (`login`),
  KEY `search_profile_profile_name` (`profile_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table service
# ------------------------------------------------------------

DROP TABLE IF EXISTS `service`;

CREATE TABLE `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_name` (`name`),
  KEY `FK_service_create_by_id` (`create_by`),
  KEY `FK_service_change_by_id` (`change_by`),
  CONSTRAINT `FK_service_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_service_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table service_customer_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `service_customer_user`;

CREATE TABLE `service_customer_user` (
  `customer_user_login` varchar(200) NOT NULL,
  `service_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  KEY `service_customer_user_customer_user_login` (`customer_user_login`(10)),
  KEY `service_customer_user_service_id` (`service_id`),
  KEY `FK_service_customer_user_create_by_id` (`create_by`),
  CONSTRAINT `FK_service_customer_user_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_service_customer_user_service_id_id` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table service_preferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `service_preferences`;

CREATE TABLE `service_preferences` (
  `service_id` int(11) NOT NULL,
  `preferences_key` varchar(150) NOT NULL,
  `preferences_value` varchar(250) DEFAULT NULL,
  KEY `service_preferences_service_id` (`service_id`),
  CONSTRAINT `FK_service_preferences_service_id_id` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table service_sla
# ------------------------------------------------------------

DROP TABLE IF EXISTS `service_sla`;

CREATE TABLE `service_sla` (
  `service_id` int(11) NOT NULL,
  `sla_id` int(11) NOT NULL,
  UNIQUE KEY `service_sla_service_sla` (`service_id`,`sla_id`),
  KEY `FK_service_sla_sla_id_id` (`sla_id`),
  CONSTRAINT `FK_service_sla_sla_id_id` FOREIGN KEY (`sla_id`) REFERENCES `sla` (`id`),
  CONSTRAINT `FK_service_sla_service_id_id` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(100) NOT NULL,
  `data_key` varchar(100) NOT NULL,
  `data_value` text,
  `serialized` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_data_key` (`data_key`),
  KEY `sessions_session_id_data_key` (`session_id`,`data_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `session_id`, `data_key`, `data_value`, `serialized`)
VALUES
	(1,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','AdminDynamicFieldsOverviewPageShown','25',0),
	(2,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','ChangeTime','2014-06-13 09:49:47',0),
	(3,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','CreateTime','2014-06-13 09:49:47',0),
	(4,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserAuthBackend','',0),
	(5,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserChallengeToken','CejyGmzEcjWOaYWNQ9cdhqgtDnFe1T4D',0),
	(6,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserCreateNextMask','',0),
	(7,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserEmail','root@localhost',0),
	(8,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserFirstname','Admin',0),
	(9,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserFullname','Admin OTRS',0),
	(10,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserID','1',0),
	(11,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserIsGroupRo[admin]','Yes',0),
	(12,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserIsGroupRo[stats]','Yes',0),
	(13,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserIsGroupRo[users]','Yes',0),
	(14,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserIsGroup[admin]','Yes',0),
	(15,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserIsGroup[stats]','Yes',0),
	(16,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserIsGroup[users]','Yes',0),
	(17,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserLastLogin','1402653079',0),
	(18,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserLastLoginTimestamp','2014-06-13 09:51:19',0),
	(20,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserLastname','OTRS',0),
	(21,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserLogin','root@localhost',0),
	(22,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserLoginFailed','0',0),
	(23,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserPw','690f00a20d733a82a71692c7e5a3fc466ca067a72d40db67cbc122f303bcb132',0),
	(24,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserRefreshTime','0',0),
	(25,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserRemoteAddr','172.17.42.1',0),
	(26,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserRemoteUserAgent','Mozilla/5.0 (X11; Linux x86_64; rv:29.0) Gecko/20100101 Firefox/29.0',0),
	(27,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserSendFollowUpNotification','0',0),
	(28,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserSendLockTimeoutNotification','0',0),
	(29,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserSendMoveNotification','0',0),
	(30,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserSendNewTicketNotification','0',0),
	(31,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserSendWatcherNotification','0',0),
	(32,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserSessionStart','1402653079',0),
	(33,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserTicketOverviewMediumPageShown','20',0),
	(34,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserTicketOverviewPreviewPageShown','15',0),
	(35,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserTicketOverviewSmallPageShown','25',0),
	(36,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserTitle',NULL,0),
	(37,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserType','User',0),
	(38,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','ValidID','1',0),
	(39,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','LastScreenOverview',';',0),
	(40,'tvKcTzMS3RqbCrK5HHTFdHonUsHY02l9','UserLastRequest','1402653079',0);

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table signature
# ------------------------------------------------------------

DROP TABLE IF EXISTS `signature`;

CREATE TABLE `signature` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `text` text NOT NULL,
  `content_type` varchar(250) DEFAULT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `signature_name` (`name`),
  KEY `FK_signature_create_by_id` (`create_by`),
  KEY `FK_signature_change_by_id` (`change_by`),
  KEY `FK_signature_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_signature_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_signature_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_signature_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `signature` WRITE;
/*!40000 ALTER TABLE `signature` DISABLE KEYS */;

INSERT INTO `signature` (`id`, `name`, `text`, `content_type`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'system standard signature (en)','\nYour Ticket-Team\n\n <OTRS_Agent_UserFirstname> <OTRS_Agent_UserLastname>\n\n--\n Super Support - Waterford Business Park\n 5201 Blue Lagoon Drive - 8th Floor & 9th Floor - Miami, 33126 USA\n Email: hot@example.com - Web: http://www.example.com/\n--','text/plain; charset=utf-8','Standard Signature.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `signature` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sla
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sla`;

CREATE TABLE `sla` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `calendar_name` varchar(100) DEFAULT NULL,
  `first_response_time` int(11) NOT NULL,
  `first_response_notify` smallint(6) DEFAULT NULL,
  `update_time` int(11) NOT NULL,
  `update_notify` smallint(6) DEFAULT NULL,
  `solution_time` int(11) NOT NULL,
  `solution_notify` smallint(6) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sla_name` (`name`),
  KEY `FK_sla_create_by_id` (`create_by`),
  KEY `FK_sla_change_by_id` (`change_by`),
  CONSTRAINT `FK_sla_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_sla_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table sla_preferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sla_preferences`;

CREATE TABLE `sla_preferences` (
  `sla_id` int(11) NOT NULL,
  `preferences_key` varchar(150) NOT NULL,
  `preferences_value` varchar(250) DEFAULT NULL,
  KEY `sla_preferences_sla_id` (`sla_id`),
  CONSTRAINT `FK_sla_preferences_sla_id_id` FOREIGN KEY (`sla_id`) REFERENCES `sla` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table smime_signer_cert_relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `smime_signer_cert_relations`;

CREATE TABLE `smime_signer_cert_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cert_hash` varchar(8) NOT NULL,
  `cert_fingerprint` varchar(59) NOT NULL,
  `ca_hash` varchar(8) NOT NULL,
  `ca_fingerprint` varchar(59) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_smime_signer_cert_relations_create_by_id` (`create_by`),
  KEY `FK_smime_signer_cert_relations_change_by_id` (`change_by`),
  CONSTRAINT `FK_smime_signer_cert_relations_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_smime_signer_cert_relations_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table standard_attachment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `standard_attachment`;

CREATE TABLE `standard_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `content_type` varchar(250) NOT NULL,
  `content` longblob NOT NULL,
  `filename` varchar(250) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `standard_attachment_name` (`name`),
  KEY `FK_standard_attachment_create_by_id` (`create_by`),
  KEY `FK_standard_attachment_change_by_id` (`change_by`),
  KEY `FK_standard_attachment_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_standard_attachment_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_standard_attachment_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_standard_attachment_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table standard_template
# ------------------------------------------------------------

DROP TABLE IF EXISTS `standard_template`;

CREATE TABLE `standard_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `text` text,
  `content_type` varchar(250) DEFAULT NULL,
  `template_type` varchar(100) NOT NULL DEFAULT 'Answer',
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `standard_template_name` (`name`),
  KEY `FK_standard_template_create_by_id` (`create_by`),
  KEY `FK_standard_template_change_by_id` (`change_by`),
  KEY `FK_standard_template_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_standard_template_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_standard_template_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_standard_template_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `standard_template` WRITE;
/*!40000 ALTER TABLE `standard_template` DISABLE KEYS */;

INSERT INTO `standard_template` (`id`, `name`, `text`, `content_type`, `template_type`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'empty answer','','text/plain; charset=utf-8','Answer',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'test answer','Some test answer to show how a standard template can be used.','text/plain; charset=utf-8','Answer',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `standard_template` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table standard_template_attachment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `standard_template_attachment`;

CREATE TABLE `standard_template_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `standard_attachment_id` int(11) NOT NULL,
  `standard_template_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_standard_template_attachment_standard_attachment_id_id` (`standard_attachment_id`),
  KEY `FK_standard_template_attachment_standard_template_id_id` (`standard_template_id`),
  KEY `FK_standard_template_attachment_create_by_id` (`create_by`),
  KEY `FK_standard_template_attachment_change_by_id` (`change_by`),
  CONSTRAINT `FK_standard_template_attachment_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_standard_template_attachment_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_standard_template_attachment_standard_attachment_id_id` FOREIGN KEY (`standard_attachment_id`) REFERENCES `standard_attachment` (`id`),
  CONSTRAINT `FK_standard_template_attachment_standard_template_id_id` FOREIGN KEY (`standard_template_id`) REFERENCES `standard_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table system_address
# ------------------------------------------------------------

DROP TABLE IF EXISTS `system_address`;

CREATE TABLE `system_address` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `value0` varchar(200) NOT NULL,
  `value1` varchar(200) NOT NULL,
  `value2` varchar(200) DEFAULT NULL,
  `value3` varchar(200) DEFAULT NULL,
  `queue_id` int(11) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_system_address_create_by_id` (`create_by`),
  KEY `FK_system_address_change_by_id` (`change_by`),
  KEY `FK_system_address_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_system_address_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_system_address_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_system_address_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `system_address` WRITE;
/*!40000 ALTER TABLE `system_address` DISABLE KEYS */;

INSERT INTO `system_address` (`id`, `value0`, `value1`, `value2`, `value3`, `queue_id`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'otrs@localhost','OTRS System',NULL,NULL,1,'Standard Address.',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `system_address` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table system_data
# ------------------------------------------------------------

DROP TABLE IF EXISTS `system_data`;

CREATE TABLE `system_data` (
  `data_key` varchar(160) NOT NULL,
  `data_value` longblob,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`data_key`),
  KEY `FK_system_data_create_by_id` (`create_by`),
  KEY `FK_system_data_change_by_id` (`change_by`),
  CONSTRAINT `FK_system_data_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_system_data_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ticket
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket`;

CREATE TABLE `ticket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tn` varchar(50) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `queue_id` int(11) NOT NULL,
  `ticket_lock_id` smallint(6) NOT NULL,
  `type_id` smallint(6) DEFAULT NULL,
  `service_id` int(11) DEFAULT NULL,
  `sla_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `responsible_user_id` int(11) NOT NULL,
  `ticket_priority_id` smallint(6) NOT NULL,
  `ticket_state_id` smallint(6) NOT NULL,
  `customer_id` varchar(150) DEFAULT NULL,
  `customer_user_id` varchar(250) DEFAULT NULL,
  `timeout` int(11) NOT NULL,
  `until_time` int(11) NOT NULL,
  `escalation_time` int(11) NOT NULL,
  `escalation_update_time` int(11) NOT NULL,
  `escalation_response_time` int(11) NOT NULL,
  `escalation_solution_time` int(11) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `archive_flag` smallint(6) NOT NULL DEFAULT '0',
  `create_time_unix` bigint(20) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_tn` (`tn`),
  KEY `ticket_archive_flag` (`archive_flag`),
  KEY `ticket_create_time` (`create_time`),
  KEY `ticket_create_time_unix` (`create_time_unix`),
  KEY `ticket_customer_id` (`customer_id`),
  KEY `ticket_customer_user_id` (`customer_user_id`),
  KEY `ticket_escalation_response_time` (`escalation_response_time`),
  KEY `ticket_escalation_solution_time` (`escalation_solution_time`),
  KEY `ticket_escalation_time` (`escalation_time`),
  KEY `ticket_escalation_update_time` (`escalation_update_time`),
  KEY `ticket_queue_id` (`queue_id`),
  KEY `ticket_queue_view` (`ticket_state_id`,`ticket_lock_id`),
  KEY `ticket_responsible_user_id` (`responsible_user_id`),
  KEY `ticket_ticket_lock_id` (`ticket_lock_id`),
  KEY `ticket_ticket_priority_id` (`ticket_priority_id`),
  KEY `ticket_ticket_state_id` (`ticket_state_id`),
  KEY `ticket_timeout` (`timeout`),
  KEY `ticket_title` (`title`),
  KEY `ticket_type_id` (`type_id`),
  KEY `ticket_until_time` (`until_time`),
  KEY `ticket_user_id` (`user_id`),
  KEY `FK_ticket_service_id_id` (`service_id`),
  KEY `FK_ticket_sla_id_id` (`sla_id`),
  KEY `FK_ticket_create_by_id` (`create_by`),
  KEY `FK_ticket_change_by_id` (`change_by`),
  KEY `FK_ticket_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_ticket_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_ticket_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_queue_id_id` FOREIGN KEY (`queue_id`) REFERENCES `queue` (`id`),
  CONSTRAINT `FK_ticket_responsible_user_id_id` FOREIGN KEY (`responsible_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_service_id_id` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`),
  CONSTRAINT `FK_ticket_sla_id_id` FOREIGN KEY (`sla_id`) REFERENCES `sla` (`id`),
  CONSTRAINT `FK_ticket_ticket_lock_id_id` FOREIGN KEY (`ticket_lock_id`) REFERENCES `ticket_lock_type` (`id`),
  CONSTRAINT `FK_ticket_ticket_priority_id_id` FOREIGN KEY (`ticket_priority_id`) REFERENCES `ticket_priority` (`id`),
  CONSTRAINT `FK_ticket_ticket_state_id_id` FOREIGN KEY (`ticket_state_id`) REFERENCES `ticket_state` (`id`),
  CONSTRAINT `FK_ticket_type_id_id` FOREIGN KEY (`type_id`) REFERENCES `ticket_type` (`id`),
  CONSTRAINT `FK_ticket_user_id_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;

INSERT INTO `ticket` (`id`, `tn`, `title`, `queue_id`, `ticket_lock_id`, `type_id`, `service_id`, `sla_id`, `user_id`, `responsible_user_id`, `ticket_priority_id`, `ticket_state_id`, `customer_id`, `customer_user_id`, `timeout`, `until_time`, `escalation_time`, `escalation_update_time`, `escalation_response_time`, `escalation_solution_time`, `valid_id`, `archive_flag`, `create_time_unix`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'2010080210123456','Welcome to OTRS!',2,1,NULL,NULL,NULL,1,1,3,1,NULL,NULL,0,0,0,0,0,0,1,0,1280750400,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ticket_flag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_flag`;

CREATE TABLE `ticket_flag` (
  `ticket_id` bigint(20) NOT NULL,
  `ticket_key` varchar(50) NOT NULL,
  `ticket_value` varchar(50) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  UNIQUE KEY `ticket_flag_per_user` (`ticket_id`,`ticket_key`,`create_by`),
  KEY `ticket_flag_ticket_id` (`ticket_id`),
  KEY `ticket_flag_ticket_id_create_by` (`ticket_id`,`create_by`),
  KEY `ticket_flag_ticket_id_ticket_key` (`ticket_id`,`ticket_key`),
  KEY `FK_ticket_flag_create_by_id` (`create_by`),
  CONSTRAINT `FK_ticket_flag_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_flag_ticket_id_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ticket_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_history`;

CREATE TABLE `ticket_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `history_type_id` smallint(6) NOT NULL,
  `ticket_id` bigint(20) NOT NULL,
  `article_id` bigint(20) DEFAULT NULL,
  `type_id` smallint(6) NOT NULL,
  `queue_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `priority_id` smallint(6) NOT NULL,
  `state_id` smallint(6) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_history_create_time` (`create_time`),
  KEY `ticket_history_history_type_id` (`history_type_id`),
  KEY `ticket_history_owner_id` (`owner_id`),
  KEY `ticket_history_priority_id` (`priority_id`),
  KEY `ticket_history_queue_id` (`queue_id`),
  KEY `ticket_history_state_id` (`state_id`),
  KEY `ticket_history_ticket_id` (`ticket_id`),
  KEY `ticket_history_type_id` (`type_id`),
  KEY `FK_ticket_history_article_id_id` (`article_id`),
  KEY `FK_ticket_history_create_by_id` (`create_by`),
  KEY `FK_ticket_history_change_by_id` (`change_by`),
  KEY `FK_ticket_history_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_ticket_history_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_ticket_history_article_id_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`),
  CONSTRAINT `FK_ticket_history_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_history_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_history_history_type_id_id` FOREIGN KEY (`history_type_id`) REFERENCES `ticket_history_type` (`id`),
  CONSTRAINT `FK_ticket_history_owner_id_id` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_history_priority_id_id` FOREIGN KEY (`priority_id`) REFERENCES `ticket_priority` (`id`),
  CONSTRAINT `FK_ticket_history_queue_id_id` FOREIGN KEY (`queue_id`) REFERENCES `queue` (`id`),
  CONSTRAINT `FK_ticket_history_state_id_id` FOREIGN KEY (`state_id`) REFERENCES `ticket_state` (`id`),
  CONSTRAINT `FK_ticket_history_ticket_id_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  CONSTRAINT `FK_ticket_history_type_id_id` FOREIGN KEY (`type_id`) REFERENCES `ticket_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `ticket_history` WRITE;
/*!40000 ALTER TABLE `ticket_history` DISABLE KEYS */;

INSERT INTO `ticket_history` (`id`, `name`, `history_type_id`, `ticket_id`, `article_id`, `type_id`, `queue_id`, `owner_id`, `priority_id`, `state_id`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'New Ticket [2010080210123456] created.',1,1,1,1,1,1,3,1,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `ticket_history` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ticket_history_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_history_type`;

CREATE TABLE `ticket_history_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_history_type_name` (`name`),
  KEY `FK_ticket_history_type_create_by_id` (`create_by`),
  KEY `FK_ticket_history_type_change_by_id` (`change_by`),
  KEY `FK_ticket_history_type_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_ticket_history_type_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_ticket_history_type_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_history_type_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `ticket_history_type` WRITE;
/*!40000 ALTER TABLE `ticket_history_type` DISABLE KEYS */;

INSERT INTO `ticket_history_type` (`id`, `name`, `comments`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'NewTicket',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'FollowUp',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'SendAutoReject',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,'SendAutoReply',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(5,'SendAutoFollowUp',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(6,'Forward',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(7,'Bounce',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(8,'SendAnswer',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(9,'SendAgentNotification',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(10,'SendCustomerNotification',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(11,'EmailAgent',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(12,'EmailCustomer',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(13,'PhoneCallAgent',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(14,'PhoneCallCustomer',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(15,'AddNote',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(16,'Move',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(17,'Lock',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(18,'Unlock',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(19,'Remove',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(20,'TimeAccounting',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(21,'CustomerUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(22,'PriorityUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(23,'OwnerUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(24,'LoopProtection',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(25,'Misc',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(26,'SetPendingTime',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(27,'StateUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(28,'TicketDynamicFieldUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(29,'WebRequestCustomer',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(30,'TicketLinkAdd',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(31,'TicketLinkDelete',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(32,'SystemRequest',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(33,'Merged',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(34,'ResponsibleUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(35,'Subscribe',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(36,'Unsubscribe',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(37,'TypeUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(38,'ServiceUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(39,'SLAUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(40,'ArchiveFlagUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(41,'EscalationSolutionTimeStop',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(42,'EscalationResponseTimeStart',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(43,'EscalationUpdateTimeStart',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(44,'EscalationSolutionTimeStart',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(45,'EscalationResponseTimeNotifyBefore',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(46,'EscalationUpdateTimeNotifyBefore',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(47,'EscalationSolutionTimeNotifyBefore',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(48,'EscalationResponseTimeStop',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(49,'EscalationUpdateTimeStop',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(50,'TitleUpdate',NULL,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `ticket_history_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ticket_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_index`;

CREATE TABLE `ticket_index` (
  `ticket_id` bigint(20) NOT NULL,
  `queue_id` int(11) NOT NULL,
  `queue` varchar(200) NOT NULL,
  `group_id` int(11) NOT NULL,
  `s_lock` varchar(200) NOT NULL,
  `s_state` varchar(200) NOT NULL,
  `create_time_unix` bigint(20) NOT NULL,
  KEY `ticket_index_group_id` (`group_id`),
  KEY `ticket_index_queue_id` (`queue_id`),
  KEY `ticket_index_ticket_id` (`ticket_id`),
  CONSTRAINT `FK_ticket_index_ticket_id_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  CONSTRAINT `FK_ticket_index_group_id_id` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`),
  CONSTRAINT `FK_ticket_index_queue_id_id` FOREIGN KEY (`queue_id`) REFERENCES `queue` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ticket_lock_index
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_lock_index`;

CREATE TABLE `ticket_lock_index` (
  `ticket_id` bigint(20) NOT NULL,
  KEY `ticket_lock_index_ticket_id` (`ticket_id`),
  CONSTRAINT `FK_ticket_lock_index_ticket_id_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ticket_lock_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_lock_type`;

CREATE TABLE `ticket_lock_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_lock_type_name` (`name`),
  KEY `FK_ticket_lock_type_create_by_id` (`create_by`),
  KEY `FK_ticket_lock_type_change_by_id` (`change_by`),
  KEY `FK_ticket_lock_type_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_ticket_lock_type_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_ticket_lock_type_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_lock_type_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `ticket_lock_type` WRITE;
/*!40000 ALTER TABLE `ticket_lock_type` DISABLE KEYS */;

INSERT INTO `ticket_lock_type` (`id`, `name`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'unlock',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'lock',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'tmp_lock',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `ticket_lock_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ticket_loop_protection
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_loop_protection`;

CREATE TABLE `ticket_loop_protection` (
  `sent_to` varchar(250) NOT NULL,
  `sent_date` varchar(150) NOT NULL,
  KEY `ticket_loop_protection_sent_date` (`sent_date`),
  KEY `ticket_loop_protection_sent_to` (`sent_to`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table ticket_priority
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_priority`;

CREATE TABLE `ticket_priority` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_priority_name` (`name`),
  KEY `FK_ticket_priority_create_by_id` (`create_by`),
  KEY `FK_ticket_priority_change_by_id` (`change_by`),
  CONSTRAINT `FK_ticket_priority_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_priority_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `ticket_priority` WRITE;
/*!40000 ALTER TABLE `ticket_priority` DISABLE KEYS */;

INSERT INTO `ticket_priority` (`id`, `name`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'1 very low',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'2 low',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'3 normal',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,'4 high',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(5,'5 very high',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `ticket_priority` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ticket_state
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_state`;

CREATE TABLE `ticket_state` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `type_id` smallint(6) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_state_name` (`name`),
  KEY `FK_ticket_state_type_id_id` (`type_id`),
  KEY `FK_ticket_state_create_by_id` (`create_by`),
  KEY `FK_ticket_state_change_by_id` (`change_by`),
  KEY `FK_ticket_state_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_ticket_state_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_ticket_state_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_state_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_state_type_id_id` FOREIGN KEY (`type_id`) REFERENCES `ticket_state_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `ticket_state` WRITE;
/*!40000 ALTER TABLE `ticket_state` DISABLE KEYS */;

INSERT INTO `ticket_state` (`id`, `name`, `comments`, `type_id`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'new','New ticket created by customer.',1,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'closed successful','Ticket is closed successful.',3,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'closed unsuccessful','Ticket is closed unsuccessful.',3,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,'open','Open tickets.',2,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(5,'removed','Customer removed ticket.',6,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(6,'pending reminder','Ticket is pending for agent reminder.',4,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(7,'pending auto close+','Ticket is pending for automatic close.',5,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(8,'pending auto close-','Ticket is pending for automatic close.',5,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(9,'merged','State for merged tickets.',7,1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `ticket_state` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ticket_state_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_state_type`;

CREATE TABLE `ticket_state_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_state_type_name` (`name`),
  KEY `FK_ticket_state_type_create_by_id` (`create_by`),
  KEY `FK_ticket_state_type_change_by_id` (`change_by`),
  CONSTRAINT `FK_ticket_state_type_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_state_type_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `ticket_state_type` WRITE;
/*!40000 ALTER TABLE `ticket_state_type` DISABLE KEYS */;

INSERT INTO `ticket_state_type` (`id`, `name`, `comments`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'new','All new state types (default: viewable).','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'open','All open state types (default: viewable).','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'closed','All closed state types (default: not viewable).','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(4,'pending reminder','All \'pending reminder\' state types (default: viewable).','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(5,'pending auto','All \'pending auto *\' state types (default: viewable).','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(6,'removed','All \'removed\' state types (default: not viewable).','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(7,'merged','State type for merged tickets (default: not viewable).','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `ticket_state_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ticket_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_type`;

CREATE TABLE `ticket_type` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticket_type_name` (`name`),
  KEY `FK_ticket_type_create_by_id` (`create_by`),
  KEY `FK_ticket_type_change_by_id` (`change_by`),
  KEY `FK_ticket_type_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_ticket_type_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_ticket_type_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_type_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `ticket_type` WRITE;
/*!40000 ALTER TABLE `ticket_type` DISABLE KEYS */;

INSERT INTO `ticket_type` (`id`, `name`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'Unclassified',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `ticket_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ticket_watcher
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ticket_watcher`;

CREATE TABLE `ticket_watcher` (
  `ticket_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  KEY `ticket_watcher_ticket_id` (`ticket_id`),
  KEY `ticket_watcher_user_id` (`user_id`),
  KEY `FK_ticket_watcher_create_by_id` (`create_by`),
  KEY `FK_ticket_watcher_change_by_id` (`change_by`),
  CONSTRAINT `FK_ticket_watcher_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_watcher_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ticket_watcher_ticket_id_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  CONSTRAINT `FK_ticket_watcher_user_id_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table time_accounting
# ------------------------------------------------------------

DROP TABLE IF EXISTS `time_accounting`;

CREATE TABLE `time_accounting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint(20) NOT NULL,
  `article_id` bigint(20) DEFAULT NULL,
  `time_unit` decimal(10,2) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time_accounting_ticket_id` (`ticket_id`),
  KEY `FK_time_accounting_article_id_id` (`article_id`),
  KEY `FK_time_accounting_create_by_id` (`create_by`),
  KEY `FK_time_accounting_change_by_id` (`change_by`),
  CONSTRAINT `FK_time_accounting_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_time_accounting_article_id_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`),
  CONSTRAINT `FK_time_accounting_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_time_accounting_ticket_id_id` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table user_preferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_preferences`;

CREATE TABLE `user_preferences` (
  `user_id` int(11) NOT NULL,
  `preferences_key` varchar(150) NOT NULL,
  `preferences_value` longblob,
  KEY `user_preferences_user_id` (`user_id`),
  CONSTRAINT `FK_user_preferences_user_id_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;

INSERT INTO `user_preferences` (`user_id`, `preferences_key`, `preferences_value`)
VALUES
	(1,'UserAuthBackend',''),
	(1,'UserLoginFailed',X'30'),
	(1,'UserLastLogin',X'31343032363533303739');

/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(200) NOT NULL,
  `pw` varchar(64) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `valid_id` smallint(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_login` (`login`),
  KEY `FK_users_create_by_id` (`create_by`),
  KEY `FK_users_change_by_id` (`change_by`),
  KEY `FK_users_valid_id_id` (`valid_id`),
  CONSTRAINT `FK_users_valid_id_id` FOREIGN KEY (`valid_id`) REFERENCES `valid` (`id`),
  CONSTRAINT `FK_users_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_users_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `login`, `pw`, `title`, `first_name`, `last_name`, `valid_id`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'root@localhost','690f00a20d733a82a71692c7e5a3fc466ca067a72d40db67cbc122f303bcb132',NULL,'Admin','OTRS',1,'2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table valid
# ------------------------------------------------------------

DROP TABLE IF EXISTS `valid`;

CREATE TABLE `valid` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `create_time` datetime NOT NULL,
  `create_by` int(11) NOT NULL,
  `change_time` datetime NOT NULL,
  `change_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `valid_name` (`name`),
  KEY `FK_valid_create_by_id` (`create_by`),
  KEY `FK_valid_change_by_id` (`change_by`),
  CONSTRAINT `FK_valid_change_by_id` FOREIGN KEY (`change_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_valid_create_by_id` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `valid` WRITE;
/*!40000 ALTER TABLE `valid` DISABLE KEYS */;

INSERT INTO `valid` (`id`, `name`, `create_time`, `create_by`, `change_time`, `change_by`)
VALUES
	(1,'valid','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(2,'invalid','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1),
	(3,'invalid-temporarily','2014-06-13 09:49:47',1,'2014-06-13 09:49:47',1);

/*!40000 ALTER TABLE `valid` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table virtual_fs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `virtual_fs`;

CREATE TABLE `virtual_fs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `filename` text NOT NULL,
  `backend` varchar(60) NOT NULL,
  `backend_key` varchar(160) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `virtual_fs_backend` (`backend`),
  KEY `virtual_fs_filename` (`filename`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table virtual_fs_db
# ------------------------------------------------------------

DROP TABLE IF EXISTS `virtual_fs_db`;

CREATE TABLE `virtual_fs_db` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `filename` text NOT NULL,
  `content` longblob NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `virtual_fs_db_filename` (`filename`(255))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table virtual_fs_preferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `virtual_fs_preferences`;

CREATE TABLE `virtual_fs_preferences` (
  `virtual_fs_id` bigint(20) NOT NULL,
  `preferences_key` varchar(150) NOT NULL,
  `preferences_value` text,
  KEY `virtual_fs_preferences_key_value` (`preferences_key`,`preferences_value`(150)),
  KEY `virtual_fs_preferences_virtual_fs_id` (`virtual_fs_id`),
  CONSTRAINT `FK_virtual_fs_preferences_virtual_fs_id_id` FOREIGN KEY (`virtual_fs_id`) REFERENCES `virtual_fs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table web_upload_cache
# ------------------------------------------------------------

DROP TABLE IF EXISTS `web_upload_cache`;

CREATE TABLE `web_upload_cache` (
  `form_id` varchar(250) DEFAULT NULL,
  `filename` varchar(250) DEFAULT NULL,
  `content_id` varchar(250) DEFAULT NULL,
  `content_size` varchar(30) DEFAULT NULL,
  `content_type` varchar(250) DEFAULT NULL,
  `content` longblob NOT NULL,
  `create_time_unix` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table xml_storage
# ------------------------------------------------------------

DROP TABLE IF EXISTS `xml_storage`;

CREATE TABLE `xml_storage` (
  `xml_type` varchar(200) NOT NULL,
  `xml_key` varchar(250) NOT NULL,
  `xml_content_key` varchar(250) NOT NULL,
  `xml_content_value` mediumtext,
  KEY `xml_storage_key_type` (`xml_key`(10),`xml_type`(10)),
  KEY `xml_storage_xml_content_key` (`xml_content_key`(100))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `xml_storage` WRITE;
/*!40000 ALTER TABLE `xml_storage` DISABLE KEYS */;

INSERT INTO `xml_storage` (`xml_type`, `xml_key`, `xml_content_key`, `xml_content_value`)
VALUES
	('Stats','1','[0]{\'TagKey\'}','[0]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','1'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:19'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:19'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','Monthly overview, which reports status changes per day of a selected month.'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'Content\'}','StateAction'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'File\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','Print'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}',''),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Static::StateAction'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10001'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','static'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','1'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','1'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','Changes of status in a monthly overview'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','1','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','2','[0]{\'TagKey\'}','[0]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','0'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:19'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:19'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','List of open tickets, sorted by time left until escalation deadline expires.\n\nNOTE: Please check the output and configuration of the statistics carefully to make sure that it produces the results you expect. If necessary, change the configuration before using the statistics in a production environment.'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'Content\'}',''),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'File\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','CSV'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'Content\'}','Print'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'Content\'}',''),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','TicketList'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::TicketList'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'Content\'}','Ticketlist'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10002'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','0'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','0'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','List of open tickets, sorted by time left until escalation deadline expires'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Content\'}','\n'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Element\'}','StateIDs'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Fixed\'}','1'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','1'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[2]{\'Content\'}','4'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[2]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[3]{\'Content\'}','8'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[3]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[3]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[4]{\'Content\'}','7'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[4]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[4]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[5]{\'Content\'}','6'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[5]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[5]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','OrderBy'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','EscalationTimeWorkingTime'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Content\'}','\n'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Element\'}','SortSequence'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Fixed\'}','1'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'Content\'}','Up'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','TicketAttributes'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','2','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','3','[0]{\'TagKey\'}','[0]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','0'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','List of all tickets created last month. Order by age.\n\nNOTE: Please check the output and configuration of the statistics carefully to make sure that it produces the results you expect. If necessary, change the configuration before using the statistics in a production environment.'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'Content\'}',''),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'File\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','CSV'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'Content\'}','Print'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'Content\'}',''),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','TicketList'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::TicketList'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'Content\'}','Ticketlist'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10003'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','0'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','0'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','List of tickets created last month'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Content\'}','\n'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Element\'}','Limit'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Fixed\'}','1'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','unlimited'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'Content\'}','\n'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'Element\'}','CreateTime'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'Fixed\'}','1'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'TimeRelativeCount\'}','1'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'TimeRelativeUnit\'}','Month'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','OrderBy'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','Age'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Content\'}','\n'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Element\'}','SortSequence'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Fixed\'}','1'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'Content\'}','Up'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','TicketAttributes'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','3','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','4','[0]{\'TagKey\'}','[0]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','0'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','List of all tickets closed last month. Order by age.\n\nNOTE: Please check the output and configuration of the statistics carefully to make sure that it produces the results you expect. If necessary, change the configuration before using the statistics in a production environment.'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'Content\'}',''),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'File\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','CSV'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'Content\'}','Print'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'Content\'}',''),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','TicketList'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::TicketList'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'Content\'}','Ticketlist'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10004'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','0'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','0'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','List of tickets closed last month'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Content\'}','\n'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Element\'}','Limit'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Fixed\'}','1'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','unlimited'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'Content\'}','\n'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'Element\'}','CloseTime'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'Fixed\'}','1'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'TimeRelativeCount\'}','1'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'TimeRelativeUnit\'}','Month'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','OrderBy'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','Age'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Content\'}','\n'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Element\'}','SortSequence'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Fixed\'}','1'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'Content\'}','Down'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','TicketAttributes'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','4','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','5','[0]{\'TagKey\'}','[0]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','0'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','List of tickets closed last month which required the most time to process.\n\nNOTE: Please check the output and configuration of the statistics carefully to make sure that it produces the results you expect. If necessary, change the configuration before using the statistics in a production environment.'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'Content\'}',''),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'File\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','CSV'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'Content\'}','Print'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'Content\'}',''),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','TicketList'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::TicketList'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'Content\'}','Ticketlist'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10005'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','0'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','0'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','List of the most time-consuming tickets'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Content\'}','\n'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Element\'}','Limit'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Fixed\'}','1'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','5'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'Content\'}','\n'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'Element\'}','CloseTime'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'Fixed\'}','1'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'TimeRelativeCount\'}','1'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[2]{\'TimeRelativeUnit\'}','Month'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','OrderBy'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','AccountedTime'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Content\'}','\n'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Element\'}','SortSequence'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Fixed\'}','1'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'Content\'}','Down'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','TicketAttributes'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','5','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','6','[0]{\'TagKey\'}','[0]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','0'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','List of tickets closed last month, sorted by solution time.\n\nNOTE: Please check the output and configuration of the statistics carefully to make sure that it produces the results you expect. If necessary, change the configuration before using the statistics in a production environment.'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'Content\'}',''),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'File\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','CSV'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'Content\'}','Print'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'Content\'}',''),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','TicketList'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::TicketList'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'Content\'}','Ticketlist'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10006'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','0'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','0'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','List of tickets closed, sorted by solution time'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Content\'}','\n'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Element\'}','CloseTime'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Fixed\'}','1'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TimeRelativeCount\'}','1'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TimeRelativeUnit\'}','Month'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','OrderBy'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','SolutionDiffInMin'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Content\'}','\n'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Element\'}','SortSequence'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Fixed\'}','1'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'Content\'}','Up'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','TicketAttributes'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','6','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','7','[0]{\'TagKey\'}','[0]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','0'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','List of open tickets, sorted by time left until solution deadline expires.\n\nNOTE: Please check the output and configuration of the statistics carefully to make sure that it produces the results you expect. If necessary, change the configuration before using the statistics in a production environment.'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'Content\'}',''),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'File\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','CSV'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'Content\'}','Print'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'Content\'}',''),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','TicketList'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::TicketList'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'Content\'}','Ticketlist'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10007'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','0'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','0'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','List of open tickets, sorted by time left until solution deadline expires'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Content\'}','\n'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Element\'}','StateIDs'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Fixed\'}','1'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','1'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[2]{\'Content\'}','4'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[2]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[3]{\'Content\'}','8'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[3]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[3]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[4]{\'Content\'}','7'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[4]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[4]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[5]{\'Content\'}','6'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[5]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[5]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','OrderBy'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','SolutionTimeDestinationDate'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Content\'}','\n'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Element\'}','SortSequence'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Fixed\'}','1'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'Content\'}','Up'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','TicketAttributes'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','7','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','8','[0]{\'TagKey\'}','[0]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','0'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','List of tickets closed last month, sorted by response time.\n\nNOTE: Please check the output and configuration of the statistics carefully to make sure that it produces the results you expect. If necessary, change the configuration before using the statistics in a production environment.'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'Content\'}',''),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'File\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','CSV'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'Content\'}','Print'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'Content\'}',''),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','TicketList'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::TicketList'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'Content\'}','Ticketlist'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10008'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','0'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','0'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','List of tickets closed, sorted by response time.'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Content\'}','\n'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Element\'}','CloseTime'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Fixed\'}','1'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TimeRelativeCount\'}','1'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TimeRelativeUnit\'}','Month'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','OrderBy'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','FirstResponseDiffInMin'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Content\'}','\n'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Element\'}','SortSequence'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Fixed\'}','1'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'Content\'}','Up'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','TicketAttributes'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','8','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','9','[0]{\'TagKey\'}','[0]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','0'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','Current state of all tickets in the system without time restrictions.'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','Print'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','Ticket'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::Ticket'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10009'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','1'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','1'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','Overview about all tickets in the system'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','QueueIDs'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','StateIDs'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','9','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','10','[0]{\'TagKey\'}','[0]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','Total number of new tickets per day and queue which have been created during the last month.'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','Print'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','Ticket'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::Ticket'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10010'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','New Tickets'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','QueueIDs'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','CreateTime'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','Day'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TimeRelativeCount\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TimeRelativeUnit\'}','Month'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TimeScaleCount\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','10','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]'),
	('Stats','11','[0]{\'TagKey\'}','[0]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'Content\'}','0'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Cache\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Changed\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'Content\'}','1'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ChangedBy\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Content\'}','\n'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'Content\'}','2014-06-13 09:51:20'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Created\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'Content\'}','1'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'CreatedBy\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'Content\'}','List of open tickets, sorted by time left until response deadline expires.\n\nNOTE: Please check the output and configuration of the statistics carefully to make sure that it produces the results you expect. If necessary, change the configuration before using the statistics in a production environment.'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Description\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'Content\'}',''),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'File\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'File\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'Content\'}','CSV'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'Content\'}','Print'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Format\'}[2]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'Content\'}',''),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'GraphSize\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'Content\'}','TicketList'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Object\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'Content\'}','Kernel::System::Stats::Dynamic::TicketList'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectModule\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'Content\'}','Ticketlist'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'ObjectName\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'Content\'}','3'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Permission\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'Content\'}','10011'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatNumber\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'Content\'}','dynamic'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'StatType\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'Content\'}','0'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumCol\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'Content\'}','0'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'SumRow\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'Content\'}','List of open tickets, sorted by time left until response deadline expires'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Title\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Content\'}','\n'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Element\'}','StateIDs'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'Fixed\'}','1'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','1'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[2]{\'Content\'}','4'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[2]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[3]{\'Content\'}','8'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[3]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[3]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[4]{\'Content\'}','7'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[4]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[4]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[5]{\'Content\'}','6'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[5]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'SelectedValues\'}[5]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsRestriction\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Content\'}','\n'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Element\'}','OrderBy'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'Fixed\'}','1'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'Content\'}','SolutionTimeDestinationDate'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'SelectedValues\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Content\'}','\n'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Element\'}','SortSequence'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'Fixed\'}','1'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'Content\'}','Up'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'SelectedValues\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsValueSeries\'}[2]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Content\'}','\n'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Element\'}','TicketAttributes'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'Fixed\'}','1'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'UseAsXvalue\'}[1]'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'Content\'}','1'),
	('Stats','11','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]{\'TagKey\'}','[0]{\'otrs_stats\'}[1]{\'Valid\'}[1]');

/*!40000 ALTER TABLE `xml_storage` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
