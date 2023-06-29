-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2023 at 07:11 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dierenvriend`
--

-- --------------------------------------------------------

--
-- Table structure for table `dier`
--

CREATE TABLE `dier` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230629125852', '2023-06-29 14:59:00', 47),
('DoctrineMigrations\\Version20230629125943', '2023-06-29 14:59:50', 33),
('DoctrineMigrations\\Version20230629130116', '2023-06-29 15:01:22', 37),
('DoctrineMigrations\\Version20230629165836', '2023-06-29 18:58:44', 109),
('DoctrineMigrations\\Version20230629171053', '2023-06-29 19:11:01', 106);

-- --------------------------------------------------------

--
-- Table structure for table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
  `fname` varchar(255) NOT NULL,
  `part` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `fname`, `part`, `password`) VALUES
(1, 'pleun@hotmail.com', '[\"ROLE_ADMIN\"]', 'Pleun', 'Pleundieren', '$2y$13$7n.X5TMN7Yh.xcewBAUcm.x0NKOF07LzpiSch8lrzMKA1GZKi7b4K\r\n'),
(2, 'harun@hotmail.com', '[\"ROLE_ADMIN\"]', 'Harun', 'Het deel van harun', '$2y$13$aNffrqYPnqJUvrx8CXvRReHMCGbBW2trCkBy9klHHM4X6kFMXMj8u\r\n'),
(3, 'sanne@hotmail.com', '[\"ROLE_ADMIN\"]', 'sanne', 'Sannetje', '$2y$13$bNhINjN70SQsdzsENrUM2.7m8EUsiMPdRkSdRPGrdNNSnJVNAII5K\r\n'),
(4, 'alex@hotmail.com', '[\"ROLE_MEMBER\"]', 'alex', NULL, '$2y$13$n8xnbqIfywQHzMerKc4gGuMbNtyr23cx/a9U.c7yc7Wz3CTxv2wOO\r\n\r\n');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dier`
--
ALTER TABLE `dier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7487C015A76ED395` (`user_id`);

--
-- Indexes for table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dier`
--
ALTER TABLE `dier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dier`
--
ALTER TABLE `dier`
  ADD CONSTRAINT `FK_7487C015A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
