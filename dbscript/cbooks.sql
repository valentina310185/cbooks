-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2016 at 12:41 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cbooks`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `age_get`(
p_birth_date date
) RETURNS varchar(3) CHARSET latin1
begin
if p_birth_date <> '' and p_birth_date is not null then
return truncate((select datediff(date(now()), p_birth_date) / 365.25), 0);
else
return null;
end if;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `format_date`(`p_date` DATE) RETURNS varchar(20) CHARSET latin1
begin
if(p_date  is not null and p_date <> '') then
return date_format(p_date , '%m/%d/%Y');
else
return null;
end if;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `specific_age_get`(
p_birth_date date,
p_specific_date date
) RETURNS varchar(3) CHARSET latin1
begin
if p_birth_date <> '' and p_birth_date is not null then
return truncate((select datediff(date(p_specific_date), p_birth_date) / 365.25), 0);
else
return null;
end if;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `string_to_date`(
p_string_date varchar(20)
) RETURNS date
begin
if(p_string_date is not null and p_string_date <> '') then
return str_to_date(p_string_date, '%m/%d/%y');
else
return null;
end if;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cbooks_baptism`
--

CREATE TABLE IF NOT EXISTS `cbooks_baptism` (
  `baptism_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parishioner_id` bigint(20) unsigned NOT NULL,
  `parish_id` int(11) unsigned NOT NULL,
  `baptism_date` date NOT NULL,
  `baptism_godfather` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `baptism_godmother` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `baptism_book` int(11) NOT NULL,
  `baptism_page` int(11) NOT NULL,
  `baptism_number` int(11) NOT NULL,
  `baptism_celebrant` varchar(45) CHARACTER SET latin1 NOT NULL,
  `baptism_notes` varchar(300) CHARACTER SET latin1 DEFAULT NULL,
  `communion_date` date DEFAULT NULL,
  `communion_parish` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `communion_city` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_date` date DEFAULT NULL,
  `confirmation_parish` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_city` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marriage_couple_full_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marriage_couple_father_full_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marriage_couple_mother_full_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marriage_date` date DEFAULT NULL,
  `marriage_parish` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marriage_city` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`baptism_id`),
  UNIQUE KEY `parishioner_id_2` (`parishioner_id`),
  KEY `parish_id` (`parish_id`),
  KEY `parishioner_id` (`parishioner_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cbooks_civil_status`
--

CREATE TABLE IF NOT EXISTS `cbooks_civil_status` (
  `civil_status_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `civil_status_name` varchar(20) NOT NULL,
  PRIMARY KEY (`civil_status_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `cbooks_civil_status`
--

INSERT INTO `cbooks_civil_status` (`civil_status_id`, `civil_status_name`) VALUES
(1, 'Single'),
(2, 'Married'),
(3, 'Widowed');

-- --------------------------------------------------------

--
-- Table structure for table `cbooks_communion`
--

CREATE TABLE IF NOT EXISTS `cbooks_communion` (
  `communion_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parishioner_id` bigint(20) unsigned NOT NULL,
  `parish_id` int(11) unsigned NOT NULL,
  `communion_date` date NOT NULL,
  `communion_book` int(11) NOT NULL,
  `communion_page` int(11) NOT NULL,
  `communion_number` int(11) NOT NULL,
  `communion_celebrant` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `communion_notes` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`communion_id`),
  UNIQUE KEY `parishioner_id_2` (`parishioner_id`),
  KEY `parishioner_id` (`parishioner_id`),
  KEY `parish_id` (`parish_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cbooks_confirmation`
--

CREATE TABLE IF NOT EXISTS `cbooks_confirmation` (
  `confirmation_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parishioner_id` bigint(20) unsigned NOT NULL,
  `parish_id` int(11) unsigned NOT NULL,
  `confirmation_date` date NOT NULL,
  `confirmation_godfather_godmother` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `confirmation_book` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `confirmation_page` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `confirmation_number` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `confirmation_celebrant` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `confirmation_notes` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`confirmation_id`),
  UNIQUE KEY `parishioner_id_2` (`parishioner_id`),
  KEY `parishioner_id` (`parishioner_id`),
  KEY `parish_id` (`parish_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cbooks_diocese`
--

CREATE TABLE IF NOT EXISTS `cbooks_diocese` (
  `diocese_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `diocese_name` varchar(45) NOT NULL,
  `diocese_city` varchar(45) NOT NULL,
  `diocese_state` varchar(45) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`diocese_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cbooks_gender`
--

CREATE TABLE IF NOT EXISTS `cbooks_gender` (
  `gender_id` int(11) NOT NULL AUTO_INCREMENT,
  `gender_name` varchar(25) NOT NULL,
  PRIMARY KEY (`gender_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `cbooks_gender`
--

INSERT INTO `cbooks_gender` (`gender_id`, `gender_name`) VALUES
(1, 'Male'),
(2, 'Female');

-- --------------------------------------------------------

--
-- Table structure for table `cbooks_marriage`
--

CREATE TABLE IF NOT EXISTS `cbooks_marriage` (
  `marriage_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parishioner_husband_id` bigint(20) unsigned NOT NULL,
  `parishioner_wife_id` bigint(20) unsigned NOT NULL,
  `parish_id` int(11) unsigned NOT NULL,
  `marriage_date` date NOT NULL,
  `husband_civil_status_id` tinyint(3) unsigned NOT NULL,
  `wife_civil_status_id` tinyint(3) unsigned NOT NULL,
  `marriage_witness_1` varchar(45) CHARACTER SET latin1 NOT NULL,
  `marriage_witness_2` varchar(45) CHARACTER SET latin1 NOT NULL,
  `marriage_book` int(11) NOT NULL,
  `marriage_page` int(11) NOT NULL,
  `marriage_number` int(11) NOT NULL,
  `marriage_celebrant` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `marriage_notes` varchar(300) CHARACTER SET latin1 DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`marriage_id`),
  KEY `parishioner_husband_id` (`parishioner_husband_id`),
  KEY `parishioner_wife_id` (`parishioner_wife_id`),
  KEY `parish_id` (`parish_id`),
  KEY `user_id` (`user_id`),
  KEY `husband_civil_status_id` (`husband_civil_status_id`,`wife_civil_status_id`),
  KEY `wife_civil_status_id` (`wife_civil_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cbooks_parish`
--

CREATE TABLE IF NOT EXISTS `cbooks_parish` (
  `parish_id` int(11) unsigned NOT NULL,
  `diocese_id` int(11) unsigned NOT NULL,
  `parish_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `parish_city` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `parish_state` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `administrator_full_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `parish_email` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `office_hours` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `physical_address` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `postal_address` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `zipcode` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`parish_id`),
  KEY `diocese_id_fk_1` (`diocese_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cbooks_parishioner`
--

CREATE TABLE IF NOT EXISTS `cbooks_parishioner` (
  `parishioner_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parish_id` int(11) unsigned NOT NULL,
  `parishioner_first_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `parishioner_middle_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parishioner_last_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parishioner_second_last_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender_id` tinyint(3) unsigned NOT NULL,
  `parishioner_birth_place` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `parishioner_birth_date` date NOT NULL,
  `parishioner_residence` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `father_first_name` varchar(25) CHARACTER SET latin1 DEFAULT NULL,
  `father_middle_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `father_last_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `father_second_last_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `father_birth_place` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `father_birth_date` date NOT NULL,
  `father_residence` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `mother_first_name` varchar(25) CHARACTER SET latin1 DEFAULT NULL,
  `mother_middle_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mother_last_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mother_second_last_name` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mother_birth_place` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `mother_birth_date` date NOT NULL,
  `mother_residence` varchar(45) CHARACTER SET latin1 DEFAULT NULL,
  `paternal_grandfather_first_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `paternal_grandfather_last_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `paternal_grandmother_first_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `paternal_grandmother_last_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `maternal_grandfather_first_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `maternal_grandfather_last_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `maternal_grandmother_first_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `maternal_grandmother_last_name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `physical_address` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `postal_address` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` tinytext COLLATE utf8_unicode_ci,
  `user_id` int(11) unsigned NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`parishioner_id`),
  KEY `USER_ID` (`user_id`),
  KEY `PARISH_ID` (`parish_id`),
  KEY `GENDER_ID` (`gender_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_akeeba_common`
--

CREATE TABLE IF NOT EXISTS `joomla_akeeba_common` (
  `key` varchar(255) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `joomla_akeeba_common`
--

INSERT INTO `joomla_akeeba_common` (`key`, `value`) VALUES
('stats_lastrun', '1453435248'),
('stats_siteid', 'de4c754a1fcc50591e998daf0ba39c3b748d82f3'),
('stats_siteurl', '5e4e194fc470dfeb3d4d60af4ff9d84d');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_ak_profiles`
--

CREATE TABLE IF NOT EXISTS `joomla_ak_profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `configuration` longtext,
  `filters` longtext,
  `quickicon` tinyint(3) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `joomla_ak_profiles`
--

INSERT INTO `joomla_ak_profiles` (`id`, `description`, `configuration`, `filters`, `quickicon`) VALUES
(1, 'Default Backup Profile', '###AES128###UHgpIJOwJxBayq+Rwp80lEsHE4MGqhhi4wNth/Z3216VXJE3OCk0N+IcTBhNiVeTo0fBpYLw1XRBKzLmDhHU+9hK2P6br2sr4FJuooJZhW+WhcWXPAbvhUdXdKsXIKdrPGlFkWK6LyBzLAbgc2EJqBhp4iaoTEmqp5T9cduT1HDLg2lh3bBCNiL2Jhez4bM9eena++PjNWXYEQyv0XHIay2L0KAVgpOCXEE6Nao91pM0HBQuX2X5Jy0SjVIyPBglv+FJXIcQhDrR+MDETnOZHTviEX7GbdJykVh7WfA4q0lZCOjomuFSF1VcA0gTjD+6QkiFcIX2K5hjVQBoUbqmzKKQ2hQ1TozZJLcxMEB9YtfrfL5r04Y/3iS7+SGX/A1xBoRfJiD9QmkC5uG0cDinDgA+5CnInB2A8fjAw3rcKpSeRZ2pL4LgUDnG7qBGqEGzt4nIm1o0fVkoJ7vynfzWSq42p18lFbE5ES5GsV+pe7pjZ10Lu/s5b5BGS2r9Jecvr0JBSkSrOIfygVC/9fAAOFaEHoNxLONxn+1tBbPE4n4JWL7OHb+PguvyYqzQ8YTgtT1DA7cOKJ9vVi1JL8HOiFluDXWUJjPEWEd2hZkyxRwp3tEzIHCmQTnfmLWb079jOKXHrRhG8jumYHalQ/rUq93nKMtF1Feolbg712Jw+4YIOBwkmhKREnfzGqgzbViokUVoRwDaJpGZIImoAdkFXuKp8LJDeCrJvdgrEplsHXYraIcg4iPhlh3OUD+VPrr47aRYMqjXMhILP4lrab9PCRUMN/tC6FH/VbOfoA62rcRyuG5HF7WMKpnmSPDrJsNorXI3OeZiiaDy7ScjCyvzWU3bNWHIJMMKOgab2/llUDu8GhTg4e5DemK9v8pZQAImrFShGiO2hWtd/WpBzJNrcdpTHwOa1FjRpBHEiKtHd6CEnULEJIFBbWi3wRiaQ4MwMdX4GRcy0/3mBX5PHE8JJ3bwPzFtGnKN6Ce65p5Lz4Lx821yJkHFYLCIc0Jq8YLVKrGKUEoJnhFaFjnmTAZ9eK7THd6QTEwq9hW4c6le3DN3ULoFbKIY1bHs5lrddVKVuKaFPaT2TXhFxr7AzFb1Z9E+BkyWTgjANXK3FYyWZhyXYrQioIUFAl0U2EjTQAWy4ny2oFZnPYzOcsgv0BI8q+kT7k2GwiXhFXvqYQpWiLzesjjjOZUUfeu8C4OJ4YY6Liy2mm8lk1pRSYUC0KeUyVgxi6SWRy0aW0Yq2crxdG93IvtcDJcXUo1AjIfz9ZBmklK8p+cD6cajv5ucVYqv3PP/WW3Dck9kkWVPSDmxHm9xpWLCIRbQayfXYMwZBbSEARB/QlUiI6h2XEnlc+ZQFRGNNxwTGAqWdxSI+BWiX7ABZ9W28ADpSKtMicfaJp4S4nKAT3eO8Ub9r0dcDcNW+VZZmcw2w95O2hgYFTNRJsodCPOJkpt7pHUvXRbsDX90XFezAHD8DzM1BPopCPg8ocNFsSwCh7+qPZMFYqIHIS4/NOQUCnYeVM+w3yqKfP2okoBUEwFJZ7SecVIaoGoWhdLQfQneeQxOCfTk7D5cLAXuwAkNlvD+9dVray8BmGUhYn8wkWJuvjUc711dpu0imk+80QJ2fBsXej+d37j4eLoIyD3qCpCdwxIx2Avi67hIb3KGaZIWCLw8UIc7liF3fkRc1E3eIEpJJ/ucIm3A/m+froQEuIMPegrzDJtPfZFz961Gpi8gGKJJkHzw9oEukUiaUH2Bz4In48gcjCz9sxn0wGaGyBTZXvpvivmHY2LLIbKu6sYsp7swLViAtY4CQaq1yrHwWjEX7e3UpaykhOBQPdbC+ahkiCwfBdnAQxpEuIGoFjR85lTVyiraZa7XGrdor5MqRpAXoBTWB6xS7K8BWpuZt0/nBURkbidjYqvI2D4YeVd6ZZzjJypFBQlMTFZjXdUJmSg2xNWO3xafWgJULAIjdvAp1PCY2N3Gam1Sj0k1Dd4oJsvCmnP9Mw04nrKxN1+bQUhfxEY2c0BlJK4jVtqR+bk9YbYMwBM8s84jZUA5uqQWbJ2bdTFnUKIjwGOgy/nTz1HcyMKUdShX4BR8fFH2rRL/8ihLqH++aDEQ7/u34mvPr5AxmRq36+O3mYJo7bFo4bkmX/9wGbXr1B5COHUEdW1u+U46Ezz0zb1GFr7Py3EgNlkmXRKinMvLpYzgJf6SrL/Cd9zYV8U024JI1hq2JQXzN2VtaTc41YhBjlvw4ZRiy3Dg+b5Y8fwaae9VZ5zjnhKThtw37BF7iDkePxTnbJhIRoL8zlxRZchPL90RtMSFAjhCH5lX4/GynA/nX4lh/69ML/dt4+/vdSzRBgAA', 'a:2:{s:6:"tables";a:1:{s:8:"[SITEDB]";a:9:{i:2;s:16:"cbooks_communion";i:3;s:19:"cbooks_confirmation";i:4;s:14:"cbooks_diocese";i:5;s:13:"cbooks_gender";i:6;s:15:"cbooks_marriage";i:7;s:13:"cbooks_parish";i:8;s:18:"cbooks_parishioner";i:9;s:14:"cbooks_baptism";i:10;s:19:"cbooks_civil_status";}}s:9:"tabledata";a:0:{}}', 1);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_ak_stats`
--

CREATE TABLE IF NOT EXISTS `joomla_ak_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `comment` longtext,
  `backupstart` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `backupend` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` enum('run','fail','complete') NOT NULL DEFAULT 'run',
  `origin` varchar(30) NOT NULL DEFAULT 'backend',
  `type` varchar(30) NOT NULL DEFAULT 'full',
  `profile_id` bigint(20) NOT NULL DEFAULT '1',
  `archivename` longtext,
  `absolute_path` longtext,
  `multipart` int(11) NOT NULL DEFAULT '0',
  `tag` varchar(255) DEFAULT NULL,
  `backupid` varchar(255) DEFAULT NULL,
  `filesexist` tinyint(3) NOT NULL DEFAULT '1',
  `remote_filename` varchar(1000) DEFAULT NULL,
  `total_size` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_fullstatus` (`filesexist`,`status`),
  KEY `idx_stale` (`status`,`origin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_ak_storage`
--

CREATE TABLE IF NOT EXISTS `joomla_ak_storage` (
  `tag` varchar(255) NOT NULL,
  `lastupdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data` longtext,
  PRIMARY KEY (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_assets`
--

CREATE TABLE IF NOT EXISTS `joomla_assets` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=61 ;

--
-- Dumping data for table `joomla_assets`
--

INSERT INTO `joomla_assets` (`id`, `parent_id`, `lft`, `rgt`, `level`, `name`, `title`, `rules`) VALUES
(1, 0, 0, 115, 0, 'root.1', 'Root Asset', '{"core.login.site":{"6":1,"2":1},"core.login.admin":{"6":1},"core.login.offline":{"6":1},"core.admin":{"8":1},"core.manage":{"7":1},"core.create":{"6":1,"3":1},"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1},"core.edit.own":{"6":1,"3":1}}'),
(2, 1, 1, 2, 1, 'com_admin', 'com_admin', '{}'),
(3, 1, 3, 6, 1, 'com_banners', 'com_banners', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(4, 1, 7, 8, 1, 'com_cache', 'com_cache', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(5, 1, 9, 10, 1, 'com_checkin', 'com_checkin', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(6, 1, 11, 12, 1, 'com_config', 'com_config', '{}'),
(7, 1, 13, 16, 1, 'com_contact', 'com_contact', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(8, 1, 17, 24, 1, 'com_content', 'com_content', '{"core.admin":{"7":1},"core.options":[],"core.manage":{"6":1},"core.create":{"3":1},"core.delete":[],"core.edit":{"4":1},"core.edit.state":{"5":1},"core.edit.own":[]}'),
(9, 1, 25, 26, 1, 'com_cpanel', 'com_cpanel', '{}'),
(10, 1, 27, 28, 1, 'com_installer', 'com_installer', '{"core.admin":[],"core.manage":{"7":0},"core.delete":{"7":0},"core.edit.state":{"7":0}}'),
(11, 1, 29, 30, 1, 'com_languages', 'com_languages', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(12, 1, 31, 32, 1, 'com_login', 'com_login', '{}'),
(13, 1, 33, 34, 1, 'com_mailto', 'com_mailto', '{}'),
(14, 1, 35, 36, 1, 'com_massmail', 'com_massmail', '{}'),
(15, 1, 37, 38, 1, 'com_media', 'com_media', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":{"3":1},"core.delete":{"5":1}}'),
(16, 1, 39, 40, 1, 'com_menus', 'com_menus', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(17, 1, 41, 42, 1, 'com_messages', 'com_messages', '{"core.admin":{"7":1},"core.manage":{"7":1}}'),
(18, 1, 43, 76, 1, 'com_modules', 'com_modules', '{"core.admin":{"7":1},"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(19, 1, 77, 80, 1, 'com_newsfeeds', 'com_newsfeeds', '{"core.admin":{"7":1},"core.manage":{"6":1},"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(20, 1, 81, 82, 1, 'com_plugins', 'com_plugins', '{"core.admin":{"7":1},"core.manage":[],"core.edit":[],"core.edit.state":[]}'),
(21, 1, 83, 84, 1, 'com_redirect', 'com_redirect', '{"core.admin":{"7":1},"core.manage":[]}'),
(22, 1, 85, 86, 1, 'com_search', 'com_search', '{"core.admin":{"7":1},"core.manage":{"6":1}}'),
(23, 1, 87, 88, 1, 'com_templates', 'com_templates', '{"core.admin":{"7":1},"core.options":[],"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(24, 1, 89, 92, 1, 'com_users', 'com_users', '{"core.admin":{"7":1},"core.options":[],"core.manage":[],"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(26, 1, 93, 94, 1, 'com_wrapper', 'com_wrapper', '{}'),
(27, 8, 18, 23, 2, 'com_content.category.2', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(28, 3, 4, 5, 2, 'com_banners.category.3', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(29, 7, 14, 15, 2, 'com_contact.category.4', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(30, 19, 78, 79, 2, 'com_newsfeeds.category.5', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[],"core.edit.own":[]}'),
(32, 24, 90, 91, 1, 'com_users.category.7', 'Uncategorised', '{"core.create":[],"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(33, 1, 95, 96, 1, 'com_finder', 'com_finder', '{"core.admin":{"7":1},"core.manage":{"6":1}}'),
(34, 1, 97, 98, 1, 'com_joomlaupdate', 'com_joomlaupdate', '{"core.admin":[],"core.manage":[],"core.delete":[],"core.edit.state":[]}'),
(35, 1, 99, 100, 1, 'com_tags', 'com_tags', '{"core.admin":[],"core.manage":[],"core.manage":[],"core.delete":[],"core.edit.state":[]}'),
(36, 1, 101, 102, 1, 'com_contenthistory', 'com_contenthistory', '{}'),
(37, 1, 103, 104, 1, 'com_ajax', 'com_ajax', '{}'),
(38, 1, 105, 106, 1, 'com_postinstall', 'com_postinstall', '{}'),
(39, 18, 44, 45, 2, 'com_modules.module.1', 'Main Menu', '{"core.delete":[],"core.edit":[],"core.edit.state":[],"module.edit.frontend":[]}'),
(40, 18, 46, 47, 2, 'com_modules.module.2', 'Login', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(41, 18, 48, 49, 2, 'com_modules.module.3', 'Popular Articles', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(42, 18, 50, 51, 2, 'com_modules.module.4', 'Recently Added Articles', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(43, 18, 52, 53, 2, 'com_modules.module.8', 'Toolbar', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(44, 18, 54, 55, 2, 'com_modules.module.9', 'Quick Icons', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(45, 18, 56, 57, 2, 'com_modules.module.10', 'Logged-in Users', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(46, 18, 58, 59, 2, 'com_modules.module.12', 'Admin Menu', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(47, 18, 60, 61, 2, 'com_modules.module.13', 'Admin Submenu', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(48, 18, 62, 63, 2, 'com_modules.module.14', 'User Status', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(49, 18, 64, 65, 2, 'com_modules.module.15', 'Title', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(50, 18, 66, 67, 2, 'com_modules.module.16', 'Login Form', '{"core.delete":[],"core.edit":[],"core.edit.state":[],"module.edit.frontend":[]}'),
(51, 18, 68, 69, 2, 'com_modules.module.17', 'Breadcrumbs', '{"core.delete":[],"core.edit":[],"core.edit.state":[],"module.edit.frontend":[]}'),
(52, 18, 70, 71, 2, 'com_modules.module.79', 'Multilanguage status', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(53, 18, 72, 73, 2, 'com_modules.module.86', 'Joomla Version', '{"core.delete":[],"core.edit":[],"core.edit.state":[]}'),
(54, 27, 19, 20, 3, 'com_content.article.1', 'Home', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(55, 1, 107, 108, 1, 'com_jaextmanager', 'com_jaextmanager', '{}'),
(56, 1, 109, 110, 1, 'com_vjdatabasetool', 'VJ Database Tool', '{}'),
(57, 1, 111, 112, 1, 'com_quicklogout', 'Quick Logout', '{}'),
(58, 27, 21, 22, 3, 'com_content.article.2', 'Administration', '{"core.delete":{"6":1},"core.edit":{"6":1,"4":1},"core.edit.state":{"6":1,"5":1}}'),
(59, 18, 74, 75, 2, 'com_modules.module.87', 'Translate', '{"core.delete":[],"core.edit":[],"core.edit.state":[],"module.edit.frontend":[]}'),
(60, 1, 113, 114, 1, 'com_akeeba', 'Akeeba', '{}');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_associations`
--

CREATE TABLE IF NOT EXISTS `joomla_associations` (
  `id` int(11) NOT NULL COMMENT 'A reference to the associated item.',
  `context` varchar(50) NOT NULL COMMENT 'The context of the associated item.',
  `key` char(32) NOT NULL COMMENT 'The key for the association computed from an md5 on associated ids.',
  PRIMARY KEY (`context`,`id`),
  KEY `idx_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_banners`
--

CREATE TABLE IF NOT EXISTS `joomla_banners` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_banner_clients`
--

CREATE TABLE IF NOT EXISTS `joomla_banner_clients` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_banner_tracks`
--

CREATE TABLE IF NOT EXISTS `joomla_banner_tracks` (
  `track_date` datetime NOT NULL,
  `track_type` int(10) unsigned NOT NULL,
  `banner_id` int(10) unsigned NOT NULL,
  `count` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`track_date`,`track_type`,`banner_id`),
  KEY `idx_track_date` (`track_date`),
  KEY `idx_track_type` (`track_type`),
  KEY `idx_banner_id` (`banner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_categories`
--

CREATE TABLE IF NOT EXISTS `joomla_categories` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `joomla_categories`
--

INSERT INTO `joomla_categories` (`id`, `asset_id`, `parent_id`, `lft`, `rgt`, `level`, `path`, `extension`, `title`, `alias`, `note`, `description`, `published`, `checked_out`, `checked_out_time`, `access`, `params`, `metadesc`, `metakey`, `metadata`, `created_user_id`, `created_time`, `modified_user_id`, `modified_time`, `hits`, `language`, `version`) VALUES
(1, 0, 0, 0, 11, 0, '', 'system', 'ROOT', 'root', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{}', '', '', '{}', 42, '2011-01-01 00:00:01', 0, '0000-00-00 00:00:00', 0, '*', 1),
(2, 27, 1, 1, 2, 1, 'uncategorised', 'com_content', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 42, '2011-01-01 00:00:01', 0, '0000-00-00 00:00:00', 0, '*', 1),
(3, 28, 1, 3, 4, 1, 'uncategorised', 'com_banners', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 42, '2011-01-01 00:00:01', 0, '0000-00-00 00:00:00', 0, '*', 1),
(4, 29, 1, 5, 6, 1, 'uncategorised', 'com_contact', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 42, '2011-01-01 00:00:01', 0, '0000-00-00 00:00:00', 0, '*', 1),
(5, 30, 1, 7, 8, 1, 'uncategorised', 'com_newsfeeds', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 42, '2011-01-01 00:00:01', 0, '0000-00-00 00:00:00', 0, '*', 1),
(7, 32, 1, 9, 10, 1, 'uncategorised', 'com_users', 'Uncategorised', 'uncategorised', '', '', 1, 0, '0000-00-00 00:00:00', 1, '{"category_layout":"","image":""}', '', '', '{"author":"","robots":""}', 42, '2011-01-01 00:00:01', 0, '0000-00-00 00:00:00', 0, '*', 1);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_contact_details`
--

CREATE TABLE IF NOT EXISTS `joomla_contact_details` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_content`
--

CREATE TABLE IF NOT EXISTS `joomla_content` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `joomla_content`
--

INSERT INTO `joomla_content` (`id`, `asset_id`, `title`, `alias`, `introtext`, `fulltext`, `state`, `catid`, `created`, `created_by`, `created_by_alias`, `modified`, `modified_by`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `images`, `urls`, `attribs`, `version`, `ordering`, `metakey`, `metadesc`, `access`, `hits`, `metadata`, `featured`, `language`, `xreference`) VALUES
(1, 54, 'Home', 'home', '<p>{source}<br />&lt;?php<br /><img src="media/sourcerer/images/tab.png" alt="" />$user = JFactory::getUser();<br /><br /><img src="media/sourcerer/images/tab.png" alt="" />if($user-&gt;guest)<br /><img src="media/sourcerer/images/tab.png" alt="" />{<br />?&gt;<br /><img src="media/sourcerer/images/tab.png" alt="" />&lt;h3&gt;<br /><img src="media/sourcerer/images/tab.png" alt="" /><img src="media/sourcerer/images/tab.png" alt="" />Welcome to Cbooks!<br /><img src="media/sourcerer/images/tab.png" alt="" />&lt;/h3&gt;<br /><img src="media/sourcerer/images/tab.png" alt="" />&lt;h6&gt;<br /><img src="media/sourcerer/images/tab.png" alt="" /><img src="media/sourcerer/images/tab.png" alt="" />Please enter your username and password to login to the system!<br /><img src="media/sourcerer/images/tab.png" alt="" />&lt;/h6&gt;<br />&lt;?php<br /><img src="media/sourcerer/images/tab.png" alt="" />}<br />?&gt;<br />{/source}</p>\r\n<p>{module Login Form}</p>', '', 1, 2, '2015-11-15 04:13:31', 458, '', '2015-11-22 05:20:33', 458, 0, '0000-00-00 00:00:00', '2015-11-15 04:13:31', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":false,"urlatext":"","targeta":"","urlb":false,"urlbtext":"","targetb":"","urlc":false,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_tags":"","show_intro":"","info_block_position":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":"","extra-class":""}', 14, 1, '', '', 1, 276, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', ''),
(2, 58, 'Administration', 'administration', '<p>{source}<span style="font-family: courier new, courier, monospace;"><br />&lt;link href="css/font-awesome/css/font-awesome.min.css" rel="stylesheet"&gt;<br />&lt;link href="css/animate.min.css" rel="stylesheet"&gt;<br />&lt;link href="css/custom.css" rel="stylesheet"&gt;<br />&lt;script src="js/loader.js"&gt;&lt;/script&gt;<br />&lt;div id="main-content"&gt;<br />&lt;?php<br />require_once "php/lazy/menu.php";<br />Menu::ButtonsBig("sacraments");<br />?&gt;<br />&lt;/div&gt;<br /></span>{/source}</p>', '', 1, 2, '2015-11-22 05:12:13', 458, '', '2016-01-22 01:12:59', 458, 0, '0000-00-00 00:00:00', '2015-11-22 05:12:13', '0000-00-00 00:00:00', '{"image_intro":"","float_intro":"","image_intro_alt":"","image_intro_caption":"","image_fulltext":"","float_fulltext":"","image_fulltext_alt":"","image_fulltext_caption":""}', '{"urla":false,"urlatext":"","targeta":"","urlb":false,"urlbtext":"","targetb":"","urlc":false,"urlctext":"","targetc":""}', '{"show_title":"","link_titles":"","show_tags":"","show_intro":"","info_block_position":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_vote":"","show_hits":"","show_noauth":"","urls_position":"","alternative_readmore":"","article_layout":"","show_publishing_options":"","show_article_options":"","show_urls_images_backend":"","show_urls_images_frontend":"","extra-class":""}', 7, 0, '', '', 2, 284, '{"robots":"","author":"","rights":"","xreference":""}', 0, '*', '');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_contentitem_tag_map`
--

CREATE TABLE IF NOT EXISTS `joomla_contentitem_tag_map` (
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

-- --------------------------------------------------------

--
-- Table structure for table `joomla_content_frontpage`
--

CREATE TABLE IF NOT EXISTS `joomla_content_frontpage` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `ordering` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_content_rating`
--

CREATE TABLE IF NOT EXISTS `joomla_content_rating` (
  `content_id` int(11) NOT NULL DEFAULT '0',
  `rating_sum` int(10) unsigned NOT NULL DEFAULT '0',
  `rating_count` int(10) unsigned NOT NULL DEFAULT '0',
  `lastip` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_content_types`
--

CREATE TABLE IF NOT EXISTS `joomla_content_types` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `joomla_content_types`
--

INSERT INTO `joomla_content_types` (`type_id`, `type_title`, `type_alias`, `table`, `rules`, `field_mappings`, `router`, `content_history_options`) VALUES
(1, 'Article', 'com_content.article', '{"special":{"dbtable":"#__content","key":"id","type":"Content","prefix":"JTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"title","core_state":"state","core_alias":"alias","core_created_time":"created","core_modified_time":"modified","core_body":"introtext", "core_hits":"hits","core_publish_up":"publish_up","core_publish_down":"publish_down","core_access":"access", "core_params":"attribs", "core_featured":"featured", "core_metadata":"metadata", "core_language":"language", "core_images":"images", "core_urls":"urls", "core_version":"version", "core_ordering":"ordering", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"catid", "core_xreference":"xreference", "asset_id":"asset_id"}, "special":{"fulltext":"fulltext"}}', 'ContentHelperRoute::getArticleRoute', '{"formFile":"administrator\\/components\\/com_content\\/models\\/forms\\/article.xml", "hideFields":["asset_id","checked_out","checked_out_time","version"],"ignoreChanges":["modified_by", "modified", "checked_out", "checked_out_time", "version", "hits"],"convertToInt":["publish_up", "publish_down", "featured", "ordering"],"displayLookup":[{"sourceColumn":"catid","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"created_by","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"access","targetTable":"#__viewlevels","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"modified_by","targetTable":"#__users","targetColumn":"id","displayColumn":"name"} ]}'),
(2, 'Contact', 'com_contact.contact', '{"special":{"dbtable":"#__contact_details","key":"id","type":"Contact","prefix":"ContactTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"name","core_state":"published","core_alias":"alias","core_created_time":"created","core_modified_time":"modified","core_body":"address", "core_hits":"hits","core_publish_up":"publish_up","core_publish_down":"publish_down","core_access":"access", "core_params":"params", "core_featured":"featured", "core_metadata":"metadata", "core_language":"language", "core_images":"image", "core_urls":"webpage", "core_version":"version", "core_ordering":"ordering", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"catid", "core_xreference":"xreference", "asset_id":"null"}, "special":{"con_position":"con_position","suburb":"suburb","state":"state","country":"country","postcode":"postcode","telephone":"telephone","fax":"fax","misc":"misc","email_to":"email_to","default_con":"default_con","user_id":"user_id","mobile":"mobile","sortname1":"sortname1","sortname2":"sortname2","sortname3":"sortname3"}}', 'ContactHelperRoute::getContactRoute', '{"formFile":"administrator\\/components\\/com_contact\\/models\\/forms\\/contact.xml","hideFields":["default_con","checked_out","checked_out_time","version","xreference"],"ignoreChanges":["modified_by", "modified", "checked_out", "checked_out_time", "version", "hits"],"convertToInt":["publish_up", "publish_down", "featured", "ordering"], "displayLookup":[ {"sourceColumn":"created_by","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"catid","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"modified_by","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"access","targetTable":"#__viewlevels","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"} ] }'),
(3, 'Newsfeed', 'com_newsfeeds.newsfeed', '{"special":{"dbtable":"#__newsfeeds","key":"id","type":"Newsfeed","prefix":"NewsfeedsTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"name","core_state":"published","core_alias":"alias","core_created_time":"created","core_modified_time":"modified","core_body":"description", "core_hits":"hits","core_publish_up":"publish_up","core_publish_down":"publish_down","core_access":"access", "core_params":"params", "core_featured":"featured", "core_metadata":"metadata", "core_language":"language", "core_images":"images", "core_urls":"link", "core_version":"version", "core_ordering":"ordering", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"catid", "core_xreference":"xreference", "asset_id":"null"}, "special":{"numarticles":"numarticles","cache_time":"cache_time","rtl":"rtl"}}', 'NewsfeedsHelperRoute::getNewsfeedRoute', '{"formFile":"administrator\\/components\\/com_newsfeeds\\/models\\/forms\\/newsfeed.xml","hideFields":["asset_id","checked_out","checked_out_time","version"],"ignoreChanges":["modified_by", "modified", "checked_out", "checked_out_time", "version", "hits"],"convertToInt":["publish_up", "publish_down", "featured", "ordering"],"displayLookup":[{"sourceColumn":"catid","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"created_by","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"access","targetTable":"#__viewlevels","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"modified_by","targetTable":"#__users","targetColumn":"id","displayColumn":"name"} ]}'),
(4, 'User', 'com_users.user', '{"special":{"dbtable":"#__users","key":"id","type":"User","prefix":"JTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"name","core_state":"null","core_alias":"username","core_created_time":"registerdate","core_modified_time":"lastvisitDate","core_body":"null", "core_hits":"null","core_publish_up":"null","core_publish_down":"null","access":"null", "core_params":"params", "core_featured":"null", "core_metadata":"null", "core_language":"null", "core_images":"null", "core_urls":"null", "core_version":"null", "core_ordering":"null", "core_metakey":"null", "core_metadesc":"null", "core_catid":"null", "core_xreference":"null", "asset_id":"null"}, "special":{}}', 'UsersHelperRoute::getUserRoute', ''),
(5, 'Article Category', 'com_content.category', '{"special":{"dbtable":"#__categories","key":"id","type":"Category","prefix":"JTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"title","core_state":"published","core_alias":"alias","core_created_time":"created_time","core_modified_time":"modified_time","core_body":"description", "core_hits":"hits","core_publish_up":"null","core_publish_down":"null","core_access":"access", "core_params":"params", "core_featured":"null", "core_metadata":"metadata", "core_language":"language", "core_images":"null", "core_urls":"null", "core_version":"version", "core_ordering":"null", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"parent_id", "core_xreference":"null", "asset_id":"asset_id"}, "special":{"parent_id":"parent_id","lft":"lft","rgt":"rgt","level":"level","path":"path","extension":"extension","note":"note"}}', 'ContentHelperRoute::getCategoryRoute', '{"formFile":"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml", "hideFields":["asset_id","checked_out","checked_out_time","version","lft","rgt","level","path","extension"], "ignoreChanges":["modified_user_id", "modified_time", "checked_out", "checked_out_time", "version", "hits", "path"],"convertToInt":["publish_up", "publish_down"], "displayLookup":[{"sourceColumn":"created_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"access","targetTable":"#__viewlevels","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"modified_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"parent_id","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"}]}'),
(6, 'Contact Category', 'com_contact.category', '{"special":{"dbtable":"#__categories","key":"id","type":"Category","prefix":"JTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"title","core_state":"published","core_alias":"alias","core_created_time":"created_time","core_modified_time":"modified_time","core_body":"description", "core_hits":"hits","core_publish_up":"null","core_publish_down":"null","core_access":"access", "core_params":"params", "core_featured":"null", "core_metadata":"metadata", "core_language":"language", "core_images":"null", "core_urls":"null", "core_version":"version", "core_ordering":"null", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"parent_id", "core_xreference":"null", "asset_id":"asset_id"}, "special":{"parent_id":"parent_id","lft":"lft","rgt":"rgt","level":"level","path":"path","extension":"extension","note":"note"}}', 'ContactHelperRoute::getCategoryRoute', '{"formFile":"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml", "hideFields":["asset_id","checked_out","checked_out_time","version","lft","rgt","level","path","extension"], "ignoreChanges":["modified_user_id", "modified_time", "checked_out", "checked_out_time", "version", "hits", "path"],"convertToInt":["publish_up", "publish_down"], "displayLookup":[{"sourceColumn":"created_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"access","targetTable":"#__viewlevels","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"modified_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"parent_id","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"}]}'),
(7, 'Newsfeeds Category', 'com_newsfeeds.category', '{"special":{"dbtable":"#__categories","key":"id","type":"Category","prefix":"JTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"title","core_state":"published","core_alias":"alias","core_created_time":"created_time","core_modified_time":"modified_time","core_body":"description", "core_hits":"hits","core_publish_up":"null","core_publish_down":"null","core_access":"access", "core_params":"params", "core_featured":"null", "core_metadata":"metadata", "core_language":"language", "core_images":"null", "core_urls":"null", "core_version":"version", "core_ordering":"null", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"parent_id", "core_xreference":"null", "asset_id":"asset_id"}, "special":{"parent_id":"parent_id","lft":"lft","rgt":"rgt","level":"level","path":"path","extension":"extension","note":"note"}}', 'NewsfeedsHelperRoute::getCategoryRoute', '{"formFile":"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml", "hideFields":["asset_id","checked_out","checked_out_time","version","lft","rgt","level","path","extension"], "ignoreChanges":["modified_user_id", "modified_time", "checked_out", "checked_out_time", "version", "hits", "path"],"convertToInt":["publish_up", "publish_down"], "displayLookup":[{"sourceColumn":"created_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"access","targetTable":"#__viewlevels","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"modified_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"parent_id","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"}]}'),
(8, 'Tag', 'com_tags.tag', '{"special":{"dbtable":"#__tags","key":"tag_id","type":"Tag","prefix":"TagsTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"title","core_state":"published","core_alias":"alias","core_created_time":"created_time","core_modified_time":"modified_time","core_body":"description", "core_hits":"hits","core_publish_up":"null","core_publish_down":"null","core_access":"access", "core_params":"params", "core_featured":"featured", "core_metadata":"metadata", "core_language":"language", "core_images":"images", "core_urls":"urls", "core_version":"version", "core_ordering":"null", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"null", "core_xreference":"null", "asset_id":"null"}, "special":{"parent_id":"parent_id","lft":"lft","rgt":"rgt","level":"level","path":"path"}}', 'TagsHelperRoute::getTagRoute', '{"formFile":"administrator\\/components\\/com_tags\\/models\\/forms\\/tag.xml", "hideFields":["checked_out","checked_out_time","version", "lft", "rgt", "level", "path", "urls", "publish_up", "publish_down"],"ignoreChanges":["modified_user_id", "modified_time", "checked_out", "checked_out_time", "version", "hits", "path"],"convertToInt":["publish_up", "publish_down"], "displayLookup":[{"sourceColumn":"created_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"}, {"sourceColumn":"access","targetTable":"#__viewlevels","targetColumn":"id","displayColumn":"title"}, {"sourceColumn":"modified_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"}]}'),
(9, 'Banner', 'com_banners.banner', '{"special":{"dbtable":"#__banners","key":"id","type":"Banner","prefix":"BannersTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"name","core_state":"published","core_alias":"alias","core_created_time":"created","core_modified_time":"modified","core_body":"description", "core_hits":"null","core_publish_up":"publish_up","core_publish_down":"publish_down","core_access":"access", "core_params":"params", "core_featured":"null", "core_metadata":"metadata", "core_language":"language", "core_images":"images", "core_urls":"link", "core_version":"version", "core_ordering":"ordering", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"catid", "core_xreference":"null", "asset_id":"null"}, "special":{"imptotal":"imptotal", "impmade":"impmade", "clicks":"clicks", "clickurl":"clickurl", "custombannercode":"custombannercode", "cid":"cid", "purchase_type":"purchase_type", "track_impressions":"track_impressions", "track_clicks":"track_clicks"}}', '', '{"formFile":"administrator\\/components\\/com_banners\\/models\\/forms\\/banner.xml", "hideFields":["checked_out","checked_out_time","version", "reset"],"ignoreChanges":["modified_by", "modified", "checked_out", "checked_out_time", "version", "imptotal", "impmade", "reset"], "convertToInt":["publish_up", "publish_down", "ordering"], "displayLookup":[{"sourceColumn":"catid","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"}, {"sourceColumn":"cid","targetTable":"#__banner_clients","targetColumn":"id","displayColumn":"name"}, {"sourceColumn":"created_by","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"modified_by","targetTable":"#__users","targetColumn":"id","displayColumn":"name"} ]}'),
(10, 'Banners Category', 'com_banners.category', '{"special":{"dbtable":"#__categories","key":"id","type":"Category","prefix":"JTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"title","core_state":"published","core_alias":"alias","core_created_time":"created_time","core_modified_time":"modified_time","core_body":"description", "core_hits":"hits","core_publish_up":"null","core_publish_down":"null","core_access":"access", "core_params":"params", "core_featured":"null", "core_metadata":"metadata", "core_language":"language", "core_images":"null", "core_urls":"null", "core_version":"version", "core_ordering":"null", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"parent_id", "core_xreference":"null", "asset_id":"asset_id"}, "special": {"parent_id":"parent_id","lft":"lft","rgt":"rgt","level":"level","path":"path","extension":"extension","note":"note"}}', '', '{"formFile":"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml", "hideFields":["asset_id","checked_out","checked_out_time","version","lft","rgt","level","path","extension"], "ignoreChanges":["modified_user_id", "modified_time", "checked_out", "checked_out_time", "version", "hits", "path"], "convertToInt":["publish_up", "publish_down"], "displayLookup":[{"sourceColumn":"created_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"access","targetTable":"#__viewlevels","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"modified_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"parent_id","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"}]}'),
(11, 'Banner Client', 'com_banners.client', '{"special":{"dbtable":"#__banner_clients","key":"id","type":"Client","prefix":"BannersTable"}}', '', '', '', '{"formFile":"administrator\\/components\\/com_banners\\/models\\/forms\\/client.xml", "hideFields":["checked_out","checked_out_time"], "ignoreChanges":["checked_out", "checked_out_time"], "convertToInt":[], "displayLookup":[]}'),
(12, 'User Notes', 'com_users.note', '{"special":{"dbtable":"#__user_notes","key":"id","type":"Note","prefix":"UsersTable"}}', '', '', '', '{"formFile":"administrator\\/components\\/com_users\\/models\\/forms\\/note.xml", "hideFields":["checked_out","checked_out_time", "publish_up", "publish_down"],"ignoreChanges":["modified_user_id", "modified_time", "checked_out", "checked_out_time"], "convertToInt":["publish_up", "publish_down"],"displayLookup":[{"sourceColumn":"catid","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"}, {"sourceColumn":"created_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"}, {"sourceColumn":"user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"}, {"sourceColumn":"modified_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"}]}'),
(13, 'User Notes Category', 'com_users.category', '{"special":{"dbtable":"#__categories","key":"id","type":"Category","prefix":"JTable","config":"array()"},"common":{"dbtable":"#__ucm_content","key":"ucm_id","type":"Corecontent","prefix":"JTable","config":"array()"}}', '', '{"common":{"core_content_item_id":"id","core_title":"title","core_state":"published","core_alias":"alias","core_created_time":"created_time","core_modified_time":"modified_time","core_body":"description", "core_hits":"hits","core_publish_up":"null","core_publish_down":"null","core_access":"access", "core_params":"params", "core_featured":"null", "core_metadata":"metadata", "core_language":"language", "core_images":"null", "core_urls":"null", "core_version":"version", "core_ordering":"null", "core_metakey":"metakey", "core_metadesc":"metadesc", "core_catid":"parent_id", "core_xreference":"null", "asset_id":"asset_id"}, "special":{"parent_id":"parent_id","lft":"lft","rgt":"rgt","level":"level","path":"path","extension":"extension","note":"note"}}', '', '{"formFile":"administrator\\/components\\/com_categories\\/models\\/forms\\/category.xml", "hideFields":["checked_out","checked_out_time","version","lft","rgt","level","path","extension"], "ignoreChanges":["modified_user_id", "modified_time", "checked_out", "checked_out_time", "version", "hits", "path"], "convertToInt":["publish_up", "publish_down"], "displayLookup":[{"sourceColumn":"created_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"}, {"sourceColumn":"access","targetTable":"#__viewlevels","targetColumn":"id","displayColumn":"title"},{"sourceColumn":"modified_user_id","targetTable":"#__users","targetColumn":"id","displayColumn":"name"},{"sourceColumn":"parent_id","targetTable":"#__categories","targetColumn":"id","displayColumn":"title"}]}');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_core_log_searches`
--

CREATE TABLE IF NOT EXISTS `joomla_core_log_searches` (
  `search_term` varchar(128) NOT NULL DEFAULT '',
  `hits` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_example_items`
--

CREATE TABLE IF NOT EXISTS `joomla_example_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_extensions`
--

CREATE TABLE IF NOT EXISTS `joomla_extensions` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10018 ;

--
-- Dumping data for table `joomla_extensions`
--

INSERT INTO `joomla_extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(1, 'com_mailto', 'component', 'com_mailto', '', 0, 1, 1, 1, '{"name":"com_mailto","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_MAILTO_XML_DESCRIPTION","group":"","filename":"mailto"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(2, 'com_wrapper', 'component', 'com_wrapper', '', 0, 1, 1, 1, '{"name":"com_wrapper","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.\\n\\t","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_WRAPPER_XML_DESCRIPTION","group":"","filename":"wrapper"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(3, 'com_admin', 'component', 'com_admin', '', 1, 1, 1, 1, '{"name":"com_admin","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_ADMIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(4, 'com_banners', 'component', 'com_banners', '', 1, 1, 1, 0, '{"name":"com_banners","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_BANNERS_XML_DESCRIPTION","group":"","filename":"banners"}', '{"purchase_type":"3","track_impressions":"0","track_clicks":"0","metakey_prefix":"","save_history":"1","history_limit":10}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(5, 'com_cache', 'component', 'com_cache', '', 1, 1, 1, 1, '{"name":"com_cache","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_CACHE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(6, 'com_categories', 'component', 'com_categories', '', 1, 1, 1, 1, '{"name":"com_categories","type":"component","creationDate":"December 2007","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_CATEGORIES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(7, 'com_checkin', 'component', 'com_checkin', '', 1, 1, 1, 1, '{"name":"com_checkin","type":"component","creationDate":"Unknown","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_CHECKIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(8, 'com_contact', 'component', 'com_contact', '', 1, 1, 1, 0, '{"name":"com_contact","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_CONTACT_XML_DESCRIPTION","group":"","filename":"contact"}', '{"show_contact_category":"hide","save_history":"1","history_limit":10,"show_contact_list":"0","presentation_style":"sliders","show_name":"1","show_position":"1","show_email":"0","show_street_address":"1","show_suburb":"1","show_state":"1","show_postcode":"1","show_country":"1","show_telephone":"1","show_mobile":"1","show_fax":"1","show_webpage":"1","show_misc":"1","show_image":"1","image":"","allow_vcard":"0","show_articles":"0","show_profile":"0","show_links":"0","linka_name":"","linkb_name":"","linkc_name":"","linkd_name":"","linke_name":"","contact_icons":"0","icon_address":"","icon_email":"","icon_telephone":"","icon_mobile":"","icon_fax":"","icon_misc":"","show_headings":"1","show_position_headings":"1","show_email_headings":"0","show_telephone_headings":"1","show_mobile_headings":"0","show_fax_headings":"0","allow_vcard_headings":"0","show_suburb_headings":"1","show_state_headings":"1","show_country_headings":"1","show_email_form":"1","show_email_copy":"1","banned_email":"","banned_subject":"","banned_text":"","validate_session":"1","custom_reply":"0","redirect":"","show_category_crumb":"0","metakey":"","metadesc":"","robots":"","author":"","rights":"","xreference":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(9, 'com_cpanel', 'component', 'com_cpanel', '', 1, 1, 1, 1, '{"name":"com_cpanel","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_CPANEL_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10, 'com_installer', 'component', 'com_installer', '', 1, 1, 1, 1, '{"name":"com_installer","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_INSTALLER_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(11, 'com_languages', 'component', 'com_languages', '', 1, 1, 1, 1, '{"name":"com_languages","type":"component","creationDate":"2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_LANGUAGES_XML_DESCRIPTION","group":""}', '{"administrator":"en-GB","site":"en-GB"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(12, 'com_login', 'component', 'com_login', '', 1, 1, 1, 1, '{"name":"com_login","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_LOGIN_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(13, 'com_media', 'component', 'com_media', '', 1, 1, 0, 1, '{"name":"com_media","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_MEDIA_XML_DESCRIPTION","group":"","filename":"media"}', '{"upload_extensions":"bmp,csv,doc,gif,ico,jpg,jpeg,odg,odp,ods,odt,pdf,png,ppt,swf,txt,xcf,xls,BMP,CSV,DOC,GIF,ICO,JPG,JPEG,ODG,ODP,ODS,ODT,PDF,PNG,PPT,SWF,TXT,XCF,XLS","upload_maxsize":"10","file_path":"images","image_path":"images","restrict_uploads":"1","allowed_media_usergroup":"3","check_mime":"1","image_extensions":"bmp,gif,jpg,png","ignore_extensions":"","upload_mime":"image\\/jpeg,image\\/gif,image\\/png,image\\/bmp,application\\/x-shockwave-flash,application\\/msword,application\\/excel,application\\/pdf,application\\/powerpoint,text\\/plain,application\\/x-zip","upload_mime_illegal":"text\\/html"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(14, 'com_menus', 'component', 'com_menus', '', 1, 1, 1, 1, '{"name":"com_menus","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_MENUS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(15, 'com_messages', 'component', 'com_messages', '', 1, 1, 1, 1, '{"name":"com_messages","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_MESSAGES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(16, 'com_modules', 'component', 'com_modules', '', 1, 1, 1, 1, '{"name":"com_modules","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_MODULES_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(17, 'com_newsfeeds', 'component', 'com_newsfeeds', '', 1, 1, 1, 0, '{"name":"com_newsfeeds","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_NEWSFEEDS_XML_DESCRIPTION","group":"","filename":"newsfeeds"}', '{"newsfeed_layout":"_:default","save_history":"1","history_limit":5,"show_feed_image":"1","show_feed_description":"1","show_item_description":"1","feed_character_count":"0","feed_display_order":"des","float_first":"right","float_second":"right","show_tags":"1","category_layout":"_:default","show_category_title":"1","show_description":"1","show_description_image":"1","maxLevel":"-1","show_empty_categories":"0","show_subcat_desc":"1","show_cat_items":"1","show_cat_tags":"1","show_base_description":"1","maxLevelcat":"-1","show_empty_categories_cat":"0","show_subcat_desc_cat":"1","show_cat_items_cat":"1","filter_field":"1","show_pagination_limit":"1","show_headings":"1","show_articles":"0","show_link":"1","show_pagination":"1","show_pagination_results":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(18, 'com_plugins', 'component', 'com_plugins', '', 1, 1, 1, 1, '{"name":"com_plugins","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_PLUGINS_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(19, 'com_search', 'component', 'com_search', '', 1, 1, 1, 0, '{"name":"com_search","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_SEARCH_XML_DESCRIPTION","group":"","filename":"search"}', '{"enabled":"0","show_date":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(20, 'com_templates', 'component', 'com_templates', '', 1, 1, 1, 1, '{"name":"com_templates","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_TEMPLATES_XML_DESCRIPTION","group":""}', '{"template_positions_display":"1","upload_limit":"2","image_formats":"gif,bmp,jpg,jpeg,png","source_formats":"txt,less,ini,xml,js,php,css,scss,yaml,twig","font_formats":"woff,ttf,otf,eot,svg","compressed_formats":"zip"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(22, 'com_content', 'component', 'com_content', '', 1, 1, 0, 1, '{"name":"com_content","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_CONTENT_XML_DESCRIPTION","group":"","filename":"content"}', '{"article_layout":"_:default","show_title":"0","link_titles":"0","show_intro":"0","info_block_position":"0","show_category":"0","link_category":"0","show_parent_category":"0","link_parent_category":"0","show_author":"0","link_author":"0","show_create_date":"0","show_modify_date":"0","show_publish_date":"0","show_item_navigation":"0","show_vote":"0","show_readmore":"0","show_readmore_title":"0","readmore_limit":"100","show_tags":"0","show_icons":"0","show_print_icon":"0","show_email_icon":"0","show_hits":"0","show_noauth":"0","urls_position":"0","show_publishing_options":"1","show_article_options":"1","save_history":"1","history_limit":10,"show_urls_images_frontend":"0","show_urls_images_backend":"1","targeta":0,"targetb":0,"targetc":0,"float_intro":"left","float_fulltext":"left","category_layout":"_:blog","show_category_heading_title_text":"1","show_category_title":"0","show_description":"0","show_description_image":"0","maxLevel":"1","show_empty_categories":"0","show_no_articles":"1","show_subcat_desc":"1","show_cat_num_articles":"0","show_cat_tags":"1","show_base_description":"1","maxLevelcat":"-1","show_empty_categories_cat":"0","show_subcat_desc_cat":"1","show_cat_num_articles_cat":"1","num_leading_articles":"1","num_intro_articles":"4","num_columns":"2","num_links":"4","multi_column_order":"0","show_subcategory_content":"0","show_pagination_limit":"1","filter_field":"hide","show_headings":"1","list_show_date":"0","date_format":"","list_show_hits":"1","list_show_author":"1","orderby_pri":"order","orderby_sec":"rdate","order_date":"published","show_pagination":"2","show_pagination_results":"1","show_featured":"show","show_feed_link":"1","feed_summary":"0","feed_show_readmore":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(23, 'com_config', 'component', 'com_config', '', 1, 1, 0, 1, '{"name":"com_config","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_CONFIG_XML_DESCRIPTION","group":""}', '{"filters":{"1":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"9":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"6":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"7":{"filter_type":"NONE","filter_tags":"","filter_attributes":""},"2":{"filter_type":"NH","filter_tags":"","filter_attributes":""},"3":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"4":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"5":{"filter_type":"BL","filter_tags":"","filter_attributes":""},"8":{"filter_type":"NONE","filter_tags":"","filter_attributes":""}}}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(24, 'com_redirect', 'component', 'com_redirect', '', 1, 1, 0, 1, '{"name":"com_redirect","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_REDIRECT_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(25, 'com_users', 'component', 'com_users', '', 1, 1, 0, 1, '{"name":"com_users","type":"component","creationDate":"April 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_USERS_XML_DESCRIPTION","group":"","filename":"users"}', '{"allowUserRegistration":"0","new_usertype":"2","guest_usergroup":"9","sendpassword":"0","useractivation":"2","mail_to_admin":"0","captcha":"","frontend_userparams":"1","site_language":"0","change_login_name":"0","reset_count":"10","reset_time":"1","minimum_length":"7","minimum_integers":"0","minimum_symbols":"0","minimum_uppercase":"0","save_history":"1","history_limit":5,"mailSubjectPrefix":"","mailBodySuffix":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(27, 'com_finder', 'component', 'com_finder', '', 1, 1, 0, 0, '{"name":"com_finder","type":"component","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_FINDER_XML_DESCRIPTION","group":"","filename":"finder"}', '{"show_description":"1","description_length":255,"allow_empty_query":"0","show_url":"1","show_advanced":"1","expand_advanced":"0","show_date_filters":"0","highlight_terms":"1","opensearch_name":"","opensearch_description":"","batch_size":"50","memory_table_limit":30000,"title_multiplier":"1.7","text_multiplier":"0.7","meta_multiplier":"1.2","path_multiplier":"2.0","misc_multiplier":"0.3","stemmer":"snowball"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(28, 'com_joomlaupdate', 'component', 'com_joomlaupdate', '', 1, 1, 0, 1, '{"name":"com_joomlaupdate","type":"component","creationDate":"February 2012","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"COM_JOOMLAUPDATE_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(29, 'com_tags', 'component', 'com_tags', '', 1, 1, 1, 1, '{"name":"com_tags","type":"component","creationDate":"December 2013","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.1.0","description":"COM_TAGS_XML_DESCRIPTION","group":"","filename":"tags"}', '{"tag_layout":"_:default","save_history":"1","history_limit":5,"show_tag_title":"0","tag_list_show_tag_image":"0","tag_list_show_tag_description":"0","tag_list_image":"","show_tag_num_items":"0","tag_list_orderby":"title","tag_list_orderby_direction":"ASC","show_headings":"0","tag_list_show_date":"0","tag_list_show_item_image":"0","tag_list_show_item_description":"0","tag_list_item_maximum_characters":0,"return_any_or_all":"1","include_children":"0","maximum":200,"tag_list_language_filter":"all","tags_layout":"_:default","all_tags_orderby":"title","all_tags_orderby_direction":"ASC","all_tags_show_tag_image":"0","all_tags_show_tag_descripion":"0","all_tags_tag_maximum_characters":20,"all_tags_show_tag_hits":"0","filter_field":"1","show_pagination_limit":"1","show_pagination":"2","show_pagination_results":"1","tag_field_ajax_mode":"1","show_feed_link":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(30, 'com_contenthistory', 'component', 'com_contenthistory', '', 1, 1, 1, 0, '{"name":"com_contenthistory","type":"component","creationDate":"May 2013","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.2.0","description":"COM_CONTENTHISTORY_XML_DESCRIPTION","group":"","filename":"contenthistory"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(31, 'com_ajax', 'component', 'com_ajax', '', 1, 1, 1, 0, '{"name":"com_ajax","type":"component","creationDate":"August 2013","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.2.0","description":"COM_AJAX_XML_DESCRIPTION","group":"","filename":"ajax"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(32, 'com_postinstall', 'component', 'com_postinstall', '', 1, 1, 1, 1, '{"name":"com_postinstall","type":"component","creationDate":"September 2013","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.2.0","description":"COM_POSTINSTALL_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(101, 'SimplePie', 'library', 'simplepie', '', 0, 1, 1, 1, '{"name":"SimplePie","type":"library","creationDate":"2004","author":"SimplePie","copyright":"Copyright (c) 2004-2009, Ryan Parman and Geoffrey Sneddon","authorEmail":"","authorUrl":"http:\\/\\/simplepie.org\\/","version":"1.2","description":"LIB_SIMPLEPIE_XML_DESCRIPTION","group":"","filename":"simplepie"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(102, 'phputf8', 'library', 'phputf8', '', 0, 1, 1, 1, '{"name":"phputf8","type":"library","creationDate":"2006","author":"Harry Fuecks","copyright":"Copyright various authors","authorEmail":"hfuecks@gmail.com","authorUrl":"http:\\/\\/sourceforge.net\\/projects\\/phputf8","version":"0.5","description":"LIB_PHPUTF8_XML_DESCRIPTION","group":"","filename":"phputf8"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(103, 'Joomla! Platform', 'library', 'joomla', '', 0, 1, 1, 1, '{"name":"Joomla! Platform","type":"library","creationDate":"2008","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"http:\\/\\/www.joomla.org","version":"13.1","description":"LIB_JOOMLA_XML_DESCRIPTION","group":"","filename":"joomla"}', '{"mediaversion":"15f888e750174b080f8b068b5fe2921e"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(104, 'IDNA Convert', 'library', 'idna_convert', '', 0, 1, 1, 1, '{"name":"IDNA Convert","type":"library","creationDate":"2004","author":"phlyLabs","copyright":"2004-2011 phlyLabs Berlin, http:\\/\\/phlylabs.de","authorEmail":"phlymail@phlylabs.de","authorUrl":"http:\\/\\/phlylabs.de","version":"0.8.0","description":"LIB_IDNA_XML_DESCRIPTION","group":"","filename":"idna_convert"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(105, 'FOF', 'library', 'fof', '', 0, 1, 1, 1, '{"name":"FOF","type":"library","creationDate":"2015-04-22 13:15:32","author":"Nicholas K. Dionysopoulos \\/ Akeeba Ltd","copyright":"(C)2011-2015 Nicholas K. Dionysopoulos","authorEmail":"nicholas@akeebabackup.com","authorUrl":"https:\\/\\/www.akeebabackup.com","version":"2.4.3","description":"LIB_FOF_XML_DESCRIPTION","group":"","filename":"fof"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(106, 'PHPass', 'library', 'phpass', '', 0, 1, 1, 1, '{"name":"PHPass","type":"library","creationDate":"2004-2006","author":"Solar Designer","copyright":"","authorEmail":"solar@openwall.com","authorUrl":"http:\\/\\/www.openwall.com\\/phpass\\/","version":"0.3","description":"LIB_PHPASS_XML_DESCRIPTION","group":"","filename":"phpass"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(200, 'mod_articles_archive', 'module', 'mod_articles_archive', '', 0, 1, 1, 0, '{"name":"mod_articles_archive","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_ARTICLES_ARCHIVE_XML_DESCRIPTION","group":"","filename":"mod_articles_archive"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(201, 'mod_articles_latest', 'module', 'mod_articles_latest', '', 0, 1, 1, 0, '{"name":"mod_articles_latest","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_LATEST_NEWS_XML_DESCRIPTION","group":"","filename":"mod_articles_latest"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(202, 'mod_articles_popular', 'module', 'mod_articles_popular', '', 0, 1, 1, 0, '{"name":"mod_articles_popular","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_POPULAR_XML_DESCRIPTION","group":"","filename":"mod_articles_popular"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(203, 'mod_banners', 'module', 'mod_banners', '', 0, 1, 1, 0, '{"name":"mod_banners","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_BANNERS_XML_DESCRIPTION","group":"","filename":"mod_banners"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(204, 'mod_breadcrumbs', 'module', 'mod_breadcrumbs', '', 0, 1, 1, 1, '{"name":"mod_breadcrumbs","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_BREADCRUMBS_XML_DESCRIPTION","group":"","filename":"mod_breadcrumbs"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(205, 'mod_custom', 'module', 'mod_custom', '', 0, 1, 1, 1, '{"name":"mod_custom","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_CUSTOM_XML_DESCRIPTION","group":"","filename":"mod_custom"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(206, 'mod_feed', 'module', 'mod_feed', '', 0, 1, 1, 0, '{"name":"mod_feed","type":"module","creationDate":"July 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_FEED_XML_DESCRIPTION","group":"","filename":"mod_feed"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(207, 'mod_footer', 'module', 'mod_footer', '', 0, 1, 1, 0, '{"name":"mod_footer","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_FOOTER_XML_DESCRIPTION","group":"","filename":"mod_footer"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(208, 'mod_login', 'module', 'mod_login', '', 0, 1, 1, 1, '{"name":"mod_login","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_LOGIN_XML_DESCRIPTION","group":"","filename":"mod_login"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(209, 'mod_menu', 'module', 'mod_menu', '', 0, 1, 1, 1, '{"name":"mod_menu","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_MENU_XML_DESCRIPTION","group":"","filename":"mod_menu"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(210, 'mod_articles_news', 'module', 'mod_articles_news', '', 0, 1, 1, 0, '{"name":"mod_articles_news","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_ARTICLES_NEWS_XML_DESCRIPTION","group":"","filename":"mod_articles_news"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(211, 'mod_random_image', 'module', 'mod_random_image', '', 0, 1, 1, 0, '{"name":"mod_random_image","type":"module","creationDate":"July 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_RANDOM_IMAGE_XML_DESCRIPTION","group":"","filename":"mod_random_image"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(212, 'mod_related_items', 'module', 'mod_related_items', '', 0, 1, 1, 0, '{"name":"mod_related_items","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_RELATED_XML_DESCRIPTION","group":"","filename":"mod_related_items"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(213, 'mod_search', 'module', 'mod_search', '', 0, 1, 1, 0, '{"name":"mod_search","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_SEARCH_XML_DESCRIPTION","group":"","filename":"mod_search"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(214, 'mod_stats', 'module', 'mod_stats', '', 0, 1, 1, 0, '{"name":"mod_stats","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_STATS_XML_DESCRIPTION","group":"","filename":"mod_stats"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(215, 'mod_syndicate', 'module', 'mod_syndicate', '', 0, 1, 1, 1, '{"name":"mod_syndicate","type":"module","creationDate":"May 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_SYNDICATE_XML_DESCRIPTION","group":"","filename":"mod_syndicate"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(216, 'mod_users_latest', 'module', 'mod_users_latest', '', 0, 1, 1, 0, '{"name":"mod_users_latest","type":"module","creationDate":"December 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_USERS_LATEST_XML_DESCRIPTION","group":"","filename":"mod_users_latest"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(218, 'mod_whosonline', 'module', 'mod_whosonline', '', 0, 1, 1, 0, '{"name":"mod_whosonline","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_WHOSONLINE_XML_DESCRIPTION","group":"","filename":"mod_whosonline"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(219, 'mod_wrapper', 'module', 'mod_wrapper', '', 0, 1, 1, 0, '{"name":"mod_wrapper","type":"module","creationDate":"October 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_WRAPPER_XML_DESCRIPTION","group":"","filename":"mod_wrapper"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(220, 'mod_articles_category', 'module', 'mod_articles_category', '', 0, 1, 1, 0, '{"name":"mod_articles_category","type":"module","creationDate":"February 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_ARTICLES_CATEGORY_XML_DESCRIPTION","group":"","filename":"mod_articles_category"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(221, 'mod_articles_categories', 'module', 'mod_articles_categories', '', 0, 1, 1, 0, '{"name":"mod_articles_categories","type":"module","creationDate":"February 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_ARTICLES_CATEGORIES_XML_DESCRIPTION","group":"","filename":"mod_articles_categories"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(222, 'mod_languages', 'module', 'mod_languages', '', 0, 1, 1, 1, '{"name":"mod_languages","type":"module","creationDate":"February 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_LANGUAGES_XML_DESCRIPTION","group":"","filename":"mod_languages"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(223, 'mod_finder', 'module', 'mod_finder', '', 0, 1, 0, 0, '{"name":"mod_finder","type":"module","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_FINDER_XML_DESCRIPTION","group":"","filename":"mod_finder"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(300, 'mod_custom', 'module', 'mod_custom', '', 1, 1, 1, 1, '{"name":"mod_custom","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_CUSTOM_XML_DESCRIPTION","group":"","filename":"mod_custom"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(301, 'mod_feed', 'module', 'mod_feed', '', 1, 1, 1, 0, '{"name":"mod_feed","type":"module","creationDate":"July 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_FEED_XML_DESCRIPTION","group":"","filename":"mod_feed"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(302, 'mod_latest', 'module', 'mod_latest', '', 1, 1, 1, 0, '{"name":"mod_latest","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_LATEST_XML_DESCRIPTION","group":"","filename":"mod_latest"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(303, 'mod_logged', 'module', 'mod_logged', '', 1, 1, 1, 0, '{"name":"mod_logged","type":"module","creationDate":"January 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_LOGGED_XML_DESCRIPTION","group":"","filename":"mod_logged"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(304, 'mod_login', 'module', 'mod_login', '', 1, 1, 1, 1, '{"name":"mod_login","type":"module","creationDate":"March 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_LOGIN_XML_DESCRIPTION","group":"","filename":"mod_login"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(305, 'mod_menu', 'module', 'mod_menu', '', 1, 1, 1, 0, '{"name":"mod_menu","type":"module","creationDate":"March 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_MENU_XML_DESCRIPTION","group":"","filename":"mod_menu"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(307, 'mod_popular', 'module', 'mod_popular', '', 1, 1, 1, 0, '{"name":"mod_popular","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_POPULAR_XML_DESCRIPTION","group":"","filename":"mod_popular"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(308, 'mod_quickicon', 'module', 'mod_quickicon', '', 1, 1, 1, 1, '{"name":"mod_quickicon","type":"module","creationDate":"Nov 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_QUICKICON_XML_DESCRIPTION","group":"","filename":"mod_quickicon"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(309, 'mod_status', 'module', 'mod_status', '', 1, 1, 1, 0, '{"name":"mod_status","type":"module","creationDate":"Feb 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_STATUS_XML_DESCRIPTION","group":"","filename":"mod_status"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(310, 'mod_submenu', 'module', 'mod_submenu', '', 1, 1, 1, 0, '{"name":"mod_submenu","type":"module","creationDate":"Feb 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_SUBMENU_XML_DESCRIPTION","group":"","filename":"mod_submenu"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(311, 'mod_title', 'module', 'mod_title', '', 1, 1, 1, 0, '{"name":"mod_title","type":"module","creationDate":"Nov 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_TITLE_XML_DESCRIPTION","group":"","filename":"mod_title"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(312, 'mod_toolbar', 'module', 'mod_toolbar', '', 1, 1, 1, 1, '{"name":"mod_toolbar","type":"module","creationDate":"Nov 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_TOOLBAR_XML_DESCRIPTION","group":"","filename":"mod_toolbar"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(313, 'mod_multilangstatus', 'module', 'mod_multilangstatus', '', 1, 1, 1, 0, '{"name":"mod_multilangstatus","type":"module","creationDate":"September 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_MULTILANGSTATUS_XML_DESCRIPTION","group":"","filename":"mod_multilangstatus"}', '{"cache":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(314, 'mod_version', 'module', 'mod_version', '', 1, 1, 1, 0, '{"name":"mod_version","type":"module","creationDate":"January 2012","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_VERSION_XML_DESCRIPTION","group":"","filename":"mod_version"}', '{"format":"short","product":"1","cache":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(315, 'mod_stats_admin', 'module', 'mod_stats_admin', '', 1, 1, 1, 0, '{"name":"mod_stats_admin","type":"module","creationDate":"July 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"MOD_STATS_XML_DESCRIPTION","group":"","filename":"mod_stats_admin"}', '{"serverinfo":"0","siteinfo":"0","counter":"0","increase":"0","cache":"1","cache_time":"900","cachemode":"static"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(316, 'mod_tags_popular', 'module', 'mod_tags_popular', '', 0, 1, 1, 0, '{"name":"mod_tags_popular","type":"module","creationDate":"January 2013","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.1.0","description":"MOD_TAGS_POPULAR_XML_DESCRIPTION","group":"","filename":"mod_tags_popular"}', '{"maximum":"5","timeframe":"alltime","owncache":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(317, 'mod_tags_similar', 'module', 'mod_tags_similar', '', 0, 1, 1, 0, '{"name":"mod_tags_similar","type":"module","creationDate":"January 2013","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.1.0","description":"MOD_TAGS_SIMILAR_XML_DESCRIPTION","group":"","filename":"mod_tags_similar"}', '{"maximum":"5","matchtype":"any","owncache":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(400, 'plg_authentication_gmail', 'plugin', 'gmail', 'authentication', 0, 0, 1, 0, '{"name":"plg_authentication_gmail","type":"plugin","creationDate":"February 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_GMAIL_XML_DESCRIPTION","group":"","filename":"gmail"}', '{"applysuffix":"0","suffix":"","verifypeer":"1","user_blacklist":""}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(401, 'plg_authentication_joomla', 'plugin', 'joomla', 'authentication', 0, 1, 1, 1, '{"name":"plg_authentication_joomla","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_AUTH_JOOMLA_XML_DESCRIPTION","group":"","filename":"joomla"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(402, 'plg_authentication_ldap', 'plugin', 'ldap', 'authentication', 0, 0, 1, 0, '{"name":"plg_authentication_ldap","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_LDAP_XML_DESCRIPTION","group":"","filename":"ldap"}', '{"host":"","port":"389","use_ldapV3":"0","negotiate_tls":"0","no_referrals":"0","auth_method":"bind","base_dn":"","search_string":"","users_dn":"","username":"admin","password":"bobby7","ldap_fullname":"fullName","ldap_email":"mail","ldap_uid":"uid"}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(403, 'plg_content_contact', 'plugin', 'contact', 'content', 0, 1, 1, 0, '{"name":"plg_content_contact","type":"plugin","creationDate":"January 2014","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.2.2","description":"PLG_CONTENT_CONTACT_XML_DESCRIPTION","group":"","filename":"contact"}', '', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(404, 'plg_content_emailcloak', 'plugin', 'emailcloak', 'content', 0, 1, 1, 0, '{"name":"plg_content_emailcloak","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_CONTENT_EMAILCLOAK_XML_DESCRIPTION","group":"","filename":"emailcloak"}', '{"mode":"1"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(406, 'plg_content_loadmodule', 'plugin', 'loadmodule', 'content', 0, 1, 1, 0, '{"name":"plg_content_loadmodule","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_LOADMODULE_XML_DESCRIPTION","group":"","filename":"loadmodule"}', '{"style":"xhtml"}', '', '', 0, '2011-09-18 15:22:50', 0, 0),
(407, 'plg_content_pagebreak', 'plugin', 'pagebreak', 'content', 0, 1, 1, 0, '{"name":"plg_content_pagebreak","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_CONTENT_PAGEBREAK_XML_DESCRIPTION","group":"","filename":"pagebreak"}', '{"title":"1","multipage_toc":"1","showall":"1"}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(408, 'plg_content_pagenavigation', 'plugin', 'pagenavigation', 'content', 0, 1, 1, 0, '{"name":"plg_content_pagenavigation","type":"plugin","creationDate":"January 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_PAGENAVIGATION_XML_DESCRIPTION","group":"","filename":"pagenavigation"}', '{"position":"1"}', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(409, 'plg_content_vote', 'plugin', 'vote', 'content', 0, 1, 1, 0, '{"name":"plg_content_vote","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_VOTE_XML_DESCRIPTION","group":"","filename":"vote"}', '', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(410, 'plg_editors_codemirror', 'plugin', 'codemirror', 'editors', 0, 1, 1, 1, '{"name":"plg_editors_codemirror","type":"plugin","creationDate":"28 March 2011","author":"Marijn Haverbeke","copyright":"Copyright (C) 2014 by Marijn Haverbeke <marijnh@gmail.com> and others","authorEmail":"marijnh@gmail.com","authorUrl":"http:\\/\\/codemirror.net\\/","version":"5.6","description":"PLG_CODEMIRROR_XML_DESCRIPTION","group":"","filename":"codemirror"}', '{"lineNumbers":"1","lineWrapping":"1","matchTags":"1","matchBrackets":"1","marker-gutter":"1","autoCloseTags":"1","autoCloseBrackets":"1","autoFocus":"1","theme":"default","tabmode":"indent"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(411, 'plg_editors_none', 'plugin', 'none', 'editors', 0, 1, 1, 1, '{"name":"plg_editors_none","type":"plugin","creationDate":"September 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_NONE_XML_DESCRIPTION","group":"","filename":"none"}', '', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(412, 'plg_editors_tinymce', 'plugin', 'tinymce', 'editors', 0, 1, 1, 0, '{"name":"plg_editors_tinymce","type":"plugin","creationDate":"2005-2014","author":"Moxiecode Systems AB","copyright":"Moxiecode Systems AB","authorEmail":"N\\/A","authorUrl":"tinymce.moxiecode.com","version":"4.1.7","description":"PLG_TINY_XML_DESCRIPTION","group":"","filename":"tinymce"}', '{"mode":"1","skin":"0","mobile":"0","entity_encoding":"raw","lang_mode":"1","text_direction":"ltr","content_css":"1","content_css_custom":"","relative_urls":"1","newlines":"0","invalid_elements":"script,applet,iframe","extended_elements":"","html_height":"550","html_width":"750","resizing":"1","element_path":"1","fonts":"1","paste":"1","searchreplace":"1","insertdate":"1","colors":"1","table":"1","smilies":"1","hr":"1","link":"1","media":"1","print":"1","directionality":"1","fullscreen":"1","alignment":"1","visualchars":"1","visualblocks":"1","nonbreaking":"1","template":"1","blockquote":"1","wordcount":"1","advlist":"1","autosave":"1","contextmenu":"1","inlinepopups":"1","custom_plugin":"","custom_button":""}', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(413, 'plg_editors-xtd_article', 'plugin', 'article', 'editors-xtd', 0, 1, 1, 0, '{"name":"plg_editors-xtd_article","type":"plugin","creationDate":"October 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_ARTICLE_XML_DESCRIPTION","group":"","filename":"article"}', '', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(414, 'plg_editors-xtd_image', 'plugin', 'image', 'editors-xtd', 0, 1, 1, 0, '{"name":"plg_editors-xtd_image","type":"plugin","creationDate":"August 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_IMAGE_XML_DESCRIPTION","group":"","filename":"image"}', '', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(415, 'plg_editors-xtd_pagebreak', 'plugin', 'pagebreak', 'editors-xtd', 0, 1, 1, 0, '{"name":"plg_editors-xtd_pagebreak","type":"plugin","creationDate":"August 2004","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_EDITORSXTD_PAGEBREAK_XML_DESCRIPTION","group":"","filename":"pagebreak"}', '', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(416, 'plg_editors-xtd_readmore', 'plugin', 'readmore', 'editors-xtd', 0, 1, 1, 0, '{"name":"plg_editors-xtd_readmore","type":"plugin","creationDate":"March 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_READMORE_XML_DESCRIPTION","group":"","filename":"readmore"}', '', '', '', 0, '0000-00-00 00:00:00', 4, 0);
INSERT INTO `joomla_extensions` (`extension_id`, `name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`) VALUES
(417, 'plg_search_categories', 'plugin', 'categories', 'search', 0, 1, 1, 0, '{"name":"plg_search_categories","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SEARCH_CATEGORIES_XML_DESCRIPTION","group":"","filename":"categories"}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(418, 'plg_search_contacts', 'plugin', 'contacts', 'search', 0, 1, 1, 0, '{"name":"plg_search_contacts","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SEARCH_CONTACTS_XML_DESCRIPTION","group":"","filename":"contacts"}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(419, 'plg_search_content', 'plugin', 'content', 'search', 0, 1, 1, 0, '{"name":"plg_search_content","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SEARCH_CONTENT_XML_DESCRIPTION","group":"","filename":"content"}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(420, 'plg_search_newsfeeds', 'plugin', 'newsfeeds', 'search', 0, 1, 1, 0, '{"name":"plg_search_newsfeeds","type":"plugin","creationDate":"November 2005","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SEARCH_NEWSFEEDS_XML_DESCRIPTION","group":"","filename":"newsfeeds"}', '{"search_limit":"50","search_content":"1","search_archived":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(422, 'plg_system_languagefilter', 'plugin', 'languagefilter', 'system', 0, 0, 1, 1, '{"name":"plg_system_languagefilter","type":"plugin","creationDate":"July 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SYSTEM_LANGUAGEFILTER_XML_DESCRIPTION","group":"","filename":"languagefilter"}', '', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(423, 'plg_system_p3p', 'plugin', 'p3p', 'system', 0, 0, 1, 0, '{"name":"plg_system_p3p","type":"plugin","creationDate":"September 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_P3P_XML_DESCRIPTION","group":"","filename":"p3p"}', '{"headers":"NOI ADM DEV PSAi COM NAV OUR OTRo STP IND DEM"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(424, 'plg_system_cache', 'plugin', 'cache', 'system', 0, 0, 1, 1, '{"name":"plg_system_cache","type":"plugin","creationDate":"February 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_CACHE_XML_DESCRIPTION","group":"","filename":"cache"}', '{"browsercache":"0","cachetime":"15"}', '', '', 0, '0000-00-00 00:00:00', 9, 0),
(425, 'plg_system_debug', 'plugin', 'debug', 'system', 0, 1, 1, 0, '{"name":"plg_system_debug","type":"plugin","creationDate":"December 2006","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_DEBUG_XML_DESCRIPTION","group":"","filename":"debug"}', '{"profile":"1","queries":"1","memory":"1","language_files":"1","language_strings":"1","strip-first":"1","strip-prefix":"","strip-suffix":""}', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(426, 'plg_system_log', 'plugin', 'log', 'system', 0, 1, 1, 1, '{"name":"plg_system_log","type":"plugin","creationDate":"April 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_LOG_XML_DESCRIPTION","group":"","filename":"log"}', '', '', '', 0, '0000-00-00 00:00:00', 5, 0),
(427, 'plg_system_redirect', 'plugin', 'redirect', 'system', 0, 0, 1, 1, '{"name":"plg_system_redirect","type":"plugin","creationDate":"April 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SYSTEM_REDIRECT_XML_DESCRIPTION","group":"","filename":"redirect"}', '', '', '', 0, '0000-00-00 00:00:00', 6, 0),
(428, 'plg_system_remember', 'plugin', 'remember', 'system', 0, 1, 1, 1, '{"name":"plg_system_remember","type":"plugin","creationDate":"April 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_REMEMBER_XML_DESCRIPTION","group":"","filename":"remember"}', '', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(429, 'plg_system_sef', 'plugin', 'sef', 'system', 0, 1, 1, 0, '{"name":"plg_system_sef","type":"plugin","creationDate":"December 2007","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SEF_XML_DESCRIPTION","group":"","filename":"sef"}', '', '', '', 0, '0000-00-00 00:00:00', 8, 0),
(430, 'plg_system_logout', 'plugin', 'logout', 'system', 0, 1, 1, 1, '{"name":"plg_system_logout","type":"plugin","creationDate":"April 2009","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SYSTEM_LOGOUT_XML_DESCRIPTION","group":"","filename":"logout"}', '', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(431, 'plg_user_contactcreator', 'plugin', 'contactcreator', 'user', 0, 0, 1, 0, '{"name":"plg_user_contactcreator","type":"plugin","creationDate":"August 2009","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_CONTACTCREATOR_XML_DESCRIPTION","group":"","filename":"contactcreator"}', '{"autowebpage":"","category":"34","autopublish":"0"}', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(432, 'plg_user_joomla', 'plugin', 'joomla', 'user', 0, 1, 1, 0, '{"name":"plg_user_joomla","type":"plugin","creationDate":"December 2006","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_USER_JOOMLA_XML_DESCRIPTION","group":"","filename":"joomla"}', '{"autoregister":"1","mail_to_user":"1","forceLogout":"1"}', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(433, 'plg_user_profile', 'plugin', 'profile', 'user', 0, 0, 1, 0, '{"name":"plg_user_profile","type":"plugin","creationDate":"January 2008","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_USER_PROFILE_XML_DESCRIPTION","group":"","filename":"profile"}', '{"register-require_address1":"1","register-require_address2":"1","register-require_city":"1","register-require_region":"1","register-require_country":"1","register-require_postal_code":"1","register-require_phone":"1","register-require_website":"1","register-require_favoritebook":"1","register-require_aboutme":"1","register-require_tos":"1","register-require_dob":"1","profile-require_address1":"1","profile-require_address2":"1","profile-require_city":"1","profile-require_region":"1","profile-require_country":"1","profile-require_postal_code":"1","profile-require_phone":"1","profile-require_website":"1","profile-require_favoritebook":"1","profile-require_aboutme":"1","profile-require_tos":"1","profile-require_dob":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(434, 'plg_extension_joomla', 'plugin', 'joomla', 'extension', 0, 1, 1, 1, '{"name":"plg_extension_joomla","type":"plugin","creationDate":"May 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_EXTENSION_JOOMLA_XML_DESCRIPTION","group":"","filename":"joomla"}', '', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(435, 'plg_content_joomla', 'plugin', 'joomla', 'content', 0, 1, 1, 0, '{"name":"plg_content_joomla","type":"plugin","creationDate":"November 2010","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_CONTENT_JOOMLA_XML_DESCRIPTION","group":"","filename":"joomla"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(436, 'plg_system_languagecode', 'plugin', 'languagecode', 'system', 0, 0, 1, 0, '{"name":"plg_system_languagecode","type":"plugin","creationDate":"November 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SYSTEM_LANGUAGECODE_XML_DESCRIPTION","group":"","filename":"languagecode"}', '', '', '', 0, '0000-00-00 00:00:00', 10, 0),
(437, 'plg_quickicon_joomlaupdate', 'plugin', 'joomlaupdate', 'quickicon', 0, 1, 1, 1, '{"name":"plg_quickicon_joomlaupdate","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_QUICKICON_JOOMLAUPDATE_XML_DESCRIPTION","group":"","filename":"joomlaupdate"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(438, 'plg_quickicon_extensionupdate', 'plugin', 'extensionupdate', 'quickicon', 0, 1, 1, 1, '{"name":"plg_quickicon_extensionupdate","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_QUICKICON_EXTENSIONUPDATE_XML_DESCRIPTION","group":"","filename":"extensionupdate"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(439, 'plg_captcha_recaptcha', 'plugin', 'recaptcha', 'captcha', 0, 0, 1, 0, '{"name":"plg_captcha_recaptcha","type":"plugin","creationDate":"December 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.4.0","description":"PLG_CAPTCHA_RECAPTCHA_XML_DESCRIPTION","group":"","filename":"recaptcha"}', '{"public_key":"","private_key":"","theme":"clean"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(440, 'plg_system_highlight', 'plugin', 'highlight', 'system', 0, 1, 1, 0, '{"name":"plg_system_highlight","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SYSTEM_HIGHLIGHT_XML_DESCRIPTION","group":"","filename":"highlight"}', '', '', '', 0, '0000-00-00 00:00:00', 7, 0),
(441, 'plg_content_finder', 'plugin', 'finder', 'content', 0, 0, 1, 0, '{"name":"plg_content_finder","type":"plugin","creationDate":"December 2011","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_CONTENT_FINDER_XML_DESCRIPTION","group":"","filename":"finder"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(442, 'plg_finder_categories', 'plugin', 'categories', 'finder', 0, 1, 1, 0, '{"name":"plg_finder_categories","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_FINDER_CATEGORIES_XML_DESCRIPTION","group":"","filename":"categories"}', '', '', '', 0, '0000-00-00 00:00:00', 1, 0),
(443, 'plg_finder_contacts', 'plugin', 'contacts', 'finder', 0, 1, 1, 0, '{"name":"plg_finder_contacts","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_FINDER_CONTACTS_XML_DESCRIPTION","group":"","filename":"contacts"}', '', '', '', 0, '0000-00-00 00:00:00', 2, 0),
(444, 'plg_finder_content', 'plugin', 'content', 'finder', 0, 1, 1, 0, '{"name":"plg_finder_content","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_FINDER_CONTENT_XML_DESCRIPTION","group":"","filename":"content"}', '', '', '', 0, '0000-00-00 00:00:00', 3, 0),
(445, 'plg_finder_newsfeeds', 'plugin', 'newsfeeds', 'finder', 0, 1, 1, 0, '{"name":"plg_finder_newsfeeds","type":"plugin","creationDate":"August 2011","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_FINDER_NEWSFEEDS_XML_DESCRIPTION","group":"","filename":"newsfeeds"}', '', '', '', 0, '0000-00-00 00:00:00', 4, 0),
(447, 'plg_finder_tags', 'plugin', 'tags', 'finder', 0, 1, 1, 0, '{"name":"plg_finder_tags","type":"plugin","creationDate":"February 2013","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_FINDER_TAGS_XML_DESCRIPTION","group":"","filename":"tags"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(448, 'plg_twofactorauth_totp', 'plugin', 'totp', 'twofactorauth', 0, 0, 1, 0, '{"name":"plg_twofactorauth_totp","type":"plugin","creationDate":"August 2013","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.2.0","description":"PLG_TWOFACTORAUTH_TOTP_XML_DESCRIPTION","group":"","filename":"totp"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(449, 'plg_authentication_cookie', 'plugin', 'cookie', 'authentication', 0, 1, 1, 0, '{"name":"plg_authentication_cookie","type":"plugin","creationDate":"July 2013","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_AUTH_COOKIE_XML_DESCRIPTION","group":"","filename":"cookie"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(450, 'plg_twofactorauth_yubikey', 'plugin', 'yubikey', 'twofactorauth', 0, 0, 1, 0, '{"name":"plg_twofactorauth_yubikey","type":"plugin","creationDate":"September 2013","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.2.0","description":"PLG_TWOFACTORAUTH_YUBIKEY_XML_DESCRIPTION","group":"","filename":"yubikey"}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(451, 'plg_search_tags', 'plugin', 'tags', 'search', 0, 1, 1, 0, '{"name":"plg_search_tags","type":"plugin","creationDate":"March 2014","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.0.0","description":"PLG_SEARCH_TAGS_XML_DESCRIPTION","group":"","filename":"tags"}', '{"search_limit":"50","show_tagged_items":"1"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(503, 'beez3', 'template', 'beez3', '', 0, 1, 1, 0, '{"name":"beez3","type":"template","creationDate":"25 November 2009","author":"Angie Radtke","copyright":"Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.","authorEmail":"a.radtke@derauftritt.de","authorUrl":"http:\\/\\/www.der-auftritt.de","version":"3.1.0","description":"TPL_BEEZ3_XML_DESCRIPTION","group":"","filename":"templateDetails"}', '{"wrapperSmall":"53","wrapperLarge":"72","sitetitle":"","sitedescription":"","navposition":"center","templatecolor":"nature"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(504, 'hathor', 'template', 'hathor', '', 1, 1, 1, 0, '{"name":"hathor","type":"template","creationDate":"May 2010","author":"Andrea Tarr","copyright":"Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.","authorEmail":"hathor@tarrconsulting.com","authorUrl":"http:\\/\\/www.tarrconsulting.com","version":"3.0.0","description":"TPL_HATHOR_XML_DESCRIPTION","group":"","filename":"templateDetails"}', '{"showSiteName":"0","colourChoice":"0","boldText":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(506, 'protostar', 'template', 'protostar', '', 0, 1, 1, 0, '{"name":"protostar","type":"template","creationDate":"4\\/30\\/2012","author":"Kyle Ledbetter","copyright":"Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"","version":"1.0","description":"TPL_PROTOSTAR_XML_DESCRIPTION","group":"","filename":"templateDetails"}', '{"templateColor":"","logoFile":"","googleFont":"1","googleFontName":"Open+Sans","fluidContainer":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(507, 'isis', 'template', 'isis', '', 1, 1, 1, 0, '{"name":"isis","type":"template","creationDate":"3\\/30\\/2012","author":"Kyle Ledbetter","copyright":"Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"","version":"1.0","description":"TPL_ISIS_XML_DESCRIPTION","group":"","filename":"templateDetails"}', '{"templateColor":"","logoFile":""}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(600, 'English (en-GB)', 'language', 'en-GB', '', 0, 1, 1, 1, '{"name":"English (en-GB)","type":"language","creationDate":"2013-03-07","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.4.3","description":"en-GB site language","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(601, 'English (en-GB)', 'language', 'en-GB', '', 1, 1, 1, 1, '{"name":"English (en-GB)","type":"language","creationDate":"2013-03-07","author":"Joomla! Project","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.4.3","description":"en-GB administrator language","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(700, 'files_joomla', 'file', 'joomla', '', 0, 1, 1, 1, '{"name":"files_joomla","type":"file","creationDate":"December 2015","author":"Joomla! Project","copyright":"(C) 2005 - 2015 Open Source Matters. All rights reserved","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"3.4.8","description":"FILES_JOOMLA_XML_DESCRIPTION","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10000, 'plg_installer_webinstaller', 'plugin', 'webinstaller', 'installer', 0, 1, 1, 0, '{"name":"plg_installer_webinstaller","type":"plugin","creationDate":"18 December 2013","author":"Joomla! Project","copyright":"Copyright (C) 2013 Open Source Matters. All rights reserved.","authorEmail":"admin@joomla.org","authorUrl":"www.joomla.org","version":"1.0.5","description":"PLG_INSTALLER_WEBINSTALLER_XML_DESCRIPTION","group":"","filename":"webinstaller"}', '{"tab_position":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10002, 'plg_system_nnframework', 'plugin', 'nnframework', 'system', 0, 1, 1, 0, '{"name":"plg_system_nnframework","type":"plugin","creationDate":"December 2015","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2015 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"https:\\/\\/www.nonumber.nl","version":"15.12.7724","description":"PLG_SYSTEM_NNFRAMEWORK_DESC","group":"","filename":"nnframework"}', '{"max_list_count":"2500"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10003, 'plg_editors-xtd_sourcerer', 'plugin', 'sourcerer', 'editors-xtd', 0, 1, 1, 0, '{"name":"plg_editors-xtd_sourcerer","type":"plugin","creationDate":"December 2015","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2015 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"https:\\/\\/www.nonumber.nl","version":"5.2.1","description":"PLG_EDITORS-XTD_SOURCERER_DESC","group":"","filename":"sourcerer"}', '[]', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10004, 'plg_system_sourcerer', 'plugin', 'sourcerer', 'system', 0, 1, 1, 0, '{"name":"plg_system_sourcerer","type":"plugin","creationDate":"December 2015","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2015 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"https:\\/\\/www.nonumber.nl","version":"5.2.1","description":"PLG_SYSTEM_SOURCERER_DESC","group":"","filename":"sourcerer"}', '{"syntax_word":"source","tag_characters":"{.}","include_path":"\\/","enable_css":"1","enable_js":"1","enable_php":"1","forbidden_php":"dl, escapeshellarg, escapeshellcmd, exec, passthru, popen, proc_close, proc_open, shell_exec, symlink, system","forbidden_tags":"","@notice_articles_security_level":"NN_ONLY_AVAILABLE_IN_PRO","@notice_articles_enable_css":"NN_ONLY_AVAILABLE_IN_PRO","@notice_articles_enable_js":"NN_ONLY_AVAILABLE_IN_PRO","@notice_articles_enable_php":"NN_ONLY_AVAILABLE_IN_PRO","@notice_components_enable_css":"NN_ONLY_AVAILABLE_IN_PRO","@notice_components_enable_js":"NN_ONLY_AVAILABLE_IN_PRO","@notice_components_enable_php":"NN_ONLY_AVAILABLE_IN_PRO","@wizard":"0","@noticeother_enable_css":"NN_ONLY_AVAILABLE_IN_PRO","@notice_other_enable_js":"NN_ONLY_AVAILABLE_IN_PRO","@notice_other_enable_php":"NN_ONLY_AVAILABLE_IN_PRO","button_text":"Code","enable_frontend":"1","addsourcetags":"1","@notice_use_example_code":"NN_ONLY_AVAILABLE_IN_PRO"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10005, 'com_jaextmanager', 'component', 'com_jaextmanager', '', 1, 1, 0, 0, '{"name":"com_jaextmanager","type":"component","creationDate":"Feb 2015","author":"JoomlArt","copyright":"Copyright (C), J.O.O.M Solutions Co., Ltd. All Rights Reserved.","authorEmail":"webmaster@joomlart.com","authorUrl":"http:\\/\\/www.joomlart.com","version":"2.6.0","description":"JA Extension Manager Component","group":""}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10006, 'T3 Framework', 'plugin', 't3', 'system', 0, 1, 1, 0, '{"name":"T3 Framework","type":"plugin","creationDate":"December 09, 2015","author":"JoomlArt.com","copyright":"Copyright (C) 2005 - 2015 Open Source Matters. All rights reserved.","authorEmail":"info@joomlart.com","authorUrl":"http:\\/\\/www.t3-framework.org","version":"2.5.2","description":"\\n\\t\\n\\t<div align=\\"center\\">\\n\\t\\t<div class=\\"alert alert-success\\" style=\\"background-color:#DFF0D8;border-color:#D6E9C6;color: #468847;padding: 1px 0;\\">\\n\\t\\t\\t\\t<a href=\\"http:\\/\\/t3-framework.org\\/\\"><img src=\\"http:\\/\\/joomlart.s3.amazonaws.com\\/images\\/jat3v3-documents\\/message-installation\\/logo.png\\" alt=\\"some_text\\" width=\\"300\\" height=\\"99\\"><\\/a>\\n\\t\\t\\t\\t<h4><a href=\\"http:\\/\\/t3-framework.org\\/\\" title=\\"\\">Home<\\/a> | <a href=\\"http:\\/\\/demo.t3-framework.org\\/\\" title=\\"\\">Demo<\\/a> | <a href=\\"http:\\/\\/t3-framework.org\\/documentation\\" title=\\"\\">Document<\\/a> | <a href=\\"https:\\/\\/github.com\\/t3framework\\/t3\\/blob\\/master\\/CHANGELOG.md\\" title=\\"\\">Changelog<\\/a><\\/h4>\\n\\t\\t<p> <\\/p>\\n\\t\\t<p>Copyright 2004 - 2015 <a href=''http:\\/\\/www.joomlart.com\\/'' title=''Visit Joomlart.com!''>JoomlArt.com<\\/a>.<\\/p>\\n\\t\\t<\\/div>\\n     <style>table.adminform{width: 100%;}<\\/style>\\n\\t <\\/div>\\n\\t\\t\\n\\t","group":"","filename":"t3"}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10007, 'purity_III', 'template', 'purity_iii', '', 0, 1, 1, 0, '{"name":"purity_III","type":"template","creationDate":"July 2015","author":"JoomlArt.com","copyright":"Copyright (C), J.O.O.M Solutions Co., Ltd. All Rights Reserved.","authorEmail":"webmaster@joomlart.com","authorUrl":"http:\\/\\/www.t3-framework.org","version":"1.1.5","description":"\\n\\t\\t\\n\\t\\t<div align=\\"center\\">\\n\\t\\t\\t<div class=\\"alert alert-success\\" style=\\"background-color:#DFF0D8;border-color:#D6E9C6;color: #468847;padding: 1px 0;\\">\\n\\t\\t\\t\\t<h2>Purity III Template references<\\/h2>\\n\\t\\t\\t\\t<h4><a href=\\"http:\\/\\/joomla-templates.joomlart.com\\/purity_iii\\/\\" title=\\"Purity III Template demo\\">Live Demo<\\/a> | <a href=\\"http:\\/\\/www.joomlart.com\\/documentation\\/joomla-templates\\/purity-iii\\" title=\\"purity iii template documentation\\">Documentation<\\/a> | <a href=\\"http:\\/\\/www.joomlart.com\\/forums\\/forumdisplay.php?542-Purity-III\\" title=\\"purity iii forum\\">Forum<\\/a> | <a href=\\"http:\\/\\/www.joomlart.com\\/joomla\\/templates\\/purity-iii\\" title=\\"Purity III template more info\\">More Info<\\/a><\\/h4>\\n\\t\\t\\t\\t<p> <\\/p>\\n\\t\\t\\t\\t<span style=\\"color:#FF0000\\">Note: Purity III requires T3 plugin to be installed and enabled.<\\/span>\\n\\t\\t\\t\\t<p> <\\/p>\\n\\t\\t\\t\\t<p>Copyright 2004 - 2015 <a href=''http:\\/\\/www.joomlart.com\\/'' title=''Visit Joomlart.com!''>JoomlArt.com<\\/a>.<\\/p>\\n\\t\\t\\t<\\/div>\\n\\t\\t\\t<style>table.adminform{width: 100%;}<\\/style>\\n\\t\\t<\\/div>\\n\\t\\t\\n\\t","group":"","filename":"templateDetails"}', '{"tpl_article_info_datetime_format":"d M Y"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10008, 'VJ Database Tool', 'component', 'com_vjdatabasetool', '', 1, 1, 0, 0, '{"name":"VJ Database Tool","type":"component","creationDate":"March 2015","author":"VJ Tools","copyright":"Copyright (C) 2014 vj-tools.com. All rights reserved.","authorEmail":"info@vj-tools.com","authorUrl":"http:\\/\\/www.vj-tools.com","version":"1.0.0","description":"VJ Database Tool - Database management tool for Joomla!.<br \\/><br \\/>&copy;&nbsp;<a href=\\"http:\\/\\/www.vj-tools.com\\">VJ Tools<\\/a> - Fabulous Joomla! extensions.","group":"","filename":"vjdatabasetool"}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10009, 'Quick Logout', 'component', 'com_quicklogout', '', 1, 1, 0, 0, '{"name":"Quick Logout","type":"component","creationDate":"2014-07-25","author":"John Muehleisen","copyright":"Copyright (C) 2014. All rights reserved.","authorEmail":"john@welcometojoomla.com","authorUrl":"www.welcometojoomla.com","version":"1.9.3","description":"Adds a new menu option type to Joomla to allow a one click logout","group":"","filename":"quicklogout"}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10011, 'plg_editors-xtd_modulesanywhere', 'plugin', 'modulesanywhere', 'editors-xtd', 0, 1, 1, 0, '{"name":"plg_editors-xtd_modulesanywhere","type":"plugin","creationDate":"December 2015","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2015 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"https:\\/\\/www.nonumber.nl","version":"4.1.3","description":"PLG_EDITORS-XTD_MODULESANYWHERE_DESC","group":"","filename":"modulesanywhere"}', '[]', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10012, 'plg_system_modulesanywhere', 'plugin', 'modulesanywhere', 'system', 0, 1, 1, 0, '{"name":"plg_system_modulesanywhere","type":"plugin","creationDate":"December 2015","author":"NoNumber (Peter van Westen)","copyright":"Copyright \\u00a9 2015 NoNumber All Rights Reserved","authorEmail":"peter@nonumber.nl","authorUrl":"https:\\/\\/www.nonumber.nl","version":"4.1.3","description":"PLG_SYSTEM_MODULESANYWHERE_DESC","group":"","filename":"modulesanywhere"}', '{"style":"none","styles":"none,division,tabs,well","override_style":"1","@notice_override_settings":"NN_ONLY_AVAILABLE_IN_PRO","ignore_access":"0","ignore_state":"0","ignore_assignments":"1","ignore_caching":"0","@notice_show_edit":"NN_ONLY_AVAILABLE_IN_PRO","place_comments":"1","@notice_articles":"NN_ONLY_AVAILABLE_IN_PRO","@notice_components":"NN_ONLY_AVAILABLE_IN_PRO","@notice_otherareas":"NN_ONLY_AVAILABLE_IN_PRO","button_text":"Module","enable_frontend":"1","@notice_div_enable":"NN_ONLY_AVAILABLE_IN_PRO","@notice_div_width":"NN_ONLY_AVAILABLE_IN_PRO","@notice_div_height":"NN_ONLY_AVAILABLE_IN_PRO","@notice_div_float":"NN_ONLY_AVAILABLE_IN_PRO","@notice_div_class":"NN_ONLY_AVAILABLE_IN_PRO","module_tag":"module","modulepos_tag":"modulepos","tag_characters":"{.}","handle_loadposition":"0","activate_jumper":"0"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10014, 'GTranslate', 'module', 'mod_gtranslate', '', 0, 1, 0, 0, '{"name":"GTranslate","type":"module","creationDate":"September 2010","author":"Edvard Ananyan","copyright":"Copyright (C) 2008 - 2015 Edvard Ananyan. All rights reserved.","authorEmail":"edo888@gmail.com","authorUrl":"http:\\/\\/gtranslate.net","version":"3.0.35","description":"\\n    \\n    <span style=''font-weight:normal;text-align:left;''>\\n    <p>GTranslate - Makes your website multilingual and available to the world.<\\/p>\\n    <p><i>Ugrade to <a href=\\"http:\\/\\/gtranslate.net\\/features?xyz=997\\" target=\\"_blank\\">GTranslate Enterprise<\\/a> and enable the following features:<\\/i><\\/p>\\n    <ul>\\n        <li><strong>Enable search engine indexing<\\/strong> - Search engines will index your translated pages which will increase international traffic.<\\/li>\\n        <li><strong>Search engine friendly<\\/strong> - The URL will change depending on a selected language e.g. es.domain.com for Spanish.<\\/li>\\n        <li><strong>Meta data translation<\\/strong> - Meta keywords and description will be translated which will increase translated keywords ranking in the search engines.<\\/li>\\n        <li><strong>Ability to edit translations<\\/strong> - You will be able to edit the translated texts directly from the front-end.<\\/li>\\n        <li><strong>Cache support<\\/strong> - Translations will be cached and make your translated pages to load faster.<\\/li>\\n        <li><strong><a href=\\"http:\\/\\/gtranslate.net\\/translation-delivery-network\\" target=\\"_blank\\">Translation Delivery Network<\\/a><\\/strong> - The translations will be delivered by our cloud network. No software is installed on your server.<\\/li>\\n        <li><strong>Centralized translation cache<\\/strong> - The quality of the translations cache will improve over time by using crowd sourced and professional translations.<\\/li>\\n        <li><strong>Seamless updates<\\/strong> - We care about further updates. You just enjoy the up to date service every day.<\\/li>\\n        <li><strong>URL Translation<\\/strong> - The URL will be translated which is very important for multilingual SEO.<\\/li>\\n        <li><strong>Ability to edit translated URLs<\\/strong> - You will be able to change the translated URL manually.<\\/li>\\n        <li><strong>Language hosting<\\/strong> - Host your language on top level country domain name to rank higher on local search engines results (ccTLD domain.es).<\\/li>\\n    <\\/ul>\\n\\n    <table border=\\"0\\" cellpadding=\\"20\\">\\n    <tr>\\n    <td>\\n    <h3>Tour Video<\\/h3>\\n    <iframe src=\\"http:\\/\\/player.vimeo.com\\/video\\/30132555?title=1&amp;byline=0&amp;portrait=0\\" width=\\"568\\" height=\\"360\\" frameborder=\\"0\\" webkitAllowFullScreen mozallowfullscreen allowFullScreen><\\/iframe>\\n    <\\/td>\\n    <td>\\n    <h3>Translation Delivery Network<\\/h3>\\n    <iframe src=\\"http:\\/\\/player.vimeo.com\\/video\\/38686858?title=1&amp;byline=0&amp;portrait=0\\" width=\\"568\\" height=\\"360\\" frameborder=\\"0\\" webkitAllowFullScreen mozallowfullscreen allowFullScreen><\\/iframe>\\n    <\\/td>\\n    <\\/tr>\\n    <\\/table>\\n\\n    <p><a href=''http:\\/\\/gtranslate.net\\/docs\\/54-joomla-module-documentation'' target=''_blank'' class=''btn btn-large btn-info''><i class=''icon-support''><\\/i> Documentation<\\/a> &nbsp; <a href=''http:\\/\\/extensions.joomla.org\\/extensions\\/extension\\/languages\\/automatic-translations\\/gtranslate#reviews'' target=''_blank'' class=''btn btn-large btn-warning''><i class=''icon-comments''><\\/i> Reviews<\\/a><\\/p>\\n    <p><b>Version: 3.0.35<\\/b><br\\/>Copyright &copy; 2008 - 2015 Edvard Ananyan, All rights reserved. <a href=''http:\\/\\/gtranslate.net'' target=''_blank''><b>http:\\/\\/gtranslate.net<\\/b><\\/a><\\/p>\\n    <\\/span>\\n    \\n    ","group":"","filename":"mod_gtranslate"}', '{"moduleclass_sfx":"","pro_version":"0","enterprise_version":"0","method":"onfly","look":"both","flag_size":"16","orientation":"h","new_tab":"0","analytics":"0","language":"en","show_af":"1","show_sq":"1","show_ar":"1","show_hy":"1","show_az":"1","show_eu":"1","show_be":"1","show_bg":"1","show_ca":"1","show_zh-CN":"1","show_zh-TW":"1","show_hr":"1","show_cs":"1","show_da":"1","show_nl":"1","show_en":"2","show_et":"1","show_tl":"1","show_fi":"1","show_fr":"2","show_gl":"1","show_ka":"1","show_de":"2","show_el":"1","show_ht":"1","show_iw":"1","show_hi":"1","show_hu":"1","show_is":"1","show_id":"1","show_ga":"1","show_it":"2","show_ja":"1","show_ko":"1","show_lv":"1","show_lt":"1","show_mk":"1","show_ms":"1","show_mt":"1","show_no":"1","show_fa":"1","show_pl":"1","show_pt":"2","show_ro":"1","show_ru":"2","show_sr":"1","show_sk":"1","show_sl":"1","show_es":"2","show_sw":"1","show_sv":"1","show_th":"1","show_tr":"1","show_uk":"1","show_ur":"1","show_vi":"1","show_cy":"1","show_yi":"1","show_bn":"0","show_bs":"0","show_ceb":"0","show_eo":"0","show_gu":"0","show_ha":"0","show_hmn":"0","show_ig":"0","show_jw":"0","show_kn":"0","show_km":"0","show_lo":"0","show_la":"0","show_mi":"0","show_mr":"0","show_mn":"0","show_ne":"0","show_pa":"0","show_so":"0","show_ta":"0","show_te":"0","show_yo":"0","show_zu":"0","cache":"1","cache_time":"900","cachemode":"static"}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10015, 'Akeeba', 'component', 'com_akeeba', '', 1, 1, 0, 0, '{"name":"Akeeba","type":"component","creationDate":"2015-12-22","author":"Nicholas K. Dionysopoulos","copyright":"Copyright (c)2006-2014 Nicholas K. Dionysopoulos","authorEmail":"nicholas@dionysopoulos.me","authorUrl":"http:\\/\\/www.akeebabackup.com","version":"4.5.1","description":"Akeeba Backup Core - Full Joomla! site backup solution, Core Edition.","group":"","filename":"akeeba"}', '{"confwiz_upgrade":1,"siteurl":"http:\\/\\/anthony_rivera\\/cbooks\\/","jlibrariesdir":"C:\\/wamp\\/www\\/cbooks\\/libraries","jversion":"1.6","show_howtorestoremodal":0}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10016, 'F0F (NEW) DO NOT REMOVE', 'library', 'lib_f0f', '', 0, 1, 1, 0, '{"name":"F0F (NEW) DO NOT REMOVE","type":"library","creationDate":"2015-12-21 11:41:04","author":"Nicholas K. Dionysopoulos \\/ Akeeba Ltd","copyright":"(C)2011-2014 Nicholas K. Dionysopoulos","authorEmail":"nicholas@akeebabackup.com","authorUrl":"https:\\/\\/www.akeebabackup.com","version":"2.5.1","description":"Framework-on-Framework (FOF) newer version - DO NOT REMOVE - The rapid component development framework for Joomla!. This package is the newer version of FOF, not the one shipped with Joomla! as the official Joomla! RAD Layer. The Joomla! RAD Layer has ceased development in March 2014. DO NOT UNINSTALL THIS PACKAGE, IT IS *** N O T *** A DUPLICATE OF THE ''FOF'' PACKAGE. REMOVING EITHER FOF PACKAGE WILL BREAK YOUR SITE.","group":"","filename":"lib_f0f"}', '{}', '', '', 0, '0000-00-00 00:00:00', 0, 0),
(10017, 'AkeebaStrapper', 'file', 'AkeebaStrapper', '', 0, 1, 0, 0, '{"name":"AkeebaStrapper","type":"file","creationDate":"2015-12-21 11:41:04","author":"Nicholas K. Dionysopoulos","copyright":"(C) 2012-2013 Akeeba Ltd.","authorEmail":"nicholas@dionysopoulos.me","authorUrl":"https:\\/\\/www.akeebabackup.com","version":"2.5.1","description":"Namespaced jQuery, jQuery UI and Bootstrap for Akeeba products.","group":""}', '', '', '', 0, '0000-00-00 00:00:00', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_filters`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_filters` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms0`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms0` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms1`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms1` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms2`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms2` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms3`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms3` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms4`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms4` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms5`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms5` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms6`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms6` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms7`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms7` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms8`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms8` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_terms9`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_terms9` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_termsa`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_termsa` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_termsb`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_termsb` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_termsc`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_termsc` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_termsd`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_termsd` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_termse`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_termse` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_links_termsf`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_links_termsf` (
  `link_id` int(10) unsigned NOT NULL,
  `term_id` int(10) unsigned NOT NULL,
  `weight` float unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`term_id`),
  KEY `idx_term_weight` (`term_id`,`weight`),
  KEY `idx_link_term_weight` (`link_id`,`term_id`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_taxonomy`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_taxonomy` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `joomla_finder_taxonomy`
--

INSERT INTO `joomla_finder_taxonomy` (`id`, `parent_id`, `title`, `state`, `access`, `ordering`) VALUES
(1, 0, 'ROOT', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_taxonomy_map`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_taxonomy_map` (
  `link_id` int(10) unsigned NOT NULL,
  `node_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`link_id`,`node_id`),
  KEY `link_id` (`link_id`),
  KEY `node_id` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_terms`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_terms` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_terms_common`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_terms_common` (
  `term` varchar(75) NOT NULL,
  `language` varchar(3) NOT NULL,
  KEY `idx_word_lang` (`term`,`language`),
  KEY `idx_lang` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `joomla_finder_terms_common`
--

INSERT INTO `joomla_finder_terms_common` (`term`, `language`) VALUES
('a', 'en'),
('about', 'en'),
('after', 'en'),
('ago', 'en'),
('all', 'en'),
('am', 'en'),
('an', 'en'),
('and', 'en'),
('ani', 'en'),
('any', 'en'),
('are', 'en'),
('aren''t', 'en'),
('as', 'en'),
('at', 'en'),
('be', 'en'),
('but', 'en'),
('by', 'en'),
('for', 'en'),
('from', 'en'),
('get', 'en'),
('go', 'en'),
('how', 'en'),
('if', 'en'),
('in', 'en'),
('into', 'en'),
('is', 'en'),
('isn''t', 'en'),
('it', 'en'),
('its', 'en'),
('me', 'en'),
('more', 'en'),
('most', 'en'),
('must', 'en'),
('my', 'en'),
('new', 'en'),
('no', 'en'),
('none', 'en'),
('not', 'en'),
('noth', 'en'),
('nothing', 'en'),
('of', 'en'),
('off', 'en'),
('often', 'en'),
('old', 'en'),
('on', 'en'),
('onc', 'en'),
('once', 'en'),
('onli', 'en'),
('only', 'en'),
('or', 'en'),
('other', 'en'),
('our', 'en'),
('ours', 'en'),
('out', 'en'),
('over', 'en'),
('page', 'en'),
('she', 'en'),
('should', 'en'),
('small', 'en'),
('so', 'en'),
('some', 'en'),
('than', 'en'),
('thank', 'en'),
('that', 'en'),
('the', 'en'),
('their', 'en'),
('theirs', 'en'),
('them', 'en'),
('then', 'en'),
('there', 'en'),
('these', 'en'),
('they', 'en'),
('this', 'en'),
('those', 'en'),
('thus', 'en'),
('time', 'en'),
('times', 'en'),
('to', 'en'),
('too', 'en'),
('true', 'en'),
('under', 'en'),
('until', 'en'),
('up', 'en'),
('upon', 'en'),
('use', 'en'),
('user', 'en'),
('users', 'en'),
('veri', 'en'),
('version', 'en'),
('very', 'en'),
('via', 'en'),
('want', 'en'),
('was', 'en'),
('way', 'en'),
('were', 'en'),
('what', 'en'),
('when', 'en'),
('where', 'en'),
('whi', 'en'),
('which', 'en'),
('who', 'en'),
('whom', 'en'),
('whose', 'en'),
('why', 'en'),
('wide', 'en'),
('will', 'en'),
('with', 'en'),
('within', 'en'),
('without', 'en'),
('would', 'en'),
('yes', 'en'),
('yet', 'en'),
('you', 'en'),
('your', 'en'),
('yours', 'en');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_tokens`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_tokens` (
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

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_tokens_aggregate`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_tokens_aggregate` (
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

-- --------------------------------------------------------

--
-- Table structure for table `joomla_finder_types`
--

CREATE TABLE IF NOT EXISTS `joomla_finder_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `mime` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_jaem_log`
--

CREATE TABLE IF NOT EXISTS `joomla_jaem_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ext_id` varchar(50) DEFAULT NULL,
  `service_id` int(11) DEFAULT NULL,
  `check_date` datetime DEFAULT NULL,
  `check_info` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ext_id` (`ext_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_jaem_services`
--

CREATE TABLE IF NOT EXISTS `joomla_jaem_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ws_name` varchar(255) NOT NULL,
  `ws_mode` varchar(50) NOT NULL DEFAULT 'local',
  `ws_uri` varchar(255) NOT NULL,
  `ws_user` varchar(100) NOT NULL,
  `ws_pass` varchar(100) NOT NULL,
  `ws_default` tinyint(1) NOT NULL DEFAULT '0',
  `ws_core` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `joomla_jaem_services`
--

INSERT INTO `joomla_jaem_services` (`id`, `ws_name`, `ws_mode`, `ws_uri`, `ws_user`, `ws_pass`, `ws_default`, `ws_core`) VALUES
(1, 'Local Service', 'local', '', '', '', 1, 1),
(2, 'JoomlArt Updates', 'remote', 'http://update.joomlart.com/service/', '', '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_languages`
--

CREATE TABLE IF NOT EXISTS `joomla_languages` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `joomla_languages`
--

INSERT INTO `joomla_languages` (`lang_id`, `lang_code`, `title`, `title_native`, `sef`, `image`, `description`, `metakey`, `metadesc`, `sitename`, `published`, `access`, `ordering`) VALUES
(1, 'en-GB', 'English (UK)', 'English (UK)', 'en', 'en', '', '', '', '', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_menu`
--

CREATE TABLE IF NOT EXISTS `joomla_menu` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=109 ;

--
-- Dumping data for table `joomla_menu`
--

INSERT INTO `joomla_menu` (`id`, `menutype`, `title`, `alias`, `note`, `path`, `link`, `type`, `published`, `parent_id`, `level`, `component_id`, `checked_out`, `checked_out_time`, `browserNav`, `access`, `img`, `template_style_id`, `params`, `lft`, `rgt`, `home`, `language`, `client_id`) VALUES
(1, '', 'Menu_Item_Root', 'root', '', '', '', '', 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0, 0, '', 0, '', 0, 55, 0, '*', 0),
(2, 'menu', 'com_banners', 'Banners', '', 'Banners', 'index.php?option=com_banners', 'component', 0, 1, 1, 4, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners', 0, '', 1, 10, 0, '*', 1),
(3, 'menu', 'com_banners', 'Banners', '', 'Banners/Banners', 'index.php?option=com_banners', 'component', 0, 2, 2, 4, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners', 0, '', 2, 3, 0, '*', 1),
(4, 'menu', 'com_banners_categories', 'Categories', '', 'Banners/Categories', 'index.php?option=com_categories&extension=com_banners', 'component', 0, 2, 2, 6, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-cat', 0, '', 4, 5, 0, '*', 1),
(5, 'menu', 'com_banners_clients', 'Clients', '', 'Banners/Clients', 'index.php?option=com_banners&view=clients', 'component', 0, 2, 2, 4, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-clients', 0, '', 6, 7, 0, '*', 1),
(6, 'menu', 'com_banners_tracks', 'Tracks', '', 'Banners/Tracks', 'index.php?option=com_banners&view=tracks', 'component', 0, 2, 2, 4, 0, '0000-00-00 00:00:00', 0, 0, 'class:banners-tracks', 0, '', 8, 9, 0, '*', 1),
(7, 'menu', 'com_contact', 'Contacts', '', 'Contacts', 'index.php?option=com_contact', 'component', 0, 1, 1, 8, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact', 0, '', 17, 22, 0, '*', 1),
(8, 'menu', 'com_contact', 'Contacts', '', 'Contacts/Contacts', 'index.php?option=com_contact', 'component', 0, 7, 2, 8, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact', 0, '', 18, 19, 0, '*', 1),
(9, 'menu', 'com_contact_categories', 'Categories', '', 'Contacts/Categories', 'index.php?option=com_categories&extension=com_contact', 'component', 0, 7, 2, 6, 0, '0000-00-00 00:00:00', 0, 0, 'class:contact-cat', 0, '', 20, 21, 0, '*', 1),
(10, 'menu', 'com_messages', 'Messaging', '', 'Messaging', 'index.php?option=com_messages', 'component', 0, 1, 1, 15, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages', 0, '', 23, 28, 0, '*', 1),
(11, 'menu', 'com_messages_add', 'New Private Message', '', 'Messaging/New Private Message', 'index.php?option=com_messages&task=message.add', 'component', 0, 10, 2, 15, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages-add', 0, '', 24, 25, 0, '*', 1),
(12, 'menu', 'com_messages_read', 'Read Private Message', '', 'Messaging/Read Private Message', 'index.php?option=com_messages', 'component', 0, 10, 2, 15, 0, '0000-00-00 00:00:00', 0, 0, 'class:messages-read', 0, '', 26, 27, 0, '*', 1),
(13, 'menu', 'com_newsfeeds', 'News Feeds', '', 'News Feeds', 'index.php?option=com_newsfeeds', 'component', 0, 1, 1, 17, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds', 0, '', 29, 34, 0, '*', 1),
(14, 'menu', 'com_newsfeeds_feeds', 'Feeds', '', 'News Feeds/Feeds', 'index.php?option=com_newsfeeds', 'component', 0, 13, 2, 17, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds', 0, '', 30, 31, 0, '*', 1),
(15, 'menu', 'com_newsfeeds_categories', 'Categories', '', 'News Feeds/Categories', 'index.php?option=com_categories&extension=com_newsfeeds', 'component', 0, 13, 2, 6, 0, '0000-00-00 00:00:00', 0, 0, 'class:newsfeeds-cat', 0, '', 32, 33, 0, '*', 1),
(16, 'menu', 'com_redirect', 'Redirect', '', 'Redirect', 'index.php?option=com_redirect', 'component', 0, 1, 1, 24, 0, '0000-00-00 00:00:00', 0, 0, 'class:redirect', 0, '', 35, 36, 0, '*', 1),
(17, 'menu', 'com_search', 'Basic Search', '', 'Basic Search', 'index.php?option=com_search', 'component', 0, 1, 1, 19, 0, '0000-00-00 00:00:00', 0, 0, 'class:search', 0, '', 37, 38, 0, '*', 1),
(18, 'menu', 'com_finder', 'Smart Search', '', 'Smart Search', 'index.php?option=com_finder', 'component', 0, 1, 1, 27, 0, '0000-00-00 00:00:00', 0, 0, 'class:finder', 0, '', 39, 40, 0, '*', 1),
(19, 'menu', 'com_joomlaupdate', 'Joomla! Update', '', 'Joomla! Update', 'index.php?option=com_joomlaupdate', 'component', 1, 1, 1, 28, 0, '0000-00-00 00:00:00', 0, 0, 'class:joomlaupdate', 0, '', 41, 42, 0, '*', 1),
(20, 'main', 'com_tags', 'Tags', '', 'Tags', 'index.php?option=com_tags', 'component', 0, 1, 1, 29, 0, '0000-00-00 00:00:00', 0, 1, 'class:tags', 0, '', 43, 44, 0, '', 1),
(21, 'main', 'com_postinstall', 'Post-installation messages', '', 'Post-installation messages', 'index.php?option=com_postinstall', 'component', 0, 1, 1, 32, 0, '0000-00-00 00:00:00', 0, 1, 'class:postinstall', 0, '', 45, 46, 0, '*', 1),
(101, 'mainmenu', 'Home', 'home', '', 'home', 'index.php?option=com_content&view=article&id=1', 'component', 1, 1, 1, 22, 0, '0000-00-00 00:00:00', 0, 1, ' ', 0, '{"show_title":"","link_titles":"","show_intro":"","info_block_position":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_tags":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":"1","page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0,"masthead-title":"","masthead-slogan":""}', 11, 12, 1, '*', 0),
(102, 'main', 'COM_JAEXTMANAGER', 'com-jaextmanager', '', 'com-jaextmanager', 'index.php?option=com_jaextmanager', 'component', 0, 1, 1, 10005, 0, '0000-00-00 00:00:00', 0, 1, 'components/com_jaextmanager/assets/images/jauc.png', 0, '{}', 47, 48, 0, '', 1),
(103, 'main', 'VJDATABASETOOL_MENU_MAIN', 'vjdatabasetool-menu-main', '', 'vjdatabasetool-menu-main', 'index.php?option=com_vjdatabasetool', 'component', 0, 1, 1, 10008, 0, '0000-00-00 00:00:00', 0, 1, 'class:component', 0, '{}', 49, 50, 0, '', 1),
(104, 'main', 'COM_QUICKLOGOUT', 'com-quicklogout', '', 'com-quicklogout', 'index.php?option=com_quicklogout', 'component', 0, 1, 1, 10009, 0, '0000-00-00 00:00:00', 0, 1, 'class:component', 0, '{}', 51, 52, 0, '', 1),
(105, 'mainmenu', 'Logout', 'logout', '', 'logout', 'index.php?option=com_quicklogout&view=quicklogout', 'component', 1, 1, 1, 10009, 0, '0000-00-00 00:00:00', 0, 2, ' ', 0, '{"quick_logout_redirect":"101","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":"","page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0,"masthead-title":"","masthead-slogan":""}', 15, 16, 0, '*', 0),
(106, 'mainmenu', 'Administration', 'administration', '', 'administration', 'index.php?option=com_content&view=article&id=2', 'component', 1, 1, 1, 22, 0, '0000-00-00 00:00:00', 0, 2, ' ', 0, '{"show_title":"","link_titles":"","show_intro":"","info_block_position":"","show_category":"","link_category":"","show_parent_category":"","link_parent_category":"","show_author":"","link_author":"","show_create_date":"","show_modify_date":"","show_publish_date":"","show_item_navigation":"","show_vote":"","show_icons":"","show_print_icon":"","show_email_icon":"","show_hits":"","show_tags":"","show_noauth":"","urls_position":"","menu-anchor_title":"","menu-anchor_css":"","menu_image":"","menu_text":1,"page_title":"","show_page_heading":"","page_heading":"","pageclass_sfx":"","menu-meta_description":"","menu-meta_keywords":"","robots":"","secure":0,"masthead-title":"","masthead-slogan":""}', 13, 14, 0, '*', 0),
(108, 'main', 'COM_AKEEBA', 'com-akeeba', '', 'com-akeeba', 'index.php?option=com_akeeba', 'component', 1, 1, 1, 10015, 0, '0000-00-00 00:00:00', 0, 1, '../media/com_akeeba/icons/akeeba-16.png', 0, '{}', 53, 54, 0, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_menu_types`
--

CREATE TABLE IF NOT EXISTS `joomla_menu_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menutype` varchar(24) NOT NULL,
  `title` varchar(48) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_menutype` (`menutype`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `joomla_menu_types`
--

INSERT INTO `joomla_menu_types` (`id`, `menutype`, `title`, `description`) VALUES
(1, 'mainmenu', 'Main Menu', 'The main menu for the site');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_messages`
--

CREATE TABLE IF NOT EXISTS `joomla_messages` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_messages_cfg`
--

CREATE TABLE IF NOT EXISTS `joomla_messages_cfg` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cfg_name` varchar(100) NOT NULL DEFAULT '',
  `cfg_value` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `idx_user_var_name` (`user_id`,`cfg_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_modules`
--

CREATE TABLE IF NOT EXISTS `joomla_modules` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=88 ;

--
-- Dumping data for table `joomla_modules`
--

INSERT INTO `joomla_modules` (`id`, `asset_id`, `title`, `note`, `content`, `ordering`, `position`, `checked_out`, `checked_out_time`, `publish_up`, `publish_down`, `published`, `module`, `access`, `showtitle`, `params`, `client_id`, `language`) VALUES
(1, 39, 'Main Menu', '', '', 1, 'off-canvas', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 1, 1, '{"menutype":"mainmenu","base":"","startLevel":"1","endLevel":"0","showAllChildren":"1","tag_id":"","class_sfx":"","window_open":"","layout":"_:default","moduleclass_sfx":"_menu","cache":"1","cache_time":"900","cachemode":"itemid","module_tag":"div","bootstrap_size":"0","header_tag":"h3","header_class":"","style":"0"}', 0, '*'),
(2, 40, 'Login', '', '', 1, 'login', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_login', 1, 1, '', 1, '*'),
(3, 41, 'Popular Articles', '', '', 3, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_popular', 3, 1, '{"count":"5","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(4, 42, 'Recently Added Articles', '', '', 4, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_latest', 3, 1, '{"count":"5","ordering":"c_dsc","catid":"","user_id":"0","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(8, 43, 'Toolbar', '', '', 1, 'toolbar', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_toolbar', 3, 1, '', 1, '*'),
(9, 44, 'Quick Icons', '', '', 1, 'icon', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_quickicon', 3, 1, '', 1, '*'),
(10, 45, 'Logged-in Users', '', '', 2, 'cpanel', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_logged', 3, 1, '{"count":"5","name":"1","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(12, 46, 'Admin Menu', '', '', 1, 'menu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_menu', 3, 1, '{"layout":"","moduleclass_sfx":"","shownew":"1","showhelp":"1","cache":"0"}', 1, '*'),
(13, 47, 'Admin Submenu', '', '', 1, 'submenu', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_submenu', 3, 1, '', 1, '*'),
(14, 48, 'User Status', '', '', 2, 'status', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_status', 3, 1, '', 1, '*'),
(15, 49, 'Title', '', '', 1, 'title', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_title', 3, 1, '', 1, '*'),
(16, 50, 'Login Form', '', '', 1, '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_login', 5, 1, '{"pretext":"","posttext":"","login":"106","logout":"101","greeting":"1","name":"0","usesecure":"0","usetext":"0","layout":"_:default","moduleclass_sfx":"","cache":"0","module_tag":"div","bootstrap_size":"0","header_tag":"h3","header_class":"","style":"0"}', 0, '*'),
(17, 51, 'Breadcrumbs', '', '', 1, 'navhelper', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_breadcrumbs', 1, 1, '{"showHere":"1","showHome":"1","homeText":"","showLast":"1","separator":"","layout":"_:default","moduleclass_sfx":"","cache":"1","cache_time":"900","cachemode":"itemid","module_tag":"div","bootstrap_size":"0","header_tag":"h3","header_class":"","style":"0"}', 0, '*'),
(79, 52, 'Multilanguage status', '', '', 1, 'status', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 'mod_multilangstatus', 3, 1, '{"layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(86, 53, 'Joomla Version', '', '', 1, 'footer', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_version', 3, 1, '{"format":"short","product":"1","layout":"_:default","moduleclass_sfx":"","cache":"0"}', 1, '*'),
(87, 59, 'Translate', '', '', 1, 'head-search', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 'mod_gtranslate', 1, 0, '{"moduleclass_sfx":"","pro_version":"0","enterprise_version":"0","method":"onfly","look":"both","flag_size":"16","orientation":"h","new_tab":"0","analytics":"0","language":"en","show_af":"1","show_sq":"1","show_ar":"1","show_hy":"1","show_az":"1","show_eu":"1","show_be":"1","show_bg":"1","show_ca":"1","show_zh-CN":"1","show_zh-TW":"1","show_hr":"1","show_cs":"1","show_da":"1","show_nl":"1","show_en":"1","show_et":"1","show_tl":"1","show_fi":"1","show_fr":"1","show_gl":"1","show_ka":"1","show_de":"1","show_el":"1","show_ht":"1","show_iw":"1","show_hi":"1","show_hu":"1","show_is":"1","show_id":"1","show_ga":"1","show_it":"1","show_ja":"1","show_ko":"1","show_lv":"1","show_lt":"1","show_mk":"1","show_ms":"1","show_mt":"1","show_no":"1","show_fa":"1","show_pl":"1","show_pt":"1","show_ro":"1","show_ru":"1","show_sr":"1","show_sk":"1","show_sl":"1","show_es":"1","show_sw":"1","show_sv":"1","show_th":"1","show_tr":"1","show_uk":"1","show_ur":"1","show_vi":"1","show_cy":"1","show_yi":"1","show_bn":"1","show_bs":"1","show_ceb":"1","show_eo":"1","show_gu":"1","show_ha":"1","show_hmn":"1","show_ig":"1","show_jw":"1","show_kn":"1","show_km":"1","show_lo":"1","show_la":"1","show_mi":"1","show_mr":"1","show_mn":"1","show_ne":"1","show_pa":"1","show_so":"1","show_ta":"1","show_te":"1","show_yo":"1","show_zu":"1","cache":"1","cache_time":"900","cachemode":"static","module_tag":"div","bootstrap_size":"0","header_tag":"h3","header_class":"","style":"0"}', 0, '*');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_modules_menu`
--

CREATE TABLE IF NOT EXISTS `joomla_modules_menu` (
  `moduleid` int(11) NOT NULL DEFAULT '0',
  `menuid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`moduleid`,`menuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `joomla_modules_menu`
--

INSERT INTO `joomla_modules_menu` (`moduleid`, `menuid`) VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(12, 0),
(13, 0),
(14, 0),
(15, 0),
(16, 0),
(17, 0),
(79, 0),
(86, 0),
(87, 0);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_newsfeeds`
--

CREATE TABLE IF NOT EXISTS `joomla_newsfeeds` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_overrider`
--

CREATE TABLE IF NOT EXISTS `joomla_overrider` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `constant` varchar(255) NOT NULL,
  `string` text NOT NULL,
  `file` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_postinstall_messages`
--

CREATE TABLE IF NOT EXISTS `joomla_postinstall_messages` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `joomla_postinstall_messages`
--

INSERT INTO `joomla_postinstall_messages` (`postinstall_message_id`, `extension_id`, `title_key`, `description_key`, `action_key`, `language_extension`, `language_client_id`, `type`, `action_file`, `action`, `condition_file`, `condition_method`, `version_introduced`, `enabled`) VALUES
(1, 700, 'PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_TITLE', 'PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_BODY', 'PLG_TWOFACTORAUTH_TOTP_POSTINSTALL_ACTION', 'plg_twofactorauth_totp', 1, 'action', 'site://plugins/twofactorauth/totp/postinstall/actions.php', 'twofactorauth_postinstall_action', 'site://plugins/twofactorauth/totp/postinstall/actions.php', 'twofactorauth_postinstall_condition', '3.2.0', 1),
(2, 700, 'COM_CPANEL_WELCOME_BEGINNERS_TITLE', 'COM_CPANEL_WELCOME_BEGINNERS_MESSAGE', '', 'com_cpanel', 1, 'message', '', '', '', '', '3.2.0', 1);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_redirect_links`
--

CREATE TABLE IF NOT EXISTS `joomla_redirect_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_url` varchar(255) NOT NULL,
  `new_url` varchar(255) DEFAULT NULL,
  `referer` varchar(150) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `hits` int(10) unsigned NOT NULL DEFAULT '0',
  `published` tinyint(4) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `header` smallint(3) NOT NULL DEFAULT '301',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_link_old` (`old_url`),
  KEY `idx_link_modifed` (`modified_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_schemas`
--

CREATE TABLE IF NOT EXISTS `joomla_schemas` (
  `extension_id` int(11) NOT NULL,
  `version_id` varchar(20) NOT NULL,
  PRIMARY KEY (`extension_id`,`version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `joomla_schemas`
--

INSERT INTO `joomla_schemas` (`extension_id`, `version_id`) VALUES
(700, '3.4.0-2015-02-26');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_session`
--

CREATE TABLE IF NOT EXISTS `joomla_session` (
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

--
-- Dumping data for table `joomla_session`
--

INSERT INTO `joomla_session` (`session_id`, `client_id`, `guest`, `time`, `data`, `userid`, `username`) VALUES
('hvlph11lar3q97vqeg5bnjnu80', 1, 0, '1453435992', 'joomla|s:3096:"TzoyNDoiSm9vbWxhXFJlZ2lzdHJ5XFJlZ2lzdHJ5IjoyOntzOjc6IgAqAGRhdGEiO086ODoic3RkQ2xhc3MiOjI6e3M6OToiX19kZWZhdWx0IjtPOjg6InN0ZENsYXNzIjo0OntzOjc6InNlc3Npb24iO086ODoic3RkQ2xhc3MiOjM6e3M6NzoiY291bnRlciI7aToxMDI7czo1OiJ0aW1lciI7Tzo4OiJzdGRDbGFzcyI6Mzp7czo1OiJzdGFydCI7aToxNDUzNDM1MTc0O3M6NDoibGFzdCI7aToxNDUzNDM1OTkwO3M6Mzoibm93IjtpOjE0NTM0MzU5OTA7fXM6NToidG9rZW4iO3M6MzI6ImM0NDlhOTE2NjZkOTY0NWQ4YjQyNzYzMzIzMDVhYTFlIjt9czo4OiJyZWdpc3RyeSI7TzoyNDoiSm9vbWxhXFJlZ2lzdHJ5XFJlZ2lzdHJ5IjoyOntzOjc6IgAqAGRhdGEiO086ODoic3RkQ2xhc3MiOjU6e3M6MTE6ImFwcGxpY2F0aW9uIjtPOjg6InN0ZENsYXNzIjoxOntzOjQ6ImxhbmciO3M6NToiZW4tR0IiO31zOjEzOiJjb21faW5zdGFsbGVyIjtPOjg6InN0ZENsYXNzIjozOntzOjc6Im1lc3NhZ2UiO3M6MDoiIjtzOjE3OiJleHRlbnNpb25fbWVzc2FnZSI7czowOiIiO3M6MTI6InJlZGlyZWN0X3VybCI7Tjt9czoxMDoiY29tX2FrZWViYSI7Tzo4OiJzdGRDbGFzcyI6MTp7czoxMDoic3RhdGlzdGljcyI7Tzo4OiJzdGRDbGFzcyI6Mjp7czo1OiJsaW1pdCI7aToyMDtzOjEwOiJsaW1pdHN0YXJ0IjtpOjA7fX1zOjY6Imdsb2JhbCI7Tzo4OiJzdGRDbGFzcyI6MTp7czo0OiJsaXN0IjtPOjg6InN0ZENsYXNzIjoxOntzOjU6ImxpbWl0IjtzOjI6IjIwIjt9fXM6Mjg6ImNvbV9ha2VlYmFwcm9maWxlc2xpbWl0c3RhcnQiO3M6MToiMCI7fXM6OToic2VwYXJhdG9yIjtzOjE6Ii4iO31zOjQ6InVzZXIiO086NToiSlVzZXIiOjI4OntzOjk6IgAqAGlzUm9vdCI7YjoxO3M6MjoiaWQiO3M6MzoiNDU4IjtzOjQ6Im5hbWUiO3M6MTQ6IkFudGhvbnkgUml2ZXJhIjtzOjg6InVzZXJuYW1lIjtzOjc6InJldm9idHoiO3M6NToiZW1haWwiO3M6Mjc6ImFudGhvbnkucmV2b2NvZGV6QGdtYWlsLmNvbSI7czo4OiJwYXNzd29yZCI7czo2MDoiJDJ5JDEwJDJldjhTSDRtZTFTR1AyNW0zQ2ZGd09SZGVNRllzVGR3YWFJLnVrOS45N0NSampEZGZTMzNpIjtzOjE0OiJwYXNzd29yZF9jbGVhciI7czowOiIiO3M6NToiYmxvY2siO3M6MToiMCI7czo5OiJzZW5kRW1haWwiO3M6MToiMSI7czoxMjoicmVnaXN0ZXJEYXRlIjtzOjE5OiIyMDE1LTExLTE1IDAzOjAwOjE2IjtzOjEzOiJsYXN0dmlzaXREYXRlIjtzOjE5OiIyMDE2LTAxLTIyIDAzOjU0OjQyIjtzOjEwOiJhY3RpdmF0aW9uIjtzOjE6IjAiO3M6NjoicGFyYW1zIjtzOjExMToieyJhZG1pbl9zdHlsZSI6IiIsImFkbWluX2xhbmd1YWdlIjoiIiwibGFuZ3VhZ2UiOiIiLCJlZGl0b3IiOiIiLCJoZWxwc2l0ZSI6IiIsInRpbWV6b25lIjoiIiwicGFyaXNoX2lkIjoiMTAwNCJ9IjtzOjY6Imdyb3VwcyI7YToxOntpOjg7czoxOiI4Ijt9czo1OiJndWVzdCI7aTowO3M6MTM6Imxhc3RSZXNldFRpbWUiO3M6MTk6IjAwMDAtMDAtMDAgMDA6MDA6MDAiO3M6MTA6InJlc2V0Q291bnQiO3M6MToiMCI7czoxMjoicmVxdWlyZVJlc2V0IjtzOjE6IjAiO3M6MTA6IgAqAF9wYXJhbXMiO086MjQ6Ikpvb21sYVxSZWdpc3RyeVxSZWdpc3RyeSI6Mjp7czo3OiIAKgBkYXRhIjtPOjg6InN0ZENsYXNzIjo3OntzOjExOiJhZG1pbl9zdHlsZSI7czowOiIiO3M6MTQ6ImFkbWluX2xhbmd1YWdlIjtzOjA6IiI7czo4OiJsYW5ndWFnZSI7czowOiIiO3M6NjoiZWRpdG9yIjtzOjA6IiI7czo4OiJoZWxwc2l0ZSI7czowOiIiO3M6ODoidGltZXpvbmUiO3M6MDoiIjtzOjk6InBhcmlzaF9pZCI7czo0OiIxMDA0Ijt9czo5OiJzZXBhcmF0b3IiO3M6MToiLiI7fXM6MTQ6IgAqAF9hdXRoR3JvdXBzIjthOjI6e2k6MDtpOjE7aToxO2k6ODt9czoxNDoiACoAX2F1dGhMZXZlbHMiO2E6NTp7aTowO2k6MTtpOjE7aToxO2k6MjtpOjI7aTozO2k6MztpOjQ7aTo2O31zOjE1OiIAKgBfYXV0aEFjdGlvbnMiO047czoxMjoiACoAX2Vycm9yTXNnIjtOO3M6MTM6IgAqAHVzZXJIZWxwZXIiO086MTg6IkpVc2VyV3JhcHBlckhlbHBlciI6MDp7fXM6MTA6IgAqAF9lcnJvcnMiO2E6MDp7fXM6MzoiYWlkIjtpOjA7czo2OiJvdHBLZXkiO3M6MDoiIjtzOjQ6Im90ZXAiO3M6MDoiIjt9czoxMToiYXBwbGljYXRpb24iO086ODoic3RkQ2xhc3MiOjE6e3M6NToicXVldWUiO047fX1zOjg6Il9fYWtlZWJhIjtPOjg6InN0ZENsYXNzIjoyOntzOjc6InByb2ZpbGUiO2k6MTtzOjc6ImJ1YWRtaW4iO086ODoic3RkQ2xhc3MiOjE6e3M6NDoidGFzayI7czo3OiJkZWZhdWx0Ijt9fX1zOjk6InNlcGFyYXRvciI7czoxOiIuIjt9";', 458, 'revobtz');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_tags`
--

CREATE TABLE IF NOT EXISTS `joomla_tags` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `joomla_tags`
--

INSERT INTO `joomla_tags` (`id`, `parent_id`, `lft`, `rgt`, `level`, `path`, `title`, `alias`, `note`, `description`, `published`, `checked_out`, `checked_out_time`, `access`, `params`, `metadesc`, `metakey`, `metadata`, `created_user_id`, `created_time`, `created_by_alias`, `modified_user_id`, `modified_time`, `images`, `urls`, `hits`, `language`, `version`, `publish_up`, `publish_down`) VALUES
(1, 0, 0, 1, 0, '', 'ROOT', 'root', '', '', 1, 0, '0000-00-00 00:00:00', 1, '', '', '', '', 42, '2011-01-01 00:00:01', '', 0, '0000-00-00 00:00:00', '', '', 0, '*', 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_template_styles`
--

CREATE TABLE IF NOT EXISTS `joomla_template_styles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) NOT NULL DEFAULT '',
  `client_id` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `home` char(7) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_template` (`template`),
  KEY `idx_home` (`home`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `joomla_template_styles`
--

INSERT INTO `joomla_template_styles` (`id`, `template`, `client_id`, `home`, `title`, `params`) VALUES
(4, 'beez3', 0, '0', 'Beez3 - Default', '{"wrapperSmall":"53","wrapperLarge":"72","logo":"images\\/joomla_black.png","sitetitle":"Joomla!","sitedescription":"Open Source Content Management","navposition":"left","templatecolor":"personal","html5":"0"}'),
(5, 'hathor', 1, '0', 'Hathor - Default', '{"showSiteName":"0","colourChoice":"","boldText":"0"}'),
(7, 'protostar', 0, '0', 'protostar - Default', '{"templateColor":"","logoFile":"","googleFont":"1","googleFontName":"Open+Sans","fluidContainer":"0"}'),
(8, 'isis', 1, '1', 'isis - Default', '{"templateColor":"","logoFile":""}'),
(9, 'g5_hydrogen', 0, '0', 'Hydrogen - Default', '{"configuration":"9"}'),
(10, 'purity_iii', 0, '1', 'purity_III - Default', '{"tpl_article_info_datetime_format":"d M Y","t3_template":"1","devmode":"0","themermode":"1","legacy_css":"0","responsive":"1","non_responsive_width":"970px","build_rtl":"0","t3-assets":"t3-assets","t3-rmvlogo":"1","minify":"0","minify_js":"0","minify_js_tool":"jsmin","minify_exclude":"","link_titles":"","theme":"","logotype":"image","sitename":"","slogan":"","logoimage":"","enable_logoimage_sm":"0","logoimage_sm":"","mainlayout":"blog","sublayout":"","mm_type":"mainmenu","navigation_trigger":"hover","navigation_type":"megamenu","navigation_animation":"slide","navigation_animation_duration":"200","mm_config":"","navigation_collapse_enable":"0","addon_offcanvas_enable":"1","addon_offcanvas_effect":"off-canvas-effect-4","snippet_open_head":"","snippet_close_head":"","snippet_open_body":"","snippet_close_body":"","snippet_debug":"0"}');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_ucm_base`
--

CREATE TABLE IF NOT EXISTS `joomla_ucm_base` (
  `ucm_id` int(10) unsigned NOT NULL,
  `ucm_item_id` int(10) NOT NULL,
  `ucm_type_id` int(11) NOT NULL,
  `ucm_language_id` int(11) NOT NULL,
  PRIMARY KEY (`ucm_id`),
  KEY `idx_ucm_item_id` (`ucm_item_id`),
  KEY `idx_ucm_type_id` (`ucm_type_id`),
  KEY `idx_ucm_language_id` (`ucm_language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_ucm_content`
--

CREATE TABLE IF NOT EXISTS `joomla_ucm_content` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains core content data in name spaced fields' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_ucm_history`
--

CREATE TABLE IF NOT EXISTS `joomla_ucm_history` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `joomla_ucm_history`
--

INSERT INTO `joomla_ucm_history` (`version_id`, `ucm_item_id`, `ucm_type_id`, `version_note`, `save_date`, `editor_user_id`, `character_count`, `sha1_hash`, `version_data`, `keep_forever`) VALUES
(5, 1, 1, '', '2015-11-15 14:24:19', 458, 2959, 'b9106d0b3df55544df67309a85b8ec9aa7b2159a', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script language=\\"javascript\\" type=\\"text\\/javascript\\" src=\\"js\\/loader.js\\"&gt;<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>\\/\\/ You can place JavaScript like this<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>&lt;\\/script&gt;<br \\/>&lt;div id=\\"#main-content\\"&gt;<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>$user = JFactory::getUser();<br \\/><br \\/>if(!$user-&gt;guest)<br \\/>{<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<br \\/>}<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>?&gt;<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-15 14:24:19","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-15 14:22:57","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\"}","version":5,"ordering":"0","metakey":"","metadesc":"","access":"1","hits":"37","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(6, 1, 1, '', '2015-11-15 14:26:03', 458, 2612, '238d8016bf02ea5ab5301fb3b2f9c3fa0e519293', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>$user = JFactory::getUser();<br \\/><br \\/>if(!$user-&gt;guest)<br \\/>{<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<br \\/>}<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>?&gt;<br \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-15 14:26:03","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-15 14:24:19","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\"}","version":6,"ordering":"0","metakey":"","metadesc":"","access":"1","hits":"43","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(7, 1, 1, '', '2015-11-15 14:28:13', 458, 2671, 'ffe393f97bfc8851284904283491f5895f2baceb', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>$user = JFactory::getUser();<br \\/><br \\/>if(!$user-&gt;guest)<br \\/>{<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<br \\/>}<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>?&gt;<br \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-15 14:28:13","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-15 14:26:03","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\"}","version":7,"ordering":"0","metakey":"","metadesc":"","access":"1","hits":"48","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(8, 1, 1, '', '2015-11-15 16:37:27', 458, 2696, '92d843e5d3d92ff8f0e8a0f0746641e7fc61f587', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>$user = JFactory::getUser();<br \\/><br \\/>if(!$user-&gt;guest)<br \\/>{<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<br \\/>}<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>?&gt;<br \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-15 16:37:27","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-15 16:36:33","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"0\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"0\\",\\"link_category\\":\\"0\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"0\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":8,"ordering":"0","metakey":"","metadesc":"","access":"1","hits":"93","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(9, 1, 1, '', '2015-11-15 16:38:09', 458, 2693, '4569e6eff03d0831ca57f3570dad57806cc2167c', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>$user = JFactory::getUser();<br \\/><br \\/>if(!$user-&gt;guest)<br \\/>{<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<br \\/>}<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>?&gt;<br \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-15 16:38:09","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-15 16:37:48","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"0\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":9,"ordering":"0","metakey":"","metadesc":"","access":"1","hits":"94","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(10, 1, 1, '', '2015-11-15 16:38:22', 458, 2693, '8728efa27663e3c8b10d7a8b65dcc7f3a13f7c00', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>$user = JFactory::getUser();<br \\/><br \\/>if(!$user-&gt;guest)<br \\/>{<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<br \\/>}<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>?&gt;<br \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-15 16:38:22","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-15 16:38:09","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":10,"ordering":"0","metakey":"","metadesc":"","access":"1","hits":"95","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(11, 1, 12, '', '2015-11-15 20:43:14', 458, 543, '01bb2475f6f53046f15aaeb5962bc73f91ca8cb6', '{"id":"1","user_id":"458","catid":"7","subject":"","body":"<p>Antes de crear la cuenta de los usuarios<\\/p>\\r\\n<p>Crear la diocesis y asignar su respectivo ID<\\/p>\\r\\n<p>Crear la parroquia y asignar su respectivo ID<\\/p>\\r\\n<p>Crear los usuarios y asignar sus respectivos ID<\\/p>\\r\\n<p>\\u00a0<\\/p>","state":"1","checked_out":null,"checked_out_time":null,"created_user_id":"458","created_time":"2015-11-15 20:43:14","modified_user_id":"458","modified_time":"2015-11-15 20:43:14","review_time":"1970-01-01","publish_up":null,"publish_down":null}', 0),
(12, 1, 1, '', '2015-11-21 21:52:14', 458, 2725, 'dc48b2687345f8a5b8261984800fa9d04207027f', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<p>{module Login Form}<\\/p>\\r\\n<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>$user = JFactory::getUser();<br \\/><br \\/>if(!$user-&gt;guest)<br \\/>{<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<br \\/>}<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>?&gt;<br \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-21 21:52:14","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-21 21:51:46","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":11,"ordering":"0","metakey":"","metadesc":"","access":"1","hits":"156","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(13, 1, 1, '', '2015-11-21 21:56:19', 458, 3465, 'b3c62f8b7bcf07fb08d40cf91b1cfdd90e38d9c8', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<p>\\u00a0<\\/p>\\r\\n<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>$user = JFactory::getUser();<br \\/><br \\/>if(!$user-&gt;guest)<br \\/>{<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<br \\/>}<\\/span><\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">else<\\/span><\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">{<\\/span><\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">?&gt;<\\/span><\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">&lt;h3&gt;Welcome to Cbooks!&lt;h3&gt;<\\/span><\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">&lt;small&gt;Please enter your username and password to login to the system!&lt;\\/small&gt;<\\/span><\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">&lt;?php<\\/span><\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">}<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><br \\/>?&gt;<br \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>\\r\\n<p>{module Login Form}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-21 21:56:19","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-21 21:53:50","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":12,"ordering":"0","metakey":"","metadesc":"","access":"1","hits":"160","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(14, 1, 1, '', '2015-11-22 05:10:54', 458, 1915, '5a146eb2a792e40cc87bcd24e07858a44f766ac0', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<h3>Welcome to Cbooks!<\\/h3>\\r\\n<p>\\u00a0<\\/p>\\r\\n<h6><span style=\\"font-family: courier new, courier, monospace;\\">Please enter your username and password to login to the system!<\\/span><\\/h6>\\r\\n<p>{module Login Form}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-22 05:10:54","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-22 05:08:14","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":13,"ordering":"0","metakey":"","metadesc":"","access":"1","hits":"172","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(15, 2, 1, '', '2015-11-22 05:12:13', 458, 2503, '82b7b70aba323db43180eca01a8e15a320814dfe', '{"id":"2","asset_id":58,"title":"Admin","alias":"admin","introtext":"<p>\\u00a0{source}<\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<\\/span><\\/p>\\r\\n<p>?&gt;<\\/p>\\r\\n<p>&lt;\\/div&gt;<\\/p>\\r\\n<p>\\u00a0<\\/p>\\r\\n<p>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-22 05:12:13","created_by":"458","created_by_alias":"","modified":"2015-11-22 05:12:13","modified_by":null,"checked_out":null,"checked_out_time":null,"publish_up":"2015-11-22 05:12:13","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":1,"ordering":null,"metakey":"","metadesc":"","access":"2","hits":null,"metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(16, 2, 1, '', '2015-11-22 05:17:19', 458, 2502, '47919b7faafa1d00cd1f421dccf9fc8ab4157b47', '{"id":2,"asset_id":"58","title":"Admin","alias":"admin","introtext":"<p>\\u00a0{source}<\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<\\/span><\\/p>\\r\\n<p>?&gt;<\\/p>\\r\\n<p>&lt;\\/div&gt;<\\/p>\\r\\n<p>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-22 05:12:13","created_by":"458","created_by_alias":"","modified":"2015-11-22 05:17:19","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-22 05:17:02","publish_up":"2015-11-22 05:12:13","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":2,"ordering":"0","metakey":"","metadesc":"","access":"2","hits":"0","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(17, 1, 1, '', '2015-11-22 05:20:33', 458, 2766, '070b63de6463b795b452da55d6a5bf94aeab12fb', '{"id":1,"asset_id":"54","title":"Home","alias":"home","introtext":"<p>{source}<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>$user = JFactory::getUser();<br \\/><br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>if($user-&gt;guest)<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>{<br \\/>?&gt;<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>&lt;h3&gt;<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>Welcome to Cbooks!<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>&lt;\\/h3&gt;<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>&lt;h6&gt;<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>Please enter your username and password to login to the system!<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>&lt;\\/h6&gt;<br \\/>&lt;?php<br \\/><img src=\\"media\\/sourcerer\\/images\\/tab.png\\" alt=\\"\\" \\/>}<br \\/>?&gt;<br \\/>{\\/source}<\\/p>\\r\\n<p>{module Login Form}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-15 04:13:31","created_by":"458","created_by_alias":"","modified":"2015-11-22 05:20:33","modified_by":"458","checked_out":"0","checked_out_time":"0000-00-00 00:00:00","publish_up":"2015-11-15 04:13:31","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":14,"ordering":"1","metakey":"","metadesc":"","access":"1","hits":"173","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(18, 2, 1, '', '2015-11-22 05:26:10', 458, 2496, 'd0b653877053788309341f99f57164f7d68591c7', '{"id":2,"asset_id":"58","title":"Admin","alias":"admin","introtext":"<p>{source}<\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;style&gt;<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-webkit-viewport { width: device-width; }<br \\/>@-moz-viewport { width: device-width; }<br \\/>@-ms-viewport { width: device-width; }<br \\/>@-o-viewport { width: device-width; }<br \\/>@viewport { width: device-width; }<br \\/>&lt;\\/style&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<\\/span><\\/p>\\r\\n<p>?&gt;<\\/p>\\r\\n<p>&lt;\\/div&gt;<\\/p>\\r\\n<p>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-22 05:12:13","created_by":"458","created_by_alias":"","modified":"2015-11-22 05:26:10","modified_by":"458","checked_out":"458","checked_out_time":"2015-11-22 05:25:38","publish_up":"2015-11-22 05:12:13","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":3,"ordering":"0","metakey":"","metadesc":"","access":"2","hits":"7","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(19, 2, 1, '', '2015-12-17 20:36:55', 458, 2316, '8b47bd052dc092322362c522d4546cc5e4b2dd03', '{"id":2,"asset_id":"58","title":"Admin","alias":"admin","introtext":"<p>{source}<\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/><span style=\\"font-size: 12.16px; line-height: 15.808px;\\">&lt;link href=\\"css\\/custom.css\\" rel=\\"stylesheet\\"&gt;<\\/span><br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::Render(1);<\\/span><\\/p>\\r\\n<p>?&gt;<\\/p>\\r\\n<p>&lt;\\/div&gt;<\\/p>\\r\\n<p>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-22 05:12:13","created_by":"458","created_by_alias":"","modified":"2015-12-17 20:36:55","modified_by":"458","checked_out":"458","checked_out_time":"2015-12-17 20:35:43","publish_up":"2015-11-22 05:12:13","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":4,"ordering":"0","metakey":"","metadesc":"","access":"2","hits":"117","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(20, 2, 1, '', '2015-12-29 17:50:04', 458, 2445, 'b3f2645aec6b22981d8e820d199a43b801f99082', '{"id":2,"asset_id":"58","title":"Admin","alias":"admin","introtext":"<p>{source}<\\/p>\\r\\n<p><span style=\\"font-family: courier new, courier, monospace;\\">&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/><span style=\\"font-size: 12.16px; line-height: 15.808px;\\">&lt;link href=\\"css\\/custom.css\\" rel=\\"stylesheet\\"&gt;<\\/span><br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::<\\/span>ButtonsBig<span style=\\"font-family: ''courier new'', courier, monospace; font-size: 12.16px; line-height: 1.3em;\\">(\\"sacraments\\");<\\/span><\\/p>\\r\\n<p>?&gt;<\\/p>\\r\\n<p>&lt;\\/div&gt;<\\/p>\\r\\n<p>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-22 05:12:13","created_by":"458","created_by_alias":"","modified":"2015-12-29 17:50:04","modified_by":"458","checked_out":"458","checked_out_time":"2015-12-29 17:48:21","publish_up":"2015-11-22 05:12:13","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":5,"ordering":"0","metakey":"","metadesc":"","access":"2","hits":"117","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0),
(21, 2, 1, '', '2015-12-31 16:31:32', 458, 2246, '6243761d6f7e360f8a01eee2146abf2545327220', '{"id":2,"asset_id":"58","title":"Admin","alias":"admin","introtext":"<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/custom.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::ButtonsBig(\\"sacraments\\");<br \\/>?&gt;<br \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-22 05:12:13","created_by":"458","created_by_alias":"","modified":"2015-12-31 16:31:32","modified_by":"458","checked_out":"458","checked_out_time":"2015-12-31 16:30:51","publish_up":"2015-11-22 05:12:13","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":6,"ordering":"0","metakey":"","metadesc":"","access":"2","hits":"133","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0);
INSERT INTO `joomla_ucm_history` (`version_id`, `ucm_item_id`, `ucm_type_id`, `version_note`, `save_date`, `editor_user_id`, `character_count`, `sha1_hash`, `version_data`, `keep_forever`) VALUES
(22, 2, 1, '', '2016-01-22 01:12:59', 458, 2264, '4ab9d63f26181fc55c5de086c32fcbc083479cad', '{"id":2,"asset_id":"58","title":"Administration","alias":"administration","introtext":"<p>{source}<span style=\\"font-family: courier new, courier, monospace;\\"><br \\/>&lt;link href=\\"css\\/font-awesome\\/css\\/font-awesome.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/animate.min.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;link href=\\"css\\/custom.css\\" rel=\\"stylesheet\\"&gt;<br \\/>&lt;script src=\\"js\\/loader.js\\"&gt;&lt;\\/script&gt;<br \\/>&lt;div id=\\"main-content\\"&gt;<br \\/>&lt;?php<br \\/>require_once \\"php\\/lazy\\/menu.php\\";<br \\/>Menu::ButtonsBig(\\"sacraments\\");<br \\/>?&gt;<br \\/>&lt;\\/div&gt;<br \\/><\\/span>{\\/source}<\\/p>","fulltext":"","state":1,"catid":"2","created":"2015-11-22 05:12:13","created_by":"458","created_by_alias":"","modified":"2016-01-22 01:12:59","modified_by":"458","checked_out":"458","checked_out_time":"2016-01-22 01:12:31","publish_up":"2015-11-22 05:12:13","publish_down":"0000-00-00 00:00:00","images":"{\\"image_intro\\":\\"\\",\\"float_intro\\":\\"\\",\\"image_intro_alt\\":\\"\\",\\"image_intro_caption\\":\\"\\",\\"image_fulltext\\":\\"\\",\\"float_fulltext\\":\\"\\",\\"image_fulltext_alt\\":\\"\\",\\"image_fulltext_caption\\":\\"\\"}","urls":"{\\"urla\\":false,\\"urlatext\\":\\"\\",\\"targeta\\":\\"\\",\\"urlb\\":false,\\"urlbtext\\":\\"\\",\\"targetb\\":\\"\\",\\"urlc\\":false,\\"urlctext\\":\\"\\",\\"targetc\\":\\"\\"}","attribs":"{\\"show_title\\":\\"\\",\\"link_titles\\":\\"\\",\\"show_tags\\":\\"\\",\\"show_intro\\":\\"\\",\\"info_block_position\\":\\"\\",\\"show_category\\":\\"\\",\\"link_category\\":\\"\\",\\"show_parent_category\\":\\"\\",\\"link_parent_category\\":\\"\\",\\"show_author\\":\\"\\",\\"link_author\\":\\"\\",\\"show_create_date\\":\\"\\",\\"show_modify_date\\":\\"\\",\\"show_publish_date\\":\\"\\",\\"show_item_navigation\\":\\"\\",\\"show_icons\\":\\"\\",\\"show_print_icon\\":\\"\\",\\"show_email_icon\\":\\"\\",\\"show_vote\\":\\"\\",\\"show_hits\\":\\"\\",\\"show_noauth\\":\\"\\",\\"urls_position\\":\\"\\",\\"alternative_readmore\\":\\"\\",\\"article_layout\\":\\"\\",\\"show_publishing_options\\":\\"\\",\\"show_article_options\\":\\"\\",\\"show_urls_images_backend\\":\\"\\",\\"show_urls_images_frontend\\":\\"\\",\\"extra-class\\":\\"\\"}","version":7,"ordering":"0","metakey":"","metadesc":"","access":"2","hits":"280","metadata":"{\\"robots\\":\\"\\",\\"author\\":\\"\\",\\"rights\\":\\"\\",\\"xreference\\":\\"\\"}","featured":"0","language":"*","xreference":""}', 0);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_updates`
--

CREATE TABLE IF NOT EXISTS `joomla_updates` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Available Updates' AUTO_INCREMENT=348 ;

--
-- Dumping data for table `joomla_updates`
--

INSERT INTO `joomla_updates` (`update_id`, `update_site_id`, `extension_id`, `name`, `description`, `element`, `type`, `folder`, `client_id`, `version`, `data`, `detailsurl`, `infourl`, `extra_query`) VALUES
(1, 3, 0, 'Armenian', '', 'pkg_hy-AM', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/hy-AM_details.xml', '', ''),
(2, 3, 0, 'Malay', '', 'pkg_ms-MY', 'package', '', 0, '3.4.1.2', '', 'http://update.joomla.org/language/details3/ms-MY_details.xml', '', ''),
(3, 3, 0, 'Romanian', '', 'pkg_ro-RO', 'package', '', 0, '3.4.3.1', '', 'http://update.joomla.org/language/details3/ro-RO_details.xml', '', ''),
(4, 3, 0, 'Flemish', '', 'pkg_nl-BE', 'package', '', 0, '3.4.8.2', '', 'http://update.joomla.org/language/details3/nl-BE_details.xml', '', ''),
(5, 3, 0, 'Chinese Traditional', '', 'pkg_zh-TW', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/zh-TW_details.xml', '', ''),
(6, 3, 0, 'French', '', 'pkg_fr-FR', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/fr-FR_details.xml', '', ''),
(7, 3, 0, 'Galician', '', 'pkg_gl-ES', 'package', '', 0, '3.3.1.2', '', 'http://update.joomla.org/language/details3/gl-ES_details.xml', '', ''),
(8, 3, 0, 'German', '', 'pkg_de-DE', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/de-DE_details.xml', '', ''),
(9, 3, 0, 'Greek', '', 'pkg_el-GR', 'package', '', 0, '3.4.2.1', '', 'http://update.joomla.org/language/details3/el-GR_details.xml', '', ''),
(10, 3, 0, 'Japanese', '', 'pkg_ja-JP', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/ja-JP_details.xml', '', ''),
(11, 3, 0, 'Hebrew', '', 'pkg_he-IL', 'package', '', 0, '3.1.1.1', '', 'http://update.joomla.org/language/details3/he-IL_details.xml', '', ''),
(12, 3, 0, 'Hungarian', '', 'pkg_hu-HU', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/hu-HU_details.xml', '', ''),
(13, 3, 0, 'Afrikaans', '', 'pkg_af-ZA', 'package', '', 0, '3.4.5.1', '', 'http://update.joomla.org/language/details3/af-ZA_details.xml', '', ''),
(14, 3, 0, 'Arabic Unitag', '', 'pkg_ar-AA', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/ar-AA_details.xml', '', ''),
(15, 3, 0, 'Belarusian', '', 'pkg_be-BY', 'package', '', 0, '3.2.1.1', '', 'http://update.joomla.org/language/details3/be-BY_details.xml', '', ''),
(16, 3, 0, 'Bulgarian', '', 'pkg_bg-BG', 'package', '', 0, '3.4.4.2', '', 'http://update.joomla.org/language/details3/bg-BG_details.xml', '', ''),
(17, 3, 0, 'Catalan', '', 'pkg_ca-ES', 'package', '', 0, '3.4.4.2', '', 'http://update.joomla.org/language/details3/ca-ES_details.xml', '', ''),
(18, 3, 0, 'Chinese Simplified', '', 'pkg_zh-CN', 'package', '', 0, '3.4.1.1', '', 'http://update.joomla.org/language/details3/zh-CN_details.xml', '', ''),
(19, 3, 0, 'Croatian', '', 'pkg_hr-HR', 'package', '', 0, '3.4.4.2', '', 'http://update.joomla.org/language/details3/hr-HR_details.xml', '', ''),
(20, 3, 0, 'Czech', '', 'pkg_cs-CZ', 'package', '', 0, '3.4.1.1', '', 'http://update.joomla.org/language/details3/cs-CZ_details.xml', '', ''),
(21, 3, 0, 'Danish', '', 'pkg_da-DK', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/da-DK_details.xml', '', ''),
(22, 3, 0, 'Dutch', '', 'pkg_nl-NL', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/nl-NL_details.xml', '', ''),
(23, 3, 0, 'Estonian', '', 'pkg_et-EE', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/et-EE_details.xml', '', ''),
(24, 3, 0, 'English', '', 'pkg_en-AU', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/en-AU_details.xml', '', ''),
(25, 3, 0, 'Italian', '', 'pkg_it-IT', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/it-IT_details.xml', '', ''),
(26, 3, 0, 'Khmer', '', 'pkg_km-KH', 'package', '', 0, '3.4.5.1', '', 'http://update.joomla.org/language/details3/km-KH_details.xml', '', ''),
(27, 3, 0, 'Korean', '', 'pkg_ko-KR', 'package', '', 0, '3.4.4.2', '', 'http://update.joomla.org/language/details3/ko-KR_details.xml', '', ''),
(28, 3, 0, 'Latvian', '', 'pkg_lv-LV', 'package', '', 0, '3.4.3.1', '', 'http://update.joomla.org/language/details3/lv-LV_details.xml', '', ''),
(29, 3, 0, 'Macedonian', '', 'pkg_mk-MK', 'package', '', 0, '3.4.5.1', '', 'http://update.joomla.org/language/details3/mk-MK_details.xml', '', ''),
(30, 3, 0, 'Norwegian Bokmal', '', 'pkg_nb-NO', 'package', '', 0, '3.4.5.1', '', 'http://update.joomla.org/language/details3/nb-NO_details.xml', '', ''),
(31, 3, 0, 'Norwegian Nynorsk', '', 'pkg_nn-NO', 'package', '', 0, '3.4.2.1', '', 'http://update.joomla.org/language/details3/nn-NO_details.xml', '', ''),
(32, 3, 0, 'Persian', '', 'pkg_fa-IR', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/fa-IR_details.xml', '', ''),
(33, 3, 0, 'Polish', '', 'pkg_pl-PL', 'package', '', 0, '3.4.2.1', '', 'http://update.joomla.org/language/details3/pl-PL_details.xml', '', ''),
(34, 3, 0, 'English', '', 'pkg_en-US', 'package', '', 0, '3.4.6.1', '', 'http://update.joomla.org/language/details3/en-US_details.xml', '', ''),
(35, 3, 0, 'Portuguese', '', 'pkg_pt-PT', 'package', '', 0, '3.4.5.1', '', 'http://update.joomla.org/language/details3/pt-PT_details.xml', '', ''),
(36, 3, 0, 'Russian', '', 'pkg_ru-RU', 'package', '', 0, '3.4.1.3', '', 'http://update.joomla.org/language/details3/ru-RU_details.xml', '', ''),
(37, 3, 0, 'Slovak', '', 'pkg_sk-SK', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/sk-SK_details.xml', '', ''),
(38, 3, 0, 'Swedish', '', 'pkg_sv-SE', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/sv-SE_details.xml', '', ''),
(39, 3, 0, 'Syriac', '', 'pkg_sy-IQ', 'package', '', 0, '3.4.5.1', '', 'http://update.joomla.org/language/details3/sy-IQ_details.xml', '', ''),
(40, 3, 0, 'Tamil', '', 'pkg_ta-IN', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/ta-IN_details.xml', '', ''),
(41, 3, 0, 'Thai', '', 'pkg_th-TH', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/th-TH_details.xml', '', ''),
(42, 3, 0, 'Turkish', '', 'pkg_tr-TR', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/tr-TR_details.xml', '', ''),
(43, 3, 0, 'Ukrainian', '', 'pkg_uk-UA', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/uk-UA_details.xml', '', ''),
(44, 3, 0, 'Uyghur', '', 'pkg_ug-CN', 'package', '', 0, '3.3.0.1', '', 'http://update.joomla.org/language/details3/ug-CN_details.xml', '', ''),
(45, 3, 0, 'Albanian', '', 'pkg_sq-AL', 'package', '', 0, '3.1.1.1', '', 'http://update.joomla.org/language/details3/sq-AL_details.xml', '', ''),
(46, 3, 0, 'Hindi', '', 'pkg_hi-IN', 'package', '', 0, '3.3.6.1', '', 'http://update.joomla.org/language/details3/hi-IN_details.xml', '', ''),
(47, 3, 0, 'Portuguese Brazil', '', 'pkg_pt-BR', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/pt-BR_details.xml', '', ''),
(48, 3, 0, 'Serbian Latin', '', 'pkg_sr-YU', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/sr-YU_details.xml', '', ''),
(49, 3, 0, 'Spanish', '', 'pkg_es-ES', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/es-ES_details.xml', '', ''),
(50, 3, 0, 'Bosnian', '', 'pkg_bs-BA', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/bs-BA_details.xml', '', ''),
(51, 3, 0, 'Serbian Cyrillic', '', 'pkg_sr-RS', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/sr-RS_details.xml', '', ''),
(52, 3, 0, 'Vietnamese', '', 'pkg_vi-VN', 'package', '', 0, '3.2.1.1', '', 'http://update.joomla.org/language/details3/vi-VN_details.xml', '', ''),
(53, 3, 0, 'Bahasa Indonesia', '', 'pkg_id-ID', 'package', '', 0, '3.3.0.2', '', 'http://update.joomla.org/language/details3/id-ID_details.xml', '', ''),
(54, 3, 0, 'Finnish', '', 'pkg_fi-FI', 'package', '', 0, '3.4.2.1', '', 'http://update.joomla.org/language/details3/fi-FI_details.xml', '', ''),
(55, 3, 0, 'Swahili', '', 'pkg_sw-KE', 'package', '', 0, '3.4.8.1', '', 'http://update.joomla.org/language/details3/sw-KE_details.xml', '', ''),
(56, 3, 0, 'Montenegrin', '', 'pkg_srp-ME', 'package', '', 0, '3.3.1.1', '', 'http://update.joomla.org/language/details3/srp-ME_details.xml', '', ''),
(57, 3, 0, 'FrenchCA', '', 'pkg_fr-CA', 'package', '', 0, '3.4.4.3', '', 'http://update.joomla.org/language/details3/fr-CA_details.xml', '', ''),
(58, 3, 0, 'English', '', 'pkg_en-CA', 'package', '', 0, '3.4.6.1', '', 'http://update.joomla.org/language/details3/en-CA_details.xml', '', ''),
(59, 3, 0, 'Welsh', '', 'pkg_cy-GB', 'package', '', 0, '3.3.0.2', '', 'http://update.joomla.org/language/details3/cy-GB_details.xml', '', ''),
(60, 3, 0, 'Sinhala', '', 'pkg_si-LK', 'package', '', 0, '3.3.1.1', '', 'http://update.joomla.org/language/details3/si-LK_details.xml', '', ''),
(61, 3, 0, 'Dari Persian', '', 'pkg_prs-AF', 'package', '', 0, '3.4.4.1', '', 'http://update.joomla.org/language/details3/prs-AF_details.xml', '', ''),
(62, 3, 0, 'Turkmen', '', 'pkg_tk-TM', 'package', '', 0, '3.4.5.1', '', 'http://update.joomla.org/language/details3/tk-TM_details.xml', '', ''),
(63, 3, 0, 'Irish', '', 'pkg_ga-IE', 'package', '', 0, '3.4.5.2', '', 'http://update.joomla.org/language/details3/ga-IE_details.xml', '', ''),
(64, 3, 0, 'Dzongkha', '', 'pkg_dz-BT', 'package', '', 0, '3.4.5.1', '', 'http://update.joomla.org/language/details3/dz-BT_details.xml', '', ''),
(65, 6, 10004, 'Sourcerer', '', 'sourcerer', 'plugin', 'system', 0, '5.2.2', '', 'http://download.nonumber.nl/updates.xml?e=sourcerer&type=.xml', 'http://www.nonumber.nl/extensions/sourcerer#download', ''),
(66, 7, 0, '', '', '', 'module', '', 0, '', '', 'http://update.joomlart.com/service/tracking/j16/.xml', '', ''),
(67, 7, 0, 'JA Amazon S3 for joomla 16', '', 'com_com_jaamazons3', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/com_com_jaamazons3.xml', '', ''),
(68, 7, 0, 'JA Extenstion Manager Component j16', '', 'com_com_jaextmanager', 'file', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/com_com_jaextmanager.xml', '', ''),
(69, 7, 0, 'JA Amazon S3 for joomla 2.5 & 3.x', '', 'com_jaamazons3', 'component', '', 1, '2.5.7', '', 'http://update.joomlart.com/service/tracking/j16/com_jaamazons3.xml', '', ''),
(70, 7, 0, 'JA Comment Package for Joomla 2.5 & 3.3', '', 'com_jacomment', 'component', '', 1, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j16/com_jacomment.xml', '', ''),
(71, 7, 0, 'JA Google Storage Package for J2.5 & J3.0', '', 'com_jagooglestorage', 'component', '', 1, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/com_jagooglestorage.xml', '', ''),
(72, 7, 0, 'JA Job Board Package For J25', '', 'com_jajobboard', 'component', '', 1, '1.0.6', '', 'http://update.joomlart.com/service/tracking/j16/com_jajobboard.xml', '', ''),
(73, 7, 0, 'JA K2 Filter Package for J25 & J3.4', '', 'com_jak2filter', 'component', '', 1, '1.2.2', '', 'http://update.joomlart.com/service/tracking/j16/com_jak2filter.xml', '', ''),
(74, 7, 0, 'JA K2 Filter Package for J25 & J30', '', 'com_jak2fiter', 'component', '', 1, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/com_jak2fiter.xml', '', ''),
(75, 7, 0, 'JA Showcase component for Joomla 1.7', '', 'com_jashowcase', 'component', '', 1, '1.1.0', '', 'http://update.joomlart.com/service/tracking/j16/com_jashowcase.xml', '', ''),
(76, 7, 0, 'JA Voice Package for Joomla 2.5 & 3.x', '', 'com_javoice', 'component', '', 1, '1.1.0', '', 'http://update.joomlart.com/service/tracking/j16/com_javoice.xml', '', ''),
(77, 7, 0, 'JA Appolio Theme for EasyBlog', '', 'easyblog_theme_appolio', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_appolio.xml', '', ''),
(78, 7, 0, 'JA Biz Theme for EasyBlog', '', 'easyblog_theme_biz', 'custom', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_biz.xml', '', ''),
(79, 7, 0, 'JA Bookshop Theme for EasyBlog', '', 'easyblog_theme_bookshop', 'custom', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_bookshop.xml', '', ''),
(80, 7, 0, 'Theme Community Plus for Easyblog J25 & J30', '', 'easyblog_theme_community_plus', 'custom', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_community_plus.xml', '', ''),
(81, 7, 0, 'JA Decor Theme for EasyBlog', '', 'easyblog_theme_decor', 'custom', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_decor.xml', '', ''),
(82, 7, 0, 'Theme Fixel for Easyblog J25 & J34', '', 'easyblog_theme_fixel', 'custom', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_fixel.xml', '', ''),
(83, 7, 0, 'Theme Magz for Easyblog J25 & J34', '', 'easyblog_theme_magz', 'custom', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_magz.xml', '', ''),
(84, 7, 0, 'JA Muzic Theme for EasyBlog', '', 'easyblog_theme_muzic', 'custom', '', 0, '1.1.0', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_muzic.xml', '', ''),
(85, 7, 0, 'JA Obelisk Theme for EasyBlog', '', 'easyblog_theme_obelisk', 'custom', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_obelisk.xml', '', ''),
(86, 7, 0, 'JA Sugite Theme for EasyBlog', '', 'easyblog_theme_sugite', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/easyblog_theme_sugite.xml', '', ''),
(87, 7, 0, 'JA Anion template for Joomla 3.x', '', 'ja_anion', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_anion.xml', '', ''),
(88, 7, 0, 'JA Appolio Template', '', 'ja_appolio', 'template', '', 0, '1.1.3', '', 'http://update.joomlart.com/service/tracking/j16/ja_appolio.xml', '', ''),
(89, 7, 0, 'JA Argo Template for J3x', '', 'ja_argo', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_argo.xml', '', ''),
(90, 7, 0, 'JA Beranis Template', '', 'ja_beranis', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_beranis.xml', '', ''),
(91, 7, 0, 'JA Bistro Template for Joomla 3.x', '', 'ja_bistro', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_bistro.xml', '', ''),
(92, 7, 0, 'JA Blazes Template for J25 & J3x', '', 'ja_blazes', 'template', '', 0, '2.5.6', '', 'http://update.joomlart.com/service/tracking/j16/ja_blazes.xml', '', ''),
(93, 7, 0, 'JA Bookshop Template', '', 'ja_bookshop', 'template', '', 0, '1.1.4', '', 'http://update.joomlart.com/service/tracking/j16/ja_bookshop.xml', '', ''),
(94, 7, 0, 'JA Brisk Template for J25 & J3x', '', 'ja_brisk', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_brisk.xml', '', ''),
(95, 7, 0, 'JA Business Template for Joomla 3.x', '', 'ja_business', 'template', '', 0, '2.5.6', '', 'http://update.joomlart.com/service/tracking/j16/ja_business.xml', '', ''),
(96, 7, 0, 'JA Cloris Template for Joomla 3.x', '', 'ja_cloris', 'template', '', 0, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j16/ja_cloris.xml', '', ''),
(97, 7, 0, 'JA Community PLus Template for Joomla 3.x', '', 'ja_community_plus', 'template', '', 0, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j16/ja_community_plus.xml', '', ''),
(98, 7, 0, 'JA Decor Template', '', 'ja_decor', 'template', '', 0, '1.1.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_decor.xml', '', ''),
(99, 7, 0, 'JA Droid Template for Joomla 3.x', '', 'ja_droid', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_droid.xml', '', ''),
(100, 7, 0, 'JA Edenite Template for J25 & J34', '', 'ja_edenite', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_edenite.xml', '', ''),
(101, 7, 0, 'JA Elastica Template for J25 & J3x', '', 'ja_elastica', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_elastica.xml', '', ''),
(102, 7, 0, 'JA Erio Template for Joomla 2.5 & 3.x', '', 'ja_erio', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_erio.xml', '', ''),
(103, 7, 0, 'Ja Events Template for Joomla 2.5', '', 'ja_events', 'template', '', 0, '2.5.6', '', 'http://update.joomlart.com/service/tracking/j16/ja_events.xml', '', ''),
(104, 7, 0, 'JA Fubix Template for J25 & J3x', '', 'ja_fubix', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_fubix.xml', '', ''),
(105, 7, 0, 'JA Graphite Template for Joomla 3x', '', 'ja_graphite', 'template', '', 0, '2.5.7', '', 'http://update.joomlart.com/service/tracking/j16/ja_graphite.xml', '', ''),
(106, 7, 0, 'JA Hawkstore Template', '', 'ja_hawkstore', 'template', '', 0, '1.1.1', '', 'http://update.joomlart.com/service/tracking/j16/ja_hawkstore.xml', '', ''),
(107, 7, 0, 'JA Ironis Template for Joomla 2.5 & 3.x', '', 'ja_ironis', 'template', '', 0, '2.5.6', '', 'http://update.joomlart.com/service/tracking/j16/ja_ironis.xml', '', ''),
(108, 7, 0, 'JA Jason template', '', 'ja_jason', 'template', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/ja_jason.xml', '', ''),
(109, 7, 0, 'JA Kranos Template for J2.5 & J3.x', '', 'ja_kranos', 'template', '', 0, '2.5.7', '', 'http://update.joomlart.com/service/tracking/j16/ja_kranos.xml', '', ''),
(110, 7, 0, 'JA Lens Template for Joomla 2.5 & 3.x', '', 'ja_lens', 'template', '', 0, '1.0.7', '', 'http://update.joomlart.com/service/tracking/j16/ja_lens.xml', '', ''),
(111, 7, 0, 'Ja Lime Template for Joomla 3x', '', 'ja_lime', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_lime.xml', '', ''),
(112, 7, 0, 'JA Magz Template for J25 & J34', '', 'ja_magz', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_magz.xml', '', ''),
(113, 7, 0, 'JA Medicare Template', '', 'ja_medicare', 'template', '', 0, '1.1.4', '', 'http://update.joomlart.com/service/tracking/j16/ja_medicare.xml', '', ''),
(114, 7, 0, 'JA Mendozite Template for J25 & J32', '', 'ja_mendozite', 'template', '', 0, '1.0.8', '', 'http://update.joomlart.com/service/tracking/j16/ja_mendozite.xml', '', ''),
(115, 7, 0, 'JA Mero Template for J25 & J3x', '', 'ja_mero', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_mero.xml', '', ''),
(116, 7, 0, 'JA Mers Template for J25 & J3x', '', 'ja_mers', 'template', '', 0, '1.0.8', '', 'http://update.joomlart.com/service/tracking/j16/ja_mers.xml', '', ''),
(117, 7, 0, 'JA Methys Template for Joomla 3x', '', 'ja_methys', 'template', '', 0, '2.5.7', '', 'http://update.joomlart.com/service/tracking/j16/ja_methys.xml', '', ''),
(118, 7, 0, 'Ja Minisite Template for Joomla 3.4', '', 'ja_minisite', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_minisite.xml', '', ''),
(119, 7, 0, 'JA Mitius Template', '', 'ja_mitius', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_mitius.xml', '', ''),
(120, 7, 0, 'JA Mixmaz Template', '', 'ja_mixmaz', 'template', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/ja_mixmaz.xml', '', ''),
(121, 7, 0, 'JA Nex Template for J25 & J30', '', 'ja_nex', 'template', '', 0, '2.5.9', '', 'http://update.joomlart.com/service/tracking/j16/ja_nex.xml', '', ''),
(122, 7, 0, 'JA Nex T3 Template', '', 'ja_nex_t3', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_nex_t3.xml', '', ''),
(123, 7, 0, 'JA Norite Template for J2.5 & J31', '', 'ja_norite', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_norite.xml', '', ''),
(124, 7, 0, 'JA Nuevo template', '', 'ja_nuevo', 'template', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_nuevo.xml', '', ''),
(125, 7, 0, 'JA Obelisk Template', '', 'ja_obelisk', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_obelisk.xml', '', ''),
(126, 7, 0, 'JA Onepage Template', '', 'ja_onepage', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_onepage.xml', '', ''),
(127, 7, 0, 'JA ores template for Joomla 3.x', '', 'ja_ores', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_ores.xml', '', ''),
(128, 7, 0, 'JA Orisite Template  for J25 & J3x', '', 'ja_orisite', 'template', '', 0, '1.1.7', '', 'http://update.joomlart.com/service/tracking/j16/ja_orisite.xml', '', ''),
(129, 7, 0, 'JA Playmag Template', '', 'ja_playmag', 'template', '', 0, '1.1.3', '', 'http://update.joomlart.com/service/tracking/j16/ja_playmag.xml', '', ''),
(130, 7, 0, 'JA Portfolio Real Estate template for Joomla 1.6.x', '', 'ja_portfolio', 'file', '', 0, '1.0.0 beta', '', 'http://update.joomlart.com/service/tracking/j16/ja_portfolio.xml', '', ''),
(131, 7, 0, 'JA Portfolio Template for Joomla 3.x', '', 'ja_portfolio_real_estate', 'template', '', 0, '2.5.6', '', 'http://update.joomlart.com/service/tracking/j16/ja_portfolio_real_estate.xml', '', ''),
(132, 7, 0, 'JA Puresite Template for J25 & J3x', '', 'ja_puresite', 'template', '', 0, '1.0.8', '', 'http://update.joomlart.com/service/tracking/j16/ja_puresite.xml', '', ''),
(133, 7, 0, 'JA Purity II template for Joomla 2.5 & 3.2', '', 'ja_purity_ii', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_purity_ii.xml', '', ''),
(134, 7, 0, 'JA Pyro Template for Joomla 3.x', '', 'ja_pyro', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_pyro.xml', '', ''),
(135, 7, 0, 'JA Rasite Template for J34', '', 'ja_rasite', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_rasite.xml', '', ''),
(136, 7, 0, 'JA Rave Template for Joomla 3.x', '', 'ja_rave', 'template', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/ja_rave.xml', '', ''),
(137, 7, 0, 'JA Smashboard Template', '', 'ja_smashboard', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_smashboard.xml', '', ''),
(138, 7, 0, 'JA Social Template for Joomla 2.5', '', 'ja_social', 'template', '', 0, '2.5.8', '', 'http://update.joomlart.com/service/tracking/j16/ja_social.xml', '', ''),
(139, 7, 0, 'JA Social T3 Template for J25 & J3x', '', 'ja_social_t3', 'template', '', 0, '1.1.3', '', 'http://update.joomlart.com/service/tracking/j16/ja_social_t3.xml', '', ''),
(140, 7, 0, 'JA Sugite Template', '', 'ja_sugite', 'template', '', 0, '1.1.4', '', 'http://update.joomlart.com/service/tracking/j16/ja_sugite.xml', '', ''),
(141, 7, 0, 'JA System Pager Plugin for J25 & J30', '', 'ja_system_japager', 'plugin', 'ja_system_japager', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/ja_system_japager.xml', '', ''),
(142, 7, 0, 'JA T3V2 Blank Template', '', 'ja_t3_blank', 'template', '', 0, '2.5.8', '', 'http://update.joomlart.com/service/tracking/j16/ja_t3_blank.xml', '', ''),
(143, 7, 0, 'JA T3 Blank template for joomla 1.6', '', 'ja_t3_blank_j16', 'template', '', 0, '1.0.0 Beta', '', 'http://update.joomlart.com/service/tracking/j16/ja_t3_blank_j16.xml', '', ''),
(144, 7, 0, 'JA Blank Template for T3v3', '', 'ja_t3v3_blank', 'template', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/ja_t3v3_blank.xml', '', ''),
(145, 7, 0, 'JA Teline III  Template for Joomla 1.6', '', 'ja_teline_iii', 'file', '', 0, '1.0.0 Beta', '', 'http://update.joomlart.com/service/tracking/j16/ja_teline_iii.xml', '', ''),
(146, 7, 0, 'JA Teline IV Template for J2.5 and J3.2', '', 'ja_teline_iv', 'template', '', 0, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j16/ja_teline_iv.xml', '', ''),
(147, 7, 0, 'JA Teline IV T3 Template', '', 'ja_teline_iv_t3', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/ja_teline_iv_t3.xml', '', ''),
(148, 7, 0, 'JA Tiris Template for J25 & J3x', '', 'ja_tiris', 'template', '', 0, '2.5.9', '', 'http://update.joomlart.com/service/tracking/j16/ja_tiris.xml', '', ''),
(149, 7, 0, 'JA Travel Template for Joomla 3x', '', 'ja_travel', 'template', '', 0, '2.5.6', '', 'http://update.joomlart.com/service/tracking/j16/ja_travel.xml', '', ''),
(150, 7, 0, 'JA University Template for J25 & J32', '', 'ja_university', 'template', '', 0, '1.0.6', '', 'http://update.joomlart.com/service/tracking/j16/ja_university.xml', '', ''),
(151, 7, 0, 'JA University T3 template', '', 'ja_university_t3', 'template', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/ja_university_t3.xml', '', ''),
(152, 7, 0, 'JA Vintas Template for J25 & J31', '', 'ja_vintas', 'template', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/ja_vintas.xml', '', ''),
(153, 7, 0, 'JA Wall Template for J25 & J34', '', 'ja_wall', 'template', '', 0, '1.2.1', '', 'http://update.joomlart.com/service/tracking/j16/ja_wall.xml', '', ''),
(154, 7, 0, 'JA ZiteTemplate', '', 'ja_zite', 'template', '', 0, '1.0.6', '', 'http://update.joomlart.com/service/tracking/j16/ja_zite.xml', '', ''),
(155, 7, 0, 'JA Bookmark plugin for Joomla 1.6.x', '', 'jabookmark', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jabookmark.xml', '', ''),
(156, 7, 0, 'JA Comment plugin for Joomla 1.6.x', '', 'jacomment', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jacomment.xml', '', ''),
(157, 7, 0, 'JA Comment Off Plugin for Joomla 1.6', '', 'jacommentoff', 'file', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/jacommentoff.xml', '', ''),
(158, 7, 0, 'JA Comment On Plugin for Joomla 1.6', '', 'jacommenton', 'file', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/jacommenton.xml', '', ''),
(159, 7, 0, 'JA Content Extra Fields for Joomla 1.6', '', 'jacontentextrafields', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jacontentextrafields.xml', '', ''),
(160, 7, 0, 'JA Disqus Debate Echo plugin for Joomla 1.6.x', '', 'jadisqus_debate_echo', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jadisqus_debate_echo.xml', '', ''),
(161, 7, 0, 'JA System Google Map plugin for Joomla 1.6.x', '', 'jagooglemap', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jagooglemap.xml', '', ''),
(162, 7, 0, 'JA Google Translate plugin for Joomla 1.6.x', '', 'jagoogletranslate', 'plugin', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jagoogletranslate.xml', '', ''),
(163, 7, 0, 'JA Highslide plugin for Joomla 1.6.x', '', 'jahighslide', 'plugin', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jahighslide.xml', '', ''),
(164, 7, 0, 'JA K2 Search Plugin for Joomla 2.5', '', 'jak2_filter', 'plugin', '', 0, '1.0.0 Alpha', '', 'http://update.joomlart.com/service/tracking/j16/jak2_filter.xml', '', ''),
(165, 7, 0, 'JA K2 Extra Fields Plugin for Joomla 2.5', '', 'jak2_indexing', 'plugin', '', 0, '1.0.0 Alpha', '', 'http://update.joomlart.com/service/tracking/j16/jak2_indexing.xml', '', ''),
(166, 7, 0, 'JA Load module Plugin for Joomla 2.5', '', 'jaloadmodule', 'plugin', 'jaloadmodule', 0, '2.5.1', '', 'http://update.joomlart.com/service/tracking/j16/jaloadmodule.xml', '', ''),
(167, 7, 0, 'JA System Nrain plugin for Joomla 1.6.x', '', 'janrain', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/janrain.xml', '', ''),
(168, 7, 0, 'JA Popup plugin for Joomla 1.6', '', 'japopup', 'file', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/japopup.xml', '', ''),
(169, 7, 0, 'JA System Social plugin for Joomla 1.7', '', 'jasocial', 'file', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/jasocial.xml', '', ''),
(170, 7, 0, 'JA T3 System plugin for Joomla 1.6', '', 'jat3', 'plugin', '', 0, '1.0.0 Beta', '', 'http://update.joomlart.com/service/tracking/j16/jat3.xml', '', ''),
(171, 7, 0, 'JA Tabs plugin for Joomla 1.6.x', '', 'jatabs', 'plugin', 'jatabs', 0, '2.5.6', '', 'http://update.joomlart.com/service/tracking/j16/jatabs.xml', '', ''),
(172, 7, 0, 'JA Typo plugin For Joomla 1.6', '', 'jatypo', 'plugin', 'jatypo', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jatypo.xml', '', ''),
(173, 7, 0, 'Jomsocial Theme 3.x for JA Social', '', 'jomsocial_theme_social', 'custom', '', 0, '4.1.x', '', 'http://update.joomlart.com/service/tracking/j16/jomsocial_theme_social.xml', '', ''),
(174, 7, 0, 'JA Jomsocial theme for Joomla 2.5', '', 'jomsocial_theme_social_j16', 'file', '', 0, '2.5.1', '', 'http://update.joomlart.com/service/tracking/j16/jomsocial_theme_social_j16.xml', '', ''),
(175, 7, 0, 'JA Jomsocial theme for Joomla 2.5', '', 'jomsocial_theme_social_j16_26', 'custom', '', 0, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j16/jomsocial_theme_social_j16_26.xml', '', ''),
(176, 7, 0, 'JShopping Template for Ja Orisite', '', 'jshopping_theme_orisite', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jshopping_theme_orisite.xml', '', ''),
(177, 7, 0, 'JA Tiris Jshopping theme for J25 & J3x', '', 'jshopping_theme_tiris', 'custom', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/jshopping_theme_tiris.xml', '', ''),
(178, 7, 0, 'Theme for Jshopping j17', '', 'jshopping_theme_tiris_j17', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/jshopping_theme_tiris_j17.xml', '', ''),
(179, 7, 0, 'JA Kranos kunena theme for Joomla 3.x', '', 'kunena_theme_kranos_j17', 'custom', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_kranos_j17.xml', '', ''),
(180, 7, 0, 'Kunena Template for JA Mendozite', '', 'kunena_theme_mendozite', 'custom', '', 0, '1.0.6', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_mendozite.xml', '', ''),
(181, 7, 0, 'JA Mitius Kunena Theme for Joomla 25 ', '', 'kunena_theme_mitius', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_mitius.xml', '', ''),
(182, 7, 0, 'Kunena theme for JA Nex J2.5', '', 'kunena_theme_nex_j17', 'custom', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_nex_j17.xml', '', ''),
(183, 7, 0, 'Kunena theme for JA Nex T3', '', 'kunena_theme_nex_t3', 'custom', '', 0, '1.0.6', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_nex_t3.xml', '', ''),
(184, 7, 0, 'Kunena Template for Ja Orisite', '', 'kunena_theme_orisite', 'custom', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_orisite.xml', '', ''),
(185, 7, 0, 'Kunena theme for ja PlayMag', '', 'kunena_theme_playmag', 'custom', '', 0, '1.1.5', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_playmag.xml', '', ''),
(186, 7, 0, 'Kunena theme for JA Social T3', '', 'kunena_theme_social', 'custom', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_social.xml', '', ''),
(187, 7, 0, 'Kunena theme for Joomla 2.5', '', 'kunena_theme_social_j16', 'custom', '', 0, '2.5.1', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_social_j16.xml', '', ''),
(188, 7, 0, 'Kunena theme for ja Techzone', '', 'kunena_theme_techzone', 'custom', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_techzone.xml', '', ''),
(189, 7, 0, 'JA Tiris kunena theme for Joomla 2.5', '', 'kunena_theme_tiris_j16', 'custom', '', 0, '2.5.3', '', 'http://update.joomlart.com/service/tracking/j16/kunena_theme_tiris_j16.xml', '', ''),
(190, 7, 0, 'JA Bookshop Theme for Mijoshop V2', '', 'mijoshop_theme_bookshop', 'custom', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/mijoshop_theme_bookshop.xml', '', ''),
(191, 7, 0, 'JA Decor Theme for Mijoshop', '', 'mijoshop_theme_decor', 'custom', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/mijoshop_theme_decor.xml', '', ''),
(192, 7, 0, 'JA Decor Theme for Mijoshop V3', '', 'mijoshop_theme_decor_v3', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/mijoshop_theme_decor_v3.xml', '', ''),
(193, 7, 0, 'JA ACM Module', '', 'mod_ja_acm', 'module', '', 0, '2.0.9', '', 'http://update.joomlart.com/service/tracking/j16/mod_ja_acm.xml', '', ''),
(194, 7, 0, 'JA Jobs Tags module for Joomla 2.5', '', 'mod_ja_jobs_tags', 'module', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/mod_ja_jobs_tags.xml', '', ''),
(195, 7, 0, 'JA Accordion Module for J25 & J34', '', 'mod_jaaccordion', 'module', '', 0, '2.5.9', '', 'http://update.joomlart.com/service/tracking/j16/mod_jaaccordion.xml', '', ''),
(196, 7, 0, 'JA Animation module for Joomla 2.5 & 3.2', '', 'mod_jaanimation', 'module', '', 0, '2.5.3', '', 'http://update.joomlart.com/service/tracking/j16/mod_jaanimation.xml', '', ''),
(197, 7, 0, 'JA Bulletin Module for J3.x', '', 'mod_jabulletin', 'module', '', 0, '2.6.0', '', 'http://update.joomlart.com/service/tracking/j16/mod_jabulletin.xml', '', ''),
(198, 7, 0, 'JA Latest Comment Module for Joomla 2.5 & 3.3', '', 'mod_jaclatest_comments', 'module', '', 0, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j16/mod_jaclatest_comments.xml', '', ''),
(199, 7, 0, 'JA Content Popup Module for J25 & J34', '', 'mod_jacontentpopup', 'module', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j16/mod_jacontentpopup.xml', '', ''),
(200, 7, 0, 'JA Content Scroll module for Joomla 1.6', '', 'mod_jacontentscroll', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/mod_jacontentscroll.xml', '', ''),
(201, 7, 0, 'JA Contenslider module for Joomla 1.6', '', 'mod_jacontentslide', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/mod_jacontentslide.xml', '', ''),
(202, 7, 0, 'JA Content Slider Module for J25 & J34', '', 'mod_jacontentslider', 'module', '', 0, '2.7.2', '', 'http://update.joomlart.com/service/tracking/j16/mod_jacontentslider.xml', '', ''),
(203, 7, 0, 'JA CountDown Module for Joomla 2.5 & 3.4', '', 'mod_jacountdown', 'module', '', 0, '1.0.7', '', 'http://update.joomlart.com/service/tracking/j16/mod_jacountdown.xml', '', ''),
(204, 7, 0, 'JA Facebook Activity Module for J25 & J30', '', 'mod_jafacebookactivity', 'module', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/mod_jafacebookactivity.xml', '', ''),
(205, 7, 0, 'JA Facebook Like Box Module for Joonla 25 & 34', '', 'mod_jafacebooklikebox', 'module', '', 0, '2.6.1', '', 'http://update.joomlart.com/service/tracking/j16/mod_jafacebooklikebox.xml', '', ''),
(206, 7, 0, 'JA Featured Employer module for Joomla 2.5', '', 'mod_jafeatured_employer', 'module', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/mod_jafeatured_employer.xml', '', ''),
(207, 7, 0, 'JA Filter Jobs module for Joomla 2.5', '', 'mod_jafilter_jobs', 'module', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/mod_jafilter_jobs.xml', '', ''),
(208, 7, 0, 'JA flowlist module for Joomla 2.5 & 3.0', '', 'mod_jaflowlist', 'module', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/mod_jaflowlist.xml', '', ''),
(209, 7, 0, 'JAEC Halloween Module for Joomla 2.5 & 3', '', 'mod_jahalloween', 'module', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/mod_jahalloween.xml', '', ''),
(210, 7, 0, 'JA Image Hotspot Module for Joomla 2.5 & 3.4', '', 'mod_jaimagehotspot', 'module', '', 0, '1.0.8', '', 'http://update.joomlart.com/service/tracking/j16/mod_jaimagehotspot.xml', '', ''),
(211, 7, 0, 'JA static module for Joomla 2.5', '', 'mod_jajb_statistic', 'module', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/mod_jajb_statistic.xml', '', ''),
(212, 7, 0, 'JA Jobboard Menu module for Joomla 2.5', '', 'mod_jajobboard_menu', 'module', '', 0, '1.0.5', '', 'http://update.joomlart.com/service/tracking/j16/mod_jajobboard_menu.xml', '', ''),
(213, 7, 0, 'JA Jobs Counter module for Joomla 2.5', '', 'mod_jajobs_counter', 'module', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/mod_jajobs_counter.xml', '', ''),
(214, 7, 0, 'JA Jobs Map module for Joomla 2.5', '', 'mod_jajobs_map', 'module', '', 0, '1.0.5', '', 'http://update.joomlart.com/service/tracking/j16/mod_jajobs_map.xml', '', ''),
(215, 7, 0, 'JA K2 Fillter Module for Joomla 2.5', '', 'mod_jak2_filter', 'module', '', 0, '1.0.0 Alpha', '', 'http://update.joomlart.com/service/tracking/j16/mod_jak2_filter.xml', '', ''),
(216, 7, 0, 'JA K2 Filter Module for J25 & J3.4', '', 'mod_jak2filter', 'module', '', 0, '1.2.2', '', 'http://update.joomlart.com/service/tracking/j16/mod_jak2filter.xml', '', ''),
(217, 7, 0, 'JA K2 Timeline', '', 'mod_jak2timeline', 'module', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j16/mod_jak2timeline.xml', '', ''),
(218, 7, 0, 'JA Latest Resumes module for Joomla 2.5', '', 'mod_jalatest_resumes', 'module', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/mod_jalatest_resumes.xml', '', ''),
(219, 7, 0, 'JA List Employer module for Joomla 2.5', '', 'mod_jalist_employers', 'module', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/mod_jalist_employers.xml', '', ''),
(220, 7, 0, 'JA List Jobs module for Joomla 2.5', '', 'mod_jalist_jobs', 'module', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j16/mod_jalist_jobs.xml', '', ''),
(221, 7, 0, 'JA List Resumes module for Joomla 2.5', '', 'mod_jalist_resumes', 'module', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j16/mod_jalist_resumes.xml', '', ''),
(222, 7, 0, 'JA Login module for J25 & J3x', '', 'mod_jalogin', 'module', '', 0, '2.6.6', '', 'http://update.joomlart.com/service/tracking/j16/mod_jalogin.xml', '', ''),
(223, 7, 0, 'JA Masshead Module for J25 & J34', '', 'mod_jamasshead', 'module', '', 0, '2.6.1', '', 'http://update.joomlart.com/service/tracking/j16/mod_jamasshead.xml', '', ''),
(224, 7, 0, 'JA News Featured Module for J25 & J34', '', 'mod_janews_featured', 'module', '', 0, '2.6.1', '', 'http://update.joomlart.com/service/tracking/j16/mod_janews_featured.xml', '', ''),
(225, 7, 0, 'JA Newsflash module for Joomla 1.6.x', '', 'mod_janewsflash', 'module', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/mod_janewsflash.xml', '', ''),
(226, 7, 0, 'JA Newsmoo module for Joomla 1.6.x', '', 'mod_janewsmoo', 'module', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/mod_janewsmoo.xml', '', ''),
(227, 7, 0, 'JA News Pro Module for J25 & J3x', '', 'mod_janewspro', 'module', '', 0, '2.6.2', '', 'http://update.joomlart.com/service/tracking/j16/mod_janewspro.xml', '', ''),
(228, 7, 0, 'JA Newsticker Module for J3x', '', 'mod_janewsticker', 'module', '', 0, '2.6.2', '', 'http://update.joomlart.com/service/tracking/j16/mod_janewsticker.xml', '', ''),
(229, 7, 0, 'JA Quick Contact Module for J3.x', '', 'mod_jaquickcontact', 'module', '', 0, '2.5.9', '', 'http://update.joomlart.com/service/tracking/j16/mod_jaquickcontact.xml', '', ''),
(230, 7, 0, 'JA Recent Viewed Jobs module for Joomla 2.5', '', 'mod_jarecent_viewed_jobs', 'module', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/mod_jarecent_viewed_jobs.xml', '', ''),
(231, 7, 0, 'JA SideNews Module for J25 & J34', '', 'mod_jasidenews', 'module', '', 0, '2.6.7', '', 'http://update.joomlart.com/service/tracking/j16/mod_jasidenews.xml', '', ''),
(232, 7, 0, 'JA Slideshow Module for Joomla 2.5 & 3.x', '', 'mod_jaslideshow', 'module', '', 0, '2.7.5', '', 'http://update.joomlart.com/service/tracking/j16/mod_jaslideshow.xml', '', ''),
(233, 7, 0, 'JA Slideshow Lite Module for J25 & J3.4', '', 'mod_jaslideshowlite', 'module', '', 0, '1.2.3', '', 'http://update.joomlart.com/service/tracking/j16/mod_jaslideshowlite.xml', '', ''),
(234, 7, 0, 'JA Soccerway Module for J25 & J33', '', 'mod_jasoccerway', 'module', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/mod_jasoccerway.xml', '', ''),
(235, 7, 0, 'JA Social Locker module', '', 'mod_jasocial_locker', 'module', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/mod_jasocial_locker.xml', '', ''),
(236, 7, 0, 'JA Tab module for Joomla 2.5', '', 'mod_jatabs', 'module', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j16/mod_jatabs.xml', '', ''),
(237, 7, 0, 'JA Toppanel Module for Joomla 2.5 & Joomla 3.4', '', 'mod_jatoppanel', 'module', '', 0, '2.5.8', '', 'http://update.joomlart.com/service/tracking/j16/mod_jatoppanel.xml', '', ''),
(238, 7, 0, 'JA Twitter Module for J25 & J3.4', '', 'mod_jatwitter', 'module', '', 0, '2.6.3', '', 'http://update.joomlart.com/service/tracking/j16/mod_jatwitter.xml', '', ''),
(239, 7, 0, 'JA List of Voices Module for J2.5 & J3.x', '', 'mod_javlist_voices', 'module', '', 0, '1.1.0', '', 'http://update.joomlart.com/service/tracking/j16/mod_javlist_voices.xml', '', ''),
(240, 7, 0, 'JA VMProducts Module', '', 'mod_javmproducts', 'module', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/mod_javmproducts.xml', '', ''),
(241, 7, 0, 'JA Voice  Work Flow Module for J2.5 & J3.x', '', 'mod_javwork_flow', 'module', '', 0, '1.1.0', '', 'http://update.joomlart.com/service/tracking/j16/mod_javwork_flow.xml', '', ''),
(242, 7, 0, 'JA Amazon S3 Button Plugin for joomla 2.5 & 3.x', '', 'jaamazons3', 'plugin', 'button', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/plg_button_jaamazons3.xml', '', ''),
(243, 7, 0, 'JA AVTracklist Button plugin for J2.5 & J3.3', '', 'jaavtracklist', 'plugin', 'button', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j16/plg_button_jaavtracklist.xml', '', ''),
(244, 7, 0, 'JA Comment Off Plugin for Joomla 2.5 & 3.3', '', 'jacommentoff', 'plugin', 'button', 0, '2.5.3', '', 'http://update.joomlart.com/service/tracking/j16/plg_button_jacommentoff.xml', '', ''),
(245, 7, 0, 'JA Comment On Plugin for Joomla 2.5 & 3.3', '', 'jacommenton', 'plugin', 'button', 0, '2.5.2', '', 'http://update.joomlart.com/service/tracking/j16/plg_button_jacommenton.xml', '', ''),
(246, 7, 0, 'JA Amazon S3 System plugin for joomla 2.5 & 3.x', '', 'plg_jaamazons3', 'plugin', 'plg_jaamazons3', 0, '2.5.7', '', 'http://update.joomlart.com/service/tracking/j16/plg_jaamazons3.xml', '', ''),
(247, 7, 0, 'JA AVTracklist plugin for J2.5 & J3.x', '', 'plg_jaavtracklist', 'plugin', 'plg_jaavtracklist', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j16/plg_jaavtracklist.xml', '', ''),
(248, 7, 0, 'JA Bookmark plugin for J3.x', '', 'plg_jabookmark', 'plugin', 'plg_jabookmark', 0, '2.6.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_jabookmark.xml', '', ''),
(249, 7, 0, 'JA Comment Plugin for Joomla 2.5 & 3.3', '', 'plg_jacomment', 'plugin', 'plg_jacomment', 0, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j16/plg_jacomment.xml', '', ''),
(250, 7, 0, 'JA Disqus Debate Echo plugin for J3x', '', 'debate_echo', 'plugin', 'jadisqus', 0, '2.6.3', '', 'http://update.joomlart.com/service/tracking/j16/plg_jadisqus_debate_echo.xml', '', ''),
(251, 7, 0, 'JA Google Storage Plugin for j25 & j30', '', 'plg_jagooglestorage', 'plugin', 'plg_jagooglestorage', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_jagooglestorage.xml', '', ''),
(252, 7, 0, 'JA Translate plugin for Joomla 1.6.x', '', 'plg_jagoogletranslate', 'file', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_jagoogletranslate.xml', '', ''),
(253, 7, 0, 'JA Thumbnail Plugin for J25 & J3', '', 'plg_jathumbnail', 'plugin', 'plg_jathumbnail', 0, '2.5.9', '', 'http://update.joomlart.com/service/tracking/j16/plg_jathumbnail.xml', '', ''),
(254, 7, 0, 'JA Tooltips plugin for Joomla 1.6.x', '', 'plg_jatooltips', 'plugin', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_jatooltips.xml', '', ''),
(255, 7, 0, 'JA Typo Button Plugin for J25 & J3x', '', 'plg_jatypobutton', 'plugin', 'plg_jatypobutton', 0, '2.6.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_jatypobutton.xml', '', ''),
(256, 7, 0, 'JA K2 Filter Plg for J25 & J3.4', '', 'jak2filter', 'plugin', 'k2', 0, '1.2.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_k2_jak2filter.xml', '', ''),
(257, 7, 0, 'JA K2 Timeline Plugin', '', 'jak2timeline', 'plugin', 'k2', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_k2_jak2timeline.xml', '', ''),
(258, 7, 0, 'Multi Capcha Engine Plugin for J3.x', '', 'captcha_engine', 'plugin', 'multiple', 0, '2.5.3', '', 'http://update.joomlart.com/service/tracking/j16/plg_multiple_captcha_engine.xml', '', ''),
(259, 7, 0, 'JA JobBoard Payment Plugin Authorize for Joomla 2.5', '', 'plg_payment_jajb_authorize_25', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_payment_jajb_authorize_25.xml', '', ''),
(260, 7, 0, 'JA JobBoard Payment Plugin MoneyBooker for Joomla 2.5', '', 'plg_payment_jajb_moneybooker_25', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_payment_jajb_moneybooker_25.xml', '', ''),
(261, 7, 0, 'JA JobBoard Payment Plugin Paypal for Joomla 2.5', '', 'plg_payment_jajb_paypal_25', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_payment_jajb_paypal_25.xml', '', ''),
(262, 7, 0, 'JA JobBoard Payment Plugin BankWire for Joomla 2.5', '', 'plg_payment_jajb_wirebank_25', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_payment_jajb_wirebank_25.xml', '', ''),
(263, 7, 0, 'JA Search Comment Plugin for Joomla J2.5 & 3.0', '', 'jacomment', 'plugin', 'search', 0, '2.5.2', '', 'http://update.joomlart.com/service/tracking/j16/plg_search_jacomment.xml', '', ''),
(264, 7, 0, 'JA Search Jobs plugin for Joomla 2.5', '', 'jajob', 'plugin', 'search', 0, '1.0.0 stable', '', 'http://update.joomlart.com/service/tracking/j16/plg_search_jajob.xml', '', ''),
(265, 7, 0, 'JA System Comment Plugin for Joomla 2.5 & 3.3', '', 'jacomment', 'plugin', 'system', 0, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jacomment.xml', '', ''),
(266, 7, 0, 'JA Content Extra Fields for Joomla 2.5', '', 'jacontentextrafields', 'plugin', 'system', 0, '2.5.1', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jacontentextrafields.xml', '', ''),
(267, 7, 0, 'JA System Google Map plugin for Joomla 2.5 & J3.4', '', 'jagooglemap', 'plugin', 'system', 0, '2.6.2', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jagooglemap.xml', '', ''),
(268, 7, 0, 'JAEC PLG System Jobboad Jomsocial Synchonization', '', 'jajb_jomsocial', 'plugin', 'system', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jajb_jomsocial.xml', '', ''),
(269, 7, 0, 'JA System Lazyload Plugin for J25 & J3x', '', 'jalazyload', 'plugin', 'system', 0, '1.0.6', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jalazyload.xml', '', ''),
(270, 7, 0, 'JA System Nrain Plugin for Joomla 2.5 & 3.3', '', 'janrain', 'plugin', 'system', 0, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_janrain.xml', '', ''),
(271, 7, 0, 'JA Popup Plugin for Joomla 25 & 34', '', 'japopup', 'plugin', 'system', 0, '2.6.3', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_japopup.xml', '', ''),
(272, 7, 0, 'JA System Social Plugin for Joomla 3.x', '', 'jasocial', 'plugin', 'system', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jasocial.xml', '', ''),
(273, 7, 0, 'JA System Social Feed Plugin for Joomla 2.5 & 3.4', '', 'jasocial_feed', 'plugin', 'system', 0, '1.2.5', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jasocial_feed.xml', '', ''),
(274, 7, 0, 'JA T3v2 System Plugin for J3.x', '', 'jat3', 'plugin', 'system', 0, '2.7.2', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jat3.xml', '', ''),
(275, 7, 0, 'JA T3v3 System Plugin', '', 'jat3v3', 'plugin', 'system', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jat3v3.xml', '', ''),
(276, 7, 0, 'JA Tabs Plugin for J3.x', '', 'jatabs', 'plugin', 'system', 0, '2.6.6', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jatabs.xml', '', ''),
(277, 7, 0, 'JA Typo Plugin for Joomla 2.5 & J34', '', 'jatypo', 'plugin', 'system', 0, '2.5.7', '', 'http://update.joomlart.com/service/tracking/j16/plg_system_jatypo.xml', '', ''),
(278, 7, 0, 'JA Teline III Template for Joomla 2.5', '', 'teline_iii', 'template', '', 0, '2.5.3', '', 'http://update.joomlart.com/service/tracking/j16/teline_iii.xml', '', ''),
(279, 7, 0, 'Thirdparty Extensions Compatibility Bundle', '', 'thirdparty_exts_compatibility', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j16/thirdparty_exts_compatibility.xml', '', ''),
(280, 7, 0, 'T3 Blank Template', '', 't3_blank', 'template', '', 0, '2.2.1', '', 'http://update.joomlart.com/service/tracking/j16/tpl_t3_blank.xml', '', ''),
(281, 7, 0, 'Uber Template', '', 'uber', 'template', '', 0, '2.1.2', '', 'http://update.joomlart.com/service/tracking/j16/uber.xml', '', ''),
(282, 7, 0, 'T3 B3 Blank Template', '', 't3_bs3_blank', 'template', '', 0, '2.2.1', '', 'http://update.joomlart.com/service/tracking/j30/tpl_t3_bs3_blank.xml', '', ''),
(283, 7, 0, 'JA K2 v3 Filter package for J33', '', 'com_jak2v3filter', 'component', '', 1, '3.0.0 preview ', '', 'http://update.joomlart.com/service/tracking/j31/com_jak2v3filter.xml', '', ''),
(284, 7, 0, 'JA Multilingual Component for J25 & J31', '', 'com_jalang', 'component', '', 1, '1.0.7', '', 'http://update.joomlart.com/service/tracking/j31/com_jalang.xml', '', ''),
(285, 7, 0, 'JA Sugite Theme for EasyBlog', '', 'easyblog_theme_sugite', 'custom', '', 0, '1.1.1', '', 'http://update.joomlart.com/service/tracking/j31/easyblog_theme_sugite.xml', '', ''),
(286, 7, 0, 'JA Biz Template', '', 'ja_biz', 'template', '', 0, '1.1.4', '', 'http://update.joomlart.com/service/tracking/j31/ja_biz.xml', '', ''),
(287, 7, 0, 'JA Cago template', '', 'ja_cago', 'template', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/ja_cago.xml', '', ''),
(288, 7, 0, 'JA Cagox template', '', 'ja_cagox', 'template', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j31/ja_cagox.xml', '', '');
INSERT INTO `joomla_updates` (`update_id`, `update_site_id`, `extension_id`, `name`, `description`, `element`, `type`, `folder`, `client_id`, `version`, `data`, `detailsurl`, `infourl`, `extra_query`) VALUES
(289, 7, 0, 'JA Charity template', '', 'ja_charity', 'template', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j31/ja_charity.xml', '', ''),
(290, 7, 0, 'JA Directory Template', '', 'ja_directory', 'template', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/ja_directory.xml', '', ''),
(291, 7, 0, 'JA Events II template', '', 'ja_events_ii', 'template', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/ja_events_ii.xml', '', ''),
(292, 7, 0, 'JA Fixel Template', '', 'ja_fixel', 'template', '', 0, '1.1.4', '', 'http://update.joomlart.com/service/tracking/j31/ja_fixel.xml', '', ''),
(293, 7, 0, 'JA Hotel Template', '', 'ja_hotel', 'template', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j31/ja_hotel.xml', '', ''),
(294, 7, 0, 'JA Magz II Template', '', 'ja_magz_ii', 'template', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/ja_magz_ii.xml', '', ''),
(295, 7, 0, 'JA Mono Template', '', 'ja_mono', 'template', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/ja_mono.xml', '', ''),
(296, 7, 0, 'JA Muzic Template', '', 'ja_muzic', 'template', '', 0, '1.1.2', '', 'http://update.joomlart.com/service/tracking/j31/ja_muzic.xml', '', ''),
(297, 7, 0, 'JA Platon Template', '', 'ja_platon', 'template', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/ja_platon.xml', '', ''),
(298, 7, 0, 'JA Playstore Template', '', 'ja_playstore', 'template', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/ja_playstore.xml', '', ''),
(299, 7, 0, 'JA Rent template', '', 'ja_rent', 'template', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/ja_rent.xml', '', ''),
(300, 7, 0, 'JA Social II template', '', 'ja_social_ii', 'template', '', 0, '1.0.3', '', 'http://update.joomlart.com/service/tracking/j31/ja_social_ii.xml', '', ''),
(301, 7, 0, 'JA Techzone Template', '', 'ja_techzone', 'template', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/ja_techzone.xml', '', ''),
(302, 7, 0, 'JA Teline V Template', '', 'ja_teline_v', 'template', '', 0, '1.0.6', '', 'http://update.joomlart.com/service/tracking/j31/ja_teline_v.xml', '', ''),
(303, 7, 0, 'JA University T3 template', '', 'ja_university_t3', 'template', '', 0, '1.1.3', '', 'http://update.joomlart.com/service/tracking/j31/ja_university_t3.xml', '', ''),
(304, 7, 0, 'JA Vintas Template for J25 & J3x', '', 'ja_vintas', 'template', '', 0, '1.0.5', '', 'http://update.joomlart.com/service/tracking/j31/ja_vintas.xml', '', ''),
(305, 7, 0, 'Jomsocial theme for Platon', '', 'jomsocial_theme_platon', 'custom', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/jomsocial_theme_platon.xml', '', ''),
(306, 7, 0, 'Theme Fixel for JShopping J25 & J30', '', 'jshopping_theme_fixel', 'custom', '', 0, '1.0.5', '', 'http://update.joomlart.com/service/tracking/j31/jshopping_theme_fixel.xml', '', ''),
(307, 7, 0, 'JA Tiris Jshopping theme for J3x', '', 'jshopping_theme_tiris_j3x', 'custom', '', 0, '2.5.6', '', 'http://update.joomlart.com/service/tracking/j31/jshopping_theme_tiris_j3x.xml', '', ''),
(308, 7, 0, 'JA Mitius Kunena Theme for Joomla 3x', '', 'kunena_theme_mitius', 'custom', '', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j31/kunena_theme_mitius.xml', '', ''),
(309, 7, 0, 'JA Tiris Kunena Theme for Joomla 3x', '', 'kunena_theme_mitius_j31', 'custom', '', 0, '2.5.4', '', 'http://update.joomlart.com/service/tracking/j31/kunena_theme_mitius_j31.xml', '', ''),
(310, 7, 0, 'Kunena Theme Platon', '', 'kunena_theme_platon', 'custom', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/kunena_theme_platon.xml', '', ''),
(311, 7, 0, 'Kunena Theme Playstore', '', 'kunena_theme_playstore', 'custom', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/kunena_theme_playstore.xml', '', ''),
(312, 7, 0, 'JA Tiris Kunena Theme for Joomla 3x', '', 'kunena_theme_tiris_j3x', 'custom', '', 0, '2.5.5', '', 'http://update.joomlart.com/service/tracking/j31/kunena_theme_tiris_j3x.xml', '', ''),
(313, 7, 0, 'Mijoshop Modules Accordion', '', 'mijoshop_mod_accordion', 'custom', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j31/mijoshop_mod_accordion.xml', '', ''),
(314, 7, 0, 'Mijoshop V3 Modules Accordion', '', 'mijoshop_mod_accordion_v3', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/mijoshop_mod_accordion_v3.xml', '', ''),
(315, 7, 0, 'Mijoshop Modules Slider', '', 'mijoshop_mod_slider', 'custom', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j31/mijoshop_mod_slider.xml', '', ''),
(316, 7, 0, 'Mijoshop V3 Modules Slider', '', 'mijoshop_mod_slider_v3', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/mijoshop_mod_slider_v3.xml', '', ''),
(317, 7, 0, 'JA Bookshop Theme for Mijoshop V3', '', 'mijoshop_theme_bookshop_v3', 'custom', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/mijoshop_theme_bookshop_v3.xml', '', ''),
(318, 7, 0, 'JA Google Chart Module', '', 'mod_jagooglechart', 'module', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/mod_jagooglechart.xml', '', ''),
(319, 7, 0, 'JA Halloween Game for Joomla 3.x', '', 'mod_jahalloweengame', 'module', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/mod_jahalloweengame.xml', '', ''),
(320, 7, 0, 'JA K2 v3 Filter Module for J33', '', 'mod_jak2v3filter', 'module', '', 0, '3.0.0 preview ', '', 'http://update.joomlart.com/service/tracking/j31/mod_jak2v3filter.xml', '', ''),
(321, 7, 0, 'JA Masthead Module ', '', 'mod_jamasthead', 'module', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/mod_jamasthead.xml', '', ''),
(322, 7, 0, 'JA Promo Bar module', '', 'mod_japromobar', 'module', '', 0, '1.0.2', '', 'http://update.joomlart.com/service/tracking/j31/mod_japromobar.xml', '', ''),
(323, 7, 0, 'Ja Yahoo Finance', '', 'mod_jayahoo_finance', 'module', '', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/mod_jayahoo_finance.xml', '', ''),
(324, 7, 0, 'Ja Yahoo Weather', '', 'mod_jayahoo_weather', 'module', '', 0, '1.0.1', '', 'http://update.joomlart.com/service/tracking/j31/mod_jayahoo_weather.xml', '', ''),
(325, 7, 0, 'Plugin Ajax JA Content Type', '', 'jacontenttype', 'plugin', 'ajax', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/plg_ajax_jacontenttype.xml', '', ''),
(326, 7, 0, 'JA K2 Data Migration plugin', '', 'plg_jak2tocomcontentmigration', 'plugin', 'plg_jak2tocomcontent', 0, '1.0.0 beta', '', 'http://update.joomlart.com/service/tracking/j31/plg_jak2tocomcontentmigration.xml', '', ''),
(327, 7, 0, 'Plgin JA K2 import to Joomla Content', '', 'plg_jak2tocontent', 'plugin', 'plg_jak2tocontent', 0, '1.0.0 beta', '', 'http://update.joomlart.com/service/tracking/j31/plg_jak2tocontent.xml', '', ''),
(328, 7, 0, 'JA K2 Extrafields', '', 'jak2extrafields', 'plugin', 'k2', 0, '1.0.0', '', 'http://update.joomlart.com/service/tracking/j31/plg_k2_jak2extrafields.xml', '', ''),
(329, 7, 0, 'JA K2 v3 Filter Plugin for J33', '', 'jak2v3filter', 'plugin', 'k2', 0, '3.0.0 preview ', '', 'http://update.joomlart.com/service/tracking/j31/plg_k2_jak2v3filter.xml', '', ''),
(330, 7, 0, 'Plugin JA Content Type', '', 'jacontenttype', 'plugin', 'system', 0, '1.0.4', '', 'http://update.joomlart.com/service/tracking/j31/plg_system_jacontenttype.xml', '', ''),
(331, 7, 0, 'Sample package for Uber App', '', 'uber_app', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_app.xml', '', ''),
(332, 7, 0, 'Sample package for Bookstore', '', 'uber_bookstore', 'sample_package', '', 0, '2.1.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_bookstore.xml', '', ''),
(333, 7, 0, 'Sample package for Uber Business', '', 'uber_business', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_business.xml', '', ''),
(334, 7, 0, 'Sample package for Uber Charity', '', 'uber_charity', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_charity.xml', '', ''),
(335, 7, 0, 'Sample package for Uber Church', '', 'uber_church', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_church.xml', '', ''),
(336, 7, 0, 'Sample package for Uber Construction', '', 'uber_construction', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_construction.xml', '', ''),
(337, 7, 0, 'Sample package for Uber Corporate', '', 'uber_corporate', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_corporate.xml', '', ''),
(338, 7, 0, 'Sample package for Uber Gym', '', 'uber_gym', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_gym.xml', '', ''),
(339, 7, 0, 'Sample package for Uber Home', '', 'uber_home', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_home.xml', '', ''),
(340, 7, 0, 'Sample package for Landing page', '', 'uber_landing', 'sample_package', '', 0, '2.1.0', '', 'http://update.joomlart.com/service/tracking/j31/uber_landing.xml', '', ''),
(341, 7, 0, 'Sample package for Uber Lawyer', '', 'uber_lawyer', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_lawyer.xml', '', ''),
(342, 7, 0, 'Sample package for Uber Medicare', '', 'uber_medicare', 'sample_package', '', 0, '2.1.0', '', 'http://update.joomlart.com/service/tracking/j31/uber_medicare.xml', '', ''),
(343, 7, 0, 'Sample package for Uber Music', '', 'uber_music', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_music.xml', '', ''),
(344, 7, 0, 'Sample package for Uber Restaurant', '', 'uber_restaurant', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_restaurant.xml', '', ''),
(345, 7, 0, 'Sample package for Uber Spa', '', 'uber_spa', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_spa.xml', '', ''),
(346, 7, 0, 'Sample package for Uber University', '', 'uber_university', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_university.xml', '', ''),
(347, 7, 0, 'Sample package for Uber Wedding', '', 'uber_wedding', 'sample_package', '', 0, '2.0.2', '', 'http://update.joomlart.com/service/tracking/j31/uber_wedding.xml', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_update_sites`
--

CREATE TABLE IF NOT EXISTS `joomla_update_sites` (
  `update_site_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `type` varchar(20) DEFAULT '',
  `location` text NOT NULL,
  `enabled` int(11) DEFAULT '0',
  `last_check_timestamp` bigint(20) DEFAULT '0',
  `extra_query` varchar(1000) DEFAULT '',
  PRIMARY KEY (`update_site_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Update Sites' AUTO_INCREMENT=11 ;

--
-- Dumping data for table `joomla_update_sites`
--

INSERT INTO `joomla_update_sites` (`update_site_id`, `name`, `type`, `location`, `enabled`, `last_check_timestamp`, `extra_query`) VALUES
(1, 'Joomla! Core', 'collection', 'http://update.joomla.org/core/list.xml', 1, 1453435181, ''),
(2, 'Joomla! Extension Directory', 'collection', 'http://update.joomla.org/jed/list.xml', 1, 1453435179, ''),
(3, 'Accredited Joomla! Translations', 'collection', 'http://update.joomla.org/language/translationlist_3.xml', 1, 1453435179, ''),
(4, 'Joomla! Update Component Update Site', 'extension', 'http://update.joomla.org/core/extensions/com_joomlaupdate.xml', 1, 1453435179, ''),
(5, 'WebInstaller Update Site', 'extension', 'http://appscdn.joomla.org/webapps/jedapps/webinstaller.xml', 1, 1453435179, ''),
(6, 'NoNumber Sourcerer', 'extension', 'http://download.nonumber.nl/updates.xml?e=sourcerer&type=.xml', 1, 1453435179, ''),
(7, '', 'collection', 'http://update.joomlart.com/service/tracking/list.xml', 1, 1453435179, ''),
(8, 'NoNumber Modules Anywhere', 'extension', 'http://download.nonumber.nl/updates.xml?e=modulesanywhere&type=.xml', 1, 1453435179, ''),
(9, 'GTranslate', 'extension', 'http://gtranslate.net/downloads/gtranslate.xml', 1, 1453435179, ''),
(10, 'Akeeba Backup Core', 'extension', 'http://cdn.akeebabackup.com/updates/abcore.xml', 1, 1453435278, '');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_update_sites_extensions`
--

CREATE TABLE IF NOT EXISTS `joomla_update_sites_extensions` (
  `update_site_id` int(11) NOT NULL DEFAULT '0',
  `extension_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`update_site_id`,`extension_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Links extensions to update sites';

--
-- Dumping data for table `joomla_update_sites_extensions`
--

INSERT INTO `joomla_update_sites_extensions` (`update_site_id`, `extension_id`) VALUES
(1, 700),
(2, 700),
(3, 600),
(4, 28),
(5, 10000),
(6, 10003),
(6, 10004),
(7, 10005),
(7, 10006),
(7, 10007),
(8, 10011),
(8, 10012),
(9, 10014),
(10, 10015);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_usergroups`
--

CREATE TABLE IF NOT EXISTS `joomla_usergroups` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `joomla_usergroups`
--

INSERT INTO `joomla_usergroups` (`id`, `parent_id`, `lft`, `rgt`, `title`) VALUES
(1, 0, 1, 18, 'Public'),
(2, 1, 8, 15, 'Registered'),
(3, 2, 9, 14, 'Author'),
(4, 3, 10, 13, 'Editor'),
(5, 4, 11, 12, 'Publisher'),
(6, 1, 4, 7, 'Manager'),
(7, 6, 5, 6, 'Administrator'),
(8, 1, 16, 17, 'Super Users'),
(9, 1, 2, 3, 'Guest');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_users`
--

CREATE TABLE IF NOT EXISTS `joomla_users` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=459 ;

--
-- Dumping data for table `joomla_users`
--

INSERT INTO `joomla_users` (`id`, `name`, `username`, `email`, `password`, `block`, `sendEmail`, `registerDate`, `lastvisitDate`, `activation`, `params`, `lastResetTime`, `resetCount`, `otpKey`, `otep`, `requireReset`) VALUES
(458, 'Anthony Rivera', 'revobtz', 'anthony.revocodez@gmail.com', '$2y$10$2ev8SH4me1SGP25m3CfFwORdeMFYsTdwaaI.uk9.97CRjjDdfS33i', 0, 1, '2015-11-15 03:00:16', '2016-01-22 03:59:37', '0', '{"admin_style":"","admin_language":"","language":"","editor":"","helpsite":"","timezone":"","parish_id":"1004"}', '0000-00-00 00:00:00', 0, '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_user_keys`
--

CREATE TABLE IF NOT EXISTS `joomla_user_keys` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `joomla_user_notes`
--

CREATE TABLE IF NOT EXISTS `joomla_user_notes` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `joomla_user_notes`
--

INSERT INTO `joomla_user_notes` (`id`, `user_id`, `catid`, `subject`, `body`, `state`, `checked_out`, `checked_out_time`, `created_user_id`, `created_time`, `modified_user_id`, `modified_time`, `review_time`, `publish_up`, `publish_down`) VALUES
(1, 458, 7, '', '<p>Antes de crear la cuenta de los usuarios</p>\r\n<p>Crear la diocesis y asignar su respectivo ID</p>\r\n<p>Crear la parroquia y asignar su respectivo ID</p>\r\n<p>Crear los usuarios y asignar sus respectivos ID</p>\r\n<p> </p>', 1, 0, '0000-00-00 00:00:00', 458, '2015-11-15 20:43:14', 458, '2015-11-15 20:43:14', '1970-01-01 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `joomla_user_profiles`
--

CREATE TABLE IF NOT EXISTS `joomla_user_profiles` (
  `user_id` int(11) NOT NULL,
  `profile_key` varchar(100) NOT NULL,
  `profile_value` text NOT NULL,
  `ordering` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `idx_user_id_profile_key` (`user_id`,`profile_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Simple user profile storage table';

-- --------------------------------------------------------

--
-- Table structure for table `joomla_user_usergroup_map`
--

CREATE TABLE IF NOT EXISTS `joomla_user_usergroup_map` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__users.id',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__usergroups.id',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `joomla_user_usergroup_map`
--

INSERT INTO `joomla_user_usergroup_map` (`user_id`, `group_id`) VALUES
(458, 8);

-- --------------------------------------------------------

--
-- Table structure for table `joomla_viewlevels`
--

CREATE TABLE IF NOT EXISTS `joomla_viewlevels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `title` varchar(100) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `rules` varchar(5120) NOT NULL COMMENT 'JSON encoded access control.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_assetgroup_title_lookup` (`title`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `joomla_viewlevels`
--

INSERT INTO `joomla_viewlevels` (`id`, `title`, `ordering`, `rules`) VALUES
(1, 'Public', 0, '[1]'),
(2, 'Registered', 2, '[6,2,8]'),
(3, 'Special', 3, '[6,3,8]'),
(5, 'Guest', 1, '[9]'),
(6, 'Super Users', 4, '[8]');

-- --------------------------------------------------------

--
-- Table structure for table `lazy_classes`
--

CREATE TABLE IF NOT EXISTS `lazy_classes` (
  `class_name` varchar(60) NOT NULL,
  `class_code` text NOT NULL,
  `class_comments` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`class_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lazy_classes`
--

INSERT INTO `lazy_classes` (`class_name`, `class_code`, `class_comments`) VALUES
('baptism', '<?php\r\nrequire_once "php/lazy/requestmanager.php";\r\nrequire_once "php/lazy/joomla.php";\r\n$user = JFactory::getUser();\r\nif($user->guest)\r\n   RequestManager::RequestSessionEnded();\r\nrequire_once "php/lazy/form.php";\r\nrequire_once "php/lazy/is.php";\r\nrequire_once "php/lazy/dialog.php";\r\n\r\nclass baptism\r\n\r\n{\r\n\r\npublic static function BtnSearchForm() { Form::GetSearchForm("baptism"); }\r\n\r\npublic static function BtnInsertForm() \r\n{ \r\nif(!isset($_POST["parishioner_id"])) \r\n{\r\n    Dialog::Prompt("Enter the parishioner ID", "function(data){PostDataChildForm({parishioner_id:data}, ''server.php?class_name=baptism&function_name=BtnInsertForm'')}");\r\n}\r\nelse if(is_int((int)$_POST["parishioner_id"]))\r\n{\r\n    $user = JFactory::getUser();\r\n    $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n    Form::GetInsertChildForm("baptism","parishioner_info"); \r\n}\r\n\r\n}\r\n\r\npublic static function BtnUpdateForm() { Form::GetUpdateForm("baptism", "baptism_select"); }\r\n\r\npublic static function BtnSearchRecords() \r\n{\r\n    Form::SearchRecords("baptism_search", "baptism"); \r\n}\r\n\r\npublic static function BtnInsertRecord()\r\n\r\n{\r\n\r\nif(Is::ValidRequest("baptism", array(''parishioner_full_name'', ''parishioner_birth_date'', ''parishioner_birth_place'')))\r\n\r\n{\r\n     $user = JFactory::getUser();\r\n     $_POST["user_id"] = $user->id;\r\n     $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n     if(Form::InsertRecord("baptism_insert"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n\r\n}\r\n}\r\n\r\npublic static function BtnUpdateRecord()\r\n\r\n{\r\n\r\n if(Is::ValidRequest("baptism", array(''parishioner_full_name'', ''parishioner_birth_date'', ''parishioner_birth_place'')))\r\n\r\n {\r\n     $user = JFactory::getUser();\r\n     $_POST["user_id"] = $user->id;\r\n     $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n     if(Form::UpdateRecord("baptism_update"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n\r\n }\r\n}\r\n\r\npublic static function BtnBaptismCertificateAllInOne()\r\n{\r\n   if(!isset($_POST["parishioner_id"])) \r\n   {\r\n      Dialog::Prompt("Enter the parishioner ID", "function(data){PostDataChildForm({parishioner_id:data}, ''server.php?class_name=baptism&function_name=BtnBaptismCertificateAllInOne'')}");\r\n   }\r\n   else if(is_int((int)$_POST["parishioner_id"]))\r\n   {\r\n      $user = JFactory::getUser();\r\n      $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n      Form::GetView("baptism_certificate_all_in_one");\r\n   }\r\n}\r\n \r\n//public static function BtnDeleteRecord() { echo Form::DeleteRecord($query_id); }\r\n\r\n}\r\n\r\n?>', 'baptism'),
('communion', '<?php\r\nrequire_once "php/lazy/requestmanager.php";\r\nrequire_once "php/lazy/joomla.php";\r\n$user = JFactory::getUser();\r\nif($user->guest)\r\n   RequestManager::RequestSessionEnded();\r\nrequire_once "php/lazy/form.php";\r\nrequire_once "php/lazy/is.php";\r\nrequire_once "php/lazy/dialog.php";\r\n\r\nclass communion\r\n\r\n{\r\n\r\npublic static function BtnSearchForm() { Form::GetSearchForm("communion"); }\r\n\r\npublic static function BtnInsertForm() \r\n{ \r\nif(!isset($_POST["parishioner_id"])) \r\n{\r\n    Dialog::Prompt("Enter the parishioner ID", "function(data){PostDataChildForm({parishioner_id:data}, ''server.php?class_name=communion&function_name=BtnInsertForm'')}");\r\n}\r\nelse if(is_int((int)$_POST["parishioner_id"]))\r\n{\r\n    $user = JFactory::getUser();\r\n    $_POST["user_id"] = $user->id;\r\n    $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n    Form::GetInsertChildForm("communion","parishioner_info"); \r\n}\r\n\r\n}\r\n\r\npublic static function BtnUpdateForm() { Form::GetUpdateForm("communion", "communion_select"); }\r\n\r\npublic static function BtnSearchRecords() \r\n{\r\n    Form::SearchRecords("communion_search", "communion"); \r\n}\r\n\r\npublic static function BtnInsertRecord()\r\n\r\n{\r\n\r\nif(Is::ValidRequest("communion", array(''parishioner_full_name'', ''parishioner_birth_date'', ''parishioner_birth_place'')))\r\n\r\n{\r\n     $user = JFactory::getUser();\r\n     $_POST["user_id"] = $user->id;\r\n     $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n     if(Form::InsertRecord("communion_insert"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n}\r\n}\r\n\r\npublic static function BtnUpdateRecord()\r\n\r\n{\r\n\r\n if(Is::ValidRequest("communion", array(''parishioner_full_name'', ''parishioner_birth_date'', ''parishioner_birth_place'')))\r\n\r\n {\r\n     $user = JFactory::getUser();\r\n     $_POST["user_id"] = $user->id;\r\n     if(Form::UpdateRecord("communion_update"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n\r\n }\r\n}\r\n\r\n//public static function BtnDeleteRecord() { echo Form::DeleteRecord($query_name); }\r\n\r\n}\r\n\r\n?>', 'communion'),
('confirmation', '<?php\r\nrequire_once "php/lazy/requestmanager.php";\r\nrequire_once "php/lazy/joomla.php";\r\n$user = JFactory::getUser();\r\nif($user->guest)\r\n   RequestManager::RequestSessionEnded();\r\nrequire_once "php/lazy/form.php";\r\nrequire_once "php/lazy/is.php";\r\nrequire_once "php/lazy/dialog.php";\r\n\r\nclass confirmation\r\n\r\n{\r\n\r\npublic static function BtnSearchForm() { Form::GetSearchForm("confirmation"); }\r\n\r\npublic static function BtnInsertForm() \r\n{ \r\nif(!isset($_POST["parishioner_id"])) \r\n{\r\n    Dialog::Prompt("Enter the parishioner ID", "function(data){PostDataChildForm({parishioner_id:data}, ''server.php?class_name=confirmation&function_name=BtnInsertForm'')}");\r\n}\r\nelse if(is_int((int)$_POST["parishioner_id"]))\r\n{\r\n    $user = JFactory::getUser();\r\n    $_POST["user_id"] = $user->id;\r\n    $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n    Form::GetInsertChildForm("confirmation","parishioner_info"); \r\n}\r\n\r\n}\r\n\r\npublic static function BtnUpdateForm() { Form::GetUpdateForm("confirmation", "confirmation_select"); }\r\n\r\npublic static function BtnSearchRecords() \r\n{\r\n    Form::SearchRecords("confirmation_search", "confirmation"); \r\n}\r\n\r\npublic static function BtnInsertRecord()\r\n\r\n{\r\n\r\nif(Is::ValidRequest("confirmation", array(''parishioner_full_name'', ''parishioner_birth_date'', ''parishioner_birth_place'')))\r\n\r\n{\r\n     $user = JFactory::getUser();\r\n     $_POST["user_id"] = $user->id;\r\n     $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n     if(Form::InsertRecord("confirmation_insert"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n\r\n}\r\n}\r\n\r\npublic static function BtnUpdateRecord()\r\n\r\n{\r\n\r\n if(Is::ValidRequest("confirmation", array(''parishioner_full_name'', ''parishioner_birth_date'', ''parishioner_birth_place'')))\r\n\r\n {\r\n     $user = JFactory::getUser();\r\n     $_POST["user_id"] = $user->id;\r\n     if(Form::UpdateRecord("confirmation_update"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n\r\n }\r\n}\r\n\r\n//public static function BtnDeleteRecord() { echo Form::DeleteRecord($query_id); }\r\n\r\n}\r\n\r\n?>', 'confirmation'),
('marriage', '<?php\r\nrequire_once "php/lazy/requestmanager.php";\r\nrequire_once "php/lazy/joomla.php";\r\n$user = JFactory::getUser();\r\nif($user->guest)\r\n   RequestManager::RequestSessionEnded();\r\nrequire_once "php/lazy/form.php";\r\nrequire_once "php/lazy/is.php";\r\nrequire_once "php/lazy/dialog.php";\r\n\r\nclass marriage\r\n\r\n{\r\n\r\npublic static function BtnSearchForm() { Form::GetSearchForm("marriage"); }\r\n\r\npublic static function BtnInsertForm() \r\n{ \r\nif(!isset($_POST["parishioner_husband_id"]) || !isset($_POST["parishioner_wife_id"])) \r\n{\r\n    Dialog::PromptDouble("Enter the parishioner Husband ID", "Enter the parishioner Wife ID", "function(data1, data2){PostDataChildForm({parishioner_husband_id:data1, parishioner_wife_id:data2}, ''server.php?class_name=marriage&function_name=BtnInsertForm'')}");\r\n}\r\nelse if(is_int((int)$_POST["parishioner_husband_id"]) && is_int((int)$_POST["parishioner_wife_id"]))\r\n{\r\n    $user = JFactory::getUser();\r\n    $_POST["user_id"] = $user->id;\r\n    $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n    Form::GetInsertChildForm("marriage","marriage_select_couple_info"); \r\n}\r\n\r\n}\r\n\r\npublic static function BtnUpdateForm() { Form::GetUpdateForm("marriage", "marriage_select"); }\r\n\r\npublic static function BtnSearchRecords() \r\n{\r\n    Form::SearchRecords("marriage_search", "marriage"); \r\n}\r\n\r\npublic static function BtnInsertRecord()\r\n\r\n{\r\n\r\nif(Is::ValidRequest("marriage", array(''parishioner_full_name'', ''parishioner_birth_date'', ''parishioner_birth_place'')))\r\n\r\n{\r\n     $user = JFactory::getUser();\r\n     $_POST["user_id"] = $user->id;\r\n     $_POST["parish_id"] = $user->getParam(''parish_id'');\r\n     if(Form::InsertRecord("marriage_insert"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n\r\n}\r\n}\r\n\r\npublic static function BtnUpdateRecord()\r\n\r\n{\r\n\r\n if(Is::ValidRequest("marriage", array(''parishioner_full_name'', ''parishioner_birth_date'', ''parishioner_birth_place'')))\r\n\r\n {\r\n     $user = JFactory::getUser();\r\n     $_POST["user_id"] = $user->id;\r\n     if(Form::UpdateRecord("marriage_update"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n\r\n }\r\n}\r\n\r\n//public static function BtnDeleteRecord() { echo Form::DeleteRecord($query_id); }\r\n\r\n}\r\n\r\n?>', 'marriage'),
('parish', '<?php\r\nrequire_once "php/lazy/requestmanager.php";\r\nrequire_once "php/lazy/joomla.php";\r\n$user = JFactory::getUser();\r\nif($user->guest)\r\n   RequestManager::RequestSessionEnded();\r\nrequire_once "php/lazy/form.php";\r\nrequire_once "php/lazy/is.php";\r\nrequire_once "php/lazy/model.php";\r\n\r\nclass parish\r\n{\r\n\r\npublic static function BtnInsertUpdateForm() \r\n{\r\n     $parish = current(Model::GetFromQuery("parish_select_current_session"));\r\n\r\n     if(!property_exists($parish, "parish_id"))\r\n     {\r\n           Form::GetInsertForm("parish"); \r\n     }\r\n     else\r\n     {\r\n           Form::GetUpdateForm("parish", "parish_select_current_session");\r\n     }\r\n}\r\n\r\npublic static function BtnInsertRecord()\r\n\r\n{\r\n\r\nif(Is::ValidRequest("parish"))\r\n{\r\n     if(Form::InsertRecord("parish_insert"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n}\r\n}\r\n\r\npublic static function BtnUpdateRecord()\r\n{\r\n\r\n if(Is::ValidRequest("parish"))\r\n {\r\n\r\n     if(Form::UpdateRecord("parish_update"))\r\n         RequestManager::RequestRecordSaved();\r\n     else\r\n         RequestManager::RequestDatabaseError();\r\n\r\n }\r\n}\r\n\r\n}\r\n\r\n?>', 'parish'),
('parishioner', '<?php\nrequire_once "php/lazy/requestmanager.php";\nrequire_once "php/lazy/joomla.php";\n$user = JFactory::getUser();\nif($user->guest)\n   RequestManager::RequestSessionEnded();\nrequire_once "php/lazy/form.php";\nrequire_once "php/lazy/is.php";\n\n\nclass parishioner\n\n{\n\npublic static function BtnSearchForm() { Form::GetSearchForm("parishioner"); }\n\npublic static function BtnInsertForm() { Form::GetInsertForm("parishioner"); }\n\npublic static function BtnUpdateForm() { Form::GetUpdateForm("parishioner", "parishioner_select"); }\n\npublic static function BtnSearchRecords() { Form::SearchRecords("parishioner_search", "parishioner"); }\n\npublic static function BtnInsertRecord()\n\n{\n\nif(Is::ValidRequest("parishioner", array("parishioner_id")))\n{\n     $user = JFactory::getUser();\n     $_POST["user_id"] = $user->id;\n     $_POST["parish_id"] = $user->getParam(''parish_id'');\n     if(Form::InsertRecord("parishioner_insert"))\n         RequestManager::RequestRecordSaved();\n     else\n         RequestManager::RequestDatabaseError();\n}\n}\n\npublic static function BtnUpdateRecord()\n{\n\n if(Is::ValidRequest("parishioner"))\n\n {\n     $user = JFactory::getUser();\n     $_POST["user_id"] = $user->id;\n     $_POST["parish_id"] = $user->getParam(''parish_id'');\n     if(Form::UpdateRecord("parishioner_update"))\n         RequestManager::RequestRecordSaved();\n     else\n         RequestManager::RequestDatabaseError();\n\n }\n}\n\n//public static function BtnDeleteRecord() { echo Form::DeleteRecord($query_id); }\n\n}\n\n?>', 'parishioner');

-- --------------------------------------------------------

--
-- Table structure for table `lazy_forms`
--

CREATE TABLE IF NOT EXISTS `lazy_forms` (
  `form_name_id` varchar(60) NOT NULL,
  `class_name` varchar(60) NOT NULL,
  `form_title_code` text,
  `form_id` varchar(45) NOT NULL,
  `form_name` varchar(45) NOT NULL,
  `form_action` varchar(80) NOT NULL DEFAULT 'server.php',
  `form_method` enum('post','get','','') NOT NULL DEFAULT 'post',
  `form_class` varchar(45) NOT NULL DEFAULT 'form-horizontal ajax',
  `form_enctype` enum('multipart/form-data','application/x-www-form-urlencoded','text/plain','') NOT NULL DEFAULT 'multipart/form-data',
  `form_autocomplete` enum('on','off','','') NOT NULL DEFAULT 'on',
  `form_target` enum('_self','_blank','_parent','_top','') NOT NULL DEFAULT '_self',
  `form_attributes` varchar(80) DEFAULT NULL,
  `form_options` varchar(120) NOT NULL DEFAULT 'all',
  `form_above_code` text,
  `form_below_code` text,
  `form_is_hidden` enum('NO','YES','','') NOT NULL DEFAULT 'NO',
  PRIMARY KEY (`form_name_id`),
  KEY `class_name` (`class_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lazy_forms`
--

INSERT INTO `lazy_forms` (`form_name_id`, `class_name`, `form_title_code`, `form_id`, `form_name`, `form_action`, `form_method`, `form_class`, `form_enctype`, `form_autocomplete`, `form_target`, `form_attributes`, `form_options`, `form_above_code`, `form_below_code`, `form_is_hidden`) VALUES
('baptism', 'baptism', '<h3>Baptism</h3>', 'baptism', 'baptism', 'server.php', 'post', 'form-horizontal ajax', 'multipart/form-data', 'on', '_self', NULL, 'all', NULL, NULL, 'NO'),
('communion', 'communion', '<h3>Communion</h3>', 'communion', 'communion', 'server.php', 'post', 'form-horizontal ajax', 'multipart/form-data', 'on', '_self', NULL, 'all', NULL, NULL, 'NO'),
('confirmation', 'confirmation', '<h3>Confirmation</h3>', 'confirmation', 'confirmation', 'server.php', 'post', 'form-horizontal ajax', 'multipart/form-data', 'on', '_self', NULL, 'all', NULL, NULL, 'NO'),
('marriage', 'marriage', '<h3>Marriage</h3>', 'marriage', 'marriage', 'server.php', 'post', 'form-horizontal ajax', 'multipart/form-data', 'on', '_self', NULL, 'all', NULL, NULL, 'NO'),
('parish', 'parish', '<h3>Parish</h3>', 'parish', 'parish', 'server.php', 'post', 'form-horizontal ajax', 'multipart/form-data', 'on', '_self', NULL, 'all', NULL, NULL, 'NO'),
('parishioner', 'parishioner', '<h3>Parishioner</h3>', 'parishioner', 'parishioner', 'server.php', 'post', 'form-horizontal ajax', 'multipart/form-data', 'on', '_self', NULL, 'all', NULL, NULL, 'NO');

-- --------------------------------------------------------

--
-- Table structure for table `lazy_forms_inputs`
--

CREATE TABLE IF NOT EXISTS `lazy_forms_inputs` (
  `input_form_id` int(11) NOT NULL AUTO_INCREMENT,
  `form_name_id` varchar(60) NOT NULL,
  `input_validation_name` varchar(80) NOT NULL,
  `select_query_name` varchar(60) DEFAULT NULL,
  `select_column_name_for_value` varchar(45) DEFAULT NULL,
  `select_column_name_for_description` varchar(45) DEFAULT NULL,
  `input_grid_layout_class` varchar(45) NOT NULL DEFAULT 'col-sm-6 col-md-4 col-lg-3',
  `input_id` varchar(45) NOT NULL,
  `input_name` varchar(45) NOT NULL,
  `input_label_text` varchar(45) DEFAULT NULL,
  `input_type` enum('text','password','color','date','datetime','datime-local','email','month','number','range','search','tel','time','url','week','file','select','textarea') NOT NULL,
  `input_maxlength` int(11) DEFAULT NULL,
  `input_class` varchar(45) DEFAULT 'form-control',
  `input_attributes` varchar(80) DEFAULT NULL,
  `input_files_extensions` varchar(45) DEFAULT NULL,
  `input_files_mime_types` varchar(60) DEFAULT NULL,
  `input_placeholder` varchar(45) DEFAULT NULL,
  `input_help_text` varchar(60) DEFAULT NULL,
  `input_order_number` int(11) NOT NULL,
  `input_data_type` enum('CHAR','VARCHAR','TINYTEXT','TEXT','MEDIUMTEXT','LONGTEXT','BINARY','VARBINARY','TINYBLOB','MEDIUMBLOB','BLOB','LONGBLOB','ENUM','SET','TINYINT','SMALLINT','MEDIUMINT','INT','INTERGER','BIGINT','BIT','BOOL','BOOLEAN','SERIAL','DECIMAL','DEC','FLOAT','DOUBLE','NUMERIC','DOUBLE PRECISION','REAL') NOT NULL,
  `input_is_nullable` enum('NO','YES','','') NOT NULL DEFAULT 'NO',
  `input_is_search_field` enum('NO','YES','','') NOT NULL DEFAULT 'NO',
  `input_is_hidden` enum('NO','YES','','') NOT NULL DEFAULT 'NO',
  `input_above_input_code` text,
  `input_below_input_code` text,
  PRIMARY KEY (`input_form_id`),
  KEY `form_name` (`form_name_id`),
  KEY `input_validation_name` (`input_validation_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=140 ;

--
-- Dumping data for table `lazy_forms_inputs`
--

INSERT INTO `lazy_forms_inputs` (`input_form_id`, `form_name_id`, `input_validation_name`, `select_query_name`, `select_column_name_for_value`, `select_column_name_for_description`, `input_grid_layout_class`, `input_id`, `input_name`, `input_label_text`, `input_type`, `input_maxlength`, `input_class`, `input_attributes`, `input_files_extensions`, `input_files_mime_types`, `input_placeholder`, `input_help_text`, `input_order_number`, `input_data_type`, `input_is_nullable`, `input_is_search_field`, `input_is_hidden`, `input_above_input_code`, `input_below_input_code`) VALUES
(1, 'parishioner', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_id', 'parishioner_id', 'Parishioner ID', 'number', 20, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 1, 'BIGINT', 'NO', 'YES', 'NO', '<hr><h4>Parishioner Info</h4><hr>', '<div class="clearfix"></div>'),
(2, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_first_name', 'parishioner_first_name', 'Parishioner First  Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 5, 'VARCHAR', 'NO', 'YES', 'NO', NULL, NULL),
(3, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_middle_name', 'parishioner_middle_name', 'Parishioner Middle Name', 'text', 25, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 10, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(4, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_last_name', 'parishioner_last_name', 'Parishioner Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 15, 'VARCHAR', 'YES', 'YES', 'NO', NULL, NULL),
(5, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_second_last_name', 'parishioner_second_last_name', 'Parishioner Second Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 20, 'VARCHAR', 'YES', 'YES', 'NO', NULL, '<div class="clearfix"></div>'),
(6, 'parishioner', 'IsPositiveInt', 'gender_select', 'gender_id', 'gender_name', 'col-sm-6 col-md-4 col-lg-3', 'gender_id', 'gender_id', 'Gender ', 'select', NULL, 'form-control', NULL, NULL, NULL, NULL, NULL, 25, 'TINYINT', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(7, 'parishioner', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_birth_place', 'parishioner_birth_place', 'Parishioner Birth Place', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 30, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(8, 'parishioner', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_birth_date', 'parishioner_birth_date', 'Parishioner Birth Date', 'text', 10, 'form-control', 'data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 35, 'VARCHAR', 'YES', 'YES', 'NO', NULL, NULL),
(9, 'parishioner', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_residence', 'parishioner_residence', 'Parishioner Residence', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 40, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(10, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'father_first_name', 'father_first_name', 'Father First Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 45, 'VARCHAR', 'YES', 'NO', 'NO', '<h4>Father Info</h4><hr>', NULL),
(11, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'father_middle_name', 'father_middle_name', 'Father Middle Name', 'text', 25, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 50, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(12, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'father_last_name', 'father_last_name', 'Father Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 55, 'VARCHAR', 'YES', 'NO', 'NO', NULL, ''),
(13, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'father_second_last_name', 'father_second_last_name', 'Father Second Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 60, 'VARCHAR', 'YES', 'NO', 'NO', NULL, ''),
(14, 'parishioner', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'father_residence', 'father_residence', 'Father Residence', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 65, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(15, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'mother_first_name', 'mother_first_name', 'Mother First Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 70, 'VARCHAR', 'YES', 'NO', 'NO', '<h4>Mother Info</h4><hr>', NULL),
(16, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'mother_middle_name', 'mother_middle_name', 'Mother Middle Name', 'text', 25, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 75, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(17, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'mother_last_name', 'mother_last_name', 'Mother Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 80, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(18, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'mother_second_last_name', 'mother_second_last_name', 'Mother Second Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 85, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(19, 'parishioner', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'mother_residence', 'mother_residence', 'Mother Residence', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 90, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(20, 'parishioner', 'IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'physical_address', 'physical_address', 'Physical Address', 'text', 80, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 99, 'VARCHAR', 'YES', 'NO', 'NO', '<h4>Contact Info</h4><hr>', NULL),
(21, 'parishioner', 'IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'postal_address', 'postal_address', 'Postal Address', 'text', 80, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 100, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(22, 'parishioner', 'IsEmail', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'email', 'email', 'Email', 'email', 60, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 105, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(23, 'parishioner', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'phone', 'phone', 'Phone', 'tel', 10, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 110, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(24, 'parishioner', 'IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'notes', 'notes', 'Notes', 'textarea', 255, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 120, 'TINYTEXT', 'YES', 'NO', 'NO', NULL, NULL),
(25, 'baptism', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_id', 'parishioner_id', 'Parishioner ID', 'number', 20, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 1, 'BIGINT', 'NO', 'YES', 'NO', '<hr><h4>Parishioner Info</h4><hr>', '<div class="clearfix"></div>'),
(26, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_full_name', 'parishioner_full_name', 'Parishioner Full Name', 'text', 100, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 5, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(27, 'baptism', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_birth_date', 'parishioner_birth_date', 'Parishioner Birthdate', 'text', 10, 'form-control', 'readonly data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 10, 'VARCHAR', 'YES', 'YES', 'NO', NULL, NULL),
(28, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_birth_place', 'parishioner_birth_place', 'Parishioner Birthplace', 'text', 45, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 15, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(30, 'baptism', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'baptism_date', 'baptism_date', 'Baptism Date', 'text', 10, 'form-control', 'data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 20, 'VARCHAR', 'NO', 'NO', 'NO', '<h4>Baptism Info</h4><hr>', '<div class="clearfix"></div>'),
(31, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'baptism_godfather', 'baptism_godfather', 'Baptism Godfather', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 25, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(32, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'baptism_godmother', 'baptism_godmother', 'Baptism Godmother', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 30, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(33, 'baptism', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'baptism_book', 'baptism_book', 'Baptism Book', 'number', 10, 'form-control', NULL, NULL, NULL, NULL, NULL, 35, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(34, 'baptism', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'baptism_page', 'baptism_page', 'Baptism Page', 'number', 10, 'form-control', NULL, NULL, NULL, NULL, NULL, 40, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(35, 'baptism', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'baptism_number', 'baptism_number', 'Baptism Number', 'number', 10, 'form-control', NULL, NULL, NULL, NULL, NULL, 45, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(36, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'baptism_celebrant', 'baptism_celebrant', 'Baptism Celebrant', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 50, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(38, 'baptism', 'IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'baptism_notes', 'baptism_notes', ' Baptism Notes', 'textarea', 300, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 60, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(39, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'paternal_grandfather_first_name', 'paternal_grandfather_first_name', 'Paternal Grandfather First Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 91, 'VARCHAR', 'YES', 'NO', 'NO', '<h4>Paternal Grandparents</h4><hr>', NULL),
(40, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'paternal_grandfather_last_name', 'paternal_grandfather_last_name', 'Paternal Grandfather Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 92, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(41, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'paternal_grandmother_first_name', 'paternal_grandmother_first_name', 'Paternal Grandmother First Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 93, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(42, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'paternal_grandmother_last_name', 'paternal_grandmother_last_name', 'Paternal Grandmother Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 94, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(43, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'maternal_grandfather_first_name', 'maternal_grandfather_first_name', 'Maternal Grandfather First Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 95, 'VARCHAR', 'YES', 'NO', 'NO', '<h4>Maternal Grandparents</h4><hr>', NULL),
(44, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'maternal_grandfather_last_name', 'maternal_grandfather_last_name', 'Maternal Grandfather Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 96, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(45, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'maternal_grandmother_first_name', 'maternal_grandmother_first_name', 'Maternal Grandmother First Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 97, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(46, 'parishioner', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'maternal_grandmother_last_name', 'maternal_grandmother_last_name', 'Maternal Grandmother Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 98, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(47, 'baptism', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_first_name', 'parishioner_first_name', 'Parishioner First  Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 6, 'VARCHAR', 'NO', 'YES', 'YES', NULL, NULL),
(48, 'baptism', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_last_name', 'parishioner_last_name', 'Parishioner Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 7, 'VARCHAR', 'YES', 'YES', 'YES', NULL, NULL),
(50, 'baptism', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_second_last_name', 'parishioner_second_last_name', 'Parishioner Second Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 8, 'VARCHAR', 'YES', 'YES', 'YES', NULL, '<div class="clearfix"></div>'),
(51, 'communion', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_id', 'parishioner_id', 'Parishioner ID', 'number', 20, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 1, 'BIGINT', 'NO', 'YES', 'NO', '<hr><h4>Parishioner Info</h4><hr>', '<div class="clearfix"></div>'),
(52, 'communion', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_full_name', 'parishioner_full_name', 'Parishioner Full Name', 'text', 100, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 5, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(53, 'communion', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_birth_date', 'parishioner_birth_date', 'Parishioner Birthdate', 'text', 10, 'form-control', 'readonly data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 10, 'VARCHAR', 'YES', 'YES', 'NO', NULL, NULL),
(54, 'communion', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_birth_place', 'parishioner_birth_place', 'Parishioner Birthplace', 'text', 45, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 15, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(55, 'communion', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_first_name', 'parishioner_first_name', 'Parishioner First  Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 6, 'VARCHAR', 'YES', 'YES', 'YES', NULL, NULL),
(56, 'communion', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_last_name', 'parishioner_last_name', 'Parishioner Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 7, 'VARCHAR', 'YES', 'YES', 'YES', NULL, NULL),
(57, 'communion', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_second_last_name', 'parishioner_second_last_name', 'Parishioner Second Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 8, 'VARCHAR', 'YES', 'YES', 'YES', NULL, '<div class="clearfix"></div>'),
(58, 'communion', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'communion_date', 'communion_date', 'Communion Date', 'text', 10, 'form-control', 'data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 20, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(60, 'communion', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'communion_book', 'communion_book', 'Communion Book', 'text', 11, 'form-control', NULL, NULL, NULL, NULL, NULL, 25, 'INT', 'NO', 'NO', 'NO', '<h4>Communion Info</h4><hr>', NULL),
(61, 'communion', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'communion_page', 'communion_page', 'Communion Page', 'text', 11, 'form-control', NULL, NULL, NULL, NULL, NULL, 30, 'INT', 'NO', 'NO', 'NO', NULL, NULL),
(63, 'communion', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'communion_number', 'communion_number', 'Communion Number', 'number', 11, 'form-control', NULL, NULL, NULL, NULL, NULL, 35, 'INT', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(64, 'communion', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'communion_celebrant', 'communion_celebrant', 'Communion Celebrant', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 40, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(66, 'communion', 'IsAlphaNumeric', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'communion_notes', 'communion_notes', 'Communion Notes', 'textarea', 300, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 50, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(67, 'confirmation', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_id', 'parishioner_id', 'Parishioner ID', 'number', 20, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 1, 'BIGINT', 'NO', 'YES', 'NO', '<hr><h4>Parishioner Info</h4><hr>', '<div class="clearfix"></div>'),
(68, 'confirmation', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_full_name', 'parishioner_full_name', 'Parishioner Full Name', 'text', 100, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 5, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(69, 'confirmation', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_first_name', 'parishioner_first_name', 'Parishioner First  Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 6, 'VARCHAR', 'YES', 'YES', 'YES', NULL, NULL),
(70, 'confirmation', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_last_name', 'parishioner_last_name', 'Parishioner Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 7, 'VARCHAR', 'YES', 'YES', 'YES', NULL, NULL),
(71, 'confirmation', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_second_last_name', 'parishioner_second_last_name', 'Parishioner Second Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 8, 'VARCHAR', 'YES', 'YES', 'YES', NULL, '<div class="clearfix"></div>'),
(74, 'confirmation', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_birth_date', 'parishioner_birth_date', 'Parishioner Birthdate', 'text', 10, 'form-control', 'readonly data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 10, 'VARCHAR', 'YES', 'YES', 'NO', NULL, NULL),
(75, 'confirmation', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_birth_place', 'parishioner_birth_place', 'Parishioner Birthplace', 'text', 45, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 15, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(77, 'confirmation', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_date', 'confirmation_date', 'Confirmation Date', 'text', 10, 'form-control', 'data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 20, 'VARCHAR', 'NO', 'NO', 'NO', '<h4>Confirmation Info</h4><hr>', '<div class="clearfix"></div>'),
(78, 'confirmation', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_godfather_godmother', 'confirmation_godfather_godmother', 'Confirmation Godfather Godmother', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 25, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(79, 'confirmation', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_book', 'confirmation_book', 'Confirmation Book', 'number', 10, 'form-control', NULL, NULL, NULL, NULL, NULL, 30, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(80, 'confirmation', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_page', 'confirmation_page', 'Confirmation Page', 'number', 10, 'form-control', NULL, NULL, NULL, NULL, NULL, 35, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(81, 'confirmation', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_number', 'confirmation_number', 'Confirmation Number', 'number', 10, 'form-control', NULL, NULL, NULL, NULL, NULL, 40, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(82, 'confirmation', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_celebrant', 'confirmation_celebrant', 'Confirmation Celebrant', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 45, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(84, 'confirmation', 'IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_notes', 'confirmation_notes', 'Confirmation Notes', 'textarea', 300, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 55, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(85, 'marriage', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_id', 'parishioner_id', 'Parishioner ID', 'number', 20, 'form-control', NULL, NULL, NULL, NULL, NULL, 1, 'BIGINT', 'NO', 'YES', 'YES', '<hr><h4>Parishioner Info</h4><hr>', '<div class="clearfix"></div>'),
(86, 'marriage', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_first_name', 'parishioner_first_name', 'Parishioner First  Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 6, 'VARCHAR', 'YES', 'YES', 'YES', NULL, NULL),
(87, 'marriage', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_last_name', 'parishioner_last_name', 'Parishioner Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 7, 'VARCHAR', 'YES', 'YES', 'YES', NULL, NULL),
(88, 'marriage', 'IsAlpha', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_second_last_name', 'parishioner_second_last_name', 'Parishioner Second Last Name', 'text', 25, 'form-control', NULL, NULL, NULL, NULL, NULL, 8, 'VARCHAR', 'YES', 'YES', 'YES', NULL, '<div class="clearfix"></div>'),
(89, 'marriage', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_birth_date', 'parishioner_birth_date', 'Parishioner Birthdate', 'text', 10, 'form-control', ' data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 10, 'VARCHAR', 'YES', 'YES', 'YES', NULL, '<div class="clearfix"></div>'),
(90, 'marriage', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_husband_id', 'parishioner_husband_id', 'Parishioner Husband ID', 'text', 25, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 15, 'VARCHAR', 'YES', 'NO', 'NO', '<hr><h4>Husband Info</h4><hr>', '<div class="clearfix"></div>'),
(91, 'marriage', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_husband_full_name', 'parishioner_husband_full_name', 'Parishioner Husband Full Name', 'text', 100, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 20, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(92, 'marriage', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_husband_birth_date', 'parishioner_husband_birth_date', 'Parishioner Husband Birth Date', 'text', 45, 'form-control', 'readonly data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, NULL, NULL, 25, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(93, 'marriage', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_husband_birth_place', 'parishioner_husband_birth_place', 'Parishioner Husband Birth Place', 'text', 45, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 30, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(94, 'marriage', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_wife_id', 'parishioner_wife_id', 'Parishioner Wife ID', 'text', 25, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 35, 'VARCHAR', 'YES', 'NO', 'NO', '<h4>Wife Info</h4><hr>', '<div class="clearfix"></div>'),
(95, 'marriage', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_wife_full_name', 'parishioner_wife_full_name', 'Parishioner Wife  Full Name', 'text', 100, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 40, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(96, 'marriage', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_wife_birth_date', 'parishioner_wife_birth_date', 'Parishioner Wife Birth Date', 'text', 45, 'form-control', 'readonly data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, '', NULL, 45, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(97, 'marriage', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parishioner_wife_birth_place', 'parishioner_wife_birth_place', 'Parishioner Wife Birth Pace', 'text', 45, 'form-control', 'readonly', NULL, NULL, NULL, NULL, 50, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(98, 'marriage', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_date', 'marriage_date', 'Marriage Date', 'text', 10, 'form-control', ' data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 55, 'VARCHAR', 'NO', 'NO', 'NO', '<h4>Marriage Info</h4><hr>', '<div class="clearfix"></div>'),
(99, 'marriage', 'IsPositiveInt', 'civil_status_select', 'civil_status_id', 'civil_status_name', 'col-sm-6 col-md-4 col-lg-3', 'husband_civil_status_id', 'husband_civil_status_id', 'Husband Civil Status ID', 'select', 3, 'form-control', NULL, NULL, NULL, NULL, NULL, 60, 'TINYINT', 'NO', 'NO', 'NO', NULL, NULL),
(100, 'marriage', 'IsPositiveInt', 'civil_status_select', 'civil_status_id', 'civil_status_name', 'col-sm-6 col-md-4 col-lg-3', 'wife_civil_status_id', 'wife_civil_status_id', 'Wife Civil Status ID', 'select', 3, 'form-control', NULL, NULL, NULL, NULL, NULL, 65, 'TINYINT', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(101, 'marriage', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_witness_1', 'marriage_witness_1', 'Marriage Witness 1', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 70, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(102, 'marriage', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_witness_2', 'marriage_witness_2', 'Marriage Witness 2', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 75, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(103, 'marriage', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_book', 'marriage_book', 'Marriage Book', 'number', 11, 'form-control', NULL, NULL, NULL, NULL, NULL, 80, 'INT', 'NO', 'NO', 'NO', NULL, NULL),
(104, 'marriage', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_page', 'marriage_page', 'Marriage Page', 'number', 11, 'form-control', NULL, NULL, NULL, NULL, NULL, 85, 'INT', 'NO', 'NO', 'NO', NULL, NULL),
(105, 'marriage', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_number', 'marriage_number', 'Marriage Number', 'number', 11, 'form-control', NULL, NULL, NULL, NULL, NULL, 90, 'INT', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(106, 'marriage', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_celebrant', 'marriage_celebrant', 'Marriage Celebrant', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 95, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(108, 'marriage', 'IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_notes', 'marriage_notes', 'Marriage Notes', 'textarea', 300, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 105, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(109, 'baptism', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'communion_date', 'communion_date', 'Communion Date', 'text', 10, 'form-control optional', 'data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 105, 'VARCHAR', 'YES', 'NO', 'NO', '<h4>Communion Reference</h4><hr>', NULL),
(110, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'communion_parish', 'communion_parish', 'Communion Parish', 'text', 60, 'form-control optional', '', NULL, NULL, '', NULL, 110, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(111, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'communion_city', 'communion_city', 'Communion City', 'text', 45, 'form-control optional', '', NULL, NULL, '', NULL, 115, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(113, 'baptism', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_date', 'confirmation_date', 'Confirmation Date', 'text', 10, 'form-control optional', 'data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 120, 'VARCHAR', 'YES', 'NO', 'NO', '<h4>Confirmation Reference</h4><hr>', NULL),
(114, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_parish', 'confirmation_parish', 'Confirmation Parish', 'text', 60, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 125, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(115, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'confirmation_city', 'confirmation_city', 'Confirmation City', 'text', 45, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 130, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(116, 'marriage', 'IsAlphaNumericUnderscore', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_couple_full_name', 'marriage_couple_full_name', 'Marriage Couple Fullname', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 135, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(117, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_couple_father_full_name', 'marriage_couple_father_full_name', 'Marriage Couple Father Fullname', 'text', 45, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 140, 'VARCHAR', 'YES', 'NO', 'NO', '', NULL),
(118, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_couple_mother_full_name', 'marriage_couple_mother_full_name', 'Marriage Couple Mother Fullname', 'text', 45, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 145, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(119, 'baptism', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_date', 'marriage_date', 'Marriage Date', 'text', 10, 'form-control optional', 'data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 150, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(120, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_parish', 'marriage_parish', 'Marriage Parish', 'text', 60, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 155, 'VARCHAR', 'YES', 'NO', 'NO', NULL, NULL),
(121, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_city', 'marriage_city', 'Marriage City', 'text', 45, 'form-control optional', NULL, NULL, NULL, NULL, NULL, 160, 'VARCHAR', 'YES', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(122, 'baptism', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'marriage_couple_full_name', 'marriage_couple_full_name', 'Marriage Couple Fullname', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 135, 'VARCHAR', 'YES', 'NO', 'NO', '<h4>Marriage Reference</h4><hr>', '<div class="clearfix"></div>'),
(123, 'parish', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parish_id', 'parish_id', 'Parish ID', 'number', 11, 'form-control', NULL, NULL, NULL, NULL, NULL, 1, 'INT', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(124, 'parish', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'diocese_id', 'diocese_id', 'Diocese ID', 'number', 11, 'form-control', NULL, NULL, NULL, NULL, NULL, 5, 'VARCHAR', 'NO', 'NO', 'NO', NULL, '<div class="clearfix"></div>'),
(125, 'parish', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parish_name', 'parish_name', 'Parish Name', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 10, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(126, 'parish', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parish_city', 'parish_city', 'Parish City', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 15, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(127, 'parish', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parish_state', 'parish_state', 'Parish State', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 20, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(128, 'parish', 'IsEmail', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'parish_email', 'parish_email', 'Parish Email', 'email', 60, 'form-control', NULL, NULL, NULL, NULL, NULL, 25, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(129, 'parish', 'IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'office_hours', 'office_hours', 'Office Hours', 'text', 80, 'form-control', NULL, NULL, NULL, NULL, NULL, 30, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(130, 'parish', 'IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'physical_address', 'physical_address', 'Physical Address', 'text', 80, 'form-control', NULL, NULL, NULL, NULL, NULL, 35, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(131, 'parish', 'IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'postal_address', 'postal_address', 'Postal Address', 'text', 80, 'form-control', NULL, NULL, NULL, NULL, NULL, 40, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(132, 'parish', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'zipcode', 'zipcode', 'Zipcode', 'number', 5, 'form-control', NULL, NULL, NULL, NULL, NULL, 45, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(133, 'parish', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'phone', 'phone', 'Phone', 'number', 10, 'form-control', NULL, NULL, NULL, NULL, NULL, 50, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(134, 'parish', 'IsPositiveInt', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'fax', 'fax', 'Fax', 'number', 10, 'form-control', NULL, NULL, NULL, NULL, NULL, 55, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(135, 'parish', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'administrator_full_name', 'administrator_full_name', 'Administrator Fullname', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 21, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(136, 'parishioner', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'father_birth_place', 'father_birth_place', 'Father Birthplace', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 61, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(137, 'parishioner', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'father_birth_date', 'father_birth_date', 'Father Birthdate', 'text', 10, 'form-control', 'data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 62, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(138, 'parishioner', 'IsAlphaWhitespace', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'mother_birth_place', 'mother_birth_place', 'Mother Birthplace', 'text', 45, 'form-control', NULL, NULL, NULL, NULL, NULL, 86, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL),
(139, 'parishioner', 'IsValidDate', NULL, NULL, NULL, 'col-sm-6 col-md-4 col-lg-3', 'mother_birth_date', 'mother_birth_date', 'Mother Birthdate', 'text', 10, 'form-control', 'data-inputmask="''alias'': ''mm/dd/yyyy''"', NULL, NULL, 'mm/dd/yyyy', NULL, 87, 'VARCHAR', 'NO', 'NO', 'NO', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lazy_inputs_validations`
--

CREATE TABLE IF NOT EXISTS `lazy_inputs_validations` (
  `input_validation_name` varchar(80) NOT NULL,
  `input_regex` varchar(250) NOT NULL,
  `input_regex_comments` tinytext,
  PRIMARY KEY (`input_validation_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lazy_inputs_validations`
--

INSERT INTO `lazy_inputs_validations` (`input_validation_name`, `input_regex`, `input_regex_comments`) VALUES
('IsAlpha', '^[a-zA-Z]+$', 'Matches letters'),
('IsAlphaNumeric', '^[a-zA-Z0-9]+$', 'Matches letters and numbers'),
('IsAlphaNumericUnderscore', '^[a-zA-Z0-9_]+$', 'Matches letters, numbers and underscore'),
('IsAlphaNumericUnderscorWhiteeSpaceDotCommaHyphen', '^[a-zA-Z0-9\\s_.,-]+$', 'Matches Letters, Numbers, Underscore, WhiteSpace Dot Comma and Hyphen'),
('IsAlphaWhitespace', '^[a-zA-Z ]+$', 'Matches letters and white spaces'),
('IsEmail', '^\\w+[\\w-\\.]*\\@\\w+((-\\w+)|(\\w*))\\.[a-z]{2,4}$', 'Matches email address'),
('IsFill', '^\\s*$', 'Matches empty and whitespace/s'),
('IsOptional', '(.*?)', 'Matches Anything'),
('IsPositiveInt', '^\\d+$', 'Matches positive intergers'),
('IsValidDate', '^\\d{2}\\/\\d{2}\\/\\d{4}$', 'Matches format: mm/dd/yyyy');

-- --------------------------------------------------------

--
-- Table structure for table `lazy_menus`
--

CREATE TABLE IF NOT EXISTS `lazy_menus` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menus_groups_name` varchar(60) NOT NULL,
  `class_name` varchar(60) DEFAULT NULL,
  `function_name` varchar(45) DEFAULT 'SearchForm',
  `menu_class` enum('btn-default','btn-primary','btn-success','btn-info','btn-warning','btn-danger') NOT NULL,
  `menu_flag` enum('ajax','') DEFAULT 'ajax',
  `menu_name` varchar(45) NOT NULL,
  `menu_url` varchar(45) NOT NULL DEFAULT 'server.php',
  `menu_icon` varchar(25) DEFAULT NULL,
  `menu_target` enum('_self','_blank','_parent','_top','') NOT NULL DEFAULT '_self',
  `menu_attributes` varchar(80) DEFAULT NULL,
  `menu_order_number` int(11) NOT NULL,
  `menu_above_menu_code` text,
  `menu_below_menu_code` text,
  `menu_is_hidden` enum('NO','YES','','') NOT NULL DEFAULT 'NO',
  PRIMARY KEY (`menu_id`),
  KEY `menus_groups_name` (`menus_groups_name`),
  KEY `class_name` (`class_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `lazy_menus`
--

INSERT INTO `lazy_menus` (`menu_id`, `menus_groups_name`, `class_name`, `function_name`, `menu_class`, `menu_flag`, `menu_name`, `menu_url`, `menu_icon`, `menu_target`, `menu_attributes`, `menu_order_number`, `menu_above_menu_code`, `menu_below_menu_code`, `menu_is_hidden`) VALUES
(1, 'sacraments', 'parishioner', 'BtnSearchForm', 'btn-primary', 'ajax', 'Parishioner', 'server.php', 'fa-user', '_self', NULL, 1, '<h3>Sacrament Forms</h3>', '', 'NO'),
(2, 'sacraments', 'baptism', 'BtnSearchForm', 'btn-primary', 'ajax', 'Baptism', 'server.php', 'fa-book', '_self', NULL, 5, '', '', 'NO'),
(3, 'sacraments', 'communion', 'BtnSearchForm', 'btn-primary', 'ajax', 'Communion', 'server.php', 'fa-book', '_self', NULL, 10, '', '', 'NO'),
(4, 'sacraments', 'confirmation', 'BtnSearchForm', 'btn-primary', 'ajax', 'Confirmation', 'server.php', 'fa-book', '_self', NULL, 15, '', '', 'NO'),
(5, 'sacraments', 'marriage', 'BtnSearchForm', 'btn-primary', 'ajax', 'Marriage', 'server.php', 'fa-book', '_self', NULL, 20, '', '', 'NO'),
(6, 'sacraments', 'baptism', 'BtnBaptismCertificateAllInOne', 'btn-primary', 'ajax', 'Baptism Certificate All In One', 'server.php', 'fa-file-text-o', '_self', NULL, 25, '<div class="clearfix"></div><hr><h3>Certificates</h3>', NULL, 'NO'),
(7, 'sacraments', 'parish', 'BtnInsertUpdateForm', 'btn-primary', 'ajax', 'Parish Form', 'server.php', 'fa-file-text-o', '_self', NULL, 30, '<div class="clearfix"></div><hr><h3>Parish</h3>', NULL, 'NO'),
(8, 'sacraments', NULL, NULL, 'btn-primary', NULL, 'System Updater', 'updater/kickstart.php', 'fa-cloud-download', '_blank', NULL, 35, '<div class="clearfix"></div><hr><h3>System</h3>', NULL, 'NO');

-- --------------------------------------------------------

--
-- Table structure for table `lazy_menus_groups`
--

CREATE TABLE IF NOT EXISTS `lazy_menus_groups` (
  `menu_groups_name` varchar(45) NOT NULL,
  `menu_groups_is_hidden` enum('NO','YES','','') NOT NULL DEFAULT 'NO',
  PRIMARY KEY (`menu_groups_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lazy_menus_groups`
--

INSERT INTO `lazy_menus_groups` (`menu_groups_name`, `menu_groups_is_hidden`) VALUES
('sacraments', 'NO');

-- --------------------------------------------------------

--
-- Table structure for table `lazy_queries`
--

CREATE TABLE IF NOT EXISTS `lazy_queries` (
  `query_name` varchar(80) NOT NULL,
  `query_text` text NOT NULL,
  `query_comments` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`query_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lazy_queries`
--

INSERT INTO `lazy_queries` (`query_name`, `query_text`, `query_comments`) VALUES
('baptism_insert', 'insert into cbooks_baptism \r\n(\r\n baptism_id\r\n,parishioner_id\r\n,parish_id\r\n,baptism_date\r\n,baptism_godfather\r\n,baptism_godmother\r\n,baptism_book\r\n,baptism_page\r\n,baptism_number\r\n,baptism_celebrant\r\n,baptism_notes\r\n,communion_date\r\n,communion_parish\r\n,communion_city\r\n,confirmation_date\r\n,confirmation_parish\r\n,confirmation_city\r\n,marriage_couple_full_name\r\n,marriage_couple_father_full_name\r\n,marriage_couple_mother_full_name\r\n,marriage_date\r\n,marriage_parish\r\n,marriage_city\r\n,create_date\r\n,user_id\r\n) \r\nvalues \r\n(\r\n null\r\n,:parishioner_id\r\n,:parish_id\r\n,(select string_to_date(:baptism_date) as baptism_date)\r\n,:baptism_godfather\r\n,:baptism_godmother\r\n,:baptism_book\r\n,:baptism_page\r\n,:baptism_number\r\n,:baptism_celebrant\r\n,:baptism_notes\r\n,(select string_to_date(:communion_date) as communion_date)\r\n,:communion_parish\r\n,:communion_city\r\n,(select string_to_date(:confirmation_date) as confirmation_date)\r\n,:confirmation_parish\r\n,:confirmation_city\r\n,:marriage_couple_full_name\r\n,:marriage_couple_father_full_name\r\n,:marriage_couple_mother_full_name\r\n,(select string_to_date(:marriage_date) as marriage_date)\r\n,:marriage_parish\r\n,:marriage_city\r\n,now()\r\n,:user_id\r\n);', NULL),
('baptism_search', 'select \r\n\r\np.parishioner_id\r\n\r\n,concat(p.parishioner_first_name, (select if(p.parishioner_middle_name <> '''', concat('' '', p.parishioner_middle_name), '''')), '' '', p.parishioner_last_name, '' '', p.parishioner_second_last_name) as parishioner_full_name\r\n\r\n#,(select age_get(p.parishioner_birth_date)) as age\r\n\r\n,g.gender_id as gender_id\r\n\r\n,p.parishioner_birth_place\r\n\r\n,(select format_date(p.parishioner_birth_date)) as parishioner_birth_date\r\n\r\n,p.parishioner_residence\r\n\r\n,concat(p.father_first_name, (select if(p.father_middle_name<> '''', concat('' '', p.father_middle_name), '''')), '' '', p.father_last_name, '' '', p.father_second_last_name) as father_full_name\r\n\r\n,p.father_residence \r\n\r\n,concat(p.mother_first_name, (select if(p.mother_middle_name<> '''', concat('' '', p.mother_middle_name), '''')), '' '', p.mother_last_name, '' '', p.mother_second_last_name) as mother_full_name\r\n\r\n,p.mother_residence\r\n\r\n#,par.parish_name\r\n#,par.parish_city\r\n\r\n,(select format_date(b.baptism_date)) as baptism_date\r\n,b.baptism_godfather \r\n,b.baptism_godmother\r\n,b.baptism_book\r\n,b.baptism_page\r\n,b.baptism_number\r\n,b.baptism_celebrant\r\n,b.baptism_notes\r\n,(select format_date(b.communion_date)) as communion_date\r\n,b.communion_parish\r\n,b.communion_city\r\n,(select format_date(b.confirmation_date)) as confirmation_date\r\n,b.confirmation_parish\r\n,b.confirmation_city\r\n,b.marriage_couple_full_name\r\n,b.marriage_couple_father_full_name\r\n,b.marriage_couple_mother_full_name\r\n,(select format_date(b.marriage_date)) as marriage_date\r\n,b.marriage_parish\r\n,b.marriage_city\r\n#,(select format_date(b.create_date)) as create_date\r\nfrom \r\ncbooks_baptism as b\r\n,cbooks_parishioner as p\r\n#,cbooks_parish as par\r\n,cbooks_gender as g\r\nwhere\r\n1 = 1\r\n#and b.parish_id = p_parish_id\r\n#and p.parish_id = p_parish_id\r\n#and par.parish_id = p_parish_id\r\n#and par.parish_id = b.parish_id\r\nand p.parishioner_id =  b.parishioner_id\r\nand if (:parishioner_id  <> '''', p.parishioner_id = :parishioner_id and b.parishioner_id =  :parishioner_id and p.parishioner_id =  b.parishioner_id, 1=1)\r\nand if (:parishioner_first_name <> '''', parishioner_first_name = :parishioner_first_name, 1=1)\r\nand if (:parishioner_last_name <> '''', parishioner_last_name = :parishioner_last_name, 1=1)\r\nand if (:parishioner_second_last_name <> '''', parishioner_second_last_name = :parishioner_second_last_name, 1=1)\r\nand if (:parishioner_birth_date <> '''', string_to_date(:parishioner_birth_date) = parishioner_birth_date, 1=1)\r\nand p.gender_id = g.gender_id\r\norder by p.parishioner_first_name asc;\r\n', NULL),
('baptism_select', 'select \r\n\r\np.parishioner_id\r\n\r\n,concat(p.parishioner_first_name, (select if(p.parishioner_middle_name <> '''', concat('' '', p.parishioner_middle_name), '''')), '' '', p.parishioner_last_name, '' '', p.parishioner_second_last_name) as parishioner_full_name\r\n\r\n#,(select age_get(p.parishioner_birth_date)) as age\r\n\r\n,g.gender_id as gender_id\r\n\r\n,p.parishioner_birth_place\r\n\r\n,(select FORMAT_DATE(p.parishioner_birth_date)) as parishioner_birth_date\r\n\r\n,p.parishioner_residence\r\n\r\n,concat(p.father_first_name, (select if(p.father_middle_name<> '''', concat('' '', p.father_middle_name), '''')), '' '', p.father_last_name, '' '', p.father_second_last_name) as father_full_name\r\n\r\n,p.father_residence \r\n\r\n,concat(p.mother_first_name, (select if(p.mother_middle_name<> '''', concat('' '', p.mother_middle_name), '''')), '' '', p.mother_last_name, '' '', p.mother_second_last_name) as mother_full_name\r\n\r\n,p.mother_residence\r\n\r\n#,par.parish_name\r\n#,par.parish_city\r\n\r\n,(select FORMAT_DATE(b.baptism_date)) as baptism_date\r\n,b.baptism_godfather \r\n,b.baptism_godmother\r\n,b.baptism_book\r\n,b.baptism_page\r\n,b.baptism_number\r\n,b.baptism_celebrant\r\n,b.baptism_notes\r\n,(select FORMAT_DATE(b.communion_date)) as communion_date\r\n,b.communion_parish\r\n,b.communion_city\r\n,(select FORMAT_DATE(b.confirmation_date)) as confirmation_date\r\n,b.confirmation_parish\r\n,b.confirmation_city\r\n,b.marriage_couple_full_name\r\n,b.marriage_couple_father_full_name\r\n,b.marriage_couple_mother_full_name\r\n,(select FORMAT_DATE(b.marriage_date)) as marriage_date\r\n,b.marriage_parish\r\n,b.marriage_city\r\n,(select FORMAT_DATE(b.create_date)) as create_date\r\nfrom \r\ncbooks_baptism as b\r\n,cbooks_parishioner as p\r\n#,cbooks_parish as par\r\n,cbooks_gender as g\r\nwhere\r\n1 = 1\r\nand p.parishioner_id =  b.parishioner_id\r\nand p.parishioner_id = :parishioner_id \r\nand b.parishioner_id =  :parishioner_id \r\nand p.parishioner_id =  b.parishioner_id;\r\n', NULL),
('baptism_update', 'update cbooks_baptism set\r\n baptism_date = (select string_to_date(:baptism_date) as baptism_date)\r\n,baptism_godfather = :baptism_godfather\r\n,baptism_godmother = :baptism_godmother\r\n,baptism_book = :baptism_book\r\n,baptism_page = :baptism_page\r\n,baptism_number = :baptism_number\r\n,baptism_celebrant = :baptism_celebrant\r\n,baptism_notes = :baptism_notes\r\n,communion_date = (select string_to_date(:communion_date ) as communion_date)\r\n,communion_parish = :communion_parish\r\n,communion_city = :communion_city\r\n,confirmation_date = (select string_to_date(:confirmation_date) as confirmation_date)\r\n,confirmation_parish = :confirmation_parish\r\n,confirmation_city = :confirmation_city\r\n,marriage_couple_full_name = :marriage_couple_full_name\r\n,marriage_couple_father_full_name = :marriage_couple_father_full_name\r\n,marriage_couple_mother_full_name = :marriage_couple_mother_full_name\r\n,marriage_date = (select string_to_date(:marriage_date) as marriage_date)\r\n,marriage_parish = :marriage_parish\r\n,marriage_city = :marriage_city\r\n,user_id = :user_id\r\nwhere \r\nparishioner_id = :parishioner_id\r\nlimit 1;', NULL),
('civil_status_select', 'select \r\ncivil_status_id, \r\ncivil_status_name \r\nfrom \r\ncbooks_civil_status \r\norder by civil_status_id;', NULL),
('communion_insert', 'insert into cbooks_communion \r\n(\r\n communion_id\r\n,parishioner_id\r\n,parish_id\r\n,communion_date\r\n,communion_book\r\n,communion_page\r\n,communion_number\r\n,communion_celebrant\r\n,communion_notes\r\n,create_date\r\n,user_id\r\n) \r\nvalues \r\n(\r\n null\r\n,:parishioner_id\r\n,:parish_id\r\n,(select string_to_date(:communion_date) as p_communion_date)\r\n,:communion_book\r\n,:communion_page\r\n,:communion_number\r\n,:communion_celebrant\r\n,:communion_notes\r\n,now()\r\n,:user_id\r\n);', NULL),
('communion_search', 'select\r\np.parishioner_id\r\n,concat(p.parishioner_first_name, (select if(p.parishioner_middle_name <> '''', concat('' '', p.parishioner_middle_name), '''')), '' '', p.parishioner_last_name, '' '', p.parishioner_second_last_name) as parishioner_full_name\r\n\r\n#,g.gender_id as gender_id\r\n#,(select age_get(p.parishioner_birth_date)) as parishioner_age\r\n\r\n,p.parishioner_birth_place\r\n,(select format_date(p.parishioner_birth_date))  as parishioner_birth_date\r\n,p.parishioner_residence\r\n\r\n,concat(p.father_first_name, (select if(p.father_middle_name<> '''', concat('' '', p.father_middle_name), '''')), '' '', p.father_last_name, '' '', p.father_second_last_name) as father_full_name\r\n\r\n,p.father_residence\r\n\r\n,concat(p.mother_first_name, (select if(p.mother_middle_name<> '''', concat('' '', p.mother_middle_name), '''')), '' '', p.mother_last_name, '' '', p.mother_second_last_name) as mother_full_name\r\n\r\n,p.mother_residence\r\n#,par.parish_name\r\n#,par.parish_city\r\n\r\n#,p.parishioner_id\r\n#,c.parish_id\r\n,(select format_date(c.communion_date)) as communion_date\r\n,c.communion_book\r\n,c.communion_page\r\n,c.communion_number\r\n,c.communion_celebrant\r\n,c.communion_notes\r\n#,(select format_date(c.create_date)) as create_date\r\nfrom cbooks_communion as c\r\n,cbooks_parishioner as p\r\n#,cbooks_parish as par\r\n#,gender as g\r\nwhere\r\n1=1\r\n#and c.parish_id = p_parish_id\r\n#and p.parish_id = p_parish_id\r\n#and par.parish_id = p_parish_id\r\n#and par.parish_id = c.parish_id\r\nand p.parishioner_id =  c.parishioner_id\r\nand if (:parishioner_id  <> '''', p.parishioner_id = :parishioner_id and c.parishioner_id =  :parishioner_id, 1=1)\r\nand if (:parishioner_first_name <> '''', parishioner_first_name = :parishioner_first_name, 1=1)\r\nand if (:parishioner_last_name <> '''', parishioner_last_name = :parishioner_last_name, 1=1)\r\nand if (:parishioner_second_last_name <> '''', parishioner_second_last_name = :parishioner_second_last_name, 1=1)\r\nand if (:parishioner_birth_date <> '''', string_to_date(:parishioner_birth_date) = parishioner_birth_date, 1=1)\r\n#and p.gender_id = g.gender_id\r\norder by p.parishioner_first_name asc;', NULL),
('communion_select', 'select \r\np.parishioner_id\r\n,concat(p.parishioner_first_name, (select if(p.parishioner_middle_name <> '''', concat('' '', p.parishioner_middle_name), '''')), '' '', p.parishioner_last_name, '' '', p.parishioner_second_last_name) as parishioner_full_name\r\n#,(select age_get(p.parishioner_birth_date)) as parishioner_age\r\n,p.parishioner_birth_place\r\n,(select format_date(p.parishioner_birth_date))  as parishioner_birth_date\r\n,(select format_date(c.communion_date)) as communion_date\r\n,c.communion_book\r\n,c.communion_page\r\n,c.communion_number\r\n,c.communion_celebrant\r\n,c.communion_notes\r\n#,c.create_date\r\nfrom \r\n cbooks_communion as c\r\n,cbooks_parishioner as p\r\nwhere \r\n1=1\r\n#,c.parish_id = p_parish_id\r\nand p.parishioner_id = :parishioner_id\r\nand c.parishioner_id = :parishioner_id\r\nand c.parishioner_id = p.parishioner_id\r\nlimit 1;', NULL),
('communion_update', 'update cbooks_communion set\r\n communion_date = (select STRING_TO_DATE(:communion_date) as p_communion_date)\r\n,communion_page = :communion_page\r\n,communion_number = :communion_number\r\n,communion_celebrant = :communion_celebrant\r\n,communion_notes =:communion_notes\r\n,user_id = :user_id\r\nwhere \r\n1=1\r\n#parish_id = p_parish_id\r\nand parishioner_id = :parishioner_id\r\nlimit 1;', NULL),
('confirmation_insert', 'insert into cbooks_confirmation \r\n(\r\n confirmation_id\r\n,parishioner_id\r\n,parish_id\r\n,confirmation_date\r\n,confirmation_godfather_godmother\r\n,confirmation_book\r\n,confirmation_page\r\n,confirmation_number\r\n,confirmation_celebrant\r\n,confirmation_notes\r\n,user_id\r\n,create_date\r\n) \r\nvalues \r\n(\r\n null\r\n,:parishioner_id\r\n,:parish_id\r\n,(select string_to_date(:confirmation_date)  as p_confirmation_date) \r\n,:confirmation_godfather_godmother\r\n,:confirmation_book\r\n,:confirmation_page\r\n,:confirmation_number\r\n,:confirmation_celebrant\r\n,:confirmation_notes\r\n,:user_id\r\n,now()\r\n);', NULL),
('confirmation_search', 'select\r\np.parishioner_id\r\n,concat(p.parishioner_first_name, (select if(p.parishioner_middle_name <> '''', concat('' '', p.parishioner_middle_name), '''')), '' '', p.parishioner_last_name, '' '', p.parishioner_second_last_name) as parishioner_full_name\r\n\r\n#,g.gender_id as gender_id\r\n#,(select age_get(p.parishioner_birth_date)) as parishioner_age\r\n\r\n,p.parishioner_birth_place\r\n,(select format_date(p.parishioner_birth_date))  as parishioner_birth_date\r\n,p.parishioner_residence\r\n\r\n,concat(p.father_first_name, (select if(p.father_middle_name<> '''', concat('' '', p.father_middle_name), '''')), '' '', p.father_last_name, '' '', p.father_second_last_name) as father_full_name\r\n\r\n,p.father_residence\r\n\r\n,concat(p.mother_first_name, (select if(p.mother_middle_name<> '''', concat('' '', p.mother_middle_name), '''')), '' '', p.mother_last_name, '' '', p.mother_second_last_name) as mother_full_name\r\n\r\n,p.mother_residence\r\n#,par.parish_name\r\n#,par.parish_city\r\n\r\n#,c.parish_id\r\n,(select format_date(c.confirmation_date)) as confirmation_date\r\n,c.confirmation_godfather_godmother\r\n,c.confirmation_book\r\n,c.confirmation_page\r\n,c.confirmation_number\r\n,c.confirmation_celebrant\r\n,c.confirmation_notes\r\n#,(select format_date(c.create_date)) as create_date\r\nfrom \r\n cbooks_confirmation as c\r\n,cbooks_parishioner as p\r\n#,parish as par\r\n#,gender as g\r\nwhere \r\n1 = 1\r\n#and c.parish_id = p_parish_id\r\n#and p.parish_id = p_parish_id\r\n#and par.parish_id = p_parish_id\r\n#and par.parish_id = c.parish_id\r\n#and p.parishioner_id =  c.parishioner_id\r\nand if (:parishioner_id  <> '''', p.parishioner_id = :parishioner_id and c.parishioner_id =  :parishioner_id, 1=1)\r\nand if (:parishioner_first_name <> '''', parishioner_first_name = :parishioner_first_name, 1=1)\r\nand if (:parishioner_last_name <> '''', parishioner_last_name = :parishioner_last_name, 1=1)\r\nand if (:parishioner_second_last_name <> '''', parishioner_second_last_name = :parishioner_second_last_name, 1=1)\r\nand if (:parishioner_birth_date <> '''', string_to_date(:parishioner_birth_date) = parishioner_birth_date, 1=1)\r\n#and p.gender_id = g.gender_id\r\norder by p.parishioner_first_name asc;', NULL),
('confirmation_select', 'select\r\n c.confirmation_id\r\n,p.parishioner_id\r\n#,c.parish_id\r\n,concat(p.parishioner_first_name, (select if(p.parishioner_middle_name <> '''', concat('' '', p.parishioner_middle_name), '''')), '' '', p.parishioner_last_name, '' '', p.parishioner_second_last_name) as parishioner_full_name\r\n#,(select age_get(p.parishioner_birth_date)) as parishioner_age\r\n#,(select specific_age_get(p.parishioner_birth_date, confirmation_date)) as parishioner_confirmation_age\r\n,p.parishioner_birth_place\r\n,(select format_date(p.parishioner_birth_date))  as parishioner_birth_date\r\n,(select format_date(c.confirmation_date)) as confirmation_date \r\n,c.confirmation_godfather_godmother\r\n,c.confirmation_book\r\n,c.confirmation_page\r\n,c.confirmation_number\r\n,c.confirmation_celebrant\r\n,c.confirmation_notes\r\n#,c.create_date\r\nfrom cbooks_confirmation as c\r\n,cbooks_parishioner as p\r\nwhere \r\n1=1\r\n#and c.parish_id = p_parish_id\r\nand p.parishioner_id = :parishioner_id\r\nand c.parishioner_id = :parishioner_id\r\nand c.parishioner_id = p.parishioner_id;', NULL),
('confirmation_update', 'update cbooks_confirmation set\r\n confirmation_date = (select string_to_date(:confirmation_date) as p_confirmation_date) \r\n,confirmation_godfather_godmother = :confirmation_godfather_godmother\r\n,confirmation_book = :confirmation_book\r\n,confirmation_page = :confirmation_page\r\n,confirmation_number = :confirmation_number\r\n,confirmation_celebrant = :confirmation_celebrant\r\n,confirmation_notes = :confirmation_notes\r\n,user_id = :user_id\r\nwhere \r\n1=1\r\nand parishioner_id = :parishioner_id\r\n#and parish_id = p_parish_id\r\nlimit 1;', NULL),
('gender_select', 'select\ngender_id, \ngender_name \nfrom\ncbooks_gender \norder by gender_id', NULL),
('marriage_insert', 'insert into cbooks_marriage \r\n(\r\n marriage_id\r\n,parishioner_husband_id\r\n,parishioner_wife_id\r\n,parish_id\r\n,marriage_date\r\n,husband_civil_status_id\r\n,wife_civil_status_id \r\n,marriage_witness_1\r\n,marriage_witness_2\r\n,marriage_book\r\n,marriage_page\r\n,marriage_number\r\n,marriage_celebrant\r\n,marriage_notes\r\n,create_date\r\n,user_id\r\n) \r\nvalues \r\n(\r\n null\r\n,:parishioner_husband_id\r\n,:parishioner_wife_id\r\n,:parish_id\r\n,(select string_to_date(:marriage_date) as p_marriage_date)\r\n,:husband_civil_status_id\r\n,:wife_civil_status_id \r\n,:marriage_witness_1\r\n,:marriage_witness_2\r\n,:marriage_book\r\n,:marriage_page\r\n,:marriage_number\r\n,:marriage_celebrant\r\n,:marriage_notes\r\n,now()\r\n,:user_id\r\n);', NULL),
('marriage_search', 'select \r\n m.marriage_id\r\n,m.parishioner_husband_id\r\n,concat(ph.parishioner_first_name, (select if(ph.parishioner_middle_name <> '''', concat('' '', ph.parishioner_middle_name), '''')), '' '', ph.parishioner_last_name, '' '', ph.parishioner_second_last_name) as parishioner_husband_full_name\r\n#,(select age_get(ph.parishioner_birth_date)) as parishioner_husband_age\r\n,ph.parishioner_birth_place as parishioner_husband_birth_place\r\n,(select format_date(ph.parishioner_birth_date))  as parishioner_husband_birth_date\r\n#,ph.parishioner_residence as parishioner_husband_residence\r\n,m.parishioner_wife_id\r\n,concat(pw.parishioner_first_name, (select if(pw.parishioner_middle_name <> '''', concat('' '', pw.parishioner_middle_name), '''')), '' '', pw.parishioner_last_name, '' '', pw.parishioner_second_last_name) as parishioner_wife_full_name\r\n#,(select age_get(pw.parishioner_birth_date)) as parishioner_wife_age\r\n,pw.parishioner_birth_place as parishioner_wife_birth_place\r\n,(select format_date(pw.parishioner_birth_date))  as parishioner_wife_birth_date\r\n#,pw.parishioner_residence as parishioner_wife_residence\r\n#,m.parish_id\r\n,(select format_date(m.marriage_date)) as marriage_date\r\n,m.husband_civil_status_id\r\n,m.wife_civil_status_id\r\n,m.marriage_witness_1\r\n,m.marriage_witness_2\r\n,m.marriage_book\r\n,m.marriage_page\r\n,m.marriage_number\r\n,m.marriage_celebrant\r\n,m.marriage_notes\r\n#,(select format_date(m.create_date)) as create_date\r\n#,m.user_id\r\nfrom\r\n cbooks_marriage as m\r\n,cbooks_parishioner as ph\r\n,cbooks_parishioner as pw\r\nwhere\r\n1=1\r\n#and m.parish_id = p_parish_id\r\n\r\nand if (:parishioner_id  <> '''', ph.parishioner_id = :parishioner_id or pw.parishioner_id = :parishioner_id, 1=1)\r\nand if (:parishioner_first_name <> '''', ph.parishioner_first_name = :parishioner_first_name or pw.parishioner_first_name = :parishioner_first_name, 1=1)\r\nand if (:parishioner_last_name <> '''', ph.parishioner_last_name = :parishioner_last_name or pw.parishioner_last_name = :parishioner_last_name, 1=1)\r\nand if (:parishioner_second_last_name <> '''', ph.parishioner_second_last_name = :parishioner_second_last_name or pw.parishioner_second_last_name = :parishioner_second_last_name, 1=1)\r\nand if (:parishioner_birth_date <> '''', string_to_date(:parishioner_birth_date) = ph.parishioner_birth_date or string_to_date(:parishioner_birth_date) = pw.parishioner_birth_date, 1=1)\r\n\r\n\r\n\r\n\r\n#and if (:parishioner_id  <> '''', ph.parishioner_id = :parishioner_id, 1=1)\r\n#and if (:parishioner_first_name <> '''', ph.parishioner_first_name = :parishioner_first_name, 1=1)\r\n#and if (:parishioner_last_name <> '''', ph.parishioner_last_name = :parishioner_last_name, 1=1)\r\n#and if (:parishioner_second_last_name <> '''', ph.parishioner_second_last_name = :parishioner_second_last_name, 1=1)\r\n#and if (:parishioner_birth_date <> '''', string_to_date(:parishioner_birth_date) = ph.parishioner_birth_date, 1=1)\r\n\r\n#and if (:parishioner_id  <> '''', pw.parishioner_id = :parishioner_id, 1=1)\r\n#and if (:parishioner_first_name <> '''', pw.parishioner_first_name = :parishioner_first_name, 1=1)\r\n#and if (:parishioner_last_name <> '''', pw.parishioner_last_name = :parishioner_last_name, 1=1)\r\n#and if (:parishioner_second_last_name <> '''', pw.parishioner_second_last_name = :parishioner_second_last_name, 1=1)\r\n#and if (:parishioner_birth_date <> '''', string_to_date(:parishioner_birth_date) = pw.parishioner_birth_date, 1=1)\r\n\r\nand m.parishioner_husband_id = ph.parishioner_id\r\nand m.parishioner_wife_id = pw.parishioner_id\r\n\r\norder by ph.parishioner_first_name asc', NULL),
('marriage_select', 'select\r\n\r\n#m.marriage_id\r\n\r\nph.parishioner_id as parishioner_husband_id\r\n,concat(ph.parishioner_first_name, (select if(ph.parishioner_middle_name <> '''', concat('' '', ph.parishioner_middle_name), '''')), '' '', ph.parishioner_last_name, '' '', ph.parishioner_second_last_name) as parishioner_husband_full_name\r\n,(select age_get(ph.parishioner_birth_date)) as parishioner_husband_age\r\n,ph.parishioner_birth_place as parishioner_husband_birth_place\r\n,(select format_date(ph.parishioner_birth_date))  as parishioner_husband_birth_date\r\n,(select specific_age_get(ph.parishioner_birth_date, m.marriage_date)) as parishioner_husband_marriage_age\r\n,ph.parishioner_residence as parishioner_husband_residence\r\n,concat(ph.father_first_name, (select if(ph.father_middle_name <> '''', concat('' '', ph.father_middle_name), '''')), '' '', ph.father_last_name, '' '', ph.father_second_last_name) as parishioner_husband_father_full_name\r\n,concat(ph.mother_first_name, (select if(ph.mother_middle_name <> '''', concat('' '', ph.mother_middle_name), '''')), '' '', ph.mother_last_name, '' '', ph.mother_second_last_name) as parishioner_husband_mother_full_name\r\n\r\n,pw.parishioner_id as parishioner_wife_id\r\n,concat(pw.parishioner_first_name, (select if(pw.parishioner_middle_name <> '''', concat('' '', pw.parishioner_middle_name), '''')), '' '', pw.parishioner_last_name, '' '', pw.parishioner_second_last_name) as parishioner_wife_full_name\r\n,(select age_get(pw.parishioner_birth_date)) as parishioner_wife_age\r\n,pw.parishioner_birth_place as parishioner_wife_birth_place\r\n,(select format_date(pw.parishioner_birth_date))  as parishioner_wife_birth_date\r\n,(select specific_age_get(pw.parishioner_birth_date, m.marriage_date)) as parishioner_wife_marriage_age\r\n,pw.parishioner_residence as parishioner_wife_residence\r\n,concat(pw.father_first_name, (select if(pw.father_middle_name <> '''', concat('' '', pw.father_middle_name), '''')), '' '', pw.father_last_name, '' '', pw.father_second_last_name) as parishioner_wife_father_full_name\r\n,concat(pw.mother_first_name, (select if(pw.mother_middle_name <> '''', concat('' '', pw.mother_middle_name), '''')), '' '', pw.mother_last_name, '' '', pw.mother_second_last_name) as parishioner_wife_mother_full_name\r\n\r\n#,m.parish_id\r\n,(select format_date(m.marriage_date)) as marriage_date\r\n,m.husband_civil_status_id\r\n,m.wife_civil_status_id\r\n,m.marriage_witness_1\r\n,m.marriage_witness_2\r\n,m.marriage_book\r\n,m.marriage_page\r\n,m.marriage_number\r\n,m.marriage_celebrant\r\n,m.marriage_certifier\r\n,m.marriage_notes\r\n#,m.create_date\r\n#,m.user_id\r\nfrom \r\ncbooks_marriage as m\r\n,cbooks_parishioner as ph\r\n,cbooks_parishioner as pw\r\nwhere \r\n1=1\r\nand m.marriage_id = :marriage_id\r\nand m.parishioner_husband_id = ph.parishioner_id \r\nand m.parishioner_wife_id = pw.parishioner_id\r\n#and ph.parishioner_id = parishioner_husband_id\r\n#and pw.parishioner_id = parishioner_wife_id    \r\n#and m.parish_id = parish_id\r\nlimit 1;', NULL),
('marriage_select_couple_info', 'select\r\n\r\nph.parishioner_id as parishioner_husband_id\r\n,concat(ph.parishioner_first_name, (select if(ph.parishioner_middle_name <> '''', concat('' '', ph.parishioner_middle_name), '''')), '' '', ph.parishioner_last_name, '' '', ph.parishioner_second_last_name) as parishioner_husband_full_name\r\n,(select age_get(ph.parishioner_birth_date)) as parishioner_husband_age\r\n,ph.parishioner_birth_place as parishioner_husband_birth_place\r\n,(select format_date(ph.parishioner_birth_date))  as parishioner_husband_birth_date\r\n,(select specific_age_get(ph.parishioner_birth_date, now())) as parishioner_husband_marriage_age\r\n,ph.parishioner_residence as parishioner_husband_residence\r\n,concat(ph.father_first_name, (select if(ph.father_middle_name <> '''', concat('' '', ph.father_middle_name), '''')), '' '', ph.father_last_name, '' '', ph.father_second_last_name) as parishioner_husband_father_full_name\r\n,concat(ph.mother_first_name, (select if(ph.mother_middle_name <> '''', concat('' '', ph.mother_middle_name), '''')), '' '', ph.mother_last_name, '' '', ph.mother_second_last_name) as parishioner_husband_mother_full_name\r\n\r\n,pw.parishioner_id as parishioner_wife_id\r\n,concat(pw.parishioner_first_name, (select if(pw.parishioner_middle_name <> '''', concat('' '', pw.parishioner_middle_name), '''')), '' '', pw.parishioner_last_name, '' '', pw.parishioner_second_last_name) as parishioner_wife_full_name\r\n,(select age_get(pw.parishioner_birth_date)) as parishioner_wife_age\r\n,pw.parishioner_birth_place as parishioner_wife_birth_place\r\n,(select format_date(pw.parishioner_birth_date))  as parishioner_wife_birth_date\r\n,(select specific_age_get(pw.parishioner_birth_date, now())) as parishioner_wife_marriage_age\r\n,pw.parishioner_residence as parishioner_wife_residence\r\n,concat(pw.father_first_name, (select if(pw.father_middle_name <> '''', concat('' '', pw.father_middle_name), '''')), '' '', pw.father_last_name, '' '', pw.father_second_last_name) as parishioner_wife_father_full_name\r\n,concat(pw.mother_first_name, (select if(pw.mother_middle_name <> '''', concat('' '', pw.mother_middle_name), '''')), '' '', pw.mother_last_name, '' '', pw.mother_second_last_name) as parishioner_wife_mother_full_name\r\n\r\n\r\nfrom \r\ncbooks_parishioner as ph\r\n,cbooks_parishioner as pw\r\nwhere \r\n1=1\r\nand ph.parishioner_id = :parishioner_husband_id\r\nand pw.parishioner_id = :parishioner_wife_id    \r\n#and m.parish_id = p_parish_id\r\nlimit 1;', NULL),
('marriage_update', 'update cbooks_marriage set\r\n marriage_date = (select string_to_date(:marriage_date) as p_marriage_date)\r\n,husband_civil_status_id = :husband_civil_status_id\r\n,wife_civil_status_id = :wife_civil_status_id \r\n,marriage_witness_1 = :marriage_witness_1\r\n,marriage_witness_2 = :marriage_witness_2\r\n,marriage_book = :marriage_book\r\n,marriage_page = :marriage_page\r\n,marriage_number = :marriage_number\r\n,marriage_celebrant = :marriage_celebrant\r\n,marriage_notes = :marriage_notes\r\n,user_id = :user_id\r\nwhere\r\n1=1\r\nand parishioner_husband_id = :parishioner_husband_id\r\nand parishioner_wife_id = :parishioner_wife_id\r\n#and parish_id = p_parish_id\r\nlimit 1;\r\n', NULL),
('parishioner_info', 'select\r\np.parishioner_id\r\n,concat(p.parishioner_first_name, (select if(p.parishioner_middle_name <> '''', concat('' '', p.parishioner_middle_name), '''')), '' '', p.parishioner_last_name, '' '', p.parishioner_second_last_name) as parishioner_full_name\r\n,p.parishioner_birth_place\r\n,(select format_date(p.parishioner_birth_date))  as parishioner_birth_date\r\nfrom cbooks_parishioner as p\r\nwhere\r\np.parishioner_id = :parishioner_id;', NULL),
('parishioner_insert', 'insert into cbooks_parishioner\r\n(\r\n    parishioner_id, \r\n    parish_id, \r\n    parishioner_first_name, \r\n    parishioner_middle_name, \r\n    parishioner_last_name, \r\n    parishioner_second_last_name, \r\n    gender_id, \r\n    parishioner_birth_place, \r\n    parishioner_birth_date, \r\n    parishioner_residence, \r\n    father_first_name, \r\n    father_middle_name, \r\n    father_last_name, \r\n    father_second_last_name, \r\n    father_birth_place,\r\n    father_birth_date,\r\n    father_residence, \r\n    mother_first_name, \r\n    mother_middle_name, \r\n    mother_last_name, \r\n    mother_second_last_name,\r\n    mother_birth_place,\r\n    mother_birth_date,\r\n    mother_residence, \r\n    paternal_grandfather_first_name\r\n    ,paternal_grandfather_last_name\r\n    ,paternal_grandmother_first_name\r\n    ,paternal_grandmother_last_name\r\n    ,maternal_grandfather_first_name\r\n    ,maternal_grandfather_last_name\r\n    ,maternal_grandmother_first_name\r\n    ,maternal_grandmother_last_name,\r\n    physical_address, \r\n    postal_address, \r\n    email, \r\n    phone, \r\n    notes, \r\n    user_id, \r\n    create_date\r\n    ) \r\n    values\r\n    (\r\n        null, \r\n        :parish_id, \r\n        :parishioner_first_name, \r\n        :parishioner_middle_name, \r\n        :parishioner_last_name, \r\n        :parishioner_second_last_name, \r\n        :gender_id, \r\n        :parishioner_birth_place, \r\n        (select string_to_date(:parishioner_birth_date)), \r\n        :parishioner_residence, \r\n        :father_first_name, \r\n        :father_middle_name, \r\n        :father_last_name, \r\n        :father_second_last_name, \r\n        :father_birth_place,\r\n        (select string_to_date(:father_birth_date)),\r\n        :father_residence, \r\n        :mother_first_name, \r\n        :mother_middle_name, \r\n        :mother_last_name, \r\n        :mother_second_last_name, \r\n        :mother_birth_place,\r\n        (select string_to_date(:mother_birth_date)),\r\n        :mother_residence,\r\n:paternal_grandfather_first_name\r\n,:paternal_grandfather_last_name\r\n,:paternal_grandmother_first_name\r\n,:paternal_grandmother_last_name\r\n,:maternal_grandfather_first_name\r\n,:maternal_grandfather_last_name\r\n,:maternal_grandmother_first_name\r\n,:maternal_grandmother_last_name,\r\n        :physical_address, \r\n        :postal_address, \r\n        :email, \r\n        :phone, \r\n        :notes,\r\n        :user_id,\r\n        now()\r\n    )', NULL),
('parishioner_search', 'select\r\np.parishioner_id, \r\nconcat(p.parishioner_first_name, (select if(p.parishioner_middle_name <> '''', concat('' '', p.parishioner_middle_name), '''')), '' '', p.parishioner_last_name, '' '', p.parishioner_second_last_name) as parishioner_full_name,\r\ng.gender_name,\r\np.parishioner_birth_place, \r\n(select format_date(p.parishioner_birth_date)) as parishioner_birth_date,  \r\np.parishioner_residence, \r\nconcat(p.father_first_name, (select if(p.father_middle_name<> '''', concat('' '', p.father_middle_name), '''')), '' '', p.father_last_name, '' '', p.father_second_last_name) as father_full_name,\r\np.father_birth_place,\r\n(select format_date(p.father_birth_date)) as father_birth_date, \r\np.father_residence, \r\nconcat(p.mother_first_name, (select if(p.mother_middle_name<> '''', concat('' '', p.mother_middle_name), '''')), '' '', p.mother_last_name, '' '', p.mother_second_last_name) as mother_full_name,\r\np.mother_birth_place,\r\n(select format_date(p.mother_birth_date)) as mother_birth_date, \r\np.mother_residence,\r\np.paternal_grandfather_first_name\r\n,p.paternal_grandfather_last_name\r\n,p.paternal_grandmother_first_name\r\n,p.paternal_grandmother_last_name\r\n,p.maternal_grandfather_first_name\r\n,p.maternal_grandfather_last_name\r\n,p.maternal_grandmother_first_name\r\n,p.maternal_grandmother_last_name,\r\np.physical_address, \r\np.postal_address, \r\np.email, \r\np.phone,\r\np.notes\r\nfrom\r\ncbooks_parishioner as p, \r\ncbooks_gender as g \r\nwhere\r\n1=1 \r\nand p.gender_id = g.gender_id\r\nand if (:parishioner_id  <> '''', p.parishioner_id = :parishioner_id, 1=1)\r\nand if (:parishioner_first_name <> '''', p.parishioner_first_name = :parishioner_first_name, 1=1)\r\nand if (:parishioner_last_name <> '''', p.parishioner_last_name = :parishioner_last_name, 1=1)\r\nand if (:parishioner_second_last_name <> '''', p.parishioner_second_last_name = :parishioner_second_last_name, 1=1)\r\nand if (:parishioner_birth_date <> '''', p.parishioner_birth_date = string_to_date(:parishioner_birth_date), 1=1)\r\norder by p.parishioner_first_name asc;', NULL),
('parishioner_select', 'select\r\np.parishioner_id, \r\np.parishioner_first_name,\r\np.parishioner_middle_name, \r\np.parishioner_last_name, \r\np.parishioner_second_last_name, \r\ng.gender_id,\r\ng.gender_name,\r\np.parishioner_birth_place, \r\n(select format_date(p.parishioner_birth_date)) as parishioner_birth_date, \r\np.parishioner_residence, \r\np.father_first_name, \r\np.father_middle_name, \r\np.father_last_name, \r\np.father_second_last_name, \r\np.father_birth_place,\r\n(select format_date(p.father_birth_date)) as father_birth_date, \r\np.father_residence, \r\np.mother_first_name, \r\np.mother_middle_name, \r\np.mother_last_name,\r\np.mother_second_last_name, \r\np.mother_birth_place,\r\n(select format_date(p.mother_birth_date)) as mother_birth_date, \r\np.mother_residence, \r\np.paternal_grandfather_first_name\r\n,p.paternal_grandfather_last_name\r\n,p.paternal_grandmother_first_name\r\n,p.paternal_grandmother_last_name\r\n,p.maternal_grandfather_first_name\r\n,p.maternal_grandfather_last_name\r\n,p.maternal_grandmother_first_name\r\n,p.maternal_grandmother_last_name,\r\np.physical_address, \r\np.postal_address, \r\np.email, \r\np.phone,\r\np.notes\r\nfrom\r\ncbooks_parishioner as p, \r\ncbooks_gender as g \r\nwhere\r\n1=1 \r\nand p.gender_id = g.gender_id\r\nand p.parishioner_id = :parishioner_id;', NULL),
('parishioner_update', 'update cbooks_parishioner set\r\n parishioner_first_name = :parishioner_first_name\r\n,parishioner_middle_name = :parishioner_middle_name\r\n,parishioner_last_name = :parishioner_last_name\r\n,parishioner_second_last_name = :parishioner_second_last_name\r\n,gender_id = :gender_id\r\n,parishioner_birth_place = :parishioner_birth_place\r\n,parishioner_birth_date = (select string_to_date(:parishioner_birth_date) as parishioner_birth_date)\r\n,parishioner_residence = :parishioner_residence\r\n,father_first_name = :father_first_name\r\n,father_middle_name = :father_middle_name\r\n,father_last_name = :father_last_name\r\n,father_second_last_name = :father_second_last_name\r\n,father_birth_place = :father_birth_place \r\n,father_birth_date = (select string_to_date(:father_birth_date) as father_birth_date)\r\n,father_residence = :father_residence\r\n,mother_first_name = :mother_first_name\r\n,mother_middle_name = :mother_middle_name\r\n,mother_last_name = :mother_last_name\r\n,mother_second_last_name = :mother_second_last_name\r\n,mother_birth_place = :mother_birth_place \r\n,mother_birth_date = (select string_to_date(:mother_birth_date) as mother_birth_date)\r\n,mother_residence = :mother_residence\r\n,paternal_grandfather_first_name = :paternal_grandfather_first_name\r\n,paternal_grandfather_last_name = :paternal_grandfather_last_name\r\n,paternal_grandmother_first_name = :paternal_grandmother_first_name\r\n,paternal_grandmother_last_name = :paternal_grandmother_last_name\r\n,maternal_grandfather_first_name = :maternal_grandfather_first_name\r\n,maternal_grandfather_last_name = :maternal_grandfather_last_name\r\n,maternal_grandmother_first_name = :maternal_grandmother_first_name\r\n,maternal_grandmother_last_name = :maternal_grandmother_last_name\r\n,physical_address = :physical_address\r\n,postal_address = :postal_address\r\n,email = :email\r\n,phone = :phone\r\n,notes = :notes\r\n,user_id = :user_id\r\nwhere \r\n1=1\r\nand parishioner_id = :parishioner_id\r\nlimit 1;', NULL),
('parish_insert', 'insert into cbooks_parish \r\n(\r\n parish_id\r\n,diocese_id\r\n,parish_name\r\n,parish_city\r\n,parish_state\r\n,administrator_full_name\r\n,parish_email\r\n,office_hours\r\n,physical_address\r\n,postal_address\r\n,zipcode\r\n,phone\r\n,fax\r\n,create_date\r\n) \r\nvalues \r\n(\r\n :parish_id\r\n,:diocese_id\r\n,:parish_name\r\n,:parish_city\r\n,:parish_state\r\n,:administrator_full_name\r\n,:parish_email\r\n,:office_hours\r\n,:physical_address\r\n,:postal_address\r\n,:zipcode\r\n,:phone\r\n,:fax\r\n,now()\r\n);', NULL),
('parish_select_current_session', 'select \r\n parish_id\r\n,diocese_id\r\n,parish_name\r\n,parish_city\r\n,parish_state\r\n,administrator_full_name\r\n,parish_email\r\n,office_hours\r\n,physical_address\r\n,postal_address\r\n,zipcode\r\n,phone\r\n,fax\r\nfrom \r\ncbooks_parish\r\nlimit 1;', 'Selects the current only parish'),
('parish_update', 'update cbooks_parish set\r\n parish_name = :parish_name\r\n,parish_city = :parish_city\r\n,parish_state = :parish_state\r\n,administrator_full_name = :administrator_full_name\r\n,parish_email = :parish_email\r\n,office_hours = :office_hours\r\n,physical_address = :physical_address\r\n,postal_address = :postal_address\r\n,zipcode = :zipcode\r\n,phone = :phone\r\n,fax = :fax\r\nwhere \r\nparish_id = :parish_id\r\nlimit 1;', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lazy_table_views`
--

CREATE TABLE IF NOT EXISTS `lazy_table_views` (
  `table_view_name` varchar(80) NOT NULL,
  `class_name` varchar(60) NOT NULL,
  `table_name` varchar(45) NOT NULL,
  `table_column_key_name` varchar(45) NOT NULL,
  `table_action` varchar(120) NOT NULL DEFAULT 'server.php',
  `table_options` varchar(120) NOT NULL DEFAULT 'all',
  PRIMARY KEY (`table_view_name`),
  KEY `class_name` (`class_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lazy_table_views`
--

INSERT INTO `lazy_table_views` (`table_view_name`, `class_name`, `table_name`, `table_column_key_name`, `table_action`, `table_options`) VALUES
('baptism', 'baptism', 'cbooks_baptism', 'parishioner_id', 'server.php', 'edit print pdf word excel csv image'),
('communion', 'communion', 'cbooks_communion', 'parishioner_id', 'server.php', 'edit print pdf word excel csv image'),
('confirmation', 'confirmation', 'cbooks_confirmation', 'parishioner_id', 'server.php', 'edit print pdf word excel csv image'),
('marriage', 'marriage', 'cbooks_marriage', 'marriage_id', 'server.php', 'edit print pdf word excel csv image'),
('parishioner', 'parishioner', 'cbooks_parishioner', 'parishioner_id', 'server.php', 'edit print pdf word excel csv image');

-- --------------------------------------------------------

--
-- Table structure for table `lazy_table_views_columns`
--

CREATE TABLE IF NOT EXISTS `lazy_table_views_columns` (
  `table_view_columns_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `table_view_name` varchar(80) NOT NULL,
  `table_view_column_name` varchar(45) NOT NULL,
  `table_view_column_header_label` varchar(45) NOT NULL,
  `table_view_column_order_number` int(11) NOT NULL,
  `table_view_column_is_hidden` enum('NO','YES','','') NOT NULL DEFAULT 'NO',
  `column_header_text_align` enum('left','right','center','initial','inherit') DEFAULT NULL,
  `column_header_font_style` enum('normal','italic','oblique','initial','inherit') DEFAULT NULL,
  `column_header_font_weight` enum('normal','bold','bolder','lighter','100','200','300','400','500','600','700','800','900','initial','inherit') DEFAULT NULL,
  `column_header_background_color` varchar(25) DEFAULT NULL,
  `column_header_text_color` varchar(25) DEFAULT NULL,
  `rows_text_align` enum('left','right','center','justify','initial','inherit') DEFAULT NULL,
  `rows_font_style` enum('normal','italic','oblique','initial','inherit') DEFAULT NULL,
  `rows_font_weight` enum('normal','bold','bolder','lighter','100','200','300','400','500','600','700','800','900','initial','inherit') DEFAULT NULL,
  `rows_background_color` varchar(25) DEFAULT NULL,
  `rows_text_color` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`table_view_columns_id`),
  KEY `table_view_name` (`table_view_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=108 ;

--
-- Dumping data for table `lazy_table_views_columns`
--

INSERT INTO `lazy_table_views_columns` (`table_view_columns_id`, `table_view_name`, `table_view_column_name`, `table_view_column_header_label`, `table_view_column_order_number`, `table_view_column_is_hidden`, `column_header_text_align`, `column_header_font_style`, `column_header_font_weight`, `column_header_background_color`, `column_header_text_color`, `rows_text_align`, `rows_font_style`, `rows_font_weight`, `rows_background_color`, `rows_text_color`) VALUES
(1, 'parishioner', 'parishioner_id', 'Parishioner ID', 1, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'parishioner', 'parishioner_first_name', 'Parishioner First Name', 5, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'parishioner', 'parishioner_middle_name', 'Parishioner Middle Name', 10, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'parishioner', 'parishioner_last_name', 'Parishioner Last Name', 15, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'parishioner', 'parishioner_second_last_name', 'Parishioner Second Last Name', 20, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'parishioner', 'gender_name', 'Gender', 25, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'parishioner', 'parishioner_birth_place', 'Parishioner Birth Place', 30, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'parishioner', 'parishioner_birth_date', 'Parishioner Birth Date', 35, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'parishioner', 'parishioner_residence', 'Parishioner Residence', 40, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'parishioner', 'father_first_name', 'Father First Name', 45, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'parishioner', 'father_middle_name', 'Father Middle Name', 50, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'parishioner', 'father_last_name', 'Father Last Name', 55, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'parishioner', 'father_second_last_name', 'Father Second Last Name', 60, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'parishioner', 'father_residence', 'Father Residence', 65, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'parishioner', 'mother_first_name', 'Mother First Name', 70, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'parishioner', 'mother_middle_name', 'Mother Middle Name', 75, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'parishioner', 'mother_last_name', 'Mother Last Name', 80, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'parishioner', 'mother_second_last_name', 'Mother Second Last Name', 85, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'parishioner', 'mother_residence', 'Mother Residence', 86, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'parishioner', 'physical_address', 'Physical Address', 100, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 'parishioner', 'postal_address', 'Postal Address', 101, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 'parishioner', 'email', 'Email', 105, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 'parishioner', 'phone', 'Phone', 110, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 'parishioner', 'notes', 'Notes', 115, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 'baptism', 'parishioner_id', 'Parishioner ID', 1, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 'baptism', 'parishioner_full_name', 'Parishioner Full Name', 5, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 'baptism', 'baptism_date', 'Baptism Date', 10, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'baptism', 'baptism_birth_place', 'Baptism Birth Place', 15, 'YES', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'baptism', 'baptism_godfather', 'Baptism Godfather', 20, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 'baptism', 'baptism_godmother', 'Baptism Godmother', 25, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 'baptism', 'baptism_book', 'Baptism Book', 30, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 'baptism', 'baptism_page', 'Baptism Page', 35, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 'baptism', 'baptism_number', 'Baptism Number', 40, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(34, 'baptism', 'baptism_celebrant', 'Baptism Celebrant', 45, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 'baptism', 'baptism_notes', 'Baptism Notes', 100, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(37, 'parishioner', 'paternal_grandfather_first_name', 'Paternal Grandfather First Name', 91, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(38, 'parishioner', 'paternal_grandfather_last_name', 'Paternal Grandfather Last Name', 92, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(39, 'parishioner', 'paternal_grandmother_first_name', 'Paternal Grandmother First Name', 93, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(40, 'parishioner', 'paternal_grandmother_last_name', 'Paternal Grandmother Last Name', 94, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(41, 'parishioner', 'maternal_grandfather_first_name', 'Maternal Grandfather First Name', 95, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 'parishioner', 'maternal_grandfather_last_name', 'Maternal Grandfather Last Name', 96, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 'parishioner', 'maternal_grandmother_first_name', 'Maternal Grandmother First Name', 97, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 'parishioner', 'maternal_grandmother_last_name', 'Maternal Grandmother Last Name', 98, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(46, 'communion', 'parishioner_full_name', 'Parishioner Full Name', 10, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 'communion', 'father_full_name', 'Father Full Name', 50, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 'communion', 'mother_full_name', 'Mother Full Name', 75, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 'communion', 'parishioner_id', 'Parishioner ID', 1, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 'communion', 'parishioner_full_name', 'Parishioner Full Name', 5, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(51, 'communion', 'parishioner_birth_place', 'Parishioner Birth Place', 10, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(52, 'communion', 'parishioner_birth_date', 'Parishioner Birth Date', 15, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 'communion', 'communion_date', 'Communion Date', 20, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(54, 'communion', 'communion_book', 'Communion Book', 25, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 'communion', 'communion_page', 'Communion Page', 30, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 'communion', 'communion_number', 'Communion Number', 35, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(57, 'communion', 'communion_celebrant', 'Communion Celebrant', 40, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(59, 'communion', 'communion_notes', 'Communion Notes', 50, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(60, 'confirmation', 'parishioner_id', 'Parishioner ID', 1, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(61, 'confirmation', 'parishioner_full_name', 'Parishioner Full Name', 5, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(62, 'confirmation', 'parishioner_birth_place', 'Parishioner Birth Place', 10, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(63, 'confirmation', 'parishioner_birth_date', 'Parishioner Birth Date', 15, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(64, 'confirmation', 'confirmation_date', 'Confirmation Date', 20, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(65, 'confirmation', 'confirmation_godfather_godmother', 'Confirmation Godfather Godmother', 25, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(66, 'confirmation', 'confirmation_book', 'Confirmation Book', 25, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(67, 'confirmation', 'confirmation_book', 'Confirmation Book', 30, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(68, 'confirmation', 'confirmation_page', 'Confirmation Page', 35, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(69, 'confirmation', 'confirmation_number', 'Confirmation Number', 40, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(70, 'confirmation', 'confirmation_celebrant', 'Confirmation Celebrant', 45, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(72, 'confirmation', 'confirmation_notes', 'Confirmation Notes', 55, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(73, 'marriage', 'parishioner_husband_id', 'Parishioner Husband ID', 1, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(74, 'marriage', 'parishioner_husband_full_name', 'Parishioner Husband Full Name', 5, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(75, 'marriage', 'parishioner_husband_birth_date', 'Parishioner Husband Birth Date', 10, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(76, 'marriage', 'parishioner_husband_birth_place', 'Parishioner Husband Birth Place', 15, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(77, 'marriage', 'parishioner_wife_id', 'Parishioner Wife ID', 20, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(78, 'marriage', 'parishioner_wife_full_name', 'Parishioner Wife Full Name', 25, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(79, 'marriage', 'parishioner_wife_birth_date', 'Parishioner Wife Birth Date', 30, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(80, 'marriage', 'parishioner_wife_birth_place', 'Parishioner Wife Birth Place', 35, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(81, 'marriage', 'marriage_date', 'Marriage Date', 40, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(82, 'marriage', 'husband_civil_status_id', 'Husband Civil Status ID', 45, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(83, 'marriage', 'wife_civil_status_id', 'Wife Civil Status ID', 50, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(84, 'marriage', 'marriage_witness_1', 'Marriage Witness 1', 55, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(85, 'marriage', 'marriage_witness_2', 'Marriage Witness 2', 60, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(86, 'marriage', 'marriage_book', 'Marriage Book', 65, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(87, 'marriage', 'marriage_page', 'Marriage Page', 70, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(88, 'marriage', 'marriage_number', 'Marriage Number', 75, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(89, 'marriage', 'marriage_celebrant', 'Marriage Celebrant', 80, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(91, 'marriage', 'marriage_notes', 'Marriage Notes', 90, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(92, 'baptism', 'communion_date', 'Communion Date', 105, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(93, 'baptism', 'communion_parish', 'Communion Parish', 110, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(94, 'baptism', 'communion_city', 'Communion City', 115, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(95, 'baptism', 'confirmation_date', 'Confirmation Date', 120, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(96, 'baptism', 'confirmation_parish', 'Confirmation Parish', 125, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(97, 'baptism', 'confirmation_city', 'Confirmation City', 130, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(98, 'baptism', 'marriage_couple_full_name', 'Marriage Couple Fullname', 135, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(99, 'baptism', 'marriage_couple_father_full_name', 'Marriage Couple Father Fullname', 140, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(100, 'baptism', 'marriage_couple_mother_full_name', 'Marriage Couple Mother Fullname', 145, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(101, 'baptism', 'marriage_date', 'Marriage Date', 150, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(102, 'baptism', 'marriage_parish', 'Marriage Parish', 155, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(103, 'baptism', 'marriage_city', 'Marriage City', 160, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(104, 'parishioner', 'father_birth_place', 'Father Birthplace', 61, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(105, 'parishioner', 'father_birth_date', 'Father Birthdate', 62, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(106, 'parishioner', 'mother_birth_place', 'Mother Birthplace', 81, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(107, 'parishioner', 'mother_birth_date', 'Mother Birthdate', 82, 'NO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lazy_views`
--

CREATE TABLE IF NOT EXISTS `lazy_views` (
  `view_name` varchar(80) NOT NULL,
  `view_code` text NOT NULL,
  PRIMARY KEY (`view_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lazy_views`
--

INSERT INTO `lazy_views` (`view_name`, `view_code`) VALUES
('baptism_certificate_all_in_one', '<?php\r\nrequire_once "php/lazy/requestmanager.php";\r\nrequire_once "php/lazy/joomla.php";\r\n$user = JFactory::getUser();\r\nif($user->guest)\r\n   RequestManager::RequestSessionEnded();\r\nrequire_once "php/lazy/model.php";\r\n\r\nRequestManager::ScriptResponseHeader();\r\n\r\n//Buscamos el feligres\r\n$parishioner = current(Model::GetFromQuery("parishioner_select"));\r\n//Buscamos el bautismo y las referencias\r\n$baptism = current(Model::GetFromQuery("baptism_select"));\r\n\r\n//Validamos que existe\r\nif(count($parishioner) == 0 || count($baptism) == 0)\r\n{\r\n   RequestManager::RequestNoRecordFound();\r\n}\r\nelse\r\n{\r\n//Cargamos la paroquia\r\n$parish = current(Model::GetFromQuery("parish_select_current_session"));\r\n?>\r\n\r\nvar doc = new jsPDF();\r\n\r\n//Header\r\ndoc.setFontSize(18);\r\ndoc.setFontType("bold");\r\ndoc.textCenter(''Parish <?=$parish->parish_name?>'', 10);\r\n\r\ndoc.setFontSize(12);\r\ndoc.setFontType("normal");\r\ndoc.textCenter(''<?=$parish->postal_address?>'', 15);\r\ndoc.textCenter(''<?=$parish->parish_city?>, <?=$parish->parish_state?> <?=$parish->zipcode?>'', 20);\r\ndoc.textCenter(''Phone <?=$parish->phone?> Fax <?=$parish->fax?>'', 25);\r\n\r\ndoc.setFontSize(22);\r\ndoc.setFontType("bold");\r\ndoc.textCenter(''Baptism Certificate'', 40);\r\n\r\n//Body\r\ndoc.setFontSize(8);\r\ndoc.setFontType("normal");\r\ndoc.textCenter(''I the undersigned priest of this parish, certify that in the archives of the parish the following record of baptism appears'', 50);\r\n\r\n//Priest and baptism date\r\ndoc.setFontSize(10);\r\ndoc.text(''In the Parish <?=$parish->parish_name?> the date <?=$baptism->baptism_date?>, I the Reverend <?=$baptism->baptism_celebrant?>'', 10, 60);\r\n\r\n//Parishioner\r\ndoc.text(''Baptized <?=$parishioner->parishioner_first_name?> <?=$parishioner->parishioner_middle_name?> <?=$parishioner->parishioner_last_name?> <?=$parishioner->parishioner_second_last_name?> who was born in <?=$parishioner->parishioner_birth_place?> the date <?=$parishioner->parishioner_birth_date?>'', 10, 70);\r\n\r\n//Father\r\ndoc.text(''Child of Mr. <?=$parishioner->father_first_name?> <?=$parishioner->father_last_name?> <?=$parishioner->father_second_last_name?> who was born in <?=$parishioner->father_birth_place?> the date <?=$parishioner->father_birth_date?> resident of <?=$parishioner->father_residence?>'', 10, 80);\r\n\r\n//Mother\r\ndoc.text(''And child of Mrs. <?=$parishioner->mother_first_name?> <?=$parishioner->mother_last_name?> <?=$parishioner->mother_second_last_name?> who was born in <?=$parishioner->mother_birth_place?> the date <?=$parishioner->mother_birth_date?> resident of <?=$parishioner->mother_residence?>'', 10, 90);\r\n\r\n//Grandparents\r\ndoc.setFontSize(12);\r\ndoc.setFontType("bold");\r\ndoc.text(''Grandparents'', 10, 100);\r\n\r\ndoc.setFontSize(10);\r\ndoc.setFontType("normal");\r\n\r\n//Paternals\r\ndoc.text(''Paternals: <?=$parishioner->paternal_grandfather_first_name?> <?=$parishioner->paternal_grandfather_last_name?> and <?=$parishioner->paternal_grandmother_first_name?> <?=$parishioner->paternal_grandmother_last_name?>'', 10, 110);\r\n\r\n//Maternals\r\ndoc.text(''Maternals: <?=$parishioner->maternal_grandfather_first_name?> <?=$parishioner->maternal_grandfather_last_name?> and <?=$parishioner->maternal_grandmother_first_name?> <?=$parishioner->maternal_grandmother_last_name?>'', 10, 120);\r\n\r\n//Marginal notes\r\n<?php \r\n   \r\nif($baptism->communion_date == "")\r\n{\r\n?>\r\n\r\ndoc.setFontSize(12);\r\ndoc.setFontType("bold");\r\ndoc.textCenter(''Marginal Notes: No'', 130);\r\ndoc.textCenter(''________________________________________________________________________________'', 135);\r\ndoc.setFontSize(10);\r\ndoc.setFontType("normal");\r\n\r\n<?php\r\n}\r\nelse\r\n{\r\n?>\r\n\r\ndoc.setFontSize(12);\r\ndoc.setFontType("bold");\r\ndoc.textCenter(''Marginal Notes: Yes'', 130);\r\ndoc.textCenter(''__________________________________________________________________________________'', 135);\r\n\r\n<?php\r\n}\r\n?>\r\n\r\n//Communion\r\ndoc.setFontSize(12);\r\ndoc.setFontType("bold");\r\ndoc.text(''First Holy Communion'', 10, 145);\r\n\r\ndoc.setFontSize(10);\r\ndoc.setFontType("normal");\r\ndoc.text(''Date: <?=$baptism->communion_date?>'', 20, 150);\r\ndoc.text(''Church: <?=$baptism->communion_parish?> '', 20, 155);\r\ndoc.text(''Place: <?=$baptism->communion_city?>'', 20, 160);\r\n\r\n//Confirmation\r\ndoc.setFontSize(12);\r\ndoc.setFontType("bold")\r\ndoc.text(''Confirmation'', 10, 165);\r\n\r\ndoc.setFontSize(10);\r\ndoc.setFontType("normal");\r\ndoc.text(''Date: <?=$baptism->confirmation_date?>'', 20, 170);\r\ndoc.text(''Church: <?=$baptism->confirmation_parish?> '', 20, 175);\r\ndoc.text(''Place: <?=$baptism->confirmation_city?>'', 20, 180);\r\n\r\n\r\n//Marriage\r\ndoc.setFontSize(12);\r\ndoc.setFontType("bold")\r\ndoc.text(''Marriage'', 10, 185);\r\n\r\ndoc.setFontSize(10);\r\ndoc.setFontType("normal");\r\ndoc.text(''Married with: <?=$baptism->marriage_couple_full_name?>'', 20, 190);\r\ndoc.text(''Son of: <?=$baptism->marriage_couple_father_full_name?> and <?=$baptism->marriage_couple_mother_full_name?>'', 20, 195);\r\ndoc.text(''Date: <?=$baptism->confirmation_date?>'', 20, 200);\r\ndoc.text(''Church: <?=$baptism->confirmation_parish?> '', 20, 205);\r\ndoc.text(''Place: <?=$baptism->confirmation_city?>'', 20, 210);\r\n\r\n\r\n//Footer\r\ndoc.setFontSize(12);\r\ndoc.setFontType("bold")\r\ndoc.textCenter(''__________________________________________________________________________________'', 215);\r\ndoc.text(''I testify: <?=$parish->administrator_full_name?>'', 10, 225);\r\n\r\ndoc.setFontSize(8);\r\ndoc.text(''Note:'', 10, 235);\r\ndoc.text(''This information is a faithful and exact copy of the baptism books that can be found on this church.'', 10, 240);\r\n\r\ndoc.setFontSize(12);\r\ndoc.text(''Book: <?=$baptism->baptism_book?> Page: <?=$baptism->baptism_page?> Number: <?=$baptism->baptism_number?>'', 10, 250);\r\n\r\ndoc.text(''SEAL'', 35, 270);\r\n\r\ndoc.textRight(''I Give Faith: ___________________________________       '', 270);\r\n\r\ndoc.setFontSize(8);\r\ndoc.textCenter(''Warning'', 285);\r\ndoc.textCenter(''This document is not valid without the priest signature and the parish seal.'', 290);\r\ndoc.textCenter(''Any alteration or erasure voids the validity of this certification.'', 295);\r\n\r\n//Output\r\ndoc.output(''dataurlnewwindow'');\r\n\r\n<?php\r\n}\r\n?>');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lazy_forms`
--
ALTER TABLE `lazy_forms`
  ADD CONSTRAINT `class_name_fk_1` FOREIGN KEY (`class_name`) REFERENCES `lazy_classes` (`class_name`) ON UPDATE CASCADE;

--
-- Constraints for table `lazy_forms_inputs`
--
ALTER TABLE `lazy_forms_inputs`
  ADD CONSTRAINT `form_name_fk_1` FOREIGN KEY (`form_name_id`) REFERENCES `lazy_forms` (`form_name_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `input_validation_name_fk_1` FOREIGN KEY (`input_validation_name`) REFERENCES `lazy_inputs_validations` (`input_validation_name`) ON UPDATE CASCADE;

--
-- Constraints for table `lazy_menus`
--
ALTER TABLE `lazy_menus`
  ADD CONSTRAINT `class_name_fk_2` FOREIGN KEY (`class_name`) REFERENCES `lazy_classes` (`class_name`),
  ADD CONSTRAINT `menus_groups_name_fk_1` FOREIGN KEY (`menus_groups_name`) REFERENCES `lazy_menus_groups` (`menu_groups_name`);

--
-- Constraints for table `lazy_table_views`
--
ALTER TABLE `lazy_table_views`
  ADD CONSTRAINT `class_name_fk_3` FOREIGN KEY (`class_name`) REFERENCES `lazy_classes` (`class_name`) ON UPDATE CASCADE;

--
-- Constraints for table `lazy_table_views_columns`
--
ALTER TABLE `lazy_table_views_columns`
  ADD CONSTRAINT `table_view_fk_1` FOREIGN KEY (`table_view_name`) REFERENCES `lazy_table_views` (`table_view_name`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
