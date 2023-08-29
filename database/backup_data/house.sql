-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 12, 2023 at 12:05 PM
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
-- Database: `iot_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `house`
--

CREATE TABLE `house` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci PACK_KEYS=1;

--
-- Dumping data for table `house`
--

INSERT INTO `house` (`id`, `user_id`, `name`, `address`, `created_at`, `updated_at`) VALUES
(1, 2, 'Biệt thự ngọc trai', 'Hậu Lộc, Thanh Hóa', '2023-03-04 16:42:31', '2023-03-04 16:42:31'),
(2, 2, 'Biệt thự hoa hồng', 'Vin home Ocean Park', '2023-03-04 18:33:14', '2023-03-04 18:33:14'),
(3, 2, 'Biệt thự Guldam', 'Nghi Xuân, Hà Tĩnh', '2023-03-04 18:33:21', '2023-03-04 18:33:21'),
(4, 2, 'Lâu đài tình ái', 'Vin home Ocean Park', '2023-03-04 18:33:24', '2023-03-04 18:33:24'),
(5, 2, 'Can ho so 6', 'Vin home Ocean Park', '2023-03-04 18:33:49', '2023-03-04 18:33:49'),
(6, 2, 'Can ho so 7', 'Vin home Ocean Park', '2023-03-04 18:33:52', '2023-03-04 18:33:52'),
(7, 1, 'Can ho so 8', 'Vin home Ocean Park', '2023-03-04 18:40:30', '2023-03-04 18:40:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `house`
--
ALTER TABLE `house`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
