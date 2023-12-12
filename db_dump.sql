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
  `description_file` varchar(100) DEFAULT NULL,
  `submission_status` varchar(100) NOT NULL,
  `submitted_on` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_assignment_course_id_id_b8793c68_fk_app_course_id` (`course_id_id`),
  KEY `app_assignment_assign_prof_id_2a3d49b3_fk_auth_user_id` (`assign_prof_id`),
  KEY `app_assignment_assign_student_id_d5f773fd_fk_auth_user_id` (`assign_student_id`),
  CONSTRAINT `app_assignment_assign_prof_id_2a3d49b3_fk_auth_user_id` FOREIGN KEY (`assign_prof_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `app_assignment_assign_student_id_d5f773fd_fk_auth_user_id` FOREIGN KEY (`assign_student_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `app_assignment_course_id_id_b8793c68_fk_app_course_id` FOREIGN KEY (`course_id_id`) REFERENCES `app_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_assignment`
--

LOCK TABLES `app_assignment` WRITE;
/*!40000 ALTER TABLE `app_assignment` DISABLE KEYS */;
INSERT INTO `app_assignment` VALUES (2,'Encapsulation',2,0,'Write a program in Python to implement encapsulation.','Plagarised','assign8_answers_12_8Q3OmpC.pdf','2023-12-21 00:00:00.000000',0,1,5,5,4,'test_4_OliykKB.pdf','On Time','2023-12-09 01:00:08.589651'),(7,'Encapsulation',2,NULL,'Write a program in Python to implement encapsulation.',NULL,'','2023-12-21 00:00:00.000000',NULL,NULL,5,5,3,'test_4_OliykKB.pdf','',NULL),(8,'CRUD Operations',3,7,'Write a query to create, insert, update and delete table Users.','Upload On Time','test_4_s8pQC19.pdf','2023-12-13 00:00:00.000000',0,1,7,6,4,'test_7_c5ZE05h.pdf','Late','2023-12-08 16:47:12.265152'),(9,'CRUD Operations',3,NULL,'Write a query to create, insert, update and delete table Users.',NULL,'','2023-12-13 00:00:00.000000',NULL,NULL,7,6,3,'test_7_c5ZE05h.pdf','',NULL),(10,'CRUD Operations 2',4,NULL,'Write a query to create, insert, update and delete table Employee.',NULL,'','2023-12-11 00:00:00.000000',NULL,NULL,7,6,3,'test_4_sYvYbgS.pdf','',NULL),(11,'CRUD Operations 2',4,NULL,'Write a query to create, insert, update and delete table Employee.',NULL,'','2023-12-11 00:00:00.000000',NULL,NULL,7,6,4,'test_4_2zTxa4a.pdf','',NULL),(16,'OS Basics',10,NULL,'Highlight the answers in the question sheet provided in a pdf format.',NULL,'','2023-12-13 00:00:00.000000',NULL,NULL,13,15,4,'assign8_questions_vHYT8gP.pdf','',NULL),(17,'OS Basics',10,9,'Highlight the answers in the question sheet provided in a pdf format.','Can do better','assign8_answers_12_ELnHyjf.pdf','2023-12-13 00:00:00.000000',0,1,13,15,13,'assign8_questions_8t3AX2k.pdf','On Time','2023-12-08 18:56:31.864280'),(20,'CNN',34,NULL,'Implement CNN using PYthon',NULL,'','2023-12-21 00:00:00.000000',NULL,NULL,3,5,65,'assign8_questions_mowFnjY.pdf','',NULL),(21,'CNN',34,0,'Implement CNN using PYthon','Plagarized','assign8_answers_12_NxDDQeB.pdf','2023-12-21 00:00:00.000000',0,1,3,5,971,'assign8_questions_TXHPzcK.pdf','On Time','2023-12-09 01:14:11.617747');
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
  `semester` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_course_prof_id_70fbff3e_fk_auth_user_id` (`prof_id`),
  CONSTRAINT `app_course_prof_id_70fbff3e_fk_auth_user_id` FOREIGN KEY (`prof_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_course`
--

LOCK TABLES `app_course` WRITE;
/*!40000 ALTER TABLE `app_course` DISABLE KEYS */;
INSERT INTO `app_course` VALUES (1,'DSA',1,2,'I'),(3,'ML',3,5,'I'),(5,'OOPS',5,5,'I'),(7,'DBMS',2,6,'I'),(8,'GK',6,2,'I'),(13,'OS',8,15,'I');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_course_student`
--

LOCK TABLES `app_course_student` WRITE;
/*!40000 ALTER TABLE `app_course_student` DISABLE KEYS */;
INSERT INTO `app_course_student` VALUES (26,3,65),(27,3,971),(10,5,3),(5,5,4),(13,7,3),(11,7,4),(23,13,4),(21,13,13);
/*!40000 ALTER TABLE `app_course_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_studentrequest`
--

DROP TABLE IF EXISTS `app_studentrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_studentrequest` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` varchar(20) NOT NULL,
  `course_id` bigint NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_studentrequest_course_id_0ce06433_fk_app_course_id` (`course_id`),
  KEY `app_studentrequest_student_id_6a2c8ce9_fk_auth_user_id` (`student_id`),
  CONSTRAINT `app_studentrequest_course_id_0ce06433_fk_app_course_id` FOREIGN KEY (`course_id`) REFERENCES `app_course` (`id`),
  CONSTRAINT `app_studentrequest_student_id_6a2c8ce9_fk_auth_user_id` FOREIGN KEY (`student_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_studentrequest`
--

LOCK TABLES `app_studentrequest` WRITE;
/*!40000 ALTER TABLE `app_studentrequest` DISABLE KEYS */;
INSERT INTO `app_studentrequest` VALUES (3,'pending',3,4),(4,'pending',1,4),(5,'approved',7,4),(8,'approved',13,13),(9,'pending',3,3),(10,'approved',3,65),(11,'approved',3,971);
/*!40000 ALTER TABLE `app_studentrequest` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add course',7,'add_course'),(26,'Can change course',7,'change_course'),(27,'Can delete course',7,'delete_course'),(28,'Can view course',7,'view_course'),(29,'Can add assignment',8,'add_assignment'),(30,'Can change assignment',8,'change_assignment'),(31,'Can delete assignment',8,'delete_assignment'),(32,'Can view assignment',8,'view_assignment'),(33,'Can add student request',9,'add_studentrequest'),(34,'Can change student request',9,'change_studentrequest'),(35,'Can delete student request',9,'delete_studentrequest'),(36,'Can view student request',9,'view_studentrequest');
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
) ENGINE=InnoDB AUTO_INCREMENT=973 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$6LAPsDpHHYYbP0zbT2ZXRi$2Zkj8ip78szdbTv9lcvrs/IkfNE3YgZohE7lGcup+Dk=','2023-12-12 05:14:01.963586',1,'root','','','root@gmail.com',1,1,'2023-12-08 10:52:16.057536'),(2,'pbkdf2_sha256$720000$zQeNhIH3VKONFDh74cOcya$trG1pZoYjGmRqev3NUpMNVXQv1ehnACGiWdIHnwfaSQ=','2023-12-12 08:47:17.205559',0,'Aryan','','','aryan@gmail.com',1,1,'2023-12-08 10:53:18.000000'),(3,'pbkdf2_sha256$720000$8PwYfjYpFicVzM78BwAttu$0bHujcJ+11+V+PPWUrJ9lcz3QOehEghnKH+riNQlA6s=','2023-12-08 21:53:48.336506',0,'Tejashree','','','tejashree@gmail.com',0,1,'2023-12-08 10:59:26.445479'),(4,'pbkdf2_sha256$720000$ddTOrMOQn0JfeG1ASLhUMn$r8zTu2M0JOmo2dhD4WO9FhsTaQkirD879qMFCFhQgp0=','2023-12-09 00:59:40.338353',0,'Kuldeep','','','kuldeep@gmail.com',0,1,'2023-12-08 11:00:50.129455'),(5,'pbkdf2_sha256$720000$jpx5bSqpbnGhASaCey7Z4M$BC7V1qPgtCYj3aiDc+4Xsj8l7e6bG1C0MIzF4DpaElU=','2023-12-09 00:56:27.304369',0,'Jim','','','jim@gmail.com',1,1,'2023-12-08 11:04:40.000000'),(6,'pbkdf2_sha256$720000$3CRBht9NVkao2BEP0q87DG$jmKElj0FYVNsMl/Kn0gjjLgfvoSmV6tvA60+gV+X18o=','2023-12-08 16:36:15.070611',0,'Adhd','','','new_user@gmail.com',1,1,'2023-12-08 16:34:51.000000'),(13,'pbkdf2_sha256$720000$iUE0LSJpAcKjUwXJlHarxI$vjq9NXVHu2h4tdpmfSA4beBGlTLYXOEuGLKWMoS+edM=','2023-12-08 22:17:15.402585',0,'Pam','','','pam@gmail.com',0,1,'2023-12-08 18:52:38.157532'),(15,'pbkdf2_sha256$720000$thqhLoMcSOruGI6ZnmjxZC$Tvf/JavnkG4oNa++ogEtAKAVE6+xyURiVKPJuc1Bo08=','2023-12-08 22:02:26.634899',0,'Angela','','','angela@gmail.com',1,1,'2023-12-08 18:50:27.000000'),(18,'pbkdf2_sha256$720000$QN2Cto3MBBgIG65eyvc0Xo$W+5lbCjG3q4kSPA2VU/PLzQc7EUgtqVX6rNecgwjly8=',NULL,0,'Creed','','','creed@gmail.com',1,1,'2023-12-08 23:22:18.000000'),(20,'pbkdf2_sha256$720000$PSrMvvXlDzNi0qaMoRJKYU$zrK8uAEGphjdN7dyaNFQIAVMVxc5FmqtnAK6hxG1ZW8=','2023-12-08 23:34:33.245696',0,'Oscar','','','oscar@gmail.com',1,1,'2023-12-08 23:33:53.000000'),(65,'pbkdf2_sha256$720000$NoMNommZ5SJ25wVHlNhKxF$uryO5CEh+Gjwr66iAkGeZlHODgNzSo1KsiG8MS+kct8=','2023-12-09 00:55:17.239821',0,'Vishal','','','v@gmail.com',0,1,'2023-12-09 00:55:16.137207'),(971,'pbkdf2_sha256$720000$lx3CMLdy9rCOoo9cJBYZN3$Mp/3/3X6Rw05h1HQOCU0AzXF1uq9o/LKTl9vOg93s9c=','2023-12-09 01:10:06.725100',0,'Rohan','','','r@gmail.com',0,1,'2023-12-09 01:10:05.639038'),(972,'pbkdf2_sha256$720000$ZiSUhKQBrcMGioB6oEIwCG$3cwTsR/IADt2ihwyVtSMDKpAGb7C+4EvRy9U4Y+8BlY=',NULL,0,'hello','','','',0,1,'2023-12-12 05:15:34.886422');
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2023-12-08 10:53:18.601871','2','Aryan',1,'[{\"added\": {}}]',4,1),(2,'2023-12-08 10:53:39.021006','2','Aryan',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(3,'2023-12-08 11:04:41.315618','5','Jim',1,'[{\"added\": {}}]',4,1),(4,'2023-12-08 11:04:55.239416','5','Jim',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(5,'2023-12-08 16:34:52.239891','6','Adhd',1,'[{\"added\": {}}]',4,1),(6,'2023-12-08 16:35:10.686301','6','Adhd',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(7,'2023-12-08 17:50:34.711293','7','Angela',1,'[{\"added\": {}}]',4,1),(8,'2023-12-08 17:50:47.271332','7','Angela',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(9,'2023-12-08 17:55:03.208184','11','New User',3,'',4,1),(10,'2023-12-08 17:58:26.863218','7','Angela',3,'',4,1),(11,'2023-12-08 17:59:26.816445','12','Angela',1,'[{\"added\": {}}]',4,1),(12,'2023-12-08 17:59:40.616619','12','Angela',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(13,'2023-12-08 18:08:48.805799','12','Angela',3,'',4,1),(14,'2023-12-08 18:08:48.805799','11','Pam',3,'',4,1),(15,'2023-12-08 18:10:50.671846','9','Course object (9)',3,'',7,1),(16,'2023-12-08 18:15:07.650554','13','Angela',1,'[{\"added\": {}}]',4,1),(17,'2023-12-08 18:15:25.206213','13','Angela',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(18,'2023-12-08 18:26:18.872683','13','Angela',3,'',4,1),(19,'2023-12-08 18:26:18.880739','11','Pam',3,'',4,1),(20,'2023-12-08 18:30:15.932890','14','Angela',1,'[{\"added\": {}}]',4,1),(21,'2023-12-08 18:30:30.400610','14','Angela',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(22,'2023-12-08 18:48:41.786977','14','Angela',3,'',4,1),(23,'2023-12-08 18:48:41.788632','13','Pam',3,'',4,1),(24,'2023-12-08 18:50:28.411496','15','Angela',1,'[{\"added\": {}}]',4,1),(25,'2023-12-08 18:50:44.366261','15','Angela',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(26,'2023-12-08 23:08:09.774865','16','Michael',1,'[{\"added\": {}}]',4,1),(27,'2023-12-08 23:08:23.957929','16','Michael',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(28,'2023-12-08 23:11:07.532855','16','Dwight',3,'',4,1),(29,'2023-12-08 23:13:28.658461','17','Creed',1,'[{\"added\": {}}]',4,1),(30,'2023-12-08 23:13:40.771227','17','Creed',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(31,'2023-12-08 23:16:41.848501','17','Creed',3,'',4,1),(32,'2023-12-08 23:22:18.562100','18','Creed',1,'[{\"added\": {}}]',4,1),(33,'2023-12-08 23:22:29.686617','18','Creed',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(34,'2023-12-08 23:27:47.276740','19','Oscar',1,'[{\"added\": {}}]',4,1),(35,'2023-12-08 23:27:57.952429','19','Oscar',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(36,'2023-12-08 23:32:08.218622','19','Oscar',3,'',4,1),(37,'2023-12-08 23:33:54.097127','20','Oscar',1,'[{\"added\": {}}]',4,1),(38,'2023-12-08 23:34:04.534233','20','Oscar',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Staff status\"]}}]',4,1),(39,'2023-12-12 05:15:35.391003','972','hello',1,'[{\"added\": {}}]',4,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(8,'app','assignment'),(7,'app','course'),(9,'app','studentrequest'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-12-08 10:51:05.984685'),(2,'auth','0001_initial','2023-12-08 10:51:06.703236'),(3,'admin','0001_initial','2023-12-08 10:51:06.919360'),(4,'admin','0002_logentry_remove_auto_add','2023-12-08 10:51:06.922519'),(5,'admin','0003_logentry_add_action_flag_choices','2023-12-08 10:51:06.938551'),(6,'app','0001_initial','2023-12-08 10:51:07.198260'),(7,'app','0002_assignment_assign_prof_assignment_assign_student_and_more','2023-12-08 10:51:08.212780'),(8,'contenttypes','0002_remove_content_type_name','2023-12-08 10:51:08.309934'),(9,'auth','0002_alter_permission_name_max_length','2023-12-08 10:51:08.386500'),(10,'auth','0003_alter_user_email_max_length','2023-12-08 10:51:08.437238'),(11,'auth','0004_alter_user_username_opts','2023-12-08 10:51:08.449266'),(12,'auth','0005_alter_user_last_login_null','2023-12-08 10:51:08.518800'),(13,'auth','0006_require_contenttypes_0002','2023-12-08 10:51:08.518800'),(14,'auth','0007_alter_validators_add_error_messages','2023-12-08 10:51:08.532635'),(15,'auth','0008_alter_user_username_max_length','2023-12-08 10:51:08.615983'),(16,'auth','0009_alter_user_last_name_max_length','2023-12-08 10:51:08.692084'),(17,'auth','0010_alter_group_name_max_length','2023-12-08 10:51:08.715699'),(18,'auth','0011_update_proxy_permissions','2023-12-08 10:51:08.736206'),(19,'auth','0012_alter_user_first_name_max_length','2023-12-08 10:51:08.832377'),(20,'sessions','0001_initial','2023-12-08 10:51:08.878056');
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
INSERT INTO `django_session` VALUES ('04c1mnzdz2srsaw53rce7lt9j59v6b6e','.eJxVjDEOwjAMRe-SGUWkil3MyM4ZKjt2aAElUtNOiLtDpQ6w_vfef7mB12Uc1mbzMKk7O3CH3004PaxsQO9cbtWnWpZ5Er8pfqfNX6va87K7fwcjt_FbJ-yiKluOCVUSEyII8anvOHQCBL2JUM6IGMEykuYQ4Zh7MgwMwb0_D1s4gg:1rBldr:Nd4O9Bbp1WooHH0yu0a7Y_PlFVOhz6AUINZufMvVGUQ','2023-12-23 00:56:27.311372'),('84xaa2n99k93bsz0g2juqzdj6e6wf000','.eJxVjEEOwiAQRe_C2hCgUMCle89AZobBVg0kpV0Z765NutDtf-_9l0iwrVPaOi9pzuIsjDj9bgj04LqDfId6a5JaXZcZ5a7Ig3Z5bZmfl8P9O5igT9_aISEBZ0clWIwqaxpZQfEmeqNKGVSEwRXGcdDaGA6sLGgdAlkPBaN4fwAQkjiH:1rCyQ9:thiEPMIbVbr4z9-hvZXGi97uKHp17jl2xhQmkBCfpl8','2023-12-26 08:47:17.228056'),('8jmb3xxbyop5k2qxr5m4tk28zrzbhn4t','.eJxVjEEOwiAQRe_C2pApdoC6dN8zkBmGStVAUtqV8e7apAvd_vfef6lA25rD1tISZlEXZdXpd2OKj1R2IHcqt6pjLesys94VfdCmxyrpeT3cv4NMLX_rCbHvyQwDG_QJBXqbwBk23oGFSBHRAjAmtgTcdXQWz8OEIuDZiVPvD8osN5k:1rBdpn:TuNQHWX3GoBbzL5fN_paT7mtT_Rf90SFgh465GpyKQA','2023-12-22 16:36:15.077622');
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

-- Dump completed on 2023-12-13  0:37:13
