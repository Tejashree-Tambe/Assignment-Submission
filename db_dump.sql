CREATE DATABASE  IF NOT EXISTS `assignment` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `assignment`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: assignment
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_assignment`
--

DROP TABLE IF EXISTS `app_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_assignment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `assign_id` int NOT NULL,
  `grade` int DEFAULT NULL,
  `description` varchar(512) NOT NULL,
  `feedback` varchar(512) DEFAULT NULL,
  `file` varchar(100) DEFAULT NULL,
  `date_of_submission` datetime(6) NOT NULL,
  `pending` tinyint(1) DEFAULT NULL,
  `finished` tinyint(1) DEFAULT NULL,
  `course_id_id` bigint NOT NULL,
  `assign_prof_id` int NOT NULL,
  `assign_student_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_assignment_course_id_id_b8793c68_fk_app_course_id` (`course_id_id`),
  KEY `app_assignment_assign_prof_id_2a3d49b3_fk_auth_user_id` (`assign_prof_id`),
  KEY `app_assignment_assign_student_id_d5f773fd_fk_auth_user_id` (`assign_student_id`),
  CONSTRAINT `app_assignment_assign_prof_id_2a3d49b3_fk_auth_user_id` FOREIGN KEY (`assign_prof_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `app_assignment_assign_student_id_d5f773fd_fk_auth_user_id` FOREIGN KEY (`assign_student_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `app_assignment_course_id_id_b8793c68_fk_app_course_id` FOREIGN KEY (`course_id_id`) REFERENCES `app_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_assignment`
--

LOCK TABLES `app_assignment` WRITE;
/*!40000 ALTER TABLE `app_assignment` DISABLE KEYS */;
INSERT INTO `app_assignment` VALUES (6,'Trees and Graphs',4,8,'Write a program to implement trees.','Good','test_7.pdf','2023-12-20 00:00:00.000000',NULL,NULL,4,3,6),(10,'Image Classification ',8,NULL,'Implement a deep learning model for image classification using a popular framework like TensorFlow or PyTorch. Explore transfer learning by fine-tuning a pre-trained model on a specific dataset.',NULL,'','2023-12-20 00:00:00.000000',NULL,NULL,8,3,2),(11,'Image Classification ',8,NULL,'Implement a deep learning model for image classification using a popular framework like TensorFlow or PyTorch. Explore transfer learning by fine-tuning a pre-trained model on a specific dataset.',NULL,'','2023-12-20 00:00:00.000000',NULL,NULL,8,3,5),(12,'Image Classification ',8,NULL,'Implement a deep learning model for image classification using a popular framework like TensorFlow or PyTorch. Explore transfer learning by fine-tuning a pre-trained model on a specific dataset.',NULL,'','2023-12-20 00:00:00.000000',NULL,NULL,8,3,6),(13,'Linked List ',15,7,'Write a program to implement singly linked list.','Can do better','test_4_tKj0xsW.pdf','2023-12-20 00:00:00.000000',0,NULL,4,3,6);
/*!40000 ALTER TABLE `app_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_course`
--

DROP TABLE IF EXISTS `app_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `course_id` int NOT NULL,
  `prof_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_course_prof_id_70fbff3e_fk_auth_user_id` (`prof_id`),
  CONSTRAINT `app_course_prof_id_70fbff3e_fk_auth_user_id` FOREIGN KEY (`prof_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_course`
--

LOCK TABLES `app_course` WRITE;
/*!40000 ALTER TABLE `app_course` DISABLE KEYS */;
INSERT INTO `app_course` VALUES (4,'DSA',1,3),(5,'DBMS',2,3),(6,'ML',3,3),(8,'AI',4,3),(9,'OOPS',5,3);
/*!40000 ALTER TABLE `app_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_course_student`
--

DROP TABLE IF EXISTS `app_course_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_course_student` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_course_student_course_id_user_id_ab3b1e61_uniq` (`course_id`,`user_id`),
  KEY `app_course_student_user_id_c3fb948f_fk_auth_user_id` (`user_id`),
  CONSTRAINT `app_course_student_course_id_011b9745_fk_app_course_id` FOREIGN KEY (`course_id`) REFERENCES `app_course` (`id`),
  CONSTRAINT `app_course_student_user_id_c3fb948f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_course_student`
--

LOCK TABLES `app_course_student` WRITE;
/*!40000 ALTER TABLE `app_course_student` DISABLE KEYS */;
INSERT INTO `app_course_student` VALUES (5,4,6),(4,6,5),(1,8,2),(3,8,5),(2,8,6);
/*!40000 ALTER TABLE `app_course_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add course',7,'add_course'),(26,'Can change course',7,'change_course'),(27,'Can delete course',7,'delete_course'),(28,'Can view course',7,'view_course'),(29,'Can add assignment',8,'add_assignment'),(30,'Can change assignment',8,'change_assignment'),(31,'Can delete assignment',8,'delete_assignment'),(32,'Can view assignment',8,'view_assignment');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (2,'pbkdf2_sha256$720000$KwavSDan9Uwic5OSK9ZFGX$qZeUwmRu5KMOwAplR2h1EVMIGkvJiokAxyxKFMWnvgg=','2023-12-06 11:09:41.560383',0,'Kuldeep','','','kuldeep@gmail.com',0,1,'2023-12-05 16:41:16.048549'),(3,'pbkdf2_sha256$720000$FltoXGg4uoZxQFjuCscs22$F9SC2p4CQXtetW58hEFHa0FE6vLXpnGVJ+LSeTBLzFo=','2023-12-06 18:48:58.977577',0,'Aryan','','','aryan@gmail.com',1,1,'2023-12-05 16:44:20.970809'),(4,'pbkdf2_sha256$720000$snr7ZNQ4CKPaBOboHaCfsN$SKocqphptTmfu6D4LrR3RiZj6U0Um/2YXpNo+zjI0fg=','2023-12-06 18:24:05.552780',1,'root','','','',1,1,'2023-12-05 16:45:54.367928'),(5,'pbkdf2_sha256$720000$Dv65vc5pwUlYl0XyfbpV4T$+7xAzfS05x4Pskkybk9qifc5ST0YyxC6d16nhVQrxlE=','2023-12-06 10:43:21.154328',0,'Aadhavan','','','aadhavan@gmail.com',0,1,'2023-12-05 23:16:42.263565'),(6,'pbkdf2_sha256$720000$2dQ3C7SZEshm1tYZXybFR2$epP1aOktvOvru9mYKMrCTZADKWU8DcfwqHZZd+nxx7M=','2023-12-06 18:37:13.238969',0,'Tejashree','','','agela@gmail.com',0,1,'2023-12-05 23:22:00.895328');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-12-05 16:48:28.773032','1','Course object (1)',1,'[{\"added\": {}}]',7,4);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(8,'app','assignment'),(7,'app','course'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-12-05 16:39:26.906654'),(2,'auth','0001_initial','2023-12-05 16:39:27.696699'),(3,'admin','0001_initial','2023-12-05 16:39:27.867770'),(4,'admin','0002_logentry_remove_auto_add','2023-12-05 16:39:27.883509'),(5,'admin','0003_logentry_add_action_flag_choices','2023-12-05 16:39:27.901318'),(6,'app','0001_initial','2023-12-05 16:39:28.162617'),(7,'contenttypes','0002_remove_content_type_name','2023-12-05 16:39:28.264635'),(8,'auth','0002_alter_permission_name_max_length','2023-12-05 16:39:28.355353'),(9,'auth','0003_alter_user_email_max_length','2023-12-05 16:39:28.392085'),(10,'auth','0004_alter_user_username_opts','2023-12-05 16:39:28.407945'),(11,'auth','0005_alter_user_last_login_null','2023-12-05 16:39:28.483075'),(12,'auth','0006_require_contenttypes_0002','2023-12-05 16:39:28.483075'),(13,'auth','0007_alter_validators_add_error_messages','2023-12-05 16:39:28.506837'),(14,'auth','0008_alter_user_username_max_length','2023-12-05 16:39:28.630024'),(15,'auth','0009_alter_user_last_name_max_length','2023-12-05 16:39:28.714664'),(16,'auth','0010_alter_group_name_max_length','2023-12-05 16:39:28.749170'),(17,'auth','0011_update_proxy_permissions','2023-12-05 16:39:28.767552'),(18,'auth','0012_alter_user_first_name_max_length','2023-12-05 16:39:28.863491'),(19,'sessions','0001_initial','2023-12-05 16:39:28.914798'),(20,'app','0002_alter_course_student','2023-12-05 16:48:21.811912'),(21,'app','0003_alter_assignment_feedback_alter_assignment_file_and_more','2023-12-05 19:09:43.662778'),(22,'app','0004_assignment_prof_assignment_student','2023-12-05 19:20:33.647434'),(23,'app','0005_rename_prof_assignment_assign_prof_and_more','2023-12-05 19:20:33.909853'),(24,'app','0006_remove_course_student_course_student','2023-12-06 09:53:38.289957');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('qm2r4zopslk5r2ogd844t679yixcf6ht','.eJxVjEEOgjAQRe_StWloi4Vx6Z4zkJnOjKCmTSisjHdXEha6_e-9_zIjbus0blWWcWZzMcGcfjfC9JC8A75jvhWbSl6Xmeyu2INWOxSW5_Vw_w4mrNO3bgWajqJ47ZsATqN64EbPGoAig3eOgmAKwEoak_qAXd-KF-4cJmDz_gDsYjim:1rAwx8:eZ3q2p0sa3PXtTOKMfJtT3tXjBRU5VxH2T-dl7vMYDk','2023-12-20 18:48:58.981208');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'assignment'
--

--
-- Dumping routines for database 'assignment'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-07  0:57:36
