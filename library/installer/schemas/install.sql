-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 07, 2014 at 01:18 PM
-- Server version: 5.5.38-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dev`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth`
--

CREATE TABLE IF NOT EXISTS `auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(256) NOT NULL,
  `name` varchar(66) NOT NULL,
  `password` varchar(256) NOT NULL,
  `token` varchar(64) NOT NULL,
  `uuid` char(16) NOT NULL,
  `admin` int(1) NOT NULL,
  `disabled` int(1) NOT NULL,
  `permissions` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Table structure for table `auth`
--
INSERT INTO `auth` (`id`, `username`, `name`, `password`, `token`, `uuid`, `admin`, `disabled`, `permissions`) VALUES
(1, 'admin', 'admin', '282942cb291cc5fc15e8d42a91bcad45', '', '', 1, 0, ''),
(2, 'staff', 'staff', '63eacd4bd19d78626da0f1c366d1db3e', '', '5346788d0a8ae', 0, 0, '{"sections":{"access":"yes","dashboard":"realtime","reports":0,"graph":0,"sales":1,"invoices":1,"items":1,"stock":1,"suppliers":1,"customers":1},"apicalls":["adminconfig\/get","stats\/general","graph\/general","stock\/get","stock\/history","suppliers\/get","invoices\/get"]}');

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

CREATE TABLE IF NOT EXISTS `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(66) NOT NULL,
  `data` varchar(2048) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;


--
-- Dumping data for table `config`
--

INSERT INTO `config` (`id`, `name`, `data`) VALUES
(1, 'general', '{"dateformat":"d\\/m\\/y","curformat":"$","accntype":"cash","bizname":"Wallace IT","biznumber":"9999 999 999","bizemail":"admin@wallacepos.com","bizaddress":"1 Some St","bizsuburb":"Someville","bizstate":"NSW","bizpostcode":"2000","bizcountry":"Australia","bizlogo":"\\/assets\\/images\\/receipt-logo.png","bizicon":"\\/icon.ico","gcontact":0,"gcontacttoken":""}'),
(2, 'pos', '{"recline2":"Your business in the cloud","recline3":"an application by WallaceIT","reclogo":"\\/assets\\/images\\/receipt-logo-mono.png","recprintlogo":true,"recemaillogo":"\\/assets\\/images\\/receipt-logo.png","recfooter":"Thanks for shopping with us!","recqrcode":"https:\\/\\/wallaceit.com.au","salerange":"week","saledevice":"location","priceedit":"blank"}'),
(3, 'invoice', '{"defaultduedt":"+2 weeks","payinst":"Please contact us for payment instructions","emailmsg":"<div align=\\"left\\">Dear %name%,<br><\\/div><br>Please find the attached invoice.<br><br>Kind regards,<br>Administration"}'),
(4, 'accounting', '{"xeroenabled":0,"xerotoken":"","xeroaccnmap":""}');
-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `name` varchar(66) NOT NULL,
  `phone` varchar(66) NOT NULL,
  `mobile` varchar(66) NOT NULL,
  `address` varchar(192) NOT NULL,
  `suburb` varchar(66) NOT NULL,
  `postcode` int(5) NOT NULL,
  `state` varchar(66) NOT NULL,
  `country` varchar(66) NOT NULL,
  `notes` varchar(2048) NOT NULL,
  `googleid` varchar(1024) NOT NULL,
  `pass` varchar(512) NOT NULL,
  `token` varchar(256) NOT NULL,
  `activated` int(1) NOT NULL,
  `disabled` int(1) NOT NULL,
  `lastlogin` datetime NOT NULL,
  `dt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=127 ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_contacts`
--

CREATE TABLE IF NOT EXISTS `customer_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `position` varchar(128) NOT NULL,
  `phone` varchar(66) NOT NULL,
  `mobile` varchar(66) NOT NULL,
  `email` varchar(128) NOT NULL,
  `receivesinv` int(1) NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE IF NOT EXISTS `devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(66) NOT NULL,
  `locationid` int(11) NOT NULL,
  `dt` datetime NOT NULL,
  `disabled` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Table structure for table `device_map`
--

CREATE TABLE IF NOT EXISTS `device_map` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceid` int(11) NOT NULL,
  `uuid` char(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=37 ;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(66) NOT NULL,
  `dt` datetime NOT NULL,
  `disabled` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE IF NOT EXISTS `sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ref` varchar(128) NOT NULL,
  `type` varchar(12) NOT NULL,
  `channel` varchar(12) NOT NULL,
  `data` varchar(4096) NOT NULL,
  `userid` int(11) NOT NULL,
  `deviceid` int(11) NOT NULL,
  `locationid` int(11) NOT NULL,
  `custid` int(11) NOT NULL,
  `discount` decimal(4,0) NOT NULL,
  `rounding` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `balance` decimal(10,2) NOT NULL,
  `status` int(1) NOT NULL,
  `processdt` bigint(20) NOT NULL,
  `duedt` bigint(20) NOT NULL,
  `dt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=210 ;

-- --------------------------------------------------------

--
-- Table structure for table `sale_history`
--

CREATE TABLE IF NOT EXISTS `sale_history` (
  `id` int(11) NOT NULL,
  `saleid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `type` varchar(66) NOT NULL,
  `description` varchar(256) NOT NULL,
  `dt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE IF NOT EXISTS `sale_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleid` int(11) NOT NULL,
  `storeditemid` int(11) NOT NULL,
  `saleitemid` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `name` varchar(66) NOT NULL,
  `description` varchar(128) NOT NULL,
  `taxid` varchar(11) NOT NULL,
  `tax` decimal(12,2) NOT NULL,
  `unit` decimal(12,2) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `refundqty` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=494 ;

-- --------------------------------------------------------

--
-- Table structure for table `sale_payments`
--

CREATE TABLE IF NOT EXISTS `sale_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleid` int(11) NOT NULL,
  `method` varchar(32) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `processdt` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=195 ;

-- --------------------------------------------------------

--
-- Table structure for table `sale_voids`
--

CREATE TABLE IF NOT EXISTS `sale_voids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `deviceid` int(11) NOT NULL,
  `locationid` int(11) NOT NULL,
  `reason` varchar(1024) NOT NULL,
  `method` varchar(32) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `items` varchar(1024) NOT NULL,
  `void` int(1) NOT NULL,
  `processdt` bigint(128) NOT NULL,
  `dt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

-- --------------------------------------------------------

--
-- Table structure for table `stock_history`
--

CREATE TABLE IF NOT EXISTS `stock_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storeditemid` int(11) NOT NULL,
  `locationid` int(11) NOT NULL,
  `auxid` int(11) NOT NULL,
  `auxdir` int(1) NOT NULL,
  `type` varchar(66) NOT NULL,
  `amount` int(11) NOT NULL,
  `dt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_2` (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `stock_levels`
--

CREATE TABLE IF NOT EXISTS `stock_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storeditemid` int(11) NOT NULL,
  `locationid` int(11) NOT NULL,
  `stocklevel` int(11) NOT NULL,
  `dt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `stored_items`
--

CREATE TABLE IF NOT EXISTS `stored_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplierid` int(11) NOT NULL,
  `code` varchar(256) NOT NULL,
  `qty` int(11) NOT NULL,
  `name` varchar(66) NOT NULL,
  `description` varchar(128) NOT NULL,
  `taxid` varchar(11) NOT NULL,
  `price` varchar(66) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `supplierid` (`supplierid`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Table structure for table `stored_suppliers`
--

CREATE TABLE IF NOT EXISTS `stored_suppliers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(66) NOT NULL,
  `dt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_items`
--

CREATE TABLE IF NOT EXISTS `tax_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(66) NOT NULL,
  `value` decimal(8,0) NOT NULL,
  `calcfunc` varchar(66) NOT NULL,
  `divisor` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tax_items`
--

INSERT INTO `tax_items` (`id`, `name`, `value`, `calcfunc`, `divisor`) VALUES
(1, 'No Tax', 0, 'function(total){ return 0; }', 0),
(2, 'GST', 10, 'function(total){ return (total/11); }', 11);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;