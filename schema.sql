-- MySQL dump 10.13  Distrib 5.7.20, for Win64 (x86_64)
--
-- Host: localhost    Database: blog_app
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Current Database: `blog_app`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `blog_app` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `blog_app`;

--
-- Table structure for table `progcomments`
--

DROP TABLE IF EXISTS `progcomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `progcomments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `programs_tag` varchar(30) NOT NULL,
  `user_username` varchar(30) NOT NULL,
  `comment` varchar(600) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_username` (`user_username`),
  KEY `programs_tag` (`programs_tag`),
  CONSTRAINT `progcomments_ibfk_3` FOREIGN KEY (`user_username`) REFERENCES `user` (`username`) ON DELETE CASCADE,
  CONSTRAINT `progcomments_ibfk_4` FOREIGN KEY (`programs_tag`) REFERENCES `programs` (`tag`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progcomments`
--

LOCK TABLES `progcomments` WRITE;
/*!40000 ALTER TABLE `progcomments` DISABLE KEYS */;
INSERT INTO `progcomments` VALUES (6,'Program_one','raunak','Cool!','2017-12-08 22:22:57'),(13,'Program_one','EpicThunder','I made this. I\'m the creator of this website man! Thanks for the compliments. I have made more and they are yet to be launched publicly on this website. I hope you guys enjoyed this. Just wait for the other programs coming up! I might adding a voting up/down system so that its faster for you guys comment. \r\nBye for now! \r\nI hope I see you soon!','2017-12-09 15:17:39'),(14,'Program_one','EpicThunder',' This look is gonna change!','2017-12-25 20:49:16'),(15,'Program_one','EpicThunder',' Scrolling BUG fixed!! booyah!','2017-12-25 21:08:35'),(16,'Program_one','epicuser',' goat website hai','2017-12-25 21:10:05'),(17,'Program_two','epicuser',' decent goat program hai','2017-12-25 21:11:52'),(18,'Program_two','rekhaseas',' It is awesome!','2017-12-25 22:37:26'),(19,'Program_one','epicuser',' nice logo','2017-12-26 10:01:39'),(20,'Program_one','epicuser',' stop working on goat site now pls','2017-12-26 10:01:48'),(21,'Program_two','epicuser',' bohot goat site hai\nispe kaam karke kuch nahi hoga \nkuch aur seekho','2017-12-26 10:02:16');
/*!40000 ALTER TABLE `progcomments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs`
--

DROP TABLE IF EXISTS `programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(30) NOT NULL,
  `heading` varchar(40) NOT NULL,
  `content` text,
  `link` text NOT NULL,
  `type` text NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `heading` (`heading`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` VALUES (6,'Program_one','GCD Calculator','This program calculates the GCD of any 2 numbers','GCD-Calculator.html','Math','2017-12-08 14:35:48'),(7,'Program_two','LCM Calculator','This program calculates the LCM of any 2 numbers','LCM-Calculator.html','Math','2017-12-08 14:35:48');
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'EpicThunder','pbkdf2$10000$e558163d2735e0e3e78190641f3893969423feadf21e661e67013c89c965eb9d5de41c01f2d702382cdc13cefcb75b7728abdf8a0e939419d05cc2d00b92e6095a968d058275ca1584a58d8558776fb72259c9da66ccaeba48e0ef6ac08cfb01a63ff68df0d52889d82bd3ab4817ea4073e1771738b52747844549dd3e81c99fc4671f090f4b6924fe74ef730ea04eba8397db1edc4747112f6b8b424fdf20718809e4defa4978024723f8df67009bd66756808d3ac23605d50c08822c4c070056ed11990d580aae3d9805efed2be5c969f98e62db6427e8d2cf477664da3b0dd25150f91e5e56c7ddd26cbe70886caa21c96ed482e0afcad1cbf399806f2376f12f1793ab4797ef40541525eb0422f540a3721c62af504e36bc1fbf348cec39afb45bfd82013bb9e77e84fcb0054f408d0e438d6e7592c874ae5af3d29fb70fd192c802d1be256d8eedc6160a271d40070b1c89ae849c6f27ed2dbbb62e428799c8084d7c1e3f8607fcc0dc52f3260eb4f051a3c0f7a1a7782a8e14948ab2ef185720056385f20d2bf8b76fb877c98b184b8de52b94772034490eb6bc2d60d03362808ac5127b38e061f8dd97e89c29ba07c401eabd1b1918812152e8f5f6c2c7f8d560022928cfa87692b9855f473535f6978d25bc4635bd4ae54a1fd1e1eae07af7a92ec76035446dec62c79cf240d16bfefe9964af911b5364a9601534ac$86e70185878de79a34c33b5350cb205280ff1215de8e6c8503499f6feb9a29b2803ae7a91fd6dd4de2d459061dc9f591f6d67dac7af9e00c28330cda5572201a83eabbda36ed5a8b01becdb9f360750a8956d009a9a0a279f20c88212398c875d804932b717fd3d1a5222868b224cb349623f8ebf11f22d2d33b5d2ad2d25267f07e527ff1821af0961abe47ff8dc233cc50ea55d44a92ee9f62bb405fd889315861b62103f68530cb110346075692fe81bc6dac63dd93c464a4441b32b6d87a32cbaba221ef87e4daf07967c7cbcbb9615969d5203c8c924a77beff6791f9df861ba1a754ffc04355206919b721c2cb2157eef09bc774d0eea973c25ff75e784850de49fb0ef12ac4ec955c1b8b9cc3b80183a546e1fd7d4249d5f6a8831095101f653edfb80ef1f4018bd4785ef0c86dc286b6c408bed8d9bc9d624460062277dc5c5fe427935bff0665bc7e932604a7ea0cfcb73ab3d2d65c61d73eb743611ae7f73acea4548345eeb5a64c3cb6977298d9b90547059716f120174d1233505b76bfa6894185ca10d73de7a2832a5b7b2cce536f6b39b19ab840b4e657f14d2dfd1460746ef9555a205e10900496c7537f3558418b6975f25749f0de32a0dc49f5f4ddaf8ccbdd4f85afde82ef4dac87ed034331689d828aa599632ccd71542170696727046e149324d04035c557935e2d8dc6afbdda43d70e466bde82984f','janak3.1415et@gmail.com'),(3,'LightninTh5426','pbkdf2$10000$33645244fe56ce52b68cf40d8c5755bf952357652b7087e83619889250a3deca6c7f119d169fbf67d6501b699ae64b3fd933f3c8f62242ecb5c8a71505e51c462afd1f0237aa09345139635d87625ae57d8152e7858fe0796318afa9ab188db5cb4d41d0f6dea9517328487cda45718934fc56300ed4f72292102d3ce2028c99$046a8cc16f5c3863700d40d47fc25ab9997aaa21ff2ed5f4f8dd3101d4354329c8d8ee23f4cf6ba51891898d77677393be0587faf5eab5aadf39e6206d4c86fe33a4a89eeafbd3a5ff481a650048167ba28d13ce1c62d2bc4fd76cf3e6dc14de4af0024834956ab4b2128c361a31938e3f8cacea9daa7be69de0475a55761ebe53049d0dacffa4abc500535081b5c7cac01ef0252fa06791020c2d343b5f6020416a85e07e43463ef85c055295e5a3f3fcb7a7b3458feb83965054e4df25929ae461c67976e516c26078617d8cccb9bb4f9f345a9a06d76bc55b9a34df818d599b0c9ad123fe123339ed3380e7bc808e01ff4269213a7fb62b24cf56c85f2aa149396d824ba7ca9b78eeed512b532c109a349622ec4a34f76561b263489b6a6633cfbc5cf424119d14f3df49a5b3b7c9ef9dfaf5ba8dee9770a78f9285bfb4eb28e559447ca27b2a7e49ab13a45e45eb8fd4412feb8110872b5e19c8b0b22473f78af2643f7cc626e82f73da11563574ce9ddfbf98910b349c1c08730e4c85460e8feb56f4540c6b04e6d43bb1a84e2a780f6f05f5148aee67267c64d3509448b7bfa4b113e62f6dcb833144676550caeb0d2d0cd05963ec5c0929e4b05f5d85230ac294e29c2b054e3eecd5892e4ea142d16e2e96a120bb3163e059f5e8456a7cba0f35d07811e636c9fcc0c9a5ac8cde9b31fd1b45e20d4266f3a9a08a6e23','janak.shah3.1415@gmail.com'),(5,'raunak','pbkdf2$10000$0e36c798d1eb6bde8adda0e3abde19b719e50ae12a2a23bc7af850a42798fbab1e1c38866d7af47b6baa811375c28de20ddba4da92264e43a1e1712de5323fd98b20c5cc83b7410df08148511cc1700ac5e5a00809de374280b0987ce546d1276b4fd57a908b1733265fb7393df5e7e70e8e53b4ba7440eb0074c51026a3cb8e$70402de3b2615e7c220a9fa2ed9cd8b2cc3598c169274c172870a8e70cdc784e351cbef354b7c56a0760c8e9d946909f4f2a763c4de30bec12d5611806085fb5d4b25fac98a3a326738dcf54d429e1751f2b7d2d4b89d1922ae7b5a938dc42915a5fb71f020897b89946ee11d37cb6272d96bbd2a9e55f99233bd188cd6a53c3cd525cade35a2788d93e6f9f556d17faee72dcbd0030130cffefd5e832c7ba135edb3b91941d974ef2bbba9bd8caf65d8fb5d09c6922bcaced4f6eccb5c5af04caf6df3f4cbfecccdb62714b59d5194d676092761dc6acdedf840b6ed3285bcaed94c4fdcceb9cf10a8c9ef21c9b61f2c687994cff2430cb15ee0bdc2ddf25ab58aa9a475ad1b4097bae2a1e629ea07eae57a5bbba95db0ba2c00b8e9e883343b9f6eedcf57a850a5ccdc696a3a9b14bbc1f0de0bbfbf6861809d50381521b012200321f9699ab7474e3f6363dbe630c3f321279b7594cbc4e5d822142a776ab4c01e572f8fcc5cb01101086ad9bca3f3a9213d51ae9a759bf776ff458207483e29e1f0ff6a37337c065e47a9bcb8784910a85d94670a73d6d79d3b2e94602d74ff3a4b3d45e193ac695f3ccc2f5af919279764bdddd60b300258567e7c455bdb2628a0beb0d9c7099d365ebbfe597aa57871a2df74817fcf45791ca5b2ab78a9c800f0330c28105774a7495b46f6053773833f5b34c8b1368375244e864111d','foleys.raunak@gmail.com'),(6,'epicuser','pbkdf2$10000$38866d5ca3f5c19e7190445e9d00629bcfe1e709e08af33c2e23887cc4dd1039760a99a2529c89f6b9a26c7df0b7dcd66b4e5a6d2374c5b358a1bbb700b199bb52e1f3b61f26971e3c44cdbb3c17d292cbe8f1a9a171d7588e0a92dbf260f479d24c857d2de1a40b7a98f1e440b722c41fa9b4e6882f73ceb474c0a679440805$59a3f5b39a6879adced91eaf2656f18db82c1f2386d7759a846aa3709bc5ea4ab21bc277c234fb915f51d72381be3443ea9530180e1912c4f414d0b4e1dc4afb461435cf6120bc4db4cac0707adc144fed02b65fc3160ef84d1a2da6d0217ae6a776aa928a902057bd55018763528a58b3c76d14361a6fdcedf99de2ccf5339482519040aa4573b90b8f4cf4fa45bacb63e3bae343c9e8b863319fa8e287c232277d31696efbf241536e6e8389e24c7bbbb469baf124bf529c7a62762948a6dae29c089521fbdbc22a090a9f76c283034b1b66a3ba701e666cba4f333e17788480264470d56760560c3a3e5e7c0c3d205171c246bb9f7e3ba0278b8309c06b3f25b20456c34772d0c577f879d7c8f79680f0d07103091885cb4d22b36fbcda48b8dc1fde53ebaab2058eebbfc3c42604662f2850e5a9c3467979a2aad08198da19af6f178c2505c1464f341fb1e51ce352ccef69e52f1bc193241230c55e37ffd190357e3435acdfd8f6d20ff205bf426d1b105aad28e4427a0ac0be58298c536f44ecf9e6bd97ace886e7d0b2024cab14938b589d7ed083bcc8dbb0f2f782450babc52ea412973c0373b947a0251661f6a139b5b83ceb6101a4ea3ecb6356c7108e27bb4eca9a3f7303da211487c36eb7832c3bdc24628dd798f48eee4a10e4989de846803472b66fd01de41b4e888c29581d76bc8da9e1da0afa3a556ae301','epic@gmail.com'),(7,'rekhaseas','pbkdf2$10000$68a9edcadd205af28b01c62da49a0f6087f9e8747b6ae755a2d6642383c2164618a06e719a8ab1b3d161f7da8dd42f27ca35c0d992fdcaa93eff59545808ef99354ab1df29f3a7d2d1317b2a3be614d42eeccc85ce4022c6adb67db324566e76e02396c4bd63f91b0642f13a743492d1ae6e9dfbe50d7e1741d3aab4fe4f61ae$c185efa09b5d47933cc33f14624a7e1f39da56555f1bec9cf19d99c9a37a98902195f2768483141467000fb5fd89fb8dea0c1d592edbaa307f7b9dc9db8cead1fa1f6ad95587e49c3bf482ae0f32a3456baaad46a0ba77ad166cbf97475224bcc7e2d4595a707e6c017c7cc37948387efdcf6583c8544a7ea7feaceface95d00b8e1588854fdc97313e2aa71027a6965e83163c31a1ef674766835509ff471300f3ee5e44f3e019dd46c37ed9f7c72dfe474fc675ce75efb87fe5fbc2713f5de49ed337b876c53a2215f55d84d279b5a77d2e9dc1b7196cad9d4497c14dfd32a15cb661ff73a2655551e905e6c66e5aa281eaaee8728448869b15eed3720cab854224979fc26cc03627a16eb27e1c298391e5a71c4e2eccf49ae73ff3ea5cbfa862862de1601520971fdc2c2a7aba3d20f1bbbd776db7b949fc6c6991d60e7cbeec2e065934acac4a26a2653c9ade90cbab9d4ff30f126c794ddec1670a750e201b0b57c1b6eb95b3f86de6429ceac9f1c3b2597e471ea1147cff58f69fd6563e62c498a6ebeed514216cb2317e620015597fb3d849bfd19617a1f66492395913b86c709a2adeb37af1501234ccf0f5c2ae30a7393d6a5d712e1ccbded0b141d3ca6f40aa08adbeb141c5c0ca2b43845ea06f953a56ba49e731688f496b2573a0a1540839f90056ecb10f424bb6799e2325f96212bab6980e76b9a2eede16d09','rekhaseas@gmail.com'),(8,'bhsea19','pbkdf2$10000$ecb0751bf9b1aefe27595510529d327d1fc8881d80c656ef38af1d0cd4669a13e1639598c75f76f160b52473864be82fb0efc9c5d9f92a67e153f5282d06a5ed895c95ae2347eab99e0091ebff7b52719b6022f3ed14358ced9aa13d65b7453e5bf245c861b24d4b06958b46c8c17e7a1041210332fe330a3900e5b4c7d6c894$5a0b6d2058f29cd8b71395f0d3a3d389de06dfbaf1fafeeff929d7f422fde9de2a51fe474b7f8f1f59b1b06d8f757e448080143cce19651a87e1992e7d478133f26739775606a0507d3cc5923c3b5c9b8b66c84fe967964c7ce26c1f2cf9eb23e9b7e25b1a15694b5825b933f74b376cae34615db9893011a343adb3364278d55a6cae33edf4a2d30eac0a036c1991eff0f393f73b9750c0040970223354a8b3a83b2ce32d30175c4564549f0f221a9af53e93c8d2c480b0dee341a8d962bfdbd638450f5b267d111d82c36669821903ea396a91d9e977ea7db684a7206e34f27272a36098626497aeeaa8fb0d3f4660e77172c239bb16ce100c4d52cbdff38b4e3cc6bca2f9b56f3491e3388f6f8c8d5264e4d2bcbf9d73b3dd04e71ecf95dd205acc0011403b43957eabf68905974a13e6095d5d76821b41fb6949ce07885e3f7db288fc76b9873d5d54e4766b4d79253128177cb8a97b9fca24eac7c419a99fbf6f01cf729f6d462750c9d582c594ffc6d980c49184274a0391e56a165a31e6515d5079b517a0bdbdcb73bea8dbc17e4ae761cece4b9fcedc3bcb5d9128c782027f7a24c1b3d85bf8ed2e2cfb66511f95a286f15611ce73a8620a3cc460cacd2e5a04417662e1ff3975f6c69836dcfb0e613306e7e3225b703ec8298cd25df1f64f85621f4b4bcf505bd094922343af137104ea48713a501731438a50d706','bhsea19@gmail.com');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `blog_app`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `blog_app` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `blog_app`;

--
-- Table structure for table `progcomments`
--

DROP TABLE IF EXISTS `progcomments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `progcomments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `programs_tag` varchar(30) NOT NULL,
  `user_username` varchar(30) NOT NULL,
  `comment` varchar(600) NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_username` (`user_username`),
  KEY `programs_tag` (`programs_tag`),
  CONSTRAINT `progcomments_ibfk_3` FOREIGN KEY (`user_username`) REFERENCES `user` (`username`) ON DELETE CASCADE,
  CONSTRAINT `progcomments_ibfk_4` FOREIGN KEY (`programs_tag`) REFERENCES `programs` (`tag`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `progcomments`
--

LOCK TABLES `progcomments` WRITE;
/*!40000 ALTER TABLE `progcomments` DISABLE KEYS */;
/*!40000 ALTER TABLE `progcomments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs`
--

DROP TABLE IF EXISTS `programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(30) NOT NULL,
  `heading` varchar(40) NOT NULL,
  `content` text,
  `link` text NOT NULL,
  `type` text NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `heading` (`heading`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
INSERT INTO `programs` VALUES (6,'Program_one','GCD Calculator','This program calculates the GCD of any 2 numbers','GCD-Calculator.html','Math','2017-12-08 14:35:48'),(7,'Program_two','LCM Calculator','This program calculates the LCM of any 2 numbers','LCM-Calculator.html','Math','2017-12-08 14:35:48');
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
