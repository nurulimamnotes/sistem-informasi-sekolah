--
-- DATABASE DUMP for SISFO Sekolah JIBAS 3.2 (03 September 2013)
--
-- MySQL dump 10.13  Distrib 5.5.24, for Win32 (x86)
--
-- Host: localhost    Database: jbsakad
-- ------------------------------------------------------
-- Server version	5.5.24

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `jbsakad`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbsakad` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbsakad`;

--
-- Table structure for table `aktivitaskalender`
--

DROP TABLE IF EXISTS `aktivitaskalender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aktivitaskalender` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idkalender` int(10) unsigned NOT NULL DEFAULT '0',
  `tanggalawal` date NOT NULL DEFAULT '0000-00-00',
  `tanggalakhir` date NOT NULL DEFAULT '0000-00-00',
  `kegiatan` varchar(50) NOT NULL,
  `keterangan` text,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_aktivitaskalender_kalenderakademik` (`idkalender`),
  KEY `IX_aktivitaskalender_ts` (`ts`,`issync`),
  CONSTRAINT `FK_aktivitaskalender_kalenderakademik` FOREIGN KEY (`idkalender`) REFERENCES `kalenderakademik` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aktivitaskalender`
--

LOCK TABLES `aktivitaskalender` WRITE;
/*!40000 ALTER TABLE `aktivitaskalender` DISABLE KEYS */;
/*!40000 ALTER TABLE `aktivitaskalender` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_aktivitaskalender BEFORE INSERT ON jbsakad.aktivitaskalender
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_aktivitaskalender BEFORE UPDATE ON jbsakad.aktivitaskalender
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_aktivitaskalender AFTER DELETE ON jbsakad.aktivitaskalender
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'aktivitaskalender', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alumni`
--

DROP TABLE IF EXISTS `alumni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumni` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(45) NOT NULL,
  `klsakhir` int(10) unsigned NOT NULL,
  `tktakhir` int(10) unsigned NOT NULL,
  `tgllulus` date DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `departemen` varchar(50) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_alumni_siswa` (`nis`),
  KEY `FK_alumni_tingkat` (`tktakhir`),
  KEY `FK_alumni_kelas` (`klsakhir`),
  KEY `FK_alumni_departemen` (`departemen`),
  KEY `IX_alumni_ts` (`ts`,`issync`),
  CONSTRAINT `FK_alumni_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_alumni_kelas` FOREIGN KEY (`klsakhir`) REFERENCES `kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_alumni_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_alumni_tingkat` FOREIGN KEY (`tktakhir`) REFERENCES `tingkat` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumni`
--

LOCK TABLES `alumni` WRITE;
/*!40000 ALTER TABLE `alumni` DISABLE KEYS */;
/*!40000 ALTER TABLE `alumni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `angkatan`
--

DROP TABLE IF EXISTS `angkatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `angkatan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `angkatan` varchar(50) NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_angkatan_departemen` (`departemen`),
  KEY `IX_angkatan_ts` (`ts`,`issync`),
  CONSTRAINT `FK_angkatan_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `angkatan`
--

LOCK TABLES `angkatan` WRITE;
/*!40000 ALTER TABLE `angkatan` DISABLE KEYS */;
INSERT INTO `angkatan` VALUES (19,'2008','SMA',1,'Sekedar contoh. Nama angkatan siswa yang ada di departemen sekolah. Biasanya angkatan ini bersesuaian dengan tahun penerimaan siswa baru. Ubah atau tambahkan data ini sesuai dengan nama angkatan siswa di sekolah.',NULL,NULL,NULL,'2010-03-02 03:06:17',11596,0);
/*!40000 ALTER TABLE `angkatan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_angkatan BEFORE INSERT ON jbsakad.angkatan
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_angkatan BEFORE UPDATE ON jbsakad.angkatan
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_angkatan AFTER DELETE ON jbsakad.angkatan
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'angkatan', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `asalsekolah`
--

DROP TABLE IF EXISTS `asalsekolah`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asalsekolah` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `departemen` varchar(50) NOT NULL,
  `sekolah` varchar(100) NOT NULL,
  `urutan` tinyint(2) unsigned DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`sekolah`),
  UNIQUE KEY `UX_asalsekolah` (`replid`),
  KEY `FK_asalsekolah_departemen` (`departemen`),
  KEY `IX_asalsekolah_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asalsekolah`
--

LOCK TABLES `asalsekolah` WRITE;
/*!40000 ALTER TABLE `asalsekolah` DISABLE KEYS */;
INSERT INTO `asalsekolah` VALUES (31,'SDN','SDN Indonesia Membaca',NULL,NULL,NULL,NULL,'2010-03-02 03:06:17',29807,0),(30,'SMAN','SMAN Indonesia Membaca',NULL,NULL,NULL,NULL,'2010-03-02 03:06:17',48716,0),(21,'SMPN','SMP Indonesia Membaca',NULL,NULL,NULL,NULL,'2010-03-02 03:06:17',23099,0);
/*!40000 ALTER TABLE `asalsekolah` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_asalsekolah BEFORE INSERT ON jbsakad.asalsekolah
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_asalsekolah BEFORE UPDATE ON jbsakad.asalsekolah
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_asalsekolah AFTER DELETE ON jbsakad.asalsekolah
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'asalsekolah', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `aturangrading`
--

DROP TABLE IF EXISTS `aturangrading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aturangrading` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nipguru` varchar(30) NOT NULL,
  `idtingkat` int(10) unsigned NOT NULL,
  `idpelajaran` int(10) unsigned NOT NULL,
  `dasarpenilaian` varchar(50) NOT NULL,
  `nmin` decimal(6,1) NOT NULL,
  `nmax` decimal(6,1) NOT NULL,
  `grade` varchar(2) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_aturangrading_pegawai` (`nipguru`),
  KEY `FK_aturangrading_tingkat` (`idtingkat`),
  KEY `FK_aturangrading_pelajaran` (`idpelajaran`),
  KEY `FK_aturangrading_dasarpenilaian` (`dasarpenilaian`),
  KEY `IX_aturangrading_ts` (`ts`,`issync`),
  CONSTRAINT `FK_aturangrading_dasarpenilaian` FOREIGN KEY (`dasarpenilaian`) REFERENCES `dasarpenilaian` (`dasarpenilaian`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_aturangrading_pegawai` FOREIGN KEY (`nipguru`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_aturangrading_pelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_aturangrading_tingkat` FOREIGN KEY (`idtingkat`) REFERENCES `tingkat` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=257 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aturangrading`
--

LOCK TABLES `aturangrading` WRITE;
/*!40000 ALTER TABLE `aturangrading` DISABLE KEYS */;
INSERT INTO `aturangrading` VALUES (207,'101',26,45,'Praktik',75.0,100.0,'A',NULL,NULL,NULL,'2010-03-02 03:06:17',34878,0),(208,'101',26,45,'Praktik',60.0,74.9,'B',NULL,NULL,NULL,'2010-03-02 03:06:17',39560,0),(209,'101',26,45,'Praktik',50.0,59.9,'C',NULL,NULL,NULL,'2010-03-02 03:06:17',27637,0),(210,'101',26,45,'Praktik',40.0,49.9,'D',NULL,NULL,NULL,'2010-03-02 03:06:17',19503,0),(211,'101',26,45,'Praktik',0.0,39.9,'E',NULL,NULL,NULL,'2010-03-02 03:06:17',14603,0),(217,'101',27,45,'Pemahaman Konsep',75.0,100.0,'A',NULL,NULL,NULL,'2010-03-02 03:06:17',14507,0),(218,'101',27,45,'Pemahaman Konsep',60.0,74.9,'B',NULL,NULL,NULL,'2010-03-02 03:06:17',28724,0),(219,'101',27,45,'Pemahaman Konsep',50.0,59.9,'C',NULL,NULL,NULL,'2010-03-02 03:06:17',34571,0),(220,'101',27,45,'Pemahaman Konsep',40.0,49.9,'D',NULL,NULL,NULL,'2010-03-02 03:06:17',21151,0),(221,'101',27,45,'Pemahaman Konsep',0.0,39.9,'E',NULL,NULL,NULL,'2010-03-02 03:06:17',2041,0),(222,'101',27,45,'Praktik',70.0,100.0,'A',NULL,NULL,NULL,'2010-03-02 03:06:17',12283,0),(223,'101',27,45,'Praktik',50.0,69.9,'B',NULL,NULL,NULL,'2010-03-02 03:06:17',55290,0),(224,'101',27,45,'Praktik',40.0,49.9,'C',NULL,NULL,NULL,'2010-03-02 03:06:17',43011,0),(225,'101',27,45,'Praktik',30.0,39.9,'D',NULL,NULL,NULL,'2010-03-02 03:06:17',49186,0),(226,'101',27,45,'Praktik',0.0,29.9,'E',NULL,NULL,NULL,'2010-03-02 03:06:17',51364,0),(227,'101',28,45,'Pemahaman Konsep',75.0,100.0,'A',NULL,NULL,NULL,'2010-03-02 03:06:17',43731,0),(228,'101',28,45,'Pemahaman Konsep',60.0,74.9,'B',NULL,NULL,NULL,'2010-03-02 03:06:17',64565,0),(229,'101',28,45,'Pemahaman Konsep',50.0,59.9,'C',NULL,NULL,NULL,'2010-03-02 03:06:17',60569,0),(230,'101',28,45,'Pemahaman Konsep',40.0,49.9,'D',NULL,NULL,NULL,'2010-03-02 03:06:17',43622,0),(231,'101',28,45,'Pemahaman Konsep',0.0,39.9,'E',NULL,NULL,NULL,'2010-03-02 03:06:17',36402,0),(242,'101',28,45,'Praktik',70.0,100.0,'A',NULL,NULL,NULL,'2010-03-02 03:06:17',51145,0),(243,'101',28,45,'Praktik',50.0,69.9,'B',NULL,NULL,NULL,'2010-03-02 03:06:17',15456,0),(244,'101',28,45,'Praktik',40.0,49.9,'C',NULL,NULL,NULL,'2010-03-02 03:06:17',54904,0),(245,'101',28,45,'Praktik',30.0,39.9,'D',NULL,NULL,NULL,'2010-03-02 03:06:17',31562,0),(246,'101',28,45,'Praktik',0.0,29.9,'E',NULL,NULL,NULL,'2010-03-02 03:06:17',58628,0),(252,'101',26,45,'Pemahaman Konsep',75.0,100.0,'A',NULL,NULL,NULL,'2010-03-02 03:06:17',1865,0),(253,'101',26,45,'Pemahaman Konsep',60.0,74.9,'B',NULL,NULL,NULL,'2010-03-02 03:06:17',30031,0),(254,'101',26,45,'Pemahaman Konsep',50.0,59.9,'C',NULL,NULL,NULL,'2010-03-02 03:06:17',13500,0),(255,'101',26,45,'Pemahaman Konsep',40.0,49.9,'D',NULL,NULL,NULL,'2010-03-02 03:06:17',42936,0),(256,'101',26,45,'Pemahaman Konsep',0.0,39.9,'E',NULL,NULL,NULL,'2010-03-02 03:06:17',43118,0);
/*!40000 ALTER TABLE `aturangrading` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_aturangrading BEFORE INSERT ON jbsakad.aturangrading
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_aturangrading BEFORE UPDATE ON jbsakad.aturangrading
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_aturangrading AFTER DELETE ON jbsakad.aturangrading
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'aturangrading', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `aturannhb`
--

DROP TABLE IF EXISTS `aturannhb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aturannhb` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nipguru` varchar(30) NOT NULL,
  `idtingkat` int(10) unsigned NOT NULL,
  `idpelajaran` int(10) unsigned NOT NULL,
  `dasarpenilaian` varchar(50) NOT NULL,
  `idjenisujian` int(10) unsigned NOT NULL,
  `bobot` tinyint(3) unsigned NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_aturannhb_jenisujian` (`idjenisujian`),
  KEY `FK_aturannhb_dasarpenilaian` (`dasarpenilaian`),
  KEY `FK_aturannhb_pelajaran` (`idpelajaran`),
  KEY `FK_aturannhb_tingkat` (`idtingkat`),
  KEY `FK_aturannhb_pegawai` (`nipguru`),
  KEY `IX_aturannhb_ts` (`ts`,`issync`),
  CONSTRAINT `FK_aturannhb_dasarpenilaian` FOREIGN KEY (`dasarpenilaian`) REFERENCES `dasarpenilaian` (`dasarpenilaian`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_aturannhb_jenisujian` FOREIGN KEY (`idjenisujian`) REFERENCES `jenisujian` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_aturannhb_pegawai` FOREIGN KEY (`nipguru`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_aturannhb_pelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_aturannhb_tingkat` FOREIGN KEY (`idtingkat`) REFERENCES `tingkat` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aturannhb`
--

LOCK TABLES `aturannhb` WRITE;
/*!40000 ALTER TABLE `aturannhb` DISABLE KEYS */;
INSERT INTO `aturannhb` VALUES (203,'101',26,45,'Pemahaman Konsep',108,10,1,NULL,NULL,NULL,NULL,'2010-03-02 03:06:17',42437,0),(214,'101',27,45,'Pemahaman Konsep',108,10,1,NULL,NULL,NULL,NULL,'2010-03-02 03:06:17',55114,0),(222,'101',28,45,'Pemahaman Konsep',108,10,1,NULL,NULL,NULL,NULL,'2010-03-02 03:06:17',5132,0);
/*!40000 ALTER TABLE `aturannhb` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_aturannhb BEFORE INSERT ON jbsakad.aturannhb
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_aturannhb BEFORE UPDATE ON jbsakad.aturannhb
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_aturannhb AFTER DELETE ON jbsakad.aturannhb
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'aturannhb', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `auditnilai`
--

DROP TABLE IF EXISTS `auditnilai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditnilai` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jenisnilai` varchar(45) NOT NULL,
  `idnilai` int(10) unsigned NOT NULL,
  `nasli` decimal(10,2) NOT NULL,
  `nubah` decimal(10,2) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `alasan` varchar(255) NOT NULL,
  `pengguna` varchar(100) NOT NULL,
  `informasi` varchar(255) NOT NULL,
  PRIMARY KEY (`replid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditnilai`
--

LOCK TABLES `auditnilai` WRITE;
/*!40000 ALTER TABLE `auditnilai` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditnilai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bobotnau`
--

DROP TABLE IF EXISTS `bobotnau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bobotnau` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idinfo` int(10) unsigned DEFAULT NULL,
  `idujian` int(10) unsigned NOT NULL,
  `bobot` int(10) unsigned NOT NULL DEFAULT '0',
  `idaturan` int(10) unsigned DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_bobotnau_infobobot` (`idinfo`),
  KEY `FK_bobotnau_ujian` (`idujian`),
  KEY `IX_bobotnau_ts` (`ts`,`issync`),
  CONSTRAINT `FK_bobotnau_infobobot` FOREIGN KEY (`idinfo`) REFERENCES `infobobotnau` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_bobotnau_ujian` FOREIGN KEY (`idujian`) REFERENCES `ujian` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bobotnau`
--

LOCK TABLES `bobotnau` WRITE;
/*!40000 ALTER TABLE `bobotnau` DISABLE KEYS */;
/*!40000 ALTER TABLE `bobotnau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calonsiswa`
--

DROP TABLE IF EXISTS `calonsiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calonsiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nopendaftaran` varchar(20) NOT NULL,
  `nisn` varchar(50) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `panggilan` varchar(30) DEFAULT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `tahunmasuk` int(10) unsigned NOT NULL,
  `idproses` int(10) unsigned NOT NULL,
  `idkelompok` int(10) unsigned NOT NULL,
  `suku` varchar(20) NOT NULL,
  `agama` varchar(20) NOT NULL,
  `status` varchar(100) NOT NULL,
  `kondisi` varchar(100) NOT NULL,
  `kelamin` varchar(1) NOT NULL,
  `tmplahir` varchar(50) NOT NULL,
  `tgllahir` date NOT NULL,
  `warga` varchar(5) DEFAULT NULL,
  `anakke` tinyint(2) unsigned DEFAULT '0',
  `jsaudara` tinyint(2) unsigned DEFAULT '0',
  `bahasa` varchar(30) DEFAULT NULL,
  `berat` decimal(4,1) unsigned DEFAULT '0.0',
  `tinggi` decimal(4,1) unsigned DEFAULT '0.0',
  `darah` varchar(2) DEFAULT NULL,
  `foto` blob,
  `alamatsiswa` varchar(255) DEFAULT NULL,
  `kodepossiswa` varchar(8) DEFAULT NULL,
  `telponsiswa` varchar(20) DEFAULT NULL,
  `hpsiswa` varchar(20) DEFAULT NULL,
  `emailsiswa` varchar(100) DEFAULT NULL,
  `kesehatan` varchar(150) DEFAULT NULL,
  `asalsekolah` varchar(100) DEFAULT NULL,
  `ketsekolah` varchar(100) DEFAULT NULL,
  `namaayah` varchar(60) DEFAULT NULL,
  `namaibu` varchar(60) DEFAULT NULL,
  `almayah` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `almibu` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pendidikanayah` varchar(20) DEFAULT NULL,
  `pendidikanibu` varchar(20) DEFAULT NULL,
  `pekerjaanayah` varchar(60) DEFAULT NULL,
  `pekerjaanibu` varchar(60) DEFAULT NULL,
  `wali` varchar(60) DEFAULT NULL,
  `penghasilanayah` int(10) unsigned DEFAULT '0',
  `penghasilanibu` int(10) unsigned DEFAULT '0',
  `alamatortu` varchar(100) DEFAULT NULL,
  `telponortu` varchar(20) DEFAULT NULL,
  `hportu` varchar(20) DEFAULT NULL,
  `emailayah` varchar(100) DEFAULT NULL,
  `alamatsurat` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `replidsiswa` int(10) unsigned DEFAULT NULL,
  `emailibu` varchar(100) DEFAULT NULL,
  `sum1` decimal(10,0) NOT NULL DEFAULT '0',
  `sum2` decimal(10,0) NOT NULL DEFAULT '0',
  `ujian1` decimal(5,2) NOT NULL DEFAULT '0.00',
  `ujian2` decimal(5,2) NOT NULL DEFAULT '0.00',
  `ujian3` decimal(5,2) NOT NULL DEFAULT '0.00',
  `ujian4` decimal(5,2) NOT NULL DEFAULT '0.00',
  `ujian5` decimal(5,2) NOT NULL DEFAULT '0.00',
  `info1` varchar(20) DEFAULT NULL,
  `info2` varchar(20) DEFAULT NULL,
  `info3` varchar(20) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`nopendaftaran`),
  UNIQUE KEY `UX_calonsiswa_replid` (`replid`),
  KEY `FK_calonsiswa_prosespenerimaansiswa` (`idproses`),
  KEY `FK_calonsiswa_kelompokcalonsiswa` (`idkelompok`),
  KEY `FK_calonsiswa_suku` (`suku`),
  KEY `FK_calonsiswa_agama` (`agama`),
  KEY `FK_calonsiswa_statusiswa` (`status`),
  KEY `FK_calonsiswa_asalsekolah` (`asalsekolah`),
  KEY `FK_calonsiswa_tingkatpendidikan` (`pendidikanayah`),
  KEY `FK_calonsiswa_jenispekerjaan` (`pekerjaanayah`),
  KEY `FK_calonsiswa_tingkatpendidikanibu` (`pendidikanibu`),
  KEY `FK_calonsiswa_jenispekerjaanibu` (`pekerjaanibu`),
  KEY `FK_calonsiswa_kondisisiswa` (`kondisi`),
  KEY `IX_calonsiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_calonsiswa_agama` FOREIGN KEY (`agama`) REFERENCES `jbsumum`.`agama` (`agama`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_asalsekolah` FOREIGN KEY (`asalsekolah`) REFERENCES `asalsekolah` (`sekolah`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_jenispekerjaan` FOREIGN KEY (`pekerjaanayah`) REFERENCES `jbsumum`.`jenispekerjaan` (`pekerjaan`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_jenispekerjaanibu` FOREIGN KEY (`pekerjaanibu`) REFERENCES `jbsumum`.`jenispekerjaan` (`pekerjaan`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_kelompokcalonsiswa` FOREIGN KEY (`idkelompok`) REFERENCES `kelompokcalonsiswa` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_kondisisiswa` FOREIGN KEY (`kondisi`) REFERENCES `kondisisiswa` (`kondisi`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_prosespenerimaansiswa` FOREIGN KEY (`idproses`) REFERENCES `prosespenerimaansiswa` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_statussiswa` FOREIGN KEY (`status`) REFERENCES `statussiswa` (`status`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_suku` FOREIGN KEY (`suku`) REFERENCES `jbsumum`.`suku` (`suku`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_tingkatpendidikan` FOREIGN KEY (`pendidikanayah`) REFERENCES `jbsumum`.`tingkatpendidikan` (`pendidikan`) ON UPDATE CASCADE,
  CONSTRAINT `FK_calonsiswa_tingkatpendidikanibu` FOREIGN KEY (`pendidikanibu`) REFERENCES `jbsumum`.`tingkatpendidikan` (`pendidikan`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='InnoDB free: 196608 kB; (`pendidikanibu`) REFER `jbsumum/tin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calonsiswa`
--

LOCK TABLES `calonsiswa` WRITE;
/*!40000 ALTER TABLE `calonsiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `calonsiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_calonsiswa BEFORE INSERT ON jbsakad.calonsiswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_calonsiswa BEFORE UPDATE ON jbsakad.calonsiswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_calonsiswa AFTER DELETE ON jbsakad.calonsiswa
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'calonsiswa', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `dasarpenilaian`
--

DROP TABLE IF EXISTS `dasarpenilaian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dasarpenilaian` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dasarpenilaian` varchar(50) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`dasarpenilaian`),
  UNIQUE KEY `UX_dasarpenilaian_replid` (`replid`),
  KEY `IX_dasarpenilaian_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dasarpenilaian`
--

LOCK TABLES `dasarpenilaian` WRITE;
/*!40000 ALTER TABLE `dasarpenilaian` DISABLE KEYS */;
INSERT INTO `dasarpenilaian` VALUES (3,'PKON','Pemahaman Konsep',NULL,NULL,NULL,'2010-03-02 03:06:17',50529,0),(4,'PRAK','Praktik',NULL,NULL,NULL,'2010-03-02 03:06:17',24109,0);
/*!40000 ALTER TABLE `dasarpenilaian` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_dasarpenilaian BEFORE INSERT ON jbsakad.dasarpenilaian
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_dasarpenilaian BEFORE UPDATE ON jbsakad.dasarpenilaian
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_dasarpenilaian AFTER DELETE ON jbsakad.dasarpenilaian
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'dasarpenilaian', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `deleteddata`
--

DROP TABLE IF EXISTS `deleteddata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleteddata` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tablename` varchar(100) NOT NULL,
  `rowid` bigint(20) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IX_deleteddata_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleteddata`
--

LOCK TABLES `deleteddata` WRITE;
/*!40000 ALTER TABLE `deleteddata` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleteddata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departemen`
--

DROP TABLE IF EXISTS `departemen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departemen` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `departemen` varchar(50) NOT NULL,
  `nipkepsek` varchar(30) NOT NULL,
  `urutan` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`departemen`),
  UNIQUE KEY `UX_departemen_replid` (`replid`),
  KEY `FK_departemen_pegawai` (`nipkepsek`),
  KEY `IX_departemen_ts` (`ts`,`issync`),
  CONSTRAINT `FK_departemen_pegawai` FOREIGN KEY (`nipkepsek`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departemen`
--

LOCK TABLES `departemen` WRITE;
/*!40000 ALTER TABLE `departemen` DISABLE KEYS */;
INSERT INTO `departemen` VALUES (11,'SMA','101',1,'Sekedar contoh. Menu ini mengatur departemen-departemen yang ada di sekolah. Ubah atau tambahkan data ini sesuai dengan departemen yang ada di sekolah anda.',1,NULL,NULL,NULL,'2010-03-02 03:06:17',34486,0);
/*!40000 ALTER TABLE `departemen` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_departemen BEFORE INSERT ON jbsakad.departemen
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_departemen BEFORE UPDATE ON jbsakad.departemen
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_departemen AFTER DELETE ON jbsakad.departemen
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'departemen', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `guru`
--

DROP TABLE IF EXISTS `guru`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guru` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `idpelajaran` int(10) unsigned NOT NULL,
  `statusguru` varchar(50) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_guru_pegawai` (`nip`),
  KEY `FK_guru_pelajaran` (`idpelajaran`),
  KEY `FK_guru_statusguru` (`statusguru`),
  KEY `IX_guru_ts` (`ts`,`issync`),
  CONSTRAINT `FK_guru_pegawai` FOREIGN KEY (`nip`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_guru_pelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_guru_statusguru` FOREIGN KEY (`statusguru`) REFERENCES `statusguru` (`status`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guru`
--

LOCK TABLES `guru` WRITE;
/*!40000 ALTER TABLE `guru` DISABLE KEYS */;
INSERT INTO `guru` VALUES (44,'101',45,'Guru Pelajaran',1,'',NULL,NULL,NULL,'2010-03-02 03:06:17',34572,0);
/*!40000 ALTER TABLE `guru` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_guru BEFORE INSERT ON jbsakad.guru
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_guru BEFORE UPDATE ON jbsakad.guru
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_guru AFTER DELETE ON jbsakad.guru
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'guru', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `infobobotnau`
--

DROP TABLE IF EXISTS `infobobotnau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infobobotnau` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idujian` int(10) unsigned NOT NULL,
  `idaturan` int(10) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_infobobotnau_ujian` (`idujian`),
  KEY `IX_infobobotnau_ts` (`ts`,`issync`),
  CONSTRAINT `FK_infobobotnau_ujian` FOREIGN KEY (`idujian`) REFERENCES `ujian` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infobobotnau`
--

LOCK TABLES `infobobotnau` WRITE;
/*!40000 ALTER TABLE `infobobotnau` DISABLE KEYS */;
/*!40000 ALTER TABLE `infobobotnau` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infobobotujian`
--

DROP TABLE IF EXISTS `infobobotujian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infobobotujian` (
  `replid` int(11) NOT NULL AUTO_INCREMENT,
  `idpelajaran` int(10) unsigned NOT NULL DEFAULT '0',
  `idkelas` int(10) unsigned NOT NULL DEFAULT '0',
  `idsemester` int(10) unsigned NOT NULL DEFAULT '0',
  `idjenisujian` int(10) unsigned NOT NULL DEFAULT '0',
  `pilihan` tinyint(4) NOT NULL DEFAULT '0',
  `info` varchar(100) NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_infobobotujian_idpelajaran` (`idpelajaran`),
  KEY `FK_infobobotujian_idsemester` (`idsemester`),
  KEY `FK_infobobotujian_idjenis` (`idjenisujian`),
  KEY `FK_infobobotujian_kelas` (`idkelas`),
  KEY `IX_infobobotujian_ts` (`ts`,`issync`),
  CONSTRAINT `FK_infobobotujian_idjenis` FOREIGN KEY (`idjenisujian`) REFERENCES `jenisujian` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_infobobotujian_idpelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_infobobotujian_idsemester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_infobobotujian_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infobobotujian`
--

LOCK TABLES `infobobotujian` WRITE;
/*!40000 ALTER TABLE `infobobotujian` DISABLE KEYS */;
/*!40000 ALTER TABLE `infobobotujian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infojadwal`
--

DROP TABLE IF EXISTS `infojadwal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infojadwal` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `deskripsi` varchar(100) NOT NULL DEFAULT '',
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `terlihat` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `idtahunajaran` int(10) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_infojadwal_tahunajaran` (`idtahunajaran`),
  KEY `IX_infojadwal_ts` (`ts`,`issync`),
  CONSTRAINT `FK_infojadwal_tahunajaran` FOREIGN KEY (`idtahunajaran`) REFERENCES `tahunajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infojadwal`
--

LOCK TABLES `infojadwal` WRITE;
/*!40000 ALTER TABLE `infojadwal` DISABLE KEYS */;
/*!40000 ALTER TABLE `infojadwal` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_infojadwal BEFORE INSERT ON jbsakad.infojadwal
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_infojadwal BEFORE UPDATE ON jbsakad.infojadwal
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_infojadwal AFTER DELETE ON jbsakad.infojadwal
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'infojadwal', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `infonap`
--

DROP TABLE IF EXISTS `infonap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infonap` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpelajaran` int(10) unsigned NOT NULL DEFAULT '0',
  `idsemester` int(10) unsigned NOT NULL DEFAULT '0',
  `idkelas` int(10) unsigned NOT NULL DEFAULT '0',
  `nilaimin` decimal(5,2) NOT NULL DEFAULT '0.00',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_infonap_pelajaran` (`idpelajaran`),
  KEY `FK_infonap_semester` (`idsemester`),
  KEY `FK_infonap_kelas` (`idkelas`),
  KEY `IX_infonap_ts` (`ts`,`issync`),
  CONSTRAINT `FK_infonap_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_infonap_pelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_infonap_semester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infonap`
--

LOCK TABLES `infonap` WRITE;
/*!40000 ALTER TABLE `infonap` DISABLE KEYS */;
/*!40000 ALTER TABLE `infonap` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_infonap BEFORE INSERT ON jbsakad.infonap
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_infonap BEFORE UPDATE ON jbsakad.infonap
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_infonap AFTER DELETE ON jbsakad.infonap
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'infonap', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jadwal`
--

DROP TABLE IF EXISTS `jadwal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jadwal` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idkelas` int(10) unsigned NOT NULL DEFAULT '0',
  `nipguru` varchar(30) NOT NULL,
  `idpelajaran` int(10) unsigned NOT NULL DEFAULT '0',
  `departemen` varchar(50) NOT NULL DEFAULT '',
  `infojadwal` int(10) unsigned NOT NULL DEFAULT '0',
  `hari` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `jamke` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `njam` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `sifat` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `jam1` time NOT NULL DEFAULT '00:00:00',
  `jam2` time NOT NULL DEFAULT '00:00:00',
  `idjam1` int(10) unsigned NOT NULL DEFAULT '0',
  `idjam2` int(10) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_jadwal_departemen` (`departemen`),
  KEY `FK_jadwal_pegawai` (`nipguru`),
  KEY `FK_jadwal_jam1` (`idjam1`),
  KEY `FK_jadwal_jam2` (`idjam2`),
  KEY `FK_jadwal_infojadwal` (`infojadwal`),
  KEY `FK_jadwal_pelajaran` (`idpelajaran`),
  KEY `FK_jadwal_kelas` (`idkelas`),
  KEY `IX_jadwal_ts` (`ts`,`issync`),
  CONSTRAINT `FK_jadwal_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_infojadwal` FOREIGN KEY (`infojadwal`) REFERENCES `infojadwal` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_jam` FOREIGN KEY (`idjam1`) REFERENCES `jam` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_jam2` FOREIGN KEY (`idjam2`) REFERENCES `jam` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_pegawai` FOREIGN KEY (`nipguru`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_pelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jadwal`
--

LOCK TABLES `jadwal` WRITE;
/*!40000 ALTER TABLE `jadwal` DISABLE KEYS */;
/*!40000 ALTER TABLE `jadwal` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_jadwal BEFORE INSERT ON jbsakad.jadwal
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_jadwal BEFORE UPDATE ON jbsakad.jadwal
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_jadwal AFTER DELETE ON jbsakad.jadwal
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'jadwal', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jam`
--

DROP TABLE IF EXISTS `jam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jam` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jamke` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `departemen` varchar(50) NOT NULL DEFAULT '',
  `jam1` time NOT NULL DEFAULT '00:00:00',
  `jam2` time NOT NULL DEFAULT '00:00:00',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_jam_departemen` (`departemen`),
  KEY `IX_jam_ts` (`ts`,`issync`),
  CONSTRAINT `FK_jam_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jam`
--

LOCK TABLES `jam` WRITE;
/*!40000 ALTER TABLE `jam` DISABLE KEYS */;
INSERT INTO `jam` VALUES (34,1,'SMA','06:30:00','08:00:00',NULL,NULL,NULL,'2010-03-02 03:06:17',52283,0),(35,2,'SMA','08:00:00','09:30:00',NULL,NULL,NULL,'2010-03-02 03:06:17',40376,0),(36,3,'SMA','09:30:00','10:00:00',NULL,NULL,NULL,'2010-03-02 03:06:17',45031,0),(37,4,'SMA','10:30:00','12:00:00',NULL,NULL,NULL,'2010-03-02 03:06:17',38498,0),(38,5,'SMA','12:00:00','13:30:00',NULL,NULL,NULL,'2010-03-02 03:06:17',57397,0),(39,6,'SMA','13:30:00','15:00:00',NULL,NULL,NULL,'2010-03-02 03:06:17',40428,0);
/*!40000 ALTER TABLE `jam` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_jam BEFORE INSERT ON jbsakad.jam
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_jam BEFORE UPDATE ON jbsakad.jam
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_jam AFTER DELETE ON jbsakad.jam
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'jam', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jenismutasi`
--

DROP TABLE IF EXISTS `jenismutasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jenismutasi` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jenismutasi` varchar(45) NOT NULL DEFAULT '',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_jenismutasi_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenismutasi`
--

LOCK TABLES `jenismutasi` WRITE;
/*!40000 ALTER TABLE `jenismutasi` DISABLE KEYS */;
INSERT INTO `jenismutasi` VALUES (2,'Pindah Sekolah','',NULL,NULL,NULL,'2010-03-02 03:06:17',29948,0),(3,'Dikeluarkan','Sekedar contoh. Menu ini mengatur jenis-jenis mutasi siswa. Ubah atau tambahkan data ini sesuai dengan jenis-jenis mutasi siswa yang terjadi.',NULL,NULL,NULL,'2010-03-02 03:06:17',28455,0),(4,'Mengundurkan Diri','',NULL,NULL,NULL,'2010-03-02 03:06:17',52431,0),(5,'Meninggal Dunia','',NULL,NULL,NULL,'2010-03-02 03:06:17',45730,0),(6,'Pindah Tempat Tinggal','',NULL,NULL,NULL,'2010-03-02 03:06:17',5828,0);
/*!40000 ALTER TABLE `jenismutasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jenisujian`
--

DROP TABLE IF EXISTS `jenisujian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jenisujian` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jenisujian` varchar(50) NOT NULL,
  `idpelajaran` int(10) unsigned NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_jenisujian_pelajaran` (`idpelajaran`),
  KEY `IX_jenisujian_ts` (`ts`,`issync`),
  CONSTRAINT `FK_jenisujian_pelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenisujian`
--

LOCK TABLES `jenisujian` WRITE;
/*!40000 ALTER TABLE `jenisujian` DISABLE KEYS */;
INSERT INTO `jenisujian` VALUES (108,'PR',45,'Sekedar contoh. Menu ini mengatur jenis-jenis ujian untuk pengambilan nilai siswa pada setiap pelajaran di sekolah. Ubah atau tambahkan data ini sesuai dengan jenis-jenis ujian yang digunakan di sekolah.','PR',NULL,NULL,'2010-04-16 01:55:23',32036,0);
/*!40000 ALTER TABLE `jenisujian` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_jenisujian BEFORE INSERT ON jbsakad.jenisujian
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_jenisujian BEFORE UPDATE ON jbsakad.jenisujian
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_jenisujian AFTER DELETE ON jbsakad.jenisujian
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'jenisujian', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kalenderakademik`
--

DROP TABLE IF EXISTS `kalenderakademik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kalenderakademik` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kalender` varchar(50) NOT NULL DEFAULT '',
  `aktif` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `terlihat` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `idtahunajaran` int(10) unsigned NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_kalenderakademik_tahunajaran` (`idtahunajaran`),
  KEY `FK_kalenderakademik_departemen` (`departemen`),
  KEY `IX_kalenderakademik_ts` (`ts`,`issync`),
  CONSTRAINT `FK_kalenderakademik_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_kalenderakademik_tahunajaran` FOREIGN KEY (`idtahunajaran`) REFERENCES `tahunajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kalenderakademik`
--

LOCK TABLES `kalenderakademik` WRITE;
/*!40000 ALTER TABLE `kalenderakademik` DISABLE KEYS */;
/*!40000 ALTER TABLE `kalenderakademik` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_kalenderakademik BEFORE INSERT ON jbsakad.kalenderakademik
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_kalenderakademik BEFORE UPDATE ON jbsakad.kalenderakademik
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_kalenderakademik AFTER DELETE ON jbsakad.kalenderakademik
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'kalenderakademik', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kejadianpenting`
--

DROP TABLE IF EXISTS `kejadianpenting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kejadianpenting` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idkriteria` int(10) unsigned NOT NULL DEFAULT '0',
  `nis` varchar(15) NOT NULL DEFAULT '',
  `nip` varchar(15) NOT NULL DEFAULT '',
  `tanggal` date NOT NULL DEFAULT '0000-00-00',
  `kejadian` text NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_kejadianpenting_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kejadianpenting`
--

LOCK TABLES `kejadianpenting` WRITE;
/*!40000 ALTER TABLE `kejadianpenting` DISABLE KEYS */;
/*!40000 ALTER TABLE `kejadianpenting` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_kejadianpenting BEFORE INSERT ON jbsakad.kejadianpenting
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_kejadianpenting BEFORE UPDATE ON jbsakad.kejadianpenting
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_kejadianpenting AFTER DELETE ON jbsakad.kejadianpenting
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'kejadianpenting', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kelas`
--

DROP TABLE IF EXISTS `kelas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kelas` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kelas` varchar(50) NOT NULL,
  `idtahunajaran` int(10) unsigned NOT NULL,
  `kapasitas` int(10) unsigned NOT NULL,
  `nipwali` varchar(30) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `idtingkat` int(10) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_kelas_pegawai` (`nipwali`),
  KEY `FK_kelas_tahunajaran` (`idtahunajaran`),
  KEY `FK_kelas_tingkat` (`idtingkat`),
  KEY `IX_kelas_ts` (`ts`,`issync`),
  CONSTRAINT `FK_kelas_pegawai` FOREIGN KEY (`nipwali`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_kelas_tahunajaran` FOREIGN KEY (`idtahunajaran`) REFERENCES `tahunajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_kelas_tingkat` FOREIGN KEY (`idtingkat`) REFERENCES `tingkat` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kelas`
--

LOCK TABLES `kelas` WRITE;
/*!40000 ALTER TABLE `kelas` DISABLE KEYS */;
INSERT INTO `kelas` VALUES (46,'1-A',20,50,'101',1,'Sekedar contoh. Menu ini mengatur setiap nama kelas yang ada di setiap tingkatan di sekolah. Ubah atau tambahkan data ini sesuai dengan nama-nama kelas di sekolah.',26,NULL,NULL,NULL,'2010-03-02 03:06:17',17056,0);
/*!40000 ALTER TABLE `kelas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_kelas BEFORE INSERT ON jbsakad.kelas
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_kelas BEFORE UPDATE ON jbsakad.kelas
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_kelas AFTER DELETE ON jbsakad.kelas
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'kelas', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kelompokcalonsiswa`
--

DROP TABLE IF EXISTS `kelompokcalonsiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kelompokcalonsiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kelompok` varchar(100) NOT NULL,
  `idproses` int(10) unsigned NOT NULL,
  `kapasitas` int(10) unsigned NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_kelompokcalonsiswa_prosespenerimaansiswa` (`idproses`),
  KEY `IX_kelompokcalonsiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_kelompokcalonsiswa_prosespenerimaansiswa` FOREIGN KEY (`idproses`) REFERENCES `prosespenerimaansiswa` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kelompokcalonsiswa`
--

LOCK TABLES `kelompokcalonsiswa` WRITE;
/*!40000 ALTER TABLE `kelompokcalonsiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `kelompokcalonsiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_kelompokcalonsiswa BEFORE INSERT ON jbsakad.kelompokcalonsiswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_kelompokcalonsiswa BEFORE UPDATE ON jbsakad.kelompokcalonsiswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_kelompokcalonsiswa AFTER DELETE ON jbsakad.kelompokcalonsiswa
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'kelompokcalonsiswa', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `komennap`
--

DROP TABLE IF EXISTS `komennap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `komennap` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL,
  `idinfo` int(10) unsigned NOT NULL DEFAULT '0',
  `komentar` text NOT NULL,
  `predikat` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_komennap_infonap` (`idinfo`),
  KEY `FK_komennap_siswa` (`nis`),
  KEY `IX_komennap_ts` (`ts`,`issync`),
  CONSTRAINT `FK_komennap_infonap` FOREIGN KEY (`idinfo`) REFERENCES `infonap` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_komennap_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `komennap`
--

LOCK TABLES `komennap` WRITE;
/*!40000 ALTER TABLE `komennap` DISABLE KEYS */;
/*!40000 ALTER TABLE `komennap` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_komennap BEFORE INSERT ON jbsakad.komennap
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_komennap BEFORE UPDATE ON jbsakad.komennap
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_komennap AFTER DELETE ON jbsakad.komennap
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'komennap', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kondisisiswa`
--

DROP TABLE IF EXISTS `kondisisiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kondisisiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kondisi` varchar(100) NOT NULL,
  `urutan` tinyint(2) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`kondisi`),
  UNIQUE KEY `UX_kondisisiswa` (`replid`),
  KEY `IX_kondisisiswa_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kondisisiswa`
--

LOCK TABLES `kondisisiswa` WRITE;
/*!40000 ALTER TABLE `kondisisiswa` DISABLE KEYS */;
INSERT INTO `kondisisiswa` VALUES (8,'Berkecukupan',1,NULL,NULL,NULL,'2010-03-02 03:06:17',30009,0),(9,'Kurang Mampu',2,NULL,NULL,NULL,'2010-03-02 03:06:17',54640,0);
/*!40000 ALTER TABLE `kondisisiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_kondisisiswa BEFORE INSERT ON jbsakad.kondisisiswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_kondisisiswa BEFORE UPDATE ON jbsakad.kondisisiswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_kondisisiswa AFTER DELETE ON jbsakad.kondisisiswa
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'kondisisiswa', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kriteriakejadian`
--

DROP TABLE IF EXISTS `kriteriakejadian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kriteriakejadian` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kriteria` varchar(50) NOT NULL DEFAULT '',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_kriteriakejadian_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kriteriakejadian`
--

LOCK TABLES `kriteriakejadian` WRITE;
/*!40000 ALTER TABLE `kriteriakejadian` DISABLE KEYS */;
/*!40000 ALTER TABLE `kriteriakejadian` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_kriteriakejadian BEFORE INSERT ON jbsakad.kriteriakejadian
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_kriteriakejadian BEFORE UPDATE ON jbsakad.kriteriakejadian
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_kriteriakejadian AFTER DELETE ON jbsakad.kriteriakejadian
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'kriteriakejadian', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mutasisiswa`
--

DROP TABLE IF EXISTS `mutasisiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mutasisiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(15) NOT NULL DEFAULT '',
  `jenismutasi` int(10) unsigned NOT NULL DEFAULT '0',
  `tglmutasi` date NOT NULL DEFAULT '0000-00-00',
  `keterangan` varchar(255) DEFAULT NULL,
  `departemen` varchar(50) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_mutasisiswa_jenismutasi` (`jenismutasi`),
  KEY `FK_mutasisiswa_siswa` (`nis`),
  KEY `FK_mutasisiswa_departemen` (`departemen`),
  KEY `IX_mutasisiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_mutasisiswa_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_mutasisiswa_jenismutasi` FOREIGN KEY (`jenismutasi`) REFERENCES `jenismutasi` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_mutasisiswa_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mutasisiswa`
--

LOCK TABLES `mutasisiswa` WRITE;
/*!40000 ALTER TABLE `mutasisiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `mutasisiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nap`
--

DROP TABLE IF EXISTS `nap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nap` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL DEFAULT '',
  `idaturan` int(10) unsigned NOT NULL DEFAULT '0',
  `idinfo` int(10) unsigned NOT NULL DEFAULT '0',
  `nilaiangka` decimal(10,2) NOT NULL DEFAULT '0.00',
  `nilaihuruf` varchar(2) NOT NULL DEFAULT '',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_nap_infonap` (`idinfo`),
  KEY `FK_nap_siswa` (`nis`),
  KEY `FK_nap_aturannhb` (`idaturan`),
  KEY `IX_nap_ts` (`ts`,`issync`),
  CONSTRAINT `FK_nap_aturannhb` FOREIGN KEY (`idaturan`) REFERENCES `aturannhb` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_nap_infonap` FOREIGN KEY (`idinfo`) REFERENCES `infonap` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_nap_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nap`
--

LOCK TABLES `nap` WRITE;
/*!40000 ALTER TABLE `nap` DISABLE KEYS */;
/*!40000 ALTER TABLE `nap` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_nap BEFORE INSERT ON jbsakad.nap
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_nap BEFORE UPDATE ON jbsakad.nap
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_nap AFTER DELETE ON jbsakad.nap
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'nap', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nau`
--

DROP TABLE IF EXISTS `nau`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nau` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpelajaran` int(10) unsigned NOT NULL DEFAULT '0',
  `nis` varchar(20) NOT NULL,
  `idkelas` int(10) unsigned DEFAULT NULL,
  `idsemester` int(10) unsigned NOT NULL DEFAULT '0',
  `idjenis` int(10) unsigned NOT NULL DEFAULT '0',
  `nilaiAU` decimal(10,2) NOT NULL DEFAULT '0.00',
  `keterangan` varchar(255) DEFAULT NULL,
  `idaturan` int(10) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_nau_idpelajaran` (`idpelajaran`),
  KEY `FK_nau_nis` (`nis`),
  KEY `FK_nau_idsemester` (`idsemester`),
  KEY `FK_nau_idjenis` (`idjenis`),
  KEY `FK_nau_idaturan` (`idaturan`),
  KEY `FK_nau_kelas` (`idkelas`),
  KEY `IX_nau_ts` (`ts`,`issync`),
  CONSTRAINT `FK_nau_idaturan` FOREIGN KEY (`idaturan`) REFERENCES `aturannhb` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_nau_idjenis` FOREIGN KEY (`idjenis`) REFERENCES `jenisujian` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_nau_idpelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_nau_idsemester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_nau_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_nau_nis` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nau`
--

LOCK TABLES `nau` WRITE;
/*!40000 ALTER TABLE `nau` DISABLE KEYS */;
/*!40000 ALTER TABLE `nau` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_nau BEFORE INSERT ON jbsakad.nau
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_nau BEFORE UPDATE ON jbsakad.nau
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_nau AFTER DELETE ON jbsakad.nau
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'nau', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `nilaiujian`
--

DROP TABLE IF EXISTS `nilaiujian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nilaiujian` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idujian` int(10) unsigned NOT NULL DEFAULT '0',
  `nis` varchar(20) NOT NULL,
  `nilaiujian` decimal(10,2) NOT NULL DEFAULT '0.00',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_nilaiujian_idujian` (`idujian`),
  KEY `FK_nilaiujian_nis` (`nis`),
  KEY `IX_nilaiujian_ts` (`ts`,`issync`),
  CONSTRAINT `FK_nilaiujian_idujian` FOREIGN KEY (`idujian`) REFERENCES `ujian` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_nilaiujian_nis` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nilaiujian`
--

LOCK TABLES `nilaiujian` WRITE;
/*!40000 ALTER TABLE `nilaiujian` DISABLE KEYS */;
/*!40000 ALTER TABLE `nilaiujian` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_nilaiujian BEFORE INSERT ON jbsakad.nilaiujian
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_nilaiujian BEFORE UPDATE ON jbsakad.nilaiujian
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_nilaiujian AFTER DELETE ON jbsakad.nilaiujian
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'nilaiujian', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pelajaran`
--

DROP TABLE IF EXISTS `pelajaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pelajaran` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kode` varchar(20) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `sifat` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_daftarpelajaran_kode` (`kode`),
  KEY `FK_pelajaran_departemen` (`departemen`),
  KEY `IX_pelajaran_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pelajaran_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pelajaran`
--

LOCK TABLES `pelajaran` WRITE;
/*!40000 ALTER TABLE `pelajaran` DISABLE KEYS */;
INSERT INTO `pelajaran` VALUES (45,'FIS','Fisika','SMA',1,1,'Sekedar contoh. Menu ini mengatur nama dan kode pelajaran yang diajarkan di sekolah. Ubah atau tambahkan data ini sesuai dengan pelajaran-pelajaran yang ada di sekolah.',NULL,NULL,NULL,'2010-03-02 03:06:17',52115,0);
/*!40000 ALTER TABLE `pelajaran` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pelajaran BEFORE INSERT ON jbsakad.pelajaran
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pelajaran BEFORE UPDATE ON jbsakad.pelajaran
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pelajaran AFTER DELETE ON jbsakad.pelajaran
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'pelajaran', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `phsiswa`
--

DROP TABLE IF EXISTS `phsiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phsiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpresensi` int(10) unsigned NOT NULL,
  `nis` varchar(20) NOT NULL,
  `hadir` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ijin` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sakit` smallint(5) unsigned NOT NULL DEFAULT '0',
  `cuti` smallint(5) unsigned NOT NULL DEFAULT '0',
  `alpa` smallint(5) unsigned NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_phsiswa_siswa` (`nis`),
  KEY `FK_phsiswa_presensiharian` (`idpresensi`),
  KEY `IX_phsiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_phsiswa_presensiharian` FOREIGN KEY (`idpresensi`) REFERENCES `presensiharian` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_phsiswa_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phsiswa`
--

LOCK TABLES `phsiswa` WRITE;
/*!40000 ALTER TABLE `phsiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `phsiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_phsiswa BEFORE INSERT ON jbsakad.phsiswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_phsiswa BEFORE UPDATE ON jbsakad.phsiswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_phsiswa AFTER DELETE ON jbsakad.phsiswa
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'phsiswa', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ppsiswa`
--

DROP TABLE IF EXISTS `ppsiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppsiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpp` int(10) unsigned NOT NULL DEFAULT '0',
  `nis` varchar(20) NOT NULL,
  `statushadir` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 Hadir; 1 Sakit; 2 Ijin; 3 Alpa; 4 Cuti',
  `catatan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_ppsiswa_presensipelajaran` (`idpp`),
  KEY `FK_ppsiswa_siswa` (`nis`),
  KEY `IX_ppsiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_ppsiswa_presensipelajaran` FOREIGN KEY (`idpp`) REFERENCES `presensipelajaran` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_ppsiswa_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Presensi kehadiran siswa dalam pelajaran';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppsiswa`
--

LOCK TABLES `ppsiswa` WRITE;
/*!40000 ALTER TABLE `ppsiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppsiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_ppsiswa BEFORE INSERT ON jbsakad.ppsiswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trins_ppsiswa_ppsiswahadir_100` AFTER INSERT ON `ppsiswa` FOR EACH ROW BEGIN
	DECLARE xidkelas INT;
	DECLARE xidsemester INT;
	DECLARE xidpelajaran INT;
	DECLARE xgurupelajaran VARCHAR(20);
	DECLARE xbulan INT;
	DECLARE xtahun INT;
	DECLARE xcount INT;
	
	IF @DISABLE_TRIGER IS NULL THEN
	
		IF NEW.statushadir = 0 THEN
		
			SELECT idkelas, idsemester, idpelajaran, gurupelajaran, MONTH(tanggal), YEAR(tanggal)
			  INTO xidkelas, xidsemester, xidpelajaran, xgurupelajaran, xbulan, xtahun
			  FROM jbsakad.presensipelajaran WHERE replid = NEW.idpp;

			INSERT INTO jbsakad.ppsiswahadir 
			SET nis = NEW.nis, idkelas = xidkelas, idsemester = xidsemester,
				idpelajaran = xidpelajaran, gurupelajaran = xgurupelajaran, bulan = xbulan, tahun = xtahun, 
				hadir = 1, token = FLOOR(1 + (RAND() * 65530))
			ON DUPLICATE KEY
			UPDATE hadir = hadir + 1, issync = 0, ts = CURRENT_TIMESTAMP;
		
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_ppsiswa BEFORE UPDATE ON jbsakad.ppsiswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trupd_ppsiswa_ppsiswahadir_100` AFTER UPDATE ON `ppsiswa` FOR EACH ROW BEGIN
	DECLARE xidkelas INT;
	DECLARE xidsemester INT;
	DECLARE xidpelajaran INT;
	DECLARE xgurupelajaran VARCHAR(20);
	DECLARE xbulan INT;
	DECLARE xtahun INT;
	DECLARE xcount INT;
	
	IF @DISABLE_TRIGER IS NULL THEN
	
		IF NEW.statushadir = 0 AND OLD.statushadir <> 0 THEN
		
			SELECT idkelas, idsemester, idpelajaran, gurupelajaran, MONTH(tanggal), YEAR(tanggal)
			  INTO xidkelas, xidsemester, xidpelajaran, xgurupelajaran, xbulan, xtahun
				FROM jbsakad.presensipelajaran WHERE replid = NEW.idpp;

			INSERT INTO jbsakad.ppsiswahadir 
			SET nis = NEW.nis, idkelas = xidkelas, idsemester = xidsemester,
				idpelajaran = xidpelajaran, gurupelajaran = xgurupelajaran, bulan = xbulan, tahun = xtahun, 
				hadir = 1, token = FLOOR(1 + (RAND() * 65530))
			ON DUPLICATE KEY
			UPDATE hadir = hadir + 1, issync = 0, ts = CURRENT_TIMESTAMP;
			
		ElSEIF NEW.statushadir <> 0 AND OLD.statushadir = 0 THEN
		
			SELECT idkelas, idsemester, idpelajaran, gurupelajaran, MONTH(tanggal), YEAR(tanggal)
			  INTO xidkelas, xidsemester, xidpelajaran, xgurupelajaran, xbulan, xtahun
				FROM jbsakad.presensipelajaran WHERE replid = NEW.idpp;
			
			UPDATE jbsakad.ppsiswahadir SET hadir = hadir - 1, issync = 0, ts = CURRENT_TIMESTAMP
			  WHERE nis = NEW.nis AND idkelas = xidkelas AND 
			    idsemester = xidsemester AND idpelajaran = xidpelajaran AND
			    gurupelajaran = xgurupelajaran AND bulan = xbulan AND tahun = xtahun;
				
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_ppsiswa AFTER DELETE ON jbsakad.ppsiswa
FOR EACH ROW BEGIN
	DECLARE xidkelas INT;
	DECLARE xidsemester INT;
	DECLARE xidpelajaran INT;
	DECLARE xgurupelajaran VARCHAR(20);
	DECLARE xbulan INT;
	DECLARE xtahun INT;
	DECLARE xcount INT;

	IF @DISABLE_TRIGER IS NULL THEN
		IF OLD.statushadir = 0 THEN
			SELECT idkelas, idsemester, idpelajaran, gurupelajaran, MONTH(tanggal), YEAR(tanggal)
			  INTO xidkelas, xidsemester, xidpelajaran, xgurupelajaran, xbulan, xtahun
			  FROM jbsakad.presensipelajaran WHERE replid = OLD.idpp;

			UPDATE jbsakad.ppsiswahadir SET hadir = hadir - 1, issync = 0, ts = CURRENT_TIMESTAMP
			 WHERE nis = OLD.nis AND idkelas = xidkelas AND 
			       idsemester = xidsemester AND idpelajaran = xidpelajaran AND
			       gurupelajaran = xgurupelajaran AND bulan = xbulan AND tahun = xtahun;
		END IF;

		INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), 
			dbname = 'jbsakad', tablename = 'ppsiswa', dataid = OLD.replid, datatoken = OLD.token;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ppsiswahadir`
--

DROP TABLE IF EXISTS `ppsiswahadir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ppsiswahadir` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL,
  `idkelas` int(10) unsigned NOT NULL,
  `idsemester` int(10) unsigned NOT NULL,
  `idpelajaran` int(10) unsigned NOT NULL,
  `gurupelajaran` varchar(30) NOT NULL,
  `bulan` tinyint(1) unsigned NOT NULL,
  `tahun` smallint(5) unsigned NOT NULL,
  `hadir` smallint(5) unsigned NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  UNIQUE KEY `UX_ppsiswahadir` (`nis`,`idkelas`,`idsemester`,`idpelajaran`,`gurupelajaran`,`bulan`,`tahun`),
  KEY `FK_ppsiswahadir_siswa` (`nis`),
  KEY `FK_ppsiswahadir_kelas` (`idkelas`),
  KEY `FK_ppsiswahadir_semester` (`idsemester`),
  KEY `FK_ppsiswahadir_pelajaran` (`idpelajaran`),
  KEY `FK_ppsiswahadir_pegawai` (`gurupelajaran`),
  CONSTRAINT `FK_ppsiswahadir_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ppsiswahadir_pegawai` FOREIGN KEY (`gurupelajaran`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON UPDATE CASCADE,
  CONSTRAINT `FK_ppsiswahadir_pelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ppsiswahadir_semester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ppsiswahadir_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ppsiswahadir`
--

LOCK TABLES `ppsiswahadir` WRITE;
/*!40000 ALTER TABLE `ppsiswahadir` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppsiswahadir` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_ppsiswahadir BEFORE INSERT ON jbsakad.ppsiswahadir
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_ppsiswahadir BEFORE UPDATE ON jbsakad.ppsiswahadir
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_ppsiswahadir AFTER DELETE ON jbsakad.ppsiswahadir
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'ppsiswahadir', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `presensiharian`
--

DROP TABLE IF EXISTS `presensiharian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presensiharian` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idkelas` int(10) unsigned NOT NULL,
  `idsemester` int(10) unsigned NOT NULL,
  `tanggal1` date NOT NULL,
  `tanggal2` date NOT NULL,
  `hariaktif` int(10) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_presensiharian_semester` (`idsemester`),
  KEY `IX_presensiharian_tanggal1` (`tanggal1`),
  KEY `IX_presensiharian_tanggal2` (`tanggal2`),
  KEY `FK_presensiharian_kelas` (`idkelas`),
  KEY `IX_presensiharian_ts` (`ts`,`issync`),
  CONSTRAINT `FK_presensiharian_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_presensiharian_semester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presensiharian`
--

LOCK TABLES `presensiharian` WRITE;
/*!40000 ALTER TABLE `presensiharian` DISABLE KEYS */;
/*!40000 ALTER TABLE `presensiharian` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_presensiharian BEFORE INSERT ON jbsakad.presensiharian
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_presensiharian BEFORE UPDATE ON jbsakad.presensiharian
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_presensiharian AFTER DELETE ON jbsakad.presensiharian
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'presensiharian', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `presensipelajaran`
--

DROP TABLE IF EXISTS `presensipelajaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presensipelajaran` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idkelas` int(10) unsigned NOT NULL DEFAULT '0',
  `idsemester` int(10) unsigned NOT NULL DEFAULT '0',
  `idpelajaran` int(10) unsigned NOT NULL DEFAULT '0',
  `tanggal` date NOT NULL DEFAULT '0000-00-00',
  `jam` time NOT NULL DEFAULT '00:00:00',
  `gurupelajaran` varchar(30) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `materi` varchar(1000) NOT NULL DEFAULT '',
  `objektif` varchar(255) DEFAULT NULL,
  `refleksi` varchar(255) DEFAULT NULL,
  `rencana` varchar(255) DEFAULT NULL,
  `keterlambatan` tinyint(4) DEFAULT NULL,
  `jumlahjam` decimal(4,2) NOT NULL DEFAULT '0.00',
  `jenisguru` int(10) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(20) DEFAULT NULL,
  `info2` varchar(20) DEFAULT NULL,
  `info3` varchar(20) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_presensipelajaran_semester` (`idsemester`),
  KEY `FK_presensipelajaran_jenisguru` (`jenisguru`),
  KEY `FK_presensipelajaran_pelajaran` (`idpelajaran`),
  KEY `FK_presensipelajaran_pegawai` (`gurupelajaran`),
  KEY `FK_presensipelajaran_kelas` (`idkelas`),
  KEY `IX_presensipelajaran_ts` (`ts`,`issync`),
  CONSTRAINT `FK_presensipelajaran_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_presensipelajaran_pegawai` FOREIGN KEY (`gurupelajaran`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_presensipelajaran_pelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_presensipelajaran_semester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_presensipelajaran_statusguru` FOREIGN KEY (`jenisguru`) REFERENCES `statusguru` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Informasi presensi kehadiran guru dan siswa per mata pelajar';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presensipelajaran`
--

LOCK TABLES `presensipelajaran` WRITE;
/*!40000 ALTER TABLE `presensipelajaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `presensipelajaran` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_presensipelajaran BEFORE INSERT ON jbsakad.presensipelajaran
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_presensipelajaran BEFORE UPDATE ON jbsakad.presensipelajaran
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_presensipelajaran AFTER DELETE ON jbsakad.presensipelajaran
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'presensipelajaran', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `prosespenerimaansiswa`
--

DROP TABLE IF EXISTS `prosespenerimaansiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prosespenerimaansiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proses` varchar(100) NOT NULL,
  `kodeawalan` varchar(5) NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_prosespenerimaansiswa_departemen` (`departemen`),
  KEY `IX_prosespenerimaansiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_prosespenerimaansiswa_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prosespenerimaansiswa`
--

LOCK TABLES `prosespenerimaansiswa` WRITE;
/*!40000 ALTER TABLE `prosespenerimaansiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `prosespenerimaansiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_prosespenerimaansiswa BEFORE INSERT ON jbsakad.prosespenerimaansiswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_prosespenerimaansiswa BEFORE UPDATE ON jbsakad.prosespenerimaansiswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_prosespenerimaansiswa AFTER DELETE ON jbsakad.prosespenerimaansiswa
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'prosespenerimaansiswa', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ratauk`
--

DROP TABLE IF EXISTS `ratauk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratauk` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idkelas` int(10) unsigned NOT NULL DEFAULT '0',
  `idsemester` int(10) unsigned NOT NULL DEFAULT '0',
  `idujian` int(10) unsigned NOT NULL DEFAULT '0',
  `nilaiRK` decimal(10,2) NOT NULL DEFAULT '0.00',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_ratauk_idsemester` (`idsemester`),
  KEY `FK_ratauk_idujian` (`idujian`),
  KEY `FK_ratauk_kelas` (`idkelas`),
  KEY `IX_ratauk_ts` (`ts`,`issync`),
  CONSTRAINT `FK_ratauk_idsemester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_ratauk_idujian` FOREIGN KEY (`idujian`) REFERENCES `ujian` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ratauk_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratauk`
--

LOCK TABLES `ratauk` WRITE;
/*!40000 ALTER TABLE `ratauk` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratauk` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_ratauk BEFORE INSERT ON jbsakad.ratauk
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_ratauk BEFORE UPDATE ON jbsakad.ratauk
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_ratauk AFTER DELETE ON jbsakad.ratauk
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'ratauk', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rataus`
--

DROP TABLE IF EXISTS `rataus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rataus` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL,
  `idsemester` int(10) unsigned NOT NULL DEFAULT '0',
  `idkelas` int(10) unsigned DEFAULT NULL,
  `idjenis` int(10) unsigned NOT NULL DEFAULT '0',
  `rataUS` decimal(10,2) NOT NULL DEFAULT '0.00',
  `keterangan` varchar(255) DEFAULT NULL,
  `idpelajaran` int(10) unsigned NOT NULL DEFAULT '0',
  `idaturan` int(10) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_rataus_nis` (`nis`),
  KEY `FK_rataus_idsemester` (`idsemester`),
  KEY `FK_rataus_jenis` (`idjenis`),
  KEY `FK_rataus_idpelajaran` (`idpelajaran`),
  KEY `FK_rataus_kelas` (`idkelas`),
  KEY `IX_rataus_ts` (`ts`,`issync`),
  CONSTRAINT `FK_rataus_idpelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_rataus_idsemester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_rataus_jenis` FOREIGN KEY (`idjenis`) REFERENCES `jenisujian` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_rataus_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_rataus_nis` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rataus`
--

LOCK TABLES `rataus` WRITE;
/*!40000 ALTER TABLE `rataus` DISABLE KEYS */;
/*!40000 ALTER TABLE `rataus` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_rataus BEFORE INSERT ON jbsakad.rataus
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_rataus BEFORE UPDATE ON jbsakad.rataus
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_rataus AFTER DELETE ON jbsakad.rataus
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'rataus', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `riwayatdeptsiswa`
--

DROP TABLE IF EXISTS `riwayatdeptsiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `riwayatdeptsiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `mulai` date NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '0 -> Baru, 1 -> Siswa Pindah Departemen',
  `keterangan` varchar(255) DEFAULT NULL,
  `nislama` varchar(20) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_riwayatdeptsiswa_departemen` (`departemen`),
  KEY `FK_riwayatdeptsiswa_siswa` (`nis`),
  KEY `IX_riwayatdeptsiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_riwayatdeptsiswa_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_riwayatdeptsiswa_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riwayatdeptsiswa`
--

LOCK TABLES `riwayatdeptsiswa` WRITE;
/*!40000 ALTER TABLE `riwayatdeptsiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `riwayatdeptsiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_riwayatdeptsiswa BEFORE INSERT ON jbsakad.riwayatdeptsiswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_riwayatdeptsiswa BEFORE UPDATE ON jbsakad.riwayatdeptsiswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_riwayatdeptsiswa AFTER DELETE ON jbsakad.riwayatdeptsiswa
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'riwayatdeptsiswa', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `riwayatkelassiswa`
--

DROP TABLE IF EXISTS `riwayatkelassiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `riwayatkelassiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL,
  `idkelas` int(10) unsigned NOT NULL,
  `mulai` date NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '0 -> Baru, 1 -> Naik, 2 -> Tidak Naik, 3-> Pindah',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_riwayatkelassiswa_siswa` (`nis`),
  KEY `FK_riwayatkelassiswa_kelas` (`idkelas`),
  KEY `IX_riwayatkelassiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_riwayatkelassiswa_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_riwayatkelassiswa_siswa` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `riwayatkelassiswa`
--

LOCK TABLES `riwayatkelassiswa` WRITE;
/*!40000 ALTER TABLE `riwayatkelassiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `riwayatkelassiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_riwayatkelassiswa BEFORE INSERT ON jbsakad.riwayatkelassiswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_riwayatkelassiswa BEFORE UPDATE ON jbsakad.riwayatkelassiswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_riwayatkelassiswa AFTER DELETE ON jbsakad.riwayatkelassiswa
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'riwayatkelassiswa', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rpp`
--

DROP TABLE IF EXISTS `rpp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rpp` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idtingkat` int(10) unsigned NOT NULL,
  `idsemester` int(10) unsigned NOT NULL,
  `idpelajaran` int(10) unsigned NOT NULL,
  `koderpp` varchar(20) NOT NULL,
  `rpp` varchar(255) NOT NULL,
  `deskripsi` text,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_rpp_tingkat` (`idtingkat`),
  KEY `FK_rpp_semester` (`idsemester`),
  KEY `FK_rpp_pelajaran` (`idpelajaran`),
  KEY `IX_rpp_ts` (`ts`,`issync`),
  CONSTRAINT `FK_rpp_pelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_rpp_semester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_rpp_tingkat` FOREIGN KEY (`idtingkat`) REFERENCES `tingkat` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rpp`
--

LOCK TABLES `rpp` WRITE;
/*!40000 ALTER TABLE `rpp` DISABLE KEYS */;
/*!40000 ALTER TABLE `rpp` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_rpp BEFORE INSERT ON jbsakad.rpp
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_rpp BEFORE UPDATE ON jbsakad.rpp
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_rpp AFTER DELETE ON jbsakad.rpp
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'rpp', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `semester`
--

DROP TABLE IF EXISTS `semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semester` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `semester` varchar(50) NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_semester_departemen` (`departemen`),
  KEY `IX_semester_ts` (`ts`,`issync`),
  CONSTRAINT `FK_semester_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semester`
--

LOCK TABLES `semester` WRITE;
/*!40000 ALTER TABLE `semester` DISABLE KEYS */;
INSERT INTO `semester` VALUES (20,'Semester I','SMA',1,'Sekedar contoh. Menu ini mengatur setiap nama  semester yang ada di departemen sekolah. Setiap pergantian semester, pengguna harus mengubah status aktif semester ini. Ubah atau tambahkan data ini sesuai dengan nama semester yang digunakan disekolah anda.',NULL,NULL,NULL,'2010-03-02 03:06:18',6418,0);
/*!40000 ALTER TABLE `semester` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_semester BEFORE INSERT ON jbsakad.semester
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_semester BEFORE UPDATE ON jbsakad.semester
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_semester AFTER DELETE ON jbsakad.semester
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'semester', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `settingpsb`
--

DROP TABLE IF EXISTS `settingpsb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settingpsb` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idproses` int(10) unsigned NOT NULL,
  `kdsum1` varchar(5) DEFAULT NULL,
  `nmsum1` varchar(100) DEFAULT NULL,
  `kdsum2` varchar(5) DEFAULT NULL,
  `nmsum2` varchar(100) DEFAULT NULL,
  `kdujian1` varchar(5) DEFAULT NULL,
  `nmujian1` varchar(100) DEFAULT NULL,
  `kdujian2` varchar(5) DEFAULT NULL,
  `nmujian2` varchar(100) DEFAULT NULL,
  `kdujian3` varchar(5) DEFAULT NULL,
  `nmujian3` varchar(100) DEFAULT NULL,
  `kdujian4` varchar(5) DEFAULT NULL,
  `nmujian4` varchar(100) DEFAULT NULL,
  `kdujian5` varchar(5) DEFAULT NULL,
  `nmujian5` varchar(100) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_settingpsb_prosespsb` (`idproses`),
  CONSTRAINT `FK_settingpsb_prosespsb` FOREIGN KEY (`idproses`) REFERENCES `prosespenerimaansiswa` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settingpsb`
--

LOCK TABLES `settingpsb` WRITE;
/*!40000 ALTER TABLE `settingpsb` DISABLE KEYS */;
/*!40000 ALTER TABLE `settingpsb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `siswa`
--

DROP TABLE IF EXISTS `siswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `siswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL,
  `nisn` varchar(50) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `panggilan` varchar(30) DEFAULT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `tahunmasuk` int(10) unsigned NOT NULL,
  `idangkatan` int(10) unsigned NOT NULL,
  `idkelas` int(10) unsigned NOT NULL,
  `suku` varchar(20) NOT NULL,
  `agama` varchar(20) NOT NULL,
  `status` varchar(100) NOT NULL,
  `kondisi` varchar(100) NOT NULL,
  `kelamin` varchar(1) NOT NULL,
  `tmplahir` varchar(50) NOT NULL,
  `tgllahir` date NOT NULL,
  `warga` varchar(5) DEFAULT NULL,
  `anakke` tinyint(2) unsigned DEFAULT '0',
  `jsaudara` tinyint(2) unsigned DEFAULT '0',
  `bahasa` varchar(60) DEFAULT NULL,
  `berat` decimal(4,1) unsigned DEFAULT '0.0',
  `tinggi` decimal(4,1) unsigned DEFAULT '0.0',
  `darah` varchar(2) DEFAULT NULL,
  `foto` mediumblob,
  `alamatsiswa` varchar(255) DEFAULT NULL,
  `kodepossiswa` varchar(8) DEFAULT NULL,
  `telponsiswa` varchar(20) DEFAULT NULL,
  `hpsiswa` varchar(20) DEFAULT NULL,
  `emailsiswa` varchar(100) DEFAULT NULL,
  `kesehatan` varchar(150) DEFAULT NULL,
  `asalsekolah` varchar(100) DEFAULT NULL,
  `ketsekolah` varchar(100) DEFAULT NULL,
  `namaayah` varchar(60) DEFAULT NULL,
  `namaibu` varchar(60) DEFAULT NULL,
  `almayah` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `almibu` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pendidikanayah` varchar(20) DEFAULT NULL,
  `pendidikanibu` varchar(20) DEFAULT NULL,
  `pekerjaanayah` varchar(60) DEFAULT NULL,
  `pekerjaanibu` varchar(60) DEFAULT NULL,
  `wali` varchar(60) DEFAULT NULL,
  `penghasilanayah` int(10) unsigned DEFAULT '0',
  `penghasilanibu` int(10) unsigned DEFAULT '0',
  `alamatortu` varchar(100) DEFAULT NULL,
  `telponortu` varchar(20) DEFAULT NULL,
  `hportu` varchar(20) DEFAULT NULL,
  `emailayah` varchar(100) DEFAULT NULL,
  `alamatsurat` varchar(100) DEFAULT NULL,
  `keterangan` text,
  `frompsb` tinyint(1) unsigned DEFAULT '0',
  `ketpsb` varchar(100) DEFAULT NULL,
  `statusmutasi` int(10) unsigned DEFAULT NULL,
  `alumni` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 bukan alumni, 1 alumni',
  `pinsiswa` varchar(25) NOT NULL,
  `pinortu` varchar(25) NOT NULL,
  `pinortuibu` varchar(25) NOT NULL,
  `emailibu` varchar(100) DEFAULT NULL,
  `info1` varchar(20) DEFAULT NULL,
  `info2` varchar(20) DEFAULT NULL,
  `info3` varchar(20) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`nis`),
  UNIQUE KEY `UX_siswa_replid` (`replid`),
  KEY `FK_siswa_angkatan` (`idangkatan`),
  KEY `FK_siswa_suku` (`suku`),
  KEY `FK_siswa_agama` (`agama`),
  KEY `FK_siswa_status` (`status`),
  KEY `FK_siswa_kondisi` (`kondisi`),
  KEY `FK_siswa_pendidikanayah` (`pendidikanayah`),
  KEY `FK_siswa_pendidikanibu` (`pendidikanibu`),
  KEY `FK_siswa_pekerjaanayah` (`pekerjaanayah`),
  KEY `FK_siswa_pekerjaanibu` (`pekerjaanibu`),
  KEY `FK_siswa_statusmutasi` (`statusmutasi`),
  KEY `FK_siswa_kelas` (`idkelas`),
  KEY `FK_siswa_asalsekolah` (`asalsekolah`),
  KEY `IX_siswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_siswa_agama` FOREIGN KEY (`agama`) REFERENCES `jbsumum`.`agama` (`agama`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_angkatan` FOREIGN KEY (`idangkatan`) REFERENCES `angkatan` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_asalsekolah` FOREIGN KEY (`asalsekolah`) REFERENCES `asalsekolah` (`sekolah`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_kondisi` FOREIGN KEY (`kondisi`) REFERENCES `kondisisiswa` (`kondisi`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_pekerjaanayah` FOREIGN KEY (`pekerjaanayah`) REFERENCES `jbsumum`.`jenispekerjaan` (`pekerjaan`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_pekerjaanibu` FOREIGN KEY (`pekerjaanibu`) REFERENCES `jbsumum`.`jenispekerjaan` (`pekerjaan`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_pendidikanayah` FOREIGN KEY (`pendidikanayah`) REFERENCES `jbsumum`.`tingkatpendidikan` (`pendidikan`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_pendidikanibu` FOREIGN KEY (`pendidikanibu`) REFERENCES `jbsumum`.`tingkatpendidikan` (`pendidikan`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_status` FOREIGN KEY (`status`) REFERENCES `statussiswa` (`status`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_statusmutasi` FOREIGN KEY (`statusmutasi`) REFERENCES `jenismutasi` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_siswa_suku` FOREIGN KEY (`suku`) REFERENCES `jbsumum`.`suku` (`suku`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `siswa`
--

LOCK TABLES `siswa` WRITE;
/*!40000 ALTER TABLE `siswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `siswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_siswa BEFORE INSERT ON jbsakad.siswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_siswa BEFORE UPDATE ON jbsakad.siswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_siswa AFTER DELETE ON jbsakad.siswa
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'siswa', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `statusguru`
--

DROP TABLE IF EXISTS `statusguru`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statusguru` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`status`),
  UNIQUE KEY `UX_statusguru_replid` (`replid`),
  KEY `IX_statusguru_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statusguru`
--

LOCK TABLES `statusguru` WRITE;
/*!40000 ALTER TABLE `statusguru` DISABLE KEYS */;
INSERT INTO `statusguru` VALUES (8,'Asisten','Sekedar contoh. Menu ini mengatur status setiap guru yang mengajar di sekolah. Ubah atau tambahkan data ini sesuai dengan status guru yang ada di sekolah.',NULL,NULL,NULL,'2010-03-02 03:06:18',11638,0),(7,'Guru Honorer','',NULL,NULL,NULL,'2010-03-02 03:06:18',52760,0),(6,'Guru Pelajaran','',NULL,NULL,NULL,'2010-03-02 03:06:18',32293,0);
/*!40000 ALTER TABLE `statusguru` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_statusguru BEFORE INSERT ON jbsakad.statusguru
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_statusguru BEFORE UPDATE ON jbsakad.statusguru
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_statusguru AFTER DELETE ON jbsakad.statusguru
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'statusguru', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `statussiswa`
--

DROP TABLE IF EXISTS `statussiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statussiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(100) NOT NULL,
  `urutan` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`status`),
  UNIQUE KEY `UX_statussiswa` (`replid`),
  KEY `IX_statussiswa_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statussiswa`
--

LOCK TABLES `statussiswa` WRITE;
/*!40000 ALTER TABLE `statussiswa` DISABLE KEYS */;
INSERT INTO `statussiswa` VALUES (7,'Eksklusif',2,NULL,NULL,NULL,'2010-03-02 03:06:18',3185,0),(6,'Reguler',1,NULL,NULL,NULL,'2010-03-02 03:06:18',50107,0);
/*!40000 ALTER TABLE `statussiswa` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_statussiswa BEFORE INSERT ON jbsakad.statussiswa
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_statussiswa BEFORE UPDATE ON jbsakad.statussiswa
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_statussiswa AFTER DELETE ON jbsakad.statussiswa
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'statussiswa', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tahunajaran`
--

DROP TABLE IF EXISTS `tahunajaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tahunajaran` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tahunajaran` varchar(50) NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `tglmulai` date NOT NULL,
  `tglakhir` date NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_tahunajaran_departemen` (`departemen`),
  KEY `IX_tahunajaran_ts` (`ts`,`issync`),
  CONSTRAINT `FK_tahunajaran_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahunajaran`
--

LOCK TABLES `tahunajaran` WRITE;
/*!40000 ALTER TABLE `tahunajaran` DISABLE KEYS */;
INSERT INTO `tahunajaran` VALUES (20,'2009/2010','SMA','2009-06-01','2010-07-30',1,'Sekedar contoh. Nama tahun ajaran yang berlangsung di departemen sekolah. Ubah atau tambahkan data ini sesuai dengan nama tahun ajaran yang ada di sekolah.',NULL,NULL,NULL,'2010-03-18 02:53:06',44390,0);
/*!40000 ALTER TABLE `tahunajaran` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_tahunajaran BEFORE INSERT ON jbsakad.tahunajaran
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_tahunajaran BEFORE UPDATE ON jbsakad.tahunajaran
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_tahunajaran AFTER DELETE ON jbsakad.tahunajaran
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'tahunajaran', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tingkat`
--

DROP TABLE IF EXISTS `tingkat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tingkat` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tingkat` varchar(50) NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `urutan` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_tingkat_departemen` (`departemen`),
  KEY `IX_tingkat_ts` (`ts`,`issync`),
  CONSTRAINT `FK_tingkat_departemen` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`departemen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tingkat`
--

LOCK TABLES `tingkat` WRITE;
/*!40000 ALTER TABLE `tingkat` DISABLE KEYS */;
INSERT INTO `tingkat` VALUES (26,'10','SMA',1,'Sekedar contoh. Nama tingkatan kelas yang ada di sekolah. Ubah atau tambahkan data ini sesuai dengan nama tingkatan kelas di sekolah.',1,NULL,NULL,NULL,'2010-03-02 03:06:18',6098,0),(27,'11','SMA',1,'',2,NULL,NULL,NULL,'2010-03-02 03:06:18',28378,0),(28,'12','SMA',1,'',3,NULL,NULL,NULL,'2010-03-02 03:06:18',58064,0);
/*!40000 ALTER TABLE `tingkat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_tingkat BEFORE INSERT ON jbsakad.tingkat
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_tingkat BEFORE UPDATE ON jbsakad.tingkat
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_tingkat AFTER DELETE ON jbsakad.tingkat
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'tingkat', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ujian`
--

DROP TABLE IF EXISTS `ujian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ujian` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpelajaran` int(10) unsigned NOT NULL DEFAULT '0',
  `idkelas` int(10) unsigned NOT NULL DEFAULT '0',
  `idsemester` int(10) unsigned NOT NULL DEFAULT '0',
  `idjenis` int(10) unsigned NOT NULL DEFAULT '0',
  `deskripsi` varchar(100) NOT NULL,
  `tanggal` date NOT NULL DEFAULT '0000-00-00',
  `tglkirimSMS` date DEFAULT NULL,
  `idaturan` int(10) unsigned NOT NULL,
  `idrpp` int(10) unsigned DEFAULT NULL,
  `kode` varchar(20) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_ujian_idpelajaran` (`idpelajaran`),
  KEY `FK_ujian_idsemester` (`idsemester`),
  KEY `FK_ujian_idjenis` (`idjenis`),
  KEY `FK_ujian_idaturan` (`idaturan`),
  KEY `FK_ujian_rpp` (`idrpp`),
  KEY `FK_ujian_kelas` (`idkelas`),
  KEY `IX_ujian_ts` (`ts`,`issync`),
  CONSTRAINT `FK_ujian_idaturan` FOREIGN KEY (`idaturan`) REFERENCES `aturannhb` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_ujian_idjenis` FOREIGN KEY (`idjenis`) REFERENCES `jenisujian` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ujian_idpelajaran` FOREIGN KEY (`idpelajaran`) REFERENCES `pelajaran` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ujian_idsemester` FOREIGN KEY (`idsemester`) REFERENCES `semester` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ujian_kelas` FOREIGN KEY (`idkelas`) REFERENCES `kelas` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ujian_rpp` FOREIGN KEY (`idrpp`) REFERENCES `rpp` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ujian`
--

LOCK TABLES `ujian` WRITE;
/*!40000 ALTER TABLE `ujian` DISABLE KEYS */;
/*!40000 ALTER TABLE `ujian` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_ujian BEFORE INSERT ON jbsakad.ujian
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_ujian BEFORE UPDATE ON jbsakad.ujian
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_ujian AFTER DELETE ON jbsakad.ujian
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsakad', tablename = 'ujian', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `jbsclient`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbsclient` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbsclient`;

--
-- Table structure for table `deleteddata`
--

DROP TABLE IF EXISTS `deleteddata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleteddata` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dbname` varchar(50) NOT NULL,
  `tablename` varchar(50) NOT NULL,
  `dataid` varchar(50) NOT NULL,
  `datatoken` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_DELETEDDATA_SYNC` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleteddata`
--

LOCK TABLES `deleteddata` WRITE;
/*!40000 ALTER TABLE `deleteddata` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleteddata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exporthistory`
--

DROP TABLE IF EXISTS `exporthistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exporthistory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transferid` varchar(15) NOT NULL,
  `synctype` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `synctime` datetime NOT NULL,
  `syncfile` varchar(255) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exporthistory`
--

LOCK TABLES `exporthistory` WRITE;
/*!40000 ALTER TABLE `exporthistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `exporthistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liveupdate`
--

DROP TABLE IF EXISTS `liveupdate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveupdate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `liveupdateid` int(10) unsigned NOT NULL,
  `info` varchar(255) NOT NULL,
  `tipe` varchar(3) NOT NULL,
  `versi` varchar(15) NOT NULL,
  `tanggal` date NOT NULL,
  `repl_targetfile` varchar(255) DEFAULT NULL,
  `repl_varname` varchar(255) DEFAULT NULL,
  `repl_searchstr` varchar(255) DEFAULT NULL,
  `repl_replacestr` varchar(255) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 Disable, 1 Enable',
  `message` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`liveupdateid`),
  UNIQUE KEY `UX_liveupdate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liveupdate`
--

LOCK TABLES `liveupdate` WRITE;
/*!40000 ALTER TABLE `liveupdate` DISABLE KEYS */;
/*!40000 ALTER TABLE `liveupdate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liveupdateconfig`
--

DROP TABLE IF EXISTS `liveupdateconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveupdateconfig` (
  `tipe` varchar(20) NOT NULL,
  `nilai` varchar(45) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tipe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liveupdateconfig`
--

LOCK TABLES `liveupdateconfig` WRITE;
/*!40000 ALTER TABLE `liveupdateconfig` DISABLE KEYS */;
INSERT INTO `liveupdateconfig` VALUES ('MIN_UPDATE_ID','471','-');
/*!40000 ALTER TABLE `liveupdateconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liveupdatefile`
--

DROP TABLE IF EXISTS `liveupdatefile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveupdatefile` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `liveupdateid` int(10) unsigned NOT NULL,
  `berkas` varchar(255) NOT NULL,
  `targetdir` varchar(255) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 Disable 1 Enable',
  `tipe` varchar(4) NOT NULL DEFAULT 'DOWN' COMMENT 'DOWN | EXEC',
  PRIMARY KEY (`liveupdateid`),
  UNIQUE KEY `UX_liveupdatefile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liveupdatefile`
--

LOCK TABLES `liveupdatefile` WRITE;
/*!40000 ALTER TABLE `liveupdatefile` DISABLE KEYS */;
/*!40000 ALTER TABLE `liveupdatefile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liveupdatefile2`
--

DROP TABLE IF EXISTS `liveupdatefile2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveupdatefile2` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `liveupdateid` int(10) unsigned NOT NULL,
  `berkas` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IX_LIVEUPDATEID` (`liveupdateid`)
) ENGINE=MyISAM AUTO_INCREMENT=94 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liveupdatefile2`
--

LOCK TABLES `liveupdatefile2` WRITE;
/*!40000 ALTER TABLE `liveupdatefile2` DISABLE KEYS */;
/*!40000 ALTER TABLE `liveupdatefile2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liveupdatefiledown`
--

DROP TABLE IF EXISTS `liveupdatefiledown`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `liveupdatefiledown` (
  `liveupdateid` int(10) unsigned NOT NULL,
  `filename` varchar(150) NOT NULL,
  `filesize` int(10) unsigned NOT NULL,
  `rectime` datetime NOT NULL,
  PRIMARY KEY (`liveupdateid`,`filename`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liveupdatefiledown`
--

LOCK TABLES `liveupdatefiledown` WRITE;
/*!40000 ALTER TABLE `liveupdatefiledown` DISABLE KEYS */;
/*!40000 ALTER TABLE `liveupdatefiledown` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pkchanges`
--

DROP TABLE IF EXISTS `pkchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pkchanges` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dbname` varchar(50) CHARACTER SET latin1 NOT NULL,
  `tablename` varchar(50) CHARACTER SET latin1 NOT NULL,
  `dataid` int(10) unsigned NOT NULL,
  `datatoken` smallint(5) unsigned NOT NULL,
  `newpk` varchar(100) CHARACTER SET latin1 NOT NULL,
  `oldpk` varchar(100) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_PKCHANGES_SYNC` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pkchanges`
--

LOCK TABLES `pkchanges` WRITE;
/*!40000 ALTER TABLE `pkchanges` DISABLE KEYS */;
/*!40000 ALTER TABLE `pkchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `syncconfig`
--

DROP TABLE IF EXISTS `syncconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `syncconfig` (
  `tipe` varchar(20) NOT NULL,
  `nilai` varchar(45) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tipe`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `syncconfig`
--

LOCK TABLES `syncconfig` WRITE;
/*!40000 ALTER TABLE `syncconfig` DISABLE KEYS */;
INSERT INTO `syncconfig` VALUES ('DATABASE_ID','TVQvIxw7my9elIfRnUYYY6Z1Gw9cpcdau4Kc8jUikXpUn','Please Don\'t Change OR Delete This Value');
/*!40000 ALTER TABLE `syncconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `synchistory`
--

DROP TABLE IF EXISTS `synchistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `synchistory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(15) NOT NULL,
  `transferid` varchar(15) NOT NULL,
  `synctype` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `starttime` datetime NOT NULL,
  `endtime` datetime NOT NULL,
  `synctime` datetime NOT NULL,
  `syncfile` varchar(255) NOT NULL,
  `repopath` varchar(700) NOT NULL,
  `appid` varchar(5) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IX_SYNCHISTORY` (`method`,`synctype`,`starttime`,`appid`,`synctime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `synchistory`
--

LOCK TABLES `synchistory` WRITE;
/*!40000 ALTER TABLE `synchistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `synchistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vcontrol`
--

DROP TABLE IF EXISTS `vcontrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcontrol` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c` varchar(5) NOT NULL,
  `v` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vcontrol`
--

LOCK TABLES `vcontrol` WRITE;
/*!40000 ALTER TABLE `vcontrol` DISABLE KEYS */;
/*!40000 ALTER TABLE `vcontrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `version` varchar(10) NOT NULL,
  `builddate` datetime NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
INSERT INTO `version` VALUES ('3.2','2013-09-03 00:00:00');
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `jbsfina`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbsfina` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbsfina`;

--
-- Table structure for table `auditbesarjtt`
--

DROP TABLE IF EXISTS `auditbesarjtt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditbesarjtt` (
  `statusdata` tinyint(1) NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL,
  `nis` varchar(20) NOT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `besar` decimal(15,0) NOT NULL,
  `lunas` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `pengguna` varchar(100) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `FK_auditbesarjtt_auditinfo` (`idaudit`),
  KEY `IX_auditbesarjtt_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditbesarjtt_auditinfo` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditbesarjtt`
--

LOCK TABLES `auditbesarjtt` WRITE;
/*!40000 ALTER TABLE `auditbesarjtt` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditbesarjtt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditbesarjttcalon`
--

DROP TABLE IF EXISTS `auditbesarjttcalon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditbesarjttcalon` (
  `statusdata` tinyint(1) NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL,
  `idcalon` int(10) unsigned NOT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `besar` decimal(15,0) NOT NULL,
  `lunas` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `pengguna` varchar(100) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `FK_auditbesarjttcalon_auditinfo` (`idaudit`),
  KEY `IX_auditbesarjttcalon_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditbesarjttcalon_auditinfo` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditbesarjttcalon`
--

LOCK TABLES `auditbesarjttcalon` WRITE;
/*!40000 ALTER TABLE `auditbesarjttcalon` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditbesarjttcalon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditinfo`
--

DROP TABLE IF EXISTS `auditinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditinfo` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sumber` varchar(100) NOT NULL,
  `idsumber` int(10) unsigned NOT NULL,
  `tanggal` datetime NOT NULL,
  `petugas` varchar(100) NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `alasan` varchar(500) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_auditinfo_departemen` (`departemen`),
  KEY `IX_auditinfo_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditinfo_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditinfo`
--

LOCK TABLES `auditinfo` WRITE;
/*!40000 ALTER TABLE `auditinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditjurnal`
--

DROP TABLE IF EXISTS `auditjurnal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditjurnal` (
  `status` tinyint(1) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `transaksi` varchar(255) NOT NULL,
  `petugas` varchar(100) NOT NULL,
  `nokas` varchar(100) NOT NULL,
  `idtahunbuku` int(10) unsigned NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `sumber` varchar(40) NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `FK_auditjurnal_auditinfo` (`idaudit`),
  KEY `IX_auditjurnal_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditjurnal_auditinfo` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditjurnal`
--

LOCK TABLES `auditjurnal` WRITE;
/*!40000 ALTER TABLE `auditjurnal` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditjurnal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditjurnaldetail`
--

DROP TABLE IF EXISTS `auditjurnaldetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditjurnaldetail` (
  `status` tinyint(1) unsigned NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idjurnal` int(10) unsigned NOT NULL,
  `koderek` varchar(15) NOT NULL,
  `debet` decimal(15,0) NOT NULL DEFAULT '0',
  `kredit` decimal(15,0) NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_auditjurnaldetail_auditinfo` (`idaudit`),
  KEY `IX_auditjurnaldetail_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditjurnaldetail_auditinfo` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditjurnaldetail`
--

LOCK TABLES `auditjurnaldetail` WRITE;
/*!40000 ALTER TABLE `auditjurnaldetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditjurnaldetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditpenerimaaniuran`
--

DROP TABLE IF EXISTS `auditpenerimaaniuran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditpenerimaaniuran` (
  `statusdata` tinyint(1) unsigned NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `nis` varchar(20) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `FK_auditpenerimaaniuran_auditinfo` (`idaudit`),
  KEY `IX_auditpenerimaaniuran_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditpenerimaaniuran_auditinfo` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditpenerimaaniuran`
--

LOCK TABLES `auditpenerimaaniuran` WRITE;
/*!40000 ALTER TABLE `auditpenerimaaniuran` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditpenerimaaniuran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditpenerimaaniurancalon`
--

DROP TABLE IF EXISTS `auditpenerimaaniurancalon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditpenerimaaniurancalon` (
  `statusdata` tinyint(1) unsigned NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `idcalon` int(10) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `FK_auditpenerimaaniurancalon_audit` (`idaudit`),
  KEY `IX_auditpenerimaaniurancalon_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditpenerimaaniurancalon_audit` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditpenerimaaniurancalon`
--

LOCK TABLES `auditpenerimaaniurancalon` WRITE;
/*!40000 ALTER TABLE `auditpenerimaaniurancalon` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditpenerimaaniurancalon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditpenerimaanjtt`
--

DROP TABLE IF EXISTS `auditpenerimaanjtt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditpenerimaanjtt` (
  `statusdata` tinyint(1) NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL,
  `idbesarjtt` int(10) unsigned NOT NULL,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `FK_auditpenerimaanjtt_auditinfo` (`idaudit`),
  KEY `IX_auditpenerimaanjtt_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditpenerimaanjtt_auditinfo` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditpenerimaanjtt`
--

LOCK TABLES `auditpenerimaanjtt` WRITE;
/*!40000 ALTER TABLE `auditpenerimaanjtt` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditpenerimaanjtt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditpenerimaanjttcalon`
--

DROP TABLE IF EXISTS `auditpenerimaanjttcalon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditpenerimaanjttcalon` (
  `statusdata` tinyint(1) NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL,
  `idbesarjttcalon` int(10) unsigned NOT NULL,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `FK_auditpenerimaanjttcalon_auditinfo` (`idaudit`),
  KEY `IX_auditpenerimaanjttcalon_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditpenerimaanjttcalon_auditinfo` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditpenerimaanjttcalon`
--

LOCK TABLES `auditpenerimaanjttcalon` WRITE;
/*!40000 ALTER TABLE `auditpenerimaanjttcalon` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditpenerimaanjttcalon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditpenerimaanlain`
--

DROP TABLE IF EXISTS `auditpenerimaanlain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditpenerimaanlain` (
  `statusdata` tinyint(1) unsigned NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `sumber` varchar(100) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `FK_auditpenerimaanlain_auditinfo` (`idaudit`),
  KEY `IX_auditpenerimaanlain_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditpenerimaanlain_auditinfo` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditpenerimaanlain`
--

LOCK TABLES `auditpenerimaanlain` WRITE;
/*!40000 ALTER TABLE `auditpenerimaanlain` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditpenerimaanlain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditpengeluaran`
--

DROP TABLE IF EXISTS `auditpengeluaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditpengeluaran` (
  `statusdata` tinyint(1) unsigned NOT NULL,
  `idaudit` int(10) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL,
  `idpengeluaran` int(10) unsigned NOT NULL,
  `keperluan` varchar(255) NOT NULL,
  `jenispemohon` tinyint(1) unsigned NOT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `pemohonlain` int(10) unsigned DEFAULT NULL,
  `penerima` varchar(100) DEFAULT NULL,
  `tanggal` date NOT NULL,
  `tanggalkeluar` datetime NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `petugas` varchar(45) DEFAULT NULL,
  `idjurnal` int(10) unsigned NOT NULL,
  `keterangan` text,
  `namapemohon` varchar(100) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `FK_auditpengeluaran_auditinfo` (`idaudit`),
  KEY `IX_auditpengeluaran_ts` (`ts`,`issync`),
  CONSTRAINT `FK_auditpengeluaran_auditinfo` FOREIGN KEY (`idaudit`) REFERENCES `auditinfo` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditpengeluaran`
--

LOCK TABLES `auditpengeluaran` WRITE;
/*!40000 ALTER TABLE `auditpengeluaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditpengeluaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barang`
--

DROP TABLE IF EXISTS `barang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barang` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idkelompok` int(10) unsigned NOT NULL,
  `kode` varchar(20) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `kondisi` varchar(255) DEFAULT NULL,
  `jumlah` int(10) NOT NULL DEFAULT '0',
  `tglperolehan` date NOT NULL DEFAULT '0000-00-00',
  `foto` blob,
  `keterangan` varchar(255) DEFAULT NULL,
  `satuan` varchar(20) DEFAULT 'unit',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_barang_kelompok` (`idkelompok`),
  KEY `IX_barang_ts` (`ts`,`issync`),
  CONSTRAINT `FK_barang_kelompok` FOREIGN KEY (`idkelompok`) REFERENCES `kelompokbarang` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barang`
--

LOCK TABLES `barang` WRITE;
/*!40000 ALTER TABLE `barang` DISABLE KEYS */;
/*!40000 ALTER TABLE `barang` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_barang BEFORE INSERT ON jbsfina.barang
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_barang BEFORE UPDATE ON jbsfina.barang
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_barang AFTER DELETE ON jbsfina.barang
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'barang', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `besarjtt`
--

DROP TABLE IF EXISTS `besarjtt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `besarjtt` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `besar` decimal(15,0) NOT NULL,
  `cicilan` decimal(15,0) NOT NULL DEFAULT '0',
  `lunas` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `pengguna` varchar(100) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pembayaranjtt_siswa` (`nis`),
  KEY `FK_pembayaranjtt_penerimaan` (`idpenerimaan`),
  KEY `IX_besarjtt_ts` (`ts`,`issync`),
  CONSTRAINT `FK_besarjtt_siswa` FOREIGN KEY (`nis`) REFERENCES `jbsakad`.`siswa` (`nis`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaranjtt_penerimaan` FOREIGN KEY (`idpenerimaan`) REFERENCES `datapenerimaan` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `besarjtt`
--

LOCK TABLES `besarjtt` WRITE;
/*!40000 ALTER TABLE `besarjtt` DISABLE KEYS */;
/*!40000 ALTER TABLE `besarjtt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_besarjtt BEFORE INSERT ON jbsfina.besarjtt
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_besarjtt BEFORE UPDATE ON jbsfina.besarjtt
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trupd_besarjtt_101` AFTER UPDATE ON `besarjtt` FOR EACH ROW BEGIN
    DECLARE xidaudit int;
	DECLARE xdepartemen varchar(25); 
	
	IF (@DISABLE_TRIGGERS IS NULL) AND (@DISABLE_TRIGER IS NULL) THEN
		SELECT p.departemen INTO xdepartemen
		  FROM besarjtt b, datapenerimaan p
		 WHERE b.idpenerimaan = p.replid AND b.replid = NEW.replid;
		 
		INSERT INTO auditinfo SET departemen=xdepartemen, sumber='besarjtt', idsumber=new.replid, tanggal=now(), petugas=new.pengguna, alasan=new.info3;
		
		SELECT last_insert_id() INTO xidaudit;
		
		INSERT INTO auditbesarjtt SET statusdata=0, idaudit=xidaudit, replid=OLD.replid, nis=OLD.nis, 
			idpenerimaan=OLD.idpenerimaan, besar=OLD.besar, lunas=OLD.lunas, keterangan=OLD.keterangan, pengguna=OLD.pengguna, info1=OLD.info1, info2=OLD.info2;
		
		INSERT INTO auditbesarjtt SET statusdata=1, idaudit=xidaudit, replid=NEW.replid, nis=NEW.nis, 
			idpenerimaan=NEW.idpenerimaan, besar=NEW.besar, lunas=NEW.lunas, keterangan=NEW.keterangan, pengguna=NEW.pengguna, info1=NEW.info1, info2=NEW.info2;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_besarjtt AFTER DELETE ON jbsfina.besarjtt
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'besarjtt', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `besarjttcalon`
--

DROP TABLE IF EXISTS `besarjttcalon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `besarjttcalon` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcalon` int(10) unsigned NOT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `besar` decimal(15,0) NOT NULL,
  `cicilan` decimal(15,0) NOT NULL DEFAULT '0',
  `lunas` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `pengguna` varchar(100) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_besarjttcalon_penerimaan` (`idpenerimaan`),
  KEY `FK_besarjttcalon_calonsiswa` (`idcalon`),
  KEY `IX_besarjttcalon_ts` (`ts`,`issync`),
  CONSTRAINT `FK_besarjttcalon_calonsiswa` FOREIGN KEY (`idcalon`) REFERENCES `jbsakad`.`calonsiswa` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_besarjttcalon_penerimaan` FOREIGN KEY (`idpenerimaan`) REFERENCES `datapenerimaan` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `besarjttcalon`
--

LOCK TABLES `besarjttcalon` WRITE;
/*!40000 ALTER TABLE `besarjttcalon` DISABLE KEYS */;
/*!40000 ALTER TABLE `besarjttcalon` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_besarjttcalon BEFORE INSERT ON jbsfina.besarjttcalon
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_besarjttcalon BEFORE UPDATE ON jbsfina.besarjttcalon
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trupd_besarjttcalon_101` AFTER UPDATE ON `besarjttcalon` FOR EACH ROW BEGIN
    DECLARE xidaudit int;
	DECLARE xdepartemen varchar(25); 
	
	IF (@DISABLE_TRIGGERS IS NULL) AND (@DISABLE_TRIGER IS NULL) THEN
		SELECT p.departemen INTO xdepartemen
		FROM besarjttcalon b, datapenerimaan p
		WHERE b.idpenerimaan = p.replid AND b.replid = NEW.replid;
		 
		INSERT INTO auditinfo SET departemen=xdepartemen, sumber='besarjttcalon', idsumber=new.replid, tanggal=now(), petugas=new.pengguna, alasan=new.info3;
		
		SELECT last_insert_id() INTO xidaudit;
		
		INSERT INTO auditbesarjttcalon SET statusdata=0, idaudit=xidaudit, replid=OLD.replid, idcalon=OLD.idcalon, 
			idpenerimaan=OLD.idpenerimaan, besar=OLD.besar, lunas=OLD.lunas, keterangan=OLD.keterangan, pengguna=OLD.pengguna, info1=OLD.info1, info2=OLD.info2;
		
		INSERT INTO auditbesarjttcalon SET statusdata=1, idaudit=xidaudit, replid=NEW.replid, idcalon=NEW.idcalon, 
			idpenerimaan=NEW.idpenerimaan, besar=NEW.besar, lunas=NEW.lunas, keterangan=NEW.keterangan, pengguna=NEW.pengguna, info1=NEW.info1, info2=NEW.info2;
	END IF;		
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_besarjttcalon AFTER DELETE ON jbsfina.besarjttcalon
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'besarjttcalon', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `datadsp`
--

DROP TABLE IF EXISTS `datadsp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datadsp` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL,
  `dsp` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `operator` varchar(50) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_datadsp_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datadsp`
--

LOCK TABLES `datadsp` WRITE;
/*!40000 ALTER TABLE `datadsp` DISABLE KEYS */;
/*!40000 ALTER TABLE `datadsp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `datapenerimaan`
--

DROP TABLE IF EXISTS `datapenerimaan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datapenerimaan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `besar` decimal(15,0) DEFAULT NULL,
  `idkategori` varchar(15) NOT NULL,
  `rekkas` varchar(15) NOT NULL,
  `rekpendapatan` varchar(15) NOT NULL,
  `rekpiutang` varchar(15) DEFAULT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `departemen` varchar(50) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_datapenerimaan_rekakun_kas` (`rekkas`),
  KEY `FK_datapenerimaan_rekakun_pendapatan` (`rekpendapatan`),
  KEY `FK_datapenerimaan_rekakun_piutang` (`rekpiutang`),
  KEY `FK_datapenerimaan_kategoripenerimaan` (`idkategori`),
  KEY `FK_datapenerimaan_departemen` (`departemen`),
  KEY `IX_datapenerimaan_ts` (`ts`,`issync`),
  CONSTRAINT `FK_datapenerimaan_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_datapenerimaan_kategoripenerimaan` FOREIGN KEY (`idkategori`) REFERENCES `kategoripenerimaan` (`kode`) ON UPDATE CASCADE,
  CONSTRAINT `FK_datapenerimaan_rekakun_kas` FOREIGN KEY (`rekkas`) REFERENCES `rekakun` (`kode`) ON UPDATE CASCADE,
  CONSTRAINT `FK_datapenerimaan_rekakun_pendapatan` FOREIGN KEY (`rekpendapatan`) REFERENCES `rekakun` (`kode`) ON UPDATE CASCADE,
  CONSTRAINT `FK_datapenerimaan_rekakun_piutang` FOREIGN KEY (`rekpiutang`) REFERENCES `rekakun` (`kode`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datapenerimaan`
--

LOCK TABLES `datapenerimaan` WRITE;
/*!40000 ALTER TABLE `datapenerimaan` DISABLE KEYS */;
INSERT INTO `datapenerimaan` VALUES (9,'SPP Bulanan',NULL,'JTT','111','411','150',1,'Sekedar contoh. Menu ini mengatur setiap jenis penerimaan yang mungkin diterima sekolah. Anda harus menentukan rekening Kas, Pendapatan dan Piutang untuk setiap transaksi penerimaan.','SMA','421',NULL,NULL,'2012-01-02 00:14:49',41237,0),(11,'Dana Sumbangan Pendidikan',NULL,'CSWJB','111','412','153',1,'Sekedar contoh. Menu ini mengatur setiap jenis penerimaan yang mungkin diterima sekolah. Anda harus menentukan rekening Kas, Pendapatan dan Piutang untuk setiap transaksi penerimaan.','SMA','422',NULL,NULL,'2012-01-02 00:59:59',12756,0),(12,'Sumbangan BOS',NULL,'LNN','113','414','154',1,'Sekedar contoh. Menu ini mengatur setiap jenis penerimaan yang mungkin diterima sekolah. Anda harus menentukan rekening Kas, Pendapatan dan Piutang untuk setiap transaksi penerimaan.','SMA','424',NULL,NULL,'2012-01-02 01:01:04',5601,0),(13,'Tabungan Siswa',NULL,'SKR','112','413','150',1,'Sekedar contoh. Menu ini mengatur setiap jenis penerimaan yang mungkin diterima sekolah. Anda harus menentukan rekening Kas, Pendapatan dan Piutang untuk setiap transaksi penerimaan.','SMA','423',NULL,NULL,'2012-01-02 00:57:14',55264,0),(14,'Sumbangan Pendidikan',NULL,'CSSKR','112','415','153',1,'Sekedar contoh. Menu ini mengatur setiap jenis penerimaan yang mungkin diterima sekolah. Anda harus menentukan rekening Kas, Pendapatan dan Piutang untuk setiap transaksi penerimaan.','SMA','425',NULL,NULL,'2012-01-02 00:59:39',62929,0);
/*!40000 ALTER TABLE `datapenerimaan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_datapenerimaan BEFORE INSERT ON jbsfina.datapenerimaan
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_datapenerimaan BEFORE UPDATE ON jbsfina.datapenerimaan
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_datapenerimaan AFTER DELETE ON jbsfina.datapenerimaan
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'datapenerimaan', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `datapengeluaran`
--

DROP TABLE IF EXISTS `datapengeluaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datapengeluaran` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `departemen` varchar(50) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `rekdebet` varchar(15) NOT NULL,
  `rekkredit` varchar(15) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `besar` decimal(15,0) NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_datapengeluaran_departemen` (`departemen`),
  KEY `FK_datapengeluaran_rekakun` (`rekdebet`),
  KEY `FK_datapengeluaran_rekakun2` (`rekkredit`),
  KEY `IX_datapengeluaran_ts` (`ts`,`issync`),
  CONSTRAINT `FK_datapengeluaran_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_datapengeluaran_rekakun` FOREIGN KEY (`rekdebet`) REFERENCES `rekakun` (`kode`) ON UPDATE CASCADE,
  CONSTRAINT `FK_datapengeluaran_rekakun2` FOREIGN KEY (`rekkredit`) REFERENCES `rekakun` (`kode`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `datapengeluaran`
--

LOCK TABLES `datapengeluaran` WRITE;
/*!40000 ALTER TABLE `datapengeluaran` DISABLE KEYS */;
INSERT INTO `datapengeluaran` VALUES (4,'SMA','Bayar Listrik','501','111',1,'Sekedar contoh. Menu ini mengatur setiap jenis pengeluaran yang mungkin dikeluarkan sekolah. Anda harus menentukan rekening Kas dan Beban untuk setiap transaksi pengeluaran.',0,NULL,NULL,NULL,'2010-03-02 03:06:52',17792,0);
/*!40000 ALTER TABLE `datapengeluaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupbarang`
--

DROP TABLE IF EXISTS `groupbarang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupbarang` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `keterangan` varchar(45) DEFAULT NULL,
  `namagroup` varchar(45) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_groupbarang_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupbarang`
--

LOCK TABLES `groupbarang` WRITE;
/*!40000 ALTER TABLE `groupbarang` DISABLE KEYS */;
/*!40000 ALTER TABLE `groupbarang` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_groupbarang BEFORE INSERT ON jbsfina.groupbarang
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_groupbarang BEFORE UPDATE ON jbsfina.groupbarang
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_groupbarang AFTER DELETE ON jbsfina.groupbarang
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'groupbarang', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jurnal`
--

DROP TABLE IF EXISTS `jurnal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jurnal` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL,
  `transaksi` varchar(255) NOT NULL,
  `petugas` varchar(100) NOT NULL,
  `nokas` varchar(100) NOT NULL,
  `idtahunbuku` int(10) unsigned NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `sumber` varchar(40) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_jurnal_tahunbuku` (`idtahunbuku`),
  KEY `IX_jurnal_tanggal` (`tanggal`),
  KEY `IX_jurnal_idtahunbuku` (`idtahunbuku`),
  KEY `IX_jurnal_ts` (`ts`,`issync`),
  CONSTRAINT `FK_jurnal_tahunbuku` FOREIGN KEY (`idtahunbuku`) REFERENCES `tahunbuku` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jurnal`
--

LOCK TABLES `jurnal` WRITE;
/*!40000 ALTER TABLE `jurnal` DISABLE KEYS */;
/*!40000 ALTER TABLE `jurnal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jurnaldetail`
--

DROP TABLE IF EXISTS `jurnaldetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jurnaldetail` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idjurnal` int(10) unsigned NOT NULL,
  `koderek` varchar(15) NOT NULL,
  `debet` decimal(15,0) NOT NULL DEFAULT '0',
  `kredit` decimal(15,0) NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_jurnaldetail_jurnal` (`idjurnal`),
  KEY `IX_jurnaldetail_koderek` (`koderek`),
  KEY `IX_jurnaldetail_ts` (`ts`,`issync`),
  CONSTRAINT `FK_jurnaldetail_jurnal` FOREIGN KEY (`idjurnal`) REFERENCES `jurnal` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jurnaldetail`
--

LOCK TABLES `jurnaldetail` WRITE;
/*!40000 ALTER TABLE `jurnaldetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `jurnaldetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategoripenerimaan`
--

DROP TABLE IF EXISTS `kategoripenerimaan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategoripenerimaan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kode` varchar(10) NOT NULL,
  `kategori` varchar(100) NOT NULL,
  `urutan` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `siswa` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`kode`),
  UNIQUE KEY `Index_1` (`replid`),
  KEY `IX_kategoripenerimaan_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategoripenerimaan`
--

LOCK TABLES `kategoripenerimaan` WRITE;
/*!40000 ALTER TABLE `kategoripenerimaan` DISABLE KEYS */;
INSERT INTO `kategoripenerimaan` VALUES (4,'CSSKR','Iuran Sukarela Calon Siswa',4,1,NULL,NULL,NULL,'2010-03-02 03:06:52',31230,0),(3,'CSWJB','Iuran Wajib Calon Siswa',3,1,NULL,NULL,NULL,'2010-03-02 03:06:52',37247,0),(1,'JTT','Iuran Wajib Siswa',1,1,NULL,NULL,NULL,'2010-03-02 03:06:52',27011,0),(5,'LNN','Penerimaan Lainnya',5,1,NULL,NULL,NULL,'2010-03-02 03:06:52',23315,0),(2,'SKR','Iuran Sukarela Siswa',2,1,NULL,NULL,NULL,'2010-03-02 03:06:52',35541,0);
/*!40000 ALTER TABLE `kategoripenerimaan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_kategoripenerimaan BEFORE INSERT ON jbsfina.kategoripenerimaan
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_kategoripenerimaan BEFORE UPDATE ON jbsfina.kategoripenerimaan
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_kategoripenerimaan AFTER DELETE ON jbsfina.kategoripenerimaan
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'kategoripenerimaan', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `katerekakun`
--

DROP TABLE IF EXISTS `katerekakun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `katerekakun` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kategori` varchar(100) NOT NULL,
  `urutan` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`kategori`),
  UNIQUE KEY `Index_1` (`replid`),
  KEY `IX_katerekakun_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `katerekakun`
--

LOCK TABLES `katerekakun` WRITE;
/*!40000 ALTER TABLE `katerekakun` DISABLE KEYS */;
INSERT INTO `katerekakun` VALUES (7,'BIAYA',7,NULL,NULL,NULL,'2010-03-02 03:06:52',42231,0),(1,'HARTA',1,NULL,NULL,NULL,'2010-03-02 03:06:52',38999,0),(3,'INVENTARIS',3,NULL,NULL,NULL,'2010-03-02 03:06:52',2775,0),(5,'MODAL',5,NULL,NULL,NULL,'2010-03-02 03:06:52',27935,0),(6,'PENDAPATAN',6,NULL,NULL,NULL,'2010-03-02 03:06:52',289,0),(2,'PIUTANG',2,NULL,NULL,NULL,'2010-03-02 03:06:52',48701,0),(4,'UTANG',4,NULL,NULL,NULL,'2010-03-02 03:06:52',46047,0);
/*!40000 ALTER TABLE `katerekakun` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kelompokbarang`
--

DROP TABLE IF EXISTS `kelompokbarang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kelompokbarang` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kelompok` varchar(255) NOT NULL,
  `keterangan` varchar(45) DEFAULT NULL,
  `idgroup` int(10) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_kelompokbarang_group` (`idgroup`),
  KEY `IX_kelompokbarang_ts` (`ts`,`issync`),
  CONSTRAINT `FK_kelompokbarang_group` FOREIGN KEY (`idgroup`) REFERENCES `groupbarang` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kelompokbarang`
--

LOCK TABLES `kelompokbarang` WRITE;
/*!40000 ALTER TABLE `kelompokbarang` DISABLE KEYS */;
/*!40000 ALTER TABLE `kelompokbarang` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_kelompokbarang BEFORE INSERT ON jbsfina.kelompokbarang
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_kelompokbarang BEFORE UPDATE ON jbsfina.kelompokbarang
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_kelompokbarang AFTER DELETE ON jbsfina.kelompokbarang
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'kelompokbarang', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pemohonlain`
--

DROP TABLE IF EXISTS `pemohonlain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pemohonlain` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_pemohonlain_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pemohonlain`
--

LOCK TABLES `pemohonlain` WRITE;
/*!40000 ALTER TABLE `pemohonlain` DISABLE KEYS */;
/*!40000 ALTER TABLE `pemohonlain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penerimaaniuran`
--

DROP TABLE IF EXISTS `penerimaaniuran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penerimaaniuran` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `nis` varchar(20) NOT NULL,
  `alasan` varchar(500) DEFAULT '" "',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pembayaraniuran_jurnal` (`idjurnal`),
  KEY `FK_pembayaraniuran_datapenerimaan` (`idpenerimaan`),
  KEY `FK_pembayaraniuran_siswa` (`nis`),
  KEY `IX_penerimaaniuran_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pembayaraniuran_datapenerimaan` FOREIGN KEY (`idpenerimaan`) REFERENCES `datapenerimaan` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaraniuran_jurnal` FOREIGN KEY (`idjurnal`) REFERENCES `jurnal` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaraniuran_siswa` FOREIGN KEY (`nis`) REFERENCES `jbsakad`.`siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penerimaaniuran`
--

LOCK TABLES `penerimaaniuran` WRITE;
/*!40000 ALTER TABLE `penerimaaniuran` DISABLE KEYS */;
/*!40000 ALTER TABLE `penerimaaniuran` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_penerimaaniuran BEFORE INSERT ON jbsfina.penerimaaniuran
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trins_penerimaaniuran_100` AFTER INSERT ON `penerimaaniuran` FOR EACH ROW BEGIN
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xdepartemen varchar(25);
	
    select transaksi, nokas, idtahunbuku, keterangan 
    	into xinfo, xnokas, xidtahunbuku, xketerangan 
    	from jurnal where replid = new.idjurnal;
    
    select departemen into xdepartemen
    	from datapenerimaan
    	where replid = new.idpenerimaan; 
		
    insert into transaksilog set sumber='penerimaaniuran', idsumber=new.replid, 
    	tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
    	idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=new.jumlah, kredit=0, departemen=xdepartemen;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_penerimaaniuran BEFORE UPDATE ON jbsfina.penerimaaniuran
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trupd_penerimaaniuran_101` AFTER UPDATE ON `penerimaaniuran` FOR EACH ROW BEGIN
	declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xidaudit int;
    declare xdepartemen varchar(25);
	
	IF @DISABLE_TRIGER IS NULL THEN
	
		select transaksi, nokas, idtahunbuku, keterangan 
			into xinfo, xnokas, xidtahunbuku, xketerangan 
			from jurnal where replid = new.idjurnal;
		
		select departemen into xdepartemen
			from datapenerimaan
			where replid = new.idpenerimaan; 
			
		update transaksilog set tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
			idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=new.jumlah, kredit=0 
			where sumber='penerimaaniuran' and idsumber=new.replid;
		
		IF new.tanggal <> old.tanggal THEN
			update jurnal set tanggal = new.tanggal where replid = new.idjurnal;
		END IF;	
		
		insert into auditinfo set departemen=xdepartemen, sumber='penerimaaniuran', idsumber=new.replid, tanggal=now(), petugas=new.petugas, alasan=new.alasan;
		
		select last_insert_id() into xidaudit;
		
		insert into auditpenerimaaniuran set statusdata=0, idaudit=xidaudit, replid=old.replid, idjurnal=old.idjurnal, 
			tanggal=old.tanggal, jumlah=old.jumlah, keterangan=old.keterangan, petugas=old.petugas, idpenerimaan=old.idpenerimaan,
			nis=old.nis;
		
		insert into auditpenerimaaniuran set statusdata=1, idaudit=xidaudit, replid=new.replid, idjurnal=new.idjurnal, 
			tanggal=new.tanggal, jumlah=new.jumlah, keterangan=new.keterangan, petugas=new.petugas, idpenerimaan=new.idpenerimaan,
			nis=new.nis;
		
	END IF;
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_penerimaaniuran AFTER DELETE ON jbsfina.penerimaaniuran
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'penerimaaniuran', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `penerimaaniurancalon`
--

DROP TABLE IF EXISTS `penerimaaniurancalon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penerimaaniurancalon` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `idcalon` int(10) unsigned NOT NULL,
  `alasan` varchar(500) DEFAULT '" "',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_penerimaaniurancalon_datapenerimaan` (`idpenerimaan`),
  KEY `FK_penerimaaniurancalon_calon` (`idcalon`),
  KEY `FK_penerimaaniurancalon_jurnal` (`idjurnal`),
  KEY `IX_penerimaaniurancalon_ts` (`ts`,`issync`),
  CONSTRAINT `FK_penerimaaniurancalon_calon` FOREIGN KEY (`idcalon`) REFERENCES `jbsakad`.`calonsiswa` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_penerimaaniurancalon_datapenerimaan` FOREIGN KEY (`idpenerimaan`) REFERENCES `datapenerimaan` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_penerimaaniurancalon_jurnal` FOREIGN KEY (`idjurnal`) REFERENCES `jurnal` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penerimaaniurancalon`
--

LOCK TABLES `penerimaaniurancalon` WRITE;
/*!40000 ALTER TABLE `penerimaaniurancalon` DISABLE KEYS */;
/*!40000 ALTER TABLE `penerimaaniurancalon` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_penerimaaniurancalon BEFORE INSERT ON jbsfina.penerimaaniurancalon
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trins_penerimaaniurancalon_100` AFTER INSERT ON `penerimaaniurancalon` FOR EACH ROW BEGIN
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xdepartemen varchar(25);
	
    select transaksi, nokas, idtahunbuku, keterangan 
    	into xinfo, xnokas, xidtahunbuku, xketerangan 
    	from jurnal where replid = new.idjurnal;
    
    select departemen into xdepartemen
    	from datapenerimaan
    	where replid = new.idpenerimaan; 
		
    insert into transaksilog set sumber='penerimaaniurancalon', idsumber=new.replid, 
    	tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
    	idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=new.jumlah, kredit=0, departemen=xdepartemen;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_penerimaaniurancalon BEFORE UPDATE ON jbsfina.penerimaaniurancalon
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trupd_penerimaaniurancalon_101` AFTER UPDATE ON `penerimaaniurancalon` FOR EACH ROW BEGIN
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xidaudit int;
    declare xdepartemen varchar(25);
	
	IF @DISABLE_TRIGER IS NULL THEN
	
		select transaksi, nokas, idtahunbuku, keterangan 
			into xinfo, xnokas, xidtahunbuku, xketerangan 
			from jurnal where replid = new.idjurnal;
		
		select departemen into xdepartemen
			from datapenerimaan
			where replid = new.idpenerimaan; 
			
		update transaksilog set tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
			idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=new.jumlah, kredit=0 
			where sumber='penerimaaniurancalon' and idsumber=new.replid;
			
		IF new.tanggal <> old.tanggal THEN
			update jurnal set tanggal = new.tanggal where replid = new.idjurnal;
		END IF;	
		
		insert into auditinfo set departemen=xdepartemen, sumber='penerimaaniurancalon', idsumber=new.replid, tanggal=now(), petugas=new.petugas, alasan=new.alasan;
		
		select last_insert_id() into xidaudit;
		
		insert into auditpenerimaaniurancalon set statusdata=0, idaudit=xidaudit, replid=old.replid, idjurnal=old.idjurnal, 
			tanggal=old.tanggal, jumlah=old.jumlah, keterangan=old.keterangan, petugas=old.petugas, idpenerimaan=old.idpenerimaan,
			idcalon=old.idcalon;
		
		insert into auditpenerimaaniurancalon set statusdata=1, idaudit=xidaudit, replid=new.replid, idjurnal=new.idjurnal, 
			tanggal=new.tanggal, jumlah=new.jumlah, keterangan=new.keterangan, petugas=new.petugas, idpenerimaan=new.idpenerimaan,
			idcalon=new.idcalon;
	
	END IF;	
    		
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_penerimaaniurancalon AFTER DELETE ON jbsfina.penerimaaniurancalon
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'penerimaaniurancalon', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `penerimaanjtt`
--

DROP TABLE IF EXISTS `penerimaanjtt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penerimaanjtt` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idbesarjtt` int(10) unsigned NOT NULL,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `alasan` varchar(500) DEFAULT ' ',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pembayaranjtt_besatjtt` (`idbesarjtt`),
  KEY `FK_pembayaranjtt_jurnal` (`idjurnal`),
  KEY `IX_penerimaanjtt_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pembayaranjtt_besatjtt` FOREIGN KEY (`idbesarjtt`) REFERENCES `besarjtt` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaranjtt_jurnal` FOREIGN KEY (`idjurnal`) REFERENCES `jurnal` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penerimaanjtt`
--

LOCK TABLES `penerimaanjtt` WRITE;
/*!40000 ALTER TABLE `penerimaanjtt` DISABLE KEYS */;
/*!40000 ALTER TABLE `penerimaanjtt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_penerimaanjtt BEFORE INSERT ON jbsfina.penerimaanjtt
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trins_penerimaanjtt_100` AFTER INSERT ON `penerimaanjtt` FOR EACH ROW BEGIN
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xdepartemen varchar(25);
    
    select transaksi, nokas, idtahunbuku, keterangan 
    	into xinfo, xnokas, xidtahunbuku, xketerangan 
    	from jurnal where replid = new.idjurnal;
    
    select p.departemen into xdepartemen
    	from besarjtt b, datapenerimaan p
    	where b.idpenerimaan = p.replid and b.replid = new.idbesarjtt;
    
    insert into transaksilog set sumber='penerimaanjtt', idsumber=new.replid, 
    	tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
    	idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=new.jumlah, kredit=0, departemen=xdepartemen;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_penerimaanjtt BEFORE UPDATE ON jbsfina.penerimaanjtt
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trupd_penerimaanjtt_102 AFTER UPDATE ON jbsfina.penerimaanjtt
FOR EACH ROW BEGIN 
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xidaudit int;
    declare xdepartemen varchar(25);
	
	IF @DISABLE_TRIGER IS NULL THEN
	
		select transaksi, nokas, idtahunbuku, keterangan 
			into xinfo, xnokas, xidtahunbuku, xketerangan
			from jurnal where replid = new.idjurnal;
			
		select p.departemen into xdepartemen
			from besarjtt b, datapenerimaan p
			where b.idpenerimaan = p.replid and b.replid = new.idbesarjtt;
			
		update transaksilog set tanggal = new.tanggal, transaksi = xinfo, petugas = new.petugas, nokas = xnokas, 
			idtahunbuku = xidtahunbuku, keterangan = xketerangan, debet = new.jumlah, kredit = 0 
			where sumber='penerimaanjtt' and idsumber=new.replid;
			
		IF new.tanggal <> old.tanggal THEN
			update jurnal set tanggal = new.tanggal where replid = new.idjurnal;
		END IF;
			
		insert into auditinfo set departemen=xdepartemen, sumber='penerimaanjtt', idsumber=new.replid, tanggal=now(), petugas=new.petugas, alasan=new.alasan;
		
		select last_insert_id() into xidaudit;
		
		insert into auditpenerimaanjtt set statusdata=0, idaudit=xidaudit, replid=old.replid, idbesarjtt=old.idbesarjtt, 
			idjurnal=old.idjurnal, tanggal=old.tanggal, jumlah=old.jumlah, keterangan=old.keterangan, petugas=old.petugas, info1=old.info1, info2=old.info2, info3=old.info3;
			
		insert into auditpenerimaanjtt set statusdata=1, idaudit=xidaudit, replid=new.replid, idbesarjtt=new.idbesarjtt, 
			idjurnal=new.idjurnal, tanggal=new.tanggal, jumlah=new.jumlah, keterangan=new.keterangan, petugas=new.petugas, info1=new.info1, info2=new.info2, info3=new.info3;
		
	END IF;		
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_penerimaanjtt AFTER DELETE ON jbsfina.penerimaanjtt
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'penerimaanjtt', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `penerimaanjttcalon`
--

DROP TABLE IF EXISTS `penerimaanjttcalon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penerimaanjttcalon` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idbesarjttcalon` int(10) unsigned NOT NULL,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `alasan` varchar(500) DEFAULT '" "',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_penerimaanjttcalon_jurnal` (`idjurnal`),
  KEY `FK_penerimaanjttcalon_besarjtt` (`idbesarjttcalon`),
  KEY `IX_penerimaanjttcalon_ts` (`ts`,`issync`),
  CONSTRAINT `FK_penerimaanjttcalon_besarjttcalon` FOREIGN KEY (`idbesarjttcalon`) REFERENCES `besarjttcalon` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_penerimaanjttcalon_jurnal` FOREIGN KEY (`idjurnal`) REFERENCES `jurnal` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penerimaanjttcalon`
--

LOCK TABLES `penerimaanjttcalon` WRITE;
/*!40000 ALTER TABLE `penerimaanjttcalon` DISABLE KEYS */;
/*!40000 ALTER TABLE `penerimaanjttcalon` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_penerimaanjttcalon BEFORE INSERT ON jbsfina.penerimaanjttcalon
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trins_penerimaanjttcalon_100` AFTER INSERT ON `penerimaanjttcalon` FOR EACH ROW BEGIN
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xdepartemen varchar(25);
    
    select transaksi, nokas, idtahunbuku, keterangan 
    	into xinfo, xnokas, xidtahunbuku, xketerangan 
    	from jurnal where replid = new.idjurnal;
    
    select p.departemen into xdepartemen
    	from besarjttcalon b, datapenerimaan p
    	where b.idpenerimaan = p.replid and b.replid = new.idbesarjttcalon;
    
    insert into transaksilog set sumber='penerimaanjttcalon', idsumber=new.replid, 
    	tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
    	idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=new.jumlah, kredit=0, departemen=xdepartemen;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_penerimaanjttcalon BEFORE UPDATE ON jbsfina.penerimaanjttcalon
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trupd_penerimaanjttcalon_102 AFTER UPDATE ON jbsfina.penerimaanjttcalon
FOR EACH ROW BEGIN 
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xidaudit int;
    declare xdepartemen varchar(25);
	
	IF @DISABLE_TRIGER IS NULL THEN
	
		select transaksi, nokas, idtahunbuku, keterangan 
			into xinfo, xnokas, xidtahunbuku, xketerangan
			from jurnal where replid = new.idjurnal;
			
		select p.departemen into xdepartemen
			from besarjttcalon b, datapenerimaan p
			where b.idpenerimaan = p.replid and b.replid = new.idbesarjttcalon;
			
		update transaksilog set tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
			idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=new.jumlah, kredit=0 
			where sumber='penerimaanjttcalon' and idsumber=new.replid;
		
		IF new.tanggal <> old.tanggal THEN
			update jurnal set tanggal = new.tanggal where replid = new.idjurnal;
		END IF;
			
		insert into auditinfo set departemen=xdepartemen, sumber='penerimaanjttcalon', idsumber=new.replid, tanggal=now(), petugas=  new.petugas, alasan=new.alasan;
		
		select last_insert_id() into xidaudit;
		
		insert into auditpenerimaanjttcalon set statusdata=0, idaudit=xidaudit, replid=old.replid, idbesarjttcalon=old.idbesarjttcalon, idjurnal=old.idjurnal, tanggal=old.tanggal, jumlah=old.jumlah, keterangan=old.keterangan, petugas=old.petugas, info1=old.info1, info2=old.info2, info3=old.info3;
		
		insert into auditpenerimaanjttcalon set statusdata=1, idaudit=xidaudit, replid=new.replid, idbesarjttcalon=new.idbesarjttcalon, idjurnal=new.idjurnal, tanggal=new.tanggal, jumlah=new.jumlah, keterangan=new.keterangan, petugas=new.petugas, info1=new.info1, info2=new.info2, info3=new.info3;

	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_penerimaanjttcalon AFTER DELETE ON jbsfina.penerimaanjttcalon
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'penerimaanjttcalon', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `penerimaanlain`
--

DROP TABLE IF EXISTS `penerimaanlain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penerimaanlain` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idjurnal` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `petugas` varchar(100) DEFAULT NULL,
  `idpenerimaan` int(10) unsigned NOT NULL,
  `sumber` varchar(100) NOT NULL,
  `alasan` varchar(500) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pembayaranlain_jurnal` (`idjurnal`),
  KEY `FK_pembayaranlain_datapenerimaan` (`idpenerimaan`),
  KEY `IX_penerimaanlain_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pembayaranlain_datapenerimaan` FOREIGN KEY (`idpenerimaan`) REFERENCES `datapenerimaan` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pembayaranlain_jurnal` FOREIGN KEY (`idjurnal`) REFERENCES `jurnal` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penerimaanlain`
--

LOCK TABLES `penerimaanlain` WRITE;
/*!40000 ALTER TABLE `penerimaanlain` DISABLE KEYS */;
/*!40000 ALTER TABLE `penerimaanlain` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trins_penerimaanlain_100` AFTER INSERT ON `penerimaanlain` FOR EACH ROW BEGIN
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xdepartemen varchar(25);
	
    select transaksi, nokas, idtahunbuku, keterangan 
    	into xinfo, xnokas, xidtahunbuku, xketerangan 
    	from jurnal where replid = new.idjurnal;
    
    select departemen into xdepartemen
    	from datapenerimaan
    	where replid = new.idpenerimaan; 
		
    insert into transaksilog set sumber='penerimaanlain', idsumber=new.replid, 
    	tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
    	idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=new.jumlah, kredit=0, departemen=xdepartemen;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trupd_penerimaanlain_101` AFTER UPDATE ON `penerimaanlain` FOR EACH ROW BEGIN
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xidaudit int;
    declare xdepartemen varchar(25);
	
	IF @DISABLE_TRIGER IS NULL THEN
	
		select transaksi, nokas, idtahunbuku, keterangan 
			into xinfo, xnokas, xidtahunbuku, xketerangan 
			from jurnal where replid = new.idjurnal;
			
		select departemen into xdepartemen
			from datapenerimaan
			where replid = new.idpenerimaan; 
			
		update transaksilog set tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
			idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=new.jumlah, kredit=0 
			where sumber='penerimaanlain' and idsumber=new.replid;
		
		IF new.tanggal <> old.tanggal THEN
			update jurnal set tanggal = new.tanggal where replid = new.idjurnal;
		END IF;	
		
		insert into auditinfo set departemen=xdepartemen, sumber='penerimaanlain', idsumber=new.replid, tanggal=now(), petugas=new.petugas, alasan=new.alasan;
		
		select last_insert_id() into xidaudit;
		
		insert into auditpenerimaanlain set statusdata=0, idaudit=xidaudit, replid=old.replid, idjurnal=old.idjurnal, 
			tanggal=old.tanggal, jumlah=old.jumlah, keterangan=old.keterangan, petugas=old.petugas, idpenerimaan=old.idpenerimaan,
			sumber=old.sumber;
			
		insert into auditpenerimaanlain set statusdata=1, idaudit=xidaudit, replid=new.replid, idjurnal=new.idjurnal, 
			tanggal=new.tanggal, jumlah=new.jumlah, keterangan=new.keterangan, petugas=new.petugas, idpenerimaan=new.idpenerimaan,
			sumber=new.sumber;
		
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pengeluaran`
--

DROP TABLE IF EXISTS `pengeluaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pengeluaran` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpengeluaran` int(10) unsigned NOT NULL,
  `keperluan` varchar(255) NOT NULL,
  `jenispemohon` tinyint(1) unsigned NOT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `pemohonlain` int(10) unsigned DEFAULT NULL,
  `penerima` varchar(100) DEFAULT NULL,
  `tanggal` date NOT NULL,
  `tanggalkeluar` datetime NOT NULL,
  `jumlah` decimal(15,0) NOT NULL,
  `petugas` varchar(45) DEFAULT NULL,
  `idjurnal` int(10) unsigned NOT NULL,
  `keterangan` text,
  `namapemohon` varchar(100) NOT NULL,
  `alasan` varchar(500) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pengeluaran_nis` (`nis`),
  KEY `FK_pengeluaran_nip` (`nip`),
  KEY `FK_pengeluaran_jurnal` (`idjurnal`),
  KEY `FK_pengeluaran_pemohonlain` (`pemohonlain`),
  KEY `IX_pengeluaran_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pengeluaran_jurnal` FOREIGN KEY (`idjurnal`) REFERENCES `jurnal` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pengeluaran_nip` FOREIGN KEY (`nip`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pengeluaran_nis` FOREIGN KEY (`nis`) REFERENCES `jbsakad`.`siswa` (`nis`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pengeluaran_pemohonlain` FOREIGN KEY (`pemohonlain`) REFERENCES `pemohonlain` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengeluaran`
--

LOCK TABLES `pengeluaran` WRITE;
/*!40000 ALTER TABLE `pengeluaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `pengeluaran` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trins_pengeluaran_100` AFTER INSERT ON `pengeluaran` FOR EACH ROW BEGIN
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xdepartemen varchar(25);
	
    select transaksi, nokas, idtahunbuku, keterangan 
    	into xinfo, xnokas, xidtahunbuku, xketerangan 
    	from jurnal where replid = new.idjurnal;
    
    select departemen into xdepartemen
    	from datapengeluaran
    	where replid = new.idpengeluaran;
		
    insert into transaksilog set sumber='pengeluaran', idsumber=new.replid, 
    	tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
    	idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=0, kredit=new.jumlah, departemen=xdepartemen;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `trupd_pengeluaran_100` AFTER UPDATE ON `pengeluaran` FOR EACH ROW BEGIN
    declare xinfo varchar(255);
    declare xnokas varchar(100);
    declare xidtahunbuku int;
    declare xketerangan varchar(255);
    declare xidaudit int;
    declare xdepartemen varchar(25);
	
    select transaksi, nokas, idtahunbuku, keterangan 
    	into xinfo, xnokas, xidtahunbuku, xketerangan 
    	from jurnal where replid = new.idjurnal;
    	
    select departemen into xdepartemen
    	from datapengeluaran
    	where replid = new.idpengeluaran;
		
    update transaksilog set tanggal=new.tanggal, transaksi=xinfo, petugas=new.petugas, nokas=xnokas, 
    	idtahunbuku=xidtahunbuku, keterangan=xketerangan, debet=0, kredit=new.jumlah
    	where sumber='pengeluaran' and idsumber=new.replid;
	
	IF new.tanggal <> old.tanggal THEN
        update jurnal set tanggal = new.tanggal where replid = new.idjurnal;
    END IF;	
    
    insert into auditinfo set departemen=xdepartemen, sumber='pengeluaran', idsumber=new.replid, tanggal=now(), petugas=new.petugas, alasan=new.alasan;
    
    select last_insert_id() into xidaudit;
    
    insert into auditpengeluaran set statusdata=0, idaudit=xidaudit, replid=old.replid, idpengeluaran=old.idpengeluaran, 
    	keperluan=old.keperluan, jenispemohon=old.jenispemohon, nip=old.nip, nis=old.nis, pemohonlain=old.pemohonlain, 
    	penerima=old.penerima, tanggal=old.tanggal, tanggalkeluar=old.tanggalkeluar, jumlah=old.jumlah, petugas=old.petugas,
    	idjurnal=old.idjurnal, keterangan=old.keterangan, namapemohon=old.namapemohon;
    
    insert into auditpengeluaran set statusdata=1, idaudit=xidaudit, replid=new.replid, idpengeluaran=new.idpengeluaran, 
    	keperluan=new.keperluan, jenispemohon=new.jenispemohon, nip=new.nip, nis=new.nis, pemohonlain=new.pemohonlain, 
    	penerima=new.penerima, tanggal=new.tanggal, tanggalkeluar=new.tanggalkeluar, jumlah=new.jumlah, petugas=new.petugas,
    	idjurnal=new.idjurnal, keterangan=new.keterangan, namapemohon=new.namapemohon;
    		
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pengguna`
--

DROP TABLE IF EXISTS `pengguna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pengguna` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `tingkat` tinyint(1) unsigned NOT NULL,
  `departemen` varchar(50) CHARACTER SET latin1 NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `password` varchar(100) NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pengguna_pegawai` (`nip`),
  KEY `IX_pengguna_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pengguna_pegawai` FOREIGN KEY (`nip`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengguna`
--

LOCK TABLES `pengguna` WRITE;
/*!40000 ALTER TABLE `pengguna` DISABLE KEYS */;
/*!40000 ALTER TABLE `pengguna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rekakun`
--

DROP TABLE IF EXISTS `rekakun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rekakun` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kode` varchar(15) NOT NULL,
  `kategori` varchar(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`kode`),
  UNIQUE KEY `UX_rekakun` (`replid`),
  KEY `FK_rekakun_katerekakun` (`kategori`),
  KEY `IX_rekakun_ts` (`ts`,`issync`),
  CONSTRAINT `FK_rekakun_katerekakun` FOREIGN KEY (`kategori`) REFERENCES `katerekakun` (`kategori`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rekakun`
--

LOCK TABLES `rekakun` WRITE;
/*!40000 ALTER TABLE `rekakun` DISABLE KEYS */;
INSERT INTO `rekakun` VALUES (1,'111','HARTA','Kas','Kas yang ada disekolah',NULL,NULL,NULL,'2010-03-02 03:06:53',18600,0),(2,'112','HARTA','Kas Bank','Kas yang ada di bank yang digunakan sekolah',NULL,NULL,NULL,'2010-03-02 03:06:53',20390,0),(3,'113','HARTA','Kas BOS','Kas yang diterima dari sumbangan Bantuan Operasional Sekolah',NULL,NULL,NULL,'2010-03-02 03:06:53',46147,0),(4,'150','PIUTANG','Piutang Siswa','Piutang siswa kepada sekolah',NULL,NULL,NULL,'2010-03-02 03:06:53',38508,0),(5,'151','PIUTANG','Piutang Karyawan','Piutang karyawan kepada sekolah',NULL,NULL,NULL,'2010-03-02 03:06:53',54096,0),(6,'152','PIUTANG','Piutang Usaha','Piutang yang lain kepada sekolah',NULL,NULL,NULL,'2010-03-02 03:06:53',23895,0),(24,'153','PIUTANG','Piutang Calon Siswa','',NULL,NULL,NULL,'2012-01-02 00:58:13',0,0),(27,'154','PIUTANG','Piutang BOS','',NULL,NULL,NULL,'2012-01-02 01:00:51',0,0),(7,'411','PENDAPATAN','Pendapatan SPP','Pendapatan dari pembayaran SPP siswa',NULL,NULL,NULL,'2010-03-02 03:06:53',22719,0),(8,'412','PENDAPATAN','Pendapatan DSP','Pendapatan dari pembayaran DSP siswa',NULL,NULL,NULL,'2010-03-02 03:06:53',41907,0),(9,'413','PENDAPATAN','Pendapatan Sukarela Siswa','Pendapatan dari perolehan dana sukarela',NULL,NULL,NULL,'2010-03-02 03:06:53',10317,0),(10,'414','PENDAPATAN','Pendapatan BOS','Pendaptan dari penerimaan sumbangan Bantuan Operasional Sekolah (BOS)',NULL,NULL,NULL,'2010-03-02 03:06:53',56924,0),(25,'415','PENDAPATAN','Pendapatan Sukarela Calon Siswa','',NULL,NULL,NULL,'2012-01-02 00:58:41',0,0),(20,'421','PENDAPATAN','Diskon SPP','',NULL,NULL,NULL,'2012-01-02 00:14:27',0,0),(21,'422','PENDAPATAN','Diskon DSP','',NULL,NULL,NULL,'2012-01-02 00:56:29',0,0),(22,'423','PENDAPATAN','Diskon Sukarela Siswa','',NULL,NULL,NULL,'2012-01-02 00:56:43',0,0),(23,'424','PENDAPATAN','Diskon BOS','',NULL,NULL,NULL,'2012-01-02 00:56:53',0,0),(26,'425','PENDAPATAN','Diskon Sukarela Calon Siswa','',NULL,NULL,NULL,'2012-01-02 00:59:15',0,0),(11,'500','BIAYA','Beban Transportasi','Beban yang dikeluarkan untuk pembiayaan transportasi',NULL,NULL,NULL,'2010-03-02 03:06:53',57077,0),(12,'501','BIAYA','Beban Listrik','Beban yang dikeluarkan untuk melunasi tagihan PLN',NULL,NULL,NULL,'2010-03-02 03:06:53',49084,0),(13,'502','BIAYA','Beban Telpon','Beban yang dikeluarkan untuk pembiayaan tagihan telpon',NULL,NULL,NULL,'2010-03-02 03:06:53',8658,0),(14,'503','BIAYA','Beban Internet','Beban yang dikeluarkan untuk pembiayaan taghan Internet',NULL,NULL,NULL,'2010-03-02 03:06:53',27097,0),(15,'504','BIAYA','Beban ATK','Beban yang dikeluarkan untuk pembelian rutin ATK',NULL,NULL,NULL,'2010-03-02 03:06:53',43981,0),(16,'611','INVENTARIS','Peralatan Mengajar','Inventaris alat-alat kegiatan belajar mengajar',NULL,NULL,NULL,'2010-03-02 03:06:53',7554,0),(17,'612','INVENTARIS','Kendaraan','Inventaris kendaraan sekolah',NULL,NULL,NULL,'2010-03-02 03:06:53',36888,0),(18,'700','MODAL','Modal Usaha','Modal yang ditanamkan oleh pemodal kepada sekolah',NULL,NULL,NULL,'2010-03-02 03:06:53',30715,0),(19,'900','UTANG','Utang Usaha','Utang sekolah kepada kreditur',NULL,NULL,NULL,'2010-03-02 03:06:53',42913,0);
/*!40000 ALTER TABLE `rekakun` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tahunbuku`
--

DROP TABLE IF EXISTS `tahunbuku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tahunbuku` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tahunbuku` varchar(100) NOT NULL,
  `awalan` varchar(5) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `cacah` bigint(20) unsigned NOT NULL DEFAULT '0',
  `departemen` varchar(50) NOT NULL,
  `tanggalmulai` date NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_tahunbuku_departemen` (`departemen`),
  KEY `IX_tahunbuku_ts` (`ts`,`issync`),
  CONSTRAINT `FK_tahunbuku_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahunbuku`
--

LOCK TABLES `tahunbuku` WRITE;
/*!40000 ALTER TABLE `tahunbuku` DISABLE KEYS */;
/*!40000 ALTER TABLE `tahunbuku` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_tahunbuku BEFORE INSERT ON jbsfina.tahunbuku
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_tahunbuku BEFORE UPDATE ON jbsfina.tahunbuku
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_tahunbuku AFTER DELETE ON jbsfina.tahunbuku
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsfina', tablename = 'tahunbuku', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `transaksilog`
--

DROP TABLE IF EXISTS `transaksilog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaksilog` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sumber` varchar(45) NOT NULL,
  `idsumber` int(10) unsigned NOT NULL,
  `tanggal` date NOT NULL,
  `transaksi` varchar(255) NOT NULL,
  `petugas` varchar(100) NOT NULL,
  `nokas` varchar(100) NOT NULL,
  `idtahunbuku` int(10) unsigned NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `debet` decimal(15,0) NOT NULL DEFAULT '0',
  `kredit` decimal(15,0) NOT NULL DEFAULT '0',
  `departemen` varchar(50) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_transaksilog_departemen` (`departemen`),
  KEY `IX_transaksilog_ts` (`ts`,`issync`),
  CONSTRAINT `FK_transaksilog_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaksilog`
--

LOCK TABLES `transaksilog` WRITE;
/*!40000 ALTER TABLE `transaksilog` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaksilog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `jbsperpus`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbsperpus` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbsperpus`;

--
-- Table structure for table `aktivitas`
--

DROP TABLE IF EXISTS `aktivitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aktivitas` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `aktivitas` text,
  `perpustakaan` int(10) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_aktivitas_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aktivitas`
--

LOCK TABLES `aktivitas` WRITE;
/*!40000 ALTER TABLE `aktivitas` DISABLE KEYS */;
/*!40000 ALTER TABLE `aktivitas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anggota`
--

DROP TABLE IF EXISTS `anggota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anggota` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `noregistrasi` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL DEFAULT '',
  `alamat` varchar(255) NOT NULL,
  `kodepos` varchar(6) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telpon` varchar(100) DEFAULT NULL,
  `HP` varchar(100) DEFAULT NULL,
  `pekerjaan` varchar(100) DEFAULT NULL,
  `institusi` varchar(100) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `tgldaftar` date NOT NULL DEFAULT '0000-00-00',
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `foto` blob,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  UNIQUE KEY `Index_nopen` (`noregistrasi`),
  KEY `IX_anggota_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='InnoDB free: 2020352 kB; InnoDB free: 2020352 kB; (`NoRegist';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anggota`
--

LOCK TABLES `anggota` WRITE;
/*!40000 ALTER TABLE `anggota` DISABLE KEYS */;
/*!40000 ALTER TABLE `anggota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daftarpustaka`
--

DROP TABLE IF EXISTS `daftarpustaka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daftarpustaka` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pustaka` int(10) unsigned NOT NULL,
  `perpustakaan` int(10) unsigned NOT NULL,
  `kodepustaka` varchar(45) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 dipinjam, 1 tersedia',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  UNIQUE KEY `UX_daftarpustaka` (`kodepustaka`),
  KEY `FK_daftarpustaka_perpus` (`perpustakaan`),
  KEY `FK_daftarpustaka_pustaka` (`pustaka`),
  KEY `IX_daftarpustaka_ts` (`ts`,`issync`),
  CONSTRAINT `FK_daftarpustaka_perpus` FOREIGN KEY (`perpustakaan`) REFERENCES `perpustakaan` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_daftarpustaka_pustaka` FOREIGN KEY (`pustaka`) REFERENCES `pustaka` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daftarpustaka`
--

LOCK TABLES `daftarpustaka` WRITE;
/*!40000 ALTER TABLE `daftarpustaka` DISABLE KEYS */;
/*!40000 ALTER TABLE `daftarpustaka` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_daftarpustaka BEFORE INSERT ON jbsperpus.daftarpustaka
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_daftarpustaka BEFORE UPDATE ON jbsperpus.daftarpustaka
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_daftarpustaka AFTER DELETE ON jbsperpus.daftarpustaka
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsperpus', tablename = 'daftarpustaka', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `denda`
--

DROP TABLE IF EXISTS `denda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `denda` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpinjam` int(10) unsigned NOT NULL,
  `denda` int(10) DEFAULT '0',
  `telat` int(10) unsigned NOT NULL DEFAULT '0',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_denda_idpeminjaman` (`idpinjam`),
  KEY `IX_denda_ts` (`ts`,`issync`),
  CONSTRAINT `FK_denda_idpeminjaman` FOREIGN KEY (`idpinjam`) REFERENCES `pinjam` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `denda`
--

LOCK TABLES `denda` WRITE;
/*!40000 ALTER TABLE `denda` DISABLE KEYS */;
/*!40000 ALTER TABLE `denda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `format`
--

DROP TABLE IF EXISTS `format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `format` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kode` varchar(3) NOT NULL DEFAULT '',
  `nama` varchar(100) NOT NULL DEFAULT '',
  `keterangan` varchar(255) NOT NULL DEFAULT '',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  UNIQUE KEY `Kode_U` (`kode`),
  KEY `IX_format_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `format`
--

LOCK TABLES `format` WRITE;
/*!40000 ALTER TABLE `format` DISABLE KEYS */;
INSERT INTO `format` VALUES (1,'BU','Buku','',NULL,NULL,NULL,'2010-03-08 01:40:53',0,0);
/*!40000 ALTER TABLE `format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `katalog`
--

DROP TABLE IF EXISTS `katalog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `katalog` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kode` varchar(15) NOT NULL,
  `nama` varchar(100) NOT NULL DEFAULT '',
  `rak` int(10) unsigned NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `counter` int(10) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  UNIQUE KEY `REPL_IN` (`kode`),
  KEY `FK_katalog_rak` (`rak`),
  KEY `IX_katalog_ts` (`ts`,`issync`),
  CONSTRAINT `FK_katalog_rak` FOREIGN KEY (`rak`) REFERENCES `rak` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `katalog`
--

LOCK TABLES `katalog` WRITE;
/*!40000 ALTER TABLE `katalog` DISABLE KEYS */;
INSERT INTO `katalog` VALUES (1,'000','KARYA UMUM',1,'Klasifikasi pustaka dalam kelompok karya umum ',0,NULL,NULL,NULL,'2010-03-07 10:28:08',48886,0),(2,'010','Bibliografi',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',34247,0),(3,'020','Perpustakaan dan Informasi Sains',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',24576,0),(4,'030','Ensiklopedia dan Buku Pintar',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',20137,0),(5,'040','(   ...   )',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',26959,0),(6,'050','Majalah, Jurnal dan Terbitan Berkala',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',8852,0),(7,'060','Asosiasi, Organisasi dan Museum',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',28911,0),(8,'070','Media Berita, Jurnalisme dan Publikasi',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',52469,0),(9,'080','Kutipan',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',44550,0),(10,'090','manuskrip dan buku-buku langka',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',65344,0),(11,'100','FILSAFAT',1,'Klasifikasi pustaka yang tergolong dalam ilmu filsafat',0,NULL,NULL,NULL,'2010-03-07 10:28:08',62009,0),(12,'110','Metafisika',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',48483,0),(13,'120','Epistemologi',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',56389,0),(14,'130','Parapsikologi dan Perdukunan',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',5433,0),(15,'140','Filsafat Aliran Pemikiran',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',54588,0),(16,'150','Psikologi',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',60049,0),(17,'160','Logika',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',5421,0),(18,'170','Etika',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',43547,0),(19,'180','Filsafat kuno, pertengahan dan lanjutan',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',4883,0),(20,'190','Filsafat Barat Modern',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',24833,0),(21,'200','AGAMA',1,'Klasifikasi pustaka yang berkaitan dengan keagamaan',0,NULL,NULL,NULL,'2010-03-07 10:28:08',43986,0),(22,'210','Filsafat dan Teori Agama',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',14372,0),(23,'220','Injil',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',5431,0),(24,'300','ILMU SOSIAL, SOSIOLOGI dan ANTROPOLOGI',1,'Pengelompokan Pustaka dalam kategori ilmu sosial',0,NULL,NULL,NULL,'2010-03-07 10:28:08',49567,0),(25,'310','Statistika Umum',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',34952,0),(26,'320','Ilmu Politik',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',26057,0),(27,'330','Ekonomi',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',25429,0),(28,'340','Hukum',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',48975,0),(29,'350','Administrasi Umum dan Ilmu Militer',1,'',2,NULL,NULL,NULL,'2010-03-08 01:44:43',37528,0),(30,'360','Permasalahan Sosial dan Pelayanan Sosial',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',40716,0),(31,'370','Pendidikan',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',25463,0),(32,'380','Perdagangan, Komunikasi dan Perhubungan',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',5165,0),(33,'390','Kewarganegaraan',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',14967,0),(34,'400','BAHASA',1,'Klasifikasi pustaka dalam kelompok bahasa',0,NULL,NULL,NULL,'2010-03-07 10:28:08',59340,0),(35,'410','Linguistik',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',55207,0),(36,'420','BAHASA INGGRIS',1,'pengelompokan pustaka (bahasa) dalam kelompok bahasa inggris',0,NULL,NULL,NULL,'2010-03-07 10:28:08',32485,0),(37,'430','Bahasa Arab',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',62332,0),(38,'500','ILMU MURNI',1,'klasifikasi pustaka dalam kelompok ilmu murni',0,NULL,NULL,NULL,'2010-03-07 10:28:08',17616,0),(39,'510','Matematika',1,'pengelompokan pustaka (ilmu murni) dalam kelompok matematika',0,NULL,NULL,NULL,'2010-03-07 10:28:08',32144,0),(40,'530','Fisika',1,'pengelompokan pustaka ilmu murni berdasarkan klas fisika ',0,NULL,NULL,NULL,'2010-03-07 10:28:08',42340,0),(41,'540','Kimia',1,'klasifikasi pustaka ilmu murni dalam kelompok ilmu kimia',0,NULL,NULL,NULL,'2010-03-07 10:28:08',49740,0),(42,'570','Biologi',1,'pengelompokan pustaka ilmu murni kedalam klas biologi',0,NULL,NULL,NULL,'2010-03-07 10:28:08',56148,0),(43,'600','ILMU TERAPAN',1,'pengelompokan pustaka kedalam kategori ilmu terapan',0,NULL,NULL,NULL,'2010-03-07 10:28:08',458,0),(44,'700','KESENIAN',1,'Pengelompokan pustaka kedalam kategori kesenian',0,NULL,NULL,NULL,'2010-03-07 10:28:08',30437,0),(45,'710','Kreasi dan Ketrampilan',1,'',0,NULL,NULL,NULL,'2010-03-07 10:28:08',19752,0),(46,'800','KESUSASTERAAN',1,'klasifikasi pustaka berdasarkan kelompok sastra',0,NULL,NULL,NULL,'2010-03-07 10:28:08',7445,0),(47,'900','GEOGRAFI dan SEJARAH ',1,'klasifikasi pustaka kedalam kelompok ilmu geografi dan sejarah',0,NULL,NULL,NULL,'2010-03-07 10:28:08',43502,0);
/*!40000 ALTER TABLE `katalog` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_katalog BEFORE INSERT ON jbsperpus.katalog
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_katalog BEFORE UPDATE ON jbsperpus.katalog
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_katalog AFTER DELETE ON jbsperpus.katalog
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsperpus', tablename = 'katalog', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `konfigurasi`
--

DROP TABLE IF EXISTS `konfigurasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `konfigurasi` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `siswa` int(10) unsigned DEFAULT NULL,
  `pegawai` int(10) unsigned DEFAULT NULL,
  `other` int(10) unsigned DEFAULT NULL,
  `denda` int(10) unsigned DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_konfigurasi_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `konfigurasi`
--

LOCK TABLES `konfigurasi` WRITE;
/*!40000 ALTER TABLE `konfigurasi` DISABLE KEYS */;
INSERT INTO `konfigurasi` VALUES (1,3,4,0,0,NULL,NULL,NULL,'2010-03-25 06:24:56',0,0);
/*!40000 ALTER TABLE `konfigurasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penerbit`
--

DROP TABLE IF EXISTS `penerbit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penerbit` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kode` varchar(3) NOT NULL DEFAULT '',
  `nama` varchar(100) NOT NULL DEFAULT '',
  `alamat` varchar(255) DEFAULT NULL,
  `telpon` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fax` varchar(100) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `kontak` varchar(100) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  UNIQUE KEY `REPL_ID` (`kode`),
  KEY `IX_penerbit_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penerbit`
--

LOCK TABLES `penerbit` WRITE;
/*!40000 ALTER TABLE `penerbit` DISABLE KEYS */;
/*!40000 ALTER TABLE `penerbit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_penerbit BEFORE INSERT ON jbsperpus.penerbit
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_penerbit BEFORE UPDATE ON jbsperpus.penerbit
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_penerbit AFTER DELETE ON jbsperpus.penerbit
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsperpus', tablename = 'penerbit', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `penulis`
--

DROP TABLE IF EXISTS `penulis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penulis` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kode` varchar(3) NOT NULL DEFAULT '',
  `nama` varchar(100) NOT NULL DEFAULT '',
  `kontak` varchar(255) DEFAULT NULL,
  `biografi` text,
  `keterangan` varchar(255) DEFAULT NULL,
  `gelardepan` varchar(45) DEFAULT NULL,
  `gelarbelakang` varchar(45) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  UNIQUE KEY `REPL_ID` (`kode`),
  KEY `IX_penulis_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penulis`
--

LOCK TABLES `penulis` WRITE;
/*!40000 ALTER TABLE `penulis` DISABLE KEYS */;
/*!40000 ALTER TABLE `penulis` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_penulis BEFORE INSERT ON jbsperpus.penulis
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_penulis BEFORE UPDATE ON jbsperpus.penulis
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_penulis AFTER DELETE ON jbsperpus.penulis
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsperpus', tablename = 'penulis', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `perpustakaan`
--

DROP TABLE IF EXISTS `perpustakaan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `perpustakaan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL DEFAULT '',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  UNIQUE KEY `Nama` (`nama`),
  KEY `IX_perpustakaan_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perpustakaan`
--

LOCK TABLES `perpustakaan` WRITE;
/*!40000 ALTER TABLE `perpustakaan` DISABLE KEYS */;
INSERT INTO `perpustakaan` VALUES (1,'sma','',NULL,NULL,NULL,'2010-03-08 01:40:44',0,0);
/*!40000 ALTER TABLE `perpustakaan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pinjam`
--

DROP TABLE IF EXISTS `pinjam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pinjam` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `kodepustaka` varchar(45) NOT NULL,
  `tglpinjam` date NOT NULL DEFAULT '0000-00-00',
  `tglkembali` date NOT NULL DEFAULT '0000-00-00',
  `keterangan` varchar(255) NOT NULL DEFAULT '',
  `idanggota` varchar(45) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 belum di acc, 1 udah di acc, 2 udah dikembalikan',
  `tglditerima` date NOT NULL DEFAULT '0000-00-00',
  `petugaspinjam` varchar(50) DEFAULT NULL,
  `petugaskembali` varchar(50) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`,`tglkembali`),
  KEY `IX_pinjam_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pinjam`
--

LOCK TABLES `pinjam` WRITE;
/*!40000 ALTER TABLE `pinjam` DISABLE KEYS */;
/*!40000 ALTER TABLE `pinjam` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pinjam BEFORE INSERT ON jbsperpus.pinjam
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pinjam BEFORE UPDATE ON jbsperpus.pinjam
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pinjam AFTER DELETE ON jbsperpus.pinjam
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsperpus', tablename = 'pinjam', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pustaka`
--

DROP TABLE IF EXISTS `pustaka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pustaka` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `judul` varchar(255) NOT NULL DEFAULT '',
  `abstraksi` text NOT NULL,
  `keyword` varchar(255) NOT NULL DEFAULT '',
  `tahun` int(4) unsigned NOT NULL DEFAULT '0',
  `keteranganfisik` varchar(255) NOT NULL DEFAULT '',
  `penulis` int(10) unsigned NOT NULL,
  `penerbit` int(10) unsigned NOT NULL,
  `format` int(10) unsigned NOT NULL,
  `katalog` int(10) unsigned NOT NULL,
  `cover` blob,
  `keterangan` varchar(255) DEFAULT NULL,
  `harga` int(10) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pustaka_penulis` (`penulis`),
  KEY `FK_pustaka_format` (`format`),
  KEY `FK_pustaka_katalog` (`katalog`),
  KEY `FK_pustaka_penerbit` (`penerbit`),
  KEY `IX_pustaka_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pustaka_format` FOREIGN KEY (`format`) REFERENCES `format` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pustaka_katalog` FOREIGN KEY (`katalog`) REFERENCES `katalog` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pustaka_penerbit` FOREIGN KEY (`penerbit`) REFERENCES `penerbit` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pustaka_penulis` FOREIGN KEY (`penulis`) REFERENCES `penulis` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pustaka`
--

LOCK TABLES `pustaka` WRITE;
/*!40000 ALTER TABLE `pustaka` DISABLE KEYS */;
/*!40000 ALTER TABLE `pustaka` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pustaka BEFORE INSERT ON jbsperpus.pustaka
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pustaka BEFORE UPDATE ON jbsperpus.pustaka
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pustaka AFTER DELETE ON jbsperpus.pustaka
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsperpus', tablename = 'pustaka', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rak`
--

DROP TABLE IF EXISTS `rak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rak` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rak` varchar(25) NOT NULL,
  `keterangan` varchar(255) NOT NULL DEFAULT '',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  UNIQUE KEY `Kode_U` (`rak`),
  KEY `IX_rak_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rak`
--

LOCK TABLES `rak` WRITE;
/*!40000 ALTER TABLE `rak` DISABLE KEYS */;
INSERT INTO `rak` VALUES (1,'Rak','contoh data',NULL,NULL,NULL,'2010-03-07 10:25:32',0,0);
/*!40000 ALTER TABLE `rak` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `jbssat`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbssat` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbssat`;

--
-- Table structure for table `frabsence`
--

DROP TABLE IF EXISTS `frabsence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frabsence` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(30) DEFAULT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `departemen` varchar(50) DEFAULT NULL,
  `idtingkat` int(10) unsigned DEFAULT NULL,
  `idkelas` int(10) unsigned DEFAULT NULL,
  `datenop` date NOT NULL,
  `status` varchar(7) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `idreportsisfo` int(10) unsigned DEFAULT NULL,
  `idreportsisfoemp` int(10) unsigned DEFAULT NULL,
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_frabsence_siswa` (`nis`),
  KEY `FK_frabsence_pegawai` (`nip`),
  KEY `FK_frabsence_frsisforeport` (`idreportsisfo`),
  KEY `FK_frabsence_departemen` (`departemen`),
  KEY `FK_frabsence_frsisforeportemp` (`idreportsisfoemp`),
  KEY `FK_frabsence_tingkat` (`idtingkat`),
  KEY `FK_frabsence_kelas` (`idkelas`),
  KEY `IX_freabsence` (`datenop`,`nip`,`nis`) USING BTREE,
  CONSTRAINT `FK_frabsence_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frabsence_frsisforeport` FOREIGN KEY (`idreportsisfo`) REFERENCES `frsisforeport` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frabsence_frsisforeportemp` FOREIGN KEY (`idreportsisfoemp`) REFERENCES `frsisforeportemp` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frabsence_kelas` FOREIGN KEY (`idkelas`) REFERENCES `jbsakad`.`kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frabsence_pegawai` FOREIGN KEY (`nip`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frabsence_siswa` FOREIGN KEY (`nis`) REFERENCES `jbsakad`.`siswa` (`nis`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frabsence_tingkat` FOREIGN KEY (`idtingkat`) REFERENCES `jbsakad`.`tingkat` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frabsence`
--

LOCK TABLES `frabsence` WRITE;
/*!40000 ALTER TABLE `frabsence` DISABLE KEYS */;
/*!40000 ALTER TABLE `frabsence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frconfigassms`
--

DROP TABLE IF EXISTS `frconfigassms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frconfigassms` (
  `departemen` varchar(45) NOT NULL,
  `asin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `asout` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pengirim` varchar(45) NOT NULL,
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  KEY `FK_frconfigassms_departemen` (`departemen`),
  CONSTRAINT `FK_frconfigassms_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frconfigassms`
--

LOCK TABLES `frconfigassms` WRITE;
/*!40000 ALTER TABLE `frconfigassms` DISABLE KEYS */;
/*!40000 ALTER TABLE `frconfigassms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frdata`
--

DROP TABLE IF EXISTS `frdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frdata` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ownertype` tinyint(1) unsigned NOT NULL COMMENT '0 = Siswa, 1 = Pegawai',
  `nis` varchar(30) DEFAULT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `departemen` varchar(50) DEFAULT NULL,
  `template` blob NOT NULL,
  `image` mediumblob NOT NULL,
  `fingerpos` varchar(4) NOT NULL,
  `description` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `lastpresence` datetime DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `verify` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_frdata_siswa` (`nis`),
  KEY `FK_frdata_pegawai` (`nip`),
  KEY `FK_frdata_departemen` (`departemen`),
  KEY `IX_frdata` (`ownertype`,`nis`,`nip`,`departemen`),
  CONSTRAINT `FK_frdata_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frdata_pegawai` FOREIGN KEY (`nip`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frdata_siswa` FOREIGN KEY (`nis`) REFERENCES `jbsakad`.`siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frdata`
--

LOCK TABLES `frdata` WRITE;
/*!40000 ALTER TABLE `frdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `frdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frformatsms`
--

DROP TABLE IF EXISTS `frformatsms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frformatsms` (
  `smstype` varchar(10) NOT NULL,
  `smsformat` varchar(500) NOT NULL,
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`smstype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frformatsms`
--

LOCK TABLES `frformatsms` WRITE;
/*!40000 ALTER TABLE `frformatsms` DISABLE KEYS */;
INSERT INTO `frformatsms` VALUES ('MASUK','Kami informasikan presensi {NAMA} tanggal {TANGGAL}/{BULAN}/{TAHUN}, masuk jam {JAM_MASUK}',NULL,NULL,NULL),('PULANG','Kami informasikan presensi {NAMA} tanggal {TANGGAL}/{BULAN}/{TAHUN}, masuk jam {JAM_MASUK} pulang jam {JAM_PULANG}',NULL,NULL,NULL),('TAKHADIR','Kami informasikan bahwa siswa {NAMA} tidak hadir di sekolah pada tanggal {TANGGAL}/{BULAN}/{TAHUN}',NULL,NULL,NULL);
/*!40000 ALTER TABLE `frformatsms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frpresence`
--

DROP TABLE IF EXISTS `frpresence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frpresence` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(30) DEFAULT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `departemen` varchar(50) DEFAULT NULL,
  `idtingkat` int(10) unsigned DEFAULT NULL,
  `idkelas` int(10) unsigned DEFAULT NULL,
  `date_in` date NOT NULL,
  `time_in` varchar(10) NOT NULL,
  `date_out` date DEFAULT NULL,
  `time_out` varchar(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `active` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `smssent` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `smssenthome` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `source` varchar(2) NOT NULL DEFAULT 'F' COMMENT 'F -> Fingerprint, M -< Manual',
  `reportsisfo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `idreportsisfo` int(10) unsigned DEFAULT NULL,
  `idreportsisfoemp` int(10) unsigned DEFAULT NULL,
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_frpresence_frsisforeport` (`idreportsisfo`),
  KEY `FK_frpresence_pegawai` (`nip`),
  KEY `IX_frpresence_date` (`nis`,`nip`,`date_in`,`smssent`,`smssenthome`,`reportsisfo`) USING BTREE,
  KEY `FK_frpresence_departemen` (`departemen`),
  KEY `FK_frpresence_frsisforeportemp` (`idreportsisfoemp`),
  KEY `FK_frpresence_tingkat` (`idtingkat`),
  KEY `FK_frpresence_kelas` (`idkelas`),
  CONSTRAINT `FK_frpresence_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frpresence_frsisforeport` FOREIGN KEY (`idreportsisfo`) REFERENCES `frsisforeport` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frpresence_frsisforeportemp` FOREIGN KEY (`idreportsisfoemp`) REFERENCES `frsisforeportemp` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frpresence_kelas` FOREIGN KEY (`idkelas`) REFERENCES `jbsakad`.`kelas` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frpresence_pegawai` FOREIGN KEY (`nip`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frpresence_siswa` FOREIGN KEY (`nis`) REFERENCES `jbsakad`.`siswa` (`nis`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frpresence_tingkat` FOREIGN KEY (`idtingkat`) REFERENCES `jbsakad`.`tingkat` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frpresence`
--

LOCK TABLES `frpresence` WRITE;
/*!40000 ALTER TABLE `frpresence` DISABLE KEYS */;
/*!40000 ALTER TABLE `frpresence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frsisforeport`
--

DROP TABLE IF EXISTS `frsisforeport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frsisforeport` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year` int(10) unsigned NOT NULL,
  `month` tinyint(3) unsigned NOT NULL,
  `startdate` tinyint(3) unsigned NOT NULL,
  `enddate` tinyint(3) unsigned NOT NULL,
  `h` int(10) unsigned NOT NULL,
  `i` int(10) unsigned NOT NULL,
  `s` int(10) unsigned NOT NULL,
  `c` int(10) unsigned NOT NULL,
  `a` int(10) unsigned NOT NULL,
  `departemen` varchar(45) NOT NULL,
  `idtingkat` int(10) unsigned NOT NULL,
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_frsisforeport_departemen` (`departemen`),
  KEY `FK_frsisforeport_tingkat` (`idtingkat`),
  CONSTRAINT `FK_frsisforeport_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_frsisforeport_tingkat` FOREIGN KEY (`idtingkat`) REFERENCES `jbsakad`.`tingkat` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frsisforeport`
--

LOCK TABLES `frsisforeport` WRITE;
/*!40000 ALTER TABLE `frsisforeport` DISABLE KEYS */;
/*!40000 ALTER TABLE `frsisforeport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frsisforeportemp`
--

DROP TABLE IF EXISTS `frsisforeportemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frsisforeportemp` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year` int(10) unsigned NOT NULL,
  `month` tinyint(3) unsigned NOT NULL,
  `startdate` tinyint(3) unsigned NOT NULL,
  `enddate` tinyint(3) unsigned NOT NULL,
  `h` int(10) unsigned NOT NULL,
  `i` int(10) unsigned NOT NULL,
  `s` int(10) unsigned NOT NULL,
  `c` int(10) unsigned NOT NULL,
  `a` int(10) unsigned NOT NULL,
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`replid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frsisforeportemp`
--

LOCK TABLES `frsisforeportemp` WRITE;
/*!40000 ALTER TABLE `frsisforeportemp` DISABLE KEYS */;
/*!40000 ALTER TABLE `frsisforeportemp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fruser`
--

DROP TABLE IF EXISTS `fruser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fruser` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` varchar(45) NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 NOT NULL,
  `userlevel` tinyint(1) unsigned NOT NULL COMMENT '1 -> Manager, 2 -> Client',
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `lastlogin` datetime DEFAULT NULL,
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_fruser_pegawai` (`userid`),
  CONSTRAINT `FK_fruser_pegawai` FOREIGN KEY (`userid`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fruser`
--

LOCK TABLES `fruser` WRITE;
/*!40000 ALTER TABLE `fruser` DISABLE KEYS */;
/*!40000 ALTER TABLE `fruser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fruseraccess`
--

DROP TABLE IF EXISTS `fruseraccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fruseraccess` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iduser` int(10) unsigned NOT NULL,
  `departemen` varchar(45) NOT NULL,
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_fruseraccess_fruser` (`iduser`),
  KEY `FK_fruseraccess_departemen` (`departemen`),
  CONSTRAINT `FK_fruseraccess_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fruseraccess_fruser` FOREIGN KEY (`iduser`) REFERENCES `fruser` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fruseraccess`
--

LOCK TABLES `fruseraccess` WRITE;
/*!40000 ALTER TABLE `fruseraccess` DISABLE KEYS */;
/*!40000 ALTER TABLE `fruseraccess` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `jbssdm`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbssdm` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbssdm`;

--
-- Table structure for table `bagianpegawai`
--

DROP TABLE IF EXISTS `bagianpegawai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bagianpegawai` (
  `bagian` varchar(50) NOT NULL,
  `urutan` tinyint(2) unsigned NOT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bagian`),
  KEY `UXBagianPegawai` (`replid`),
  KEY `IX_bagianpegawai_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bagianpegawai`
--

LOCK TABLES `bagianpegawai` WRITE;
/*!40000 ALTER TABLE `bagianpegawai` DISABLE KEYS */;
INSERT INTO `bagianpegawai` VALUES ('Akademik',1,1,NULL,NULL,NULL,'2010-03-02 03:08:32',53202,0),('Non Akademik',2,2,NULL,NULL,NULL,'2010-03-02 03:08:32',19723,0);
/*!40000 ALTER TABLE `bagianpegawai` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_bagianpegawai BEFORE INSERT ON jbssdm.bagianpegawai
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_bagianpegawai BEFORE UPDATE ON jbssdm.bagianpegawai
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_bagianpegawai AFTER DELETE ON jbssdm.bagianpegawai
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'bagianpegawai', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `diklat`
--

DROP TABLE IF EXISTS `diklat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diklat` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rootid` int(10) unsigned NOT NULL,
  `allowselect` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `diklat` varchar(45) NOT NULL,
  `tingkat` tinyint(3) unsigned NOT NULL,
  `jenis` varchar(1) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_diklat_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diklat`
--

LOCK TABLES `diklat` WRITE;
/*!40000 ALTER TABLE `diklat` DISABLE KEYS */;
INSERT INTO `diklat` VALUES (11,0,1,'DIKLAT STRUKTURAL',0,'S',NULL,NULL,NULL,'2012-06-19 00:00:00',23097,0),(12,0,0,'DIKLAT FUNGSIONAL',0,'F',NULL,NULL,NULL,'2012-06-19 00:00:00',29220,0),(26,11,1,'Diklat Kepemimpinan',2,'',NULL,NULL,NULL,'2012-06-19 00:00:00',11276,0),(28,12,1,'Diklat Pengajaran',2,'',NULL,NULL,NULL,'2012-06-19 00:00:00',34253,0);
/*!40000 ALTER TABLE `diklat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_diklat BEFORE INSERT ON diklatFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_diklat BEFORE UPDATE ON diklatFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_diklat AFTER DELETE ON diklatFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'diklat', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `eselon`
--

DROP TABLE IF EXISTS `eselon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eselon` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eselon` varchar(15) NOT NULL,
  `urutan` tinyint(1) unsigned NOT NULL,
  `isdefault` tinyint(1) DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`eselon`),
  UNIQUE KEY `UX_eselon` (`replid`),
  KEY `IX_eselon_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eselon`
--

LOCK TABLES `eselon` WRITE;
/*!40000 ALTER TABLE `eselon` DISABLE KEYS */;
INSERT INTO `eselon` VALUES (5,'(Tidak Ada)',1,1,NULL,NULL,NULL,'2012-06-19 00:00:00',6374,0),(1,'Eselon I',2,0,NULL,NULL,NULL,'2012-06-19 00:00:00',60172,0),(2,'Eselon II',3,0,NULL,NULL,NULL,'2012-06-19 00:00:00',19617,0),(3,'Eselon III',4,0,NULL,NULL,NULL,'2012-06-19 00:00:00',48627,0),(4,'Eselon IV',5,0,NULL,NULL,NULL,'2012-06-19 00:00:00',53226,0);
/*!40000 ALTER TABLE `eselon` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_eselon BEFORE INSERT ON eselonFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_eselon BEFORE UPDATE ON eselon  FOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_eselon AFTER DELETE ON eselonFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'eselon', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `golongan`
--

DROP TABLE IF EXISTS `golongan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `golongan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `golongan` varchar(14) NOT NULL,
  `tingkat` tinyint(1) unsigned NOT NULL,
  `urutan` tinyint(1) unsigned NOT NULL,
  `nama` varchar(100) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`golongan`),
  UNIQUE KEY `UX_golongan` (`replid`),
  KEY `IX_golongan_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `golongan`
--

LOCK TABLES `golongan` WRITE;
/*!40000 ALTER TABLE `golongan` DISABLE KEYS */;
INSERT INTO `golongan` VALUES (18,'(Tidak Ada)',1,1,'Tidak Ada Golongan',NULL,NULL,NULL,'2012-06-19 00:00:00',54715,0),(1,'IA',1,2,'Juru Muda',NULL,NULL,NULL,'2012-06-19 00:00:00',48370,0),(2,'IB',1,3,'Juru Muda Tingkat 1',NULL,NULL,NULL,'2012-06-19 00:00:00',12175,0),(3,'IC',1,4,'Juru',NULL,NULL,NULL,'2012-06-19 00:00:00',46822,0),(4,'ID',1,5,'Juru Tingkat 1',NULL,NULL,NULL,'2012-06-19 00:00:00',997,0),(5,'IIA',2,6,'Pengatur Muda',NULL,NULL,NULL,'2012-06-19 00:00:00',61109,0),(6,'IIB',2,7,'Pengatur Muda Tingkat 1',NULL,NULL,NULL,'2012-06-19 00:00:00',40431,0),(7,'IIC',2,8,'Pengatur',NULL,NULL,NULL,'2012-06-19 00:00:00',18827,0),(8,'IID',2,9,'Pengatur Tingkat 1',NULL,NULL,NULL,'2012-06-19 00:00:00',38373,0),(9,'IIIA',3,10,'Penata Muda',NULL,NULL,NULL,'2012-06-19 00:00:00',4324,0),(10,'IIIB',3,11,'Penata muda Tingkat 1',NULL,NULL,NULL,'2012-06-19 00:00:00',37558,0),(11,'IIIC',3,12,'Penata',NULL,NULL,NULL,'2012-06-19 00:00:00',43759,0),(12,'IIID',3,13,'Penata Tingkat 1',NULL,NULL,NULL,'2012-06-19 00:00:00',40589,0),(13,'IVA',4,14,'Pembina',NULL,NULL,NULL,'2012-06-19 00:00:00',6140,0),(14,'IVB',4,15,'Pembina Tingkat 1',NULL,NULL,NULL,'2012-06-19 00:00:00',39991,0),(15,'IVC',4,16,'Pembina Utama Muda',NULL,NULL,NULL,'2012-06-19 00:00:00',50477,0),(16,'IVD',4,17,'Pembina Utama Madya',NULL,NULL,NULL,'2012-06-19 00:00:00',1348,0),(17,'IVE',4,18,'Pembuna Utama',NULL,NULL,NULL,'2012-06-19 00:00:00',51900,0);
/*!40000 ALTER TABLE `golongan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_golongan BEFORE INSERT ON golonganFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_golongan BEFORE UPDATE ON golonganFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_golongan AFTER DELETE ON golonganFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'golongan', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jabatan`
--

DROP TABLE IF EXISTS `jabatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jabatan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rootid` int(10) unsigned NOT NULL,
  `jabatan` varchar(255) NOT NULL,
  `singkatan` varchar(255) NOT NULL,
  `satker` varchar(255) DEFAULT NULL,
  `eselon` varchar(15) DEFAULT NULL,
  `isdefault` tinyint(1) DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_jabatan_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jabatan`
--

LOCK TABLES `jabatan` WRITE;
/*!40000 ALTER TABLE `jabatan` DISABLE KEYS */;
INSERT INTO `jabatan` VALUES (8,0,'NA','STRUKTUR ORGANISASI SEKOLAH',NULL,'(Tidak Ada)',1,NULL,NULL,NULL,'2012-06-19 00:00:00',58865,0),(27,8,'PENGURUS SEKOLAH','SEKOLAH','(Tidak Ada)','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',7566,0),(28,27,'Kepala Sekolah','KEPSEK','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',57825,0),(29,28,'Kepala TU','KEPTU','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',4305,0),(30,27,'Ketua Komite Sekolah','K.KOMITE','(Tidak Ada)','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',44641,0),(31,28,'Wakil Kepala Sekolah Bidang Kurikulum','WK.KURIKULUM','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',13697,0),(32,28,'Wakil Kepala Sekolah Bidang Kesiswaan','WK.KESISWAAN','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',95,0),(33,28,'Wakil Kepala Sekolah Bidang Humas','WK.HUMAS','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',24911,0),(34,32,'Pembina OSIS','PB.OSIS','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',58740,0),(35,32,'Pembina Ekstrakulikuler','PB.EKSTRA','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',22378,0),(36,28,'Wakil Kepala Sekolah Bidang Sarana Prasaran','WK.SARANA','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',1198,0),(37,33,'Kordinator Rumah Tangga','KO.RT','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',4384,0),(38,28,'Koordinator BP','KO.BP','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',18328,0),(39,28,'Koordinator IT','KO.IT','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',12955,0),(40,28,'Koordinator Guru','KO.GURU','GURU','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',9791,0),(41,40,'Guru','GURU','GURU','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:00:00',10089,0),(42,8,'Komite Sekolah','KOMSEK','MANAJEMEN','(Tidak Ada)',0,NULL,NULL,NULL,'2012-06-19 00:09:52',45480,0);
/*!40000 ALTER TABLE `jabatan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_jabatan BEFORE INSERT ON jabatanFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_jabatan BEFORE UPDATE ON jabatanFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_jabatan AFTER DELETE ON jabatanFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'jabatan', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jadwal`
--

DROP TABLE IF EXISTS `jadwal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jadwal` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `jenis` varchar(45) NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `exec` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_jadwal_pegawai` (`nip`),
  KEY `FK_jadwal_jenisagenda` (`jenis`),
  KEY `IX_jadwal_ts` (`ts`,`issync`),
  CONSTRAINT `FK_jadwal_jenisagenda` FOREIGN KEY (`jenis`) REFERENCES `jenisagenda` (`agenda`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_jadwal_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jadwal`
--

LOCK TABLES `jadwal` WRITE;
/*!40000 ALTER TABLE `jadwal` DISABLE KEYS */;
/*!40000 ALTER TABLE `jadwal` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_jadwal BEFORE INSERT ON jadwalFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_jadwal BEFORE UPDATE ON jadwalFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_jadwal AFTER DELETE ON jadwalFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'jadwal', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jenisagenda`
--

DROP TABLE IF EXISTS `jenisagenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jenisagenda` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agenda` varchar(45) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `urutan` tinyint(1) NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`agenda`),
  UNIQUE KEY `UX_agenda` (`replid`),
  KEY `IX_jenisagenda_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenisagenda`
--

LOCK TABLES `jenisagenda` WRITE;
/*!40000 ALTER TABLE `jenisagenda` DISABLE KEYS */;
INSERT INTO `jenisagenda` VALUES (5,'cpns','Pengangkatan CPNS',6,NULL,NULL,NULL,'2012-06-19 00:00:00',17386,0),(8,'gaji','Penyesuaian Gaji',4,NULL,NULL,NULL,'2012-06-19 00:00:00',6748,0),(2,'golongan','Kenaikan Golongan',2,NULL,NULL,NULL,'2012-06-19 00:00:00',47111,0),(3,'jabatan','Kenaikan Jabatan',1,NULL,NULL,NULL,'2012-06-19 00:00:00',18723,0),(7,'lainnya','Lainnya',9,NULL,NULL,NULL,'2012-06-19 00:00:00',17810,0),(1,'pangkat','Kenaikan Pangkat',3,NULL,NULL,NULL,'2012-06-19 00:00:00',32879,0),(4,'pensiun','Pensiun',8,NULL,NULL,NULL,'2012-06-19 00:00:00',45437,0),(6,'pns','Pengangkatan PNS',7,NULL,NULL,NULL,'2012-06-19 00:00:00',63018,0);
/*!40000 ALTER TABLE `jenisagenda` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_jenisagenda BEFORE INSERT ON jenisagendaFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_jenisagenda BEFORE UPDATE ON jenisagendaFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_jenisagenda AFTER DELETE ON jenisagendaFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'jenisagenda', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jenisjabatan`
--

DROP TABLE IF EXISTS `jenisjabatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jenisjabatan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `jenis` varchar(50) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `urutan` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `jabatan` varchar(2) NOT NULL DEFAULT 'F',
  `isdefault` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`jenis`),
  UNIQUE KEY `Index_replid` (`replid`),
  KEY `IX_jenisjabatan_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenisjabatan`
--

LOCK TABLES `jenisjabatan` WRITE;
/*!40000 ALTER TABLE `jenisjabatan` DISABLE KEYS */;
INSERT INTO `jenisjabatan` VALUES (8,'KEPALA','',2,'F',0,NULL,NULL,NULL,'2012-06-19 00:00:00',47718,0),(16,'KOORDINATOR','',4,'F',0,NULL,NULL,NULL,'2012-06-19 00:00:00',49537,0),(17,'STAF','',5,'F',0,NULL,NULL,NULL,'2012-06-19 00:00:00',38997,0),(11,'WAKIL KEPALA','',3,'F',0,NULL,NULL,NULL,'2012-06-19 00:00:00',46376,0);
/*!40000 ALTER TABLE `jenisjabatan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_jenisjabatan BEFORE INSERT ON jenisjabatanFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_jenisjabatan BEFORE UPDATE ON jenisjabatanFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_jenisjabatan AFTER DELETE ON jenisjabatan FOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'jenisjabatan', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pegawai`
--

DROP TABLE IF EXISTS `pegawai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pegawai` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `nrp` varchar(30) DEFAULT NULL,
  `nuptk` varchar(30) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `panggilan` varchar(50) DEFAULT NULL,
  `gelarawal` varchar(45) DEFAULT NULL,
  `gelarakhir` varchar(45) DEFAULT NULL,
  `gelar` varchar(50) DEFAULT NULL,
  `tmplahir` varchar(50) DEFAULT NULL,
  `tgllahir` date DEFAULT NULL,
  `agama` varchar(50) DEFAULT NULL,
  `suku` varchar(50) DEFAULT NULL,
  `noid` varchar(50) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `telpon` varchar(20) DEFAULT NULL,
  `handphone` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `facebook` varchar(200) DEFAULT NULL,
  `twitter` varchar(200) DEFAULT NULL,
  `website` varchar(200) DEFAULT NULL,
  `foto` blob,
  `bagian` varchar(50) NOT NULL,
  `nikah` varchar(10) NOT NULL,
  `keterangan` varchar(200) DEFAULT NULL,
  `aktif` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `kelamin` varchar(1) NOT NULL,
  `pinpegawai` varchar(25) DEFAULT NULL,
  `mulaikerja` date DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `ketnonaktif` varchar(45) DEFAULT NULL,
  `pensiun` date DEFAULT NULL,
  `doaudit` tinyint(1) DEFAULT '0',
  `info1` varchar(20) DEFAULT NULL,
  `info2` varchar(20) DEFAULT NULL,
  `info3` varchar(20) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`nip`),
  UNIQUE KEY `UX_pegawai_replid` (`replid`),
  KEY `FK_pegawai_agama` (`agama`),
  KEY `FK_pegawai_suku` (`suku`),
  KEY `FK_pegawai_bagian` (`bagian`),
  KEY `IX_pegawai_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pegawai_agama` FOREIGN KEY (`agama`) REFERENCES `jbsumum`.`agama` (`agama`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pegawai_bagian` FOREIGN KEY (`bagian`) REFERENCES `bagianpegawai` (`bagian`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pegawai_suku` FOREIGN KEY (`suku`) REFERENCES `jbsumum`.`suku` (`suku`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pegawai`
--

LOCK TABLES `pegawai` WRITE;
/*!40000 ALTER TABLE `pegawai` DISABLE KEYS */;
INSERT INTO `pegawai` VALUES (23,'101',NULL,NULL,'Pegawai','','',NULL,'','Bandung','1987-11-01','Islam','Jawa','','                                ','','','',NULL,NULL,NULL,'ÿØÿà\0JFIF\0\0\0\0\0\0ÿş\0;CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), quality = 70\nÿÛ\0C\0\n\n\n\n\r\r#%$\"\"!&+7/&)4)!\"0A149;>>>%.DIC<H7=>;ÿÛ\0C\n\r;(\"(;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ÿÀ\0\0P\0:\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RğbrÑ\n$4á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0ŞÕµ]J=bò8ïîQw\n«#\0MT:Î«ÿ\0A¯ûúßãNÖş\'WÇş›¿ş„k+SºûŸ-ÆİÌ£å¤ğ(kï]Ø\0&ÕîƒŠ%bOëXrüK¿V!no°	iÈ?Î´ô¯\0É­éëu\"É?Î;Ù©æøecåmYI¼ü*\0¯aãK½Lm«İî%\ZV~µeµİc¶©wÿ\0Ûük\'Sø~úno¬åt¸€n*ŞŞôºUÌ—v!æ½CµÏ©õ \r×µ 8Õo?ïûzîœìúe«»f…	$ä“^0éšöm7şAvŸõÁ?ô@{«€u›Î?å»ÿ\03\\÷‰ã-¤ez	Ÿ¦qık¤Õ×ş\'‡òİÿ\0™¨\"¶KµxdŒI®ÖR~3í¼zPôzŒ\Z>™rE4İ.jEÔm%±7è²ÀÉùpEOs£éÚ’­ÔHà`å†qjy4«3¥<E‹b»p=(!îcÕôÉÃ,k\"‘—Çô&¼÷Ã–ÏÀ“?ëÈ@z}¦‘e¥éæ+hÖ$\0ô{×7i\rµ¼QÅŒG•Àş>‡wş„(Ğt¯_Ó¸Ó-ëŠè\"¼•”u¯ZÓÿ\0äkÿ\0\\Sù\n\0à5_ùŞsÿ\0-ßùš†	d‚MÑ¹VÆ2=*Æ©ÿ\0!{Ïúìÿ\0ÌÕ7‘\"]Ò:¢ú±Å\0tÉt‹§G)F”e’MPŠñÃHºuâ)“ÌÃFøİœç­VÒï<Ûv6î	W£84û[«ÅÔX+\0Ÿ¼­\0l\\İ+iÏ6ÃÂ°Á¹Y¥–l\\¹Q“[zÄ²Å¦;ÊT<’\"*œ°ÏãŒ×?Ä7+˜¤SíÜP.9æ½ZÃşAÖßõÅ?¯-uö¯R°ÿ\0}·ır_ä(Ëõûé›TÔ– Ñ\"O\"y¸ÏÍ“Ò³/D–Ö‘‰Æù\'»Œàc°í[š·nuåˆòrz­â­¾Éoä…ãv€3ÛQ{‹;ØQšŞXÄ2ªxà7Ç­û}jŞ	Hšù=¹(çŸÂ¸_ŞIkf4hQšáåÎáü GãÅeéĞË!ò°Vâ\"cqù[ê;}(¹—Y“V¿{©Çeh¤Â‡®ãÀcïíØf³-Ì/Ì\\BÑ0Ä¨ ñÈªZN Ú¨Òš7î9	”íÀqĞóëVmai×¯ÑãrŒşâ€#\Z½Ì!¦˜	l+„}?ıUíúc‰4«GÅütW…ê¶’.™l©·’ a\r{\0Ñ¬@9gş(ÍõÉ#ó5„3ºê3yGN˜şµ¨³MölÃ \0t*}«µ×¬õC}.ÂH—h¢ Kµ°[w-ÎÏN§¯jŒ<Q0•“k	!E\"6*Y?vbU†$gw|P\r®Ååëë;BAÀËÿ\0f¹ı7şC‘nù’–~¸ıkÚRÛS–Æ.4ûAv·%_-X4cpR§<òyÁæ³VÃYM?Jé6æóÍcw¶AÚmÏo¹„sùPi\0	î¦ o%Ao^M&İv_â•¼5zÛx‘\"Œÿ\0cØ‡-‰‚$g†e9º¥”øÎO_³k‹a4qé(ò8_%¥†\0AKo\0ãŸœÃ>´æºÉÿ\0‰Eºö*ı[#ú×¹i`\r&Ì/AcşùÍÃe¬5ô+w¤Z´)2®c-…Gç9aê sÉÉ8\0õÊ¡T*€\0\0v ÿÙ','Akademik','tak_ada','',1,'l','12637',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,'2012-06-23 04:04:49',4536,0);
/*!40000 ALTER TABLE `pegawai` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pegawai BEFORE INSERT ON jbssdm.pegawai
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pegawai BEFORE UPDATE ON jbssdm.pegawai
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pegawai AFTER DELETE ON jbssdm.pegawai
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'pegawai', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pegdiklat`
--

DROP TABLE IF EXISTS `pegdiklat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pegdiklat` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `iddiklat` int(10) unsigned NOT NULL,
  `tahun` int(10) unsigned NOT NULL,
  `sk` varchar(45) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `terakhir` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `doaudit` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pegdiklat_pegawai` (`nip`),
  KEY `FK_pegdiklat_diklat` (`iddiklat`),
  KEY `IX_pegdiklat_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pegdiklat_diklat` FOREIGN KEY (`iddiklat`) REFERENCES `diklat` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `FK_pegdiklat_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pegdiklat`
--

LOCK TABLES `pegdiklat` WRITE;
/*!40000 ALTER TABLE `pegdiklat` DISABLE KEYS */;
/*!40000 ALTER TABLE `pegdiklat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pegdiklat BEFORE INSERT ON pegdiklatFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pegdiklat BEFORE UPDATE ON pegdiklatFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pegdiklat AFTER DELETE ON pegdiklatFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'pegdiklat', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `peggaji`
--

DROP TABLE IF EXISTS `peggaji`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `peggaji` (
  `replid` int(11) NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `tanggal` date NOT NULL,
  `gaji` varchar(15) NOT NULL,
  `sk` varchar(45) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `judulsk` varchar(255) DEFAULT NULL,
  `tanggalsk` varchar(255) DEFAULT NULL,
  `dok` text,
  `doaudit` tinyint(1) DEFAULT '1',
  `terakhir` tinyint(1) DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_peggaji_pegawai` (`nip`),
  KEY `IX_peggaji_ts` (`ts`,`issync`),
  CONSTRAINT `FK_peggaji_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peggaji`
--

LOCK TABLES `peggaji` WRITE;
/*!40000 ALTER TABLE `peggaji` DISABLE KEYS */;
/*!40000 ALTER TABLE `peggaji` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_peggaji BEFORE INSERT ON peggajiFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_peggaji BEFORE UPDATE ON peggajiFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_peggaji AFTER DELETE ON peggajiFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'peggaji', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `peggol`
--

DROP TABLE IF EXISTS `peggol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `peggol` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `golongan` varchar(14) NOT NULL,
  `tmt` date NOT NULL,
  `sk` varchar(100) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `terakhir` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `judulsk` varchar(255) DEFAULT NULL,
  `tanggalsk` varchar(45) DEFAULT NULL,
  `dok` text,
  `petugas` varchar(45) DEFAULT NULL,
  `doaudit` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_peggol_pegawai` (`nip`),
  KEY `FK_peggol_golongan` (`golongan`),
  KEY `IX_peggol_ts` (`ts`,`issync`),
  CONSTRAINT `FK_peggol_golongan` FOREIGN KEY (`golongan`) REFERENCES `golongan` (`golongan`) ON UPDATE CASCADE,
  CONSTRAINT `FK_peggol_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peggol`
--

LOCK TABLES `peggol` WRITE;
/*!40000 ALTER TABLE `peggol` DISABLE KEYS */;
/*!40000 ALTER TABLE `peggol` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_peggol BEFORE INSERT ON peggolFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_peggol BEFORE UPDATE ON peggolFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_peggol AFTER DELETE ON peggolFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'peggol', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pegjab`
--

DROP TABLE IF EXISTS `pegjab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pegjab` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `idjabatan` int(10) unsigned DEFAULT NULL,
  `tmt` date NOT NULL,
  `sk` varchar(45) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `terakhir` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `jenis` varchar(50) NOT NULL,
  `namajab` varchar(255) DEFAULT NULL,
  `doaudit` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `fk_pegjab_jabatan` (`idjabatan`),
  KEY `fk_pegjab_pegawai` (`nip`),
  KEY `IX_pegjab_ts` (`ts`,`issync`),
  CONSTRAINT `fk_pegjab_jabatan` FOREIGN KEY (`idjabatan`) REFERENCES `jabatan` (`replid`) ON UPDATE CASCADE,
  CONSTRAINT `fk_pegjab_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pegjab`
--

LOCK TABLES `pegjab` WRITE;
/*!40000 ALTER TABLE `pegjab` DISABLE KEYS */;
/*!40000 ALTER TABLE `pegjab` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pegjab BEFORE INSERT ON pegjabFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pegjab BEFORE UPDATE ON pegjabFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pegjab AFTER DELETE ON pegjabFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'pegjab', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pegkeluarga`
--

DROP TABLE IF EXISTS `pegkeluarga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pegkeluarga` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `alm` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `hubungan` varchar(50) DEFAULT NULL,
  `tgllahir` varchar(50) DEFAULT NULL,
  `hp` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pegkeluarga_pegawai` (`nip`),
  KEY `IX_pegkeluarga_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pegkeluarga`
--

LOCK TABLES `pegkeluarga` WRITE;
/*!40000 ALTER TABLE `pegkeluarga` DISABLE KEYS */;
/*!40000 ALTER TABLE `pegkeluarga` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pegkeluarga BEFORE INSERT ON pegkeluarga
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pegkeluarga BEFORE UPDATE ON pegkeluarga
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pegkeluarga AFTER DELETE ON pegkeluarga
FOR EACH ROW BEGIN
   IF @DISABLE_TRIGER IS NULL THEN
      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'pegkeluarga', dataid = OLD.replid, datatoken = OLD.token;
   END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pegkerja`
--

DROP TABLE IF EXISTS `pegkerja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pegkerja` (
  `replid` int(11) NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `tempat` varchar(255) NOT NULL,
  `thnawal` varchar(4) NOT NULL,
  `thnakhir` varchar(4) NOT NULL,
  `jabatan` varchar(255) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `terakhir` tinyint(1) NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `fk_pegkerja_pegawai` (`nip`),
  KEY `IX_pegkerja_ts` (`ts`,`issync`),
  CONSTRAINT `fk_pegkerja_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pegkerja`
--

LOCK TABLES `pegkerja` WRITE;
/*!40000 ALTER TABLE `pegkerja` DISABLE KEYS */;
INSERT INTO `pegkerja` VALUES (1,'132 456 001','Pikiran Rakyan','1996','1999','Wartawan','',1,NULL,NULL,NULL,'2012-06-19 00:00:01',52383,0),(2,'131 924 825','SMA Negeri 3 Durian','1992','1995','Guru','',1,NULL,NULL,NULL,'2012-06-19 00:00:01',43673,0);
/*!40000 ALTER TABLE `pegkerja` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pegkerja BEFORE INSERT ON pegkerjaFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pegkerja BEFORE UPDATE ON pegkerjaFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pegkerja AFTER DELETE ON pegkerjaFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'pegkerja', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `peglastdata`
--

DROP TABLE IF EXISTS `peglastdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `peglastdata` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `idpeggol` int(10) unsigned DEFAULT NULL,
  `idpegjab` int(10) unsigned DEFAULT NULL,
  `idpegdiklat` int(10) unsigned DEFAULT NULL,
  `idpegsekolah` int(10) unsigned DEFAULT NULL,
  `idpeggaji` int(10) unsigned DEFAULT NULL,
  `idpegserti` int(10) unsigned DEFAULT NULL,
  `idpegkerja` int(10) unsigned DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_peglastdata_pegawai` (`nip`),
  KEY `IX_peglastdata_ts` (`ts`,`issync`),
  CONSTRAINT `FK_peglastdata_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `peglastdata`
--

LOCK TABLES `peglastdata` WRITE;
/*!40000 ALTER TABLE `peglastdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `peglastdata` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_peglastdata BEFORE INSERT ON peglastdataFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_peglastdata BEFORE UPDATE ON peglastdataFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_peglastdata AFTER DELETE ON peglastdataFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'peglastdata', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pegsekolah`
--

DROP TABLE IF EXISTS `pegsekolah`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pegsekolah` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `tingkat` varchar(20) NOT NULL,
  `sekolah` varchar(255) NOT NULL,
  `lulus` int(10) unsigned NOT NULL,
  `sk` varchar(45) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `terakhir` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `doaudit` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pegsekolah_pegawai` (`nip`),
  KEY `IX_pegsekolah_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pegsekolah_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pegsekolah`
--

LOCK TABLES `pegsekolah` WRITE;
/*!40000 ALTER TABLE `pegsekolah` DISABLE KEYS */;
/*!40000 ALTER TABLE `pegsekolah` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pegsekolah BEFORE INSERT ON pegsekolahFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pegsekolah BEFORE UPDATE ON pegsekolahFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pegsekolah AFTER DELETE ON pegsekolahFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'pegsekolah', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pegserti`
--

DROP TABLE IF EXISTS `pegserti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pegserti` (
  `replid` int(11) NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `sertifikat` varchar(255) NOT NULL,
  `lembaga` varchar(255) NOT NULL,
  `tahun` smallint(6) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `terakhir` tinyint(1) NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `fk_pegserti_pegawai` (`nip`),
  KEY `IX_pegserti_ts` (`ts`,`issync`),
  CONSTRAINT `fk_pegserti_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pegserti`
--

LOCK TABLES `pegserti` WRITE;
/*!40000 ALTER TABLE `pegserti` DISABLE KEYS */;
/*!40000 ALTER TABLE `pegserti` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_pegserti BEFORE INSERT ON pegsertiFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_pegserti BEFORE UPDATE ON pegsertiFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_pegserti AFTER DELETE ON pegsertiFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'pegserti', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `presensi`
--

DROP TABLE IF EXISTS `presensi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presensi` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nip` varchar(30) NOT NULL,
  `tanggal` date NOT NULL,
  `jammasuk` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `jampulang` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `jamwaktukerja` int(10) unsigned DEFAULT '0',
  `menitwaktukerja` int(10) unsigned DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL COMMENT '1 -> Hadir, 2 -> Izin, 3 -> Cuti, 4 ->Sakit, 5 ->Alpa',
  `keterangan` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `source` varchar(45) DEFAULT 'MANUAL',
  `info1` varchar(100) DEFAULT NULL,
  `info2` varchar(100) DEFAULT NULL,
  `info3` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_presensi` (`nip`,`tanggal`,`status`),
  CONSTRAINT `FK_presensi_pegawai` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nip`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `presensi`
--

LOCK TABLES `presensi` WRITE;
/*!40000 ALTER TABLE `presensi` DISABLE KEYS */;
/*!40000 ALTER TABLE `presensi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `satker`
--

DROP TABLE IF EXISTS `satker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `satker` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `satker` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `isdefault` tinyint(1) DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`satker`),
  UNIQUE KEY `UX_satker` (`replid`),
  KEY `IX_satker_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `satker`
--

LOCK TABLES `satker` WRITE;
/*!40000 ALTER TABLE `satker` DISABLE KEYS */;
INSERT INTO `satker` VALUES (19,'(Tidak Ada)','Tidak Ada Satuan Kerja',1,NULL,NULL,NULL,'2012-06-19 00:00:01',17795,0),(21,'GURU','Pengajar',0,NULL,NULL,NULL,'2012-06-19 00:00:01',51312,0),(23,'KOPERASI','Koperasi',0,NULL,NULL,NULL,'2012-06-19 00:00:01',6583,0),(24,'MANAJEMEN','Manajemen Sekolah',0,NULL,NULL,NULL,'2012-06-19 00:00:01',10040,0),(22,'TATA USAHA','Tata Usaha Sekolah',0,NULL,NULL,NULL,'2012-06-19 00:00:01',30450,0),(20,'YAYASAN','Pengurus Yayasan',0,NULL,NULL,NULL,'2012-06-19 00:00:01',56600,0);
/*!40000 ALTER TABLE `satker` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_satker BEFORE INSERT ON satkerFOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_satker BEFORE UPDATE ON satkerFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      IF OLD.issync = 1 THEN           SET NEW.issync = 0;           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;       IF OLD.issync = 0 AND NEW.issync = 0 THEN           SET NEW.ts = CURRENT_TIMESTAMP;       END IF;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_satker AFTER DELETE ON satkerFOR EACH ROW BEGIN   IF @DISABLE_TRIGER IS NULL THEN      INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbssdm', tablename = 'satker', dataid = OLD.replid, datatoken = OLD.token;   END IF;END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `jbssms`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbssms` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbssms`;

--
-- Table structure for table `daemons`
--

DROP TABLE IF EXISTS `daemons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daemons` (
  `Start` text NOT NULL,
  `Info` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daemons`
--

LOCK TABLES `daemons` WRITE;
/*!40000 ALTER TABLE `daemons` DISABLE KEYS */;
/*!40000 ALTER TABLE `daemons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `format`
--

DROP TABLE IF EXISTS `format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `format` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tipe` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 presensi, 1 penilaian, 2 pengumuman',
  `format` text,
  PRIMARY KEY (`replid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `format`
--

LOCK TABLES `format` WRITE;
/*!40000 ALTER TABLE `format` DISABLE KEYS */;
INSERT INTO `format` VALUES (1,0,'Kami informasikan presensi [SISWA] tanggal [TANGGAL1]/[BULAN1] s/d [TANGGAL2]/[BULAN2] hadir [HADIR] absen [ABSEN]. [PENGIRIM]'),(2,2,'Kami informasikan nilai #SISWA tanggal #TANGGAL1/#BULAN1 s/d #TANGGAL2/#BULAN2 . #PENGIRIM'),(4,1,'Kami informasikan nilai [SISWA] tanggal [TANGGAL1]/[BULAN1] s/d [TANGGAL2]/[BULAN2] . [PENGIRIM]');
/*!40000 ALTER TABLE `format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gammu`
--

DROP TABLE IF EXISTS `gammu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gammu` (
  `Version` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gammu`
--

LOCK TABLES `gammu` WRITE;
/*!40000 ALTER TABLE `gammu` DISABLE KEYS */;
INSERT INTO `gammu` VALUES (7);
/*!40000 ALTER TABLE `gammu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbox`
--

DROP TABLE IF EXISTS `inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inbox` (
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ReceivingDateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Text` text NOT NULL,
  `SenderNumber` varchar(20) NOT NULL DEFAULT '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL DEFAULT '8bit',
  `UDH` text NOT NULL,
  `SMSCNumber` varchar(20) NOT NULL DEFAULT '',
  `Class` int(11) NOT NULL DEFAULT '-1',
  `TextDecoded` varchar(160) NOT NULL DEFAULT '',
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `RecipientID` text NOT NULL,
  `Processed` enum('false','true') NOT NULL DEFAULT 'false',
  `Status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 belum dibaca, 1 sudah dibaca',
  UNIQUE KEY `ID` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbox`
--

LOCK TABLES `inbox` WRITE;
/*!40000 ALTER TABLE `inbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kritiksaran`
--

DROP TABLE IF EXISTS `kritiksaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kritiksaran` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender` text NOT NULL,
  `senddate` datetime DEFAULT NULL,
  `message` text,
  `from` text,
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`replid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kritiksaran`
--

LOCK TABLES `kritiksaran` WRITE;
/*!40000 ALTER TABLE `kritiksaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `kritiksaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbox`
--

DROP TABLE IF EXISTS `outbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outbox` (
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `SendingDateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Text` text,
  `DestinationNumber` varchar(20) NOT NULL DEFAULT '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') DEFAULT '8bit',
  `UDH` text,
  `Class` int(11) DEFAULT '-1',
  `TextDecoded` varchar(160) NOT NULL DEFAULT '',
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `MultiPart` enum('false','true') DEFAULT 'false',
  `RelativeValidity` int(11) DEFAULT '-1',
  `SenderID` text,
  `SendingTimeOut` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `DeliveryReport` enum('default','yes','no') DEFAULT 'default',
  `CreatorID` text NOT NULL,
  `idsmsgeninfo` int(10) unsigned DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 belum dikirim, 1 sudah dikirim',
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=619178 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbox`
--

LOCK TABLES `outbox` WRITE;
/*!40000 ALTER TABLE `outbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `outbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outbox_multipart`
--

DROP TABLE IF EXISTS `outbox_multipart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outbox_multipart` (
  `Text` text,
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') DEFAULT '8bit',
  `UDH` text,
  `Class` int(11) DEFAULT '-1',
  `TextDecoded` varchar(160) DEFAULT NULL,
  `ID` int(11) unsigned NOT NULL DEFAULT '0',
  `SequencePosition` int(11) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outbox_multipart`
--

LOCK TABLES `outbox_multipart` WRITE;
/*!40000 ALTER TABLE `outbox_multipart` DISABLE KEYS */;
/*!40000 ALTER TABLE `outbox_multipart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outboxhistory`
--

DROP TABLE IF EXISTS `outboxhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outboxhistory` (
  `InsertIntoDB` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `SendingDateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Text` text,
  `DestinationNumber` varchar(20) NOT NULL DEFAULT '',
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idsmsgeninfo` int(10) unsigned DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 belum dikirim, 1 sudah dikirim',
  `SenderID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=571 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outboxhistory`
--

LOCK TABLES `outboxhistory` WRITE;
/*!40000 ALTER TABLE `outboxhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `outboxhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pbk`
--

DROP TABLE IF EXISTS `pbk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pbk` (
  `GroupID` int(11) NOT NULL DEFAULT '-1',
  `Name` text NOT NULL,
  `Number` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pbk`
--

LOCK TABLES `pbk` WRITE;
/*!40000 ALTER TABLE `pbk` DISABLE KEYS */;
/*!40000 ALTER TABLE `pbk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pbk_groups`
--

DROP TABLE IF EXISTS `pbk_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pbk_groups` (
  `Name` text NOT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  UNIQUE KEY `ID` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pbk_groups`
--

LOCK TABLES `pbk_groups` WRITE;
/*!40000 ALTER TABLE `pbk_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `pbk_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pesan`
--

DROP TABLE IF EXISTS `pesan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pesan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tanggal` datetime NOT NULL,
  `pesan` varchar(160) NOT NULL,
  `pengirim` varchar(20) NOT NULL,
  PRIMARY KEY (`replid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pesan`
--

LOCK TABLES `pesan` WRITE;
/*!40000 ALTER TABLE `pesan` DISABLE KEYS */;
/*!40000 ALTER TABLE `pesan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pesanpenerima`
--

DROP TABLE IF EXISTS `pesanpenerima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pesanpenerima` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpesan` int(10) unsigned NOT NULL,
  `jadwal` datetime NOT NULL,
  `penerima` varchar(20) NOT NULL,
  `status` int(10) unsigned NOT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_pesanpenerima_idpesan` (`idpesan`),
  CONSTRAINT `FK_pesanpenerima_idpesan` FOREIGN KEY (`idpesan`) REFERENCES `pesan` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pesanpenerima`
--

LOCK TABLES `pesanpenerima` WRITE;
/*!40000 ALTER TABLE `pesanpenerima` DISABLE KEYS */;
/*!40000 ALTER TABLE `pesanpenerima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phonebook`
--

DROP TABLE IF EXISTS `phonebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phonebook` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nohp` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 siswa, 1 ortu, 2 pegawai, 3 lainnya, 4 alumni',
  `keterangan` varchar(100) DEFAULT NULL COMMENT 'Jika status 1 isinya Ortu NamaSiswa',
  `idreplid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX` (`nohp`,`nama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phonebook`
--

LOCK TABLES `phonebook` WRITE;
/*!40000 ALTER TABLE `phonebook` DISABLE KEYS */;
/*!40000 ALTER TABLE `phonebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phones`
--

DROP TABLE IF EXISTS `phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phones` (
  `ID` text NOT NULL,
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `TimeOut` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Send` enum('yes','no') NOT NULL DEFAULT 'no',
  `Receive` enum('yes','no') NOT NULL DEFAULT 'no',
  `IMEI` text NOT NULL,
  `Client` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phones`
--

LOCK TABLES `phones` WRITE;
/*!40000 ALTER TABLE `phones` DISABLE KEYS */;
INSERT INTO `phones` VALUES ('MyPhone1','2010-02-03 03:48:05','2010-02-03 03:48:05','2010-02-03 03:48:15','yes','yes','354056001179799','Gammu 1.10.6, Windows XP SP2');
/*!40000 ALTER TABLE `phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sentitems`
--

DROP TABLE IF EXISTS `sentitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sentitems` (
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `SendingDateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `DeliveryDateTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Text` text NOT NULL,
  `DestinationNumber` varchar(20) NOT NULL DEFAULT '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL DEFAULT '8bit',
  `UDH` text NOT NULL,
  `SMSCNumber` varchar(20) NOT NULL DEFAULT '',
  `Class` int(11) NOT NULL DEFAULT '-1',
  `TextDecoded` varchar(160) NOT NULL DEFAULT '',
  `ID` int(11) unsigned NOT NULL DEFAULT '0',
  `SenderID` text NOT NULL,
  `SequencePosition` int(11) NOT NULL DEFAULT '1',
  `Status` enum('SendingOK','SendingOKNoReport','SendingError','DeliveryOK','DeliveryFailed','DeliveryPending','DeliveryUnknown','Error') NOT NULL DEFAULT 'SendingOK',
  `StatusError` int(11) NOT NULL DEFAULT '-1',
  `TPMR` int(11) NOT NULL DEFAULT '-1',
  `RelativeValidity` int(11) NOT NULL DEFAULT '-1',
  `CreatorID` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sentitems`
--

LOCK TABLES `sentitems` WRITE;
/*!40000 ALTER TABLE `sentitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `sentitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smsgeninfo`
--

DROP TABLE IF EXISTS `smsgeninfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `smsgeninfo` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tanggal` date NOT NULL DEFAULT '0000-00-00',
  `tipe` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 presensi, 1 penilaian, 2 pengumuman',
  `info` varchar(1000) DEFAULT NULL,
  `pengirim` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_smsgeninfo` (`tipe`,`info`(50),`pengirim`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `smsgeninfo`
--

LOCK TABLES `smsgeninfo` WRITE;
/*!40000 ALTER TABLE `smsgeninfo` DISABLE KEYS */;
INSERT INTO `smsgeninfo` VALUES (2,'2010-04-16',2,'Pengumuman','akademik ');
/*!40000 ALTER TABLE `smsgeninfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `jbsumum`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbsumum` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbsumum`;

--
-- Table structure for table `agama`
--

DROP TABLE IF EXISTS `agama`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agama` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `agama` varchar(20) NOT NULL,
  `urutan` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`agama`),
  UNIQUE KEY `UX_agama` (`replid`),
  KEY `IX_agama_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agama`
--

LOCK TABLES `agama` WRITE;
/*!40000 ALTER TABLE `agama` DISABLE KEYS */;
INSERT INTO `agama` VALUES (29,'Budha',5,NULL,NULL,NULL,'2010-03-02 03:07:22',48581,0),(28,'Hindu',4,NULL,NULL,NULL,'2010-03-02 03:07:22',61565,0),(25,'Islam',1,NULL,NULL,NULL,'2010-03-02 03:07:22',31019,0),(26,'Katolik',2,NULL,NULL,NULL,'2010-03-02 03:07:22',35929,0),(27,'Protestan',3,NULL,NULL,NULL,'2010-03-02 03:07:22',21057,0);
/*!40000 ALTER TABLE `agama` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_agama BEFORE INSERT ON jbsumum.agama
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_agama BEFORE UPDATE ON jbsumum.agama
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_agama AFTER DELETE ON jbsumum.agama
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsumum', tablename = 'agama', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `identitas`
--

DROP TABLE IF EXISTS `identitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identitas` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(250) DEFAULT NULL,
  `situs` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `alamat1` varchar(255) DEFAULT NULL,
  `alamat2` varchar(255) DEFAULT NULL,
  `alamat3` varchar(255) DEFAULT NULL,
  `alamat4` varchar(255) DEFAULT NULL,
  `telp1` varchar(20) DEFAULT NULL,
  `telp2` varchar(20) DEFAULT NULL,
  `telp3` varchar(20) DEFAULT NULL,
  `telp4` varchar(20) DEFAULT NULL,
  `fax1` varchar(20) DEFAULT NULL,
  `fax2` varchar(20) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `foto` blob,
  `departemen` varchar(50) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `perpustakaan` varchar(45) DEFAULT NULL,
  `info1` varchar(20) DEFAULT NULL,
  `info2` varchar(20) DEFAULT NULL,
  `info3` varchar(20) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_identitas_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identitas`
--

LOCK TABLES `identitas` WRITE;
/*!40000 ALTER TABLE `identitas` DISABLE KEYS */;
INSERT INTO `identitas` VALUES (4,'SMA Indonesia Membaca','www.indonesiamembaca.net','info@indonesiamembaca.net','Jl. Pendidikan No.1','',NULL,NULL,'(022)1234567','(022)1234567','','','(022)1234567','',NULL,'ÿØÿà\0JFIF\0\0\0\0\0\0ÿş\0<CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), quality = 100\nÿÛ\0C\0ÿÛ\0CÿÀ\0\0K\0d\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RğbrÑ\n$4á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0şş(¢Š\0+Ä!Ğ<%¡êş\'ñV¹£øgÃZŸu«k¾!ñ§e£hz.•cÜ_jz¶­¨Ïma§iövèóİ^^\\Cmo\n4’Èˆ¥‡Á¿ğPø)OÀø\'¯‚ôK¿ˆm­|BøÏñŞØ|ı›¾Go«|\\øÁ®Ú!óF•¦I\"ÛøkÁzC•›Åÿ\0<O%‡„¼+b®o.õitİQş<¿moÚKãgíK¦Ëñ¯ş\nUãHìşhú­¶¡à_Ø“áEõúşÎ¿GóÃÃâ¦­{6kñÏâ\Z›Xm[ÅŸu-ánâ)å°ğ·‡ôÈ5[?ôğÛ‰xú®*¦WF&Ë\"êg<IšT–$ÊhÆ*sxœW$İ\\G#R§ƒÂÂ¶*iÆ^Ê4¹ªÇñO<|à0ùu!Äâón+â\n‘Ãp§píf\\]ÄØº“t©C—*”ã†ÁûTá[5Ìjá2ê.3‡Ö*b90õ?|?hoø8/á“êz¯€¿àŸ5¯ÛKÅ77:Uÿ\0ÆËİjO…²†5%{K™bø¹¨é:®½ñv].çd³éß<#â]R·ÊÁã[&-,‘ş:ÿ\0ÁCjy.¤ı¥?mø7Âwë\'›ğ?ö0†ûöhøokoq¹nôSâ™ªk?üm§Oo‹i†«ñ3G±¹‹ÌFfš9~Óş+xëã&„Ú/ÂmYğ·Ãxuô/‡0ğÇ†uŸê¾–Ó^ñoÃ¯é¾2ƒU¶Óõ‡z†|7sáO‹_.!Ò¼?%ìúMÇ…­¥Ôd[Q­éü\røñCá×ˆâøŸñ‡âN›?ü Ş.ÓüY§¾½âm_L²>)‡á_ˆ%ÛYñf£*hú_€¼Cá­½Ò;Ùëö1Ÿ]:w…g7:Uağ‚åUòÚÕ8s4ñÖöuq\\CšT§–ğÎ”åM¬N*ŒçG…\ZqÇScŠÅÊ¾Q«N1•JT¥şYøÓô½ñÃ‰pœA…¥Ç|;àDpo‡Ë¸‡hÕÏü@Íq©ÔRËó#(brÜÆ†aJ¦OˆE—å±Áæ”êakÕ«\nšô½{á·Â+‚z”ş ı‘ÿ\0h¯Ú/ödñ\\¢[PÔ>ütñ½áß^^µÙjş?øoñ\'UøƒğçÇÍ}\"5Ü×¾(ğ½åş°­<ÒjRJÂá?N~\nÁh?à _³Ä¶ÚgíYğÁŸ·ÂëW;ÏŠ³Æ›¦üı¥ô=\0k­O\\ø)¯j¯ğ“âuâ©Ÿ€|YğÊîb­ô	¤òíßğÃß±Ç†uo…¾)øMá>*²ÔµƒŸ\n<-i.¡áûı\'QÔ/şxGWğ÷Ã/Š6ºo‹®õKÍSá>¹ªêvş2ğóøRü3«M¤èWşñªÛXù×>‰âï\n~Ó¿¼]âßøsÅ·Úÿ\0†~ Ëá6ÖÅ…¦µãFøg«Ïâİi|]âß\røÛjZ–³¤hôxOÃ¾ğÖy>µãíJë:KXÁ®_Çéñ†œÆ9U<ËázÈ¡V2â3œ›‡ áS3§Q¬6Ù>*V-UjâğÔ—6;Ï‰ÂÃ:Õ¾{üñ—Â¾$ÄdgÒ&\\cS\r‹9ğO)Å™~?ªQáê´³éOŠrú¸¯íıá°¹n>»tò|¨à3:ÙÅ,.ûÅı¿à ÿ\0²Gíãá­K]ı›>.i>+Ö¼4\"‹Ç¿5ËMCÁ>_¹XßNø‹ğ§ÅVÚW|-\"]³ƒR¼Ò@Õ¦†WĞµVÕVå¾Ğ¯óMğÿ\0Ä‡?|Sà?kÚ¿‹ÿ\0g?ÚÓÂ^ñï¼=ñÃá¥7Âß‰?	¼3àß\ZéşÓ.üGâô½wÑãñ>“â]kÿ\0|gÿ\0	\'…-5-[Ä	×­ßXÑ¯ ÑçìKÿ\0ºñ‡ÃOxOöwÿ\0‚¢ÜøoF“Ä7ö>øWûxøgJ‡Â¿>!kN¶š_†h?\rC$šwÀO‰\Z¬¾Y´ñ-µÀøAâ›™§K[Mf4û¯äî;ğk9á\\^ É1”¸³„¡ìe[6ÀR•,vNñ¡Z–ˆ²®zµ²ÊÑEN¥XÎ¾5£*5kÑÄ³¯ô·Á¿¥g	ø›aø#‹²¼G†&UxªxN\ZÎ±1ÄeR°8Š¸\\F7¸“Øá°œA„J2­C\r:8<Î®QÅa°x¼\núì¿§j)‘ÉÑ¤±:Kˆ²G$l¯ˆà2::’®Œ¤2²’A Óëñ£ú¬(¢Š\0+ò§ş\nƒÿ\06ğ×ìà¿\rø+À^²øÅûbünƒS±ıŸ>çµ³”X¯ñkâ¾¡hÂëÂ_¼$©sâc0ê>%¿H¼%ábÚ¥ÕŞ¡£~«Wğeªk¿?kïø(_Æ¿Š\Z¾¥ã/‹±~Û_´§ìÿ\0‰uç[ŸüøñS_ğ7Â†^´Š8ìü;á-Ãz}¡&¦ÃöŞ¹{â=j}GU¼7cõü<^&ñ¾†«c~¡\nù–g^\Zâ^_‚•%Z	J§õºò­N•9ÕNÊuå\Z¾ÉQ©üïô¤ñÆGÏs?Âå+:Î%ŒÁä=ƒ¬ÜpÎóXâ›J§[û7K\rˆÅW¥‡j¾.¥*8UÃ}eâğüò^øWñÿ\0íKûLxÿ\0]øÓûI|Lky~(ü_½ĞõmoT’×Ì{Ëü2ğVgª_ø7à÷-#º½Ó¼àı1àÒ|3¢ßx[òM:êökà·âoİøï]“Ç^ø¥ğ§Ä÷·\"GÚgˆcÑüS&á“w¡ø_ğşŸoá\Z| Ô¼?~d5]3Bño†µ»MOHñ\nø–ÿ\0PÔ®4NÏö†ğ§5j~<ñªøÖ)¾è¾!ñ_‡µ‡)ñ†¼ga©C§ù®¾şÂÔ´øõ/êËjš•¥êQ_Ùë\r©Máû«K?ZÔ-.ıƒÃ§ËáÍ\n}*õõ=6çIÓîìu9c·ŠmRÚîÒ+˜µ;ˆí-,m–çQY~ÛsäYZDÓÏ#%´¼µÿ\0N²nÃdùÆ‡2˜eù/\rğÎ[G–äÙmjï†:8Œl^o	T§NªÄV¥‹§)W¡˜ËãSWKV‡üôq_ˆ9‡ğ¾sÇ|OS<âŞ>ñ=ÅåÙÿ\0çølövWS&_šarÎ«N…zØW„Âârºñ†‘GC-ÃåøŒ£\rUcu|	ám#XøÁğá¿ˆõÛÿ\0†ß¼añÁÿ\0\n¼]â‡vşƒÇŸÆú•‡‚>Çá_xsÄ¾Óü8|q©x[Ãş+—Rğö£.—á]ZûUÒ£°“Dİ?éŞ¹û~Ïÿ\0ş~Ø÷Ş!ğİ×Å/‰_²gí‰û+üHğ‡ÄŸ‹ÙxÅKğ+FÖÿ\0ema¥Yéš_‚´{gø¹ğ¿^¹ğ÷„t‹YøkZ¸ñSê÷w2Îß“ş<ÒumsÁ~)Òü?t,<Gw ê‰áHíİ¥xš;9fğæ¯r\'Òµ¸ì5y	UÅ´R‚¥Ñ·Å=ã_ÀÚöªÖµ›şÎ_¶§ü³ÀÚwŠüS¡é­âøÄÖšÅOx7Yğ×€ ¸´Ô¼aâ­WÃ´…å¾§ÚÜGw©ë_</á¹.mg¼ÓÉşFú^Ã?Ê3şx|ó9‡\rçÙMXbG0ÄÃ\'¥˜eÕ:ò¥€¥8a#Ï…Ç`®¥JSçU%ÎÔ­ôïö_Tà®&à¾6;ƒøN·poáê®.G—ÖâœFGÄø9WÁÓÄçxŠ5³)*yQ›[ÙâiÑön„=’.yû\'ímğGá/íû`şÆŸ\n~.|=ğ¿Ä\ré_?kßŒ\ZgˆôÈ.ĞÅàæış\ZCw8öİ#Õ~7iš´1ÚİDTÑô½QíºMÕŸóûñßöuğgÂ_ÙOà¯ÇÏ†¾%^|Aı¦¾8üG¼ø#ğÃÆ:×†|Kğ›Mı™®üuñÆ¾Öu½NïÂo`ğÿ\0ìïeğóLÓüQ?Ä½TÖ~%øËÃ2øê:­;éŸ¶w> ı¥|yñsÇšŸ~\Zèÿ\0?kû\nşÒÏûü?Ó|ckâ¯øCñŸ‰>j:¤>/øŠ‘ØYxGâçÂßˆÚ_ÀŸ	|^Ğl4íkÀ2[ø³Âş-øwñÆzwü$ü½ÿ\0‚Xè¾\nø÷û;~Ìœ¿‚¿c_ØÓÀŞğêCµ\"ŠïâV¯k¡^i—ÑÆv®¡¥ø3ösøi©CÖ^*G„…»“âŞÿ\0¬8ÿ\0ø_\"ÉóÜï(Âc³‰Ía•f8¬1~WF¶gŠ£‰…\ZŠZu¨ágBÕéÔ5T”\\š?¬şšê6KàˆœcÅ<Â<O™åÀğİ^$ÈrìÚ¶<âf ËqX\n¸ªÅaëa1Y,g6µ\ZŠiIÉB2?*~/ü\0ğ¯Åãm¨j3İhúôQh–×ÖS_5¯ˆ<9¡kƒÅV~\rñvÚ6­/…ßÅPéŞ ½‡ÃºÏ†5}F÷FÓlïµyt&ÔtkïøGñóÄ–²|	ı¦t‰5Íâ”ß®,¼\'®ørÊ	è?ü5yáÛøwÅ:Æ­tïâ=CÅ:Î§«bâ_Oe¨ø’?j~!»×ü=4×|WÈ>øÇß´Ç‡-&ñ<7ãí7á4šî©uàïìÍóSğmŒdÓ´m_ˆGM¸ñ·†ìîµ=[Ä³]èßuß\nÏ¬Å’øŠşîŞÚÂÙ¿Òn*É_ÀçÙ,0”±øün&Í0š£‚ÏğÙ†&7KFs…\Zõ©RúìiÒtçM,Ãú¶#FşøoÅÏ9É³~âº™|—$Ês.)áÌç/ÃÔÄæÜ˜d˜EhbrÜM*5qX&\'¢¦\'N­\ZòG“e_Àå8œs?L¿àßğQoÿ\0Á5üIá_Ù·ö™ñ~·ãø\'çŠu};Âß¾5ø·S»Ö¼MûkÚµÜZ‡ş|Rñ¡4÷úÏì×©İÍm¤øÇº¤÷¿n¤³ğ×Š.äğTšn«¡ÿ\0c°Í\rÌ1\\[ËöóÆ“A<.²Ã42¨xåŠD,’G\"2º:1VRI\ZşµíEñN‰«xoÄz]†¹ kÚuæ‘­hú¥¬Wºv©¦jòZßXßZN¯\rÅ­Õ¼²C42+#Æì¤`×î‡ü±ã\ZøŸöñ/ƒ|WâíÆ:À?ÚÃö”ı>]øşMgZÑ>\r|(ñ¤Z/€<#6»r¿ÚZÍ—…tù\'ÑtK­Râòò×B´Ó4ˆîÇM²µ¶şúKøA”ø{šåüEÃ’§…Èø—Š¤ò]Wö^aB¯U`´kû:¼&çN„¥Íƒ«R§|<èÂûô\0úQq/ü9ğ7F¾cÅüË±â·Èßäxº•0˜ifú©o`ëQöuñ‘ƒi‡<M~\\u,Ul_îõQ_Ë‡ú(üx—@“á÷íáÿ\0LøcyÛj\ZgíÕã/Š1Û…Ø±?h/†ÿ\0\r>0éLœdßMâ]NèKŒJ$ã,Íıä×ñ¯ÿ\0Oğüÿ\0‚Ãø“ÄH·ğçí«û$ü=ñõô«åÇ}ñOöcñ&©ğ¿Æ\ZM«mÛ=Ò|4ñÂıJRÊm­H‘;X\ZOŞ~9Í<ŸÆU¦¡G5†e“NMÙ{Ln»ÂCÍÕÇQÂÒŠë)£øËéıÂµø§è·âÂR•lW\rÕÈ8ª•8¦ß°Ês¼sJ®ÛG“b³LÊ4]ì›kÉ´ÿ\0„Z—ÄŸ„_µçÅùÒsàÿ\0Ùsá—>œ C*/Æ_‹—7¾\Zğ÷ÄKphbĞ?eO5ÿ\0ÇÛáwÙWÅ‹ğóÅ{>Õìïx9u\rxfÇ@°V¶°êcÑ|%£ié%ş¥®Üe]3Bğ–‡§%Ö­âMRâİ#‹LÑ´-GS¾ıÜvv³»ª·Ó_²oíãïÙ“ö†Ğ.|7ñá/>üvKO‡_,~>.£gğ‡\\ñVm­^ü#]OÆÚ]Ô7_õßjš¦¹ğú×â$º_Œ´MVûÄ¾ğ—ˆ|âké|¨øWútı›gŸ‡\rín|}ì¥û)~ÏŸ<A%üZİïìßc¡x†×UÑîgK›k‹‰CàÀÏk©gíWÖ7~[X&cÔ5-ŞrşåÆ¾3ñ\'ƒş(ø‘K1È0ÜAâ\ZyNÇb3N—d8<>+û3,p•\'\n¸¼\\±pÃâ0|ù”1’uç*œğş=ğŸè£ÀJO£¿€˜Œ‡±ü“p=^/ÃñÎM‚É0Y–cqkËÖÆyŒóJ0ËñÕpÙ^[²¾?šû,‚¦UN8J4èû*¿ÈßÄO\nüpøG¤øOÅ?fOŞøãyüK‡<uâ?	hv–³Âà/|Qñ<šÇcñTß|#ı‹ğûÁ0ñ}ä1øm ^&ƒá?jilöz&£5¿è…k/ø{şûQ|\nÖc×<gñOÂŸ\nÿ\0nşøyà6?ø’ãÂÖ\r5¯‹~ñQµšîÎÃÃ_ş\rü\ZøÉğ²?xïÄ:¦™ èSZèÚõç¼Oàïk¿¬_µÇ„¼KûGüm·øáµfø/û/|pøÙw5ä±[Åoñ‹ö…ø}ñGöWıœmf’L«èÚ‡„uÚÂã^ŞV;K#ÃRºÈ³î‡ùLÕ>/KûşÄ¿¾3şÑ5o…z§íOãOüĞ~ø—I]ãÿ\0í3¢~Ï¶ğü=›áâÔldo„_²7„üQi­øƒã%ôö—ÿ\0ş>\\xòÇá–Ÿƒ¾Aá¿xóòlë8Óé€Êø>¦O†Î8î·\ZdxÈøc-ÄifÏˆ0ÙÆ1Ëéá§ŠÄÊ¥:Xœ.KÉ_™JœªGë29:Ô?°|ú1p¿Ñ§Äº8ÿ\0kñ-^â\0â,7×â\\ÓÃás®Î8J·\nc(TÃeØgÇá³N*l4¡õyÑ¡V®ê¯*¯èOÁº¥§ìƒû|èwß?h/‹ü)âÙ£ZøeáïŒ^0Óü9}àÏÙÛÃöŸü+áÿ\0ø#âV©á«‘w¤ë(ÕltİâgÇ¯i|qñOĞáik^²±ğ‰cø·ûC|XÖ>0~Ö´§üàßüTñÄŸÚ>xGÂß´Ë-RçûÂ~+ğìğ¾ò-OZÕ4\riZ/Ä\rkÀúWˆôYµmO†ú?xÄ)Ñ4jz? şÅŞ%Ñ¼cû9üı«ş\r^ØøoÁ^;ğÖ©ğ[ö–ğçÅ\ZïÆşÿ\0…‘ñ/ü?ø·âo\Z=ó›ï\Z|\rı¥¼Aájÿ\0|Mgt,ğOˆgğ‡í#ÒZÚÂ?}öı”¿hO†>ÿ\0‚‚ê—³ÿ\0Œş_şÊ\0î~øWYº\Z¼_|Aû|sø­ûBx?áÏÃßˆecÄÄ¿	ÀŸµ¯Š0XéQø¾#_6«§øoÆ¾-ğÏ…Ÿş;à(Vñ?<Ë²ú¼;â‡†yßxMÅ<Æ8Zk;àO¸c‹°Y\Zpî{ƒÁã%Mæ™v\Z†#—ÏŠ«‚Çå˜¸æ4êÎštê_I%ã_áß‡¹ä³9øwqE>#âœÓ†ñtğø¼VO€á>!Ì8r4ñŒ&*r¼v|ğñÕİ¬QÅQÂ`é{:˜¯¬Qù‡Çºşjúo‡><ü/øƒğÄZÅÊØèö?4[]7E×µ\'ŞÉ¤xOâƒ©x‹á_5¡\n™´oxïÄz¥±Yïm-‘=ÀÙêãö˜øíã?„^6¶5¿Ù³Æ?<âËGáoŠ¿üaáÈşßx¶Hã•­¾x«OøÁñŸá?ŒatºWÄ›‹ıí¼Iáİ+TÓ?²¸ÃŸôËÛ3ÃŸ~|Oğ–‘®[XxƒG°×¼3â¿	ø›M´Ö4¹/´mbÚæÂÿ\0OÔ4û«[¡m{k$l®›ãÈãñöãø•âïØ/áŸŠ>şÍ~ı…?c][ã?tO	ü.³ø0ç\\øùñg@½ñ%›âïhÿ\0t„<ğëÄ¿¾Ëâ¿Şxë\\ñÇ	x>ûF‡F“Kñî©¥A¨ÿ\0MæI>-ñ†¨ğM~À®)Ìó|…d¼E”c1X)àó<&q‚Å`142ÉQÆOëÏF%V>•$«M¬3ŠöSşTáÿ\0 7†\nqö\'ÅÌgÃŒƒ…øÉñoqFU—fÔ³>Ì¸_6Ë³¼/ˆ)â²º+\'[,>+%Äâ?Ùi)cı£úÍ?Ä?	xŠßÅŞğÏ‹,ínìí|OáıÄ6¶WÈ±ßZ[ëZu¶¥\r­ähî±İÛÇr°ÜÆ‚L’(f\'÷£ş\rÉĞd´ÿ\0‚V|,ñåÂî~7üfı«~4¾àÛ¥³ñí+ñB\r\nósæ&¡á½#FÔ ‘N×·º„‚Ü»5´Štÿ\0€?²ßÄ­kÃ–òZGà…Wútè\Zâêàë_ØÉáO‡Ú5³HÓ]ÜOu¯İè:\\$´÷RÉ2ŸßLØíÇöıŸ‡ì©ûşÉÿ\0³Œ–ëo¨|ıŸ~øÄ\n6?‹t?é6ş1¿,˜üİOÅ_Û\ZŒŞY1ù·O°íÅ}wÓ7¬×‡\\=‹«F¦e†Ë³ß5t9VÅ}CJ­(;Jjb0Y—³RIò¤·‹?3ı–|1…OÇN9ËpØª?=Èxc‡>¸Ô±0Âeÿ\0Û9¾\'\r‰©*u1TpY¶AíÜ%%í%)]ÆQoëz(¢¿‰õÌ+ùøÿ\0ƒˆş_jß²¿Âÿ\0ÛGÂzd·ş3ı€~-Yü\\ñ\nY@÷:¦£û9xöÀü6ı¤4k(‘X°ğ«£|J»y>X¢øf%Ey’%¯è¹ÿ\0øSÃ~;ğ¯‰¼ã-Oñ\'„<eáıgÂ*ğî­İiz÷†üE§\\é\Zæ‹©Z¿És§êšeåÕäòÍo<‘·k»,ÌqyFe—æØ\n®;,Æáse«¥ŠÁ×†#Q-/ÉVœ%këkGdYgd9ß\rgXxâò~!Ês“5ÂËáÄåÙ®¶A»;*¸jõa{;s_¡ü.êÿ\0n×|?e­xYÓm¼Ac.‡ã_‡¾#šÏL×ô[ohWv~$ğ~«y¦j6z¦âM©ZXlèÚ…†¡¤xÃ×ú6£gy¦ê7òşñÁ/?i„7Â×CğÎ§û>|7Ô<U}§xOâGÁ¯ƒ_ğN_Œ_³N«¥|qGÑu%Ñ|CñsLøµñà7‹ît3^[¹µ?	éM£ëº~¿¥ëÚf³£X\\¿İ\'áŠÿ\0bßÿ\0?àß®ï¯o~Ï‰gÏjÅÍÏÅ/ÙÅ××cáŠaº Ôuo\0ùŸ¼tmbXx“ÂPƒ$ÃQŠi}ŸÃ¼uû>ë:ÿ\0Åÿ\0…<_ğ7\\ƒAi<iâ\n\\è·\Z>·áŸÁw{ÿ\0¿‚üc ø»áï‹cĞ¬¤Ô›GÕ|Eá\rS^ğÅ½æ¦¾Õ4vÔ¯ÇúâW‡ø/¤?ğ¿ˆü!‹À`x‚–YìññõÕ%\\,%Ry†SÅB•YĞÅäù‚Å}RµKaå\n˜ŸkËN½EğûÀs ×‹!øâ~[g‰âm‚¯“a%‹Ì°Ùhaèä¼O”åÕ18zXÜ³Š27—<Ë	C›\n¸|Õ”ñ,VıFx³Æz/ìÇû^ø×âgÅ™àğ×ÁÚ[á¿Á¿é?õY¿„>üYøM®|L¶‡áïÄ½~sŸàâNñG¼øSâ\rf[_\rj>:Òüqá\rSXÓ|UâŸ‡Z7‹~Gÿ\0‚ÚÁ+~\Zÿ\0ÁL¾xKÄš¿Ä$øgãÿ\0Ù¶ßÆ¾8ğWn¤2øKPğv¹§hš§ÄO	ø¦[{]Jm+L×ì| Şiş4ÓôÍv÷Â7ºZjø{ÄzmÖ©¡j_k>0ÿ\0‚¦|lø}u«|bı£5/Ùgöo×-“Gñ7ÄïÚzÛà§ì­áİOÖ¡ûÑ´\rYü.Òi½zğNËy¨|Ó<M5®‹ãd)¾yÓ¿bkßƒŸş\"|/ıŸÿ\0à¥~øàŒ~\n¾ğ‰ì?h?Øöªø=û(|Y‹[ûriÍ?Æ¯?õŸ†Ï¯5Ş¯rú?ˆ<­^ëŞ-k«}_ÿ\0„ÇÂ²Ÿ]e8ŒëÂÎ\"Ëø¯…üBÊò6áluË#Æğ;Åàñô&¹ka³œy,¿w)©FüU\nôİL6&\n•IFìfAÆø¾4†ØøoÇ8Ìã8â3>-Àäü5*4]\'8J¯\ræyÍ>,…ê¨ÓœqYpRUhªê-/³?bŸ‚ş=ø÷à?ö,Ö>øöSıŸôÙûàÅ-gÁ\Z$VZßÄ/ˆ³7í?ÄM/ÃŞğìú7¼_áíRñÍÇÃè¿~%ø“TŸâßÜÏgà\rÄ¾1Ñ> h_ºŸ´Gí#áOZ\ZU²ü@øßã[Kû‚Ÿ\0ü;yo7Ä‹^,l,4İ1·\Z?ƒì¯¥µ—ÇŸµ˜-|ğßÃ¿lñ/Œ53K³y[ù„ğÎ‘ÿ\0Añ×ï<ûTÁV¿eŸ…^\"Ñ´/¿²·‚#øû5ë_ixzÓâWƒ­¾2¿Áï…ßî|ãi~+ñGÂ?\n6ñÂvZ—<=¢ØÅªx#IøA®jºäº•Ÿ„¿²WÅÙ¿Ç\Z¥ßì-ûnxWGøëñ;[­à¯¾|Fıˆş6üOµĞíR6“Âÿ\0mïø]>ø«©<åEw}á\0Ãbò[ÉñÍ¼¹ßğŸ\n¼ğÏÃèñt¸Cû;„ó7â¼oqVaæaÄY·qNq\'S4Ïóî&Í%Ä¹®+Š­ûÊ•³t¡,E|V&n„«W­[ìxÇŒø“S/”xOˆ8·…ÀÎŒçÃõx[\r<®†ÁağØ|¯3Îr)b“‡µ”¡‚J±:TèÒÅU¨©Sşˆtt_Ø¯ö\'øğ£\\ø‘¡h^+ø_ğoáÀ}Çº‡Âoˆ¿|7©xÃÀŸ4ŸK¨Oğ×áÖ­áßëV\ZÅ¿…µK›Kx~U’kX¤ÔMÁÎïù]ø³âß|Kø¢ÖŸ\nô¿€ö¿~j’_éúÇÀÿ\0Ø§QıŠ×Ç´“ñá·Œõ_x_Çş5øƒñ—Äòü0ğæ¯®xEÕ<W«xSB»Ôü]ãqgàıR=#ÃŞ+Ÿß>1şÔÿ\0ğP=JëVøûC|`ı¢~êsèŸjñ€ï>|=ø3«ø—ÃóİO¦Ës¥|\\øUà-é‰}nözµğ;â°ĞäwşÎÔ¯&´¾ûÿ\0 k:·ƒ¾øRÖõ9´¯xÀ^ºÔofHb±Ñü=á¯iï<ŞUµº$pYØXZ•†ÚŞ.4†ÙŠ!ÿ\0D<\0ğX×âOfü?ÉòˆÕÇäpÉóL6kƒ«ÃsÇûK¥	`èĞÊœ*V§J¬ÒÇÑ§SğË	:Uÿ\0É¦¿Ó>×fşøwÃq”qOTÃd¼a[Šxs0á¼×\r”cı…Hä96Q‰©×‹âHT£„Äbkà£Äd˜ªÔpÇ¼Î–+©ğàóşØğP_ØÛöQİõøKÆP~Ùß´TH†kH>~ÎÚÎŸ©xÃºì3éŸ¾<İx@{g`ÓéÚ>¹*[VI?»*üÿ\0‚şÉ¾%ğÁˆ·Æ_]h?nÍCÃŞ5Ñ<9¬Ûù:ÏÂßÙwÂöwvÿ\0³×Ã«˜$tícXÑ5]Oâ—Œá¶6Æã\\ñÅ­†«i£áÜ\'ïİ5øÇÇ?ñüAÏx†Œå,±U[’ÆW\\¹N^5Ek®OÛf¦õ…\\]Hô?¾şŠşÿ\0Ä\rğGƒ¸Nœ8‚Xj™ÿ\0Î›Œ¹øŸ;pÅf]H{•–WKê¹%\ZñÒ¶,£Sy0¢Š+òóú (¢Š\0ühÿ\0‚ÈÁ=¼Kû^ü$ğ¯ÆßÙîÇM·ı´ÿ\0eYu¯ü’êh´ë?‹Ô­áÿ\0…“û8x»PsCÃ¿´›‡†ï¯d/|CÓ|3®E{¥Ø¾¹4ÿ\0ÉGÅ¯ÚÀ2xWQøMñ¶ÏÅ¿²Ÿüaig xá×ímàOˆŸ³åëhZİ¿|?kâ_øDÑî®5?É®i\ZGˆ|1¬êPÛ^]YêĞŠ4Wÿ\0Fêç|Uàÿ\0	xïC½ğÏü/áßxoQUMCÃş*Ñ4Ïèwè‡r-î“«ÚŞX]*·Ì«=»…<€\r~³áïŒ<Oáæ[d8*XLÏ‡¸‚ZyU–2Ÿ³–#,&\'–âğXœ5|¿_\r(Ò©^¬_²¡?eí(ÓšşiñÃèµáï9ÿ\0	ñqˆÍ8ø&¶¶EÄy,2ºÎ¼0XúYŸå¹¶_ÁçYf	â(a*,<¢ñ8ºOèbkR—ğéÅüYÕ×â\r¿ÆXu-Iíæµ¶ñ¯Âßøë^ñâé×hwØY~Ñ¾\'üdı¢|/¥ÊK}«Âß\n>0ü0øiª‹Ÿ‡B†|Í;Â\Z6ƒ©Ïâ\n¾­à¯İ¬«wãëÚ×„|w¨¬é²î=gÆZı‡ˆüAk¨ÆLZÖŸ¯êZ›¯Û¼¶ší¥g<ĞIı:|Iÿ\0‚$ÿ\0Á\'>)ê2ë\"ıƒ?gíY¹y$¸Ö~xZãàn±<²±’IåÕ~\nê\0Ô$¹’@$’åîîÿ\0;H[šü\'ı²¿à—ß±ÏÀêºWÁß\rüoğo<b=öÇı²Á¹º‹å[ÿ\0·‡ˆâ$íUq“ŸÖx[Ç¯2®YT¼ÉèĞ­MÒÅÎa…Îjã Õ¤±³¼¦¦6¬¶§_^1»åjçó?ˆßC¤gñ\r>$‡ÓŠqxÌ5uˆË©WÉs.Ãåu#.hÏƒá.%¡”aê«.jø<£:œ±ŒâÔU¾\\°ğ’Úiš&¥k…õË†½ñƒ|ğûàßÀÏx¿R–I¥¸Õ>\"xösøiğÂ?5%—Ì¶ºø££xÉôgWod«ówfÓÃÑø{D»ğÿ\0„ukïøZé¡¸Ô|e‡®ü\"Õd´s\"İx—à_ôüñUÔJeXu/ü8Ö5-;Í–ãK¾Óïº_3ø?û$ü%ñ±e§x›]ı¡õk+U-æ·—öÀı­áG„¤!6¿àaş±şe`ãw\rÀÇôeğ{ş-ÿ\0ŸÕü/¡x«ÅŸ²«üDÖo£¶º¼o‹¿i_‹šmÌÑÊÓh?~1ø³A‘3Ğ¶ša²FÊH>…O¤„Xlš®K—x•VÀUs”ğ˜º¹MN¤õö³ÅG)Çbh»{:ÜŞÖ’Œ)ÁF<¾-¡/Òs0âšYı18“œáı”)fy^‰qU©P¤¢–\\M“åÑÃMEûl\'³x\\D¥RxŠ5eV«—ó3ñ_ö©ø x÷áÎ«ñ[ö‡øK¾ğ×Œ¼máˆ¾+|añg‰n´Ÿ_xSQÓ4ßü1ñ÷ÆO÷:,úv¯á;T¶Ò~Yø+Á¶ÖúÖ£§hÓ”i±AöWì_ûøÿ\0ş\nwñïÀ§âÂ?Šşÿ\0‚zü\"ÔtŠŸ5Ï‹Ÿ\r<iğµkŸèú¹¾øsğoÁ>øƒ¢ø[×şÙë\ZT~0ø³â3¤6™­ZéÚG‚-Úm^kèÿ\0®‚_±Ÿì‹û5$+û=~Ëÿ\0³÷Á)a‰¢¿>xÀÚœªêVFºÕ¼9 iúì³)\"yï.ç|Ÿ6GÉ¯¥+òÜãÇÒ§fÂ9_Áœ%™b15±<&?6ÍsK:u1x*Y–cŠ~ÇŠœ$ñzXXsÆ­zjq£Z¥9Ep·Ñ‡hxŸ‘øÓâoç+x™`ğ8\\k™dÜ5Ãy$±9e\Z”2ÌßdYl>·œå´êE`q¸¬Æ·±	ˆ•*˜¼&M±Æ‘\"E$qÆ‹qÆ¡4@@UEPU@\n\0\0\0)ÔQ_‡Ÿ×ÁEPÿÙ','SMA',0,NULL,NULL,NULL,NULL,'2010-03-02 03:07:22',63030,0),(5,'Sekolah Indonesia Membaca','www.indonesiamembaca.net','info@indonesiamembaca.net','Jl. Pendidikan No.1','Jl. Kebersamaan No.1',NULL,NULL,'(022)1234567','(022)1234567','(022)1234567','(022)1234567','(022)1234567','(022)1234567',NULL,'ÿØÿà\0JFIF\0\0\0\0\0\0ÿş\0<CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), quality = 100\nÿÛ\0C\0ÿÛ\0CÿÀ\0\0Z\0Q\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RğbrÑ\n$4á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0şü˜…\'ŒõóĞÏ¨Æp½8â¼KâÇÇ|-„¥ôªëÒÃæZø~ÆX…Ó+gl×’±xìm³$•I?åŒRà×}ñÅ1ø/Á^#ñLª®t]2âî8d %ÅÎÑ¤\r’¹İI8»‹íf¿õı{Sñ.µ¨ëºÅÌ—z§u%İÔò1İæ9,±Ä¤‘0ÆÂ•OÉ„&\0ı;Ã~¥Å˜œF32©RQ—Ô§N¥:2•:ØÌCQ¨è*±´©Q…9BUçª{ğ„yÜ—æ>#qÅ^¡‡ÁåÑ§<×	T…J±ŒéàğéÊ\n¿³iª•jN3Ir\'	NWQåTk?¶O®g\r ø{ÃÚLî‹ß¶j³7ûî“éñçÜp}ºbÿ\0Ãa|\\ÿ\0íÿ\00‹ßÃşbşçò8÷òÏ|ø•ãÛíOøvI´Òåb¼¼¹´Ó­îJŒ“k%ä°ı¡c÷ˆ\n0‘Ší¿á•¾4qÿ\0í‡ÈÃ¢zóÿ\0/¾ß—JıšyG…9då‚ÄC…¨Ö¡\'\n”±˜ì<ñ0’²qªñX™WæOF¦î›iÙŸC5ñG0„1˜yñ5j5â§J®ŒXyÅò´éı[¨ò½\ZtÒ‹O™hÓ7OíƒñlõƒÂØé½zĞ[ÏZ?á°¾-ÿ\0Ïñÿ\0P{î;õşÖÇ`.õ„?eoÅ;aÇıL\Z\'lÿ\0Óï~ş¿BrÙ_ãGı¶>ÿ\0ñPh‡ v?é§#ŸçïR°ş7áf_åÿ\0Oõü7ô\ZÄø¯¥£Æ-şÉ™ùÓêïÎÛ‡öÀø¶AG„zÿ\0 {ĞqÓŒêŒ8úÔWKáÿ\0Û3Åö’â/èº¼\'aÓ¥ºÑæ“†GÔ¢Üİ×+ñu>xß²ÇÆ…ÿ\0Â;dO·ˆ4^øÿ\0§Ğ9ïøı+Ï¼kğ—Çÿ\0íâ»ñF-•Ä‹j÷6·ö+9äC-Íœ³GŒ£‰Lk!»®Òã’xS›Î848b¾\"»å¥KÃSÅJZ5ì^\nÒ›³´`Ûj÷M;\nyÇŠYe7ÄTâJz6•J˜ì\ryáã¢Û«^\ZpŒ,õ“J:»IKoÔß†_<ñBÁ¦Ğ®šßR¶@Ú†‡|ñÇ©YnÂ£RâİÏ<\r$yù\\£ñ^°\n“ÏlúşX9Çç€;v5øqàÿ\0jşñ›âmWŠÿ\0L¹IBâ;‹q•ÎtWO2˜³±–†Ü9Ïí‡‡õ{}DÒu«S˜5m>ÏQ‡qä	:)!\n‡ØÃ8È8ÇøŸˆÜÇaªàjÔ«”æ>×êê·½W\rZ’„§†KŞ¤Tf§F¬½ùÁMMsÁÉşÑáï\ZÏŠğXŠ8ØS§šeşÏÛºK––&KªxˆCìKš.5©Æğ„œ\\,ÒZÙƒõÿ\0\Z*LûìñTWçè§Ìÿ\0µÔößuâb«y­èv·ş(>Ò×F<gËocõ~SòBäd€ ààğI\'HÎ=ÀÈ+_ª?µÏü’ŒäøHôN£\Zäzvş¦¿+¯g è{dàŒóÏ8\'¦O_ê£Â5ZŠNyÆ1É­äãC	ß¢ÑyË¾0ÊO‹)Å»¨åEşÊ•lL¥oV“gîO„4ËM/Ã>°²…`µ³Ñ4¸-¢@R8ì¡U¡\',Äå˜’NâZºF/RFO£Ô=‡\0ãuè+\'DmºŒA\ZV›œçş|áÏ<tpxéÇ9ùö‹øË{áq„<1r-õËËe¸ÔoĞ#Ë§ZH_Ë‚Ü’|›Ë˜òşiBÑBÈñì\nÿ\0xëãGx\rÀœEâOâqË2Ê®0«™gy¾2¬ã‚Ê2ÚujÑ§Sª§7*µaGB–#ˆœ(Pœ—õÏğÖ?‰ñùnG•S¦«U£Nó©xĞÂa(S‡µÄV”c\'\Z4 £²nRötãïJ\'Ñzß<á¶ë¾&Ñ´©OH¯5xePyÏ”_Ì^¼†ÉÇK:/‹ü/â0ÇA×´½_bo\"Æö†D8ŠFÅ‚ç‚YpxÏ9¯Æ™%’âW¸¸y&šB^Yf‘å–G å¥’Fffç$ç9äAôıJÿ\0J¼·Ô4ëË‹+ëiX.í¦hgÑ\0I×(pRÇpùNT‘_ãÎöÄq#âhÔÇx/‘Gƒ¥ˆå–ÄùŒ¸’É/j³*¹|rÌN\"njƒÊp´ª8ª_X¤¤êÃú6§ÑÛ	õ&¨ñ.!æ*ÕJ¸\ZqÁJ­´±…iW…6ôrúÅI%ïrIû§íP‘[NF0‘ÏçÔñ§¼Óã6k©ü.ñÅ­Ü1Ïğî¥pğvÍi¹‚EêUãš(ÙYpAi®àÅ™~\"hòéºÔ‘Ÿèb4¼‘Q\"şÒ³Ú« ±&ÕY7‘\rÒ¢\",§*ª® zgÅ_ù&ş9ÿ\0±[Yÿ\0Ò)Èı:µ	ø£ÂŞ0ğ·ø•ÀøÚ¸¬‡ˆªà±x9Ö§\Zì&:8|n_¡\Z•V0Ë±´ká1t£R¥8Ö£\'J­j.Yÿ\00ñEÈ?·òLÖŒaŠÂáqtkA{ÔªÓ\ZR§V”Ú=*Ô§\Z”ådùd“´“KñHIùã’:Lç8àŸØÙÚîâ÷à÷‚ä¸pï…Å²±$f+[ë¨!Sœ¬(‹ì:p?¸Àÿ\0€~8şd{Ó¿ëÇìÖ3ğoÁüg÷7ı1ÿ\0A+¯_|gÚ¿³üoŠÿ\0WrÙ4œ£ÒŒd÷QÌ•ÿ\0›–7ïÊµ?˜¼mq`”¥“ÕrWÑ¸âğM7æ¹¥év{¶·æ?øº)”Wóı.|Ëû]ÿ\0\n‚qéâ=99ş;“pN~€sÜšü®úÔäàsÀ<Œ÷=}¹ã¯ÕÚëşI\rÇ`<E¡ãÕ®{cƒsü¸5ù_¾ùÈç¯~qØ½\"¿ª|ÿ\0’Bö7Æÿ\0éœ!ü·ãü•±ÿ\0±Nÿ\0Nâ¿¯éºº6?°4qÿ\0P7®æÒŸ_¯N:ñŠü§øÉsquñOÇ\\‡C¯]ÛE¿vVŞ×mµ¶ÍÄ¦Ğ®06\0¿V´5¡h«œgJÓ³Óµœ]†	éÜô<u\"¾	ı¨¾^èş$oiöïq£ë‘Àº¬‘ aªÄ±Û#M™l7°¤l“aÏIQ°J³ƒßµ‡8«‹|Ê³¾Ãb1Ùqåÿ\0‰ğ˜dç*6+,Í2…œÔ„S”¨ex¼mben\\>[VQ¡‡­8¡\0f˜ÔÂã\'N”ó\\—êx\Z•\ZJx¨ÖÂ×Xdİ’zTêr&ıùASø¥şN»ã>¾‡¿¶qÜõã9ÂûäsßÜväSçúã¨àó÷±N\08{²Œrr}È=zã°ã8ÿ\07	9;$ÛÕ÷z+·òWmôZ³ûBê×ékßÈúöa¹¸ƒâÎ—,Ş]î™®ArªX)·Í®—x.a·`[åáJÀWß?Iÿ\0…qãŒÿ\0Ğ­­{ô²“}ûãZùŸöUøw{g-ßõX\Z½´m3B†PÉ$¶²:Ku¨ì I)onY\0–#,‰#.Òÿ\0LüV\0|7ñÆ3ÿ\0\"¾µúYHæGøq_õû.8Š8èãÂïŠ0¸œ\rn.ã¼äø\\%K†È3%‘à2ê“£?z•<Éåu³|2j>Ó˜añ\n)VWşñû4ÀæœKœ¼áV9~H²ÜMjmJ1”)â«WŒf½Ù:X\Z¥›å«Fpoš\r/ÅÃßg©=¿/ÿ\0_s_¯³Yÿ\0‹7àò?çş=ÿ\0âewî?Lı\r~Cöğôäÿ\0WNşõúóû5Œüğ†sş¢ÿ\08ïÿ\0;®ÜœWû)ãwü“ywıhê8şğcşJ<ı‰«ê^\0÷**]ƒÔşŸáE1ÓÌµÀoøT\0Hñ‡Ó î:ã>Ã89êI5ù\\9\'ƒÀ=±ï×yôy\'­~ÊürğÔ¾-øYâİ\"Ö´ßÔtø@Ş÷Kš+ø’% ~òQÀ¸<¬¤ô¯Æ²Jã	R\rÃ•”ôeÆŞy¨;¨<ÅÒ«ÃXìd½¾4«:æ\\Ü˜šiRŸ.ê-Ò«iY9FË[ŸÌ¾2á*ÓâL.IûVWFçf£Ï‡¯]U‡6ÎIU§.Xİ¨É·¥İ}•´=‚t;nú\'#Î@İ‘ÇN¹Í\\¿ÓìuKY¬µH/m.bhn-®bC,l0É$n`GLŒädØ#ó÷á‡íkmáßéÚŒôMKQŸK´‚Ê×TÒä†In-­áÂ·pİÍ”PäY±**±ø¯Nÿ\0†Îø}ÿ\0Bï‹:äşëIöÿ\0¨¦;wóäş-›øeÅr¯À×áùf8:ÓÄÑŸ,pøœ7YÎ\rNI¸ÎzSå©F¬>8T…›Oö·Ä©…ÂWşÛ£ƒ®©Q”©UUéW¡Z0ƒ”[;sS‘œ$âÜT¢ï¢×ñì§à]Zê[­&óZğñ™Ë½­«Çyc’°EuM¡ËF½BŒUÿ\0~Ì>ğíÜ7úö—‰n-Ìoz‹$VI4gr»ÙZ$k1Î\n¬Ò<}š2pk™ÿ\0†Îøz3x°gş™iqÿ\01>ÔÛ;áïı¾,?X´Ÿ\\ÿ\0ĞS·•/ág¯‚>%a¾\\\'O;-ca/ìÅ<ª)N5#ZÔÇK‡¨Jåœ®œ!;J1NÖûéı!+ÔÁ<¾~#×–ÁSiâ*ûwYÅã‹•×ºÛ®ÛºÛº}sm6ğCQ,QÃ$qÆ¡$v¢\"\0B¨\nª\0\0\00pŸÙá[øÜ’|/­u øócœ¤ÀÎFrkÀöÎø{|;âÀ?ë–‘Ô§\ZŸòç¯\'5âß¿jEñÇ‡/<+áMóI³ÔÓÈÕ5\rJhÅëÚŞÚÚgtˆN¨ÑË#ÈÍå–TÀc_Õ™‡Yı©•ÓK_…¡ŒÁÎ¥zÎ…*(P«NrvM\\iÂÑ§N.WåJ)j¿7ÎüCá8åY‹£œañ˜Š˜LD)PÃÆ¬êÖ­R”¡¬\"£NKšs”b£ÌÓmXøäUHä‡#ÜĞŒc>£Ú¿^¿f°Ãàßƒ²Í½ó‚¹S©]Fz‚:NFHùom5äĞÛZÃ%ÅÅÌÉ\r¼¯™4³K/—G9g‘ø@2[…ÆE~Øü8ĞÂ¾	ğ¿‡réZor«¢ğÛ«Şs×o1Ï$¹Ï9ıGÇU(dù>µí«æsÅÆ7³öXl5JrºÆSÅA&º¦¯½¿4ğ[RYÎmŒIû\Ztpò—GS‰¥R¾ÊJiIÅëf›µã~ãqôÿ\0Ğ¿øš)p=ÿ\03ş4WóYıA Ü¸*01òõäscÈ23Á¯ƒ>8~Ìú¥âï‡PÅ4—Ò=Ö£áœÇ›©|É\'»Ò§â8q+¨i,dÂFvÛx‰>óiTmÏä`r8cWÀ%”S¼ÀAÇ ãsrÇ±wÆ:ğ+ŞáŞ$Í¸_ı¡•WŒ\'(*UèU‡´Ãb¨©)ºUéŞ-««Âp:”å¬fµOÀâË8›õÎ“”#\'Rjo“†«ËËÏB¦©]i8N)Íi(ì×áæ³àoø~_+[ğ¶¹¥ÉÊw¥İ b2p³4>[ğ	l‘ÏJÄ:V¤3:ğ`÷³œvÎ?ÕõÀÎ}	8àWëo¯ü{oñ#áş‹ ŞY\'…<N·ã_76PMs£\'†µ«‰íd–ÆàH|Kg4z­ÌÑÇd!KÛ2.÷q>ø‡â}wâ÷Œ|5}c}gà}NßTÓ|«Iáû+[TÖ|\r5¶›âYíµgOíc¬_ßŞMcßîm ğÌ¯rC¨e?[¡ã*4â«pí	ÔIsJ–eRŒ$îµ9àñõÑÕ“ó±ùE°²¨İş¼)»5\Z¹u:³Wi|pÅQƒµ“²¥¬üÈ:^¢üƒ¯yÇcŸ8ç§îòrAõèqÒizò¼<dâÎ~çŸ\0õì	Ïú3Œ>*[ü×µÍFH.>\"k~&—À^´Ğ|9i{öí7T»ñ*ésÛ[-ëÏq£xƒÇÒi÷rı–ÛJ{]-2±æµñ?Äá¯‚^\"KÅğıÖµ©C¦ø÷ÂCJÓÄúÆ½§£è\Z“£Úk\ZeÕµÜzf®ú”º‹¦ßé\"ŸI1k\ZEëÁ¤]Ø^ì¼t«}xnÛşFò]·ÿ\0„ï]~zêeÿ\0BŸıSÿ\0ÃRòÿ\0¨ëúiÓ¥´üçşËÔOM:÷“‹IÁÏ9äFNxÇ¾k£Ğ¾øãÄ’¬:„õİL’ 4:uÂÂ7œk™„6è½Ë4™ ‚9¯Ñ¸>!ø‘ş=Ïá™4»Õøk%¤´½mìóñÇJOK|uì5Á·¼Òe»Ğ’ÎU‰¨é£--î[˜øñ/â‡ˆ|kmáOÄígÿ\0¯‹üQm©Å¡Å¦ØëRø·IÓ¼6tvéjZ$kâ\"òÒÙ‘®­í¬õ{¨İ®¡ã_Ç,\\©Éaø{Nµ½ÉWÌ+b)Åé«§O‡r¶¾ë«é«zPğK\rÇëş\"t®œãCJŒİ­uÏWZ1º²OÙU¶Î6WP|ı›Â7–>1ñÈ·ŸÄì$Ó4H¶Kk¤LK*İİ\\FÍÕúÆÎbØ6å·‡’`¬¿h„UÎÑ·å<öÈõ8Àõÿ\0Dè¨¼˜ezîaÇ8ûİ×§vP1%t#¨!¹ÉôÈì~˜Áøş}Ÿæ|I˜TÌ³Zê­y%\np§gC\rF?\r=+Ë’œ{ÊS©7ïT©9{Çë™C–ğæ~YEÒ¢¥í*No¶\"³V•zõ,œêJËD£N	rÓ„#î“QQyÉïùQ^1ìŸüqÖş7Ú|C±ÒşO«Çf¶ŞÔ£¶‹H†çFÔî-Å=O^Ñoõ‹	!±‡_MÂš%ıÊÜA=¤Z‹ÄöòL†O\ZğŸÄ¿z¨²Ôà¸øÿ\0	uä½Ğü\r®ø@ÚhúV¦ş0›ÄÇ_môÛ½*Ö\r#d­¬YO\råµ¬v×?Ú.—?¦G«~úS‰¿à_ 8 i¥º¾·ßÓMÍ}OÆ¸øu®üCñM¼rø_\\ñ}¿‹<o¤µö¿gà‰ºç‹¼i$ş\ZÑÎŸi«\\è¾\Z´†GY-t_ŞéÑêÇíOg&w†üñ§Yğÿ\0ˆou¯øÃÂúÄøg}¢[j~ñ%µÆıOKğ.£âo´izoÃmb+)oî.õ­\ZûZ’êöóÃW·—3\\h&ßL‘‡éĞê}“#Ø2~¦œzã¶@Ç¶SŠuü«¥¿­Ÿİ÷Ÿ›²|WøüZÎëIğ¿Ä«Û=Äú‹üEky¡hQİ¿Ãû_‡ß	Î£áË×¿ƒÃ«¨\\êº¯ˆ|s©:øJÎë_‹_ĞM¬:DV~m´7Æ/|}ÑüñIğ4~%ŸÃ~*ğVáÏ_Xøz+»ø¾]:ÿ\0Ä:§‹á’}6uº2øv×\\%ÔšöÎßÅ\ZW†tÇ³]rh%ûğuEşMN<tã•†G\nêéÙik®úÿ\0‡¹ù•\'Œh[ïxµôx¤xîßÆ¾]G¹ÑnD\'B=ëUµ¼³ºğe¾‘i£ë“}«LÔu;=wP»‚Úöö`š{Û¤ËËø¯â·í+ı³â}.O\ZøSL×õVñƒü9?„oã¸Ñ´ğ.©qáÏ\rŞGgàí~ú}kVÔl4ûİJÃQÇ»ªÉ£İê:u¬H‹ú½Eæ_Ê·¿åuø|¿?ÎôøñºïZñ,šî‹ñÂñw‰´M[DÕàğî{¨xCÀ:.»}á]~\r!<E©Û]jĞÿ\0Ââ³â15hˆ¼]}£ÙK¦è†k_Cø{ãÿ\0‰w¿à†âÃâ§ğsRÒ%ğN¯ø—ÃÚV–.¼W¡iÖ>\">)Ô-£KY¶¶³øÃóİj\ZÒü;#èš¶7rŞêWÉöm	´öVĞËûDßóîß÷Òÿ\0ñTV¥ÿÙ','yayasan',0,NULL,NULL,NULL,NULL,'2010-03-02 03:07:22',55385,0),(6,'Perpustakaan Umum','','','',NULL,NULL,NULL,'','',NULL,NULL,'',NULL,NULL,'ÿØÿà\0JFIF\0\0\0\0\0\0ÿş\0;CREATOR: gd-jpeg v1.0 (using IJG JPEG v62), quality = 70\nÿÛ\0C\0\n\n\n\n\r\r#%$\"\"!&+7/&)4)!\"0A149;>>>%.DIC<H7=>;ÿÛ\0C\n\r;(\"(;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ÿÀ\0\0K\0d\"\0ÿÄ\0\0\0\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁRÑğ$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚáâãäåæçèéêñòóôõö÷øùúÿÄ\0\0\0\0\0\0\0\0	\nÿÄ\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3RğbrÑ\n$4á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹ºÂÃÄÅÆÇÈÉÊÒÓÔÕÖ×ØÙÚâãäåæçèéêòóôõö÷øùúÿÚ\0\0\0?\0öj(¢€\nd²ÇM,®±Æƒ,ìpz“Xş%ñVŸá›d7§º›\"ŞÒ.d˜ûÃÔy¿ªŞëo|K6-Tæ=:|”=·ãovã=+jT\'Wm»œ˜œ]<:\\Ú·²[³²Ôş%ÚïkY¶« 87¼»e?ïã-ÿ\0ë\\Íæ£â-`Ÿí-nX£?òí§şá±o¾:Ç[Éï¢ÙiGo*íŠDB¥9*Àçîàa‡N˜§iú}Õ¬ÂêòåXùln$í=OLßŸjõ(áiFÚsyô>{˜â&šæPòZ¿¼µkdlÉ¤j7º|I‚áŠ±õel†üEoØxïÄ\Za«YÅ«Û³Zàz”?+~W‡ØÉi\rôšĞeH$ !_ª’r1Ç§RÖâY£˜¼smİ€[Ë99!{€ \0~j§BHİÂŞhŠXÊôgÊªßÊIù|ûÃ¡ø›Hñ-&›v²:¬…Yb>Œ‡‘ZµàÑ][^O’<–:”hî·0Ÿ-âPØ=²ùNG$Wu xşkI£Ó¼RQw°êh»böàoº}«Í«†”4u_Öç½†Ì!V\\“\\²íßÑõ;ú)ÈÈ¥®SÑ\n(¢€\nç<]âÈ¼9mñ‹­Rèmm=İıwõè+£¯W’ïÄ\ZİíÓ´·?Ú[ïoá7*Š=\0ã]j>Ú¢‰ÃÅ}Vƒ¨•ŞÈ·[É6«©Ü=Õüÿ\0ë§*Iÿ\0uTtQè;Ôzl’Ü´ÒyñÜ[H}Ca°8R8+Ä{Ôºœ05«\\Oææ.¦\'*Àã¶;ö«Pí0¡FÜ¥A×Ş½øÓQ’ŠÑ#âªVsƒ©-e-Ûı[Â¨Y[I!‚ÒIV\'x€Ş»ÕÆAÉ\0ñĞÖüÓìm5F’#q>Ÿ}‰4ÿ\03y@Äı:÷×Îkœ¹G’ÚDŒâB§aônÇó®æñc¿ÒïuWs§£¨wQ¹£l1/s‰?ñĞ+ÍÌy£%g£=ü‹ÙÎœ¯Ìıu-kZ}¦©â\r.ÒòŞ9£Xn&!ÆzyküÜ~UÅê:\\6Z¥ı­Ìækë‡6ğÈÁ£îb¤œná6ó“ÉÖu;›ùš{e¶Ô¿³¦ûA÷+S9nÌ¬ÓA<ãŸñJ¥¾©c¦Bu¦Ø,kÿ\08Çå\ZşuÉ„æuTbìzYŸ³\ZSœSkk®úåö›î‰Wà?ˆ§Û8<c¥S²ºiWì\Zšoy÷ŒŸ* ÀÁ\'®I÷ëÕ³Y—6Ö÷:Ê$±Ì°î&<WwwQÔğ¯z¤lù£ÿ\0|u\nœÑpËUäoxcÅøVhôİNf—E‘‚Apç-fOEcŞ?Cü=ê\0‚ ÷¯!’4š&ŠDeaEuÿ\0.\'›Â²C,Ï*Z^Ío	s’±«aF{ã¥xøì4i5(ìÏ§Ê1óÄÅÓ©¼z÷ÿ\0‚vQEyç¸ãÒÇöox†Õ†u—Ò*¸şf½†¼»Æß`øƒ$˜ÂjvI >¯*GıòV»02å®¼Ï+7¦çƒ•ºY•–É®´ıNğçÊ°€cóÑø}|ÿ\0\\Õ	x¢T\\€r[Ğßè*şª\\i:²®má‚ï÷r‹¬ˆÙ†ve‡Ü\'$g `ñÿ\0JÓ-­TÜdéöW/ÆĞÈÿ\0{b“ùWe\\LèVÕï·¡æaòúxÜ-7Y+ß×¯õØó[¨o¬£[­2îe-²G@:)c•Îá…Ry¡­¨u˜\"øk¨X8yn#†êâŒnm»Kƒìª®¹\'Û¹º=juMHXCôk9g9ÿ\0’+Eá7òçOz|;á»›İFÍ­ÚşC\nÀë‰®D.Æşì@ä·vİ	æ•Z˜¤¡kÊú[ÌôğØ`êŞìÓ½ü­oÔí`q¢x©\ZûP¸½íKq mÇ˜\0V#¡\'cÔã8â¹]Nõïµëùá†[‡ëb$C<\"^N\0¨={“ØÔú©>‘e«Y0)PÁv“®ôŞØW.;£»Ppßß\r?‡ômFÒßZc§ËÓÌFÙçÌ0ÈÒVş Wjîï»±ÈX,Z\\òJÒâÓèÓ³GN;õ…\Zrø[»·£·âgÜÇqc\"Çk5›±Â‰— a•\'ØOÓ´Ã«j’ÙÃ;Z´±¿÷dF3şÉŞêŞö¯QfÔ,•Š¤öó `AWR285Éø‚îoYIo¦ÛéZ[\\ÈoÌÒŒà°@ª…ÉÉ,;×|±³«Kk¦§¢–§¶R÷RwOµ»œ”2‰àP(`Q‘]ÂèÊø\ZŞsÖêyçüål~€W©Ìºn‰;Æ1äÂV0=q…+Ö<9¦ÿ\0cøoMÓq†¶¶6ÿ\0x(Ïëš×2—Ã¹ÏÓ_¼¨¶Ñ/ëî4è¢ŠòO¥\nâş\'iìú¾µæ]\"o9±ÔÂß,ƒò!¿à5ÚTsCÄA2	\"•J:0á ÓŒœZh™ÁN.2ÙDû¤ˆ<¡Æ\'À 0ät#Û¸®ÇÂ:­›b8šÎ„–ŞßKx—‚ûŠ½½kŠK)tRëÃ×$“ió[;Ë[s÷Ô}Óî*Ô7sé’=å¥ä–÷„a”yH ã£Õí×¢±TÕHn|–,¶¼¨UWÿ\0§ó=iÓI×åº»\";[è£E¸o»ˆ[åcØÃ¦AHÎo¼mâÍ.)^ãìóY’9İ*@,¦v{c½cI?Š¯íŞjM§X¸ÃÍx#·V°wçÛåÏ­R]¬l\'µÓüK¤W1˜Ü]i³Eo.z|îÛsÏQ×Üq^T\\¨ÉN´—céáUÔûŞz~šš…Æ¥jº+ÛE§Y%´R´kËÉ›€¬}²s]~§ªÅ§D:îPE½ªVö‡«t“\\Iâ‹‹£qªø®ÂİÕe´ìÖ…çq¸oØ«‚rPr9¶ÒÙh·zUË[o&å­ä…­e—‰6àßú×&J—7&»½İßvõ5©VjŞë~–;dÿ\0‰†ìíåH ”ÂÒ©eP3µH\'¡î+Ï/f‚îû‰h- 9\rm`mwÊ7)$1,v‚G8êxèjåö±âf°Ôo/-Ø®^#ÄXtáÔsõV¬É;fv+0¦O`ª{x<%Ÿµ›VGÍæ™Ÿ4^ši½î­òù±±şÛñf—¤º(äûm×§—ùAú¾Ñø\Zõúã>hÒÛi³k—±”»ÕHuFÅ\0ÿ\0V¿\\ÇıïjìëƒWÚÕrè{87Õ°ñƒßwêQEsÁEP-ãŸË­ØG}§*VÃ/oª~ôGÙ‡OCŠókİNÜÀÖ—Ë&4€+E}BqüC$c¦yîUĞCqŠx’XÛªº†ğ5ÓG:IÅlÎV–&Q›ÒK¯ùJ/&½“íô3cHdbøÿ\0®ŒÌãè¬µ5`HÜÉè¥=dŠ¹ú°äş5ß]xÂw¾MÍõhÊ?šb¹\rwÂ:6›3%œWP¨=úş.ºiâèÅ[Ùœ²ÌUIs{wù~LÏXv£FXÜå£$‰ú²ÆªşšUˆE1FzÆ0c?XØ?ˆªö:-¤ò–KÆãn›ÿ\0‹®âÇáÏ„Ş–]+ÏsÉóî%Á˜Š\\ £Ê©²¼[Ÿ<«»üÿ\0Ìà¯5‹xî {½FÜyHÑ„ó˜ƒŒ\0¬ÍGlzV¦ƒ Üx·T‡í—è–äK+OGö¶åE+‘’\nô­?BÒ4¬givv˜ï\n‡ó¯×<±O‘Ó‚²;©åÑU•z²æ’ô_€€``RÑEr˜QEÿÙ','P_alls',1,'alls',NULL,NULL,NULL,'2010-03-25 06:22:39',22308,0);
/*!40000 ALTER TABLE `identitas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_identitas BEFORE INSERT ON jbsumum.identitas
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_identitas BEFORE UPDATE ON jbsumum.identitas
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_identitas AFTER DELETE ON jbsumum.identitas
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsumum', tablename = 'identitas', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `jenispekerjaan`
--

DROP TABLE IF EXISTS `jenispekerjaan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jenispekerjaan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pekerjaan` varchar(100) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pekerjaan`),
  UNIQUE KEY `UX_jenispekerjaan` (`replid`),
  KEY `IX_jenispekerjaan_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jenispekerjaan`
--

LOCK TABLES `jenispekerjaan` WRITE;
/*!40000 ALTER TABLE `jenispekerjaan` DISABLE KEYS */;
INSERT INTO `jenispekerjaan` VALUES (14,'PNS',NULL,NULL,NULL,'2010-03-02 03:07:22',10914,0),(15,'Wiraswasta',NULL,NULL,NULL,'2010-03-02 03:07:22',53173,0);
/*!40000 ALTER TABLE `jenispekerjaan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_jenispekerjaan BEFORE INSERT ON jbsumum.jenispekerjaan
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_jenispekerjaan BEFORE UPDATE ON jbsumum.jenispekerjaan
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_jenispekerjaan AFTER DELETE ON jbsumum.jenispekerjaan
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsumum', tablename = 'jenispekerjaan', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `petasekolah`
--

DROP TABLE IF EXISTS `petasekolah`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `petasekolah` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idsekolah` int(10) unsigned NOT NULL,
  `idwilayah` int(10) unsigned DEFAULT NULL,
  `koordinat` varchar(100) DEFAULT NULL,
  `gambar` blob,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_peta_wilayah` (`idwilayah`),
  KEY `FK_peta_sekolah` (`idsekolah`),
  KEY `IX_petasekolah_ts` (`ts`,`issync`),
  CONSTRAINT `FK_peta_sekolah` FOREIGN KEY (`idsekolah`) REFERENCES `identitas` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_peta_wilayah` FOREIGN KEY (`idwilayah`) REFERENCES `wilayah` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petasekolah`
--

LOCK TABLES `petasekolah` WRITE;
/*!40000 ALTER TABLE `petasekolah` DISABLE KEYS */;
/*!40000 ALTER TABLE `petasekolah` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sekolah`
--

DROP TABLE IF EXISTS `sekolah`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sekolah` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `namasekolah` varchar(45) NOT NULL,
  `gambar` blob,
  `koordinat` text,
  `wilayah` int(10) unsigned NOT NULL,
  `titikpusat` varchar(10) NOT NULL,
  `lokasi` varchar(10) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_sekolah_wilayah` (`wilayah`),
  KEY `IX_sekolah_ts` (`ts`,`issync`),
  CONSTRAINT `FK_sekolah_wilayah` FOREIGN KEY (`wilayah`) REFERENCES `wilayah` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sekolah`
--

LOCK TABLES `sekolah` WRITE;
/*!40000 ALTER TABLE `sekolah` DISABLE KEYS */;
/*!40000 ALTER TABLE `sekolah` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suku`
--

DROP TABLE IF EXISTS `suku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suku` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `suku` varchar(20) NOT NULL,
  `urutan` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`suku`),
  UNIQUE KEY `UX_suku` (`replid`),
  KEY `IX_suku_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suku`
--

LOCK TABLES `suku` WRITE;
/*!40000 ALTER TABLE `suku` DISABLE KEYS */;
INSERT INTO `suku` VALUES (32,'Jawa',0,NULL,NULL,NULL,'2010-03-02 03:07:22',36536,0),(34,'Minang',0,NULL,NULL,NULL,'2012-07-19 07:27:05',23157,0),(33,'Sunda',0,NULL,NULL,NULL,'2010-03-02 03:07:22',6177,0);
/*!40000 ALTER TABLE `suku` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_suku BEFORE INSERT ON jbsumum.suku
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_suku BEFORE UPDATE ON jbsumum.suku
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_suku AFTER DELETE ON jbsumum.suku
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsumum', tablename = 'suku', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tabledep`
--

DROP TABLE IF EXISTS `tabledep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tabledep` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rootid` int(10) unsigned NOT NULL,
  `tname` varchar(100) NOT NULL,
  `colname` varchar(100) DEFAULT NULL,
  `deldep` varchar(2) DEFAULT NULL,
  `upddep` varchar(2) DEFAULT NULL,
  `tingkat` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `coltype` varchar(100) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IX_content` (`tname`,`deldep`,`upddep`),
  KEY `IX_tabledep_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabledep`
--

LOCK TABLES `tabledep` WRITE;
/*!40000 ALTER TABLE `tabledep` DISABLE KEYS */;
/*!40000 ALTER TABLE `tabledep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tingkatpendidikan`
--

DROP TABLE IF EXISTS `tingkatpendidikan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tingkatpendidikan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pendidikan` varchar(20) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pendidikan`),
  UNIQUE KEY `UX_tingkatpendidikan` (`replid`),
  KEY `IX_tingkatpendidikan_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tingkatpendidikan`
--

LOCK TABLES `tingkatpendidikan` WRITE;
/*!40000 ALTER TABLE `tingkatpendidikan` DISABLE KEYS */;
INSERT INTO `tingkatpendidikan` VALUES (25,'D1',NULL,NULL,NULL,'2010-03-02 03:07:22',26946,0),(24,'D3',NULL,NULL,NULL,'2010-03-02 03:07:22',50668,0),(23,'S1',NULL,NULL,NULL,'2010-03-02 03:07:22',41443,0),(22,'S2',NULL,NULL,NULL,'2010-03-02 03:07:22',55209,0),(21,'S3',NULL,NULL,NULL,'2010-03-02 03:07:22',20656,0),(28,'SD',NULL,NULL,NULL,'2010-03-02 03:07:22',3183,0),(26,'SMA',NULL,NULL,NULL,'2010-03-02 03:07:22',19478,0),(27,'SMP',NULL,NULL,NULL,'2010-03-02 03:07:22',22307,0);
/*!40000 ALTER TABLE `tingkatpendidikan` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trins_20_tingkatpendidikan BEFORE INSERT ON jbsumum.tingkatpendidikan
FOR EACH ROW SET NEW.token = FLOOR(1 + (RAND() * 65530)) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trupd_20_tingkatpendidikan BEFORE UPDATE ON jbsumum.tingkatpendidikan
FOR EACH ROW BEGIN 
  IF @DISABLE_TRIGER IS NULL THEN
      IF OLD.issync = 1 THEN 
          SET NEW.issync = 0; 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
      IF OLD.issync = 0 AND NEW.issync = 0 THEN 
          SET NEW.ts = CURRENT_TIMESTAMP; 
      END IF; 
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER fsync_trdel_20_tingkatpendidikan AFTER DELETE ON jbsumum.tingkatpendidikan
FOR EACH ROW BEGIN
  IF @DISABLE_TRIGER IS NULL THEN
     INSERT INTO jbsclient.deleteddata SET token = FLOOR(1 + (RAND() * 65530)), dbname = 'jbsumum', tablename = 'tingkatpendidikan', dataid = OLD.replid, datatoken = OLD.token;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `wilayah`
--

DROP TABLE IF EXISTS `wilayah`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wilayah` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `namawilayah` varchar(45) NOT NULL,
  `gambar` varchar(100) DEFAULT NULL,
  `koordinat` text,
  `rootid` int(10) unsigned NOT NULL,
  `titikpusat` varchar(15) DEFAULT NULL,
  `zoom` varchar(30) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_wilayah_provinsi` (`rootid`),
  KEY `IX_wilayah_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wilayah`
--

LOCK TABLES `wilayah` WRITE;
/*!40000 ALTER TABLE `wilayah` DISABLE KEYS */;
/*!40000 ALTER TABLE `wilayah` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wilayah1`
--

DROP TABLE IF EXISTS `wilayah1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wilayah1` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `namawilayah` varchar(45) NOT NULL,
  `gambar` blob,
  `koordinat` text,
  `rootid` int(10) unsigned NOT NULL,
  `titikpusat` varchar(15) DEFAULT NULL,
  `zoom` varchar(30) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_wilayah_provinsi` (`rootid`),
  KEY `IX_wilayah1_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wilayah1`
--

LOCK TABLES `wilayah1` WRITE;
/*!40000 ALTER TABLE `wilayah1` DISABLE KEYS */;
/*!40000 ALTER TABLE `wilayah1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `jbsuser`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbsuser` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbsuser`;

--
-- Table structure for table `adminsiswa`
--

DROP TABLE IF EXISTS `adminsiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adminsiswa` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isnew` varchar(45) NOT NULL DEFAULT '1',
  `haschange` varchar(45) NOT NULL DEFAULT '0',
  `password` varchar(100) NOT NULL DEFAULT '',
  `lastlogin` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`replid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminsiswa`
--

LOCK TABLES `adminsiswa` WRITE;
/*!40000 ALTER TABLE `adminsiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminsiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hakakses`
--

DROP TABLE IF EXISTS `hakakses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hakakses` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(30) NOT NULL,
  `modul` varchar(100) NOT NULL,
  `tingkat` tinyint(1) unsigned NOT NULL,
  `departemen` varchar(50) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `theme` tinyint(2) unsigned DEFAULT '1',
  `lastlogin` datetime DEFAULT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_hakakses_login` (`login`),
  KEY `FK_hakakses_departemen` (`departemen`),
  CONSTRAINT `FK_hakakses_departemen` FOREIGN KEY (`departemen`) REFERENCES `jbsakad`.`departemen` (`departemen`) ON UPDATE CASCADE,
  CONSTRAINT `FK_hakakses_login` FOREIGN KEY (`login`) REFERENCES `login` (`login`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hakakses`
--

LOCK TABLES `hakakses` WRITE;
/*!40000 ALTER TABLE `hakakses` DISABLE KEYS */;
INSERT INTO `hakakses` VALUES (NULL,NULL,NULL,20,'101','SIMAKA',1,NULL,'',1,'2010-03-05 14:00:05',1,NULL,NULL,NULL),(NULL,NULL,NULL,21,'101','KEUANGAN',1,NULL,'',1,'2010-03-05 14:00:29',1,NULL,NULL,NULL),(NULL,NULL,NULL,22,'101','SIMTAKA',1,NULL,NULL,1,NULL,1,NULL,NULL,NULL),(NULL,NULL,NULL,23,'101','INFOGURU',1,NULL,NULL,1,'2010-04-16 10:01:22',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `hakakses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hakaksesinfosiswa`
--

DROP TABLE IF EXISTS `hakaksesinfosiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hakaksesinfosiswa` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nis` varchar(20) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `theme` tinyint(2) unsigned DEFAULT '1',
  `lastlogin` datetime DEFAULT NULL,
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_hakaksesinfosiswa_nis` (`nis`),
  CONSTRAINT `FK_hakaksesinfosiswa_nis` FOREIGN KEY (`nis`) REFERENCES `jbsakad`.`siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hakaksesinfosiswa`
--

LOCK TABLES `hakaksesinfosiswa` WRITE;
/*!40000 ALTER TABLE `hakaksesinfosiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `hakaksesinfosiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hakakseskeuangan`
--

DROP TABLE IF EXISTS `hakakseskeuangan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hakakseskeuangan` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(20) NOT NULL,
  `modul` varchar(100) NOT NULL,
  `tingkat` tinyint(1) unsigned NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`replid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hakakseskeuangan`
--

LOCK TABLES `hakakseskeuangan` WRITE;
/*!40000 ALTER TABLE `hakakseskeuangan` DISABLE KEYS */;
/*!40000 ALTER TABLE `hakakseskeuangan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hakaksessimaka`
--

DROP TABLE IF EXISTS `hakaksessimaka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hakaksessimaka` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(20) NOT NULL,
  `modul` varchar(100) NOT NULL,
  `tingkat` tinyint(1) unsigned NOT NULL,
  `departemen` varchar(50) NOT NULL,
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_hakakses_nip` (`login`),
  KEY `FK_hakakses_modul` (`modul`),
  CONSTRAINT `FK_hakakses_modul` FOREIGN KEY (`modul`) REFERENCES `modul` (`modul`) ON UPDATE CASCADE,
  CONSTRAINT `FK_hakakses_nip` FOREIGN KEY (`login`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hakaksessimaka`
--

LOCK TABLES `hakaksessimaka` WRITE;
/*!40000 ALTER TABLE `hakaksessimaka` DISABLE KEYS */;
/*!40000 ALTER TABLE `hakaksessimaka` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `landlord`
--

DROP TABLE IF EXISTS `landlord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `landlord` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isnew` varchar(45) NOT NULL DEFAULT '1',
  `haschange` varchar(45) NOT NULL DEFAULT '0',
  `password` varchar(100) NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`replid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landlord`
--

LOCK TABLES `landlord` WRITE;
/*!40000 ALTER TABLE `landlord` DISABLE KEYS */;
INSERT INTO `landlord` VALUES ('GMS2','BD','AT',1,'1','0','5f4dcc3b5aa765d61d8327deb882cf99','2012-09-21 19:49:25',NULL,NULL,NULL);
/*!40000 ALTER TABLE `landlord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_login_nip` (`login`),
  CONSTRAINT `FK_login_nip` FOREIGN KEY (`login`) REFERENCES `jbssdm`.`pegawai` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (NULL,NULL,NULL,7,'101','5f4dcc3b5aa765d61d8327deb882cf99','',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loginsiswa`
--

DROP TABLE IF EXISTS `loginsiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loginsiswa` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(20) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `theme` tinyint(2) NOT NULL DEFAULT '1',
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_loginsiswa_nis` (`login`),
  CONSTRAINT `FK_loginsiswa_nis` FOREIGN KEY (`login`) REFERENCES `jbsakad`.`siswa` (`nis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loginsiswa`
--

LOCK TABLES `loginsiswa` WRITE;
/*!40000 ALTER TABLE `loginsiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `loginsiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lokasi`
--

DROP TABLE IF EXISTS `lokasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lokasi` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isnew` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `haschange` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lokasi` varchar(45) NOT NULL DEFAULT '',
  `singkatan` varchar(3) NOT NULL DEFAULT '',
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`replid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lokasi`
--

LOCK TABLES `lokasi` WRITE;
/*!40000 ALTER TABLE `lokasi` DISABLE KEYS */;
/*!40000 ALTER TABLE `lokasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modul`
--

DROP TABLE IF EXISTS `modul`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modul` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `isnew` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `haschange` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `modul` varchar(100) NOT NULL,
  `info1` varchar(50) DEFAULT NULL,
  `info2` varchar(50) DEFAULT NULL,
  `info3` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`modul`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modul`
--

LOCK TABLES `modul` WRITE;
/*!40000 ALTER TABLE `modul` DISABLE KEYS */;
/*!40000 ALTER TABLE `modul` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `jbsvcr`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `jbsvcr` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jbsvcr`;

--
-- Table structure for table `agenda`
--

DROP TABLE IF EXISTS `agenda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agenda` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tanggal` date NOT NULL,
  `judul` varchar(255) NOT NULL,
  `komentar` text NOT NULL,
  `idguru` varchar(20) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_agenda_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agenda`
--

LOCK TABLES `agenda` WRITE;
/*!40000 ALTER TABLE `agenda` DISABLE KEYS */;
/*!40000 ALTER TABLE `agenda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `angket`
--

DROP TABLE IF EXISTS `angket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `angket` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `judul` varchar(255) NOT NULL DEFAULT '',
  `tglmulai` date NOT NULL DEFAULT '0000-00-00',
  `tglakhir` date NOT NULL DEFAULT '0000-00-00',
  `jenis` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_angket_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `angket`
--

LOCK TABLES `angket` WRITE;
/*!40000 ALTER TABLE `angket` DISABLE KEYS */;
/*!40000 ALTER TABLE `angket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beritaguru`
--

DROP TABLE IF EXISTS `beritaguru`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beritaguru` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `judul` varchar(255) NOT NULL,
  `tanggal` datetime NOT NULL,
  `abstrak` text NOT NULL,
  `isi` text NOT NULL,
  `idguru` varchar(20) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_beritaguru_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beritaguru`
--

LOCK TABLES `beritaguru` WRITE;
/*!40000 ALTER TABLE `beritaguru` DISABLE KEYS */;
/*!40000 ALTER TABLE `beritaguru` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beritasekolah`
--

DROP TABLE IF EXISTS `beritasekolah`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beritasekolah` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `judul` varchar(255) NOT NULL,
  `tanggal` datetime NOT NULL,
  `jenisberita` tinyint(1) unsigned NOT NULL DEFAULT '2',
  `abstrak` text NOT NULL,
  `isi` text NOT NULL,
  `idpengirim` varchar(20) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_beritasiswa_nip` (`idpengirim`),
  KEY `IX_beritasekolah_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beritasekolah`
--

LOCK TABLES `beritasekolah` WRITE;
/*!40000 ALTER TABLE `beritasekolah` DISABLE KEYS */;
/*!40000 ALTER TABLE `beritasekolah` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beritasiswa`
--

DROP TABLE IF EXISTS `beritasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beritasiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `judul` varchar(255) NOT NULL,
  `tanggal` datetime NOT NULL,
  `abstrak` text NOT NULL,
  `isi` text NOT NULL,
  `idpengirim` varchar(20) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_beritasiswa_nip` (`idpengirim`),
  KEY `IX_beritasiswa_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beritasiswa`
--

LOCK TABLES `beritasiswa` WRITE;
/*!40000 ALTER TABLE `beritasiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `beritasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buletin`
--

DROP TABLE IF EXISTS `buletin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buletin` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tempatbuletin` varchar(50) NOT NULL,
  `tanggalbuletin` date NOT NULL,
  `judul` varchar(255) NOT NULL,
  `buletin` text NOT NULL,
  `idpengirim` varchar(20) NOT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '0',
  `gambar` mediumblob,
  `tanggalinput` datetime DEFAULT NULL,
  `idkategori` int(10) unsigned DEFAULT '0',
  `tampil` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '''0 Null, 1 Situs, 2 Jibas, 3 Situs&Jibas''',
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_buletin_1` (`idkategori`),
  KEY `IX_buletin_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buletin`
--

LOCK TABLES `buletin` WRITE;
/*!40000 ALTER TABLE `buletin` DISABLE KEYS */;
/*!40000 ALTER TABLE `buletin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buletin_cmt`
--

DROP TABLE IF EXISTS `buletin_cmt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buletin_cmt` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idbuletin` int(10) unsigned NOT NULL,
  `tglpost` datetime NOT NULL,
  `idpenilai` varchar(20) NOT NULL,
  `komentar` varchar(100) DEFAULT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_buletin_cmt_idbuletin` (`idbuletin`),
  KEY `IX_buletin_cmt_ts` (`ts`,`issync`),
  CONSTRAINT `FK_buletin_cmt_idbuletin` FOREIGN KEY (`idbuletin`) REFERENCES `buletin` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buletin_cmt`
--

LOCK TABLES `buletin_cmt` WRITE;
/*!40000 ALTER TABLE `buletin_cmt` DISABLE KEYS */;
/*!40000 ALTER TABLE `buletin_cmt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buletin_rate`
--

DROP TABLE IF EXISTS `buletin_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buletin_rate` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idbuletin` int(10) unsigned NOT NULL,
  `tglpost` datetime NOT NULL,
  `idpenilai` varchar(20) NOT NULL,
  `rating` tinyint(3) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_buletin_rate_idbuletin` (`idbuletin`),
  KEY `IX_buletin_rate_ts` (`ts`,`issync`),
  CONSTRAINT `FK_buletin_rate_idbuletin` FOREIGN KEY (`idbuletin`) REFERENCES `buletin` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buletin_rate`
--

LOCK TABLES `buletin_rate` WRITE;
/*!40000 ALTER TABLE `buletin_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `buletin_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catatankategori`
--

DROP TABLE IF EXISTS `catatankategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catatankategori` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `kategori` varchar(255) NOT NULL,
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `keterangan` varchar(255) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_catatankategori_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catatankategori`
--

LOCK TABLES `catatankategori` WRITE;
/*!40000 ALTER TABLE `catatankategori` DISABLE KEYS */;
/*!40000 ALTER TABLE `catatankategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catatansiswa`
--

DROP TABLE IF EXISTS `catatansiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catatansiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idkategori` int(10) unsigned NOT NULL,
  `nis` varchar(20) NOT NULL,
  `idkelas` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `judul` varchar(255) NOT NULL,
  `catatan` text NOT NULL,
  `nip` varchar(20) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_catatansiswa_idkat` (`idkategori`),
  KEY `IX_catatansiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_catatansiswa_idkat` FOREIGN KEY (`idkategori`) REFERENCES `catatankategori` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catatansiswa`
--

LOCK TABLES `catatansiswa` WRITE;
/*!40000 ALTER TABLE `catatansiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `catatansiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat`
--

DROP TABLE IF EXISTS `chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `id` varchar(50) NOT NULL,
  `waktukirim` date NOT NULL,
  `pesan` text NOT NULL,
  `chatgroup` text NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_chat_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat`
--

LOCK TABLES `chat` WRITE;
/*!40000 ALTER TABLE `chat` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dirshare`
--

DROP TABLE IF EXISTS `dirshare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dirshare` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idroot` int(10) unsigned NOT NULL,
  `dirname` varchar(255) NOT NULL,
  `dirfullpath` varchar(255) NOT NULL,
  `idguru` varchar(20) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_dirshare_ts` (`ts`,`issync`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dirshare`
--

LOCK TABLES `dirshare` WRITE;
/*!40000 ALTER TABLE `dirshare` DISABLE KEYS */;
INSERT INTO `dirshare` VALUES (1,'2010-03-02 03:08:16',60772,0,0,'root','root/',NULL,NULL,NULL,NULL,NULL),(2,'2010-03-12 02:49:11',0,0,1,'101','root/101/','101',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `dirshare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `draft`
--

DROP TABLE IF EXISTS `draft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `draft` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tanggalpesan` datetime NOT NULL,
  `judul` varchar(255) NOT NULL,
  `pesan` text NOT NULL,
  `idpemilik` varchar(20) NOT NULL,
  `idpengirim` varchar(25) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_draft_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `draft`
--

LOCK TABLES `draft` WRITE;
/*!40000 ALTER TABLE `draft` DISABLE KEYS */;
/*!40000 ALTER TABLE `draft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fileshare`
--

DROP TABLE IF EXISTS `fileshare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileshare` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `iddir` int(10) unsigned NOT NULL,
  `filename` varchar(255) NOT NULL,
  `filesize` int(11) NOT NULL,
  `filetime` datetime NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_fileshareguru_1` (`iddir`),
  KEY `IX_fileshare_ts` (`ts`,`issync`),
  CONSTRAINT `FK_fileshareguru_1` FOREIGN KEY (`iddir`) REFERENCES `dirshare` (`replid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fileshare`
--

LOCK TABLES `fileshare` WRITE;
/*!40000 ALTER TABLE `fileshare` DISABLE KEYS */;
/*!40000 ALTER TABLE `fileshare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `galerifoto`
--

DROP TABLE IF EXISTS `galerifoto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `galerifoto` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idguru` varchar(20) DEFAULT NULL,
  `foto` blob,
  `keterangan` varchar(255) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `filename` varchar(100) DEFAULT NULL,
  `fotokecil` blob,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_galerifoto_nip` (`idguru`),
  KEY `IX_galerifoto_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `galerifoto`
--

LOCK TABLES `galerifoto` WRITE;
/*!40000 ALTER TABLE `galerifoto` DISABLE KEYS */;
/*!40000 ALTER TABLE `galerifoto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gambarbuletin`
--

DROP TABLE IF EXISTS `gambarbuletin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gambarbuletin` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idpengirim` varchar(20) NOT NULL,
  `foto` mediumblob,
  `keterangan` varchar(255) DEFAULT NULL,
  `namafile` varchar(100) NOT NULL,
  `bulan` tinyint(2) unsigned NOT NULL,
  `tahun` int(4) unsigned NOT NULL,
  `filename` varchar(100) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_gambarbuletin_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gambarbuletin`
--

LOCK TABLES `gambarbuletin` WRITE;
/*!40000 ALTER TABLE `gambarbuletin` DISABLE KEYS */;
/*!40000 ALTER TABLE `gambarbuletin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gambarlogin`
--

DROP TABLE IF EXISTS `gambarlogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gambarlogin` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `direktori` varchar(255) NOT NULL,
  `namafile` varchar(255) NOT NULL,
  `aktif` tinyint(1) DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_gambarlogin_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gambarlogin`
--

LOCK TABLES `gambarlogin` WRITE;
/*!40000 ALTER TABLE `gambarlogin` DISABLE KEYS */;
/*!40000 ALTER TABLE `gambarlogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gambartiny`
--

DROP TABLE IF EXISTS `gambartiny`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gambartiny` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idguru` varchar(20) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `foto` blob,
  `keterangan` varchar(255) DEFAULT NULL,
  `namagambar` varchar(100) DEFAULT NULL,
  `bulan` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `tahun` int(4) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_gambartiny_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gambartiny`
--

LOCK TABLES `gambartiny` WRITE;
/*!40000 ALTER TABLE `gambartiny` DISABLE KEYS */;
/*!40000 ALTER TABLE `gambartiny` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gambartinypesan`
--

DROP TABLE IF EXISTS `gambartinypesan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gambartinypesan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idguru` varchar(20) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `namafile` varchar(255) DEFAULT NULL,
  `direktori` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `namagambar` varchar(100) DEFAULT NULL,
  `bulan` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `tahun` int(4) unsigned NOT NULL DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_gambartinypesan_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gambartinypesan`
--

LOCK TABLES `gambartinypesan` WRITE;
/*!40000 ALTER TABLE `gambartinypesan` DISABLE KEYS */;
/*!40000 ALTER TABLE `gambartinypesan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jawabanangket`
--

DROP TABLE IF EXISTS `jawabanangket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jawabanangket` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idjawab` int(10) unsigned NOT NULL DEFAULT '0',
  `idpertanyaan` int(10) unsigned NOT NULL DEFAULT '0',
  `idpilihan` int(10) unsigned DEFAULT NULL,
  `isian` text,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_jawabanangket_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jawabanangket`
--

LOCK TABLES `jawabanangket` WRITE;
/*!40000 ALTER TABLE `jawabanangket` DISABLE KEYS */;
/*!40000 ALTER TABLE `jawabanangket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jawabangket`
--

DROP TABLE IF EXISTS `jawabangket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jawabangket` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idangket` int(10) unsigned NOT NULL DEFAULT '0',
  `nis` varchar(20) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tanggal` date NOT NULL DEFAULT '0000-00-00',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `IX_jawabangket_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jawabangket`
--

LOCK TABLES `jawabangket` WRITE;
/*!40000 ALTER TABLE `jawabangket` DISABLE KEYS */;
/*!40000 ALTER TABLE `jawabangket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategoribuletin`
--

DROP TABLE IF EXISTS `kategoribuletin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategoribuletin` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `kategori` varchar(100) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  UNIQUE KEY `Index_2` (`kategori`),
  KEY `IX_kategoribuletin_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategoribuletin`
--

LOCK TABLES `kategoribuletin` WRITE;
/*!40000 ALTER TABLE `kategoribuletin` DISABLE KEYS */;
/*!40000 ALTER TABLE `kategoribuletin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `komentar`
--

DROP TABLE IF EXISTS `komentar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `komentar` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `nip` varchar(20) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `owner` varchar(20) DEFAULT NULL,
  `komentar` text,
  `tanggal` datetime NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_komentar_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `komentar`
--

LOCK TABLES `komentar` WRITE;
/*!40000 ALTER TABLE `komentar` DISABLE KEYS */;
/*!40000 ALTER TABLE `komentar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lampiranberitaguru`
--

DROP TABLE IF EXISTS `lampiranberitaguru`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lampiranberitaguru` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idberita` int(10) unsigned NOT NULL,
  `namafile` varchar(255) NOT NULL,
  `direktori` varchar(255) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_lampiranberitaguru_1` (`idberita`),
  KEY `IX_lampiranberitaguru_ts` (`ts`,`issync`),
  CONSTRAINT `FK_lampiranberitaguru_1` FOREIGN KEY (`idberita`) REFERENCES `beritaguru` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lampiranberitaguru`
--

LOCK TABLES `lampiranberitaguru` WRITE;
/*!40000 ALTER TABLE `lampiranberitaguru` DISABLE KEYS */;
/*!40000 ALTER TABLE `lampiranberitaguru` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lampiranberitasiswa`
--

DROP TABLE IF EXISTS `lampiranberitasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lampiranberitasiswa` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idberita` int(10) unsigned NOT NULL,
  `namafile` varchar(255) NOT NULL,
  `direktori` varchar(255) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_lampiranberitasiswa_1` (`idberita`),
  KEY `IX_lampiranberitasiswa_ts` (`ts`,`issync`),
  CONSTRAINT `FK_lampiranberitasiswa_1` FOREIGN KEY (`idberita`) REFERENCES `beritasiswa` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lampiranberitasiswa`
--

LOCK TABLES `lampiranberitasiswa` WRITE;
/*!40000 ALTER TABLE `lampiranberitasiswa` DISABLE KEYS */;
/*!40000 ALTER TABLE `lampiranberitasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lampirandraft`
--

DROP TABLE IF EXISTS `lampirandraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lampirandraft` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idpesan` int(10) unsigned NOT NULL,
  `namafile` varchar(255) NOT NULL,
  `direktori` varchar(255) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_lampirandraft_idpesan` (`idpesan`),
  KEY `IX_lampirandraft_ts` (`ts`,`issync`),
  CONSTRAINT `FK_lampirandraft_idpesan` FOREIGN KEY (`idpesan`) REFERENCES `draft` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lampirandraft`
--

LOCK TABLES `lampirandraft` WRITE;
/*!40000 ALTER TABLE `lampirandraft` DISABLE KEYS */;
/*!40000 ALTER TABLE `lampirandraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lampiranpesan`
--

DROP TABLE IF EXISTS `lampiranpesan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lampiranpesan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idpesan` int(10) unsigned NOT NULL,
  `namafile` varchar(255) NOT NULL,
  `direktori` varchar(255) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_lampiranpesan_1` (`idpesan`),
  KEY `IX_lampiranpesan_ts` (`ts`,`issync`),
  CONSTRAINT `FK_lampiranpesan_1` FOREIGN KEY (`idpesan`) REFERENCES `pesan` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lampiranpesan`
--

LOCK TABLES `lampiranpesan` WRITE;
/*!40000 ALTER TABLE `lampiranpesan` DISABLE KEYS */;
/*!40000 ALTER TABLE `lampiranpesan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mutiara`
--

DROP TABLE IF EXISTS `mutiara`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mutiara` (
  `clientid` varchar(5) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `location` varchar(5) DEFAULT NULL,
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `kata` varchar(255) NOT NULL DEFAULT '',
  `firstname` varchar(20) NOT NULL DEFAULT '',
  `lastname` varchar(25) NOT NULL DEFAULT '',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_mutiara_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mutiara`
--

LOCK TABLES `mutiara` WRITE;
/*!40000 ALTER TABLE `mutiara` DISABLE KEYS */;
/*!40000 ALTER TABLE `mutiara` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new`
--

DROP TABLE IF EXISTS `new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `new` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `foto` longblob,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IX_new_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new`
--

LOCK TABLES `new` WRITE;
/*!40000 ALTER TABLE `new` DISABLE KEYS */;
/*!40000 ALTER TABLE `new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pertanyaan`
--

DROP TABLE IF EXISTS `pertanyaan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pertanyaan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idangket` int(10) unsigned NOT NULL DEFAULT '0',
  `pertanyaan` varchar(1000) NOT NULL DEFAULT '',
  `jenis` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pertanyaan_angket` (`idangket`),
  KEY `IX_pertanyaan_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pertanyaan_angket` FOREIGN KEY (`idangket`) REFERENCES `angket` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pertanyaan`
--

LOCK TABLES `pertanyaan` WRITE;
/*!40000 ALTER TABLE `pertanyaan` DISABLE KEYS */;
/*!40000 ALTER TABLE `pertanyaan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pesan`
--

DROP TABLE IF EXISTS `pesan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pesan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `tanggalpesan` datetime NOT NULL,
  `tanggaltampil` date DEFAULT NULL,
  `judul` varchar(255) NOT NULL,
  `pesan` text NOT NULL,
  `idguru` varchar(20) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `keguru` tinyint(1) unsigned DEFAULT '0',
  `kesiswa` tinyint(1) unsigned DEFAULT '0',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_pesan_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pesan`
--

LOCK TABLES `pesan` WRITE;
/*!40000 ALTER TABLE `pesan` DISABLE KEYS */;
/*!40000 ALTER TABLE `pesan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pesanterkirim`
--

DROP TABLE IF EXISTS `pesanterkirim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pesanterkirim` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `judul` varchar(255) NOT NULL,
  `idpesan` int(10) unsigned NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_pesanterkirim_1` (`idpesan`),
  KEY `IX_pesanterkirim_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pesanterkirim_1` FOREIGN KEY (`idpesan`) REFERENCES `pesan` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pesanterkirim`
--

LOCK TABLES `pesanterkirim` WRITE;
/*!40000 ALTER TABLE `pesanterkirim` DISABLE KEYS */;
/*!40000 ALTER TABLE `pesanterkirim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pilihan`
--

DROP TABLE IF EXISTS `pilihan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pilihan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpertanyaan` int(10) unsigned NOT NULL DEFAULT '0',
  `pilihan` varchar(45) NOT NULL DEFAULT '',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`replid`),
  KEY `FK_pilihan_pertanyaan` (`idpertanyaan`),
  KEY `IX_pilihan_ts` (`ts`,`issync`),
  CONSTRAINT `FK_pilihan_tanya` FOREIGN KEY (`idpertanyaan`) REFERENCES `pertanyaan` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pilihan`
--

LOCK TABLES `pilihan` WRITE;
/*!40000 ALTER TABLE `pilihan` DISABLE KEYS */;
/*!40000 ALTER TABLE `pilihan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profil`
--

DROP TABLE IF EXISTS `profil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profil` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `nip` varchar(20) DEFAULT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `telpon` varchar(45) DEFAULT NULL,
  `hp` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `hobi` text,
  `buku` text,
  `riwayat` text,
  `foto` mediumblob,
  `tentang` text,
  `nis` varchar(20) DEFAULT NULL,
  `bg` mediumblob,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `IX_profil_ts` (`ts`,`issync`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profil`
--

LOCK TABLES `profil` WRITE;
/*!40000 ALTER TABLE `profil` DISABLE KEYS */;
/*!40000 ALTER TABLE `profil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subkategoribuletin`
--

DROP TABLE IF EXISTS `subkategoribuletin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subkategoribuletin` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `kategori` varchar(100) NOT NULL,
  `subkategori` varchar(100) NOT NULL,
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_subkategoribuletin_1` (`kategori`),
  KEY `IX_subkategoribuletin_ts` (`ts`,`issync`),
  CONSTRAINT `FK_subkategoribuletin_1` FOREIGN KEY (`kategori`) REFERENCES `kategoribuletin` (`kategori`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subkategoribuletin`
--

LOCK TABLES `subkategoribuletin` WRITE;
/*!40000 ALTER TABLE `subkategoribuletin` DISABLE KEYS */;
/*!40000 ALTER TABLE `subkategoribuletin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tujuanpesan`
--

DROP TABLE IF EXISTS `tujuanpesan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tujuanpesan` (
  `replid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` smallint(5) unsigned NOT NULL DEFAULT '0',
  `issync` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `idpesan` int(10) unsigned NOT NULL,
  `idpenerima` varchar(20) NOT NULL,
  `baru` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `aktif` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `info1` varchar(255) DEFAULT NULL,
  `info2` varchar(255) DEFAULT NULL,
  `info3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`replid`),
  KEY `FK_tujuanpesan_1` (`idpesan`),
  KEY `IX_tujuanpesan_ts` (`ts`,`issync`),
  CONSTRAINT `FK_tujuanpesan_1` FOREIGN KEY (`idpesan`) REFERENCES `pesan` (`replid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tujuanpesan`
--

LOCK TABLES `tujuanpesan` WRITE;
/*!40000 ALTER TABLE `tujuanpesan` DISABLE KEYS */;
/*!40000 ALTER TABLE `tujuanpesan` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-08-30  2:27:54
