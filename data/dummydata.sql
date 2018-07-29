-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 28. Jul 2018 um 13:59
-- Server-Version: 10.1.34-MariaDB
-- PHP-Version: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `characters`
--
CREATE DATABASE IF NOT EXISTS `characters` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `characters`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `account_instances_entered`
--

DROP TABLE IF EXISTS `account_instances_entered`;
CREATE TABLE `account_instances_entered` (
  `AccountId` int(11) UNSIGNED NOT NULL COMMENT 'Player account',
  `ExpireTime` bigint(40) NOT NULL COMMENT 'Time when instance was entered',
  `InstanceId` int(11) UNSIGNED NOT NULL COMMENT 'ID of instance entered'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Instance reset limit system' ROW_FORMAT=COMPACT;

--
-- Daten für Tabelle `account_instances_entered`
--

INSERT INTO `account_instances_entered` (`AccountId`, `ExpireTime`, `InstanceId`) VALUES
(6, 1532785320, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `arena_team`
--

DROP TABLE IF EXISTS `arena_team`;
CREATE TABLE `arena_team` (
  `arenateamid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` char(255) NOT NULL,
  `captainguid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `BackgroundColor` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `EmblemStyle` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `EmblemColor` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `BorderStyle` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `BorderColor` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `arena_team_member`
--

DROP TABLE IF EXISTS `arena_team_member`;
CREATE TABLE `arena_team_member` (
  `arenateamid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `guid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `played_week` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `wons_week` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `played_season` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `wons_season` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `personal_rating` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `arena_team_stats`
--

DROP TABLE IF EXISTS `arena_team_stats`;
CREATE TABLE `arena_team_stats` (
  `arenateamid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `rating` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `games_week` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `wins_week` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `games_season` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `wins_season` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `rank` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `auction`
--

DROP TABLE IF EXISTS `auction`;
CREATE TABLE `auction` (
  `id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `houseid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `itemguid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `item_template` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Item Identifier',
  `item_count` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `item_randompropertyid` int(11) NOT NULL DEFAULT '0',
  `itemowner` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `buyoutprice` int(11) NOT NULL DEFAULT '0',
  `time` bigint(40) UNSIGNED NOT NULL DEFAULT '0',
  `buyguid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `lastbid` int(11) NOT NULL DEFAULT '0',
  `startbid` int(11) NOT NULL DEFAULT '0',
  `deposit` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bugreport`
--

DROP TABLE IF EXISTS `bugreport`;
CREATE TABLE `bugreport` (
  `id` int(11) NOT NULL COMMENT 'Identifier',
  `type` longtext NOT NULL,
  `content` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Debug System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `characters`
--

DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `account` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Account Identifier',
  `name` varchar(12) NOT NULL DEFAULT '',
  `race` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `class` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `gender` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `level` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `xp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `money` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `playerBytes` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `playerBytes2` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `playerFlags` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `map` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `dungeon_difficulty` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `taximask` longtext,
  `online` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `cinematic` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `totaltime` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `leveltime` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `logout_time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `is_logout_resting` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `rest_bonus` float NOT NULL DEFAULT '0',
  `resettalents_cost` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `resettalents_time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `trans_x` float NOT NULL DEFAULT '0',
  `trans_y` float NOT NULL DEFAULT '0',
  `trans_z` float NOT NULL DEFAULT '0',
  `trans_o` float NOT NULL DEFAULT '0',
  `transguid` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `extra_flags` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `stable_slots` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `at_login` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `zone` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `death_expire_time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `taxi_path` text,
  `arenaPoints` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `totalHonorPoints` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `todayHonorPoints` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `yesterdayHonorPoints` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `totalKills` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `todayKills` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `yesterdayKills` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `chosenTitle` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `watchedFaction` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `drunk` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `health` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `power1` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `power2` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `power3` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `power4` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `power5` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `exploredZones` longtext,
  `equipmentCache` longtext,
  `ammoId` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `knownTitles` longtext,
  `actionBars` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `deleteInfos_Account` int(11) UNSIGNED DEFAULT NULL,
  `deleteInfos_Name` varchar(12) DEFAULT NULL,
  `deleteDate` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `characters`
--

INSERT INTO `characters` (`guid`, `account`, `name`, `race`, `class`, `gender`, `level`, `xp`, `money`, `playerBytes`, `playerBytes2`, `playerFlags`, `position_x`, `position_y`, `position_z`, `map`, `dungeon_difficulty`, `orientation`, `taximask`, `online`, `cinematic`, `totaltime`, `leveltime`, `logout_time`, `is_logout_resting`, `rest_bonus`, `resettalents_cost`, `resettalents_time`, `trans_x`, `trans_y`, `trans_z`, `trans_o`, `transguid`, `extra_flags`, `stable_slots`, `at_login`, `zone`, `death_expire_time`, `taxi_path`, `arenaPoints`, `totalHonorPoints`, `todayHonorPoints`, `yesterdayHonorPoints`, `totalKills`, `todayKills`, `yesterdayKills`, `chosenTitle`, `watchedFaction`, `drunk`, `health`, `power1`, `power2`, `power3`, `power4`, `power5`, `exploredZones`, `equipmentCache`, `ammoId`, `knownTitles`, `actionBars`, `deleteInfos_Account`, `deleteInfos_Name`, `deleteDate`) VALUES
(3, 5, 'Lead', 4, 1, 1, 31, 0, 99988970, 514, 16777225, 34, -8873.3, 645.046, 96.0634, 0, 0, 5.86727, '100663296 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 3857, 1645, 1532782271, 1, 59.9055, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 841, 0, 0, 0, 100, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 131072 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 6120 0 0 0 0 0 6121 0 6122 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 0 2362 0 0 0 0 0 ', 0, '2 0 ', 0, NULL, NULL, NULL),
(4, 6, 'Admin', 4, 1, 1, 70, 0, 7191656, 84017158, 33554436, 40, -8829.1, 629.56, 94.1037, 0, 0, 2.18689, '100663296 0 0 8 0 0 1048576 0 0 0 0 0 0 0 0 0 ', 0, 1, 3796, 1749, 1532782265, 1, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 39, 4294967295, 0, 10934, 0, 0, 0, 100, 0, '1 0 0 256 4 0 0 0 0 0 0 0 0 0 0 0 0 131072 0 0 2 65536 0 0 0 0 0 0 0 0 524288 0 0 536870912 0 0 0 0 0 0 0 32768 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '30974 0 25438 0 30980 0 6120 0 30976 0 34547 0 24803 0 34568 0 34442 0 30970 0 0 0 0 0 34162 0 0 0 5444 0 28749 0 32375 0 15807 0 0 0 ', 3030, '3074 128 ', 0, NULL, NULL, NULL),
(5, 11, 'Memberone', 4, 11, 1, 11, 0, 9970, 50726406, 16777217, 34, -8874.64, 648.594, 96.0245, 0, 0, 2.96449, '100663296 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 2986, 1640, 1532782272, 1, 13.0411, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 224, 380, 0, 0, 100, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 131072 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 0 0 6123 0 0 0 6124 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3661 0 0 0 0 0 0 0 ', 0, '0 0 ', 0, NULL, NULL, NULL),
(6, 8, 'Membertwo', 1, 1, 1, 1, 55, 0, 134283269, 33554437, 32, -8891.13, 616.858, 95.2583, 0, 0, 6.23214, '2 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 32, 32, 1532779786, 1, 0.00798611, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 60, 0, 0, 0, 100, 0, '0 0 0 536870912 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 38 0 0 0 0 0 39 0 40 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 0 2362 0 0 0 0 0 ', 0, '0 0 ', 0, NULL, NULL, NULL),
(7, 9, 'Memberthree', 3, 2, 1, 1, 55, 0, 134742790, 33554432, 32, -8891.14, 616.872, 95.258, 0, 0, 5.73848, '32 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 16, 16, 1532779828, 1, 0.00434028, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 98, 79, 0, 0, 100, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 6117 0 0 0 0 0 6118 0 43 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2361 0 0 0 0 0 0 0 ', 0, '0 0 ', 0, NULL, NULL, NULL),
(8, 12, 'Memberfour', 7, 4, 0, 1, 55, 0, 33882880, 33554437, 32, -8891.25, 617.786, 95.2583, 0, 0, 5.44438, '32 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 23, 23, 1532779910, 1, 0.00425347, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 45, 0, 0, 0, 100, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 49 0 0 0 0 0 48 0 47 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2092 0 0 0 28979 0 0 0 ', 0, '0 0 ', 0, NULL, NULL, NULL),
(9, 13, 'Memberfive', 7, 8, 1, 1, 55, 0, 67306755, 33554436, 32, -8891.51, 617.254, 95.2582, 0, 0, 5.75811, '32 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 52, 52, 1532779991, 1, 0.0181424, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 51, 240, 0, 0, 100, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 6096 0 56 0 0 0 1395 0 55 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 0 0 0 0 0 0 0 ', 0, '0 0 ', 0, NULL, NULL, NULL),
(10, 14, 'Membersix', 11, 3, 1, 1, 55, 0, 67765510, 33554436, 32, -8892.25, 615.947, 95.2579, 0, 0, 6.13117, '0 0 536870912 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 19, 19, 1532780132, 1, 0.00434028, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 66, 100, 0, 0, 100, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 23345 0 0 0 0 0 23344 0 23348 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 0 0 0 23347 0 0 0 ', 2512, '0 0 ', 0, NULL, NULL, NULL),
(11, 15, 'Membereight', 11, 7, 0, 1, 55, 0, 33816834, 33554433, 32, -8892.31, 617.484, 95.2582, 0, 0, 0.404056, '0 0 536870912 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 11, 11, 1532780172, 1, 0.00416667, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 57, 135, 0, 0, 100, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 23345 0 0 0 0 0 23344 0 23348 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 36 0 0 0 0 0 0 0 ', 0, '0 0 ', 0, NULL, NULL, NULL),
(12, 16, 'Memberseven', 4, 11, 0, 1, 55, 0, 117704448, 33554432, 32, -8890.94, 617.046, 95.2575, 0, 0, 6.10369, '100663296 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 14, 14, 1532780211, 1, 0.00416667, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 63, 110, 0, 0, 100, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 0 0 6123 0 0 0 6124 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3661 0 0 0 0 0 0 0 ', 0, '0 0 ', 0, NULL, NULL, NULL),
(13, 17, 'Membernine', 1, 5, 0, 1, 55, 0, 100664070, 33554440, 32, -8891.08, 616.955, 95.2583, 0, 0, 5.82487, '2 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 ', 0, 1, 22, 22, 1532780269, 1, 0.0078125, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 1519, 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 4294967295, 0, 72, 123, 0, 0, 100, 0, '0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 65536 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ', '0 0 0 0 0 0 53 0 6098 0 0 0 52 0 51 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 36 0 0 0 0 0 0 0 ', 0, '0 0 ', 0, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_action`
--

DROP TABLE IF EXISTS `character_action`;
CREATE TABLE `character_action` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `button` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `action` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `type` tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_action`
--

INSERT INTO `character_action` (`guid`, `button`, `action`, `type`) VALUES
(3, 72, 6603, 0),
(3, 73, 78, 0),
(3, 74, 20580, 0),
(3, 83, 117, 128),
(4, 72, 6603, 0),
(4, 73, 1, 64),
(4, 74, 20580, 0),
(4, 83, 117, 128),
(5, 0, 6603, 0),
(5, 1, 5176, 0),
(5, 2, 5185, 0),
(5, 3, 20580, 0),
(5, 10, 159, 128),
(5, 11, 4536, 128),
(6, 72, 6603, 0),
(6, 73, 78, 0),
(6, 83, 117, 128),
(7, 0, 6603, 0),
(7, 1, 21084, 0),
(7, 2, 635, 0),
(7, 10, 159, 128),
(7, 11, 4540, 128),
(8, 0, 6603, 0),
(8, 1, 1752, 0),
(8, 2, 2098, 0),
(8, 3, 2764, 0),
(8, 11, 117, 128),
(9, 0, 6603, 0),
(9, 1, 133, 0),
(9, 2, 168, 0),
(9, 10, 159, 128),
(9, 11, 4536, 128),
(10, 0, 6603, 0),
(10, 1, 2973, 0),
(10, 2, 75, 0),
(10, 3, 28880, 0),
(10, 10, 159, 128),
(10, 11, 4540, 128),
(10, 72, 6603, 0),
(10, 73, 2973, 0),
(10, 74, 75, 0),
(10, 82, 159, 128),
(10, 83, 4540, 128),
(11, 0, 6603, 0),
(11, 1, 403, 0),
(11, 2, 331, 0),
(11, 3, 28880, 0),
(11, 10, 159, 128),
(11, 11, 4540, 128),
(12, 0, 6603, 0),
(12, 1, 5176, 0),
(12, 2, 5185, 0),
(12, 3, 20580, 0),
(12, 10, 159, 128),
(12, 11, 4536, 128),
(13, 0, 6603, 0),
(13, 1, 585, 0),
(13, 2, 2050, 0),
(13, 10, 159, 128),
(13, 11, 2070, 128);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_aura`
--

DROP TABLE IF EXISTS `character_aura`;
CREATE TABLE `character_aura` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `caster_guid` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Full Global Unique Identifier',
  `item_guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `spell` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `stackcount` int(11) UNSIGNED NOT NULL DEFAULT '1',
  `remaincharges` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `basepoints0` int(11) NOT NULL DEFAULT '0',
  `basepoints1` int(11) NOT NULL DEFAULT '0',
  `basepoints2` int(11) NOT NULL DEFAULT '0',
  `periodictime0` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `periodictime1` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `periodictime2` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `maxduration` int(11) NOT NULL DEFAULT '0',
  `remaintime` int(11) NOT NULL DEFAULT '0',
  `effIndexMask` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_aura`
--

INSERT INTO `character_aura` (`guid`, `caster_guid`, `item_guid`, `spell`, `stackcount`, `remaincharges`, `basepoints0`, `basepoints1`, `basepoints2`, `periodictime0`, `periodictime1`, `periodictime2`, `maxduration`, `remaintime`, `effIndexMask`) VALUES
(3, 3, 0, 2457, 1, 0, 0, 0, 0, 0, 0, 0, -1, -1, 1),
(4, 4, 0, 2457, 1, 0, 0, 0, 0, 0, 0, 0, -1, -1, 1),
(6, 6, 0, 2457, 1, 0, 0, 0, 0, 0, 0, 0, -1, -1, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_battleground_data`
--

DROP TABLE IF EXISTS `character_battleground_data`;
CREATE TABLE `character_battleground_data` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `instance_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `team` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `join_x` float NOT NULL DEFAULT '0',
  `join_y` float NOT NULL DEFAULT '0',
  `join_z` float NOT NULL DEFAULT '0',
  `join_o` float NOT NULL DEFAULT '0',
  `join_map` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_db_version`
--

DROP TABLE IF EXISTS `character_db_version`;
CREATE TABLE `character_db_version` (
  `required_s2376_01_characters_taxi_system_format_update` bit(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Last applied sql update to DB' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_db_version`
--

INSERT INTO `character_db_version` (`required_s2376_01_characters_taxi_system_format_update`) VALUES
(NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_declinedname`
--

DROP TABLE IF EXISTS `character_declinedname`;
CREATE TABLE `character_declinedname` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `genitive` varchar(15) NOT NULL DEFAULT '',
  `dative` varchar(15) NOT NULL DEFAULT '',
  `accusative` varchar(15) NOT NULL DEFAULT '',
  `instrumental` varchar(15) NOT NULL DEFAULT '',
  `prepositional` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_gifts`
--

DROP TABLE IF EXISTS `character_gifts`;
CREATE TABLE `character_gifts` (
  `guid` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `item_guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `entry` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `flags` int(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_homebind`
--

DROP TABLE IF EXISTS `character_homebind`;
CREATE TABLE `character_homebind` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `map` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `zone` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Zone Identifier',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_homebind`
--

INSERT INTO `character_homebind` (`guid`, `map`, `zone`, `position_x`, `position_y`, `position_z`) VALUES
(3, 1, 141, 10311.3, 831.463, 1326.41),
(4, 1, 141, 10311.3, 831.463, 1326.41),
(5, 1, 141, 10311.3, 831.463, 1326.41),
(6, 0, 12, -8949.95, -132.493, 83.5312),
(7, 0, 1, -6240.32, 331.033, 382.758),
(8, 0, 1, -6240, 331, 383),
(9, 0, 1, -6240, 331, 383),
(10, 530, 3526, -3961.64, -13931.2, 100.615),
(11, 530, 3526, -3961.64, -13931.2, 100.615),
(12, 1, 141, 10311.3, 831.463, 1326.41),
(13, 0, 12, -8949.95, -132.493, 83.5312);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_instance`
--

DROP TABLE IF EXISTS `character_instance`;
CREATE TABLE `character_instance` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `instance` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `permanent` tinyint(1) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `character_instance`
--

INSERT INTO `character_instance` (`guid`, `instance`, `permanent`) VALUES
(4, 2, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_inventory`
--

DROP TABLE IF EXISTS `character_inventory`;
CREATE TABLE `character_inventory` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `bag` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `slot` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `item` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Item Global Unique Identifier',
  `item_template` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Item Identifier'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_inventory`
--

INSERT INTO `character_inventory` (`guid`, `bag`, `slot`, `item`, `item_template`) VALUES
(3, 0, 15, 22, 25),
(3, 0, 3, 24, 6120),
(3, 0, 6, 26, 6121),
(3, 0, 7, 28, 6122),
(3, 0, 16, 30, 2362),
(3, 0, 23, 32, 117),
(3, 0, 24, 34, 6948),
(4, 0, 26, 36, 25),
(4, 0, 3, 38, 6120),
(4, 0, 25, 44, 2362),
(4, 0, 23, 46, 117),
(4, 0, 24, 48, 6948),
(5, 0, 15, 50, 3661),
(5, 0, 4, 52, 6123),
(5, 0, 6, 54, 6124),
(5, 0, 23, 56, 159),
(5, 0, 24, 58, 4536),
(5, 0, 25, 60, 6948),
(6, 0, 3, 63, 38),
(6, 0, 6, 65, 39),
(6, 0, 7, 67, 40),
(6, 0, 15, 69, 25),
(6, 0, 16, 71, 2362),
(6, 0, 23, 73, 117),
(6, 0, 24, 75, 6948),
(7, 0, 3, 77, 6117),
(7, 0, 6, 79, 6118),
(7, 0, 7, 81, 43),
(7, 0, 15, 83, 2361),
(7, 0, 23, 85, 4540),
(7, 0, 24, 87, 159),
(7, 0, 25, 89, 6948),
(8, 0, 3, 91, 49),
(8, 0, 6, 93, 48),
(8, 0, 7, 95, 47),
(8, 0, 15, 97, 2092),
(8, 0, 17, 99, 28979),
(8, 0, 23, 101, 117),
(8, 0, 24, 103, 6948),
(9, 0, 4, 105, 56),
(9, 0, 6, 107, 1395),
(9, 0, 3, 109, 6096),
(9, 0, 7, 111, 55),
(9, 0, 15, 113, 35),
(9, 0, 23, 115, 4536),
(9, 0, 24, 117, 159),
(9, 0, 25, 119, 6948),
(10, 0, 3, 121, 23345),
(10, 0, 6, 123, 23344),
(10, 0, 15, 125, 25),
(10, 0, 7, 127, 23348),
(10, 0, 23, 129, 6948),
(10, 0, 24, 131, 4540),
(10, 0, 25, 133, 159),
(10, 0, 17, 135, 23347),
(10, 0, 19, 137, 2101),
(10, 137, 0, 139, 2512),
(11, 0, 3, 141, 23345),
(11, 0, 6, 143, 23344),
(11, 0, 7, 145, 23348),
(11, 0, 23, 147, 6948),
(11, 0, 15, 149, 36),
(11, 0, 24, 151, 4540),
(11, 0, 25, 153, 159),
(12, 0, 15, 155, 3661),
(12, 0, 4, 157, 6123),
(12, 0, 6, 159, 6124),
(12, 0, 23, 161, 159),
(12, 0, 24, 163, 4536),
(12, 0, 25, 165, 6948),
(13, 0, 4, 167, 6098),
(13, 0, 6, 169, 52),
(13, 0, 3, 171, 53),
(13, 0, 7, 173, 51),
(13, 0, 15, 175, 36),
(13, 0, 23, 177, 159),
(13, 0, 24, 179, 2070),
(13, 0, 25, 181, 6948),
(4, 0, 9, 182, 30970),
(4, 0, 0, 183, 30974),
(4, 0, 4, 184, 30976),
(4, 0, 2, 186, 30980),
(4, 0, 8, 187, 34442),
(4, 0, 5, 188, 34547),
(4, 0, 7, 189, 34568),
(4, 0, 16, 190, 32375),
(4, 0, 15, 191, 28749),
(4, 0, 12, 193, 34162),
(4, 0, 28, 194, 29384),
(4, 0, 14, 195, 5444),
(4, 0, 29, 197, 5114),
(4, 0, 30, 198, 6716),
(4, 0, 32, 200, 1181),
(4, 0, 33, 201, 2592),
(4, 0, 34, 202, 5124),
(4, 0, 35, 203, 5404),
(4, 0, 36, 204, 1179),
(4, 0, 37, 205, 25265),
(4, 0, 38, 206, 25409),
(4, 0, 27, 207, 21882),
(4, 0, 6, 208, 24803),
(4, 0, 17, 209, 15807),
(4, 0, 22, 211, 2101),
(4, 211, 2, 212, 3030),
(4, 0, 1, 213, 25438);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_pet`
--

DROP TABLE IF EXISTS `character_pet`;
CREATE TABLE `character_pet` (
  `id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `entry` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `owner` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `modelid` int(11) UNSIGNED DEFAULT '0',
  `CreatedBySpell` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `PetType` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `level` int(11) UNSIGNED NOT NULL DEFAULT '1',
  `exp` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `Reactstate` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `loyaltypoints` int(11) NOT NULL DEFAULT '0',
  `loyalty` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `xpForNextLoyalty` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `trainpoint` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT 'Pet',
  `renamed` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `slot` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `curhealth` int(11) UNSIGNED NOT NULL DEFAULT '1',
  `curmana` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `curhappiness` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `savetime` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `resettalents_cost` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `resettalents_time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `abdata` longtext,
  `teachspelldata` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pet System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_pet_declinedname`
--

DROP TABLE IF EXISTS `character_pet_declinedname`;
CREATE TABLE `character_pet_declinedname` (
  `id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `owner` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `genitive` varchar(12) NOT NULL DEFAULT '',
  `dative` varchar(12) NOT NULL DEFAULT '',
  `accusative` varchar(12) NOT NULL DEFAULT '',
  `instrumental` varchar(12) NOT NULL DEFAULT '',
  `prepositional` varchar(12) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_queststatus`
--

DROP TABLE IF EXISTS `character_queststatus`;
CREATE TABLE `character_queststatus` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  `status` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `rewarded` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `explored` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `timer` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `mobcount1` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `mobcount2` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `mobcount3` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `mobcount4` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `itemcount1` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `itemcount2` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `itemcount3` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `itemcount4` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_queststatus_daily`
--

DROP TABLE IF EXISTS `character_queststatus_daily`;
CREATE TABLE `character_queststatus_daily` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quest Identifier'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_queststatus_monthly`
--

DROP TABLE IF EXISTS `character_queststatus_monthly`;
CREATE TABLE `character_queststatus_monthly` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quest Identifier'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_queststatus_weekly`
--

DROP TABLE IF EXISTS `character_queststatus_weekly`;
CREATE TABLE `character_queststatus_weekly` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Quest Identifier'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_reputation`
--

DROP TABLE IF EXISTS `character_reputation`;
CREATE TABLE `character_reputation` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `faction` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `standing` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_reputation`
--

INSERT INTO `character_reputation` (`guid`, `faction`, `standing`, `flags`) VALUES
(3, 21, 0, 0),
(3, 46, 0, 4),
(3, 47, 0, 17),
(3, 54, 0, 17),
(3, 59, 0, 16),
(3, 67, 0, 14),
(3, 68, 0, 6),
(3, 69, 0, 17),
(3, 70, 0, 2),
(3, 72, 0, 17),
(3, 76, 0, 6),
(3, 81, 0, 6),
(3, 83, 0, 4),
(3, 86, 0, 4),
(3, 87, 0, 2),
(3, 92, 0, 2),
(3, 93, 0, 2),
(3, 169, 0, 8),
(3, 270, 0, 16),
(3, 289, 0, 4),
(3, 349, 0, 0),
(3, 369, 0, 0),
(3, 469, 0, 25),
(3, 470, 0, 0),
(3, 471, 0, 20),
(3, 509, 0, 16),
(3, 510, 0, 2),
(3, 529, 0, 0),
(3, 530, 0, 6),
(3, 549, 0, 4),
(3, 550, 0, 4),
(3, 551, 0, 4),
(3, 569, 0, 4),
(3, 570, 0, 4),
(3, 571, 0, 4),
(3, 574, 0, 4),
(3, 576, 0, 2),
(3, 577, 0, 0),
(3, 589, 0, 0),
(3, 609, 0, 0),
(3, 729, 0, 2),
(3, 730, 0, 16),
(3, 749, 0, 0),
(3, 809, 0, 16),
(3, 889, 0, 6),
(3, 890, 0, 16),
(3, 891, 0, 24),
(3, 892, 0, 14),
(3, 909, 0, 16),
(3, 910, 0, 2),
(3, 911, 0, 6),
(3, 922, 0, 6),
(3, 930, 0, 17),
(3, 932, 0, 80),
(3, 933, 0, 16),
(3, 934, 0, 80),
(3, 935, 0, 16),
(3, 936, 0, 28),
(3, 941, 0, 6),
(3, 942, 0, 16),
(3, 946, 0, 16),
(3, 947, 0, 2),
(3, 967, 0, 16),
(3, 970, 0, 0),
(3, 978, 0, 16),
(3, 980, 0, 8),
(3, 989, 0, 16),
(3, 990, 0, 16),
(3, 1005, 0, 4),
(3, 1011, 0, 16),
(3, 1012, 0, 16),
(3, 1015, 0, 2),
(3, 1031, 0, 16),
(3, 1038, 0, 16),
(3, 1077, 0, 16),
(4, 21, 0, 0),
(4, 46, 0, 4),
(4, 47, 0, 17),
(4, 54, 0, 17),
(4, 59, 0, 16),
(4, 67, 0, 14),
(4, 68, 0, 6),
(4, 69, 0, 17),
(4, 70, 0, 2),
(4, 72, 0, 17),
(4, 76, 0, 6),
(4, 81, 0, 6),
(4, 83, 0, 4),
(4, 86, 0, 4),
(4, 87, 0, 2),
(4, 92, 0, 2),
(4, 93, 0, 2),
(4, 169, 0, 8),
(4, 270, 0, 16),
(4, 289, 0, 4),
(4, 349, 0, 0),
(4, 369, 0, 0),
(4, 469, 0, 25),
(4, 470, 0, 0),
(4, 471, 0, 20),
(4, 509, 0, 16),
(4, 510, 0, 2),
(4, 529, 0, 0),
(4, 530, 0, 6),
(4, 549, 0, 4),
(4, 550, 0, 4),
(4, 551, 0, 4),
(4, 569, 0, 4),
(4, 570, 0, 4),
(4, 571, 0, 4),
(4, 574, 0, 4),
(4, 576, 0, 2),
(4, 577, 0, 0),
(4, 589, 0, 0),
(4, 609, 0, 0),
(4, 729, 0, 2),
(4, 730, 0, 16),
(4, 749, 0, 0),
(4, 809, 0, 16),
(4, 889, 0, 6),
(4, 890, 0, 16),
(4, 891, 0, 24),
(4, 892, 0, 14),
(4, 909, 0, 16),
(4, 910, 0, 2),
(4, 911, 0, 6),
(4, 922, 0, 6),
(4, 930, 0, 17),
(4, 932, 0, 80),
(4, 933, 0, 16),
(4, 934, 0, 80),
(4, 935, 0, 17),
(4, 936, 0, 28),
(4, 941, 0, 6),
(4, 942, 0, 16),
(4, 946, 0, 16),
(4, 947, 0, 2),
(4, 967, 165, 17),
(4, 970, 0, 0),
(4, 978, 0, 16),
(4, 980, 0, 8),
(4, 989, 0, 16),
(4, 990, 0, 16),
(4, 1005, 0, 4),
(4, 1011, 0, 16),
(4, 1012, 0, 16),
(4, 1015, 0, 2),
(4, 1031, 0, 16),
(4, 1038, 0, 16),
(4, 1077, 0, 16),
(5, 21, 0, 0),
(5, 46, 0, 4),
(5, 47, 0, 17),
(5, 54, 0, 17),
(5, 59, 0, 16),
(5, 67, 0, 14),
(5, 68, 0, 6),
(5, 69, 0, 17),
(5, 70, 0, 2),
(5, 72, 0, 17),
(5, 76, 0, 6),
(5, 81, 0, 6),
(5, 83, 0, 4),
(5, 86, 0, 4),
(5, 87, 0, 2),
(5, 92, 0, 2),
(5, 93, 0, 2),
(5, 169, 0, 8),
(5, 270, 0, 16),
(5, 289, 0, 4),
(5, 349, 0, 0),
(5, 369, 0, 0),
(5, 469, 0, 25),
(5, 470, 0, 0),
(5, 471, 0, 20),
(5, 509, 0, 16),
(5, 510, 0, 2),
(5, 529, 0, 0),
(5, 530, 0, 6),
(5, 549, 0, 4),
(5, 550, 0, 4),
(5, 551, 0, 4),
(5, 569, 0, 4),
(5, 570, 0, 4),
(5, 571, 0, 4),
(5, 574, 0, 4),
(5, 576, 0, 2),
(5, 577, 0, 0),
(5, 589, 0, 0),
(5, 609, 0, 0),
(5, 729, 0, 2),
(5, 730, 0, 16),
(5, 749, 0, 0),
(5, 809, 0, 16),
(5, 889, 0, 6),
(5, 890, 0, 16),
(5, 891, 0, 24),
(5, 892, 0, 14),
(5, 909, 0, 16),
(5, 910, 0, 2),
(5, 911, 0, 6),
(5, 922, 0, 6),
(5, 930, 0, 17),
(5, 932, 0, 80),
(5, 933, 0, 16),
(5, 934, 0, 80),
(5, 935, 0, 16),
(5, 936, 0, 28),
(5, 941, 0, 6),
(5, 942, 0, 16),
(5, 946, 0, 16),
(5, 947, 0, 2),
(5, 967, 0, 16),
(5, 970, 0, 0),
(5, 978, 0, 16),
(5, 980, 0, 8),
(5, 989, 0, 16),
(5, 990, 0, 16),
(5, 1005, 0, 4),
(5, 1011, 0, 16),
(5, 1012, 0, 16),
(5, 1015, 0, 2),
(5, 1031, 0, 16),
(5, 1038, 0, 16),
(5, 1077, 0, 16),
(6, 21, 0, 0),
(6, 46, 0, 4),
(6, 47, 0, 17),
(6, 54, 0, 17),
(6, 59, 0, 16),
(6, 67, 0, 14),
(6, 68, 0, 6),
(6, 69, 0, 17),
(6, 70, 0, 2),
(6, 72, 0, 17),
(6, 76, 0, 6),
(6, 81, 0, 6),
(6, 83, 0, 4),
(6, 86, 0, 4),
(6, 87, 0, 2),
(6, 92, 0, 2),
(6, 93, 0, 2),
(6, 169, 0, 8),
(6, 270, 0, 16),
(6, 289, 0, 4),
(6, 349, 0, 0),
(6, 369, 0, 0),
(6, 469, 0, 25),
(6, 470, 0, 0),
(6, 471, 0, 20),
(6, 509, 0, 16),
(6, 510, 0, 2),
(6, 529, 0, 0),
(6, 530, 0, 6),
(6, 549, 0, 4),
(6, 550, 0, 4),
(6, 551, 0, 4),
(6, 569, 0, 4),
(6, 570, 0, 4),
(6, 571, 0, 4),
(6, 574, 0, 4),
(6, 576, 0, 2),
(6, 577, 0, 0),
(6, 589, 0, 0),
(6, 609, 0, 0),
(6, 729, 0, 2),
(6, 730, 0, 16),
(6, 749, 0, 0),
(6, 809, 0, 16),
(6, 889, 0, 6),
(6, 890, 0, 16),
(6, 891, 0, 24),
(6, 892, 0, 14),
(6, 909, 0, 16),
(6, 910, 0, 0),
(6, 911, 0, 6),
(6, 922, 0, 6),
(6, 930, 0, 17),
(6, 932, 0, 80),
(6, 933, 0, 16),
(6, 934, 0, 80),
(6, 935, 0, 16),
(6, 936, 0, 28),
(6, 941, 0, 6),
(6, 942, 0, 16),
(6, 946, 0, 16),
(6, 947, 0, 0),
(6, 967, 0, 16),
(6, 970, 0, 0),
(6, 978, 0, 16),
(6, 980, 0, 8),
(6, 989, 0, 16),
(6, 990, 0, 16),
(6, 1005, 0, 4),
(6, 1011, 0, 16),
(6, 1012, 0, 16),
(6, 1015, 0, 2),
(6, 1031, 0, 16),
(6, 1038, 0, 16),
(6, 1077, 0, 16),
(7, 21, 0, 0),
(7, 46, 0, 4),
(7, 47, 0, 17),
(7, 54, 0, 17),
(7, 59, 0, 16),
(7, 67, 0, 14),
(7, 68, 0, 6),
(7, 69, 0, 17),
(7, 70, 0, 2),
(7, 72, 0, 17),
(7, 76, 0, 6),
(7, 81, 0, 6),
(7, 83, 0, 4),
(7, 86, 0, 4),
(7, 87, 0, 2),
(7, 92, 0, 2),
(7, 93, 0, 2),
(7, 169, 0, 8),
(7, 270, 0, 16),
(7, 289, 0, 4),
(7, 349, 0, 0),
(7, 369, 0, 0),
(7, 469, 0, 25),
(7, 470, 0, 0),
(7, 471, 0, 4),
(7, 509, 0, 16),
(7, 510, 0, 2),
(7, 529, 0, 0),
(7, 530, 0, 6),
(7, 549, 0, 4),
(7, 550, 0, 4),
(7, 551, 0, 4),
(7, 569, 0, 4),
(7, 570, 0, 4),
(7, 571, 0, 4),
(7, 574, 0, 4),
(7, 576, 0, 2),
(7, 577, 0, 0),
(7, 589, 0, 0),
(7, 609, 0, 0),
(7, 729, 0, 2),
(7, 730, 0, 16),
(7, 749, 0, 0),
(7, 809, 0, 16),
(7, 889, 0, 6),
(7, 890, 0, 16),
(7, 891, 0, 24),
(7, 892, 0, 14),
(7, 909, 0, 16),
(7, 910, 0, 0),
(7, 911, 0, 6),
(7, 922, 0, 6),
(7, 930, 0, 17),
(7, 932, 0, 80),
(7, 933, 0, 16),
(7, 934, 0, 80),
(7, 935, 0, 16),
(7, 936, 0, 28),
(7, 941, 0, 6),
(7, 942, 0, 16),
(7, 946, 0, 16),
(7, 947, 0, 0),
(7, 967, 0, 16),
(7, 970, 0, 0),
(7, 978, 0, 16),
(7, 980, 0, 8),
(7, 989, 0, 16),
(7, 990, 0, 16),
(7, 1005, 0, 4),
(7, 1011, 0, 16),
(7, 1012, 0, 16),
(7, 1015, 0, 2),
(7, 1031, 0, 16),
(7, 1038, 0, 16),
(7, 1077, 0, 16),
(8, 21, 0, 0),
(8, 46, 0, 4),
(8, 47, 0, 17),
(8, 54, 0, 17),
(8, 59, 0, 16),
(8, 67, 0, 14),
(8, 68, 0, 6),
(8, 69, 0, 17),
(8, 70, 0, 2),
(8, 72, 0, 17),
(8, 76, 0, 6),
(8, 81, 0, 6),
(8, 83, 0, 4),
(8, 86, 0, 4),
(8, 87, 0, 2),
(8, 92, 0, 2),
(8, 93, 0, 2),
(8, 169, 0, 8),
(8, 270, 0, 16),
(8, 289, 0, 4),
(8, 349, 0, 0),
(8, 369, 0, 0),
(8, 469, 0, 25),
(8, 470, 0, 0),
(8, 471, 0, 20),
(8, 509, 0, 16),
(8, 510, 0, 2),
(8, 529, 0, 0),
(8, 530, 0, 6),
(8, 549, 0, 4),
(8, 550, 0, 4),
(8, 551, 0, 4),
(8, 569, 0, 4),
(8, 570, 0, 4),
(8, 571, 0, 4),
(8, 574, 0, 4),
(8, 576, 0, 2),
(8, 577, 0, 0),
(8, 589, 0, 0),
(8, 609, 0, 0),
(8, 729, 0, 2),
(8, 730, 0, 16),
(8, 749, 0, 0),
(8, 809, 0, 16),
(8, 889, 0, 6),
(8, 890, 0, 16),
(8, 891, 0, 24),
(8, 892, 0, 14),
(8, 909, 0, 16),
(8, 910, 0, 0),
(8, 911, 0, 6),
(8, 922, 0, 6),
(8, 930, 0, 17),
(8, 932, 0, 80),
(8, 933, 0, 16),
(8, 934, 0, 80),
(8, 935, 0, 16),
(8, 936, 0, 28),
(8, 941, 0, 6),
(8, 942, 0, 16),
(8, 946, 0, 16),
(8, 947, 0, 0),
(8, 967, 0, 16),
(8, 970, 0, 0),
(8, 978, 0, 16),
(8, 980, 0, 8),
(8, 989, 0, 16),
(8, 990, 0, 16),
(8, 1005, 0, 4),
(8, 1011, 0, 16),
(8, 1012, 0, 16),
(8, 1015, 0, 2),
(8, 1031, 0, 16),
(8, 1038, 0, 16),
(8, 1077, 0, 16),
(9, 21, 0, 0),
(9, 46, 0, 4),
(9, 47, 0, 17),
(9, 54, 0, 17),
(9, 59, 0, 16),
(9, 67, 0, 14),
(9, 68, 0, 6),
(9, 69, 0, 17),
(9, 70, 0, 2),
(9, 72, 0, 17),
(9, 76, 0, 6),
(9, 81, 0, 6),
(9, 83, 0, 4),
(9, 86, 0, 4),
(9, 87, 0, 2),
(9, 92, 0, 2),
(9, 93, 0, 2),
(9, 169, 0, 8),
(9, 270, 0, 16),
(9, 289, 0, 4),
(9, 349, 0, 0),
(9, 369, 0, 0),
(9, 469, 0, 25),
(9, 470, 0, 0),
(9, 471, 0, 20),
(9, 509, 0, 16),
(9, 510, 0, 2),
(9, 529, 0, 0),
(9, 530, 0, 6),
(9, 549, 0, 4),
(9, 550, 0, 4),
(9, 551, 0, 4),
(9, 569, 0, 4),
(9, 570, 0, 4),
(9, 571, 0, 4),
(9, 574, 0, 4),
(9, 576, 0, 2),
(9, 577, 0, 0),
(9, 589, 0, 0),
(9, 609, 0, 0),
(9, 729, 0, 2),
(9, 730, 0, 16),
(9, 749, 0, 0),
(9, 809, 0, 16),
(9, 889, 0, 6),
(9, 890, 0, 16),
(9, 891, 0, 24),
(9, 892, 0, 14),
(9, 909, 0, 16),
(9, 910, 0, 0),
(9, 911, 0, 6),
(9, 922, 0, 6),
(9, 930, 0, 17),
(9, 932, 0, 80),
(9, 933, 0, 16),
(9, 934, 0, 80),
(9, 935, 0, 16),
(9, 936, 0, 28),
(9, 941, 0, 6),
(9, 942, 0, 16),
(9, 946, 0, 16),
(9, 947, 0, 0),
(9, 967, 0, 16),
(9, 970, 0, 0),
(9, 978, 0, 16),
(9, 980, 0, 8),
(9, 989, 0, 16),
(9, 990, 0, 16),
(9, 1005, 0, 4),
(9, 1011, 0, 16),
(9, 1012, 0, 16),
(9, 1015, 0, 2),
(9, 1031, 0, 16),
(9, 1038, 0, 16),
(9, 1077, 0, 16),
(10, 21, 0, 0),
(10, 46, 0, 4),
(10, 47, 0, 17),
(10, 54, 0, 17),
(10, 59, 0, 16),
(10, 67, 0, 14),
(10, 68, 0, 6),
(10, 69, 0, 17),
(10, 70, 0, 2),
(10, 72, 0, 17),
(10, 76, 0, 6),
(10, 81, 0, 6),
(10, 83, 0, 4),
(10, 86, 0, 4),
(10, 87, 0, 2),
(10, 92, 0, 2),
(10, 93, 0, 2),
(10, 169, 0, 8),
(10, 270, 0, 16),
(10, 289, 0, 4),
(10, 349, 0, 0),
(10, 369, 0, 0),
(10, 469, 0, 25),
(10, 470, 0, 0),
(10, 471, 0, 20),
(10, 509, 0, 16),
(10, 510, 0, 2),
(10, 529, 0, 0),
(10, 530, 0, 6),
(10, 549, 0, 4),
(10, 550, 0, 4),
(10, 551, 0, 4),
(10, 569, 0, 4),
(10, 570, 0, 4),
(10, 571, 0, 4),
(10, 574, 0, 4),
(10, 576, 0, 2),
(10, 577, 0, 0),
(10, 589, 0, 0),
(10, 609, 0, 0),
(10, 729, 0, 2),
(10, 730, 0, 16),
(10, 749, 0, 0),
(10, 809, 0, 16),
(10, 889, 0, 6),
(10, 890, 0, 16),
(10, 891, 0, 24),
(10, 892, 0, 0),
(10, 909, 0, 16),
(10, 910, 0, 0),
(10, 911, 0, 6),
(10, 922, 0, 6),
(10, 930, 0, 17),
(10, 932, 0, 80),
(10, 933, 0, 16),
(10, 934, 0, 80),
(10, 935, 0, 16),
(10, 936, 0, 28),
(10, 941, 0, 6),
(10, 942, 0, 16),
(10, 946, 0, 16),
(10, 947, 0, 0),
(10, 967, 0, 16),
(10, 970, 0, 0),
(10, 978, 0, 16),
(10, 980, 0, 8),
(10, 989, 0, 16),
(10, 990, 0, 16),
(10, 1005, 0, 4),
(10, 1011, 0, 16),
(10, 1012, 0, 16),
(10, 1015, 0, 2),
(10, 1031, 0, 16),
(10, 1038, 0, 16),
(10, 1077, 0, 16),
(11, 21, 0, 0),
(11, 46, 0, 4),
(11, 47, 0, 17),
(11, 54, 0, 17),
(11, 59, 0, 16),
(11, 67, 0, 14),
(11, 68, 0, 6),
(11, 69, 0, 17),
(11, 70, 0, 2),
(11, 72, 0, 17),
(11, 76, 0, 6),
(11, 81, 0, 6),
(11, 83, 0, 4),
(11, 86, 0, 4),
(11, 87, 0, 2),
(11, 92, 0, 2),
(11, 93, 0, 2),
(11, 169, 0, 8),
(11, 270, 0, 16),
(11, 289, 0, 4),
(11, 349, 0, 0),
(11, 369, 0, 0),
(11, 469, 0, 25),
(11, 470, 0, 0),
(11, 471, 0, 20),
(11, 509, 0, 16),
(11, 510, 0, 2),
(11, 529, 0, 0),
(11, 530, 0, 6),
(11, 549, 0, 4),
(11, 550, 0, 4),
(11, 551, 0, 4),
(11, 569, 0, 4),
(11, 570, 0, 4),
(11, 571, 0, 4),
(11, 574, 0, 4),
(11, 576, 0, 2),
(11, 577, 0, 0),
(11, 589, 0, 0),
(11, 609, 0, 0),
(11, 729, 0, 2),
(11, 730, 0, 16),
(11, 749, 0, 0),
(11, 809, 0, 16),
(11, 889, 0, 6),
(11, 890, 0, 16),
(11, 891, 0, 24),
(11, 892, 0, 0),
(11, 909, 0, 16),
(11, 910, 0, 0),
(11, 911, 0, 6),
(11, 922, 0, 6),
(11, 930, 0, 17),
(11, 932, 0, 80),
(11, 933, 0, 16),
(11, 934, 0, 80),
(11, 935, 0, 16),
(11, 936, 0, 28),
(11, 941, 0, 6),
(11, 942, 0, 16),
(11, 946, 0, 16),
(11, 947, 0, 0),
(11, 967, 0, 16),
(11, 970, 0, 0),
(11, 978, 0, 16),
(11, 980, 0, 8),
(11, 989, 0, 16),
(11, 990, 0, 16),
(11, 1005, 0, 4),
(11, 1011, 0, 16),
(11, 1012, 0, 16),
(11, 1015, 0, 2),
(11, 1031, 0, 16),
(11, 1038, 0, 16),
(11, 1077, 0, 16),
(12, 21, 0, 0),
(12, 46, 0, 4),
(12, 47, 0, 17),
(12, 54, 0, 17),
(12, 59, 0, 16),
(12, 67, 0, 14),
(12, 68, 0, 6),
(12, 69, 0, 17),
(12, 70, 0, 2),
(12, 72, 0, 17),
(12, 76, 0, 6),
(12, 81, 0, 6),
(12, 83, 0, 4),
(12, 86, 0, 4),
(12, 87, 0, 2),
(12, 92, 0, 2),
(12, 93, 0, 2),
(12, 169, 0, 8),
(12, 270, 0, 16),
(12, 289, 0, 4),
(12, 349, 0, 0),
(12, 369, 0, 0),
(12, 469, 0, 25),
(12, 470, 0, 0),
(12, 471, 0, 20),
(12, 509, 0, 16),
(12, 510, 0, 2),
(12, 529, 0, 0),
(12, 530, 0, 6),
(12, 549, 0, 4),
(12, 550, 0, 4),
(12, 551, 0, 4),
(12, 569, 0, 4),
(12, 570, 0, 4),
(12, 571, 0, 4),
(12, 574, 0, 4),
(12, 576, 0, 2),
(12, 577, 0, 0),
(12, 589, 0, 0),
(12, 609, 0, 0),
(12, 729, 0, 2),
(12, 730, 0, 16),
(12, 749, 0, 0),
(12, 809, 0, 16),
(12, 889, 0, 6),
(12, 890, 0, 16),
(12, 891, 0, 24),
(12, 892, 0, 14),
(12, 909, 0, 16),
(12, 910, 0, 0),
(12, 911, 0, 6),
(12, 922, 0, 6),
(12, 930, 0, 17),
(12, 932, 0, 80),
(12, 933, 0, 16),
(12, 934, 0, 80),
(12, 935, 0, 16),
(12, 936, 0, 28),
(12, 941, 0, 6),
(12, 942, 0, 16),
(12, 946, 0, 16),
(12, 947, 0, 0),
(12, 967, 0, 16),
(12, 970, 0, 0),
(12, 978, 0, 16),
(12, 980, 0, 8),
(12, 989, 0, 16),
(12, 990, 0, 16),
(12, 1005, 0, 4),
(12, 1011, 0, 16),
(12, 1012, 0, 16),
(12, 1015, 0, 2),
(12, 1031, 0, 16),
(12, 1038, 0, 16),
(12, 1077, 0, 16),
(13, 21, 0, 0),
(13, 46, 0, 4),
(13, 47, 0, 17),
(13, 54, 0, 17),
(13, 59, 0, 16),
(13, 67, 0, 14),
(13, 68, 0, 6),
(13, 69, 0, 17),
(13, 70, 0, 2),
(13, 72, 0, 17),
(13, 76, 0, 6),
(13, 81, 0, 6),
(13, 83, 0, 4),
(13, 86, 0, 4),
(13, 87, 0, 2),
(13, 92, 0, 2),
(13, 93, 0, 2),
(13, 169, 0, 8),
(13, 270, 0, 16),
(13, 289, 0, 4),
(13, 349, 0, 0),
(13, 369, 0, 0),
(13, 469, 0, 25),
(13, 470, 0, 0),
(13, 471, 0, 20),
(13, 509, 0, 16),
(13, 510, 0, 2),
(13, 529, 0, 0),
(13, 530, 0, 6),
(13, 549, 0, 4),
(13, 550, 0, 4),
(13, 551, 0, 4),
(13, 569, 0, 4),
(13, 570, 0, 4),
(13, 571, 0, 4),
(13, 574, 0, 4),
(13, 576, 0, 2),
(13, 577, 0, 0),
(13, 589, 0, 0),
(13, 609, 0, 0),
(13, 729, 0, 2),
(13, 730, 0, 16),
(13, 749, 0, 0),
(13, 809, 0, 16),
(13, 889, 0, 6),
(13, 890, 0, 16),
(13, 891, 0, 24),
(13, 892, 0, 14),
(13, 909, 0, 16),
(13, 910, 0, 0),
(13, 911, 0, 6),
(13, 922, 0, 6),
(13, 930, 0, 17),
(13, 932, 0, 80),
(13, 933, 0, 16),
(13, 934, 0, 80),
(13, 935, 0, 16),
(13, 936, 0, 28),
(13, 941, 0, 6),
(13, 942, 0, 16),
(13, 946, 0, 16),
(13, 947, 0, 0),
(13, 967, 0, 16),
(13, 970, 0, 0),
(13, 978, 0, 16),
(13, 980, 0, 8),
(13, 989, 0, 16),
(13, 990, 0, 16),
(13, 1005, 0, 4),
(13, 1011, 0, 16),
(13, 1012, 0, 16),
(13, 1015, 0, 2),
(13, 1031, 0, 16),
(13, 1038, 0, 16),
(13, 1077, 0, 16);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_skills`
--

DROP TABLE IF EXISTS `character_skills`;
CREATE TABLE `character_skills` (
  `guid` int(11) UNSIGNED NOT NULL COMMENT 'Global Unique Identifier',
  `skill` mediumint(9) UNSIGNED NOT NULL,
  `value` mediumint(9) UNSIGNED NOT NULL,
  `max` mediumint(9) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_skills`
--

INSERT INTO `character_skills` (`guid`, `skill`, `value`, `max`) VALUES
(3, 26, 1, 1),
(3, 43, 1, 155),
(3, 54, 1, 155),
(3, 95, 1, 155),
(3, 98, 300, 300),
(3, 113, 300, 300),
(3, 162, 1, 155),
(3, 173, 1, 155),
(3, 413, 1, 1),
(3, 414, 1, 1),
(3, 415, 1, 1),
(3, 433, 1, 1),
(4, 26, 1, 1),
(4, 43, 10, 350),
(4, 54, 1, 350),
(4, 55, 1, 350),
(4, 95, 24, 350),
(4, 98, 300, 300),
(4, 113, 300, 300),
(4, 118, 1, 350),
(4, 136, 1, 350),
(4, 162, 1, 350),
(4, 173, 1, 350),
(4, 226, 1, 350),
(4, 229, 1, 350),
(4, 257, 1, 1),
(4, 293, 1, 1),
(4, 413, 1, 1),
(4, 414, 1, 1),
(4, 415, 1, 1),
(4, 433, 1, 1),
(5, 95, 1, 55),
(5, 98, 300, 300),
(5, 113, 300, 300),
(5, 136, 1, 55),
(5, 162, 1, 55),
(5, 173, 1, 55),
(5, 414, 1, 1),
(5, 415, 1, 1),
(5, 573, 1, 1),
(5, 574, 1, 1),
(6, 26, 1, 1),
(6, 43, 1, 5),
(6, 44, 1, 5),
(6, 54, 1, 5),
(6, 95, 1, 5),
(6, 98, 300, 300),
(6, 162, 1, 5),
(6, 413, 1, 1),
(6, 414, 1, 1),
(6, 415, 1, 1),
(6, 433, 1, 1),
(7, 54, 1, 5),
(7, 95, 1, 5),
(7, 98, 300, 300),
(7, 111, 300, 300),
(7, 160, 1, 5),
(7, 162, 1, 5),
(7, 413, 1, 1),
(7, 414, 1, 1),
(7, 415, 1, 1),
(7, 433, 1, 1),
(7, 594, 1, 1),
(8, 38, 1, 1),
(8, 95, 1, 5),
(8, 98, 300, 300),
(8, 162, 1, 5),
(8, 173, 1, 5),
(8, 176, 1, 5),
(8, 253, 1, 1),
(8, 313, 300, 300),
(8, 414, 1, 1),
(8, 415, 1, 1),
(9, 6, 1, 1),
(9, 8, 1, 1),
(9, 95, 1, 5),
(9, 98, 300, 300),
(9, 136, 1, 5),
(9, 162, 1, 5),
(9, 228, 1, 5),
(9, 313, 300, 300),
(9, 415, 1, 1),
(10, 43, 1, 5),
(10, 51, 1, 1),
(10, 95, 1, 5),
(10, 98, 300, 300),
(10, 162, 1, 5),
(10, 163, 1, 1),
(10, 226, 1, 5),
(10, 414, 1, 1),
(10, 415, 1, 1),
(10, 759, 300, 300),
(10, 760, 1, 1),
(11, 54, 1, 5),
(11, 95, 1, 5),
(11, 98, 300, 300),
(11, 136, 1, 5),
(11, 162, 1, 5),
(11, 374, 1, 1),
(11, 375, 1, 1),
(11, 414, 1, 1),
(11, 415, 1, 1),
(11, 433, 1, 1),
(11, 759, 300, 300),
(11, 760, 1, 1),
(12, 95, 1, 5),
(12, 98, 300, 300),
(12, 113, 300, 300),
(12, 136, 1, 5),
(12, 162, 1, 5),
(12, 173, 1, 5),
(12, 414, 1, 1),
(12, 415, 1, 1),
(12, 573, 1, 1),
(12, 574, 1, 1),
(13, 54, 1, 5),
(13, 56, 1, 1),
(13, 95, 1, 5),
(13, 98, 300, 300),
(13, 162, 1, 5),
(13, 228, 1, 5),
(13, 415, 1, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_social`
--

DROP TABLE IF EXISTS `character_social`;
CREATE TABLE `character_social` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  `friend` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Friend Global Unique Identifier',
  `flags` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Friend Flags',
  `note` varchar(48) NOT NULL DEFAULT '' COMMENT 'Friend Note'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_social`
--

INSERT INTO `character_social` (`guid`, `friend`, `flags`, `note`) VALUES
(3, 4, 1, ''),
(3, 5, 1, ''),
(3, 6, 1, ''),
(5, 3, 1, '');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_spell`
--

DROP TABLE IF EXISTS `character_spell`;
CREATE TABLE `character_spell` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `spell` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Spell Identifier',
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT '1',
  `disabled` tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_spell`
--

INSERT INTO `character_spell` (`guid`, `spell`, `active`, `disabled`) VALUES
(4, 200, 1, 0),
(4, 202, 1, 0),
(4, 227, 1, 0),
(4, 469, 1, 0),
(4, 674, 1, 0),
(4, 676, 1, 0),
(4, 750, 1, 0),
(4, 871, 1, 0),
(4, 1161, 1, 0),
(4, 1680, 1, 0),
(4, 1719, 1, 0),
(4, 2048, 1, 0),
(4, 2565, 1, 0),
(4, 2687, 1, 0),
(4, 3127, 1, 0),
(4, 3411, 1, 0),
(4, 5011, 1, 0),
(4, 5246, 1, 0),
(4, 6554, 1, 0),
(4, 11578, 1, 0),
(4, 11585, 1, 0),
(4, 12282, 1, 0),
(4, 12286, 1, 0),
(4, 12303, 1, 0),
(4, 12677, 1, 0),
(4, 12678, 1, 0),
(4, 12727, 1, 0),
(4, 12752, 1, 0),
(4, 12765, 1, 0),
(4, 12803, 1, 0),
(4, 12807, 1, 0),
(4, 12809, 1, 0),
(4, 12945, 1, 0),
(4, 12958, 1, 0),
(4, 12975, 1, 0),
(4, 16462, 1, 0),
(4, 16542, 1, 0),
(4, 18499, 1, 0),
(4, 20230, 1, 0),
(4, 23920, 1, 0),
(4, 25203, 1, 0),
(4, 25208, 1, 0),
(4, 25212, 1, 0),
(4, 25231, 1, 0),
(4, 25236, 1, 0),
(4, 25242, 1, 0),
(4, 25264, 1, 0),
(4, 25266, 1, 0),
(4, 29704, 1, 0),
(4, 29707, 1, 0),
(4, 30357, 1, 0),
(4, 34428, 1, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_spell_cooldown`
--

DROP TABLE IF EXISTS `character_spell_cooldown`;
CREATE TABLE `character_spell_cooldown` (
  `LowGuid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier, Low part',
  `SpellId` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Spell Identifier',
  `SpellExpireTime` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Spell cooldown expire time',
  `Category` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Spell category',
  `CategoryExpireTime` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Spell category cooldown expire time',
  `ItemId` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Item Identifier'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_stats`
--

DROP TABLE IF EXISTS `character_stats`;
CREATE TABLE `character_stats` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier, Low part',
  `maxhealth` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxpower1` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxpower2` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxpower3` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxpower4` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxpower5` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxpower6` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxpower7` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `strength` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `agility` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `stamina` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `intellect` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `spirit` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `armor` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `resHoly` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `resFire` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `resNature` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `resFrost` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `resShadow` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `resArcane` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `blockPct` float UNSIGNED NOT NULL DEFAULT '0',
  `dodgePct` float UNSIGNED NOT NULL DEFAULT '0',
  `parryPct` float UNSIGNED NOT NULL DEFAULT '0',
  `critPct` float UNSIGNED NOT NULL DEFAULT '0',
  `rangedCritPct` float UNSIGNED NOT NULL DEFAULT '0',
  `spellCritPct` float UNSIGNED NOT NULL DEFAULT '0',
  `attackPower` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `rangedAttackPower` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `spellPower` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_ticket`
--

DROP TABLE IF EXISTS `character_ticket`;
CREATE TABLE `character_ticket` (
  `ticket_id` int(11) UNSIGNED NOT NULL,
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `ticket_text` text,
  `response_text` text,
  `ticket_lastchange` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `character_tutorial`
--

DROP TABLE IF EXISTS `character_tutorial`;
CREATE TABLE `character_tutorial` (
  `account` bigint(20) UNSIGNED NOT NULL COMMENT 'Account Identifier',
  `tut0` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `tut1` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `tut2` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `tut3` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `tut4` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `tut5` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `tut6` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `tut7` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `character_tutorial`
--

INSERT INTO `character_tutorial` (`account`, `tut0`, `tut1`, `tut2`, `tut3`, `tut4`, `tut5`, `tut6`, `tut7`) VALUES
(5, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295, 4294967295),
(6, 4202502, 512, 0, 0, 0, 0, 0, 0),
(8, 4, 512, 0, 0, 0, 0, 0, 0),
(9, 4, 512, 0, 0, 0, 0, 0, 0),
(11, 2097158, 512, 0, 0, 0, 0, 0, 0),
(12, 4, 512, 0, 0, 0, 0, 0, 0),
(13, 6, 512, 0, 0, 0, 0, 0, 0),
(14, 6, 512, 0, 0, 0, 0, 0, 0),
(15, 6, 512, 0, 0, 0, 0, 0, 0),
(16, 4, 512, 0, 0, 0, 0, 0, 0),
(17, 4, 512, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `corpse`
--

DROP TABLE IF EXISTS `corpse`;
CREATE TABLE `corpse` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `player` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `map` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `corpse_type` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `instance` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Death System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `creature_respawn`
--

DROP TABLE IF EXISTS `creature_respawn`;
CREATE TABLE `creature_respawn` (
  `guid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `instance` mediumint(8) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grid Loading System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `creature_respawn`
--

INSERT INTO `creature_respawn` (`guid`, `respawntime`, `instance`) VALUES
(343, 1532780075, 0),
(396, 1532780074, 0),
(429, 1532780072, 0),
(1028, 1532780072, 0),
(1029, 1532780072, 0),
(19306, 1532781969, 0),
(19308, 1532781983, 0),
(19310, 1532781979, 0),
(23436, 1532784134, 0),
(23438, 1532784116, 0),
(23439, 1532784198, 0),
(60033, 1532784608, 0),
(60034, 1532784512, 0),
(60035, 1532784598, 0),
(60036, 1532784592, 0),
(60037, 1532784583, 0),
(60038, 1532784601, 0),
(60039, 1532784559, 0),
(60040, 1532784489, 0),
(60041, 1532784489, 0),
(60042, 1532784489, 0),
(67974, 1532783971, 0),
(67976, 1532784058, 0),
(67980, 1532783920, 0),
(67981, 1532783939, 0),
(67987, 1532783935, 0),
(68010, 1532783285, 0),
(68011, 1532784073, 0),
(68012, 1532783740, 0),
(68013, 1532783297, 0),
(68015, 1532783609, 0),
(68016, 1532783478, 0),
(68017, 1532783948, 0),
(68018, 1532784136, 0),
(68019, 1532783183, 0),
(68021, 1532783282, 0),
(68022, 1532784001, 0),
(68024, 1532783291, 0),
(68025, 1532783213, 0),
(68111, 1532783814, 0),
(68112, 1532783874, 0),
(68113, 1532782494, 0),
(68114, 1532780855, 0),
(68115, 1532783674, 0),
(68116, 1532781053, 0),
(68118, 1532783031, 0),
(68121, 1532783254, 0),
(68122, 1532783482, 0),
(68123, 1532783549, 0),
(68124, 1532783938, 0),
(68125, 1532783871, 0),
(68126, 1532783416, 0),
(68127, 1532781693, 0),
(68128, 1532784010, 0),
(68189, 1532782595, 0),
(68262, 1532783212, 0),
(68263, 1532784008, 0),
(68264, 1532783409, 0),
(68265, 1532784135, 0),
(68311, 1532783893, 0),
(84978, 1532796372, 2),
(84980, 1532796386, 2),
(85001, 1532796427, 2),
(85081, 1532796420, 2),
(85082, 1532796431, 2),
(85083, 1532796387, 2),
(85084, 1532796432, 2),
(85180, 1532796421, 2),
(85181, 1532796427, 2),
(85182, 1532796372, 2),
(85351, 1532868381, 2),
(86026, 1532784255, 0),
(86027, 1532784254, 0),
(86029, 1532784255, 0),
(86030, 1532784254, 0),
(86036, 1532784253, 0),
(86037, 1532784529, 0),
(86070, 1532783934, 0),
(86071, 1532783341, 0),
(86072, 1532783278, 0),
(97110, 1533379097, 0),
(97111, 1533379099, 0),
(97112, 1533379108, 0),
(97113, 1533379089, 0),
(100285, 1532784117, 0),
(100286, 1532783688, 0),
(100301, 1532784196, 0),
(100302, 1532783839, 0),
(100303, 1532782876, 0),
(100304, 1532784283, 0),
(100305, 1532784124, 0),
(100306, 1532783863, 0),
(100309, 1532784070, 0),
(100310, 1532784205, 0),
(100311, 1532783730, 0),
(100312, 1532784290, 0),
(100313, 1532784265, 0),
(100314, 1532783847, 0),
(100315, 1532783977, 0),
(100316, 1532783857, 0),
(100317, 1532784232, 0),
(100318, 1532783962, 0),
(100319, 1532784218, 0),
(100320, 1532783795, 0),
(100321, 1532784228, 0),
(100322, 1532783547, 0),
(100323, 1532783382, 0),
(100324, 1532784220, 0),
(100325, 1532783557, 0),
(100326, 1532784301, 0),
(100327, 1532784194, 0),
(100328, 1532783880, 0),
(100329, 1532784085, 0),
(100330, 1532784232, 0),
(100331, 1532781198, 0),
(100332, 1532782826, 0),
(100333, 1532784186, 0),
(100334, 1532784037, 0),
(100337, 1532784220, 0),
(100338, 1532784091, 0),
(100339, 1532784284, 0),
(100340, 1532783963, 0),
(100341, 1532784288, 0),
(100342, 1532783971, 0),
(100343, 1532783849, 0),
(100344, 1532784290, 0),
(100345, 1532784291, 0),
(100346, 1532783966, 0),
(100347, 1532783522, 0),
(100348, 1532783382, 0),
(100349, 1532784169, 0),
(100350, 1532783717, 0),
(100351, 1532784191, 0),
(100352, 1532782401, 0),
(100353, 1532781361, 0),
(100354, 1532782909, 0),
(100357, 1532784138, 0),
(100358, 1532784018, 0),
(100359, 1532784168, 0),
(100360, 1532784288, 0),
(100361, 1532783467, 0),
(100362, 1532784079, 0),
(100363, 1532783160, 0),
(100364, 1532783040, 0),
(100367, 1532783734, 0),
(100368, 1532784228, 0),
(100369, 1532784284, 0),
(100370, 1532784097, 0),
(100373, 1532784171, 0),
(100374, 1532784291, 0),
(100375, 1532784289, 0),
(100376, 1532784163, 0),
(100381, 1532782218, 0),
(100382, 1532782019, 0),
(100875, 1532780012, 0),
(100876, 1532780159, 0),
(100877, 1532780279, 0),
(100881, 1532780042, 0),
(100882, 1532779888, 0),
(100883, 1532780165, 0),
(100887, 1532780545, 0),
(100888, 1532780688, 0),
(100889, 1532780813, 0),
(100893, 1532780292, 0),
(100895, 1532780414, 0),
(140485, 1532783300, 0),
(140486, 1532784068, 0),
(140487, 1532783732, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `event_group_chosen`
--

DROP TABLE IF EXISTS `event_group_chosen`;
CREATE TABLE `event_group_chosen` (
  `eventGroup` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `entry` mediumint(8) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Quest Group picked';

--
-- Daten für Tabelle `event_group_chosen`
--

INSERT INTO `event_group_chosen` (`eventGroup`, `entry`) VALUES
(1, 1006),
(2, 1016),
(3, 1025);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gameobject_respawn`
--

DROP TABLE IF EXISTS `gameobject_respawn`;
CREATE TABLE `gameobject_respawn` (
  `guid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `instance` mediumint(8) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grid Loading System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `game_event_status`
--

DROP TABLE IF EXISTS `game_event_status`;
CREATE TABLE `game_event_status` (
  `event` smallint(6) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Game event system' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `game_event_status`
--

INSERT INTO `game_event_status` (`event`) VALUES
(14),
(16),
(20),
(29),
(70),
(1006),
(1016),
(1025);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `groupId` int(11) UNSIGNED NOT NULL,
  `leaderGuid` int(11) UNSIGNED NOT NULL,
  `mainTank` int(11) UNSIGNED NOT NULL,
  `mainAssistant` int(11) UNSIGNED NOT NULL,
  `lootMethod` tinyint(4) UNSIGNED NOT NULL,
  `looterGuid` int(11) UNSIGNED NOT NULL,
  `lootThreshold` tinyint(4) UNSIGNED NOT NULL,
  `icon1` int(11) UNSIGNED NOT NULL,
  `icon2` int(11) UNSIGNED NOT NULL,
  `icon3` int(11) UNSIGNED NOT NULL,
  `icon4` int(11) UNSIGNED NOT NULL,
  `icon5` int(11) UNSIGNED NOT NULL,
  `icon6` int(11) UNSIGNED NOT NULL,
  `icon7` int(11) UNSIGNED NOT NULL,
  `icon8` int(11) UNSIGNED NOT NULL,
  `isRaid` tinyint(1) UNSIGNED NOT NULL,
  `difficulty` tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Groups' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `group_instance`
--

DROP TABLE IF EXISTS `group_instance`;
CREATE TABLE `group_instance` (
  `leaderGuid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `instance` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `permanent` tinyint(1) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `group_member`
--

DROP TABLE IF EXISTS `group_member`;
CREATE TABLE `group_member` (
  `groupId` int(11) UNSIGNED NOT NULL,
  `memberGuid` int(11) UNSIGNED NOT NULL,
  `assistant` tinyint(1) UNSIGNED NOT NULL,
  `subgroup` smallint(6) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Groups' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `guild`
--

DROP TABLE IF EXISTS `guild`;
CREATE TABLE `guild` (
  `guildid` int(6) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `leaderguid` int(6) UNSIGNED NOT NULL DEFAULT '0',
  `EmblemStyle` int(5) NOT NULL DEFAULT '0',
  `EmblemColor` int(5) NOT NULL DEFAULT '0',
  `BorderStyle` int(5) NOT NULL DEFAULT '0',
  `BorderColor` int(5) NOT NULL DEFAULT '0',
  `BackgroundColor` int(5) NOT NULL DEFAULT '0',
  `info` varchar(500) NOT NULL DEFAULT '',
  `motd` varchar(128) NOT NULL DEFAULT '',
  `createdate` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `BankMoney` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `guild`
--

INSERT INTO `guild` (`guildid`, `name`, `leaderguid`, `EmblemStyle`, `EmblemColor`, `BorderStyle`, `BorderColor`, `BackgroundColor`, `info`, `motd`, `createdate`, `BankMoney`) VALUES
(1, 'Guild', 3, 0, 0, 0, 0, 0, '', 'This guild message has been changed', 1532780302, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `guild_bank_eventlog`
--

DROP TABLE IF EXISTS `guild_bank_eventlog`;
CREATE TABLE `guild_bank_eventlog` (
  `guildid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Guild Identificator',
  `LogGuid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Log record identificator - auxiliary column',
  `TabId` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Guild bank TabId',
  `EventType` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Event type',
  `PlayerGuid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `ItemOrMoney` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `ItemStackCount` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `DestTabId` tinyint(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Destination Tab Id',
  `TimeStamp` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Event UNIX time'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `guild_bank_item`
--

DROP TABLE IF EXISTS `guild_bank_item`;
CREATE TABLE `guild_bank_item` (
  `guildid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `TabId` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `SlotId` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `item_guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `item_entry` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `guild_bank_right`
--

DROP TABLE IF EXISTS `guild_bank_right`;
CREATE TABLE `guild_bank_right` (
  `guildid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `TabId` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `rid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `gbright` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `SlotPerDay` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `guild_bank_tab`
--

DROP TABLE IF EXISTS `guild_bank_tab`;
CREATE TABLE `guild_bank_tab` (
  `guildid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `TabId` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `TabName` varchar(100) NOT NULL DEFAULT '',
  `TabIcon` varchar(100) NOT NULL DEFAULT '',
  `TabText` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `guild_eventlog`
--

DROP TABLE IF EXISTS `guild_eventlog`;
CREATE TABLE `guild_eventlog` (
  `guildid` int(11) UNSIGNED NOT NULL COMMENT 'Guild Identificator',
  `LogGuid` int(11) UNSIGNED NOT NULL COMMENT 'Log record identificator - auxiliary column',
  `EventType` tinyint(1) UNSIGNED NOT NULL COMMENT 'Event type',
  `PlayerGuid1` int(11) UNSIGNED NOT NULL COMMENT 'Player 1',
  `PlayerGuid2` int(11) UNSIGNED NOT NULL COMMENT 'Player 2',
  `NewRank` tinyint(2) UNSIGNED NOT NULL COMMENT 'New rank(in case promotion/demotion)',
  `TimeStamp` bigint(20) UNSIGNED NOT NULL COMMENT 'Event UNIX time'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild Eventlog';

--
-- Daten für Tabelle `guild_eventlog`
--

INSERT INTO `guild_eventlog` (`guildid`, `LogGuid`, `EventType`, `PlayerGuid1`, `PlayerGuid2`, `NewRank`, `TimeStamp`) VALUES
(1, 1, 2, 5, 0, 0, 1532780302),
(1, 2, 2, 6, 0, 0, 1532780302),
(1, 3, 2, 7, 0, 0, 1532780302),
(1, 4, 2, 8, 0, 0, 1532780302),
(1, 5, 2, 9, 0, 0, 1532780302),
(1, 6, 2, 10, 0, 0, 1532780302),
(1, 7, 2, 11, 0, 0, 1532780302),
(1, 8, 2, 12, 0, 0, 1532780302),
(1, 9, 2, 13, 0, 0, 1532780302),
(1, 10, 1, 3, 4, 0, 1532780574),
(1, 11, 2, 4, 0, 0, 1532780576);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `guild_member`
--

DROP TABLE IF EXISTS `guild_member`;
CREATE TABLE `guild_member` (
  `guildid` int(6) UNSIGNED NOT NULL DEFAULT '0',
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `rank` tinyint(2) UNSIGNED NOT NULL DEFAULT '0',
  `pnote` varchar(31) NOT NULL DEFAULT '',
  `offnote` varchar(31) NOT NULL DEFAULT '',
  `BankResetTimeMoney` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankRemMoney` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankResetTimeTab0` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankRemSlotsTab0` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankResetTimeTab1` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankRemSlotsTab1` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankResetTimeTab2` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankRemSlotsTab2` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankResetTimeTab3` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankRemSlotsTab3` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankResetTimeTab4` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankRemSlotsTab4` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankResetTimeTab5` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `BankRemSlotsTab5` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `guild_member`
--

INSERT INTO `guild_member` (`guildid`, `guid`, `rank`, `pnote`, `offnote`, `BankResetTimeMoney`, `BankRemMoney`, `BankResetTimeTab0`, `BankRemSlotsTab0`, `BankResetTimeTab1`, `BankRemSlotsTab1`, `BankResetTimeTab2`, `BankRemSlotsTab2`, `BankResetTimeTab3`, `BankRemSlotsTab3`, `BankResetTimeTab4`, `BankRemSlotsTab4`, `BankResetTimeTab5`, `BankRemSlotsTab5`) VALUES
(1, 3, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 4, 4, '', '', 25546342, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 5, 4, '', '', 25546338, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 6, 4, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 7, 4, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 8, 4, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 9, 4, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 10, 4, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 11, 4, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 12, 4, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 13, 4, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `guild_rank`
--

DROP TABLE IF EXISTS `guild_rank`;
CREATE TABLE `guild_rank` (
  `guildid` int(6) UNSIGNED NOT NULL DEFAULT '0',
  `rid` int(11) UNSIGNED NOT NULL,
  `rname` varchar(255) NOT NULL DEFAULT '',
  `rights` int(3) UNSIGNED NOT NULL DEFAULT '0',
  `BankMoneyPerDay` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `guild_rank`
--

INSERT INTO `guild_rank` (`guildid`, `rid`, `rname`, `rights`, `BankMoneyPerDay`) VALUES
(1, 0, 'Guild Master', 913919, 4294967295),
(1, 1, 'Officer', 913919, 0),
(1, 2, 'Veteran', 67, 0),
(1, 3, 'Member', 67, 0),
(1, 4, 'Initiate', 67, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `instance`
--

DROP TABLE IF EXISTS `instance`;
CREATE TABLE `instance` (
  `id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `map` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `resettime` bigint(40) UNSIGNED NOT NULL DEFAULT '0',
  `encountersMask` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `difficulty` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `data` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `instance`
--

INSERT INTO `instance` (`id`, `map`, `resettime`, `encountersMask`, `difficulty`, `data`) VALUES
(2, 532, 0, 0, 0, '0 0 0 0 0 0 0 0 0 0 0 3');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `instance_reset`
--

DROP TABLE IF EXISTS `instance_reset`;
CREATE TABLE `instance_reset` (
  `mapid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `resettime` bigint(40) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `instance_reset`
--

INSERT INTO `instance_reset` (`mapid`, `resettime`) VALUES
(249, 1533096000),
(269, 1532836800),
(309, 1533096000),
(409, 1533096000),
(469, 1533096000),
(509, 1533096000),
(531, 1533096000),
(532, 1533096000),
(533, 1533096000),
(534, 1533096000),
(540, 1532836800),
(542, 1532836800),
(543, 1532836800),
(544, 1533096000),
(545, 1532836800),
(546, 1532836800),
(547, 1532836800),
(548, 1533096000),
(550, 1533096000),
(552, 1532836800),
(553, 1532836800),
(554, 1532836800),
(555, 1532836800),
(556, 1532836800),
(557, 1532836800),
(558, 1532836800),
(560, 1532836800),
(564, 1533096000),
(565, 1533096000),
(568, 1533096000),
(580, 1533096000),
(585, 1532836800);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `item_instance`
--

DROP TABLE IF EXISTS `item_instance`;
CREATE TABLE `item_instance` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `owner_guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `data` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `item_instance`
--

INSERT INTO `item_instance` (`guid`, `owner_guid`, `data`) VALUES
(22, 3, '22 1073741824 3 25 1065353216 0 3 0 3 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(24, 3, '24 1073741824 3 6120 1065353216 0 3 0 3 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(26, 3, '26 1073741824 3 6121 1065353216 0 3 0 3 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(28, 3, '28 1073741824 3 6122 1065353216 0 3 0 3 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(30, 3, '30 1073741824 3 2362 1065353216 0 3 0 3 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(32, 3, '32 1073741824 3 117 1065353216 0 3 0 3 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(34, 3, '34 1073741824 3 6948 1065353216 0 3 0 3 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(36, 4, '36 1073741824 3 25 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(38, 4, '38 1073741824 3 6120 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(44, 4, '44 1073741824 3 2362 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(46, 4, '46 1073741824 3 117 1065353216 0 4 0 4 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(48, 4, '48 1073741824 3 6948 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(50, 5, '50 1073741824 3 3661 1065353216 0 5 0 5 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(52, 5, '52 1073741824 3 6123 1065353216 0 5 0 5 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 '),
(54, 5, '54 1073741824 3 6124 1065353216 0 5 0 5 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(56, 5, '56 1073741824 3 159 1065353216 0 5 0 5 0 0 0 0 0 2 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(58, 5, '58 1073741824 3 4536 1065353216 0 5 0 5 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(60, 5, '60 1073741824 3 6948 1065353216 0 5 0 5 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(63, 6, '63 1073741824 3 38 1065353216 0 6 0 6 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(65, 6, '65 1073741824 3 39 1065353216 0 6 0 6 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(67, 6, '67 1073741824 3 40 1065353216 0 6 0 6 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(69, 6, '69 1073741824 3 25 1065353216 0 6 0 6 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(71, 6, '71 1073741824 3 2362 1065353216 0 6 0 6 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(73, 6, '73 1073741824 3 117 1065353216 0 6 0 6 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(75, 6, '75 1073741824 3 6948 1065353216 0 6 0 6 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(77, 7, '77 1073741824 3 6117 1065353216 0 7 0 7 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(79, 7, '79 1073741824 3 6118 1065353216 0 7 0 7 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(81, 7, '81 1073741824 3 43 1065353216 0 7 0 7 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(83, 7, '83 1073741824 3 2361 1065353216 0 7 0 7 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(85, 7, '85 1073741824 3 4540 1065353216 0 7 0 7 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(87, 7, '87 1073741824 3 159 1065353216 0 7 0 7 0 0 0 0 0 2 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(89, 7, '89 1073741824 3 6948 1065353216 0 7 0 7 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(91, 8, '91 1073741824 3 49 1065353216 0 8 0 8 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(93, 8, '93 1073741824 3 48 1065353216 0 8 0 8 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(95, 8, '95 1073741824 3 47 1065353216 0 8 0 8 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(97, 8, '97 1073741824 3 2092 1065353216 0 8 0 8 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 16 16 '),
(99, 8, '99 1073741824 3 28979 1065353216 0 8 0 8 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 200 200 '),
(101, 8, '101 1073741824 3 117 1065353216 0 8 0 8 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(103, 8, '103 1073741824 3 6948 1065353216 0 8 0 8 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(105, 9, '105 1073741824 3 56 1065353216 0 9 0 9 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 '),
(107, 9, '107 1073741824 3 1395 1065353216 0 9 0 9 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(109, 9, '109 1073741824 3 6096 1065353216 0 9 0 9 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(111, 9, '111 1073741824 3 55 1065353216 0 9 0 9 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(113, 9, '113 1073741824 3 35 1065353216 0 9 0 9 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(115, 9, '115 1073741824 3 4536 1065353216 0 9 0 9 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(117, 9, '117 1073741824 3 159 1065353216 0 9 0 9 0 0 0 0 0 2 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(119, 9, '119 1073741824 3 6948 1065353216 0 9 0 9 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(121, 10, '121 1073741824 3 23345 1065353216 0 10 0 10 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(123, 10, '123 1073741824 3 23344 1065353216 0 10 0 10 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(125, 10, '125 1073741824 3 25 1065353216 0 10 0 10 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(127, 10, '127 1073741824 3 23348 1065353216 0 10 0 10 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(129, 10, '129 1073741824 3 6948 1065353216 0 10 0 10 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(131, 10, '131 1073741824 3 4540 1065353216 0 10 0 10 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(133, 10, '133 1073741824 3 159 1065353216 0 10 0 10 0 0 0 0 0 2 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(135, 10, '135 1073741824 3 23347 1065353216 0 10 0 10 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(137, 10, '137 1073741824 7 2101 1065353216 0 10 0 10 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6 0 139 1073741824 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(139, 10, '139 1073741824 3 2512 1065353216 0 10 0 137 1073741824 0 0 0 0 200 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(141, 11, '141 1073741824 3 23345 1065353216 0 11 0 11 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(143, 11, '143 1073741824 3 23344 1065353216 0 11 0 11 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(145, 11, '145 1073741824 3 23348 1065353216 0 11 0 11 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(147, 11, '147 1073741824 3 6948 1065353216 0 11 0 11 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(149, 11, '149 1073741824 3 36 1065353216 0 11 0 11 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(151, 11, '151 1073741824 3 4540 1065353216 0 11 0 11 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(153, 11, '153 1073741824 3 159 1065353216 0 11 0 11 0 0 0 0 0 2 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(155, 12, '155 1073741824 3 3661 1065353216 0 12 0 12 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(157, 12, '157 1073741824 3 6123 1065353216 0 12 0 12 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 '),
(159, 12, '159 1073741824 3 6124 1065353216 0 12 0 12 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(161, 12, '161 1073741824 3 159 1065353216 0 12 0 12 0 0 0 0 0 2 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(163, 12, '163 1073741824 3 4536 1065353216 0 12 0 12 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(165, 12, '165 1073741824 3 6948 1065353216 0 12 0 12 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(167, 13, '167 1073741824 3 6098 1065353216 0 13 0 13 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 '),
(169, 13, '169 1073741824 3 52 1065353216 0 13 0 13 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25 25 '),
(171, 13, '171 1073741824 3 53 1065353216 0 13 0 13 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(173, 13, '173 1073741824 3 51 1065353216 0 13 0 13 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(175, 13, '175 1073741824 3 36 1065353216 0 13 0 13 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20 20 '),
(177, 13, '177 1073741824 3 159 1065353216 0 13 0 13 0 0 0 0 0 2 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(179, 13, '179 1073741824 3 2070 1065353216 0 13 0 13 0 0 0 0 0 4 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(181, 13, '181 1073741824 3 6948 1065353216 0 13 0 13 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(182, 4, '182 1073741824 3 30970 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 55 55 '),
(183, 4, '183 1073741824 3 30974 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 100 100 '),
(184, 4, '184 1073741824 3 30976 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 165 165 '),
(186, 4, '186 1073741824 3 30980 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 100 100 '),
(187, 4, '187 1073741824 3 34442 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 55 55 '),
(188, 4, '188 1073741824 3 34547 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 55 55 '),
(189, 4, '189 1073741824 3 34568 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 75 75 '),
(190, 4, '190 1073741824 3 32375 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 120 120 '),
(191, 4, '191 1073741824 3 28749 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 105 105 '),
(193, 4, '193 1073741824 3 34162 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(194, 4, '194 1073741824 3 29384 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(195, 4, '195 1073741824 3 5444 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(197, 4, '197 1073741824 3 5114 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(198, 4, '198 1073741824 3 6716 1065353216 0 4 0 4 0 0 0 0 0 1 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(200, 4, '200 1073741824 3 1181 1065353216 0 4 0 4 0 0 0 0 0 1 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(201, 4, '201 1073741824 3 2592 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(202, 4, '202 1073741824 3 5124 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(203, 4, '203 1073741824 3 5404 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 50 50 '),
(204, 4, '204 1073741824 3 1179 1065353216 0 4 0 4 0 0 0 0 0 1 0 4294967295 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(205, 4, '205 1073741824 3 25265 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2805 0 0 2803 0 0 2813 0 0 0 0 0 0 0 0 17 4294967251 0 65 65 '),
(206, 4, '206 1073741824 3 25409 1065353216 0 4 0 4 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(207, 4, '207 1073741824 3 21882 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(208, 4, '208 1073741824 3 24803 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2802 0 0 2803 0 0 2825 0 0 0 0 0 0 0 0 56 4294967256 0 65 65 '),
(209, 4, '209 1073741824 3 15807 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 30 30 '),
(211, 4, '211 1073741824 7 2101 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6 0 0 0 0 0 212 1073741824 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(212, 4, '212 1073741824 3 3030 1065353216 0 4 0 211 1073741824 0 0 0 0 200 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 '),
(213, 4, '213 1073741824 3 25438 1065353216 0 4 0 4 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `item_loot`
--

DROP TABLE IF EXISTS `item_loot`;
CREATE TABLE `item_loot` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `owner_guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `itemid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `amount` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `suffix` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `property` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `item_text`
--

DROP TABLE IF EXISTS `item_text`;
CREATE TABLE `item_text` (
  `id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `text` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Item System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `item_text`
--

INSERT INTO `item_text` (`id`, `text`) VALUES
(1, 'testmail1'),
(2, 'heya whatcha eatin\n');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mail`
--

DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail` (
  `id` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Identifier',
  `messageType` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `stationery` tinyint(3) NOT NULL DEFAULT '41',
  `mailTemplateId` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `sender` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  `receiver` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  `subject` longtext,
  `itemTextId` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `has_items` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `expire_time` bigint(40) UNSIGNED NOT NULL DEFAULT '0',
  `deliver_time` bigint(40) UNSIGNED NOT NULL DEFAULT '0',
  `money` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `cod` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `checked` tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mail System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `mail`
--

INSERT INTO `mail` (`id`, `messageType`, `stationery`, `mailTemplateId`, `sender`, `receiver`, `subject`, `itemTextId`, `has_items`, `expire_time`, `deliver_time`, `money`, `cod`, `checked`) VALUES
(1, 0, 41, 0, 3, 5, 'testmail', 1, 0, 1535372375, 1532780375, 0, 0, 16),
(2, 0, 41, 0, 5, 3, 'food', 2, 0, 1535372416, 1532780416, 0, 0, 16);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mail_items`
--

DROP TABLE IF EXISTS `mail_items`;
CREATE TABLE `mail_items` (
  `mail_id` int(11) NOT NULL DEFAULT '0',
  `item_guid` int(11) NOT NULL DEFAULT '0',
  `item_template` int(11) NOT NULL DEFAULT '0',
  `receiver` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `petition`
--

DROP TABLE IF EXISTS `petition`;
CREATE TABLE `petition` (
  `ownerguid` int(10) UNSIGNED NOT NULL,
  `petitionguid` int(10) UNSIGNED DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `petition_sign`
--

DROP TABLE IF EXISTS `petition_sign`;
CREATE TABLE `petition_sign` (
  `ownerguid` int(10) UNSIGNED NOT NULL,
  `petitionguid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `playerguid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `player_account` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `type` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Guild System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pet_aura`
--

DROP TABLE IF EXISTS `pet_aura`;
CREATE TABLE `pet_aura` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `caster_guid` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Full Global Unique Identifier',
  `item_guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `spell` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `stackcount` int(11) UNSIGNED NOT NULL DEFAULT '1',
  `remaincharges` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `basepoints0` int(11) NOT NULL DEFAULT '0',
  `basepoints1` int(11) NOT NULL DEFAULT '0',
  `basepoints2` int(11) NOT NULL DEFAULT '0',
  `periodictime0` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `periodictime1` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `periodictime2` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `maxduration` int(11) NOT NULL DEFAULT '0',
  `remaintime` int(11) NOT NULL DEFAULT '0',
  `effIndexMask` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pet System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pet_spell`
--

DROP TABLE IF EXISTS `pet_spell`;
CREATE TABLE `pet_spell` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `spell` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Spell Identifier',
  `active` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Pet System' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pet_spell_cooldown`
--

DROP TABLE IF EXISTS `pet_spell_cooldown`;
CREATE TABLE `pet_spell_cooldown` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier, Low part',
  `spell` int(11) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Spell Identifier',
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `playerbot_saved_data`
--

DROP TABLE IF EXISTS `playerbot_saved_data`;
CREATE TABLE `playerbot_saved_data` (
  `guid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `bot_primary_order` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `bot_secondary_order` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `primary_target` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `secondary_target` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `pname` varchar(12) NOT NULL DEFAULT '',
  `sname` varchar(12) NOT NULL DEFAULT '',
  `combat_delay` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `auto_follow` int(11) UNSIGNED NOT NULL DEFAULT '1',
  `autoequip` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Persistent Playerbot settings per alt' ROW_FORMAT=FIXED;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pvpstats_battlegrounds`
--

DROP TABLE IF EXISTS `pvpstats_battlegrounds`;
CREATE TABLE `pvpstats_battlegrounds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `winner_team` tinyint(3) NOT NULL,
  `bracket_id` tinyint(3) UNSIGNED NOT NULL,
  `type` tinyint(3) UNSIGNED NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pvpstats_players`
--

DROP TABLE IF EXISTS `pvpstats_players`;
CREATE TABLE `pvpstats_players` (
  `battleground_id` bigint(20) UNSIGNED NOT NULL,
  `character_guid` int(10) UNSIGNED NOT NULL,
  `score_killing_blows` mediumint(8) UNSIGNED NOT NULL,
  `score_deaths` mediumint(8) UNSIGNED NOT NULL,
  `score_honorable_kills` mediumint(8) UNSIGNED NOT NULL,
  `score_bonus_honor` mediumint(8) UNSIGNED NOT NULL,
  `score_damage_done` mediumint(8) UNSIGNED NOT NULL,
  `score_healing_done` mediumint(8) UNSIGNED NOT NULL,
  `attr_1` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `attr_2` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `attr_3` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `attr_4` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `attr_5` mediumint(8) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `saved_variables`
--

DROP TABLE IF EXISTS `saved_variables`;
CREATE TABLE `saved_variables` (
  `NextArenaPointDistributionTime` bigint(40) UNSIGNED NOT NULL DEFAULT '0',
  `NextDailyQuestResetTime` bigint(40) UNSIGNED NOT NULL DEFAULT '0',
  `NextWeeklyQuestResetTime` bigint(40) UNSIGNED NOT NULL DEFAULT '0',
  `NextMonthlyQuestResetTime` bigint(40) UNSIGNED NOT NULL DEFAULT '0',
  `cleaning_flags` int(11) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Variable Saves' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `saved_variables`
--

INSERT INTO `saved_variables` (`NextArenaPointDistributionTime`, `NextDailyQuestResetTime`, `NextWeeklyQuestResetTime`, `NextMonthlyQuestResetTime`, `cleaning_flags`) VALUES
(0, 1532836800, 1533096000, 1533096000, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `world`
--

DROP TABLE IF EXISTS `world`;
CREATE TABLE `world` (
  `map` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `data` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `world`
--

INSERT INTO `world` (`map`, `data`) VALUES
(0, ''),
(1, ''),
(530, '');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `account_instances_entered`
--
ALTER TABLE `account_instances_entered`
  ADD PRIMARY KEY (`AccountId`,`InstanceId`);

--
-- Indizes für die Tabelle `arena_team`
--
ALTER TABLE `arena_team`
  ADD PRIMARY KEY (`arenateamid`);

--
-- Indizes für die Tabelle `arena_team_member`
--
ALTER TABLE `arena_team_member`
  ADD PRIMARY KEY (`arenateamid`,`guid`);

--
-- Indizes für die Tabelle `arena_team_stats`
--
ALTER TABLE `arena_team_stats`
  ADD PRIMARY KEY (`arenateamid`);

--
-- Indizes für die Tabelle `auction`
--
ALTER TABLE `auction`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `bugreport`
--
ALTER TABLE `bugreport`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`guid`),
  ADD KEY `idx_account` (`account`),
  ADD KEY `idx_online` (`online`),
  ADD KEY `idx_name` (`name`);

--
-- Indizes für die Tabelle `character_action`
--
ALTER TABLE `character_action`
  ADD PRIMARY KEY (`guid`,`button`);

--
-- Indizes für die Tabelle `character_aura`
--
ALTER TABLE `character_aura`
  ADD PRIMARY KEY (`guid`,`caster_guid`,`item_guid`,`spell`);

--
-- Indizes für die Tabelle `character_battleground_data`
--
ALTER TABLE `character_battleground_data`
  ADD PRIMARY KEY (`guid`);

--
-- Indizes für die Tabelle `character_declinedname`
--
ALTER TABLE `character_declinedname`
  ADD PRIMARY KEY (`guid`);

--
-- Indizes für die Tabelle `character_gifts`
--
ALTER TABLE `character_gifts`
  ADD PRIMARY KEY (`item_guid`),
  ADD KEY `idx_guid` (`guid`);

--
-- Indizes für die Tabelle `character_homebind`
--
ALTER TABLE `character_homebind`
  ADD PRIMARY KEY (`guid`);

--
-- Indizes für die Tabelle `character_instance`
--
ALTER TABLE `character_instance`
  ADD PRIMARY KEY (`guid`,`instance`),
  ADD KEY `instance` (`instance`);

--
-- Indizes für die Tabelle `character_inventory`
--
ALTER TABLE `character_inventory`
  ADD PRIMARY KEY (`item`),
  ADD KEY `idx_guid` (`guid`);

--
-- Indizes für die Tabelle `character_pet`
--
ALTER TABLE `character_pet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`);

--
-- Indizes für die Tabelle `character_pet_declinedname`
--
ALTER TABLE `character_pet_declinedname`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner_key` (`owner`);

--
-- Indizes für die Tabelle `character_queststatus`
--
ALTER TABLE `character_queststatus`
  ADD PRIMARY KEY (`guid`,`quest`);

--
-- Indizes für die Tabelle `character_queststatus_daily`
--
ALTER TABLE `character_queststatus_daily`
  ADD PRIMARY KEY (`guid`,`quest`);

--
-- Indizes für die Tabelle `character_queststatus_monthly`
--
ALTER TABLE `character_queststatus_monthly`
  ADD PRIMARY KEY (`guid`,`quest`);

--
-- Indizes für die Tabelle `character_queststatus_weekly`
--
ALTER TABLE `character_queststatus_weekly`
  ADD PRIMARY KEY (`guid`,`quest`);

--
-- Indizes für die Tabelle `character_reputation`
--
ALTER TABLE `character_reputation`
  ADD PRIMARY KEY (`guid`,`faction`);

--
-- Indizes für die Tabelle `character_skills`
--
ALTER TABLE `character_skills`
  ADD PRIMARY KEY (`guid`,`skill`);

--
-- Indizes für die Tabelle `character_social`
--
ALTER TABLE `character_social`
  ADD PRIMARY KEY (`guid`,`friend`,`flags`),
  ADD KEY `guid_flags` (`guid`,`flags`),
  ADD KEY `friend_flags` (`friend`,`flags`);

--
-- Indizes für die Tabelle `character_spell`
--
ALTER TABLE `character_spell`
  ADD PRIMARY KEY (`guid`,`spell`),
  ADD KEY `Idx_spell` (`spell`);

--
-- Indizes für die Tabelle `character_spell_cooldown`
--
ALTER TABLE `character_spell_cooldown`
  ADD PRIMARY KEY (`LowGuid`,`SpellId`);

--
-- Indizes für die Tabelle `character_stats`
--
ALTER TABLE `character_stats`
  ADD PRIMARY KEY (`guid`);

--
-- Indizes für die Tabelle `character_ticket`
--
ALTER TABLE `character_ticket`
  ADD PRIMARY KEY (`ticket_id`);

--
-- Indizes für die Tabelle `character_tutorial`
--
ALTER TABLE `character_tutorial`
  ADD PRIMARY KEY (`account`);

--
-- Indizes für die Tabelle `corpse`
--
ALTER TABLE `corpse`
  ADD PRIMARY KEY (`guid`),
  ADD KEY `idx_type` (`corpse_type`),
  ADD KEY `instance` (`instance`),
  ADD KEY `Idx_player` (`player`),
  ADD KEY `Idx_time` (`time`);

--
-- Indizes für die Tabelle `creature_respawn`
--
ALTER TABLE `creature_respawn`
  ADD PRIMARY KEY (`guid`,`instance`),
  ADD KEY `instance` (`instance`);

--
-- Indizes für die Tabelle `event_group_chosen`
--
ALTER TABLE `event_group_chosen`
  ADD PRIMARY KEY (`eventGroup`,`entry`);

--
-- Indizes für die Tabelle `gameobject_respawn`
--
ALTER TABLE `gameobject_respawn`
  ADD PRIMARY KEY (`guid`,`instance`),
  ADD KEY `instance` (`instance`);

--
-- Indizes für die Tabelle `game_event_status`
--
ALTER TABLE `game_event_status`
  ADD PRIMARY KEY (`event`);

--
-- Indizes für die Tabelle `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`groupId`),
  ADD UNIQUE KEY `leaderGuid` (`leaderGuid`);

--
-- Indizes für die Tabelle `group_instance`
--
ALTER TABLE `group_instance`
  ADD PRIMARY KEY (`leaderGuid`,`instance`),
  ADD KEY `instance` (`instance`);

--
-- Indizes für die Tabelle `group_member`
--
ALTER TABLE `group_member`
  ADD PRIMARY KEY (`groupId`,`memberGuid`),
  ADD KEY `Idx_memberGuid` (`memberGuid`);

--
-- Indizes für die Tabelle `guild`
--
ALTER TABLE `guild`
  ADD PRIMARY KEY (`guildid`);

--
-- Indizes für die Tabelle `guild_bank_eventlog`
--
ALTER TABLE `guild_bank_eventlog`
  ADD PRIMARY KEY (`guildid`,`LogGuid`,`TabId`),
  ADD KEY `Idx_PlayerGuid` (`PlayerGuid`),
  ADD KEY `Idx_LogGuid` (`LogGuid`);

--
-- Indizes für die Tabelle `guild_bank_item`
--
ALTER TABLE `guild_bank_item`
  ADD PRIMARY KEY (`guildid`,`TabId`,`SlotId`),
  ADD KEY `Idx_item_guid` (`item_guid`);

--
-- Indizes für die Tabelle `guild_bank_right`
--
ALTER TABLE `guild_bank_right`
  ADD PRIMARY KEY (`guildid`,`TabId`,`rid`);

--
-- Indizes für die Tabelle `guild_bank_tab`
--
ALTER TABLE `guild_bank_tab`
  ADD PRIMARY KEY (`guildid`,`TabId`);

--
-- Indizes für die Tabelle `guild_eventlog`
--
ALTER TABLE `guild_eventlog`
  ADD PRIMARY KEY (`guildid`,`LogGuid`),
  ADD KEY `Idx_PlayerGuid1` (`PlayerGuid1`),
  ADD KEY `Idx_PlayerGuid2` (`PlayerGuid2`),
  ADD KEY `Idx_LogGuid` (`LogGuid`);

--
-- Indizes für die Tabelle `guild_member`
--
ALTER TABLE `guild_member`
  ADD UNIQUE KEY `guid_key` (`guid`),
  ADD KEY `guildid_rank_key` (`guildid`,`rank`);

--
-- Indizes für die Tabelle `guild_rank`
--
ALTER TABLE `guild_rank`
  ADD PRIMARY KEY (`guildid`,`rid`),
  ADD KEY `Idx_rid` (`rid`);

--
-- Indizes für die Tabelle `instance`
--
ALTER TABLE `instance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `map` (`map`),
  ADD KEY `resettime` (`resettime`);

--
-- Indizes für die Tabelle `instance_reset`
--
ALTER TABLE `instance_reset`
  ADD PRIMARY KEY (`mapid`);

--
-- Indizes für die Tabelle `item_instance`
--
ALTER TABLE `item_instance`
  ADD PRIMARY KEY (`guid`),
  ADD KEY `idx_owner_guid` (`owner_guid`);

--
-- Indizes für die Tabelle `item_loot`
--
ALTER TABLE `item_loot`
  ADD PRIMARY KEY (`guid`,`itemid`),
  ADD KEY `idx_owner_guid` (`owner_guid`);

--
-- Indizes für die Tabelle `item_text`
--
ALTER TABLE `item_text`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `mail`
--
ALTER TABLE `mail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_receiver` (`receiver`);

--
-- Indizes für die Tabelle `mail_items`
--
ALTER TABLE `mail_items`
  ADD PRIMARY KEY (`mail_id`,`item_guid`),
  ADD KEY `idx_receiver` (`receiver`);

--
-- Indizes für die Tabelle `petition`
--
ALTER TABLE `petition`
  ADD PRIMARY KEY (`ownerguid`,`type`),
  ADD UNIQUE KEY `index_ownerguid_petitionguid` (`ownerguid`,`petitionguid`);

--
-- Indizes für die Tabelle `petition_sign`
--
ALTER TABLE `petition_sign`
  ADD PRIMARY KEY (`petitionguid`,`playerguid`),
  ADD KEY `Idx_playerguid` (`playerguid`),
  ADD KEY `Idx_ownerguid` (`ownerguid`);

--
-- Indizes für die Tabelle `pet_aura`
--
ALTER TABLE `pet_aura`
  ADD PRIMARY KEY (`guid`,`caster_guid`,`item_guid`,`spell`);

--
-- Indizes für die Tabelle `pet_spell`
--
ALTER TABLE `pet_spell`
  ADD PRIMARY KEY (`guid`,`spell`);

--
-- Indizes für die Tabelle `pet_spell_cooldown`
--
ALTER TABLE `pet_spell_cooldown`
  ADD PRIMARY KEY (`guid`,`spell`);

--
-- Indizes für die Tabelle `playerbot_saved_data`
--
ALTER TABLE `playerbot_saved_data`
  ADD PRIMARY KEY (`guid`);

--
-- Indizes für die Tabelle `pvpstats_battlegrounds`
--
ALTER TABLE `pvpstats_battlegrounds`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `pvpstats_players`
--
ALTER TABLE `pvpstats_players`
  ADD PRIMARY KEY (`battleground_id`,`character_guid`);

--
-- Indizes für die Tabelle `world`
--
ALTER TABLE `world`
  ADD PRIMARY KEY (`map`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `bugreport`
--
ALTER TABLE `bugreport`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Identifier';

--
-- AUTO_INCREMENT für Tabelle `character_ticket`
--
ALTER TABLE `character_ticket`
  MODIFY `ticket_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `character_tutorial`
--
ALTER TABLE `character_tutorial`
  MODIFY `account` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Account Identifier', AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT für Tabelle `pvpstats_battlegrounds`
--
ALTER TABLE `pvpstats_battlegrounds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Datenbank: `realmd`
--
CREATE DATABASE IF NOT EXISTS `realmd` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `realmd`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `account`
--

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'Identifier',
  `username` varchar(32) NOT NULL DEFAULT '',
  `sha_pass_hash` varchar(40) NOT NULL DEFAULT '',
  `gmlevel` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `sessionkey` longtext,
  `v` longtext,
  `s` longtext,
  `email` text,
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_ip` varchar(30) NOT NULL DEFAULT '0.0.0.0',
  `failed_logins` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `locked` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active_realm_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `expansion` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `mutetime` bigint(40) UNSIGNED NOT NULL DEFAULT '0',
  `locale` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `token` text
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Account System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `account`
--

INSERT INTO `account` (`id`, `username`, `sha_pass_hash`, `gmlevel`, `sessionkey`, `v`, `s`, `email`, `joindate`, `last_ip`, `failed_logins`, `locked`, `last_login`, `active_realm_id`, `expansion`, `mutetime`, `locale`, `token`) VALUES
(1, 'ADMINISTRATOR', 'a34b29541b87b7e4823683ce6c7bf6ae68beaaac', 3, '', '0', '0', '', '2006-04-25 10:18:56', '127.0.0.1', 0, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, NULL),
(2, 'GAMEMASTER', '7841e21831d7c6bc0b57fbe7151eb82bd65ea1f9', 2, '', '0', '0', '', '2006-04-25 10:18:56', '127.0.0.1', 0, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, NULL),
(3, 'MODERATOR', 'a7f5fbff0b4eec2d6b6e78e38e8312e64d700008', 1, '', '0', '0', '', '2006-04-25 10:19:35', '127.0.0.1', 0, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, NULL),
(4, 'PLAYER', '3ce8a96d17c5ae88a30681024e86279f1a38c041', 0, '', '0', '0', '', '2006-04-25 10:19:35', '127.0.0.1', 0, 0, '0000-00-00 00:00:00', 0, 0, 0, 0, NULL),
(5, 'TEST', '3D0D99423E31FCC67A6745EC89D70D700344BC76', 0, '7963C26E4E30CD6CEEEAF17C8948AE31801AA7F4D7DE48CA1A22F8F637B8F41CF21AEF8858173446', '08F016F0847D0E67317C7D897E17E4B0E283879AD1A301A1BAAA7233A624637E', 'E414D415B7D1A807B0ACBBEFC057E464DCC250951532A12EE2961E082B8D425D', NULL, '2018-07-28 10:09:35', '127.0.0.1', 0, 0, '2018-07-28 12:19:13', 0, 1, 0, 0, NULL),
(6, 'ADMIN', '8301316D0D8448A34FA6D0C6BF1CBFA2B4A1A93A', 3, '4A1147CC39D0159E4A2C44BBB104B156600591C7D88C221540428273383FB7B82DC18882B35DF43F', '82E58782C4F959AAEB078D5AF9F1EA9BE074579E4C2FEC67171F0E03EFE42185', '9630A1D06A3ADC0F1B71BF18BB3453A0FB06DD6B2D05E20554B48F3AB94B2ED5', NULL, '2018-07-28 10:10:32', '127.0.0.1', 0, 0, '2018-07-28 11:47:15', 0, 1, 0, 0, NULL),
(11, 'TEST2', '4EBB48A1FCFA0F4B846B039CE23D2F1412B80E90', 0, 'B0C67F6CF6ED238D0C4D83FBE88761D8EEA175878F90CD656B5A82DDA3F3C33EAF615C4048EE4219', '214748D5B2C3B25262443C47F8DC125ED6D4E285139E7404EE5B84CA3F37C961', '88F0263632A6335542EF810AFAF88DC2FCA04B9D3F426DEED1F6FAA78042F8AB', NULL, '2018-07-28 10:51:23', '127.0.0.1', 0, 0, '2018-07-28 12:17:57', 0, 1, 0, 0, NULL),
(8, 'TEST3', 'BF0F312A51ED09706A0476F44E7F2FC6B3131FC3', 0, '5B04C2A5FD062DE80332C3C0861ABBFF43F3BB9560077C5012DF9CCA9BFBC24C88120F6535DDE27A', '1E7C31324091927A38814CC9D2D7A34B1654A443B75009183FF35C9E21F202B1', 'B6D6AF35257B43295C6A16667222AFA353B7E69440F4C532D508A666C849C519', NULL, '2018-07-28 10:46:26', '127.0.0.1', 0, 0, '2018-07-28 12:08:48', 0, 1, 0, 0, NULL),
(9, 'TEST4', '8495ED33B86DA3C2B9E2131D272749E997ADF110', 0, 'FEE2EDC414B44D35BD33659172CF28638F6BF2731AF023B472C83EFBE72FE3F67D2EC77D46BDE07F', '7353FC06F9877A628184796141165719209E02039F64177995E313C91E9F393A', '9E94E7466E85D5F7DDA088C62949FE17DB33EDF2D0514053C640765ED565BAED', NULL, '2018-07-28 10:46:46', '127.0.0.1', 0, 0, '2018-07-28 12:10:56', 0, 1, 0, 0, NULL),
(12, 'TEST5', '6CA6D8465D6F8C59DF6E46E87944C0C4ABB96988', 0, '96CA2164AD64BA1F1746BE263EC21868F5856A25740BBE6A98E474BD43E690919DEE00BDBACC80ED', '7A0CF3B0020C89DCBE32D49DA322E8F7D954ECBC575E8F20AA5EB39BDAE0284A', 'E03781207AAC512976B6C41B72AA7C65D61E73E4811B3FA83C82AE3EE3B320C9', NULL, '2018-07-28 10:54:27', '127.0.0.1', 0, 0, '2018-07-28 12:11:06', 0, 0, 0, 0, NULL),
(13, 'TEST6', 'C7772FE5F4DEEDEAA920BE6F05215D4DA204EE6F', 0, 'DE5798F74258C19464D0F56B34763D8244CF9F7D66B6AC5C9724C8E022FACFFA94F31DEECF660556', '4A4D5F82D9568578F9F26F09B7C21D278AC466E43B5541B0CADFACC86701FA76', 'F41C77F294410BE1886C0D5FD6EF22AA11F2A01304A48B6BC47334E4A43A2D53', NULL, '2018-07-28 10:54:36', '127.0.0.1', 0, 0, '2018-07-28 12:15:40', 0, 0, 0, 0, NULL),
(14, 'TEST7', '7BD823DAE56ADEEEC7700388C59ADFC7361115E3', 0, '13740E7CC13629CB3B7BE95642AF7FC24E56DBAF51132D46E6FD4C62BABC1ABE8299D26DAF6EB9A9', '103652E236869907228FFDDE185D3ADBC2DD65CDE84DAE5FCB07D49E3A328BDD', 'A97951D5B988C3A99B17FD348F9CD910D62E1B029AA26F132AEBA54E2E71EA4B', NULL, '2018-07-28 10:54:49', '127.0.0.1', 0, 0, '2018-07-28 12:14:50', 0, 1, 0, 0, NULL),
(15, 'TEST8', 'C5BD97F0141439091DB9FCCB600CA6C58D20FC0E', 0, '1579C4088F50C2810BFEF7356481454F861DB7BC83358F429824EA345F732C221E5676842AE06504', '47017D838DB7601A5D7DB72F6C9FB643DEADC0F163617CBCD6FF436499782257', 'D8AFBE8C13CCE8D86E1259A655FB35B8676B7DC8C7F8AAE3034A8988B08F332D', NULL, '2018-07-28 10:54:55', '127.0.0.1', 0, 0, '2018-07-28 12:15:45', 0, 1, 0, 0, NULL),
(16, 'TEST9', '7A84F96A8ED0F0689BDED27A6B2EA58160D8FEFA', 0, 'AB5234387F643423EBC9C192E24938C638349CEE2A5184800D97AF14DA74BAB319457777357F2DFC', '49E0695A28641BDA47BF1E69CB1003356675A5756558D056D16A73E09A7D3EC9', '978EFC3B1D1779603E8806BBF1DAE00D5D78AAE4706FBADDC46D2AA6226F9385', NULL, '2018-07-28 11:58:36', '127.0.0.1', 0, 0, '2018-07-28 12:16:17', 0, 1, 0, 0, NULL),
(17, 'TEST10', '6319FD24CC984CD757EB93071EF2FF29017A4FF6', 0, '4BB4011999887F45601F226B144D0F3886ED3262060810DC3D98A64893E74B2D819DE44B49B79214', '7A836C3C379B13007B34273D379DFE9B0717E627A4B53DB3D3E7DCD7566C2F88', 'EF897CEA1774C7505F53274B9E2CD88248EC2B08E85EA14A56E5F5794D7548DF', NULL, '2018-07-28 12:13:50', '127.0.0.1', 0, 0, '2018-07-28 12:16:57', 0, 1, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `account_banned`
--

DROP TABLE IF EXISTS `account_banned`;
CREATE TABLE `account_banned` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'Account id',
  `bandate` bigint(40) NOT NULL DEFAULT '0',
  `unbandate` bigint(40) NOT NULL DEFAULT '0',
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Ban List' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ip_banned`
--

DROP TABLE IF EXISTS `ip_banned`;
CREATE TABLE `ip_banned` (
  `ip` varchar(32) NOT NULL DEFAULT '0.0.0.0',
  `bandate` bigint(40) NOT NULL,
  `unbandate` bigint(40) NOT NULL,
  `bannedby` varchar(50) NOT NULL DEFAULT '[Console]',
  `banreason` varchar(255) NOT NULL DEFAULT 'no reason'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Banned IPs' ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `realmcharacters`
--

DROP TABLE IF EXISTS `realmcharacters`;
CREATE TABLE `realmcharacters` (
  `realmid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `acctid` bigint(20) UNSIGNED NOT NULL,
  `numchars` tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Realm Character Tracker' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `realmcharacters`
--

INSERT INTO `realmcharacters` (`realmid`, `acctid`, `numchars`) VALUES
(1, 1, 0),
(1, 2, 0),
(1, 3, 0),
(1, 4, 0),
(1, 5, 1),
(1, 6, 1),
(1, 7, 0),
(1, 8, 1),
(1, 9, 1),
(1, 10, 0),
(1, 11, 1),
(1, 12, 1),
(1, 13, 1),
(1, 14, 1),
(1, 15, 1),
(1, 16, 1),
(1, 17, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `realmd_db_version`
--

DROP TABLE IF EXISTS `realmd_db_version`;
CREATE TABLE `realmd_db_version` (
  `required_s2367_01_realmd_totp` bit(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Last applied sql update to DB' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `realmd_db_version`
--

INSERT INTO `realmd_db_version` (`required_s2367_01_realmd_totp`) VALUES
(NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `realmlist`
--

DROP TABLE IF EXISTS `realmlist`;
CREATE TABLE `realmlist` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(32) NOT NULL DEFAULT '127.0.0.1',
  `port` int(11) NOT NULL DEFAULT '8085',
  `icon` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `realmflags` tinyint(3) UNSIGNED NOT NULL DEFAULT '2' COMMENT 'Supported masks: 0x1 (invalid, not show in realm list), 0x2 (offline, set by mangosd), 0x4 (show version and build), 0x20 (new players), 0x40 (recommended)',
  `timezone` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `allowedSecurityLevel` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `population` float UNSIGNED NOT NULL DEFAULT '0',
  `realmbuilds` varchar(64) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Realm System' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `realmlist`
--

INSERT INTO `realmlist` (`id`, `name`, `address`, `port`, `icon`, `realmflags`, `timezone`, `allowedSecurityLevel`, `population`, `realmbuilds`) VALUES
(1, 'MaNGOS', '127.0.0.1', 8085, 1, 0, 1, 0, 0.06, '8606 ');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `uptime`
--

DROP TABLE IF EXISTS `uptime`;
CREATE TABLE `uptime` (
  `realmid` int(11) UNSIGNED NOT NULL,
  `starttime` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `startstring` varchar(64) NOT NULL DEFAULT '',
  `uptime` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `maxplayers` smallint(5) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Uptime system' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `uptime`
--

INSERT INTO `uptime` (`realmid`, `starttime`, `startstring`, `uptime`, `maxplayers`) VALUES
(1, 1532772570, '2018-07-28 12:09:30', 5400, 2),
(1, 1532778342, '2018-07-28 13:45:42', 5400, 3);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_username` (`username`),
  ADD KEY `idx_gmlevel` (`gmlevel`);

--
-- Indizes für die Tabelle `account_banned`
--
ALTER TABLE `account_banned`
  ADD PRIMARY KEY (`id`,`bandate`);

--
-- Indizes für die Tabelle `ip_banned`
--
ALTER TABLE `ip_banned`
  ADD PRIMARY KEY (`ip`,`bandate`);

--
-- Indizes für die Tabelle `realmcharacters`
--
ALTER TABLE `realmcharacters`
  ADD PRIMARY KEY (`realmid`,`acctid`),
  ADD KEY `acctid` (`acctid`);

--
-- Indizes für die Tabelle `realmlist`
--
ALTER TABLE `realmlist`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_name` (`name`);

--
-- Indizes für die Tabelle `uptime`
--
ALTER TABLE `uptime`
  ADD PRIMARY KEY (`realmid`,`starttime`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `account`
--
ALTER TABLE `account`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identifier', AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT für Tabelle `realmlist`
--
ALTER TABLE `realmlist`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
